Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E56C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CC3610F100;
	Wed, 15 Jul 2026 18:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HO9bQTDi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C54D10F100
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:13:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AA7DA61838;
 Wed, 15 Jul 2026 18:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7851F000E9;
 Wed, 15 Jul 2026 18:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784139228;
 bh=wJfa+24yldggI+CnJjQ5wXXs1y6dUkKklx4PF1287Sk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HO9bQTDi09+GSacLW5lcet8AFI3lxfKD9yAvhPeDulGRaKlcxzS0KG36kSaWWGjrW
 qcrQCvQZ/54bd+spJvr4eqLwEgEKrbDOnPnE7Se4bfKIUnwwMAzpF0BtyNISc6GMIV
 ujFJWBMjT+wLugg/Djo3U2xfyPh+EZpZ0GHlXpmy9SQMXqwMLb/MZbLEvjtYUF0Bjx
 zt+iw/KkmqV8s8oUrN+J03eY7OEf5gozG4rB4alzqNesut8/qvZ/Go5+/Epx2xolQY
 WXo/MC89AfCRYo3pWRPWosYyY4u3EaaqUybzS6KBPbFQcjEaALNjhjVaVvtZ2BvLvv
 FnXMkSvG0J8cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/9] vfio/pci: Convert BAR mmap() to use a DMABUF
To: "Matt Evans" <matt@ozlabs.org>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 kvm@vger.kernel.org
In-Reply-To: <20260715174737.15287-6-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-6-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:13:47 +0000
Message-Id: <20260715181348.1F7851F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Math bug in vfio_pci_dma_buf_find_pfn() breaks direct DMABUF mma=
p() by conflating VFIO and DMABUF VMA coordinate spaces.
--

--- Patch [5]: [PATCH v5 5/9] vfio/pci: Convert BAR mmap() to use a DMABUF =
---
commit 9a789f4b1551b3573dc4e2e6ba3af07e0aa65ce5
Author: Matt Evans <matt@ozlabs.org>
vfio/pci: Convert BAR mmap() to use a DMABUF

This commit converts the VFIO device fd fops->mmap to create a DMABUF
representing the BAR mapping. The VMA fault handler is updated to look
up PFNs from the corresponding DMABUF instead. This is intended to support
future code for direct mmap()ing of BAR DMABUFs.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 3f11a9624b9c0..adce779c722c7 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -1778,23 +1766,42 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct=
 vm_fault *vmf,
>  					   unsigned int order)
>  {
[ ... ]
> +	scoped_guard(rwsem_read, &vdev->memory_lock) {
> +		if (!priv->revoked) {
> +			int pres =3D vfio_pci_dma_buf_find_pfn(priv, vma,
> +							     vmf->address,
> +							     order, &pfn);

[Severity: Medium]
Will this actually support direct DMABUF mmap()s as the commit message
suggests?

Looking at the math inside vfio_pci_dma_buf_find_pfn():

drivers/vfio/pci/vfio_pci_dmabuf.c:vfio_pci_dma_buf_find_pfn() {
    ...
	unsigned long vma_off =3D ((vma->vm_pgoff - priv->vma_pgoff_adjust) <<
				 PAGE_SHIFT) & VFIO_PCI_OFFSET_MASK;
    ...
}

If a direct DMABUF mmap has a vma->vm_pgoff of 0, won't 0 - priv->vma_pgoff=
_adjust
underflow and cause the bounds checks to fail?

Additionally, inserting the VFIO VMA into the DMABUF's i_mmap tree with a
shifted offset seems to conflate coordinate spaces. Could this break future
targeted unmap_mapping_range() calls?

> +
> +			if (pres =3D=3D 0)
> +				ret =3D vfio_pci_vmf_insert_pfn(vdev, vmf,
> +							      pfn, order);
> +			else if (pres =3D=3D -EAGAIN)
> +				ret =3D VM_FAULT_FALLBACK;
> +		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715174737.1528=
7-1-matt@ozlabs.org?part=3D5

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD11C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB22710EF76;
	Wed, 15 Jul 2026 18:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BH+X5nRu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A67EA10EFAE
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:11:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7054041AD5;
 Wed, 15 Jul 2026 18:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E0A1F000E9;
 Wed, 15 Jul 2026 18:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784139091;
 bh=EGsF4EMz61y/+4iKZ3CT+36sW1t5V50BMi7cv5elImY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BH+X5nRulkN7gorVES0oOKdu9Hn3quKT9nlRgT1sHQIFlRrXieWXfN/6bPbdyLw7S
 W8o2QfiVqMCh3fTVeCP+gTU6x5Dv+mkoLLiqkV/pYgY+mXU57E9cSohVUVIkdIdFwp
 qkSv8Ixyt81hjq5wbxLQ9ITfQdlKoqF+rSE3Q2iYzenVQsCbWwwuN/RqrccOJ3ECQc
 G3XyE4+BLww1rT0SXwwr8gsCVYifeGDbJpf7965ecmhIkQ8b3N/HazJvf0Ue/7n+3X
 byAtfG2IOpiOEXU601AqxCtQXbTQH2tnWIpLvHICvWvX66mIvDl7+o+jy70EUVnBU0
 2odVpjYx/tHJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 9/9] vfio/pci: Permanently revoke a DMABUF on request
To: "Matt Evans" <matt@ozlabs.org>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260715174737.15287-10-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-10-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:11:30 +0000
Message-Id: <20260715181131.12E0A1F000E9@smtp.kernel.org>
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
- [Low] The function `vfio_pci_core_feature_dma_buf_revoke` mixes `goto`-ba=
sed error handling with scope-based cleanup helpers (`scoped_guard`).
--

--- Patch [9]: [PATCH v5 9/9] vfio/pci: Permanently revoke a DMABUF on requ=
est ---
commit 668793566cfbdb5cee2b0a69188ebbada38dd4d5
Author: Matt Evans <matt@ozlabs.org>

vfio/pci: Permanently revoke a DMABUF on request

This commit expands the VFIO DMABUF revocation state to allow permanent
revocation via a new VFIO_DEVICE_FEATURE_DMA_BUF_REVOKE feature request.
It refactors the revocation logic into a common function used by both
the move path and the new feature request path.

> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index ccfe861f88b66..36bf07530840d 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
[ ... ]
> @@ -671,9 +696,72 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_d=
evice *vdev)
[ ... ]
> +	if (dmabuf->ops !=3D &vfio_pci_dmabuf_ops ||
> +	    READ_ONCE(priv->vdev) !=3D vdev) {
> +		ret =3D -ENODEV;
> +		goto out_put_buf;
> +	}
> +
> +	scoped_guard(rwsem_write, &vdev->memory_lock) {

[Severity: Low]
Is it intentional to mix goto-based error handling and scope-based cleanup
helpers in the same function?

The subsystem guidelines for cleanup helpers recommend against mixing goto
labels with scoped_guard in the same routine, to avoid confusing ownership
semantics and potential resource leaks during future refactoring.

Could the dma_buf_put cleanup at the out_put_buf label be converted to use a
scope-based helper, or could the scoped_guard be replaced with traditional
locking, to keep the error handling style consistent throughout
vfio_pci_core_feature_dma_buf_revoke?

> +		if (priv->status =3D=3D VFIO_PCI_DMABUF_PERM_REVOKED) {
> +			ret =3D -EBADFD;
> +		} else {
> +			vfio_pci_dma_buf_set_status(priv,
> +						    VFIO_PCI_DMABUF_PERM_REVOKED);
> +			ret =3D 0;
> +		}
> +	}
> +
> +out_put_buf:
> +	dma_buf_put(dmabuf);
> +
> +	return ret;
> +}
> +#endif /* CONFIG_VFIO_PCI_DMABUF */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715174737.1528=
7-1-matt@ozlabs.org?part=3D9

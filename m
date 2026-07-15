Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871A5C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 18:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D828910EF83;
	Wed, 15 Jul 2026 18:12:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jysgfjE9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 588AA10EF83
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 18:12:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 410844383E;
 Wed, 15 Jul 2026 18:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AD81F000E9;
 Wed, 15 Jul 2026 18:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784139149;
 bh=AyLvbPnD6vvkc0DU5Cso7RJBdGRUiEC2i1WT040e7oQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jysgfjE95vS0O7Ol1RAlJ8yUFtMkNNXnHkgEoqyCVuSAHuJR8pMRGqDrzuuivENs4
 64RyU+fU8er+43aowBWde5IyorWe82qUHLpn95lyhmqyg82/8z6Hs9XxLAfcVxtUY9
 LZ6keT28/Wu3gFFj59YkRSQvwlxrwhyjQuMdxFMVIzw6JAYkWZknAYvm8fHss/HSHl
 T3/3BMFpaRzFOyztBZ0mfHth4U8rCMuOUdx3L4J6MnjmM51vXe2HZbFU7ebkAtwjnN
 1wFCxGbkxwnsrkb4Y7tGye+ykkqz/7eATnkfxZN0dCFoEfshSpPQeXx2/5u55pRkSm
 iD3tS52X6qvww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/9] vfio/pci: Add a helper to create a DMABUF for a
 BAR-map VMA
To: "Matt Evans" <matt@ozlabs.org>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kvm@vger.kernel.org
In-Reply-To: <20260715174737.15287-5-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-5-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:12:28 +0000
Message-Id: <20260715181228.D1AD81F000E9@smtp.kernel.org>
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
- [Medium] Missing bounds check on `res_index` before calling `pcim_p2pdma_=
provider()` leads to out-of-bounds array access.
--

--- Patch [4]: [PATCH v5 4/9] vfio/pci: Add a helper to create a DMABUF for=
 a BAR-map VMA ---
commit 733300e7a6e7bd6d5e79581e31e2eac09e4e5c22
Author: Matt Evans <matt@ozlabs.org>

vfio/pci: Add a helper to create a DMABUF for a BAR-map VMA

This commit adds a helper function, vfio_pci_core_mmap_prep_dmabuf(), to
create a single-range DMABUF for mapping a PCI BAR. It also refactors the
existing vfio_pci_core_feature_dma_buf() to extract common export logic.

> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index 7c047400dfd16..74c02794bfe28 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c

[ ... ]

> @@ -460,6 +473,75 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_co=
re_device *vdev, u32 flags,
>  	return ret;
>  }
> =20
> +int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
> +				   struct vm_area_struct *vma,
> +				   u64 phys_start, u64 req_len,
> +				   unsigned int res_index)
> +{
> +	struct vfio_pci_dma_buf *priv;

[ ... ]

> +	priv->vdev =3D vdev;
> +	priv->size =3D req_len;
> +	priv->nr_ranges =3D 1;
> +	priv->vma_pgoff_adjust =3D vma_pgoff;
> +	priv->provider =3D pcim_p2pdma_provider(vdev->pdev, res_index);

[Severity: Medium]
Is a bounds check needed on res_index before calling pcim_p2pdma_provider()?

If a caller passes an index like VFIO_PCI_ROM_REGION_INDEX (6) or higher,=20
pcim_p2pdma_provider() will index the mem[PCI_STD_NUM_BARS] array out of
bounds, returning an invalid pointer.=20

This invalid pointer could later be dereferenced by pci_p2pdma_map_type()=20
in dma_buf_phys_vec_to_sgt(), which might lead to memory corruption or cras=
hes.

> +	if (!priv->provider) {
> +		ret =3D -EINVAL;
> +		goto err_free_phys;
> +	}
> +
> +	priv->phys_vec[0].paddr =3D phys_start + ((u64)vma_pgoff << PAGE_SHIFT);
> +	priv->phys_vec[0].len =3D priv->size;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715174737.1528=
7-1-matt@ozlabs.org?part=3D4

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E49CDB466
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CC0710E832;
	Mon, 22 Jun 2026 19:06:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MOS1cY6T";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83A1910E832
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 19:06:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 46E8A4013C;
 Mon, 22 Jun 2026 19:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DA01F000E9;
 Mon, 22 Jun 2026 19:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782155180;
 bh=9oxSszJzvOcRTa/rj5gx5Lq8ASBBobjy7YnCgU2vPdo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MOS1cY6T1vRZIGCz6OiQTq/oaArGrOSeh4G3IROYm2Hz2APlgepSFV40UoTSCw7hi
 qy5aAMg6Ds6CzbGaxPX03LG5P09H+3z4+jJruyLC36BwwqXcdxms7V9uunfj6UwmPc
 2Q2tsHRUWyNhVFjnaKlm4mxyHwTu9Re4liMbSSvkZcdiZ4N1BQJVUk7cHZBg5RTWFG
 c4mYcCbA22XXYdH7GNO24aUFk/7Kw96tTFx234raARcy9nxsqku7skvN3BG42UtHau
 oE6godkPHGwN4H4lK4nzze2JryIPFlFL4Q5IkyqELrJaOMrzxAVV+joTITifJ6g501
 PPTyLCEYK3XnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 3/4] vfio/pci: implement get_pci_tph and DMA_BUF_TPH
 feature
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org
In-Reply-To: <20260622184211.2229399-4-zhipingz@meta.com>
References: <20260622184211.2229399-1-zhipingz@meta.com>
 <20260622184211.2229399-4-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 19:06:19 +0000
Message-Id: <20260622190620.04DA01F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unconditional validation of the flag-gated `ph` syscall parameter =
can falsely reject valid requests to clear TPH metadata.
- [Medium] Packing new `tph_*` bitfields into the same byte as the existing=
 `revoked` bitfield introduces a data race.
- [Medium] Lockless plain read of `priv->vdev` can race with a concurrent w=
rite of `NULL` during device cleanup.
--

commit d529be6632b034e32bc07cc3b900f28862d27327
Author: Zhiping Zhang <zhipingz@meta.com>

vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature

This commit implements dma-buf get_pci_tph for vfio-pci exported dma-bufs.
It adds VFIO_DEVICE_FEATURE_DMA_BUF_TPH to allow userspace to publish TPH
metadata for a VFIO-owned device.

> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index c16f460c01d68..d6f5dd3210009 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -19,7 +20,14 @@ struct vfio_pci_dma_buf {
>  	u32 nr_ranges;
>  	struct kref kref;
>  	struct completion comp;
> -	u8 revoked : 1;
> +
> +	/* Protected by dmabuf->resv. */
> +	u16 tph_st_ext;
> +	u8 tph_st;
> +	u8 revoked:1;
> +	u8 tph_st_valid:1;
> +	u8 tph_st_ext_valid:1;
> +	u8 tph_ph:2;
>  };

[Severity: Medium]
Does this bitfield packing introduce a data race?

While the new tph_* fields are safely updated under the dmabuf->resv lock
in vfio_pci_core_feature_dma_buf_tph(), existing code in
vfio_pci_dma_buf_move() reads the revoked bit without holding the
dmabuf->resv lock:

vfio_pci_dma_buf_move()
    if (priv->revoked !=3D revoked) {
        dma_resv_lock(priv->dmabuf->resv, NULL);
        ...

Because they share the same underlying byte, the locked read-modify-write of
the tph_* fields will concurrently access the byte while the lockless read =
of
the revoked flag occurs. This can violate the C memory model and trigger
KCSAN warnings. Could the revoked flag be declared as a standalone bool to
avoid sharing the byte with the dynamic tph_* bitfields?

> [ ... ]
> @@ -333,6 +362,72 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_co=
re_device *vdev, u32 flags,
> [ ... ]
> +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
> +				      u32 flags,
> +				      struct vfio_device_feature_dma_buf_tph __user *arg,
> +				      size_t argsz)
> +{
> [ ... ]
> +	if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> +		return -EFAULT;
> +
> +	if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_EXT))
> +		return -EINVAL;
> +
> +	if (set_tph.ph & ~0x3)
> +		return -EINVAL;

[Severity: High]
Can this unconditional check falsely reject valid requests to clear TPH
metadata?

When userspace sets the flags to 0 to clear or invalidate published TPH
metadata, the ph parameter is unused and might contain uninitialized stack
garbage. Since syscall parameters that are only meaningful when certain fla=
gs
are set should not be validated when those flags are absent, could this
cause legitimate clearing requests to fail with -EINVAL?

> [ ... ]
> +	dmabuf =3D dma_buf_get(set_tph.dmabuf_fd);
> +	if (IS_ERR(dmabuf))
> +		return PTR_ERR(dmabuf);
> +
> +	if (dmabuf->ops !=3D &vfio_pci_dmabuf_ops) {
> +		ret =3D -EINVAL;
> +		goto out_put;
> +	}
> +
> +	priv =3D dmabuf->priv;
> +	if (priv->vdev !=3D vdev) {
> +		ret =3D -EINVAL;
> +		goto out_put;
> +	}

[Severity: Medium]
Could this plain read of priv->vdev race with a concurrent device cleanup?

Here, priv->vdev is accessed to check ownership without holding any locks
that would protect against cleanup. Concurrently, if the original exporting
device is being closed, vfio_pci_dma_buf_cleanup() sets priv->vdev =3D NULL
locklessly relative to this ioctl execution context:

vfio_pci_dma_buf_cleanup()
    list_del_init(&priv->dmabufs_elm);
    priv->vdev =3D NULL;
    vfio_device_put_registration(&vdev->vdev);

This plain read racing with a plain write could cause undefined behavior
under the kernel memory model and trigger KCSAN warnings. Should this be
annotated with READ_ONCE() and WRITE_ONCE() to prevent compiler reordering
or load tearing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622184211.2229=
399-1-zhipingz@meta.com?part=3D3

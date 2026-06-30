Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4053EC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 23:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A7510E2C0;
	Tue, 30 Jun 2026 23:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BasXIBhI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FAF310E2C0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 23:08:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 138916001D;
 Tue, 30 Jun 2026 23:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4C51F000E9;
 Tue, 30 Jun 2026 23:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782860921;
 bh=E9FuaoOJzCGZBbZKMbcQWsELlnnFjqrAYZ4zRijrd48=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BasXIBhIznEyleLufZSQKEe3/m/9U0UssRw/bMzftb/bLoO2RVnMARF5ley+dUonL
 x2AtfdFjz/FWrjqAdxvS7jHByBguJDONIt+GuoDhB5GnAuDZPu/KznLxk5inBFUVFK
 +k6A4kGan94PZpUDjthUOtUHjtCltbbG1SCZGdq2H2u3ZzV8GVsBdacWngsBLTsnOS
 YlBXg0fRDp0VSbupSX4PP5/QnNfBK3xySF8rTTpRQfvTwZXbnVX0X8bqkYtLvSLQvd
 JgRzVHRHnTWuKlFEoxXe3ud74f+7HmnnRCjid9lhWg6d8ZgUf0JhaBbKUoDMr49edZ
 O7OF2yGZgrsxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/4] vfio/pci: implement get_pci_tph and DMA_BUF_TPH
 feature
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260630224328.3218796-4-zhipingz@meta.com>
References: <20260630224328.3218796-1-zhipingz@meta.com>
 <20260630224328.3218796-4-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 23:08:41 +0000
Message-Id: <20260630230841.7E4C51F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Lockless plain load of `priv->vdev` races with concurrent modificat=
ion in cleanup path.
- [Low] Missing `WRITE_ONCE()` for `priv->revoked` leads to data race with =
`READ_ONCE()`.
--

commit d524eab36e9482385fe1c1a6c6280e667bf56a9c
Author: Zhiping Zhang <zhipingz@meta.com>
Subject: vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature

This commit implements dma-buf get_pci_tph for vfio-pci exported
dma-bufs and adds VFIO_DEVICE_FEATURE_DMA_BUF_TPH. This allows
userspace to publish TPH metadata for a VFIO-owned device.

> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index c16f460c01d68..8de72f9e75024 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -30,7 +38,7 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmab=
uf,
>  	if (!attachment->peer2peer)
>  		return -EOPNOTSUPP;
> =20
> -	if (priv->revoked)
> +	if (READ_ONCE(priv->revoked))

[Severity: Low]
Since this updates the read of priv->revoked to use READ_ONCE(), should the
corresponding writers in vfio_pci_dma_buf_move() also be updated to use
WRITE_ONCE()?

For example, when a concurrent state change like a device reset writes to
this field:

vfio_pci_dma_buf_move() {
        ...
        priv->revoked =3D true;
        ...
}

Will the lack of WRITE_ONCE() here trigger KCSAN data race warnings when
evaluated concurrently by the new READ_ONCE() check?

>  		return -ENODEV;
> =20
>  	if (!dma_buf_attach_revocable(attachment))

[ ... ]

> @@ -333,6 +362,72 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_co=
re_device *vdev, u32 flags,
>  	return ret;
>  }
> =20
> +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
> +				      u32 flags,
> +				      struct vfio_device_feature_dma_buf_tph __user *arg,
> +				      size_t argsz)
> +{

[ ... ]

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

[Severity: Low]
Can this lockless read of priv->vdev race with concurrent modifications in
the cleanup path?

If userspace calls the VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl on device A,
passing a dmabuf_fd belonging to device B, while device B is concurrently
being closed, could this race with vfio_pci_dma_buf_cleanup()?

vfio_pci_dma_buf_cleanup() {
        ...
        priv->vdev =3D NULL;
        ...
}

Will this concurrent plain store trigger KCSAN warnings during the pointer
equality check?

> +		ret =3D -EINVAL;
> +		goto out_put;
> +	}
> +
> +	ret =3D dma_resv_lock_interruptible(dmabuf->resv, NULL);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630224328.3218=
796-1-zhipingz@meta.com?part=3D3

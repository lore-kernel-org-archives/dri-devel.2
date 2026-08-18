Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADD2C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 21:41:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE5B810E09C;
	Tue, 18 Aug 2026 21:40:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NBJfo8KO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9523010E09C
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 21:40:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DA0B2601DE;
 Tue, 18 Aug 2026 21:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2801F000E9;
 Tue, 18 Aug 2026 21:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787089257;
 bh=lFPK7Dwno3U6M9ZL1W2r5NoBKC/KqsRkGLTs3JP30co=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NBJfo8KO5WkCQ6r7ibGlBu0p2kdct3acDx5o1/1qi+08YQJBfraff2GJZ6XlylLSV
 oA2+eEHRYWEl0mmJE48iXHh1VwyVzkQblMF837qwuSYnFFgJD2Lp5MgOpsmdGN1dZ+
 rEjvDVjBpGGcTNHDryu5BNy73pnwQou+7zfPF2PzIT1JhYa71751hwEYk5N4AQDbJZ
 yOKfEOwRPvrkK8hi3smfUgnIimeItJ+aqaTf3v+jDxHyIKVyT7qZum0LbFuI8oedpE
 Rxp1667bLuBvsmyO0pTMUI72P2m/W+A9ELNi9dIrnTamwpe9SZib/Ef+zYlj8Q+RpS
 f2A9FT7neWgng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/12] virtio_pci: support VIRTIO_F_DMB
To: "Alexander Graf" <graf@amazon.com>
Cc: dri-devel@lists.freedesktop.org, nvdimm@lists.linux.dev
In-Reply-To: <20260818211425.91009-12-graf@amazon.com>
References: <20260818211425.91009-1-graf@amazon.com>
 <20260818211425.91009-12-graf@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 21:40:57 +0000
Message-Id: <20260818214057.6E2801F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Out-of-bounds MMIO read in `vp_dmb_mem_type_supported` due to `mde=
v->common_len` exceeding the actual mapped BAR size.
--

--- Patch [11]: [PATCH v2 11/12] virtio_pci: support VIRTIO_F_DMB ---
commit 2b2d786abf770566580dde39b790350db36f5d09
Author: Alexander Graf <graf@amazon.com>

virtio_pci: support VIRTIO_F_DMB

Let a modern virtio-pci device place its virtqueues and the buffers they
reference in a Device Memory Buffer of its own: accept VIRTIO_F_DMB from
vp_transport_features(), and implement the get_dmb_shm_id config op on
top of vp_modern_get_dmb_shm_id(). get_dmb_shm_id reports the shared
memory id of the region that holds the buffer.

Link: https://lore.kernel.org/virtio-comment/20260818060255.6853-1-graf@ama=
zon.com/

> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_p=
ci_modern.c
> index 565d37b630b31..c893e31e51590 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c

[ ... ]

> @@ -364,6 +364,29 @@ static void vp_modern_avq_cleanup(struct virtio_devi=
ce *vdev)
>  	}
>  }
> =20
> +/*
> + * A device reports the memory type of its Device Memory Buffer region in
> + * dmb_mem_type, and the field is valid as soon as the device offers
> + * VIRTIO_F_DMB.  VIRTIO_DMB_MEM_TYPE_COHERENT says that a write by eith=
er side
> + * becomes visible to the other with no cache maintenance by the driver,=
 which
> + * is what plain loads and stores on the region need.  A common configur=
ation
> + * structure too short to hold the field reports no type at all, and rea=
ding it
> + * there would fall outside what vp_modern_probe() mapped.  This is the =
only
> + * place that measures the structure against the field, because the read
> + * happens before vp_check_common_size() runs.
> + */
> +static bool vp_dmb_mem_type_supported(struct virtio_pci_device *vp_dev)
> +{
> +	size_t need =3D offsetofend(struct virtio_pci_modern_common_cfg,
> +				  dmb_mem_type);
> +
> +	if (vp_dev->mdev.common_len < need)
> +		return false;
> +
> +	return vp_modern_get_dmb_mem_type(&vp_dev->mdev) =3D=3D

[Severity: High]
This isn't a bug introduced by this patch, but does this bounds check
rely on an inflated common_len that could allow out-of-bounds MMIO reads?

If a buggy or malicious PCI device sets the capability length to 68 or more,
but places it near the end of the BAR such that the remaining space is only
between 56 (minlen) and 67 bytes, vp_modern_map_capability() sets
mdev->common_len to the un-clamped capability length:

drivers/virtio/virtio_pci_modern_dev.c:vp_modern_map_capability() {
    ...
    if (length > size)
        length =3D size;

    if (len)
        *len =3D length; /* mdev->common_len receives the inflated length */

    if (minlen + offset < minlen ||
        minlen + offset > pci_resource_len(dev, bar)) {
    ...
}

Since pci_iomap_range() will only map up to the physical end of the BAR,
the actual mapped region is shorter than common_len.

Because common_len is inflated, the check (vp_dev->mdev.common_len < need)
passes here, allowing vp_modern_get_dmb_mem_type() to perform a read
which is physically outside the mapped PCI BAR.

Could this unmapped read trigger a PCIe Unsupported Request and Master Abor=
t,
potentially panicking the host system?

> +	       VIRTIO_DMB_MEM_TYPE_COHERENT;
> +}
> +
>  static void vp_transport_features(struct virtio_device *vdev, u64 featur=
es)
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818211425.9100=
9-1-graf@amazon.com?part=3D11

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53610C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 20:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0435D10E5A0;
	Fri, 14 Aug 2026 20:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lE5DmvMl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723C410E5A0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 20:22:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 97E9A60008;
 Fri, 14 Aug 2026 20:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245971F000E9;
 Fri, 14 Aug 2026 20:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786738971;
 bh=bgAJIfuDUi9E5OeZRsxtJ0M18hSLmhIbUyeKTsE5V3A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lE5DmvMlygliktlyj792/k+mXZXAWAmr64VcrshzDM5nRm6c/YWaf0pCveW2D2NHf
 FLy1JN5VKPQFi2t9JhCO3s2w1TLp77ftZn+10JFEGUcYxe450SbWdgJvFvc9rs9DVy
 DHc/EB0tDzqwLUQb628U4+cT6OsjFwc6WGcXJanpPF6KJK/3jL0B5DgjnjmrBQpVnt
 QytV8G1A6q1xOvxSa3Ycacxh6P8FpAx0Oibxc9yMx6LlzGTnNsqj4jU/Sc3AItn0sZ
 fCa2bXmJRAPUtP6degvoTbcNYPuPX7NHjBHDnKvEavB7RxFcpncND+n5dMe4D/gsR1
 f7d4qxAtlfRFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/virtio: sync shmem backing on guest-bound transfers
To: "Benjamin Leggett" <benjamin@edera.io>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-virtgpu-from-host-sync-v1-1-814e3afb5b08@edera.io>
References: <20260814-virtgpu-from-host-sync-v1-1-814e3afb5b08@edera.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 20:22:50 +0000
Message-Id: <20260814202251.245971F000E9@smtp.kernel.org>
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
- [High] Data corruption occurs in `virtio_gpu_transfer_to_host_ioctl` due =
to immediate bounce buffer snapshotting without waiting for in-flight trans=
fers.
--

--- Patch [1]: [PATCH] drm/virtio: sync shmem backing on guest-bound transf=
ers ---
commit 785780bb521416de7cc6cc47fe1be44a03a3d772
Author: Benjamin Leggett <benjamin@edera.io>
Subject: drm/virtio: sync shmem backing on guest-bound transfers

This commit fixes syncing issues for guest-bound transfers by priming the
mapping before queueing and syncing for the CPU on completion. It also adds=
 a
wait before priming to prevent a second transfer from snapshotting while an
earlier one is in flight.

Link: https://lore.kernel.org/dri-devel/20260806231002.27B4D1F000E9@smtp.ke=
rnel.org/

> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/vir=
tio/virtgpu_ioctl.c
> index 3d8e4ccdb7c1f..88320275eadbf 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -261,6 +261,25 @@ static int virtio_gpu_transfer_from_host_ioctl(struc=
t drm_device *dev,
>  	if (ret !=3D 0)
>  		goto err_put_free;
> =20
> +	if (virtio_gpu_is_shmem(bo) && virtio_gpu_use_dma_api(vgdev->vdev)) {
> +		/*
> +		 * The sync on completion restores the whole mapping, so an
> +		 * earlier transfer has to be done before this one snapshots it.
> +		 * Otherwise the snapshot predates anything the CPU wrote once
> +		 * that transfer's fence signalled, and the later sync would
> +		 * discard it. Nothing can add a fence behind our back here,
> +		 * since doing so takes the reservation we already hold.
> +		 */
> +		long wait =3D dma_resv_wait_timeout(objs->objs[0]->resv,
> +						  DMA_RESV_USAGE_WRITE, true,
> +						  MAX_SCHEDULE_TIMEOUT);
> +
> +		if (wait < 0) {
> +			ret =3D wait;
> +			goto err_unlock;
> +		}
> +	}
> +

[Severity: High]
Does virtio_gpu_transfer_to_host_ioctl() need a similar wait added?

If a user concurrently issues a transfer to the host while a transfer from
the host is in flight for the same buffer, could it overwrite the bounce
buffer with stale memory?=20

virtio_gpu_transfer_to_host_ioctl() calls virtio_gpu_cmd_transfer_to_host_3=
d()
without a dma_resv_wait_timeout() check. This triggers a call to
dma_sync_sgtable_for_device(), which copies the entire sgtable and might
erase the device's ongoing writes before the in-flight transfer completes:

virtio_gpu_transfer_to_host_ioctl() ->
  virtio_gpu_cmd_transfer_to_host_3d() {
    ...
    if (virtio_gpu_is_shmem(bo) && use_dma_api)
        dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
                                    bo->base.sgt, DMA_TO_DEVICE);
    ...
  }

>  	fence =3D virtio_gpu_fence_alloc(vgdev, vgdev->fence_drv.context, 0);
>  	if (!fence) {
>  		ret =3D -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-virtgpu-fr=
om-host-sync-v1-1-814e3afb5b08@edera.io?part=3D1

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C6FC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 22:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7482510E049;
	Fri, 14 Aug 2026 22:05:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cfmJHEwh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1227B10E049
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 22:05:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1C45560008;
 Fri, 14 Aug 2026 22:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD0D1F000E9;
 Fri, 14 Aug 2026 22:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786745107;
 bh=XkSngI4VMHlnw9kf5vxYcOgHswgQtrJQ7I7UixfXw2s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cfmJHEwhnJprGqYQvYFU6YY2tCNlVgx7AiB0lzrByaJ7RUSXac6rJYt48tsBTNkt1
 rhdu9FhbmR27p31MEN3nBI5XgGGMRhQ3PhdeuVPQFQINyCuJwQU8GS9NdEEgKMEYjb
 BHB3UckXHCZbqsNRxrsiG8J1/XXwAWdvGJfo0ibgU/pT0PbZlwOo8M3Rf8jvWeK8T5
 cJmrPkCp1Vt7UaWDB6hNkk5vkwdQclv03bw4XU1hfI9HkfeewJa/pjgeW+Fq8xOVIn
 wgdQYoD208t4Cl9xX6+GxEIguTOp2fb8R4JWKI9d4DXhohae+lgSNfy3W97h7Z3PRk
 1Ig3U0RTcmcsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/virtio: sync shmem backing on guest-bound transfers
To: "Benjamin Leggett" <benjamin@edera.io>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-virtgpu-from-host-sync-v3-1-f2538afd7d6e@edera.io>
References: <20260814-virtgpu-from-host-sync-v3-1-f2538afd7d6e@edera.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 22:05:07 +0000
Message-Id: <20260814220507.9DD0D1F000E9@smtp.kernel.org>
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
- [High] Using DMA_RESV_USAGE_WRITE for dma_resv_wait_timeout() during a gu=
est-bound transfer breaks implicit synchronization with concurrent readers.
--

--- Patch [1]: [PATCH v3] drm/virtio: sync shmem backing on guest-bound tra=
nsfers ---
commit 7807a88173cac8b6af42b38366a2631991ee3af0
Author: Benjamin Leggett <benjamin@edera.io>

drm/virtio: sync shmem backing on guest-bound transfers

This commit fixes an issue where guest-bound transfers provide stale
data by adding CPU synchronization for shmem backing. It primes the
mapping before queueing the transfer and tags the buffer to be synced
on completion. It also introduces waits for outstanding fences under
the reservation to prevent overwriting during in-flight transfers.

Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/dri-devel/20260806231002.27B4D1F000E9@smtp.=
kernel.org/

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

[Severity: High]
Does using DMA_RESV_USAGE_WRITE here break implicit synchronization by
bypassing READ fences?

If the wait uses the WRITE enum, the iterator might only wait for KERNEL
and WRITE fences. If an exporter is actively reading the pages and has
set a DMA_RESV_USAGE_READ fence, the host transfer could run concurrently
with the reader.

Could this cause dma_sync_sgtable_for_cpu() to overwrite the GEM object's
pages while they are being read? Should this use DMA_RESV_USAGE_READ
instead to ensure we wait for concurrent readers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-virtgpu-fr=
om-host-sync-v3-1-f2538afd7d6e@edera.io?part=3D1

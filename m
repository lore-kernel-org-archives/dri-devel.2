Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFDECC6B0F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D025E10F50B;
	Tue, 13 Oct 2026 07:28:26 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E88F10F50B
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 07:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:From:Reply-To;
 bh=4KvbUQc+7VOrzZaaCFx3cfetaBM9hLX6fJn4UhjwKEQ=; b=a7h8I84aLDV7VEBCP1rsXtQpZ1
 +xcDQZNnjigZnc8DPbmgkErXTn9AWFPY99DftPqOLBDxtVXUAj4UlqRhq8c7L9+BCAQGMknh5hNm7
 HTIIOwX8+j+iVU+N0zZ2PvdF6DHjH5NwuaJFIowpZhcRyejKxzu3Fq3+zw+4D1vt2l1OA9saH8JM4
 BwA5ZL6/4OtIuEZ0Y4tLZdzSYP1UtmIdtXcFgubsvgn1WARcNfsuGkRV5k95Dfc/Bfxpf0mmDxeHR
 47CnJYEaXySUzIOxYCHRw8WCYReDYeJjPJql6ggd9vuX4LyuB+PLx8sMiNytgQXCdaFo8pqpiPFy3
 M/bEuDzg==;
Received: from 89.141.155.109.dyn.user.ono.com ([89.141.155.109]
 helo=[192.168.0.17]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xGWvm-00GvMR-JG; Tue, 13 Oct 2026 09:28:14 +0200
Message-ID: <ac9b63c893795494d2b2ec128d3974713fdcc70d.camel@igalia.com>
Subject: Re: [PATCH 05/11] drm/vc4: Attach the job fences outside of job_lock
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Maxime Ripard
 <mripard@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Date: Tue, 13 Oct 2026 09:28:04 +0200
In-Reply-To: <20261004-vc4-misc-fixes-v1-5-b763df9e33e1@igalia.com>
References: <20261004-vc4-misc-fixes-v1-0-b763df9e33e1@igalia.com>
 <20261004-vc4-misc-fixes-v1-5-b763df9e33e1@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

El dom, 04-10-2026 a las 12:42 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> vc4_attach_fences() adds the job fence to the reservation of every BO
> the
> job touches, which is a O(bo_count) walk under job_lock. It was there
> because vc4_exec_info could be freed by the job done worker the
> moment the
> lock was dropped.
>=20
> As vc4_exec_info is refcounted now, hand the fences over after the
> unlock.
>=20
> Note that the render done handler dropped the fence as soon as the
> job
> completed, so the walk could find exec->fence already cleared. Leave
> the
> fence to be dropped by the release path. The submit path no longer
> needs
> a reference of its own to publish the fence through the sync object
> either.
>=20
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
> =C2=A0drivers/gpu/drm/vc4/vc4_gem.c | 23 ++++++-----------------
> =C2=A0drivers/gpu/drm/vc4/vc4_irq.c |=C2=A0 5 +----
> =C2=A02 files changed, 7 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c
> b/drivers/gpu/drm/vc4/vc4_gem.c
> index 9cf343297f83..ae76868663ea 100644
> --- a/drivers/gpu/drm/vc4/vc4_gem.c
> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
> @@ -639,14 +639,6 @@ vc4_queue_submit(struct drm_device *dev, struct
> vc4_exec_info *exec,
> =C2=A0
> =C2=A0	kref_get(&exec->refcount);
> =C2=A0
> -	/* The job can complete and drop exec->fence as soon as
> job_lock is
> -	 * released, so hold our own reference.
> -	 */
> -	if (out_sync)
> -		dma_fence_get(&fence->base);
> -
> -	vc4_attach_fences(exec);
> -
> =C2=A0	list_add_tail(&exec->head, &vc4->bin_job_list);
> =C2=A0
> =C2=A0	/* If no bin job was executing and if the render job (if
> any) has the
> @@ -663,12 +655,12 @@ vc4_queue_submit(struct drm_device *dev, struct
> vc4_exec_info *exec,
> =C2=A0
> =C2=A0	spin_unlock_irqrestore(&vc4->job_lock, irqflags);
> =C2=A0
> +	vc4_attach_fences(exec);
> +

Similar question as before: doesn't this mean we may submit this job
before we have installed the fences in the BO reservations? Wouldn't
that mean there is a small window where the BOs look idle to other
users when they are in fact being used by the GPU?

Iago

> =C2=A0	drm_exec_fini(exec_ctx);
> =C2=A0
> -	if (out_sync) {
> +	if (out_sync)
> =C2=A0		drm_syncobj_replace_fence(out_sync, &fence->base);
> -		dma_fence_put(&fence->base);
> -	}
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> @@ -862,13 +854,10 @@ vc4_release_exec(struct kref *ref)
> =C2=A0	unsigned long irqflags;
> =C2=A0	unsigned i;
> =C2=A0
> -	/* If we got force-completed because of GPU reset rather
> than
> -	 * through our IRQ handler, signal the fence now.
> +	/* The render done handler signals the fence, so only drop
> the
> +	 * reference here.
> =C2=A0	 */
> -	if (exec->fence) {
> -		dma_fence_signal(exec->fence);
> -		dma_fence_put(exec->fence);
> -	}
> +	dma_fence_put(exec->fence);
> =C2=A0
> =C2=A0	if (exec->bo) {
> =C2=A0		for (i =3D 0; i < exec->bo_count; i++) {
> diff --git a/drivers/gpu/drm/vc4/vc4_irq.c
> b/drivers/gpu/drm/vc4/vc4_irq.c
> index 6ced2835dfdc..241249b6582b 100644
> --- a/drivers/gpu/drm/vc4/vc4_irq.c
> +++ b/drivers/gpu/drm/vc4/vc4_irq.c
> @@ -193,11 +193,8 @@ vc4_irq_finish_render_job(struct drm_device
> *dev)
> =C2=A0	else if (nextbin && nextbin->perfmon !=3D exec->perfmon)
> =C2=A0		vc4_submit_next_bin_job(dev);
> =C2=A0
> -	if (exec->fence) {
> +	if (exec->fence)
> =C2=A0		dma_fence_signal_locked(exec->fence);
> -		dma_fence_put(exec->fence);
> -		exec->fence =3D NULL;
> -	}
> =C2=A0
> =C2=A0	wake_up_all(&vc4->job_wait_queue);
> =C2=A0	schedule_work(&vc4->job_done_work);
>=20


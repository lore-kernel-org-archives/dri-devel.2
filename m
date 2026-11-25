Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5612E606A69C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hvj3d5u3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F18310FA21;
	Wed, 25 Nov 2026 08:43:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB3110FA1C
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 08:42:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B6F462349;
 Wed, 25 Nov 2026 08:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161701F000CF;
 Wed, 25 Nov 2026 08:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795596156;
 bh=b2yDRIhzP5CJkqqVGhSdPt7//ZwPkASE4isPCyWmxko=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Hvj3d5u3ZtA6hq0w8011Xj3EPjN+AQyGylKU09Xg1X9fw+qpqGlI0tZxtsBUJ1Nh6
 GCC9BQMndGY1wsp+uAKw8kw0tC7PS+9bFFQ3HsRcV0t/nQ8T2tIQ+kSAG3pxRQir0C
 IeFK8U/oVZAA8RtgoUbBNtjfDQ+t/WxoWLrTEDA+0uQH2wM4X010JpMjX62KdrGqua
 jg0XXovdUCjmnQxQFewcY0afPNMLKqa3v+aV1Z4XgvMQxQW3M/pr92C4PrFllv3ktg
 D+BUyku3bDKxBdSTKD9ENdv5oy+xPwKXBNSgU7INRL1jXRzsVTIfu6aQMTDE6/Uhaq
 bMGvF4nZj+AwA==
Message-ID: <sashiko-outbox-232926@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/imagination: guard fence release against device
 removal
To: "Lewis Lakerink" <lewis@retsim.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <010101a211d07983-72e5379a-adfd-4134-b23d-3e2b1422bc2e-000000@us-west-2.amazonses.com>
References: <20261125082637.2839673-1-lewis@retsim.com>
 <010101a211d07983-72e5379a-adfd-4134-b23d-3e2b1422bc2e-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 08:42:34 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/imagination: context and drm_device leak in
  pvr_queue_fence_release()
--

commit 98562e29f0071aecadfba68150e688168073f7c8
Author: Lewis Lakerink <lewis@retsim.com>

drm/imagination: guard fence release against device removal

This commit guards work queueing in pvr_queue_fence_release() with
drm_dev_enter(), freeing the fence directly and skipping pvr_context_put()
when the device is unplugged.

> diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/im=
agination/pvr_queue.c
> index 34b826381aa2b..2a6bfb090fadd 100644
> --- a/drivers/gpu/drm/imagination/pvr_queue.c
> +++ b/drivers/gpu/drm/imagination/pvr_queue.c
[ ... ]
> @@ -122,8 +123,19 @@ static void pvr_queue_fence_release(struct dma_fence=
 *f)
>  {
>  	struct pvr_queue_fence *fence =3D container_of(f, struct pvr_queue_fenc=
e, base);
>  	struct pvr_device *pvr_dev =3D fence->queue->ctx->pvr_dev;
> +	int idx;
> =20
> -	queue_work(pvr_dev->sched_wq, &fence->release_work);
> +	/*
> +	 * Fences held by drm_syncobj are released in drm_file_free() before
> +	 * postclose. After unplug, sched_wq and kernel_vm_ctx may already be
> +	 * torn down; free the fence directly and leak the context reference.
> +	 */
> +	if (drm_dev_enter(from_pvr_device(pvr_dev), &idx)) {
> +		queue_work(pvr_dev->sched_wq, &fence->release_work);
> +		drm_dev_exit(idx);
> +	} else {
> +		dma_fence_free(&fence->base);
> +	}
>  }

[Severity: High]
Does leaking the fence->queue->ctx reference here also permanently leak
pvr_dev and trigger teardown warnings?

drm_dev_unplug() is called not only during pvr_remove(), but also at
runtime when a GPU reset or MMU flush fails:

drivers/gpu/drm/imagination/pvr_power.c:pvr_device_lost() {
	if (!pvr_dev->lost) {
		pvr_dev->lost =3D true;
		drm_dev_unplug(from_pvr_device(pvr_dev));
	}
}

Once unplugged, dropping the context reference in the else branch prevents
pvr_context_release() from ever running. That leaves the context in
pvr_dev->ctx_ids and its firmware objects in fw_objs.list and fw_dev->fw_mm
(triggering WARN_ONs in pvr_fw_fini() and pvr_context_device_fini()), and
never drops ctx->vm_ctx, whose drm_gpuvm manager and GEM objects hold
drm_device references that prevent drm_dev_release() from freeing pvr_dev.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/010101a211d07983-72=
e5379a-adfd-4134-b23d-3e2b1422bc2e-000000@us-west-2.amazonses.com?part=3D1

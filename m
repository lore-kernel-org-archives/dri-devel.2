Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A484C531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EBBA10F26F;
	Fri, 24 Jul 2026 00:16:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MdEm40/l";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3107810F26F
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:16:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1AE0543C9D;
 Fri, 24 Jul 2026 00:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7CB31F000E9;
 Fri, 24 Jul 2026 00:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784852173;
 bh=8HTJ/nDf4bC6JgvRuJqoOlfMVbXfV3QCnbilDSn4E9k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MdEm40/l7E1dcHJV6aVqKuHUvHj07eQXPeC0AOxAC90TZXk0qvIr1bo4Xnyv/hI0x
 pbk/0F9GOMjpn+6IUlH24sKsApqIHnD2F5LaIr9o2WeQRagmPtw7+2uG1g1ACJV898
 hyOvuQwOt6res07MiZfqgp+QHGpQGgbiau/t7XGdhtKGVhEj2ljYFnw05Xv2ZnHFVU
 HSFQ6+TdGt5RcICDbYizNrspL9ZOMR+FeHBMYMGHzNMLO2b+jPYRGlJiRO6xQUZh+i
 LY5pHMtyNFr1HUBZwvdQMFS8jqzRGXXy4X+G/BdVQgVyLRxNI5E89McwQlwwSPY9uJ
 /sMU1R1fUOA5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/13] drm/panfrost: Introduce a reset lock
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724-claude-fixes-v3-11-542af61abd0f@collabora.com>
References: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
 <20260724-claude-fixes-v3-11-542af61abd0f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 00:16:12 +0000
Message-Id: <20260724001612.C7CB31F000E9@smtp.kernel.org>
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

New issues:
- [High] Clocks and reset controllers are leaked on driver unbind because `=
pfdev->js` is never set to NULL during teardown.

Pre-existing issues:
- [High] The perfcnt ioctls (`panfrost_ioctl_perfcnt_enable` and `panfrost_=
ioctl_perfcnt_dump`) access hardware registers directly without holding the=
 newly introduced `pfdev->reset.lock`, which can race with a concurrent GPU=
 reset.
--

--- Patch [11]: [PATCH v3 11/13] drm/panfrost: Introduce a reset lock ---
commit 17d0aa882609f1a77cf16c55ac27f808cf38cb0a
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Introduce a reset lock

This commit introduces a read/write semaphore to envelop the GPU reset
sequence. This lock is used to prevent driver entry points from
accessing hardware registers while a reset is ongoing.

>     So as to avoid accessing HW register while a reset is ongoing, a read=
/write
>     semaphore that envelopes the reset sequence will help driver entry po=
ints
>     avoid racing with it. For now, the only such racy entry point is the =
ioctl
>     that returns the current GPU timestmap.

[Severity: High]
This is a pre-existing issue, but are the perfcnt ioctls
(panfrost_ioctl_perfcnt_enable and panfrost_ioctl_perfcnt_dump in
drivers/gpu/drm/panfrost/panfrost_perfcnt.c) also racy?

Both ioctls call functions that write directly to GPU_CMD and other HW
registers. If a userspace thread calls DRM_IOCTL_PANFROST_PERFCNT_DUMP
while the GPU is undergoing a soft reset (e.g., triggered by a job
timeout handled asynchronously by panfrost_reset_work), could this
corrupt the reset state machine and lead to undefined hardware behavior?

Should these ioctls also be wrapped with pfdev->reset.lock?

> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index c2a1670a74e86..c1d0b111dde1a 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -895,7 +895,9 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
>  	if (!pfdev->reset.wq)
>  		return -ENOMEM;
>  	args.timeout_wq =3D pfdev->reset.wq;
> +
>  	init_waitqueue_head(&pfdev->reset.wait);
> +	init_rwsem(&pfdev->reset.lock);
> =20
>  	for (j =3D 0; j < NUM_JOB_SLOTS; j++) {
>  		js->queue[j].fence_context =3D dma_fence_context_alloc(1);

[Severity: High]
Does the job manager teardown leak clocks and reset controllers?

This regression was introduced earlier in this patch series by commit
"drm/panfrost: Move all device power up and down into RPM callbacks".

When unbinding the device, panfrost_remove() calls panfrost_device_fini().
panfrost_jm_fini() in drivers/gpu/drm/panfrost/panfrost_job.c destroys
the job manager but does not set pfdev->js to NULL.

Later, panfrost_try_suspend_device() invokes panfrost_device_runtime_suspen=
d()
in drivers/gpu/drm/panfrost/panfrost_device.c. Because pfdev->js is still
non-NULL, panfrost_device_is_initialized() incorrectly evaluates to true.
This causes the cleanup block in panfrost_device_runtime_suspend() to be
skipped, and panfrost_clk_fini() and reset_control_assert() are never execu=
ted.

Should panfrost_jm_fini() set pfdev->js to NULL after cleaning up the
job slots?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-claude-fix=
es-v3-0-542af61abd0f@collabora.com?part=3D11

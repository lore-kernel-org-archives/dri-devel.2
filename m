Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A47C88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC85F10F72F;
	Fri, 11 Sep 2026 23:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V/ibKmhs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A16C710F732
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 23:40:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F128417B6;
 Fri, 11 Sep 2026 23:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EB31F000FF;
 Fri, 11 Sep 2026 23:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789170028;
 bh=0eSQfc4ElvVHySshbGJc3lOPODEqMv1etZ1AufxLvs8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V/ibKmhsPslSrlDlxEG/Wezzu3mJPKNp3fsaJm3Jxxr1y5SYr3AyqEbCD9s4+EUQD
 Yx526bhwCTTvAboshoCVOJ621lNLWUv2aikLQc5noGGbZzpbVE5HXcEyVXSOyWemT8
 EcVGgm8G8U2iUY217VWX3y2KRvCaFGOvTKGBUfw5Q/0RCC69rxxQIMSMJrMa7sI2h3
 8azPpaHAB03B1IkBFnyoXUgJdZ/4zwyeANY3mwSTyuL3jpXSGoQyEAVLkBsHb06gXG
 GhoqSUVrbX099r3PIHqbS1rCf0xpQzzaAGZTKjyVnjpW1030UtgvV3rVkciJgi+gpI
 5M6lGayWn+m+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 13/16] drm/panfrost: Avoid cache flush after perfcnt
 sample in fully coherent systems
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260912-claude-fixes-v9-13-e588feaa61ef@collabora.com>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-13-e588feaa61ef@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:40:27 +0000
Message-Id: <20260911234028.07EB31F000FF@smtp.kernel.org>
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
- [Medium] Waking up the user thread before clearing the GPU interrupt intr=
oduces a race condition that can clear the interrupt of a subsequent perfor=
mance counter dump, causing it to time out.
--

commit f36520c5a42efb4216abf8dab5756d0a6134f2a4
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Avoid cache flush after perfcnt sample in fully coherent syst=
ems

This commit skips the GPU cache flush when the system is fully coherent (AC=
E).
Instead of sending a cache clean command, it immediately signals completion
of the performance counter sample.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index ffc77121070e2..b3f71d7fd82a9 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -52,7 +52,10 @@ void panfrost_perfcnt_clean_cache_done(struct panfrost=
_device *pfdev)
> =20
>  void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
>  {
> -	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
> +	if (pfdev->features.selected_coherency !=3D COHERENCY_ACE)
> +		gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
> +	else

[Severity: Medium]
Does waking up the user thread before clearing the GPU interrupt introduce
a race condition that can drop subsequent sample interrupts?

If panfrost_perfcnt_sample_done() calls complete() and wakes up the user
thread, the thread can return to userspace and immediately issue a new
PERFCNT_DUMP ioctl, starting a new hardware sample.

If the IRQ handler on the original CPU is delayed or preempted (e.g., by
a hypervisor or NMI) before it writes to the clear register:

drivers/gpu/drm/panfrost/panfrost_gpu.c:panfrost_gpu_irq_handler() {
    ...
    if (state & GPU_IRQ_PERFCNT_SAMPLE_COMPLETED)
        panfrost_perfcnt_sample_done(pfdev);
   =20
    ...
    gpu_write(pfdev, GPU_INT_CLEAR, state);
}

Could it write the original state (which has the completion bit set) to
GPU_INT_CLEAR after the new sample has already started? This would clear
the interrupt for the newly submitted sample, causing the new dump's wait
to time out with -ETIMEDOUT.

Prior to this patch, the CLEAN_CACHES step prevented this race because the
delayed completion meant the interrupt clear could not hit a new sample.

> +		complete(&pfdev->perfcnt->dump_comp);
>  }
> =20
>  static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-claude-fix=
es-v9-0-e588feaa61ef@collabora.com?part=3D13

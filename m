Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F83ACA6009
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 00:00:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88B1F10F85D;
	Thu,  8 Oct 2026 00:00:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hbh+rbVy";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A22D610F85D
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 00:00:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E13143AFD;
 Thu,  8 Oct 2026 00:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AEE1F000FF;
 Thu,  8 Oct 2026 00:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791417601;
 bh=+Nne+llxAT1OtLH6AWZdNwCGsXXTBiIDy76qXlxrkmI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hbh+rbVydadr97piCanU75zDyPlZ9acbLaqO6GAYjj8jyOy6I4eoxqOQ38oP1x+C4
 sx1A+1eNi3HSUltRx2aKrOsPUXVjj6nwfH6sceV95QoEN/dFNM4w6R3qfJNztQgrD9
 9eF9V2ryDZf/PTwtFhG9nLggLKjGeEr2y/HLvmnAhWQirbYoldFuvx8A/gdTGSepg7
 tivx+VXGDepVkgOLcX/n+S6aDUPj9FZg94e7uCTjTpNPq99V+e8B/PXDbcD0a6UkVO
 zVQDJvGMTQf8EGvB6M5gFQXZyMxIpVwxT8k/A2UsAI5Bjkf8ze72AJTzA3Gx1OrWyp
 RKxNGja3nT2gg==
Message-ID: <sashiko-outbox-163446@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 10/15] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008-claude-fixes-v13-10-d6a493185860@collabora.com>
References: <20261008-claude-fixes-v13-0-d6a493185860@collabora.com>
 <20261008-claude-fixes-v13-10-d6a493185860@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 00:00:00 +0000
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
- [High] drm/panfrost: UAF in reset work due to incorrect teardown order
--

commit cfa26c5946307af48b39c322e0d8f2fd03c46e05
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Add debugfs knob for manually triggering a GPU reset

This patch adds a debugfs knob to manually trigger a GPU reset for testing
purposes. It also updates the teardown path to disable rather than cancel
the reset work to prevent the knob from triggering resets during device rem=
oval.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/pa=
nfrost/panfrost_job.c
> index 00fb36c577df7..ab65786bf63bc 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -932,7 +932,7 @@ void panfrost_jm_fini(struct panfrost_device *pfdev)
>  		drm_sched_fini(&js->queue[j].sched);
>  	}
> =20
> -	cancel_work_sync(&pfdev->reset.work);
> +	disable_work_sync(&pfdev->reset.work);

[Severity: High]
Does this teardown order leave a window for a use-after-free if a reset is
triggered during unbinding?

In panfrost_jm_fini(), the DRM schedulers are destroyed via drm_sched_fini()
before the asynchronous reset work is disabled. The drm_sched_fini() functi=
on
tears down the scheduler, destroying sched->submit_wq and freeing
sched->sched_rq.

If a GPU reset is scheduled right before or during driver unbinding (for
example, by writing to the newly introduced debugfs reset knob), the reset
work can run asynchronously while panfrost_jm_fini() executes. The reset
work calls drm_sched_stop() and drm_sched_start(), which ultimately queues
work onto the scheduler's now-destroyed submit_wq, leading to a crash.

Should disable_work_sync() be called before the loop that destroys the DRM
schedulers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-claude-fix=
es-v13-0-d6a493185860@collabora.com?part=3D10

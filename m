Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6468FC61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 21:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27C710F489;
	Fri, 28 Aug 2026 21:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gfTBx78O";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D522210F489
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 21:10:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7DB8240BA7;
 Fri, 28 Aug 2026 21:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365C01F000E9;
 Fri, 28 Aug 2026 21:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787951444;
 bh=af3ANbKbhJHryzL+id7opW2OJuFaW9X5ZAe8tKe74x4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gfTBx78ONMgm8h0JkAtYUziBfmEvS5hqjFn45staN0IxfiqiPStB5wiUPwaBptdMb
 u7bSscBs/fQw68nAzJO2tankcd/g+A+hXr5XwrpjUCs5uYWDfHwSApihE7oaqRrcWG
 tF+vlcWEx+jK0RuCW6qrafmHe6Cg74PYArQ7eKOQmz6IveaTirotytFvsxAGUv4rim
 NJN4BgS6oRst2zVFyUkmke3uXz2nlYxJU2cu6W484Oq9MFFAJlsowrPMQmbvt63cMy
 8Fg3ynAEIMI1eP8L1Lvfmdado8Jf/Xssn7eK3fmBggBQAnS0srdJJ08wjdeQYDDtDn
 q5LFzuKYpu1Wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/17] drm/panfrost: Add warning messages to fatal
 error conditions
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828-claude-fixes-v7-10-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-10-72a13b2c125d@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 21:10:43 +0000
Message-Id: <20260828211044.365C01F000E9@smtp.kernel.org>
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
- [Medium] Spurious WARN_ON triggered during system suspend when GPU jobs a=
re active.

Pre-existing issues:
- [High] Unconditional hardware access after `pm_runtime_get_sync()` failur=
e causes kernel panic.
--

commit a7ee5ddc6b752f83ff2b60cb2bbc09648f803bce
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Add warning messages to fatal error conditions

This commit adds drm_WARN_ON macros to panfrost_device_fini and
panfrost_device_runtime_suspend to warn users when PM reference acquisition
fails or when inflight jobs are reported during the PM suspend path.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 70c8109ea6987..d8acae9b8cfac 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> @@ -367,7 +368,7 @@ int panfrost_device_init(struct panfrost_device *pfde=
v)
> =20
>  void panfrost_device_fini(struct panfrost_device *pfdev)
>  {
> -	pm_runtime_get_sync(pfdev->base.dev);
> +	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);
>  	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>  	pm_runtime_disable(pfdev->base.dev);
>  	pm_runtime_put_noidle(pfdev->base.dev);

[Severity: High]
This isn't a bug introduced by this patch, but while we are adding a warning
here, does it make sense to continue execution if pm_runtime_get_sync fails?

If the device fails to power on due to a regulator or clock failure, the
warning is logged but the function continues and calls:

panfrost_device_fini()
    panfrost_jm_stop_sched_jobs()
    panfrost_device_disable_hw()

Both of these subsequent functions write to GPU registers. Accessing hardwa=
re
registers of an unclocked or unpowered device on ARM SoCs triggers a Data
Abort exception, leading to a hard kernel panic.

Should we abort the teardown or skip the hardware disable steps if the PM
resume fails?

[ ... ]

> @@ -517,7 +518,7 @@ static int panfrost_device_runtime_suspend(struct dev=
ice *dev)
>  {
>  	struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> =20
> -	if (!panfrost_jm_is_idle(pfdev))
> +	if (drm_WARN_ON(&pfdev->base, !panfrost_jm_is_idle(pfdev)))
>  		return -EBUSY;
> =20
>  	panfrost_device_disable_hw(pfdev);

[Severity: Medium]
Will this trigger a spurious warning stack trace if the system is suspended
while a GPU workload is still executing?

When a user suspends the system with an active GPU workload, the kernel
freezes userspace tasks but jobs already submitted to the hardware can
continue running. During the system suspend flow, pm_runtime_force_suspend()
intentionally bypasses usage counters and forces a call directly to
panfrost_device_runtime_suspend().

Since the job might still be executing on the hardware, panfrost_jm_is_idle=
()
can legitimately return false here. Returning -EBUSY to abort the suspend is
the expected behavior, but the new warning assumes this state is always a b=
ug
and will print a stack trace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-claude-fix=
es-v7-0-72a13b2c125d@collabora.com?part=3D10

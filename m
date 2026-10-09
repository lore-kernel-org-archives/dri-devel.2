Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A87ECA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8443410E19C;
	Fri,  9 Oct 2026 03:37:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A2tiCLpw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60F3110E19C
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 03:37:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A873D60DB0;
 Fri,  9 Oct 2026 03:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337D01F000FF;
 Fri,  9 Oct 2026 03:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791517033;
 bh=lZSS/2RFzLxHfGPISuolpDPcoGqgS5kdjH1YQ467zPE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A2tiCLpwJcacb1xdRusfD8qgcoTJ79YS0B9pjwCegN7UQ3nmJiIzcPWYS/5HlrBWB
 cojSw6jaH3LvmxLXIc1VMoYnj0G3UT2/nbS9R2eYq2ZYm32e5ImehHIE5q68QHI8mL
 fT54iAvIXyjBeFBX2OtwdoStRnyLVES1FY9O+okMBDPAgLD4lQ5sZW61iKofBWk+BI
 X9MXXZ/Vi4qgn6SPjLY1MwWUyDrppX8IFcO8+IFmgmK+RgMVJPYKxLLvDTVKAnTeUG
 jVtcSr4mFhzWFBucAIMaXkn40/k0h48/lI2o2xJ5/dmfMhOT7MPxCm4cRa/htdpuIG
 Kne6lb22K0uhA==
Message-ID: <sashiko-outbox-164779@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/20] drm/msm/dp: Keep runtime PM calls outside the
 connection lock
To: "Xilin Wu" <sophon@radxa.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 neil.armstrong@linaro.org
In-Reply-To: <20261009-msm-dp-hdr10-v2-6-1835d4966da3@radxa.com>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
 <20261009-msm-dp-hdr10-v2-6-1835d4966da3@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 03:37:12 +0000
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
- [High] drm/msm: Unresolved ABBA deadlock between runtime_suspend and IRQ =
thread
--

commit 32f0e463b46b824d1b3126d8c017d6f4509a8c7b
Author: Xilin Wu <sophon@radxa.com>

drm/msm/dp: Keep runtime PM calls outside the connection lock

This commit shifts runtime PM calls outside the connection lock in the plug,
unplug, and detect handlers. The goal is to avoid holding the lock during
synchronous PM operations that might deadlock with HPD IRQ threads.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c

[ ... ]

> @@ -488,10 +491,10 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_d=
isplay_private *dp)
>  			dp->msm_dp_display.connector_type,
>  			dp->link->sink_count);
> =20
> -	if (dp->plugged) {
> -		pm_runtime_put_sync(&pdev->dev);
> -		dp->plugged =3D false;
> -	}
> +	dp->plugged =3D false;
> +	mutex_unlock(&dp->plugged_lock);
> +
> +	pm_runtime_put_sync(&pdev->dev);

[Severity: High]
Does this still leave an ABBA deadlock, just shifted from the plugged_lock
to the PM runtime wait queue?

If a process thread (e.g., during unbind) calls this pm_runtime_put_sync()
and drops the PM usage count to 0, it triggers msm_dp_pm_runtime_suspend().

The suspend callback calls disable_irq(dp->irq), which synchronously blocks
waiting for the msm_dp_display_irq_thread to complete.

However, if the IRQ thread is concurrently handling an event, it executes
msm_dp_bridge_hpd_notify(), which unconditionally calls:

msm_dp_bridge_hpd_notify()
   pm_runtime_resume_and_get(&msm_dp_display->pdev->dev)

Because the device state is RPM_SUSPENDING, the IRQ thread blocks on the
PM runtime wait queue waiting for the suspend to finish. The suspend thread
is blocked on disable_irq() waiting for the IRQ thread, resulting in a
deadlock.

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-msm-dp-hdr=
10-v2-0-1835d4966da3@radxa.com?part=3D6

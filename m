Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670ECC55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 14:21:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C12D110E046;
	Sat,  8 Aug 2026 14:21:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NKuoe5zV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E959810E046
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 14:21:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 227F26001A;
 Sat,  8 Aug 2026 14:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B0E1F000E9;
 Sat,  8 Aug 2026 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786198898;
 bh=2HwsiBoT4f/F1We5voVUOqU5VWyg3znaPVQNbGydKo0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NKuoe5zV+jeHcJ/4yTq7qAQXg9wjFNUmjVlkKsSUvHKBcBgLLYD2YV06vg9oZpkMu
 DcMdFFQnVLUHWgHa5GzYFrZc2kFMD2XH3dy7d6uDAitMTUMGJ46omUyiLxhdGFgVyK
 uhIedScr7bFyqNpzI3b2C5HGezcpvC+RK7EF2xjHmBSL9bqpc16dkFQMQOtx7uVrXv
 BS0WUMmwEccr4361yYSz0/NcqJveIR9iZprcds3As75C2ExA+DrzCClXj8/dhrQxuS
 2Z8X46i+C/0Tm+SVhZomAOdaSI6bpPP2DMdo8PhOK7ZfNU/zVY+ai81IMyZe4myKPR
 /TnyRuXEV4phQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/tegra: gr2d: fix autosuspend cleanup during teardown
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808140622.2887873-1-lgs201920130244@gmail.com>
References: <20260808140622.2887873-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 14:21:37 +0000
Message-Id: <20260808142138.69B0E1F000E9@smtp.kernel.org>
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
- [Medium] The commit message falsely claims that gr2d_probe() calls pm_run=
time_use_autosuspend(), and adds a redundant cleanup to gr2d_remove() based=
 on this false premise.

Pre-existing issues:
- [High] Unbinding the gr2d driver while a DRM channel is open causes a Use=
-After-Free when the DRM file is later closed by userspace.
--

--- Patch [1]: [PATCH] drm/tegra: gr2d: fix autosuspend cleanup during tear=
down ---
commit 9b1fea12d4967b1c2b4a943c3958df804b6cd6a8
Author: Guangshuo Li <lgs201920130244@gmail.com>

    drm/tegra: gr2d: fix autosuspend cleanup during teardown

This commit adds a pm_runtime_dont_use_autosuspend() call to the driver's
remove function. It attempts to fix a leaked usage count reference that the
commit message states was taken in gr2d_probe().

>     gr2d_probe() calls pm_runtime_use_autosuspend(), but gr2d_remove()
>     does not call the matching pm_runtime_dont_use_autosuspend() during
>     teardown.

[Severity: Medium]
Is this description accurate?

Looking at the code, gr2d_probe() does not call pm_runtime_use_autosuspend(=
).

Furthermore, pm_runtime_dont_use_autosuspend() is already properly called
during teardown inside gr2d_exit(), which is reached via
host1x_client_unregister().

Does this patch add a redundant cleanup based on an incorrect premise?

> diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
> index 21f4dd0fa6aff..8063e06b0b87a 100644
> --- a/drivers/gpu/drm/tegra/gr2d.c
> +++ b/drivers/gpu/drm/tegra/gr2d.c
> @@ -293,6 +293,7 @@ static void gr2d_remove(struct platform_device *pdev)
>  {
>  	struct gr2d *gr2d =3D platform_get_drvdata(pdev);
> =20
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	host1x_client_unregister(&gr2d->client.base);
>  }

[Severity: High]
This is a pre-existing issue, but does unbinding the driver here
cause a use-after-free if a DRM channel remains open?

If an administrator unbinds the tegra-gr2d driver while userspace has a DRM
channel open, gr2d_remove() will execute. The struct gr2d driver data will
then be freed by devres.

When userspace subsequently closes the DRM file descriptor,
tegra_drm_postclose() calls tegra_drm_context_free(), which dereferences
the freed client ops:

drivers/gpu/drm/tegra/drm.c:tegra_drm_context_free() {
    ...
    context->client->ops->close_channel(context);
    ...
}

Should the DRM layer be coordinated with to revoke active contexts before t=
he
device structure is destroyed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808140622.2887=
873-1-lgs201920130244@gmail.com?part=3D1

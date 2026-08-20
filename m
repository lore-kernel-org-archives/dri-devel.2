Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9642C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 09:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51C2610EF7F;
	Thu, 20 Aug 2026 09:11:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TJtdczHe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8876C10EF7F
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 09:11:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A8B0F60A71;
 Thu, 20 Aug 2026 09:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402231F000E9;
 Thu, 20 Aug 2026 09:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787217095;
 bh=jK1E0vmg2aQCBWNTKOis9bGKgF8YiiA8PDQ1ZD/ScbU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TJtdczHejOoHxrJc3E2P4J9B8H8/mXIOqgW0v2RkYaQi/wGKnTueNvYkEuo8LYUBp
 A4RnLttNaYLNEGOUkLaE4I76Wckg/DXfsrjWEMeDSsJBcCMZrUmdTwffoMFk+hbr1e
 zhIdGu7Ij2gd1wlHK0cbJpwmdjQFI7uC6ZJwwFHEhmTmjEDttK3/Vn7bhpVWoqOYgf
 fHDlP1QrLMoKfHzk+GMT4Q19t6w00M1Rh9+g5TYzw0efGaLOalxuPRP7yHMCr2nfZI
 NBGAZiHwm1sRHV4PYdnUo0cSU9SWL01IYlUu2t/1ap7VzK+ZwHuDAIThYxvcNUcLk/
 /V6bH/JrK/+MQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/mediatek: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260820085609.2103835-1-triet.hoang.dev@gmail.com>
References: <20260820085609.2103835-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 09:11:34 +0000
Message-Id: <20260820091135.402231F000E9@smtp.kernel.org>
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
- [Low] The patch uses `pm_sleep_ptr()` for the `dev_pm_ops` structure poin=
ter instead of `pm_ptr()`, violating PM subsystem guidelines.
--

--- Patch [1]: [PATCH] drm/mediatek: Convert to DEFINE_SIMPLE_DEV_PM_OPS() =
---
commit 400d629fa164bd607d4a5ca22f02d2a6a8f25fe6
Author: Triet Hoang <triet.hoang.dev@gmail.com>

drm/mediatek: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

This commit replaces the deprecated SIMPLE_DEV_PM_OPS with
DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr(). It removes the __maybe_unused
annotations from the suspend and resume callbacks to reduce kernel size
when PM features are disabled.

> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c b/drivers/gpu/drm/med=
iatek/mtk_hdmi_v2.c
> index f0277fcf3345b..c1a12c5a0f905 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
[ ... ]
> @@ -1511,7 +1511,7 @@ static struct platform_driver mtk_hdmi_v2_driver =
=3D {
>  	.driver =3D {
>  		.name =3D "mediatek-drm-hdmi-v2",
>  		.of_match_table =3D mtk_drm_hdmi_v2_of_ids,
> -		.pm =3D &mtk_hdmi_v2_pm_ops,
> +		.pm =3D pm_sleep_ptr(&mtk_hdmi_v2_pm_ops),

[Severity: Low]
Should this use pm_ptr() instead of pm_sleep_ptr()?

According to power management guidelines, pm_sleep_ptr() evaluates to NULL
when CONFIG_PM_SLEEP is disabled. If runtime PM callbacks were ever added
to the dev_pm_ops structure in the future, wouldn't using pm_sleep_ptr()
here silently disable those runtime PM callbacks when system sleep is
disabled but CONFIG_PM is still enabled?

The standard pattern is to use pm_sleep_ptr() for the individual sleep
callbacks inside the structure definition, and pm_ptr() for the structure
pointer assignment itself.

>  	},
>  };
>  module_platform_driver(mtk_hdmi_v2_driver);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820085609.2103=
835-1-triet.hoang.dev@gmail.com?part=3D1

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB57CD6E6B
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B6EA113FC7;
	Thu,  4 Jun 2026 12:37:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PeicU7Jm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCBC5113FC7
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 12:37:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9F26743F4C;
 Thu,  4 Jun 2026 12:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478461F00893;
 Thu,  4 Jun 2026 12:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780576673;
 bh=g3/wPjLX+NvIcLEd83j/U6N9jwKUNb84DHbR+3oB1bM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PeicU7JmyecBEaYw1X9Z02eioKabD2fw0M1GX9TR3Q2einSCmufldj8QfOxJbkdJn
 AiOUCib9m1cE2rzfvy7dN4xq9x6QMqQJ5WB5eNV9Pivhgm9aMC4IDa5gI5DCfILh3N
 1zMPsyIEFDfCIBDVkTHCz9ama7o9lsWm+iXtX3DjXudZHJzoSz7V3o789cz87lYGhx
 ZshXB2Sc4QoLolboPuCfT0ODs3Dd6BkhUcN5qqKEsgLSD20Y+o9myMgvG1vi3kI+X/
 ZiVGc1xFDNdGbdK6th6gZG99QI9LsINmzsF17qBlICCsW/zZYaFHvEc4puUSNKrmR8
 wkXhmGSq3ZAKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] arm64: defconfig: Enable ILI7807S DSI panel driver
To: "Nabige Aala" <nabige.aala@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260604-shikra-display-v2-2-b3c1b2b67edc@oss.qualcomm.com>
References: <20260604-shikra-display-v2-2-b3c1b2b67edc@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 12:37:52 +0000
Message-Id: <20260604123753.478461F00893@smtp.kernel.org>
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
- [Low] The commit adds the Kconfig symbol CONFIG_DRM_PANEL_ILITEK_ILI7807S=
 to the arm64 defconfig, but the symbol and its corresponding driver do not=
 exist in the repository or within this patch series.
--

commit f1a3e380ead347531475952759052c8bc5c76b54
Author: Nabige Aala <nabige.aala@oss.qualcomm.com>

arm64: defconfig: Enable ILI7807S DSI panel driver

This commit enables the ILI7807S 1080x1920 video-mode DSI panel driver as a
module in the arm64 defconfig for the Shikra CQM EVK board.

> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 909f3c188e755..a6d72ff63e571 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
[ ... ]
> @@ -1005,6 +1005,7 @@ CONFIG_DRM_MXSFB=3Dm
>  CONFIG_DRM_IMX_LCDIF=3Dm
>  CONFIG_DRM_NOUVEAU=3Dm
>  CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=3Dm
> +CONFIG_DRM_PANEL_ILITEK_ILI7807S=3Dm

[Severity: Low]
Does this config symbol actually exist in the tree yet?  It appears that
CONFIG_DRM_PANEL_ILITEK_ILI7807S and its corresponding driver are missing
from the repository and this patch series.

Without the driver being present, will the config tools just silently drop
this addition during make defconfig?

>  CONFIG_DRM_PANEL_LVDS=3Dm
>  CONFIG_DRM_PANEL_HIMAX_HX8279=3Dm
>  CONFIG_DRM_PANEL_HIMAX_HX83112A=3Dm

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-shikra-dis=
play-v2-0-b3c1b2b67edc@oss.qualcomm.com?part=3D2

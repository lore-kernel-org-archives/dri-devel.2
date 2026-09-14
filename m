Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE57C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 01:43:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E100B10E059;
	Mon, 14 Sep 2026 01:43:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Sj4m+KyD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2822B10E059
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 01:43:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 376A761057;
 Mon, 14 Sep 2026 01:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75131F000FF;
 Mon, 14 Sep 2026 01:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789350227;
 bh=il2Ug0OSJqlAp24F/sdFw4HaJLPnPJObX/xWsrLVdAI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Sj4m+KyDZe6UECY4oEPxbQeulnnrMegCLo5cz9YiYRm3F6Gfop6T17PaqXePNpZcI
 am5vdMtkZOqESiq22xhN5HN+bFy01LwxqKzQfWBMx/a+B2WZa9isNu3t6k5ZFHnn7w
 3AW1pqFuySjK4A8W5D0ifTBWSaAxaXV/3WS0bZMiAeGTXgtaHg46n0VYJs6JnsiKxF
 98n9cTs/QUr3ogVIqqQi2MgdB2WsVAvHAl7CQVjVSSs744WxhOYSiNez5NZhZy5GK7
 uzOsVz7924ZfM6yY0UvLOxEq+6Sx4AfxzsgYv+MurGDM66dBoOdRse8NEYfRMRLYEj
 qNOrqaJN/HRtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] drm/rockchip: dsi: Relax the lane rate margin
 requirements
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914013331.108-4-kernel@airkyi.com>
References: <20260914013331.108-1-kernel@airkyi.com>
 <20260914013331.108-4-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 01:43:47 +0000
Message-Id: <20260914014347.B75131F000FF@smtp.kernel.org>
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

Pre-existing issues:
- [High] 32-bit integer overflow in PHY pixel clock calculation limits maxi=
mum pixel clock to 429.49 MHz.
--

commit 979a891d8dcf3f71d29e5487fb6d05be64459b38
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: dsi: Relax the lane rate margin requirements

This commit relaxes the lane rate margin requirements for the rockchip
dw-mipi-dsi driver to accommodate platforms with a 1Gbps lane rate limit.
It updates the bandwidth calculations to use an 11% overhead instead of 25%.

> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gp=
u/drm/rockchip/dw-mipi-dsi-rockchip.c
> index aab3353945de5..76607eac470a3 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c

[ ... ]

> @@ -600,7 +600,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const stru=
ct drm_display_mode *mode,
> =20
>  	/* for external phy only a the mipi_dphy_config is necessary */
>  	if (dsi->phy) {
> -		phy_mipi_dphy_get_default_config(mode->clock * 1000 * 10 / 8,
> +		phy_mipi_dphy_get_default_config((u32)mode->clock * 1000 * 10 / 9,

[Severity: High]
This isn't a bug introduced by this patch, but does this calculation still
overflow for pixel clocks greater than 429.49 MHz?

The original code overflowed at 214 MHz due to signed 32-bit math. While the
addition of the (u32) cast prevents the signed overflow, the arithmetic
(u32)mode->clock * 1000 * 10 still evaluates within 32-bit bounds before
being promoted to the 64-bit unsigned long parameter of
phy_mipi_dphy_get_default_config() in dw_mipi_dsi_get_lane_mbps().

For a MIPI DSI panel with a high pixel clock, such as 450 MHz, the
calculation evaluates to 4,500,000,000. This exceeds U32_MAX and wraps
around, configuring the PHY with a drastically lower clock frequency and
resulting in link training failures.

Could this be resolved by casting to u64 or using mul_u32_u32() to ensure
the intermediate multiplication doesn't overflow?

>  						 bpp, lanes,
>  						 &dsi->phy_opts.mipi_dphy);
>  		dsi->lane_mbps =3D target_mbps;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914013331.108-=
1-kernel@airkyi.com?part=3D3

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E47C61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 14:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD2F10F9F4;
	Fri,  4 Sep 2026 14:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IBQAWG+I";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE62410F9DB
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 14:00:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3BC9E6020A;
 Fri,  4 Sep 2026 14:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41261F00AC4;
 Fri,  4 Sep 2026 14:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788530401;
 bh=HVxtnXcXhjuu7nWb7gwK1VYqDBwl6ZvENMEGX7Jr8wg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IBQAWG+IPOS+e7Vh5QXnmuBASkA6sMeOvrWV8KfonJ7XTmzl/ajTvO9Mlzu8V4owd
 tYYNxWkDhm4Jpz1XmXKdKChQxFhU3Blosmti9Wf5tIfG/76X9gpo0PKR/M/AEIcbFA
 MhcfSXqKZjfM1J/LDVMjwTbR3vKmYDRtcB/eDD7R+5Wxqbl8k8ze7JROn6b8XvpfX0
 zp/UtgCOPsSjLXjc1jkgRbU0compX339FIgibrxSEytk0yUDf0SWxGmdfvC20b9cyW
 /hp77buCFHXg5xrjAMYNpEe88zRFQnt3b7WXRDLr+vpkbAhGV5FYdmWVsYL405bvG5
 XLdL1YfMJmUGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/19] phy: rockchip: inno-hdmi: Use the common
 Innosilicon PHY helpers
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org, robh@kernel.org,
 conor+dt@kernel.org, linux-clk@vger.kernel.org, olteanv@gmail.com,
 devicetree@vger.kernel.org, vkoul@kernel.org, linux-phy@lists.infradead.org,
 mfd@lists.linux.dev, lee@kernel.org
In-Reply-To: <20260904-jh7110-clean-send-v3-16-484f9ae72715@samsung.com>
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132739eucas1p223161c8aa461d6ad18786635ab3c9de4@eucas1p2.samsung.com>
 <20260904-jh7110-clean-send-v3-16-484f9ae72715@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 13:59:59 +0000
Message-Id: <20260904140000.D41261F00AC4@smtp.kernel.org>
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
- [Low] Unused macros `RK3328_SPREAD_SPECTRUM_MOD_DOWN` and `RK3328_SPREAD_=
SPECTRUM_MOD_DISABLE` were left behind despite the commit message claiming =
that unused pre-PLL macros were removed.
--

commit 103e72298ee1993440baf6c4457495f034d88185
Author: Michal Wilczynski <m.wilczynski@samsung.com>

phy: rockchip: inno-hdmi: Use the common Innosilicon PHY helpers

This commit refactors the RK3328 pre-PLL programming to use shared
Innosilicon PHY helpers. It removes local copies of register-level code,
macros, and table lookups. The RK3228 retains its own register code while
sharing the table lookup.

> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/=
rockchip/phy-rockchip-inno-hdmi.c
> index c3d257a0f4a65..17229d039132e 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
> @@ -130,42 +131,17 @@
>  #define RK3328_INT_VSS_AGND_ESD_DET			BIT(1)
>  #define RK3328_INT_AGND_VSS_ESD_DET			BIT(0)
>  /* REG: 0xa0 */
> -#define RK3328_PCLK_VCO_DIV_5_MASK			BIT(1)
> -#define RK3328_PCLK_VCO_DIV_5(x)			UPDATE(x, 1, 1)
>  #define RK3328_PRE_PLL_POWER_DOWN			BIT(0)
>  /* REG: 0xa1 */
> -#define RK3328_PRE_PLL_PRE_DIV_MASK			GENMASK(5, 0)
> -#define RK3328_PRE_PLL_PRE_DIV(x)			UPDATE(x, 5, 0)
>  /* REG: 0xa2 */
>  /* unset means center spread */
>  #define RK3328_SPREAD_SPECTRUM_MOD_DOWN			BIT(7)
>  #define RK3328_SPREAD_SPECTRUM_MOD_DISABLE		BIT(6)

[Severity: Low]
Are these macros still needed? The commit message states that unused pre-PLL
macros are being removed, but these appear to have been left behind. Since
the shared helper uses its own definitions, are these now orphaned dead cod=
e?

> -#define RK3328_PRE_PLL_FRAC_DIV_DISABLE			UPDATE(3, 5, 4)
> -#define RK3328_PRE_PLL_FB_DIV_11_8_MASK			GENMASK(3, 0)
> -#define RK3328_PRE_PLL_FB_DIV_11_8(x)			UPDATE((x) >> 8, 3, 0)
>  /* REG: 0xa3 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-jh7110-cle=
an-send-v3-0-484f9ae72715@samsung.com?part=3D16

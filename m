Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0B5C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBD0510F3BF;
	Fri, 28 Aug 2026 14:01:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GsAOb+Fn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B0010F3BF
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:01:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5B57F406F7;
 Fri, 28 Aug 2026 14:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977481F000E9;
 Fri, 28 Aug 2026 14:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787925694;
 bh=yQd6qsG83TrABDNJhnMxz4ZOai3+liNS/8tuJVDfUkk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GsAOb+Fn7op6wFEOlD3sNtVrsQ/rKtwUm10Xy3L7xcHO752Uar0bNGbAYgzqrYdRS
 fh4t7hXWmD/2yoBDCCdg1FPxQoxcvmo6rarWs9Cy10SBmfa6tgnWWitprAMfHmcEjp
 x+L45W/ykzQDpGTCqk5aGDJEEVtZjFvuS3sVwPANx2Drhgj7VyHNvXbeZrKUBdLKkX
 1tlLho6167nfyzGwV8BMNfd7g2+Ga/ZXraw9BFRK2dAuPkuHCfHJgwHfAOMdI1MFhA
 sX4Xj3EUyeNr+fQ213EcCHZD1GpIJlTID9Y7pOJScVLIGR9PZaUom/ZtmG1zGd8uiL
 3UjEvZbYEVO4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/15] clk: starfive: jh7110-vout: Allow pixel clock
 rate propagation
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: lee@kernel.org, linux-clk@vger.kernel.org, linux-phy@lists.infradead.org,
 neil.armstrong@linaro.org, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org,
 vkoul@kernel.org, olteanv@gmail.com, robh@kernel.org
In-Reply-To: <20260828-jh7110-clean-send-v2-9-331680c8b9d1@samsung.com>
References: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
 <CGME20260828134830eucas1p1188cde4642239a10afedf46b415dfde4@eucas1p1.samsung.com>
 <20260828-jh7110-clean-send-v2-9-331680c8b9d1@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 14:01:33 +0000
Message-Id: <20260828140133.977481F000E9@smtp.kernel.org>
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
- [High] Adding CLK_SET_RATE_PARENT without CLK_SET_RATE_NO_REPARENT on har=
dware signal-routing muxes allows clk_set_rate() to dynamically hijack the =
active clock parent.
--

commit 09b0c9046fefb467ad795def912713bba900bd11
Author: Michal Wilczynski <m.wilczynski@samsung.com>

clk: starfive: jh7110-vout: Allow pixel clock rate propagation

This commit adds CLK_SET_RATE_PARENT to the dc8200_pix0 and dc8200_pix1
MUXes, allowing display controller rate requests to propagate to the
parent clock.

> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-vout.c b/drivers/cl=
k/starfive/clk-starfive-jh7110-vout.c
> index bad20d5d794a7..b608fe3580311 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7110-vout.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
> @@ -40,10 +40,10 @@ static const struct jh71x0_clk_data jh7110_voutclk_da=
ta[] =3D {
>  	JH71X0_GATE(JH7110_VOUTCLK_DC8200_AXI, "dc8200_axi", 0, JH7110_VOUTCLK_=
VOUT_TOP_AXI),
>  	JH71X0_GATE(JH7110_VOUTCLK_DC8200_CORE, "dc8200_core", 0, JH7110_VOUTCL=
K_VOUT_TOP_AXI),
>  	JH71X0_GATE(JH7110_VOUTCLK_DC8200_AHB, "dc8200_ahb", 0, JH7110_VOUTCLK_=
VOUT_TOP_AHB),
> -	JH71X0_GMUX(JH7110_VOUTCLK_DC8200_PIX0, "dc8200_pix0", 0, 2,
> +	JH71X0_GMUX(JH7110_VOUTCLK_DC8200_PIX0, "dc8200_pix0", CLK_SET_RATE_PAR=
ENT, 2,
>  		    JH7110_VOUTCLK_DC8200_PIX,
>  		    JH7110_VOUTCLK_HDMITX0_PIXELCLK),
> -	JH71X0_GMUX(JH7110_VOUTCLK_DC8200_PIX1, "dc8200_pix1", 0, 2,
> +	JH71X0_GMUX(JH7110_VOUTCLK_DC8200_PIX1, "dc8200_pix1", CLK_SET_RATE_PAR=
ENT, 2,
>  		    JH7110_VOUTCLK_DC8200_PIX,
>  		    JH7110_VOUTCLK_HDMITX0_PIXELCLK),

[Severity: High]
Does adding CLK_SET_RATE_PARENT without CLK_SET_RATE_NO_REPARENT on these
hardware signal-routing muxes allow CCF to unexpectedly reparent the active
clock parent?

When the display driver calls clk_set_rate() on the dc8200_pix0 or
dc8200_pix1 clock, __clk_mux_determine_rate() will evaluate all parents
because CLK_SET_RATE_NO_REPARENT is not set.

Because the HDMI PHY PLL is highly adjustable, it will likely offer a
mathematically closer rate than the generic DC8200_PIX divider. CCF will
then select the HDMI PHY as the best parent and dynamically reparent the
clock by calling clk_core_reparent().

Could this silently override the display driver's physical routing
configuration and sever the physical routing, breaking the display output?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-jh7110-cle=
an-send-v2-0-331680c8b9d1@samsung.com?part=3D9

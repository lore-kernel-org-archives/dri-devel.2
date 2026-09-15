Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6D2C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C5D610E2D2;
	Tue, 15 Sep 2026 15:42:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HzElr28T";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B216C10FC58
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:42:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6974E43D3D;
 Tue, 15 Sep 2026 15:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB10A1F000FF;
 Tue, 15 Sep 2026 15:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789486965;
 bh=AX4ZPiwoECjWJdEGXj/MDeda6bu8zZxZKkmx2AN2TIw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HzElr28TA2A6t61nW10Ne++osJPTsbGCzMP8PxZf9TkC22tkHny0PUmSm0mrtYt5E
 qHrRn7WdlXIwcaCevu0vhmJGc+5VykOc8MyhsU3XyFKth17SAel0jzGLEJj6ZG8exv
 /dNFWFRK3elx2rM9FqC73f5K9JBOG4DNgGL29T/IPLaTxkzC+IL5JwnCI0nkOuPO4e
 zAtvJN5aXHAGjeJjLmxFi0NOmpAXGv7p96FCR1EezQID5mW02/o/czyqNEWziabbOU
 qyanKfDkT2ppY+LZY0QS/AVpCJgusZrkbj+QMH2qqle12F2WMC1p1HI5yr1bJ+fbRS
 JWwThRNRNl+Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/20] drm/bridge: starfive: Add JH7110 HDMI
 controller driver
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: olteanv@gmail.com, robh@kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, lee@kernel.org,
 neil.armstrong@linaro.org, conor+dt@kernel.org, mfd@lists.linux.dev,
 linux-phy@lists.infradead.org, vkoul@kernel.org
In-Reply-To: <20260915-jh7110-clean-send-v4-15-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153241eucas1p292a3312a0ca8aed99cc416c0e01c3b66@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-15-f0e4fd6f2cc8@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:42:43 +0000
Message-Id: <20260915154243.EB10A1F000FF@smtp.kernel.org>
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

> Add the HDMI controller (bridge) driver for the StarFive JH7110.
>=20
> This driver binds to the starfive,jh7110-inno-hdmi-controller node. It
> gets its register access, module and bus clocks from voutcrg, and
> consumes the pixel clock and the PHY from its hdmi_phy sibling.
>=20
> The driver calls the generic inno_hdmi_probe function, which picks up
> the regmap shared with the PHY from the parent device and registers a
> DRM bridge. The .enable hook is responsible for setting the PHY's pixel
> clock rate via clk_set_rate() and powering on the PHY via
> phy_power_on().
>=20
> The DC8200 has two panels, each exposing a DP and a DPI interface, and a
> mux in the video output system controller picks which of them drives the
> HDMI transmitter. It comes out of reset on panel 0 / DPI, which happens
> [ ... ]
> devm_drm_bridge_add(). Releasing them in .remove runs before devres
> unwinds and would leave the bridge registered with its clocks already
> gated.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-jh7110-cle=
an-send-v4-0-f0e4fd6f2cc8@samsung.com?part=3D15


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1847C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D99EE10E311;
	Tue, 15 Sep 2026 15:38:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HhV2LUZr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2518410E311
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:38:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 64442600D1;
 Tue, 15 Sep 2026 15:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BE31F000FF;
 Tue, 15 Sep 2026 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789486688;
 bh=nzC7oa+r/phCJ/7hvumhpU+FA2dyGXGpPMkboLtxjyU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HhV2LUZrxpzeI/MrBTkg/qrVe/GDGYUlQXpQoKi+DdGmOq4b7dcPJ0lLeetG6LRWg
 9MVWaGr4Fovtyj/ZLIiHCdv4j/LxmKmtr4LGC9t5YZ3iHyxRYSzRnEOuPfrxtgSqgj
 fSIyjOj6MGKqw2ZDj7fRoYukkZnUkRZDPFlpq8D+6xWhjXFA7I4rbFbH7FF0/0Xky0
 jO95nu5zFYj+B6THmubNoBk7YqSxRJy1ygDbVJTFVt8RCm6ervarDk/3zSY4Cdq74q
 Z/ZCsMWDbH6klPQPi0gnWLbNuizuDD9tdd89UrPn9MytxjNmGRc8tgwfGaCNHZRmT1
 HwL2YijEpLx6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/20] clk: starfive: jh7110-vout: Allow pixel clock
 rate propagation
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 olteanv@gmail.com, conor+dt@kernel.org, neil.armstrong@linaro.org,
 mfd@lists.linux.dev, vkoul@kernel.org, robh@kernel.org,
 linux-phy@lists.infradead.org, linux-clk@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260915-jh7110-clean-send-v4-14-f0e4fd6f2cc8@samsung.com>
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153238eucas1p29917a31d10ce1aa55c1dcb44b62180f9@eucas1p2.samsung.com>
 <20260915-jh7110-clean-send-v4-14-f0e4fd6f2cc8@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:38:06 +0000
Message-Id: <20260915153807.78BE31F000FF@smtp.kernel.org>
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

> The dc8200_pix0 and dc8200_pix1 MUXes feed the display controller, and
> the rate they carry is ultimately produced by the HDMI PHY, which
> registers hdmitx0_pixelclk as a clock provider.
>=20
> Add CLK_SET_RATE_PARENT to both MUXes so a rate requested on them
> reaches that parent, instead of being clamped to whatever rate the
> parent already happens to run at.
>=20
> Co-developed-by: Dominique Belhachemi <db@domibel.de>
> Signed-off-by: Dominique Belhachemi <db@domibel.de>
> Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-jh7110-cle=
an-send-v4-0-f0e4fd6f2cc8@samsung.com?part=3D14


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB276C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 092CC10F437;
	Fri, 28 Aug 2026 16:43:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YlMEhQmZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2077610F42F
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 16:43:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CE0994190D;
 Fri, 28 Aug 2026 16:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019661F000E9;
 Fri, 28 Aug 2026 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787935391;
 bh=sZhi+PUsJgvLChAVERL3VabJ3ZhgAoRELKqEbZMxnag=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YlMEhQmZgmm8ZzYGm9XHtqqhGRckC4bAQ+2tUg5K9WWnx3i8IFHQErCPNXbQ/m8LA
 rDmNM+DRmpFH5oxKu9wxdRgNTMCysYsHE8CZlvITZVAVvbu1/FxU4lN3p5hXZNabiH
 WzVIXVrPJ5nDda2avE3yQSR+GTcyzdNQdWvus/iPvtteE2HxIvfQ+oto3Dg81f4RwV
 kVDOlthv20IolO1phhNMzZKAI5xu5nu4QTcG7WmTVMm07VOMe9fEU+lbFDCNEcqSzB
 B3TpR4V6b0Q3LaSucLQmMQe+YDRBVjzRrx/JchTfrRWuTFNC7Y5tuV2vn1dHe39oXJ
 KMMTS2owO02nQ==
Date: Fri, 28 Aug 2026 17:43:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Lee Jones <lee@kernel.org>,
 Andy Yan <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Hal Feng <hal.feng@starfivetech.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Heiko Stuebner <heiko@sntech.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Dominique Belhachemi <db@domibel.de>, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mfd@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,
 Icenowy Zheng <uwu@icenowy.me>, Andy Yan <andyshrk@163.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Maud Spierings <maudspierings@gocontroll.com>,
 Graham Markall <hello@big-grey.co.uk>
Subject: Re: [PATCH v2 01/15] dt-bindings: phy: Add
 starfive,jh7110-inno-hdmi-phy
Message-ID: <20260828-unnoticed-reputable-37156d7953a6@spud>
References: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
 <CGME20260828134815eucas1p2b2aabc17e9cc6346e5a93bde5c650958@eucas1p2.samsung.com>
 <20260828-jh7110-clean-send-v2-1-331680c8b9d1@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IjnpyshY8lzNsBCD"
Content-Disposition: inline
In-Reply-To: <20260828-jh7110-clean-send-v2-1-331680c8b9d1@samsung.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

--IjnpyshY8lzNsBCD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 28, 2026 at 03:47:25PM +0200, Michal Wilczynski wrote:

> +  clock-names:
> +    const: refoclk

> +  clock-output-names:
> +    const: hdmi_pclk

Can you drop the obvious "clk" suffixes from these please? Although,
with one input and one output clock, what's the point of the -names
proeprties anyway?

Cheers,
Conor.


--IjnpyshY8lzNsBCD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapG6lQAKCRB4tDGHoIJi
0sm8AP4oliWIKMzgp8Ut3A394llDZYxdfr4HRcVVe7khXDrtiQEAnHjEzjNSnHhx
0TyqrToY++PvSu1CTCWyTFL6ZUf3FAU=
=a1Yl
-----END PGP SIGNATURE-----

--IjnpyshY8lzNsBCD--

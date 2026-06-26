Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8650ACDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F056610E469;
	Fri, 26 Jun 2026 12:48:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c1nHVby4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE14710E469
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:48:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AA6C443FCD;
 Fri, 26 Jun 2026 12:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7ABE1F000E9;
 Fri, 26 Jun 2026 12:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782478092;
 bh=v4y2stLxJY7uDBiTbKNkCgVELhkFZRy7m3W4tRJdf+E=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=c1nHVby4VzRMzYi1WtQ/1/FW3ad4AR7RuNig6IMp0LM3ATUWQciaqWn60HmhO2Mvx
 cNEqkAHm18Hvnr+k13yWAhq+yWo1uNw3hHWs3Q8x1TMAn1T5q4A954G06yoTZ/xqv7
 lRQaMyVCNzPQM45PccrZMMHmAIAiMKXOnHAYfj6tLYr6w+/gjiQcRXuiPq4vQPbvJZ
 cLkFy6mqvFRYiquJKKOAOxqBTRMC3VrfNBzcr08WK3a7LEXgOXrYKDLUf/GU7q1FJs
 LJqnxBYj30rKVQA7A4J67kU/ZHMfl/2PT7/+94GYQY7CBjUcCvqoe/B9jXAyzpvIl0
 O2OBomnk1cP5w==
Message-ID: <c5dc7d7db15a943d1b902469d79f4eb2@kernel.org>
Date: Fri, 26 Jun 2026 12:48:10 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Albert Esteve" <aesteve@redhat.com>
Subject: Re: [PATCH 2/5] drm/bridge/panel: hold a reference to the wrapped
 panel
In-Reply-To: <20260626-drm_refcount_wiring-v1-2-cca1a7b3bdef@redhat.com>
References: <20260626-drm_refcount_wiring-v1-2-cca1a7b3bdef@redhat.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev,
 linux-tegra@vger.kernel.org, "Alain Volmat" <alain.volmat@foss.st.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>, "Alim
 Akhtar" <alim.akhtar@samsung.com>, "Alison Wang" <alison.wang@nxp.com>,
 "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "Andy Yan" <andy.yan@rock-chips.com>, "Biju
 Das" <biju.das.jz@bp.renesas.com>, "Chen-Yu Tsai" <wens@kernel.org>, "David
 Airlie" <airlied@gmail.com>, "Fabio Estevam" <festevam@gmail.com>, "Frank
 Li" <Frank.Li@nxp.com>, "Geert Uytterhoeven" <geert+renesas@glider.be>,
 =?utf-8?b?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
 "Inki Dae" <inki.dae@samsung.com>, "Jagan
 Teki" <jagan@amarulasolutions.com>, "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Jessica
 Zhang" <jesszhan0024@gmail.com>, "Jingoo Han" <jingoohan1@gmail.com>, "Jonas
 Karlman" <jonas@kwiboo.se>, "Jonathan Hunter" <jonathanh@nvidia.com>, "Jyri
 Sarha" <jyri.sarha@iki.fi>,
 "Kieran Bingham" <kieran.bingham+renesas@ideasonboard.com>, "Krzysztof
 Kozlowski" <krzk@kernel.org>, "Kyungmin Park" <kyungmin.park@samsung.com>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Laurent Pinchart" <laurent.pinchart+renesas@ideasonboard.com>, "Laurentiu
 Palcu" <laurentiu.palcu@oss.nxp.com>, "Linus Walleij" <linusw@kernel.org>,
 "Luca
 Ceresoli" <luca.ceresoli@bootlin.com>, "Lucas Stach" <l.stach@pengutronix.de>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Magnus Damm" <magnus.damm@gmail.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Marek Vasut" <marex@denx.de>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Mikko Perttunen" <mperttunen@nvidia.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Paul
 Cercueil" <paul@crapouillou.net>, "Paul Kocialkowski" <paulk@sys-base.io>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Peter Griffin" <peter.griffin@linaro.org>, "Philippe
 Cornu" <philippe.cornu@foss.st.com>,
 "Raphael Gallais-Pou" <raphael.gallais-pou@foss.st.com>, "Raphael
 Gallais-Pou" <rgallaispou@gmail.com>, "Robert Foss" <rfoss@kernel.org>, "Samuel
 Holland" <samuel@sholland.org>, "Sandy Huang" <hjc@rock-chips.com>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Seung-Woo Kim" <sw0312.kim@samsung.com>,
 "Simona
 Vetter" <simona@ffwll.ch>, "Stefan Agner" <stefan@agner.ch>, "Thierry
 Reding" <thierry.reding@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>,
 "Yannick Fertre" <yannick.fertre@foss.st.com>
Content-Transfer-Encoding: 7bit
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

On Fri, 26 Jun 2026 14:03:24 +0200, Albert Esteve wrote:
> drm_panel_bridge_add_typed() stores a pointer to the drm_panel it
> wraps, but never acquires a reference to it. If the panel device
> goes away while a panel_bridge still exists, the dangling pointer can
> be dereferenced through panel_bridge->panel.
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

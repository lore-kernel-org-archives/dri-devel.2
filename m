Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5065EC531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 18:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85B8410E4E1;
	Mon, 27 Jul 2026 18:46:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="Pstfw6IK";
	dkim-atps=neutral
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com
 [91.218.175.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C3A610E4E1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 18:46:18 +0000 (UTC)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
 s=key1; t=1785177974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s0wH+ySFfCBVmnBojBZaXIoCALe+k/ClNs6fjt/QIh0=;
 b=Pstfw6IK644jlNnRGZZRzPiUJEWtkwg3bh22GraX3/i7mt3gP1kE9IC1GsrEiZtN9HwtV0
 MbmNO1kYDW2KbxEiOr9P49jzr3JFdam9Nv4GjjD4EnyoxMaeGntAA6aDHk6vcsi6R0udzB
 +qL9WEAdvH37Xa/JrZBO5IRJVCi2wuT6cT0F3vO1i/01J0QVy6duT66k2KWM33tHsZvYjQ
 IdWTyvdQr7nYV4CBGvN1dS+L/UTx/sY/MqpIXlJweYMZ4jPVhCOdsVHOTVktRuhWKjSlzx
 xk9gIo5Z9YB9UXA4kdjs/bbuTUWyR74sGlTMCREYyq4Bzestgaw3iD+MdtjkZw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 20:45:58 +0200
Message-Id: <DK9KRSOWRHY0.H7SC0R3BIIUZ@cknow-tech.com>
To: "Neil Armstrong" <neil.armstrong@linaro.org>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca
 Ceresoli" <luca.ceresoli@bootlin.com>, "Inki Dae" <inki.dae@samsung.com>,
 "Jagan Teki" <jagan@amarulasolutions.com>, "Marek Szyprowski"
 <m.szyprowski@samsung.com>, "Laurentiu Palcu"
 <laurentiu.palcu@oss.nxp.com>, "Lucas Stach" <l.stach@pengutronix.de>,
 "Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam"
 <festevam@gmail.com>, "Paul Cercueil" <paul@crapouillou.net>, "Linus
 Walleij" <linusw@kernel.org>, "Marek Vasut" <marex@denx.de>, "Stefan Agner"
 <stefan@agner.ch>, "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>,
 "Laurent Pinchart" <laurent.pinchart+renesas@ideasonboard.com>, "Kieran
 Bingham" <kieran.bingham+renesas@ideasonboard.com>, "Geert Uytterhoeven"
 <geert+renesas@glider.be>, "Magnus Damm" <magnus.damm@gmail.com>, "Biju
 Das" <biju.das.jz@bp.renesas.com>, "Sandy Huang" <hjc@rock-chips.com>,
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "Andy Yan"
 <andy.yan@rock-chips.com>, "Yannick Fertre" <yannick.fertre@foss.st.com>,
 "Raphael Gallais-Pou" <raphael.gallais-pou@foss.st.com>, "Philippe Cornu"
 <philippe.cornu@foss.st.com>, "Maxime Coquelin"
 <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Chen-Yu Tsai" <wens@kernel.org>, "Samuel
 Holland" <samuel@sholland.org>, "Jyri Sarha" <jyri.sarha@iki.fi>, "Jingoo
 Han" <jingoohan1@gmail.com>, "Seung-Woo Kim" <sw0312.kim@samsung.com>,
 "Kyungmin Park" <kyungmin.park@samsung.com>, "Krzysztof Kozlowski"
 <krzk@kernel.org>, "Peter Griffin" <peter.griffin@linaro.org>, "Alim
 Akhtar" <alim.akhtar@samsung.com>, "Alison Wang" <alison.wang@nxp.com>,
 "Paul Kocialkowski" <paulk@sys-base.io>, "Alain Volmat"
 <alain.volmat@foss.st.com>, "Raphael Gallais-Pou" <rgallaispou@gmail.com>,
 "Thierry Reding" <thierry.reding@kernel.org>, "Mikko Perttunen"
 <mperttunen@nvidia.com>, "Jonathan Hunter" <jonathanh@nvidia.com>, "Albert
 Esteve" <aesteve@redhat.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mips@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
 <linux-rockchip@lists.infradead.org>,
 <linux-stm32@st-md-mailman.stormreply.com>, <linux-sunxi@lists.linux.dev>,
 <linux-samsung-soc@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] drm/panel: refcounting panel lookups and references
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
References: <20260717-drm_refcount_wiring-v3-0-023900c32e01@redhat.com>
 <178472247762.1745070.2847290153778032256.b4-ty@b4>
In-Reply-To: <178472247762.1745070.2847290153778032256.b4-ty@b4>
X-Migadu-Flow: FLOW_OUT
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

On Wed Jul 22, 2026 at 2:15 PM CEST, Neil Armstrong wrote:
> On Fri, 17 Jul 2026 16:02:03 +0200, Albert Esteve wrote:
>> The drm_panel subsystem provides kref-based reference counting [1]
>> (drm_panel_get/put) but almost nothing in the tree actually uses it.
>> This results in a systemic use-after-free pattern throughout the codebas=
e.
>>=20
>> This series aims to close all those issues.
>>=20
>> Patches 1-2: fix the infrastructure. drm_panel_add/remove now keep
>> a counted reference for the list entry. drm_panel_bridge_add_typed()
>> now holds a counted reference for the lifetime of the panel_bridge.
>>=20
>> [...]
>
> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (dr=
m-misc-next)
>
> [1/4] drm/panel: have drm_panel_add/remove manage a list reference
>       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/61aebeadff4=
0cded27168e53406e0120ad66e114
> [2/4] drm/bridge/panel: hold a reference to the wrapped panel
>       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/8f79d34ea89=
50fd825e0d6ecd713705a42f06417
> [3/4] drm/panel: of_drm_find_panel() return a counted reference
>       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/b71a623598d=
319cae2acd9df1b297cc948c58bc7
> [4/4] drm/panel: find_panel_by_fwnode() return a counted reference
>       https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/ac3baea883d=
ab989178dd4186090d6bcf52b8d55

That last commit resulted in an extra ``drm_panel.c.orig`` file which=20
wasn't part of the patch and seems incorrect?

Cheers,
  Diederik

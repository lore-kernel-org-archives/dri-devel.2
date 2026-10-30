Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D1F606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Sd14mJMc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02C1088697;
	Fri, 30 Oct 2026 17:31:39 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D8811295A
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:31:32 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 010A4C49F6C;
 Fri, 30 Oct 2026 17:32:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1AACC603C2;
 Fri, 30 Oct 2026 17:31:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C43DF10329127; Fri, 30 Oct 2026 18:31:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793381485; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=lg0kgxHUKFzjiXY6CFOjM8mcZ+WYoVq2CQlrIXQSExI=;
 b=Sd14mJMcVMS3sOmQ2BRP/Yu27JyNaplvycxZT/sUbjYugorR3C5K7ebD0EIYqmrAIAN91+
 FRNv2vEt72dF438Dcgvt+/81ygxJN+sBh1LbP2ri3aRyIt+vnasNOrhK09Ec5zoI/msld6
 2J8HnJxSrBm74asVssFdeUzcikjyEmZkRY48/ikGuxsB9r8bqxUQjZNu2ROt2rQWE9la0o
 wjL8CWYXEBOHplUPlRUhEnbfGB+nsQR2542d2e/8X6vnD9ZRfuPojJvtYZwBfktqkS3o+e
 fgNUZTQ4Eww+aJUgZifIz687VPiGnsT3xVSNvC5qUf7felDCsf5sWg7oRh9q1g==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 18:31:02 +0100
Message-Id: <DMICO60J4G03.1QBH2T9SQ7XEZ@bootlin.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-mips@vger.kernel.org>, <imx@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-renesas-soc@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>, <linux-sunxi@lists.linux.dev>,
 <linux-tegra@vger.kernel.org>, <linux-rpi-kernel@lists.infradead.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Douglas
 Anderson" <dianders@chromium.org>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Jessica Zhang" <jesszhan0024@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Jyri
 Sarha" <jyri.sarha@iki.fi>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca
 Ceresoli" <luca.ceresoli@bootlin.com>, "Paul Cercueil"
 <paul@crapouillou.net>, "Marek Vasut" <marex@denx.de>, "Stefan Agner"
 <stefan@agner.ch>, "Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer"
 <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Laurent
 Pinchart" <laurent.pinchart+renesas@ideasonboard.com>, "Tomi Valkeinen"
 <tomi.valkeinen+renesas@ideasonboard.com>, "Kieran Bingham"
 <kieran.bingham+renesas@ideasonboard.com>, "Geert Uytterhoeven"
 <geert+renesas@glider.be>, "Magnus Damm" <magnus.damm@gmail.com>, "Biju
 Das" <biju.das.jz@bp.renesas.com>, "Linus Walleij" <linusw@kernel.org>,
 "Sandy Huang" <hjc@rock-chips.com>, =?utf-8?q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, "Andy Yan" <andy.yan@rock-chips.com>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Inki Dae" <inki.dae@samsung.com>, "Seung-Woo Kim"
 <sw0312.kim@samsung.com>, "Kyungmin Park" <kyungmin.park@samsung.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, "Peter Griffin"
 <peter.griffin@linaro.org>, "Alim Akhtar" <alim.akhtar@samsung.com>,
 "Alison Wang" <alison.wang@nxp.com>, "Paul Kocialkowski"
 <paulk@sys-base.io>, "Yannick Fertre" <yannick.fertre@foss.st.com>,
 "Raphael Gallais-Pou" <raphael.gallais-pou@foss.st.com>, "Philippe Cornu"
 <philippe.cornu@foss.st.com>, "Maxime Coquelin"
 <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Chen-Yu Tsai" <wens@kernel.org>, "Samuel
 Holland" <samuel@sholland.org>, "Thierry Reding"
 <thierry.reding@kernel.org>, "Mikko Perttunen" <mperttunen@nvidia.com>,
 "Jonathan Hunter" <jonathanh@nvidia.com>, "Jagan Teki"
 <jagan@amarulasolutions.com>, "Ondrej Jirman" <megi@xff.cz>, "Javier
 Martinez Canillas" <javierm@redhat.com>, "Igor Reznichenko"
 <igor@reznichenko.net>, "Michael Walle" <mwalle@kernel.org>, "Dario
 Binacchi" <dario.binacchi@amarulasolutions.com>, "Jagan Teki"
 <jagan@edgeble.ai>, "Jianhua Lu" <lujianhua000@gmail.com>,
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, "Purism Kernel Team"
 <kernel@puri.sm>, "Jerry Han" <hanxu5@huaqin.corp-partner.google.com>,
 "Joel Selvaraj" <jo@jsfamily.in>, "Icenowy Zheng" <icenowy@aosc.io>,
 "Michael Trimarchi" <michael@amarulasolutions.com>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, "Casey Connolly" <casey.connolly@linaro.org>,
 "Michael Tretter" <m.tretter@pengutronix.de>, "Cristian Cozzolino"
 <cristian_ci@protonmail.com>, "Junjie Cao" <junjie.cao@linux.dev>, "Ryan
 Brue" <ryanbrue.dev@gmail.com>, "Nickolay Goppen" <setotau@mainlining.org>,
 "Stefan Mavrodiev" <stefan@olimex.com>, "Florian Fainelli"
 <florian.fainelli@broadcom.com>, "Broadcom internal kernel review list"
 <bcm-kernel-feedback-list@broadcom.com>, "Robert Chiras"
 <robert.chiras@nxp.com>, "Alexander Koskovich" <akoskovich@pm.me>, "Markuss
 Broks" <markuss.broks@gmail.com>, "Artur Weber" <aweber.kernel@gmail.com>,
 "David Heidelberg" <david@ixit.cz>, "Dzmitry Sankouski"
 <dsankouski@gmail.com>, "Yedaya Katsman" <yedaya.ka@gmail.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 00/35] drm/panel: let the panels use the atomic state
X-Mailer: aerc 0.22.0
References: <20261026-drm-panel-funcs-v1-0-5e3070a3478f@oss.qualcomm.com>
 <cxsgo7u2hfb4jskscqcbeaaneiyfh7bdmlvku2wxwtduekwhxz@3vsizgxvekw7>
In-Reply-To: <cxsgo7u2hfb4jskscqcbeaaneiyfh7bdmlvku2wxwtduekwhxz@3vsizgxvekw7>
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dmitry,

On Tue Oct 27, 2026 at 1:02 PM CET, Dmitry Baryshkov wrote:
> On Mon, Oct 26, 2026 at 01:09:49PM +0200, Dmitry Baryshkov wrote:
>> The panel is the only element of the display pipeline which never sees
>> the atomic commit. Its prepare() and enable() callbacks get nothing but
>> the panel, so a panel which has to be programmed differently depending
>> on the mode can only guess it. The NT35950 driver, for example, saves
>> the connector in get_modes() and reads connector->state->crtc->state
>> while being prepared: without the locks, from the current state rather
>> than from the one being committed, and with no way to reject a mode it
>> doesn't know.
>>
>> Every panel has a struct drm_bridge embedded into it, and the bridge
>> already has all the missing parts: atomic_check(), a state object which
>> can be subclassed and the commit passed to the callbacks. Rather than
>> growing struct drm_panel_funcs into a copy of that, let the panel driver
>> provide struct drm_bridge_funcs for the embedded bridge. This is opt-in:
>> the panels which have no use for the atomic state keep using struct
>> drm_panel_funcs and are not touched by it.
>>
>> To get there the bridge callbacks become the entry point to the panel,
>> with drm_panel_prepare() and friends calling them rather than the other
>> way around. The panel core still has to track the panel state, notify
>> the panel followers and handle the backlight, so the driver doesn't fill
>> in the power callbacks directly, it wraps its functions with the macros
>> doing that part. NT35950 is converted as the first user.
>>
>> The bulk of the series is the cleanup of what the panel core and the
>> bridge need from the panel driver, so that a panel providing the bridge
>> callbacks doesn't need struct drm_panel_funcs for anything:
>>
>> - get_timings() had no callers.
>>
>> - The connector type was stored both in the panel and in its bridge, and
>>   the display drivers could override it while creating the panel bridge.
>>
>> - The orientation was read from the DT, stored and returned by nearly
>>   identical code in more than twenty panel drivers, and some of them
>>   also had to set it on the connector from get_modes(), with a TODO
>>   asking for a better place. The core reads it now. It is applied to the
>>   connector from the new connector_init() bridge callback, which is not
>>   specific to the panels: other bridges have properties to set up on the
>>   connector being created too (HDCP, DP link properties), and currently
>>   have nowhere to do it.
>>
>> - disable() and unprepare() returned an error which nobody could act on.
>>   Worse, a failed unprepare() left the panel marked as prepared, so it
>>   was never initialised again.
>>
>> Behaviour changes worth knowing about:
>>
>> - Panels with the rotation property whose driver ignored it now get the
>>   orientation property. In the tree this is the Motorola Mapphone panel
>>   (panel-dsi-cm).
>>
>> - sun6i_mipi_dsi, sti_dvo and the Tegra DSI get their panel after the
>>   DRM device has been registered, which is too late to create the
>>   property, so they lose the orientation which the panel drivers used to
>>   set from get_modes(). None of the rotated panels in the tree are used
>>   with them.
>>
>> - A panel implementing atomic_check() can only be driven through the
>>   bridge chain. The display drivers calling drm_panel_prepare() directly
>>   have no commit to pass.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
>> Dmitry Baryshkov (35):
>>       drm/panel: remove the get_timings() callback
>>       drm/panel: remove the unused struct panel_bridge
>>       drm/tidss: get the panel type from the embedded bridge
>>       drm/bridge: lvds-codec: use devm_drm_panel_bridge_add()
>>       drm/ingenic: use devm_drm_panel_bridge_add()
>>       drm: mxsfb: use devm_drm_panel_bridge_add()
>>       drm: rcar-du: use devm_drm_panel_bridge_add()
>>       drm: rz-du: use devm_drm_panel_bridge_add()
>>       drm/mcde: use drm_panel_bridge_add()
>>       drm/pl111: use drm_panel_bridge_add()
>>       drm/rockchip: lvds: use drm_panel_bridge_add()
>>       drm/rockchip: rgb: use drm_panel_bridge_add()
>>       drm/panel: remove the _typed() panel bridge functions
>
> Gmail barked at me for sending too many emails for too many recipients
> in the middle of the series. I guess, I'll have to split the series into
> smaller parts. Please consider reviewing the posted patches, letting me
> split / land the series in parts.

The first 13~14 patches are nice and fairly independent cleanups. I guess
they can be sent separately, or just be applied. However I'd still want to
review patch 14 and do some testing next week before I consider them ready
for applying.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

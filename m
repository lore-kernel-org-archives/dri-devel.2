Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63990606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zs+kdfNJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11451125DF;
	Fri, 13 Nov 2026 14:35:07 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 733031124F8
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 14:35:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B9AE462788
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 14:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7378E1F000CB
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 14:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794580499;
 bh=PF7x+WHFDlFjFzclJMmi7Uvb2yYXpjZa21XSXBNN68Y=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=Zs+kdfNJoLMkl/WkGe794yJ/6X4epq2Y0S9osHqwtoywyGWWo5acUIiHSXv04wbm7
 jT/Lpt5RBcdJ4H/5KDckMWd11BZlN7NY3J7Kg4iq8zkmjv3UmtVQtTTmcZMdsogjpK
 /1Ix/X/H1c1uvRoR9KuN41hX+QgC/q+/2BNBCz7ObiJCI0w4gNTmmxdBrBdzTVUyF7
 HnaUrlhe6B3NCHoXhN4Wqcuj0NTPB0p51y5t28+X1h+4dJZJZlYqqyXqKnErGu3tCE
 IT+KTIx9lAc5aSvhJMluLkZ+uS5+IzI807cN03nbgP9G38DTbnXDsJDnODPry9L/NQ
 3PZRqmJoROLXA==
Received: by mail-oo1-f51.google.com with SMTP id
 006d021491bc7-704597ef1d8so355507eaf.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 06:34:59 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErETX2Jf7CcQLNBX4FBNTZGsSjw+AAx+0q1aRH+N7ZnXzf4f5cfYejWWnKDgLGt+Tgsx82ZX2nnsKLM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+YjaaA47n0dHS5zhj2oEHh1p8jwSuTYcPY/fGi9RnKasfmhq8q
 vXfTVvVOpyu0k6EYBZSC3dUlG2QYkSH/h6lfb1ogmsdNxexzsSFWIy+I/fwZkw5SfRIHaACdYHy
 bR2Vx4roEjOPjOC+y8imSZyuUYZjzsRs=
X-Received: by 2002:a05:6820:238b:b0:6f4:d9d4:3948 with SMTP id
 006d021491bc7-71ab50535a7mr1136848eaf.45.1794580497611; Fri, 13 Nov 2026
 06:34:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026-drm-panel-funcs-v1-0-5e3070a3478f@oss.qualcomm.com>
 <20261026-drm-panel-funcs-v1-22-5e3070a3478f@oss.qualcomm.com>
In-Reply-To: <20261026-drm-panel-funcs-v1-22-5e3070a3478f@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 13 Nov 2026 15:34:42 +0100
X-Gmail-Original-Message-ID: <CAD++jLmME3b35ipG0N9agoe+5P1J6dsDiy3hoT9MJ9vyRwBA7A@mail.gmail.com>
X-Gm-Features: AclHuK879_MUVY4wh3-oLFktJApN7IrvQSuSi80dujOkyN3zJSTWDVcOyRF70LI
Message-ID: <CAD++jLmME3b35ipG0N9agoe+5P1J6dsDiy3hoT9MJ9vyRwBA7A@mail.gmail.com>
Subject: Re: [PATCH 22/35] drm/panel: drop the orientation workaround from
 get_modes()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Paul Cercueil <paul@crapouillou.net>, Marek Vasut <marex@denx.de>,
 Stefan Agner <stefan@agner.ch>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Alison Wang <alison.wang@nxp.com>, Paul Kocialkowski <paulk@sys-base.io>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Ondrej Jirman <megi@xff.cz>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Igor Reznichenko <igor@reznichenko.net>, 
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Jagan Teki <jagan@edgeble.ai>, Jianhua Lu <lujianhua000@gmail.com>, 
 =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Purism Kernel Team <kernel@puri.sm>,
 Jerry Han <hanxu5@huaqin.corp-partner.google.com>, 
 Joel Selvaraj <jo@jsfamily.in>, Icenowy Zheng <icenowy@aosc.io>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Tretter <m.tretter@pengutronix.de>, 
 Cristian Cozzolino <cristian_ci@protonmail.com>,
 Junjie Cao <junjie.cao@linux.dev>, 
 Ryan Brue <ryanbrue.dev@gmail.com>, Nickolay Goppen <setotau@mainlining.org>, 
 Stefan Mavrodiev <stefan@olimex.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Robert Chiras <robert.chiras@nxp.com>, Alexander Koskovich <akoskovich@pm.me>, 
 Markuss Broks <markuss.broks@gmail.com>, Artur Weber <aweber.kernel@gmail.com>,
 David Heidelberg <david@ixit.cz>, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Yedaya Katsman <yedaya.ka@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 12:11=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:

> Setting the orientation from get_modes() was a stopgap for the display
> drivers not calling drm_connector_set_orientation_from_panel(). It is
> also too late: by then the connector is registered and the property can
> no longer be attached properly.
>
> drm_bridge_connector and the panel bridge set the orientation on their
> own, and the drivers using a panel directly do it when creating the
> connector now. The exceptions are sun6i_mipi_dsi, sti_dvo and the Tegra
> DSI, which get the panel only after the DRM device has been registered.
> None of the in-tree boards using them has a rotated panel.
>
> Assisted-by: LLM
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Makes sense.
Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

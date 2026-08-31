Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8DBC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 07:37:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2241F10EBAB;
	Tue,  1 Sep 2026 07:37:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fa7a1Q3Y";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D54310E858;
 Mon, 31 Aug 2026 13:36:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9A17F60215;
 Mon, 31 Aug 2026 13:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016D61F000E9;
 Mon, 31 Aug 2026 13:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788183394;
 bh=3d2wE4iPk/eSRIKBUJMr1Vert2gthTCrW2UXhnx95p4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Fa7a1Q3YoUsfdoMvZbQAiBxdeh/TNaAy2cWmN+gHJtD0G5fAKj07cg5+8PsqlLHGz
 A1PAQuTvFk3cBiBuBnU9BX06M7lLnfqiM9pOLnHs/A2YOWF6hTp4V8VTsE2c/GmSFo
 URF1s+nDBwrxxWO45AdqLpYaq6wzMJThp7iMOVVQEGXgXFPN8CtiP/WnqMUZqdnyKW
 EQDpd7/10qJ2kUHSiXAJKr/GRWQLdNSiDsyIUkC44uOO8x+JESPpssnyKwOnT03CZH
 1TMqMRafZA0VRWtpwFEEpq9yiXTseAFhl04jX5wKhiXF3DXtIzYeLnD80tcC/prJs1
 YmW1jKy9yiPhA==
Date: Mon, 31 Aug 2026 15:36:29 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Janne Grunau <j@jannau.net>, 
 Sasha Finkelstein <k@chaosmail.tech>, asahi@lists.linux.dev, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org, Liviu Dudau <liviu.dudau@arm.com>, 
 Russell King <linux@armlinux.org.uk>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, linux-samsung-soc@vger.kernel.org, 
 Alison Wang <alison.wang@nxp.com>, Stefan Agner <stefan@agner.ch>, 
 Ruben Wauters <rubenru09@aol.com>, Tian Tao <tiantao6@hisilicon.com>, 
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Yongbang Shi <shiyongbang@huawei.com>, 
 John Stultz <jstultz@google.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Xinliang Liu <xinliang.liu@linaro.org>, Yongqin Liu <yongqin.liu@linaro.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Saurabh Sengar <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
 Fabio Estevam <festevam@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Liu Ying <victor.liu@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, imx@lists.linux.dev, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, 
 Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org, 
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Paul Kocialkowski <paulk@sys-base.io>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Dmitry Baryshkov <lumag@kernel.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 freedreno@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, Marek Vasut <marex@denx.de>,
 Dave Airlie <airlied@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, spice-devel@lists.freedesktop.org, 
 virtualization@lists.linux.dev, Geert Uytterhoeven <geert+renesas@glider.be>, 
 linux-renesas-soc@vger.kernel.org,
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Orson Zhai <orsonzhai@gmail.com>, Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 linux-sunxi@lists.linux.dev, Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Aditya Garg <gargaditya08@proton.me>, 
 Aun-Ali Zaidi <admin@kodeit.net>, LiangCheng Wang <zaq14760@gmail.com>, 
 Alex Lanzano <lanzano.alex@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, Chia-I Wu <olvaffe@gmail.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Michal Simek <michal.simek@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, Jocelyn Falempe <jfalempe@redhat.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Dharma Balasubiramani <dharma.b@microchip.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Huacai Chen <chenhuacai@kernel.org>, Jianmin Lv <lvjianmin@loongson.cn>, 
 Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Xi Ruoyao <xry111@xry111.site>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Magnus Damm <magnus.damm@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Sandy Huang <hjc@rock-chips.com>, 
 linux-rockchip@lists.infradead.org, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 Thierry Reding <thierry.reding@kernel.org>, linux-tegra@vger.kernel.org, 
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <melissa.srw@gmail.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Zack Rusin <zack.rusin@broadcom.com>
Subject: Re: [PATCH 00/70] drm/crtc: Convert all drivers to
 atomic_create_state and remove reset
Message-ID: <apWDRq8YOTwvGuSf@houat>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="eainbiqt42xdkeio"
Content-Disposition: inline
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:36:10 +0000
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


--eainbiqt42xdkeio
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 00/70] drm/crtc: Convert all drivers to
 atomic_create_state and remove reset
MIME-Version: 1.0

On Fri, Aug 21, 2026 at 04:38:36PM +0200, Maxime Ripard wrote:
> This is a follow-up to the plane reset removal series, and part of a
> larger effort to remove the reset hook from all KMS objects.
>=20
> The CRTC reset hook is overloaded: it is called both at probe time to
> create the initial software state and during suspend/resume to reset
> hardware and software state. These two roles have different
> requirements, and the reset hook is not fallible, making error
> handling difficult for the initial state allocation path.
>=20
> While reset has the semantics to reset both the software and hardware
> state, the vast majority of implementations and all the helpers only
> reset the software state, making them equivalent to
> atomic_create_state in practice. The atomic_create_state hook makes
> this explicit: it only allocates and initializes a pristine state
> without any side effect, and returns the state pointer or an ERR_PTR
> on failure.
>=20
> This series converts all CRTC drivers tree-wide from the reset hook to
> atomic_create_state, then removes the reset hook from struct
> drm_crtc_funcs entirely. Two drivers (tilcdc and loongson) had actual
> hardware reset logic mixed into their reset hook; those are moved to
> CRTC creation instead. The conversions were done using a combination of
> Coccinelle semantic patches and manual adjustments.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>


Applied patches 1,3-14,16-28,31-41,43,45-49,52-62,64-68 to drm-misc-next

Maxime

--eainbiqt42xdkeio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCapWDXQAKCRAnX84Zoj2+
dtnDAYDvbcHtYOX7CuJCyNGSb99Ed+Livj62dMg0nsp864oeIMVzqxGBJIKgPp8Z
RCHnUyUBfAxvXYJDr3LaH94QifMoTvJPOgPapZRwWXp6VAygmOgZF8WFxC9cEp2h
0/QjaJymHA==
=mCUP
-----END PGP SIGNATURE-----

--eainbiqt42xdkeio--

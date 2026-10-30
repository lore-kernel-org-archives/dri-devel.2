Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721B3606A320
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=McnVzDrA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C493010E573;
	Fri, 30 Oct 2026 17:45:04 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB59C10E573
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=6g5elUdeGVozBVRB/uIpu9t+eT/QLwJb6+mCEOi3sU0=; b=McnVzDrABheU2AO7yOCTA46Wnj
 OQAwr+mr7ut6IbkprUPAK3ZO73I8BNz6LgFRR0aLlWHWPdUxhqs+MyYI9QPusA0ppO9RpQAMByt+5
 kyQi4QZP4qr+kz0nBCHCewJpFTEI6sDQeU3G5eEMsnuLEJk7VMmGugR6rq8fGrfIfJ9B3oBmvF6eP
 zELkXz7C+gAmcKlmoUwpzrhgc3kqCPOPrd9WUA4jiFVAN+rZtcCsCMBRn7kzFI1SitdZDm4XVeYaz
 1U/XNHSlGHiXrIKUKIzzBzY7SNDRlbZHnKrkm6fsARi4ILdgUjZcpjAMO3zBbK/YAQAl2gCTDFylv
 RgxT8d+w==;
From: Heiko Stuebner <heiko@sntech.de>
To: Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Emil Renner Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Dominique Belhachemi <db@domibel.de>, Andy Yan <andyshrk@163.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Yakir Yang <kuankuan.y@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Conor Dooley <conor@kernel.org>, William Qiu <william.qiu@starfivetech.com>,
 Xingyu Wu <xingyu.wu@starfivetech.com>, Sandy Huang <hjc@rock-chips.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Michal Wilczynski <m.wilczynski@samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Maud Spierings <maud_spierings@murena.io>,
 Graham Markall <hello@big-grey.co.uk>,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Joshua Peisach <jpeisach@ubuntu.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v6 02/18] drm/bridge: inno-hdmi: Don't dereference a NULL
 drm_device on hotplug
Date: Fri, 30 Oct 2026 18:44:24 +0100
Message-ID: <2261991.3Lj2Plt8kZ@phil>
In-Reply-To: <1844578.vCJZsxu672@phil>
References: <20261029-jh7110-clean-send-v6-0-759594e43acf@samsung.com>
 <20261029-jh7110-clean-send-v6-2-759594e43acf@samsung.com>
 <1844578.vCJZsxu672@phil>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am Freitag, 30. Oktober 2026, 18:43:47 Mitteleurop=C3=A4ische Normalzeit sc=
hrieb Heiko Stuebner:
> Am Donnerstag, 29. Oktober 2026, 08:53:36 Mitteleurop=C3=A4ische Normalze=
it schrieb Michal Wilczynski:
> > inno_hdmi_irq() passes hdmi->bridge.dev to drm_helper_hpd_irq_event(),
> > which dereferences it in its first statement:
> >=20
> > 	if (!dev->mode_config.poll_enabled)
> >=20
> > bridge.dev is assigned only by drm_bridge_attach(), but inno_hdmi_bind()
> > unmutes the hotplug interrupt in inno_hdmi_init_hw() and installs the
> > handler well before it attaches the bridge:
> >=20
> > 	inno_hdmi_init_hw(hdmi);		/* unmutes hotplug */
> > 	devm_request_threaded_irq(...);		/* handler goes live */
> > 	...
> > 	hdmi->bridge.ddc =3D inno_hdmi_i2c_adapter(hdmi);
> > 	devm_drm_bridge_add(dev, &hdmi->bridge);
> > 	drm_bridge_attach(...);			/* bridge.dev set here */
> >=20
> > The bridge is allocated by devm_drm_bridge_alloc(), which kzalloc()s it,
> > so bridge.dev is NULL for all of that window, and a hotplug event
> > arriving in it enters drm_helper_hpd_irq_event(NULL).
> >=20
> > Before the conversion to a bridge the ordering was safe:
> > inno_hdmi_register() called drmm_connector_hdmi_init(), which set
> > connector.dev, before the interrupt was requested.
> >=20
> > Drop hotplug events that arrive before the bridge is attached.
> >=20
> > Fixes: 969325a2597e ("drm/rockchip: inno-hdmi: Convert to drm bridge")
> > Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> > ---
> >  drivers/gpu/drm/bridge/inno-hdmi.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridg=
e/inno-hdmi.c
> > index d7c33b92e2ddf4ced84d17304463f44be52270b8..d29832249b942dec84fb9d0=
7a0b21ee751fc0486 100644
> > --- a/drivers/gpu/drm/bridge/inno-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/inno-hdmi.c
> > @@ -929,7 +929,13 @@ static irqreturn_t inno_hdmi_irq(int irq, void *de=
v_id)
> >  {
> >  	struct inno_hdmi *hdmi =3D dev_id;
> > =20
> > -	drm_helper_hpd_irq_event(hdmi->bridge.dev);
> > +	/*
> > +	 * The interrupt is requested before the bridge is attached, and
> > +	 * bridge.dev is only set by drm_bridge_attach(). Drop hotplug events
> > +	 * that arrive before then rather than dereference a NULL drm_device.
> > +	 */

nit: I don't think that huge comment is necessary for that


> > +	if (hdmi->bridge.dev)
> > +		drm_helper_hpd_irq_event(hdmi->bridge.dev);
>=20
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>=20
> Most other callers of drm_helper_hpd_irq_event() also do exactly this.
>=20
>=20
> Heiko
>=20





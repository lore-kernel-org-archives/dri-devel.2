Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF89C98311
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 08:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C19910E8EE;
	Thu, 24 Sep 2026 08:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y66Nn1F7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C245010E178;
 Thu, 24 Sep 2026 08:57:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 795ED43454;
 Thu, 24 Sep 2026 08:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAFF1F00893;
 Thu, 24 Sep 2026 08:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790240248;
 bh=KsfA+7ZRfaMaOYHf9FLzqm+87QxZc0nf8pdVelteCEk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Y66Nn1F70+EOrXieRS0criFH3uxMANVUI7oanFcCoy8GmyXIy+pJT4bYVlm/thmPG
 N7qIdDiz1YmSsvWNdouFIMEZW4BAqVieOEmxdbjyjg8VeCwPdmNl98xvvOpohxm65Y
 GyNzGB6Z7BI3y56gBKntItSCJRjU51zGLLQXLvZnr16k3FQ6buDS49+J1C+07Q9T63
 n6nHxyci7fO61wmUlSLUGoMKJe5Tmzp5UMO6z0QysEePeglKrYmnlnSTGRtL4Xmc0R
 znGcbePU3j8NmjIOaR7E0m14ncuBzwafBVjkGLhSAzXI59gpYQZewywAESCZXVQDnZ
 5vqxv1raD/1Pw==
Date: Thu, 24 Sep 2026 10:57:24 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>, 
 Paul Kocialkowski <paulk@sys-base.io>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sean Paul <sean@poorly.run>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Albert Esteve <aesteve@redhat.com>, Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
 linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, asahi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 12/19] drm/mcde: dsi: don't create a panel_bridge
Message-ID: <arTlpd-KAsVpj3UH@houat>
References: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
 <20260916-drm-bridge-every-panel-v3-12-83afb4f1a707@bootlin.com>
 <arInho2bsfJiCgjV@houat> <DLNCQEG62F5N.O98WAO4U2FJO@bootlin.com>
 <CAD++jLkk-a0MrQUiaDD8OoDDoYVwBwSjFTj5ZBy=Xo7MS4+01g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="fta6xv3zcvscpec2"
Content-Disposition: inline
In-Reply-To: <CAD++jLkk-a0MrQUiaDD8OoDDoYVwBwSjFTj5ZBy=Xo7MS4+01g@mail.gmail.com>
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


--fta6xv3zcvscpec2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 12/19] drm/mcde: dsi: don't create a panel_bridge
MIME-Version: 1.0

On Thu, Sep 24, 2026 at 09:51:53AM +0200, Linus Walleij wrote:
> Hi Luca,
>=20
> sorry for my slowness!
>=20
> On Thu, Sep 24, 2026 at 9:01=E2=80=AFAM Luca Ceresoli <luca.ceresoli@boot=
lin.com> wrote:
> > On Tue Sep 22, 2026 at 9:09 AM CEST, Maxime Ripard wrote:
>=20
> > >> -    } else if (bridge) {
> > >> +    if (!bridge) {
> > >> +            dev_err(dev, "no bridge\n");
> > >> +            return -ENODEV;
> > >> +    } else if (!drm_bridge_is_panel(bridge)) {
> > >>              /* TODO: AV8100 HDMI encoder goes here for example */
> > >>              dev_info(dev, "connected to non-panel bridge (unsupport=
ed)\n");
> > >>              return -ENODEV;
> > >
> > > I wonder if we still need that branch. Every panel is a bridge now, a=
nd
> > > it looks like we don't have any specific panel handling in this drive=
r,
> > > so I guess it supports bridges already?
> > >
> > > Linus, do you know why this condition was here in the first place?
> >
> > I had the same thought while writing the patch, but I chose to be
> > conservative.
> >
> > Linus, unless you have more info I'm going to apply the patch as
> > is. Removing this special case would be welcome as a later patch.
>=20
> I'd say go ahead as-is.

I'm fine with that, but I really want this removed at some point.

> I do have the idea to code up and submit the AV8100 encoder
> and I have the hardware to test it, but every other user should
> be using panels directly, and I would be the only non-panel
> user so I can deal with it when it comes up.

It won't change a thing. All existing "panel" users will be bridge users
after this patch is merged. So whether you want to enable a bridge or
not shouldn't matter, the only thing that does is whether the existing
users would still work.

Maxime

--fta6xv3zcvscpec2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCarTl8wAKCRAnX84Zoj2+
dhwWAXwI9qMs84ZRfc2g48IeAyQiE/CtbfMWnKHKCoJcY62gOn2KtPtJlfAUSVSt
Fz2FzIoBf1P/bkrhzAS0uao6/CjJ0F2xh689BoYPK8a7rDMJeckpdh6Df4f795pW
2kQWWS2bNQ==
=k5VA
-----END PGP SIGNATURE-----

--fta6xv3zcvscpec2--

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7273C9832F
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 15:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D39F10E162;
	Sat, 26 Sep 2026 15:15:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YMbXDXzo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2457510E0FA;
 Sat, 26 Sep 2026 15:15:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AE8E16020C;
 Sat, 26 Sep 2026 15:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E0A1F000FF;
 Sat, 26 Sep 2026 15:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790435702;
 bh=ClVltLSpZXX7kyYoGrs6WXWqQwR9MaJl7aFlqiT71a0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YMbXDXzoGinwjtRaX2S2hqGI03VydgE7flbwKGLsH/D4N25KRqqxdVXEDMU4fUr98
 tixVjYJIraXwbE0CtskCAF0P56zAVnU95MkukV+OofcQ6nmryHDlXUVQbJXVnSS9Pk
 e7HbfqWF8ATzoeQPTpT/atbfJ0COmyrDPM/0vup039dsGZAHBr28PoVXUXUpPsagXe
 mXJbpuvsSWvvZ5fgw9f2V1LqW8EdvORKt55opNL8L4yn8Ol18YZiL2K28+KjVR9nWx
 ZYMhAMxtc9m2OaxvGEucFh3GLQMKwaY369dnBT86mm0NOXbrVyzh89kRPZhdaUrWWv
 uPtirHf7WgA7w==
Date: Sat, 26 Sep 2026 17:14:57 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Linus Walleij <linusw@kernel.org>, 
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
Message-ID: <arfhYxN4y_ZcXsZa@houat>
References: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
 <20260916-drm-bridge-every-panel-v3-12-83afb4f1a707@bootlin.com>
 <arInho2bsfJiCgjV@houat> <DLNCQEG62F5N.O98WAO4U2FJO@bootlin.com>
 <CAD++jLkk-a0MrQUiaDD8OoDDoYVwBwSjFTj5ZBy=Xo7MS4+01g@mail.gmail.com>
 <arTlpd-KAsVpj3UH@houat>
 <CAD++jLmktDoqn2EbXsNnyGRudo-q2NCxUf+9ZjeU+WrY4CBMWw@mail.gmail.com>
 <DLOJIV124RG7.27SOPEOHBTA7W@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="dg3ucg3v26dehzsz"
Content-Disposition: inline
In-Reply-To: <DLOJIV124RG7.27SOPEOHBTA7W@bootlin.com>
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


--dg3ucg3v26dehzsz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 12/19] drm/mcde: dsi: don't create a panel_bridge
MIME-Version: 1.0

On Fri, Sep 25, 2026 at 06:33:15PM +0200, Luca Ceresoli wrote:
> Hello Linus,
>=20
> On Fri Sep 25, 2026 at 6:25 PM CEST, Linus Walleij wrote:
> > On Thu, Sep 24, 2026 at 10:57=E2=80=AFAM Maxime Ripard <mripard@kernel.=
org> wrote:
> >> On Thu, Sep 24, 2026 at 09:51:53AM +0200, Linus Walleij wrote:
> >
> >> > > Linus, unless you have more info I'm going to apply the patch as
> >> > > is. Removing this special case would be welcome as a later patch.
> >> >
> >> > I'd say go ahead as-is.
> >>
> >> I'm fine with that, but I really want this removed at some point.
> >
> > If Luca wanna fix this up (drop this path) that's fine by me,
> > else send a patch immediately after this is applied and I'll
> > ACK it.
>=20
> To avoid postponing this series I plan to apply as is on Monday. I can se=
nd
> another patch later to remove the !panel case.

Works for me :)

Maxime

--dg3ucg3v26dehzsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCarfhbQAKCRAnX84Zoj2+
dgfdAYDG6Hu5i0e526axMly2zcjPr4YeajdmZ6bTC6CCZBd1XimS1nPSmAH1o1Wh
jL7z65EBgJ/BZN2zgzTAR8W15VSdR3qxd4+gFK3Sr3hkGLJSe9YoI6JmUUUSQpXj
edP84d+izQ==
=Inr9
-----END PGP SIGNATURE-----

--dg3ucg3v26dehzsz--

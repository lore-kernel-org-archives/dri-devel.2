Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7650BC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CD2510E5AD;
	Thu, 10 Sep 2026 07:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BDVKmDLC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D250710E5AD
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 07:03:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7F86B40D98;
 Thu, 10 Sep 2026 07:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DD71F000FF;
 Thu, 10 Sep 2026 07:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789023787;
 bh=BjE66fIi8oVDtAizFysavmr+bZc7c8n/oo08K88m1K4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BDVKmDLCWRChAy1YqVvSCzYWbnXSEU+F3ynlxYJVzn86jSmg1e77StTfwHIM9Uifl
 FKHQBtPhAY3cksXljoLCf3gFCfpKc4ItkE5FXvtndZMNIpifOKaK5TiIp2S7AnlwHl
 zlrZQfE1o7llj7Kk+v/RtT09k6LGLqdVQVOPnPFnWWiu6P825T59EJArtA1Ievg6E/
 Hakcz7Qz14r2siSaspysIiVGGHHzPqW8vDKFsu0rkWsDZAdeybyPRD8lbDram2bgVi
 tyDWsYnGIUM3lqKZ8SYZ0zl71O394Xda6iUz1lU2u0HYbCaBcrK33HkNU9VkQd0KdJ
 /JHz7k2Dhm4+Q==
Date: Thu, 10 Sep 2026 09:03:03 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Albert Esteve <aesteve@redhat.com>,
 Anusha Srivatsa <asrivats@redhat.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH RFC v2 05/19] drm/panel: embed a drm_bridge into every
 drm_panel
Message-ID: <aqJWErwY_fjmlbuj@houat>
References: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
 <20260903-drm-bridge-every-panel-v2-5-2ab8ee24538e@bootlin.com>
 <678ddef7e56703d9adffff5c490d4857af515343@intel.com>
 <aqEqx0zBQgmUgwqL@houat>
 <3efb06a30baae6ba1bfcf2be449bf207a30f674d@intel.com>
 <aqFsTzyf1YbQkh6W@houat>
 <f098a1ca30e3ca400b08c909d476a5752c70a6cb@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="wafkbiiq5f6wznzp"
Content-Disposition: inline
In-Reply-To: <f098a1ca30e3ca400b08c909d476a5752c70a6cb@intel.com>
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


--wafkbiiq5f6wznzp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC v2 05/19] drm/panel: embed a drm_bridge into every
 drm_panel
MIME-Version: 1.0

On Wed, Sep 09, 2026 at 06:57:44PM +0300, Jani Nikula wrote:
> On Wed, 09 Sep 2026, Maxime Ripard <mripard@kernel.org> wrote:
> > On Wed, Sep 09, 2026 at 05:02:58PM +0300, Jani Nikula wrote:
> >> On Wed, 09 Sep 2026, Maxime Ripard <mripard@kernel.org> wrote:
> >> > I really wish i915 was at least *trying* to fit within the larger mo=
del
> >> > basically everybody else uses. I understand that it's a large
> >> > undertaking and regression prone and everything, but I'm also concer=
ned
> >> > about having the "we can't because of i915" or "supported by everybo=
dy
> >> > else but i915" on a regular basis now.
> >>=20
> >> Okay, let's hear it, please name a few things where i915 is alone in
> >> doing something bonkers that amd, radeon, nouveau also don't do, and
> >> what would be the changes that would bring i915 closer to everybody
> >> else?
> >
> > Where did I say "bonkers"?
> >
> > But since you're asking, because it doesn't implement .reset, we had th=
at
> > conversation this week for
> >
> > https://lore.kernel.org/r/20260908-drm-reset-state-flag-v3-0-905570f387=
a4@kernel.org
>=20
> You mean struct drm_crtc_funcs .reset?

I mean plane, crtc, and connector reset

--wafkbiiq5f6wznzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaqJWIwAKCRAnX84Zoj2+
dlkTAYDVOHUF/N9L+RFbNoev1fEP7OCnQrVi6ZTc6m/uPoVZcfy217psBAVtpY28
DuG53wUBfj8azW2PtL8IVoQFustkgTcns9ffqCfvvamzGt3FZay1o4hPp+PdliFZ
JmWCqrhsIw==
=1ICA
-----END PGP SIGNATURE-----

--wafkbiiq5f6wznzp--

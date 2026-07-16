Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F68C44511
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A3C810E0F7;
	Thu, 16 Jul 2026 16:04:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="w2jaaP8L";
	dkim-atps=neutral
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A4D310E303
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 16:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1784217835; x=1784477035;
 bh=/YRB1L/AuOqVWGx1DDUcS5pWizMxt/oyDC51hnogQgg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=w2jaaP8LYwYHiGkyrLMhdz7gldUws3K2xMX34Qj5WZ0OJ2/6oun8jF3tde9qyhnf8
 JOwJaZ2Zxm42bHUoSgwKPvLOuH6k4UWRIlxx7vh+2dC3y42HsyCCFYx4U5aQ1uFwAI
 Yncc9rs5mQvwrnEkFhkd/gKFs1bN76WVkDsOI6bOSWLAtsc2KhAsVAby8apD6p//AY
 Na4V7OMEtRs4eLEqebePhW61gZwmE4uKRTFrvf6EAQptKTsxe+9xs3NuJ02Krf8c94
 TsdTS8/YsoNHn9icZsCuoLxJXLnqn+9tBUrWI4JTZHYlPR0zEi5tGK3Mka1d3zvYlX
 jtnKx68KZGogw==
Date: Thu, 16 Jul 2026 16:03:49 +0000
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
From: Esben Haabendal <esben@geanix.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Linus Walleij <linusw@kernel.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm/bridge: ti-sn65dsi83: Support LVDS Channel B
 on SN65DSI84
Message-ID: <8SgSn8BXZAxJ8Pj2MJVVpzkmvK0_xII-D_cs86jsXDPC0LxlvGuDXozzxKLQC58S48HUCD4MkrAP_trxtZNRIk9fOoyMeQEEiW9yfkTB4bo=@geanix.com>
In-Reply-To: <178421534409.28815.14030419996947306239.b4-review@b4>
References: <20260715-ti-sn65dsi83-fixes-v2-0-ebc4c3fe29b6@geanix.com>
 <20260715-ti-sn65dsi83-fixes-v2-3-ebc4c3fe29b6@geanix.com>
 <178421534409.28815.14030419996947306239.b4-review@b4>
Feedback-ID: 133791852:user:proton
X-Pm-Message-ID: 71927c117d3272524a1014b6bdfe834fd294a696
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Thursday, 16 July 2026 at 17:22, Luca Ceresoli <luca.ceresoli@bootlin.co=
m> wrote:
> On Wed, 15 Jul 2026 15:10:33 +0200, Esben Haabendal <esben@geanix.com> wr=
ote:
>=20
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/br=
idge/ti-sn65dsi83.c
> > index 7e73035d7798..02ae2b8179b0 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> > @@ -893,6 +895,7 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx=
, enum sn65dsi83_model model)
> >  {
> >  =09struct drm_bridge *panel_bridge;
> >  =09struct device *dev =3D ctx->dev;
> > +=09u32 panel_port =3D 2;
>=20
> Thanks for having applied the changes I had suggested.
>=20
> I'm afraid I realized right now the "panel_port" name is not ideal becaus=
e
> there could be another bridge at the output port and not directly a
> panel. Should you have a reason to send a v3 I'd rename to output_port (a=
nd
> keep my R-by if that's the only change). Otherwise I can do it while
> applying the patch.

What about the panel_bridge member of struct sn65dsi83? We use
panel_port/output_port as argument to devm_drm_of_get_bridge() and assign t=
he
bridge we get from that to ctx->panel_bridge. So are you sure that it makes
sense to rename panel_port to output_port? Or do you want to rename the
panel_bridge member also?

/Esben

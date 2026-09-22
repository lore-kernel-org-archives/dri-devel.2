Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659B1C982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9361A10E204;
	Tue, 22 Sep 2026 13:22:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RqS0wZ6M";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5857E10ECCA;
 Tue, 22 Sep 2026 13:22:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F0A994068C;
 Tue, 22 Sep 2026 13:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543431F000FF;
 Tue, 22 Sep 2026 13:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790083332;
 bh=izoFKgiwl1CtFCyEIjGCaDfq4nQekOb5nh2FLPhllwE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RqS0wZ6MEt5bZk9R+eKNjlRNCmWaNssWnIKblwHEVt1yhxX+ze4qRQgSdijlnk+u9
 x0uj7BswFEX76KgX7c17GHgRy4Qckx0Sx/PiiC1Eb0ER625jj/erLNU2xNNe6T/ltx
 V2RiRRALLcVkKzNnXsV3FaSSjjAT03Tf6Ho6/htzaKLwBoA7DXu/HOLeogcfu1cYal
 /IaGMln+Avhf92NI250562x/Cv22XLM8bnqAYK28Am/fhb5I4fg6WoukQ8LWNad5Ef
 TG8T8MTKfFhq+I45jEqJxtY1TVTGkcKwY3zEkKGZ3sZNnz99fz/nBT+HBhc8F/WX9L
 sj2D32JDkes8Q==
Date: Tue, 22 Sep 2026 15:22:09 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Daniel Stone <daniels@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Leo Li <sunpeng.li@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com, Derek Foreman <derek.foreman@collabora.com>,
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH RFC 03/25] drm/atomic-helper: Set mode_changed on
 vrr_enabled change
Message-ID: <arKAv_CPpmYmcWeg@houat>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-3-2fcd7d011646@collabora.com>
 <75b82a61-fe82-4597-bfb5-3c717fbb0dda@amd.com>
 <XpLMHDHXSDOKXXVsZyU9Pg@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="uykltmdeqp3cwq6a"
Content-Disposition: inline
In-Reply-To: <XpLMHDHXSDOKXXVsZyU9Pg@collabora.com>
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


--uykltmdeqp3cwq6a
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 03/25] drm/atomic-helper: Set mode_changed on
 vrr_enabled change
MIME-Version: 1.0

On Tue, Sep 22, 2026 at 02:53:36PM +0200, Nicolas Frattaroli wrote:
> On Monday, 21 September 2026 23:59:11 Central European Summer Time Leo Li=
 wrote:
> > Hi Nicholas,
> >=20
> > Thanks for sending this out. I'm looking into an amdgpu implementation
> > and had some comments along the way. Will reply inline on respective
> > patches.
> >=20
> > On 2026-09-21 11:51, Nicolas Frattaroli wrote:
> > > A change in whether VRR is enabled or not on a CRTC will be of intere=
st
> > > to any VRR implementation, as they may need to recalculate certain
> > > internal state in response. So far, this was handled ad-hoc in the
> > > drivers that implement VRR.
> > >=20
> > > Handle this in the common DRM atomic core by setting the mode_changed
> > > flag when this occurs. The rationale for using mode_changed is that V=
RR
> > > is deeply intertwined with the current mode with regards to its timin=
g.
> > > Consequently, any component that cares about a mode change is likely
> > > also going to care about VRR being enabled/disabled.
> > >=20
> > > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > > ---
> > >  drivers/gpu/drm/drm_atomic_helper.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/dr=
m_atomic_helper.c
> > > index 9d006f98413a..0664d5779282 100644
> > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > @@ -694,6 +694,12 @@ drm_atomic_helper_check_modeset(struct drm_devic=
e *dev,
> > >  			new_crtc_state->active_changed =3D true;
> > >  		}
> > > =20
> > > +		if (old_crtc_state->vrr_enabled !=3D new_crtc_state->vrr_enabled) {
> > > +			drm_dbg_atomic(dev, "[CRTC:%d:%s] VRR changed\n",
> > > +				       crtc->base.id, crtc->name);
> > > +			new_crtc_state->mode_changed =3D true;
> > > +		}
> > > +
> >=20
> > I don't think this is the case for all hardware, at least not for amdgp=
u.
> > The parts in HW that adjust vtotal can be programmed without requiring
> > bandwidth recalculations or reprogramming of pipes.
>=20
> Thanks for pointing this out. I was already unsure of this patch before,
> and I don't think Rockchip requires these recalculations either. Original=
ly
> I added this when I looked at the i915 code iirc and saw them setting it.
>=20
> I think in the commit message I also conflate needing to know about VRR
> being changed with needing to do a full modeset (which is what mode_chang=
ed
> basically means).
>=20
> I'll drop this patch on the next revision.

Alternatively, and since we only have a single driver enabling it (for
now), I don't think having some driver specific code for now to handle
all this is that bad.

Helpers only really make sense when we start sharing code between
drivers.

Maxime

--uykltmdeqp3cwq6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCarKBAQAKCRAnX84Zoj2+
dr15AYDf1hNAd+Ezbcn8fIQsts+wOtJnh9OA7o3i3CrBbW3rDk1DvSW+ygwNh/8m
JmlcHmIBgNLrS0a12gMnSBzONESp+jiggI5QHHajSk3lv1hURiQQRSX119tAwssZ
27Cpd/5zRw==
=xdA0
-----END PGP SIGNATURE-----

--uykltmdeqp3cwq6a--

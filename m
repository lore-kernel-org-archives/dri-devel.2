Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4137C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 09:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFAF610F4A0;
	Thu,  3 Sep 2026 09:44:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cV+4jopX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42ACD10F4A0
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 09:44:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AA8BD438A0;
 Thu,  3 Sep 2026 09:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CC81F000E9;
 Thu,  3 Sep 2026 09:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788428684;
 bh=BPIrzGXFmYZL8iESiUY0g2CdGvAzJs2/CqbLP3w0BY0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cV+4jopXQqF1iiDCAQD3G7L2xjP67etsD/rBK76YdP9Ysxz/nDhnLbYk+AZT79CFU
 U+VUCENcNmgkaFSpWt6HGoAiSl5Irj08IUXOZWBv7GDIXCsrQ+AKQ0ZpBVsJeXKZvQ
 Tuea08Y0Zkx5oHowcTwqA6By15+zJ968Y5gZQqGqHBXS+38aFInrNYjT1vCMwoUk2y
 6uvX5Tdxg6jYqq6Ja7ncfHKv1+/8/Fi08Og/KDoWMm6CxXuUp/hX8aUv8r0Gg3xbJB
 LBjLekLfAlo+8F+NJB+bsGbqy7IQm2OifHh+K5PwoXaNSu+0s5h0lfk9lZF/+dMLyO
 hU8CseuEmc1LQ==
Date: Thu, 3 Sep 2026 11:44:41 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Linus Walleij <linusw@kernel.org>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] drm/panel: merge the drm_kms_helper module into
 the drm module
Message-ID: <aplA6Q2yfp5Tdchs@houat>
References: <DKR7VTBLRBQW.2LLJMDO74KXNO@bootlin.com>
 <20260824-cuddly-aardwark-of-reward-0d93d4@houat>
 <DKX8KDDOTPM7.3OS616IO3E4UA@bootlin.com> <apBGjqt9GI5egQW6@houat>
 <DL3ZJBN3TALE.XBW7KL51XGBO@bootlin.com>
 <DL41VXI6IT94.CXUS4CYX1WJO@bootlin.com> <apgW0P4drLEZUB7s@houat>
 <DL4VJG42D5IG.32LF3WUGUPSOI@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="wd77ieiavvmjfjnc"
Content-Disposition: inline
In-Reply-To: <DL4VJG42D5IG.32LF3WUGUPSOI@bootlin.com>
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


--wd77ieiavvmjfjnc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 04/11] drm/panel: merge the drm_kms_helper module into
 the drm module
MIME-Version: 1.0

On Wed, Sep 02, 2026 at 03:44:55PM +0200, Luca Ceresoli wrote:
> Hi Maxime,
>=20
> On Wed Sep 2, 2026 at 2:36 PM CEST, Maxime Ripard wrote:
> > On Tue, Sep 01, 2026 at 04:30:40PM +0200, Luca Ceresoli wrote:
> >> On Tue Sep 1, 2026 at 2:40 PM CEST, Luca Ceresoli wrote:
> >>
> >> [...]
> >>
> >> >>> >> > And we'd essentially move drm_panel_bridge into drm_panel.c, =
and make it
> >> >>> >> > private.
> >> >>> >>
> >> >>> >> Yes in theory, but the panel_bridge code uses other parts of the
> >> >>> >> drm_kms_helper module: drm_atomic_helper and drm_probe_helper, =
maybe more,
> >> >>> >> so we'd have to move them into the drm module too.
> >> >>> >
> >> >>> > Ah, right. What would happen if we were doing it the other way a=
round
> >> >>> > then? Move drm_panel out of the main drm module?
> >> >>>
> >> >>> Into the drm_kms_helper module?
> >> >>>
> >> >>> I had a look and did some experiments and I found at least one use=
r in the drm
> >> >>> module calling a drm_panel API, and guess who:
> >> >>>
> >> >>>  drm_of_find_panel_or_bridge() (in drm_of.c, drm module)
> >> >>>     -> calls of_drm_find_panel (in drm_panel.c, drm_kms_helper mod=
ule)
> >> >>>
> >> >>> Based on our discussion after patch 3, I'm not sure
> >> >>> drm_of_find_panel_or_bridge() will disappear soon. If it doesn't, =
I guess
> >> >>> we can try to move drm_of_find_panel_or_bridge() into bridge/panel=
=2Ec which
> >> >>> is in the drm_kms_helper module (and from drm_of.h info
> >> >>> drm_bridge.h?). That however might trigger build failures for driv=
ers which
> >> >>> currently don't select DRM_KMS_HELPER and which would have to sele=
ct it.
> >> >>>
> >> >>> I'll give it a try, and if I see major drawbacks I will get back t=
o moving
> >> >>> all the drm_kms_helper code into the main drm module.
> >> >>
> >> >> No, I meant into its own module.
> >> >
> >> > Looks like a good idea indeed, making the design more modular and
> >> > dependencies cleaner.
> >> >
> >> >> Do we have any dependency from the main
> >> >> drm module into drm_panel?
> >> >
> >> > As far as I can see there is only the one mentioned above:
> >> >
> >> >   drm_of_find_panel_or_bridge() (in drm_of.c, drm module)
> >> >      -> calls of_drm_find_panel (in drm_panel.c, would-be the new dr=
m_panel module)
> >> >
> >> > And while drm_of_find_panel_or_bridge() is possibly going to disappe=
ar at
> >> > the end of my series, moving drm_panel.c to its own module would mak=
e the
> >> > series non-build-bisectable, which would be very annoying.
> >> >
> >> > However there seem to be no calls from the drm module to
> >> > drm_of_find_panel_or_bridge(), so we could move it out as well. What=
 about
> >> > a series doing, in this order:
> >> >
> >> >  - move drm_of_find_panel_or_bridge() from the drm module to the
> >> >    drm_kms_helper module
> >> >  - move drm_panel.c to a new drm_panel module
> >> >  - Main change: embed a drm_bridge into every panel
> >> >  - convert drivers to stop using the panel_bridge, hopefully removin=
g all
> >> >    calls to drm_of_find_panel_or_bridge()
> >> >  - remove drm_of_find_panel_or_bridge()
> >>
> >> Ah, no, that won't work. There would be a circular module dependency l=
oop
> >> later on when we embed a drm_bridge into evern drm_panel: indeed at th=
at
> >> point drm_panel will use the atomic and probe helpers to implement the
> >> embedded drm_bridge, resulting in:
> >>
> >>  * the panel_bridge code in bridge/panel.c [drm_kms_helper module]
> >>    already depends on the drm_panel.c code (it manipulates a drm_panel=
, OK)
> >>  * additionally, the drm_panel.c code, in order to create a drm_bridge,
> >>    will depend on the helpers in drm_atomic_helper and drm_probe_helper
> >>    code [drm_kms_helper module]
> >>
> >> The loop is only between kernel modules (.ko), not in actual code. So I
> >> think this revised plan should work (the 2nd bullet is key):
> >>
> >>  - move drm_of_find_panel_or_bridge() from the drm module to
> >>    bridge/panel.c [currently drm_kms_helper module]
> >>  - move bridge/panel.o to a new drm_panel_bridge module (NEW)
> >>  - move drm_panel.c to a new drm_panel module
> >
> > Looks good on principle, but iirc the starting point of that discussion
> > was to move bridge panel into the new panel module,
>=20
> That was the starting point, but working on it I realized it was very
> tricky. So I tried instead copying the relevant bridge/panel.c code into
> drm_panel.c, but with more suitable function names, and the result is way
> cleaner.

I don't see the difference, but I guess that's a good thing anyway :)

> This changed the steps, but not the end result: remove
> drm_of_find_panel_or_bridge() and bridge/panel.c entirely.
>=20
> > so I guess we could:
> >
> > 1) Move drm_of_find_panel_or_bridge() to drm_panel.c. Both are still in
> > the drm module at this point, so it should be ok.
> > 2) Create a new panel module, with a dependency on bridge
> > 3) Move the bridge/panel.c code into the new panel module to create the
> > bridge at the same time we create the panel.
> >
> > Would that work?
>=20
> Maybe, but as above, my plan has changed a bit.
>=20
> My opinion is that for this tricky task we should focus more on the end
> result (embed a bridge into every panel, remove
> drm_of_find_panel_or_bridge() and bridge/panel.c) than on finding the most
> optimal path to get there. So I'm aiming at a path that is
> build-bisectable, clean and understandable.
>=20
> What do you think about this principle?

I somewhat agree, the somewhat being I don't think we should go for that
end result at all cost. We don't know how long it's going to complete,
how much you're going to be involved in this going forward, etc. so I
think the intermediate steps should be reasonable (even if not perfect)
and ok to carry for an indefinite amount of time.

Maxime

--wd77ieiavvmjfjnc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaplBiAAKCRAnX84Zoj2+
dgkxAX9PJK9hBt8zYACkDfa6CxmC0TJXpl8ryCUWstuQytBSSlGW0N+GlfcEm+Vs
WxCWHa8BgKIQLIxtiyRbLQ/6WfbgrEad81k3rTOSSsH9m3MhhIPhVLj9ly2TPjIi
vbS2quffDg==
=sl8N
-----END PGP SIGNATURE-----

--wd77ieiavvmjfjnc--

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E339CD3439
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 15:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F3410F1BF;
	Thu,  7 May 2026 15:29:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eEOu1H8o";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 044E010E2D3
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 15:29:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6D4346015B;
 Thu,  7 May 2026 15:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BDFC2BCB2;
 Thu,  7 May 2026 15:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778167770;
 bh=aMk2O9QcXe4QdMYynYZZvBWho4N8dqGI1/RuB3qFjX8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eEOu1H8o+V1LItWVTzpI4T0zTwu7zvm0br3nrsHAcKXIAE+891uz7IurvUEbywaUh
 O/L0LjLPa6JMmHLDhsyJ+AxEg17pV9hVWAo1uDS5KPpD8kQHE9WXlNE5ih1OE1VQ/t
 yA6j8fJPC5jge9/GRnWLPDlko0Cw6bwXzrApEG1hirRrNlnGF91UL3tZf8G7EBDi14
 gW/z9sUfazSeT11Qzec7KYd+LnJJw2hI4py5utZgY3RpUF6qM+SplBBH8DAX/rPZRO
 jr0iUwHYvLeiNsDS+dNhVQIMti/NzamyrriZKbRlRlA/qNNHEqtDKQLOGMIgAV8P20
 v+KE0dMabFclQ==
Date: Thu, 7 May 2026 17:29:27 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Albert Esteve <aesteve@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Michael Tretter <m.tretter@pengutronix.de>, 
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] drm/panel: Make drm_panel_init() static
Message-ID: <20260507-foamy-classic-wildcat-a320c6@houat>
References: <20260507-drm_panel_init_rm-v1-0-51f448c7c291@redhat.com>
 <20260507-drm_panel_init_rm-v1-10-51f448c7c291@redhat.com>
 <20260507-premium-curious-macaw-d43cbe@houat>
 <CADSE00+UN3wgsJnfCn3CLB3h-RnR-FLLfAOY3UhDyCOmt5HTKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="xdii3lctv73unbwr"
Content-Disposition: inline
In-Reply-To: <CADSE00+UN3wgsJnfCn3CLB3h-RnR-FLLfAOY3UhDyCOmt5HTKA@mail.gmail.com>
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


--xdii3lctv73unbwr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 10/10] drm/panel: Make drm_panel_init() static
MIME-Version: 1.0

On Thu, May 07, 2026 at 05:11:15PM +0200, Albert Esteve wrote:
> On Thu, May 7, 2026 at 4:57=E2=80=AFPM Maxime Ripard <mripard@kernel.org>=
 wrote:
> >
> > Hi,
> >
> > On Thu, May 07, 2026 at 01:53:08PM +0200, Albert Esteve wrote:
> > > Now that all panel drivers use devm_drm_panel_alloc(),
> > > there are no external callers of drm_panel_init().
> > > Make it static to prevent new users from bypassing the
> > > refcounted allocation path.
> > >
> > > Remove stale references to drm_panel_init() in kdocs.
> > >
> > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > ---
> > >  drivers/gpu/drm/display/drm_dp_helper.c | 2 +-
> > >  drivers/gpu/drm/drm_panel.c             | 8 ++++----
> > >  include/drm/drm_panel.h                 | 4 ----
> > >  3 files changed, 5 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/dr=
m/display/drm_dp_helper.c
> > > index a697cc227e289..380ebf0fad2be 100644
> > > --- a/drivers/gpu/drm/display/drm_dp_helper.c
> > > +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> > > @@ -4626,7 +4626,7 @@ static const struct backlight_ops dp_aux_bl_ops=
 =3D {
> > >   * Backlight will then be handled transparently without requiring
> > >   * any intervention from the driver.
> > >   *
> > > - * drm_panel_dp_aux_backlight() must be called after the call to drm=
_panel_init().
> > > + * drm_panel_dp_aux_backlight() must be called after devm_drm_panel_=
alloc().
> > >   *
> > >   * Return: 0 on success or a negative error code on failure.
> > >   */
> > > diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> > > index d1e6598ea3bc0..e3e1c5ceb8ff8 100644
> > > --- a/drivers/gpu/drm/drm_panel.c
> > > +++ b/drivers/gpu/drm/drm_panel.c
> > > @@ -56,8 +56,9 @@ static LIST_HEAD(panel_list);
> > >   * Initialize the panel structure for subsequent registration with
> > >   * drm_panel_add().
> > >   */
> > > -void drm_panel_init(struct drm_panel *panel, struct device *dev,
> > > -                 const struct drm_panel_funcs *funcs, int connector_=
type)
> > > +static void drm_panel_init(struct drm_panel *panel, struct device *d=
ev,
> > > +                        const struct drm_panel_funcs *funcs,
> > > +                        int connector_type)
> > >  {
> > >       if (connector_type =3D=3D DRM_MODE_CONNECTOR_Unknown)
> > >               DRM_WARN("%s: %s: a valid connector type is required!\n=
", __func__, dev_name(dev));
> > > @@ -69,7 +70,6 @@ void drm_panel_init(struct drm_panel *panel, struct=
 device *dev,
> > >       panel->funcs =3D funcs;
> > >       panel->connector_type =3D connector_type;
> > >  }
> > > -EXPORT_SYMBOL(drm_panel_init);
> > >
> > >  /**
> > >   * drm_panel_add - add a panel to the global registry
> > > @@ -708,7 +708,7 @@ EXPORT_SYMBOL(devm_drm_panel_add_follower);
> > >   * A typical implementation for a panel driver supporting device tree
> > >   * will call this function at probe time. Backlight will then be han=
dled
> > >   * transparently without requiring any intervention from the driver.
> > > - * drm_panel_of_backlight() must be called after the call to drm_pan=
el_init().
> > > + * drm_panel_of_backlight() must be called after devm_drm_panel_allo=
c().
> >
> > I think we can drop that sentence entirely. Now that we can only get a
> > panel structure through devm_drm_panel_alloc, and that it also
> > initializes it, we can't call drm_panel_of_backlight before having an
> > initialized drm_panel.
>=20
> Makes sense, I will remove the sentence and send a v2. It probably
> follows the same reasoning, but just to ensure you did not miss it:
> does that apply to drm_panel_dp_aux_backlight() above too?

Yep, thanks!
Maxime

--xdii3lctv73unbwr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCafyv0gAKCRAnX84Zoj2+
dg6eAYDdFIdKQ9dtmjTMF+4W0CeItlgW5Nh0oIn9zrh2SE/4oz5dH+RnuoOSAfq9
Vr8IEaMBgJiK4UmdkKEg/l1YiTPaqvFK8vPaJZIitVN26Lp0XmrLEzBgGX+wZn75
u8YjiA0XkA==
=ol8M
-----END PGP SIGNATURE-----

--xdii3lctv73unbwr--

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48375CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:26:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ABDE10EEE6;
	Wed, 24 Jun 2026 12:26:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jhyfHIEM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBFE910EEE6
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 12:26:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B935601FA;
 Wed, 24 Jun 2026 12:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A861F00A3D;
 Wed, 24 Jun 2026 12:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782304002;
 bh=FyoWGqDXNXkDv+TpnC2bHZVSCNeq8GboVi/p3SCbn98=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jhyfHIEMGRWNkp3KiQUMVY7dHLKfjJzrWbIsyAeIsseRu5QuOZJhwAPPHwmQ0QWvH
 WGYwlNYxl1mnVmp1ZGZ8iqsxwxFXzoRVne3yK1M534Q2V4qGdWv9onURl4Ee8BG0FS
 lcsLTQrTg0ozRtjGNY5rpJVc1OCqzc7X8nap9bkj1+JTb5Fv53GwRtOuC8WOLUEUYM
 3bdSV/ZrMI2nyHYRJKGfkE/1JVqdloixiX3wwfbhAu598I30csYL3xHzuD5SjT/0T5
 kWjcrqimprGPD4LcpMUuPUjr2GYV2l3KQFiGOd7tkFcjP8G8LhbOXkUWmcax7V0BeL
 YhktxORHN27PA==
Date: Wed, 24 Jun 2026 14:26:40 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Hui Pu <Hui.Pu@gehealthcare.com>, 
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 18/37] drm/bridge: samsung-dsim: remove the panel_bridge
 on host_detach
Message-ID: <20260624-delectable-sexy-crayfish-e15c1f@houat>
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
 <20260519-drm-bridge-hotplug-v1-18-45e2bdb3dfb4@bootlin.com>
 <20260608-nano-kangaroo-of-piety-b5ab3d@houat>
 <DJ5EHSOPNQZH.22I96C6QXN9KJ@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="cstjwexp6hdv64qh"
Content-Disposition: inline
In-Reply-To: <DJ5EHSOPNQZH.22I96C6QXN9KJ@bootlin.com>
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


--cstjwexp6hdv64qh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 18/37] drm/bridge: samsung-dsim: remove the panel_bridge
 on host_detach
MIME-Version: 1.0

On Wed, Jun 10, 2026 at 03:24:10PM +0200, Luca Ceresoli wrote:
> On Mon Jun 8, 2026 at 1:53 PM CEST, Maxime Ripard wrote:
> > On Tue, May 19, 2026 at 12:37:35PM +0200, Luca Ceresoli wrote:
> >> In preparation for DRM bridge hot-plugging, we need to handle the dyna=
mic
> >> lifetime of the following bridge in case the samsung-dsim is always pr=
esent
> >> and the following bridge (next_bridge) is hot-unplugged.
> >>
> >> Based on the 'if (!IS_ERR(panel))' check in samsung_dsim_host_attach()=
, the
> >> next_bridge could be A) a panel bridge created by this driver via
> >> devm_drm_panel_bridge_add() or B) a pre-existing bridge obtained via
> >> of_drm_find_and_get_bridge().
> >>
> >> For case B) we need to put that reference when the next_bridge is remo=
ved,
> >> which is already handled by calling drm_bridge_clear_and_put() in
> >> samsung_dsim_host_detach() and in the samsung_dsim_host_attach() error
> >> management code.
> >>
> >> In case A) we additionally have to remove the panel bridge. Currently =
it is
> >> created by devm_drm_panel_bridge_add(), which adds two devm actions wi=
th
> >> the refcounted panel bridge:
> >>
> >>  - drm_bridge_put_void() via devm_drm_bridge_alloc() on panel->dev
> >>  - devm_drm_panel_bridge_release() via devm_drm_panel_bridge_add_typed=
()
> >>    on the consumer device (samsung-dsim)
> >>
> >> The first action is OK: being tied to panel->dev it will happen when t=
he
> >> panel is unplugged.
> >>
> >> The second action is bound to the consumer device, so the devm semanti=
cs is
> >> not useful here when introducing hotplug. Indeed we need to drop the
> >> next_bridge in samsung_dsim_host_detach() anyway, before the driver .r=
emove
> >> function, in order to support {add, {attach, detach} x N, remove} hotp=
lug
> >> event sequences.
> >>
> >> Thus move to the non-devm drm_panel_bridge_add() along with the matchi=
ng
> >> drm_panel_bridge_remove(), so the lifetime of the panel-bridge is tied=
 to
> >> the host_attach/host_detach cycle and not the whole samsung-dsim device
> >> lifetime.
> >>
> >> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> >>
> >> ---
> >>
> >> In a previous discussion with Maxime he mentioned a plan to make every
> >> drm_panel always have a wrapping bridge. With that done, all the code
> >> handling the panel and adding the panel_bridge would become useless he=
re
> >> (and in many other places) and could be entirely removed. This patch i=
s a
> >> temporary solution until that happens. The best pointer I could find to
> >> that discussion is [0], but there might be more recent material I coul=
d not
> >> find at the moment.
> >>
> >> [0] https://lore.kernel.org/lkml/20250218-faithful-white-magpie-da9ac9=
@houat/
> >> ---
> >>  drivers/gpu/drm/bridge/samsung-dsim.c | 17 ++++++++++++++---
> >>  include/drm/bridge/samsung-dsim.h     |  2 ++
> >>  2 files changed, 16 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/b=
ridge/samsung-dsim.c
> >> index 5b799619e07e..2af287221e22 100644
> >> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> >> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> >> @@ -1951,14 +1951,16 @@ static int samsung_dsim_host_attach(struct mip=
i_dsi_host *host,
> >>  	if (!remote)
> >>  		return -ENODEV;
> >>
> >> +	dsi->panel_bridge_added =3D false;
> >>  	panel =3D of_drm_find_panel(remote);
> >>  	if (!IS_ERR(panel)) {
> >> -		next_bridge =3D devm_drm_panel_bridge_add(dev, panel);
> >> +		next_bridge =3D drm_panel_bridge_add(panel);
> >>  		if (IS_ERR(next_bridge)) {
> >>  			ret =3D PTR_ERR(next_bridge);
> >>  			next_bridge =3D NULL; // Inhibit the cleanup action on an ERR_PTR
> >>  		} else {
> >>  			drm_bridge_get(next_bridge);
> >> +			dsi->panel_bridge_added =3D true;
> >>  		}
> >>  	} else {
> >>  		next_bridge =3D of_drm_find_and_get_bridge(remote);
> >> @@ -1989,7 +1991,7 @@ static int samsung_dsim_host_attach(struct mipi_=
dsi_host *host,
> >>  	if (!(device->mode_flags & MIPI_DSI_MODE_VIDEO)) {
> >>  		ret =3D samsung_dsim_register_te_irq(dsi, &device->dev);
> >>  		if (ret)
> >> -			goto err_remove_bridge;
> >> +			goto err_remove_panel_bridge;
> >>  	}
> >>
> >>  	// The next bridge can be used by host_ops->attach
> >> @@ -2011,8 +2013,12 @@ static int samsung_dsim_host_attach(struct mipi=
_dsi_host *host,
> >>  	drm_bridge_clear_and_put(&dsi->bridge.next_bridge);
> >>  	if (!(device->mode_flags & MIPI_DSI_MODE_VIDEO))
> >>  		samsung_dsim_unregister_te_irq(dsi);
> >> -err_remove_bridge:
> >> +err_remove_panel_bridge:
> >>  	drm_bridge_remove(&dsi->bridge);
> >> +	if (dsi->panel_bridge_added) {
> >> +		drm_panel_bridge_remove(next_bridge);
> >> +		dsi->panel_bridge_added =3D false;
> >> +	}
> >
> > This is a pretty big abstraction leak. We don't want to have that in
> > everything driver. The removal path should be the same for both cases,
> > and it's not something the driver should take care of.
>=20
> Yes. The comment after the '---' separator was meant to discuss this
> concern:
>=20
> > In a previous discussion with Maxime he mentioned a plan to make every
> > drm_panel always have a wrapping bridge. With that done, all the code
> > handling the panel and adding the panel_bridge would become useless here
> > (and in many other places) and could be entirely removed. This patch is=
 a
> > temporary solution until that happens. The best pointer I could find to
> > that discussion is [0], but there might be more recent material I could=
 not
> > find at the moment.
>=20
> Do you have any update about that plan?

I think we're pretty much there. As of 7.2, all panels will use
devm_drm_panel_alloc. It should be fairly easy now to create a bridge
for them all in devm_drm_panel_alloc, and then call drm_bridge_add in
drm_panel_add.

It's also tangentially related to https://lore.kernel.org/ksummit/0fa2fb42-=
0714-49f7-ba43-22928e1dd488@linaro.org/

Maxime

--cstjwexp6hdv64qh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCajvM+wAKCRAnX84Zoj2+
dvs6AYCbYwiAHI0RWkIrSJ6HTAS/XRbFVnFHU9MxYcXvsGs3GaljrmWoPw/w/qWK
d1Yg7qsBgLOHhMlyHfj3U/HJUmXpsK4aLwubF45HUsdZTfAggKa53Wz+5lLcDmOy
cJOZr5wk3A==
=S5Am
-----END PGP SIGNATURE-----

--cstjwexp6hdv64qh--

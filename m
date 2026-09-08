Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C82C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9DBB10EC92;
	Tue,  8 Sep 2026 15:21:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ioauQODE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D281A10EC91
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 15:21:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 16EA3601F6;
 Tue,  8 Sep 2026 15:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4660B1F00A3A;
 Tue,  8 Sep 2026 15:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788880866;
 bh=jHrBx0GYLJ/czyw8Dz2DV0Uyy/hB6kCYl3xbiY3VLxs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ioauQODEhvEpjvQABj+5OWAD8+fjU/RMgiPK6PiQB85jIOEoNwGeYMyf9vq0Ic5sc
 5N8OTvRqGdampJ9dsl+DaR6AqU4Vdvy0SBLBWC+4pIYDu3i67Av/SUEZ6ThvNB/u/X
 AinJj2KXeZ0awrK1bnO5zb6X5wxRsbohTq6yddVnKAY3yKcsZzaUto2pI4cjBECmUz
 c8363Y9uAXs8KgBaUcbWqdn586xprGh/3Aysu+RSrfSaAMCXWjzRIl7WXtH6xhA+Dg
 3PjIm//vEe4200/PlSYY+c4YBJHYDuwndb5/lQXjwrkHCtFuLnbZK3q2Quf4XTXzXo
 dO+pP2IoDpglA==
Date: Tue, 8 Sep 2026 17:21:03 +0200
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
 Albert Esteve <aesteve@redhat.com>, Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 05/19] drm/panel: embed a drm_bridge into every
 drm_panel
Message-ID: <aqAld6W-JmrKLK_9@houat>
References: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
 <20260903-drm-bridge-every-panel-v2-5-2ab8ee24538e@bootlin.com>
 <aplG-skzq-TPfFZQ@houat> <DL5Q0MLS0KT9.24LJK2Q1L89KP@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="bd64h2ct5hdmo56j"
Content-Disposition: inline
In-Reply-To: <DL5Q0MLS0KT9.24LJK2Q1L89KP@bootlin.com>
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


--bd64h2ct5hdmo56j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC v2 05/19] drm/panel: embed a drm_bridge into every
 drm_panel
MIME-Version: 1.0

On Thu, Sep 03, 2026 at 03:37:55PM +0200, Luca Ceresoli wrote:
> Hi Maxime,
>=20
> thanks for keeping the round-trip time short for this discussion!
>=20
> On Thu Sep 3, 2026 at 12:22 PM CEST, Maxime Ripard wrote:
> > On Thu, Sep 03, 2026 at 10:11:08AM +0200, Luca Ceresoli wrote:
> >> Adding a drm_panel does currently not add a panel_bridge wrapping
> >> it. Usually the panel_bridge creation happens later, when some other d=
river
> >> (e.g. the previous bridge or the encoder) calls *_of_get_bridge() and =
the
> >> following element in the pipeline is a panel.
> >>
> >> This has some drawbacks:
> >>
> >>  * the bridge API is currently the best practice to access various
> >>    components of the pipeline, especially with complex cards where bri=
dges
> >>    can be combined in different ways on different hardware
> >>  * the panel_bridge is not created in the context of the driver of the
> >>    underlying physical device (the panel driver), but of some other dr=
iver
> >>  * that other driver is not aware of whether the returned drm_bridge
> >>    pointer is a panel_bridge created on the fly, a pre-existing
> >>    panel_bridge or a non-panel bridge
> >>  * removal of a panel_bridge requires calling drm_panel_bridge_remove(=
),
> >>    but that other driver doesn't know whether this is needed because it
> >>    doesn't know whether it has created a panel_bridge or not
> >>
> >> Other drivers call [a variant of] drm_panel_bridge_add(), which also h=
as
> >> some of the above drawbacks.
> >>
> >> So far the current approach was working mostly because devm and drmm e=
nsure
> >> the panel bridge would be dealloacted at some later point. However wit=
h the
> >> upcoming implementation of bridge hotplug and dynamic bridge lifetime =
this
> >> will get more complicated.
> >>
> >> Switch to the new approach: embed a drm_bridge inside every drm_panel,
> >> which behaves just like the current drm_panel_bridge.
> >>
> >> Do this by copying and adapting the code from bridge/panel.c, using
> >> function names that are more suitable within drm_panel.c and doing the
> >> minimal adaptation needed.
> >>
> >> Currently drm_bridge and drm_panel have independent refcounted
> >> allocation. As they now become a single struct, just change
> >> drm_panel_get/put() to get/put the bridge. As a result, the refcount f=
or a
> >> drm_bridge embedded in a drm_panel is:
> >>
> >>   bridge.refcount =3D=3D number of drm_bridge_get() calls
> >>                    + number of drm_panel_get() calls
> >>                    - number of drm_bridge_put() calls
> >>                    - number of drm_panel_put() calls
> >>
> >> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> >
> > So there's a lot to unravel, and I wished you had split it, but I can't
> > find a good way to split it either.
>=20
> As I see it, this could be maybe split in 2:
>=20
>  - copy all needed symbols from bridge/panel.c (or move or whatever, see
>    discussion below) without using them
>  - change _alloc, _get, _put etc to actually embed the bridge and start
>    using the copied/moved symbols
>=20
> Would you prefer that?
>=20
> Note the second bullet, which is the core change, is pretty small, I think
> a <100 lines diff, but I don't think it can be split further.

Yeah, that's why I'm not sure it's going to make a big difference
anyway. Sometimes it's just not great and there's nothing to do about
it, really :/

> >> This patch is new in v2, and replaces "drm/bridge: panel: add a
> >> panel_bridge to every panel" which was based on a different approach.
> >> ---
> >>  drivers/gpu/drm/drm_panel.c | 258 +++++++++++++++++++++++++++++++++++=
++++++---
> >>  include/drm/drm_panel.h     |  33 ++++--
> >>  2 files changed, 266 insertions(+), 25 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> >> index f8f6082e637f..9b86195f9f66 100644
> >> --- a/drivers/gpu/drm/drm_panel.c
> >> +++ b/drivers/gpu/drm/drm_panel.c
> >> @@ -22,15 +22,19 @@
> >>   */
> >>
> >>  #include <linux/backlight.h>
> >> +#include <linux/debugfs.h>
> >>  #include <linux/err.h>
> >>  #include <linux/export.h>
> >>  #include <linux/module.h>
> >>  #include <linux/of.h>
> >>
> >> +#include <drm/drm_atomic_helper.h>
> >>  #include <drm/drm_crtc.h>
> >> +#include <drm/drm_modeset_helper_vtables.h>
> >>  #include <drm/drm_of.h>
> >>  #include <drm/drm_panel.h>
> >>  #include <drm/drm_print.h>
> >> +#include <drm/drm_probe_helper.h>
> >>
> >>  static DEFINE_MUTEX(panel_lock);
> >>  static LIST_HEAD(panel_list);
> >> @@ -46,6 +50,18 @@ static LIST_HEAD(panel_list);
> >>   * take look at drm_panel_bridge_add() and devm_drm_panel_bridge_add(=
).
> >>   */
> >>
> >> +static inline struct drm_panel *
> >> +drm_bridge_to_panel(const struct drm_bridge *bridge)
> >> +{
> >> +	return container_of(bridge, struct drm_panel, bridge);
> >> +}
> >> +
> >> +static inline struct drm_panel *
> >> +drm_connector_to_panel(const struct drm_connector *connector)
> >> +{
> >> +	return container_of(connector, struct drm_panel, connector);
> >> +}
> >> +
> >>  /**
> >>   * drm_panel_init - initialize a panel
> >>   * @panel: DRM panel
> >> @@ -86,6 +102,7 @@ void drm_panel_add(struct drm_panel *panel)
> >>  	mutex_lock(&panel_lock);
> >>  	list_add_tail(&panel->list, &panel_list);
> >>  	mutex_unlock(&panel_lock);
> >> +	drm_bridge_add(&panel->bridge);
> >>  }
> >>  EXPORT_SYMBOL(drm_panel_add);
> >>
> >> @@ -97,6 +114,7 @@ EXPORT_SYMBOL(drm_panel_add);
> >>   */
> >>  void drm_panel_remove(struct drm_panel *panel)
> >>  {
> >> +	drm_bridge_remove(&panel->bridge);
> >>  	mutex_lock(&panel_lock);
> >>  	list_del_init(&panel->list);
> >>  	mutex_unlock(&panel_lock);
> >> @@ -370,13 +388,198 @@ int drm_panel_get_modes(struct drm_panel *panel,
> >>  }
> >>  EXPORT_SYMBOL(drm_panel_get_modes);
> >>
> >> -static void __drm_panel_free(struct kref *kref)
> >> +static int drm_panel_bridge_connector_get_modes(struct drm_connector =
*connector)
> >> +{
> >> +	struct drm_panel *drm_panel =3D drm_connector_to_panel(connector);
> >> +
> >> +	return drm_panel_get_modes(drm_panel, connector);
> >> +}
> >> +
> >> +/**
> >> + * drm_bridge_set_connector_orientation - Set the connector panel
> >> + * orientation from the bridge that can be transformed to drm_panel.
> >> + *
> >> + * @bridge: The drm_bridge for a drm_panel.
> >> + * @connector: The connector to be set panel orientation.
> >> + *
> >> + * Returns 0 on success, negative errno on failure.
> >> + */
> >> +int drm_bridge_set_connector_orientation(const struct drm_bridge *bri=
dge,
> >> +					 struct drm_connector *connector)
> >> +{
> >> +	struct drm_panel *panel =3D drm_bridge_to_panel(bridge);
> >> +
> >> +	return drm_connector_set_orientation_from_panel(connector, panel);
> >> +}
> >> +EXPORT_SYMBOL(drm_bridge_set_connector_orientation);
> >
> > I don't think we should create new ones. Just move the code from
> > bridge/panel here and remove it there. The only thing left will be the
> > panel_bridge_add() variants that become almost trivial now, and you can
> > cleanup the drivers in later patches.
>=20
> What do you mean by "move" exactly? Really move all relevant functions fr=
om
> bridge/panel.c into drm_panel.c, so evey user driver will depend on the n=
ew
> drm_panel module instead of the old one for these symbols?

Yes. Basically, I don't want to end up in a situation where we have
competing implementations of the same function and we have to mess
around with names to accomodate one or the other.

> > This also allows to get rid of all the symbol renaming, which isn't
> > great in itself, but also the existing names were good so it's hard to
> > come with better ones.
>=20
> I think the names in bridge/panel.c make sense there, but not in
> drm_panel.c. Here's my interpretation (using atomic_enable as an example):
>=20
>  - panel_bridge_atomic_enable
>    ^^^^^^^^^^^^ <- this is about the panel_bridge
>=20
>  - drm_panel_bridge_atomic_enable
>    ^^^^^^^^^        <- this is drm_panel stuff
>              ^^^^^^ <- and specifically about the bridge embedded in drm_=
panel
>=20
> Does it make sense to you too in this perspective?

It's an internal symbol anyway, right? So it's really doesn't matter
that much to me.

That being said, if we were to make it public, drm_panel_bridge seem
totally fine by me. It's "panel_bridge_atomic_enable", in the drm
namespace.

Maxime

--bd64h2ct5hdmo56j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaqAn1QAKCRAnX84Zoj2+
dj6kAX9hes0lXVYSoppnuBFwWfQgULvAoLhNFbe7BBMJst5qpS1LG+qQgvOKria2
b9OpaSkBgKd9MelOsTn3TuBA3edoxxtNZj1Ifg4T471fDW0fx17WN23egOYxH+A0
dllMEvyNkQ==
=6V1p
-----END PGP SIGNATURE-----

--bd64h2ct5hdmo56j--

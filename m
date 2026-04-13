Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186B7F34C4E
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 12:34:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7117510E450;
	Mon, 13 Apr 2026 12:34:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="syyNFaz4";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76E9B10E450;
 Mon, 13 Apr 2026 12:34:17 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id A959C1A31E4;
 Mon, 13 Apr 2026 12:34:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6D14A5FFB9;
 Mon, 13 Apr 2026 12:34:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 10AAC10450229; 
 Mon, 13 Apr 2026 14:34:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776083654; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=W8Wq0XFDTnCET+9d1u1+KkWzNdxSiwKVtLFGfiPbxXY=;
 b=syyNFaz4M5CS3w/qw5wtQg2RUzkQnw7q8wpoWJoj2F/6PjYErOhqgA15EFQePTJFBA4UUF
 LSoYPrX+6nQZSqeG+B4U4C4xWZ1ulEKEh0Ey4sQyQWMzsQ6tAryHHJei5nGcYHXOoxDecC
 MEHdbtnzQcIZmpBy0guw4bo6EI9a3soHuL6Iia5wgs5TjoAu7fZyVJG+ga+5ODGi/+U2VG
 5Hif4ZnGHGfMoRaK7RFojvStP0nVD+NWuhg11+AM9pkSYzPTLZPJvgxhSIVupZBkt6H3R8
 zRfNZdNIdvMsN5cINpliwzzvjzglbX6zYtJZaEhq4n3qR6E/vUiX3TK/CIPkKw==
Date: Mon, 13 Apr 2026 14:34:02 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dave
 Airlie <airlied@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric
 Anholt <eric@anholt.net>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Chun-Kuang Hu
 <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Chris Wilson
 <chris@chris-wilson.co.uk>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Mark Yacoub <markyacoub@google.com>, Sean
 Paul <seanpaul@google.com>, Louis Chauvet <louis.chauvet@bootlin.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH RFC 10/12] drm/i915/display/dp: Adopt dp_connector
 helpers to expose link training state
Message-ID: <20260413143402.76f5c3c9@kmaincent-XPS-13-7390>
In-Reply-To: <e253ca4fa0b493032a7b35a0a20689b9d9e0c4e7@intel.com>
References: <20260409-feat_link_cap-v1-0-7069e8199ce2@bootlin.com>
 <20260409-feat_link_cap-v1-10-7069e8199ce2@bootlin.com>
 <e253ca4fa0b493032a7b35a0a20689b9d9e0c4e7@intel.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Fri, 10 Apr 2026 19:26:53 +0300
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> On Thu, 09 Apr 2026, Kory Maincent <kory.maincent@bootlin.com> wrote:
> > Switch the i915 DP connector initialization from drmm_connector_init()
> > to drmm_connector_dp_init(), providing the source link capabilities
> > (supported lane counts, link rates, DSC support, voltage swing and
> > pre-emphasis levels).
> >
> > Add intel_dp_report_link_train() to collect the negotiated link
> > parameters (rate, lane count, DSC enable, per-lane voltage swing and
> > pre-emphasis) and report them via
> > drm_connector_dp_set_link_train_properties() once link training complet=
es
> > successfully.
> >
> > Reset the link training properties via
> > drm_connector_dp_reset_link_train_properties() when the connector is
> > reported as disconnected or when the display device is disabled, so
> > the exposed state always reflects the current link status.
> >
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_dp.c            | 31
> > +++++++++++++++++++--- .../gpu/drm/i915/display/intel_dp_link_training.=
c  |
> > 25 +++++++++++++++++ 2 files changed, 52 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp.c
> > b/drivers/gpu/drm/i915/display/intel_dp.c index
> > 2af64de9c81de..641406bdc0cc9 100644 ---
> > a/drivers/gpu/drm/i915/display/intel_dp.c +++
> > b/drivers/gpu/drm/i915/display/intel_dp.c @@ -45,6 +45,7 @@
> >  #include <drm/display/drm_hdmi_helper.h>
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc.h>
> > +#include <drm/drm_dp_connector.h>
> >  #include <drm/drm_edid.h>
> >  #include <drm/drm_fixed.h>
> >  #include <drm/drm_managed.h>
> > @@ -6337,8 +6338,10 @@ intel_dp_detect(struct drm_connector *_connector,
> >  	drm_WARN_ON(display->drm,
> >  		    !drm_modeset_is_locked(&display->drm->mode_config.connection_mut=
ex));
> > =20
> > -	if (!intel_display_device_enabled(display))
> > +	if (!intel_display_device_enabled(display)) {
> > +		drm_connector_dp_reset_link_train_properties(_connector);
> >  		return connector_status_disconnected;
> > +	}
> > =20
> >  	if (!intel_display_driver_check_access(display))
> >  		return connector->base.status;
> > @@ -6388,6 +6391,8 @@ intel_dp_detect(struct drm_connector *_connector,
> > =20
> >  		intel_dp_tunnel_disconnect(intel_dp);
> > =20
> > +		drm_connector_dp_reset_link_train_properties(_connector);
> > +
> >  		goto out_unset_edid;
> >  	}
> > =20
> > @@ -7162,10 +7167,12 @@ intel_dp_init_connector(struct intel_digital_po=
rt
> > *dig_port, struct intel_connector *connector)
> >  {
> >  	struct intel_display *display =3D to_intel_display(dig_port);
> > +	struct drm_connector_dp_link_train_caps link_caps;
> >  	struct intel_dp *intel_dp =3D &dig_port->dp;
> >  	struct intel_encoder *encoder =3D &dig_port->base;
> >  	struct drm_device *dev =3D encoder->base.dev;
> >  	enum port port =3D encoder->port;
> > +	u32 *rates;
> >  	int type;
> > =20
> >  	if (drm_WARN(dev, dig_port->max_lanes < 1,
> > @@ -7213,8 +7220,25 @@ intel_dp_init_connector(struct intel_digital_port
> > *dig_port, type =3D=3D DRM_MODE_CONNECTOR_eDP ? "eDP" : "DP",
> >  		    encoder->base.base.id, encoder->base.name);
> > =20
> > -	drmm_connector_init(dev, &connector->base,
> > &intel_dp_connector_funcs,
> > -			    type, &intel_dp->aux.ddc);
> > +	intel_dp_set_source_rates(intel_dp);
> > +	link_caps.nlanes =3D DRM_DP_1LANE | DRM_DP_2LANE | DRM_DP_4LANE;
> > +	link_caps.nrates =3D intel_dp->num_source_rates;
> > +	rates =3D kzalloc_objs(*rates, intel_dp->num_source_rates);
> > +	if (!rates)
> > +		goto fail;
> > +
> > +	for (int i =3D 0; i < intel_dp->num_source_rates; i++)
> > +		rates[i] =3D intel_dp->source_rates[i];
> > +
> > +	link_caps.rates =3D rates;
> > +	link_caps.dsc =3D true; =20
>=20
> You have a source, you have a sink, and you have a link between the two.
>=20
> Source rates do not reflect the link rates common between source and
> sink.
>=20
> DSC depends on source and sink, and it's not statically "true" for
> either, and depends on a bunch of things.

At init, we are reporting the capabilities of the source. So we list every
link rates that the source can achieve and we report that the source is DSC
capable which it is IIUC the code. Or maybe I am missing something?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

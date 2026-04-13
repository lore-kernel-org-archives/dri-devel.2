Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164A1F34C62
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81B7210E4C5;
	Mon, 13 Apr 2026 15:30:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Bd+Mxj8L";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD1F010E4C5;
 Mon, 13 Apr 2026 15:30:47 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 3528C4E42978;
 Mon, 13 Apr 2026 15:30:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id ED2C35FFBB;
 Mon, 13 Apr 2026 15:30:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D8842104513C6; 
 Mon, 13 Apr 2026 17:30:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776094244; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=xg8mzFbPBXrLw9j1EK50l3GIhD/98doCuEPkQsBTXYk=;
 b=Bd+Mxj8LwX8bmTnYNL7sIGdg6fifgVRg5gBnAlj9DJfaOxX3ZMmFgplXr3RpU0G6J0nZsm
 GsPmX0Cd70dbZe9H37Sg/fs6lNEDwb2HFql8aKBOyyVHYkhs+kOEsc4183IEhRtE/+Y+bn
 B7Quo8kONLit4TeT3qRtlgQ8aIpLCBKwRueL734GVpuAoGRTWcIVQd8HZh+lml6CSdv5qB
 1DIjkVOi1e1GN698Ge5QhGyetJvHFhguVpCbSawA8cwwM0U4oRZqE04EEmUDBhaj9QQqzN
 5xK+Sw/bTXn8nBDLQHq455wUR0enHUfQ4/ku2qUCLZV+HGW8lgvFBy129MgmxA==
Date: Mon, 13 Apr 2026 17:30:32 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Joonas Lahtinen
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
Subject: Re: [PATCH RFC 09/12] drm: Introduce drmm_connector_dp_init() with
 link training state properties
Message-ID: <20260413173032.75ee842a@kmaincent-XPS-13-7390>
In-Reply-To: <bwgzwwlmvlbtnl7qnmnjrkzjaifeyrhllnbjxh7txrd2o24aqi@2ykn2gwyatcx>
References: <20260409-feat_link_cap-v1-0-7069e8199ce2@bootlin.com>
 <20260409-feat_link_cap-v1-9-7069e8199ce2@bootlin.com>
 <gmaxonri7y3k43pxsnxfnd23mydgrwsw2322v6m4yjoksqm7aj@4ehgvhzg2ubb>
 <20260413145930.140ba461@kmaincent-XPS-13-7390>
 <bwgzwwlmvlbtnl7qnmnjrkzjaifeyrhllnbjxh7txrd2o24aqi@2ykn2gwyatcx>
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

On Mon, 13 Apr 2026 16:59:43 +0300
Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:

> On Mon, Apr 13, 2026 at 02:59:30PM +0200, Kory Maincent wrote:
> > On Fri, 10 Apr 2026 00:53:08 +0300
> > Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >  =20
> > > On Thu, Apr 09, 2026 at 07:08:25PM +0200, Kory Maincent wrote: =20
> > > > Add a managed DisplayPort connector initialization helper,
> > > > drmm_connector_dp_init(), modeled after the existing HDMI counterpa=
rt
> > > > drmm_connector_hdmi_init(). Cleanup is handled automatically via a
> > > > DRM-managed action.
> > > >=20
> > > > The helper creates the following immutable connector properties to
> > > > expose DP link training capabilities and state to userspace:
> > > >=20
> > > >   - num_lanes: bitmask of supported lane counts (1, 2, 4)
> > > >   - link_rate: Array of supported link rates.
> > > >   - dsc_en: Display Stream Compression supported
> > > >   - voltage_swingN: per-lane voltage swing level bitmask
> > > >   - pre-emphasisN: per-lane pre-emphasis level bitmask
> > > >=20
> > > > Link rates are passed by the driver in deca-kbps, following the DRM
> > > > convention, but exposed to userspace in kbps for clarity.
> > > >=20
> > > > Two additional helpers are provided to update and reset those prope=
rties
> > > > at runtime:
> > > >   - drm_connector_dp_set_link_train_properties()
> > > >   - drm_connector_dp_reset_link_train_properties()
> > > >  =20
> >=20
> > ...
> >  =20
> > > > +/**
> > > > + * struct drm_connector_dp_link_train - DRM DisplayPort link train=
ing
> > > > + * information report
> > > > + */
> > > > +struct drm_connector_dp_link_train {   =20
> > >=20
> > > THese define the current DP state. As such, they definitely make sense
> > > to be a part of the drm_connector. =20
> > > > +	/**
> > > > +	 * @nlanes: The number of lanes used
> > > > +	 */
> > > > +	u8 nlanes;
> > > > +
> > > > +	/**
> > > > +	 * @rates: Link rate value selected in deca-kbps
> > > > +	 */
> > > > +	u32 rate;
> > > > +
> > > > +	/**
> > > > +	 * @dsc: Display Stream Compression enabled
> > > > +	 */
> > > > +	bool dsc_en;
> > > > +
> > > > +	/**
> > > > +	 * @v_swings: Array listing the bitmask voltage swing level per
> > > > lanes
> > > > +	 */
> > > > +	u8 v_swing[4];
> > > > +
> > > > +	/**
> > > > +	 * @pre_emph: Array listing the bitmask pre-emphasis level per
> > > > lanes
> > > > +	 */
> > > > +	u8 pre_emph[4];   =20
> > >=20
> > > Please consider following struct phy_configure_opts_dp (or using it as
> > > is). Overall, please refer the talk and (more important) the lightning
> > > resumee at this XDC. I have some bits and pieces ready in spite of th=
at
> > > proposal, but I didn't have time to finish it. =20
> >=20
> > I didn't know this phy_configure_opts_dp struct. This indeed could make
> > sense to reuse and modify that structure for our needs. =20
>=20
> Why would you want to modify it? It is an interface for the PHY drivers.
> Is there anything that you miss there?

I was thinking of the DSC, but after a quick look it is not done at the PHY
level therefore it won't land here.
=20
> > About your XDC talk. What were the developments you were talking about?
> > Could I have a look at them? =20
>=20
> I've posted an RFC just before the XDC. Currently I'm looking at the
> link training generification. Overall, you don't have to wait for that
> job to be completed, just take some of the notes in account (like reuse
> of the PHY config structures).

Ok, have you a link? I can't find the related series.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

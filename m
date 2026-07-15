Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E818BC44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 08:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E3D10E14D;
	Wed, 15 Jul 2026 08:51:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VQhVquvD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6597310E14D
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 08:51:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3BDDA410A0;
 Wed, 15 Jul 2026 08:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF18F1F00A3A;
 Wed, 15 Jul 2026 08:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784105460;
 bh=qCXCuR71/7ld5fnjtnlVmFnztWKJMWhQGvsU4ArYfYA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VQhVquvDAc+PivI/GgyNFhFfn9k464FvW3H7RbaIZZXJBVbfy+eex8r/WHi4TJk8J
 nUL2aLzEqlYTz+ATctm79EbpCBG7U4OgJ4oawXt7ct5zFYF3C3D959gyOSC7H26lok
 QSlTykWXAyKwN2JFke23qMOalptkbylWE6cCIZ/PLbIciu34ADYoQi2+MXDlwvsDSA
 r5H9jPjuair7oq48ERmBQIdSCsrJPpwAAgfXDZJGu6WgKffYanuzqDOXDQOEhacYIt
 YwoN7xM4UUAnXVLzszXu5o1aFEreAgIbT43mjXvljwwaSdEmt9wnbHFjCXLdj9Mq7Z
 uRnRYUqajBIAQ==
Date: Wed, 15 Jul 2026 10:50:55 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v8 02/39] drm/connector: Add caps-based HDMI connector
 init helper
Message-ID: <20260715-fair-opalescent-rhino-c6407b@houat>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-2-d79890d00b6a@collabora.com>
 <i4tjtsf5rsckfcayo5nuhlger5wqxn3ujeaubm4g2fgrwvhzb2@hf4uhgq3ja5p>
 <ad75cf26-9437-47d0-864d-d71263401615@collabora.com>
 <20260707-illegal-tuna-of-force-1c06e3@houat>
 <737678ab-f082-4a0e-b453-f403ba141437@collabora.com>
 <80374deb-3246-413f-a043-66bcdb438ab1@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="z6feftgsn6dp6gmq"
Content-Disposition: inline
In-Reply-To: <80374deb-3246-413f-a043-66bcdb438ab1@collabora.com>
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


--z6feftgsn6dp6gmq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 02/39] drm/connector: Add caps-based HDMI connector
 init helper
MIME-Version: 1.0

On Fri, Jul 10, 2026 at 01:27:37PM +0300, Cristian Ciocaltea wrote:
> On 7/8/26 1:11 PM, Cristian Ciocaltea wrote:
> > Hi Maxime,
> >=20
> > On 7/7/26 7:10 PM, Maxime Ripard wrote:
> >> On Fri, Jul 03, 2026 at 10:31:55PM +0300, Cristian Ciocaltea wrote:
> >>> Hi Dmitry,
> >>>
> >>> Thanks for your quick review!
> >>>
> >>> On 7/3/26 5:05 PM, Dmitry Baryshkov wrote:
> >>>> On Thu, Jul 02, 2026 at 05:46:15PM +0300, Cristian Ciocaltea wrote:
> >>>>> In preparation for adding HDMI 2.x source capabilities, introduce s=
truct
> >>>>> drm_connector_hdmi_caps and a new drmm_connector_hdmi_init_with_cap=
s()
> >>>>> helper.
> >>>>>
> >>>>> The existing drmm_connector_hdmi_init() helper currently takes
> >>>>> individual capability arguments such as supported_formats and max_b=
pc.
> >>>>> Adding more HDMI-specific arguments to that function would not scale
> >>>>> well, so move those values into a dedicated capabilities structure =
and
> >>>>> implement the existing helper as a wrapper around the new caps-based
> >>>>> interface.
> >>>>
> >>>> I think, it was an intention of Maxime: make sure that every driver =
is
> >>>> forced to provide some values here. With the struct-based init it is
> >>>> easy to overlook or to ommit a value.
> >>>
> >>> Agreed that the struct-based init loses the compile-time guarantee th=
at every
> >>> argument is explicitly provided - that's a real downside. =20
> >>>
> >>> I'd argue it's recoverable, though: the init helper validates the man=
datory
> >>> fields, so a driver that omits a required value gets rejected at init=
 time
> >>> rather than silently misconfigured.  The "you must provide sane value=
s" property
> >>> is expected to be preserved, just enforced at runtime instead of by t=
he
> >>> compiler.=20
> >>
> >> Yeah, I don't think we can win with C here. Rust might, but we're
> >> probably a long way from that.
> >>
> >>> The main motivation for the struct is scalability/maintainability as =
we add HDMI
> >>> 2.x capabilities: new fields go into the struct rather than growing t=
he helper's
> >>> argument list, so existing callers don't need churny signature update=
s on every
> >>> extension.
> >>>
> >>> FWIW, in the previous revision we discussed addressing the concern wi=
th a
> >>> callback instead.  Sadly, I had to discard that approach, as it prove=
d not
> >>> flexible enough, e.g. drm_bridge_connector_init() computes caps dynam=
ically, and
> >>> would have required either stateful callbacks, or storing redundant/t=
emporary
> >>> cap data in driver-private structures just to satisfy the callback.
> >>
> >> I just realized something reviewing your patch: we don't necessarily
> >> need an extra argument or a callback, we can just put these fields into
> >> drm_hdmi_connector_funcs directly, and then validate them in init.
> >=20
> > If I understand correctly, we should drop the drm_connector_hdmi_caps s=
truct
> > introduced by this patch and move all its fields into drm_hdmi_connecto=
r_funcs.
> >=20
> > In that case, how should we proceed with drmm_connector_hdmi_init()?=20
>=20
> Actually, this brings us to the callback issue: we cannot compute caps
> dynamically, as it only works with static data, since funcs is supposed t=
o be
> immutable.

Does it? The core and helpers must consider it immutable but it doesn't
have to. drm_bridge_connector for example could totally allocate it and
dynamically create it based on the bridge capabilities.

> Moreover, we would end up with some redundancy, as most of these input fi=
elds,
> after validation, would be stored (altered or not) directly in
> drm_connector/drm_connector_hdmi structs.

I mean, part of the conversion would obviously be to remove the
redundant fields.

--z6feftgsn6dp6gmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaldJ7wAKCRAnX84Zoj2+
dj33AX0ZUsd0ZtnCvNBfTVx1xc4lSlqSv96jF6MDRJm86n/BZPlTwIJXMW8LPOHp
JGjDi6IBf2x6ikh1LwU7GSjP2yjVDjaxBerQjTbrwYyl3BAD2SowFtEHHWKJpUMH
YvcCar5zdQ==
=VuTq
-----END PGP SIGNATURE-----

--z6feftgsn6dp6gmq--

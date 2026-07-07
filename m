Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A18C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2A9A88668;
	Tue,  7 Jul 2026 16:10:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UN7Mi0Fq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC0988668
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:10:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3B06D60018;
 Tue,  7 Jul 2026 16:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E151F000E9;
 Tue,  7 Jul 2026 16:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783440603;
 bh=Q5u+a7D+ayzU/IukGQqNNjlldkq3od3GzB6ae/tPk4w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UN7Mi0Fq/Yi7DzfCneASL6PehRygMQxJ3xpk3Ek2gkQW0e+Z1yBT1Gd0PLT4uoIUs
 dZ0pfYm0iiVRh+ZMsUsPHC+Yly+6VD3oeAReiQLNagVGn9p5eQbfsrNGzuW4CnayhP
 PPK5XUQCsYswCOceRR6LMy/3w3ibTYYkbWeLx6wQ+4iJP8lWMMO+GwH16xsAeunDAR
 3R/R0w9yZ1M91gjfgTtzhHnAXsKLudJxGTi4zF8+4azFfqushczmDDWAqrgbLr/kVB
 RmlVkmJ8Gd8mXXDoCXyZRnULvOFNE4HtZMSWfvhd4vRpX4QBoWpkZby2LQHMFE9xfM
 9ixfGG4QmrG9Q==
Date: Tue, 7 Jul 2026 18:10:02 +0200
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
Message-ID: <20260707-illegal-tuna-of-force-1c06e3@houat>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-2-d79890d00b6a@collabora.com>
 <i4tjtsf5rsckfcayo5nuhlger5wqxn3ujeaubm4g2fgrwvhzb2@hf4uhgq3ja5p>
 <ad75cf26-9437-47d0-864d-d71263401615@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="27ucv5zt2ny4lmlg"
Content-Disposition: inline
In-Reply-To: <ad75cf26-9437-47d0-864d-d71263401615@collabora.com>
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


--27ucv5zt2ny4lmlg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 02/39] drm/connector: Add caps-based HDMI connector
 init helper
MIME-Version: 1.0

On Fri, Jul 03, 2026 at 10:31:55PM +0300, Cristian Ciocaltea wrote:
> Hi Dmitry,
>=20
> Thanks for your quick review!
>=20
> On 7/3/26 5:05 PM, Dmitry Baryshkov wrote:
> > On Thu, Jul 02, 2026 at 05:46:15PM +0300, Cristian Ciocaltea wrote:
> >> In preparation for adding HDMI 2.x source capabilities, introduce stru=
ct
> >> drm_connector_hdmi_caps and a new drmm_connector_hdmi_init_with_caps()
> >> helper.
> >>
> >> The existing drmm_connector_hdmi_init() helper currently takes
> >> individual capability arguments such as supported_formats and max_bpc.
> >> Adding more HDMI-specific arguments to that function would not scale
> >> well, so move those values into a dedicated capabilities structure and
> >> implement the existing helper as a wrapper around the new caps-based
> >> interface.
> >=20
> > I think, it was an intention of Maxime: make sure that every driver is
> > forced to provide some values here. With the struct-based init it is
> > easy to overlook or to ommit a value.
>=20
> Agreed that the struct-based init loses the compile-time guarantee that e=
very
> argument is explicitly provided - that's a real downside. =20
>=20
> I'd argue it's recoverable, though: the init helper validates the mandato=
ry
> fields, so a driver that omits a required value gets rejected at init time
> rather than silently misconfigured.  The "you must provide sane values" p=
roperty
> is expected to be preserved, just enforced at runtime instead of by the
> compiler.=20

Yeah, I don't think we can win with C here. Rust might, but we're
probably a long way from that.

> The main motivation for the struct is scalability/maintainability as we a=
dd HDMI
> 2.x capabilities: new fields go into the struct rather than growing the h=
elper's
> argument list, so existing callers don't need churny signature updates on=
 every
> extension.
>=20
> FWIW, in the previous revision we discussed addressing the concern with a
> callback instead.  Sadly, I had to discard that approach, as it proved not
> flexible enough, e.g. drm_bridge_connector_init() computes caps dynamical=
ly, and
> would have required either stateful callbacks, or storing redundant/tempo=
rary
> cap data in driver-private structures just to satisfy the callback.

I just realized something reviewing your patch: we don't necessarily
need an extra argument or a callback, we can just put these fields into
drm_hdmi_connector_funcs directly, and then validate them in init.

Maxime

--27ucv5zt2ny4lmlg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCak0k1gAKCRAnX84Zoj2+
due8AX0XXDyb8dUS4C5ZJ9bIc3vTW8oheRYR3cfa67hC4Uk3O3eEE85WAlMdVZCI
eLU/TTkBfjc45nJFNa7QA9rRNN4TXSGeA/gFgRjwuvyZ7kaa+wjdc0ucP72zaBpk
vOwNPyr2SQ==
=Qd48
-----END PGP SIGNATURE-----

--27ucv5zt2ny4lmlg--

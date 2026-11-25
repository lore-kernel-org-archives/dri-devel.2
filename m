Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD535606A336
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9cCxKkR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 153C110FA19;
	Wed, 25 Nov 2026 09:17:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4651A10FA29
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 09:17:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 64667611BA;
 Wed, 25 Nov 2026 09:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2260E1F000C6;
 Wed, 25 Nov 2026 09:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795598251;
 bh=6LdnNqK9bmETN3MMj+UXmuGDtFqsIl9z/Yy1VzHbfsk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=W9cCxKkR9C7a5wqKZ5wzRsDnyT5R5of467Qu/95v5qk7boNrZ6eJqQCkuLeZzp8LN
 GiokbrM7UDxAZjv83TSEvJJkiVPgUpZhbEK0rQ8NYwpC/ft/+EtseG1HqjbCn7vp8j
 /Ux2WrmOz2N/k6xlN3WvoA+ObAGkIu5/zkdTqdp0rcAa0V6HsDx+FCEF1R791ugRTY
 YJFz4ETtkbNyMdg4z2gHGXMTZP/LUGp7ET8Hfm/1orLpCCmfapV3XCzoHPYSXAbEHh
 fvLQkOUWnHJxRFafBr6X/HPEitCbzvQcQod7eRGqi2/6E28F/2PRaJB6B82Av7tBLA
 gEeF6bpvPzX9A==
Date: Wed, 25 Nov 2026 10:17:28 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>
Subject: Re: [PATCH v9 13/42] drm/atomic_sro: Create drm_atomic_sro_state
 container
Message-ID: <awamDCF8_6VEhWJA@houat>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
 <20261120-drm-state-readout-v9-13-a67c2b45b8ec@kernel.org>
 <ff6aeb12-270e-4959-838a-260bed0fb336@ideasonboard.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="c3byawpcsa2i7rok"
Content-Disposition: inline
In-Reply-To: <ff6aeb12-270e-4959-838a-260bed0fb336@ideasonboard.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--c3byawpcsa2i7rok
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 13/42] drm/atomic_sro: Create drm_atomic_sro_state
 container
MIME-Version: 1.0

Hi Tomi,

Thanks for your review,

On Wed, Nov 25, 2026 at 10:55:24AM +0200, Tomi Valkeinen wrote:
> On 20/11/2026 14:55, Maxime Ripard wrote:
> > The SRO infrastructure needs a state container to collect the readout
> > states for all KMS objects. Unlike drm_atomic_commit which tracks old
> > and new states for atomic commits, this container only holds a single
> > state per object: the one read out from the hardware.
> >=20
> > Create struct drm_atomic_sro_state with arrays for planes, CRTCs,
> > connectors, and private objects, along with accessors to get and set
> > individual object states within it.
> >=20
> > Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >   drivers/gpu/drm/Makefile                   |   1 +
> >   drivers/gpu/drm/drm_atomic_state_readout.c | 491 ++++++++++++++++++++=
+++++++++
> >   include/drm/drm_atomic_state_readout.h     |  51 +++
> >   3 files changed, 543 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> > index 2c6bc093a923..e94b77497514 100644
> > --- a/drivers/gpu/drm/Makefile
> > +++ b/drivers/gpu/drm/Makefile
> > @@ -32,10 +32,11 @@ endif
> >   # Enable -Werror in CI and development
> >   subdir-ccflags-$(CONFIG_DRM_WERROR) +=3D -Werror
> >   drm-y :=3D \
> >   	drm_atomic.o \
> > +	drm_atomic_state_readout.o \
> >   	drm_atomic_uapi.o \
> >   	drm_auth.o \
> >   	drm_blend.o \
> >   	drm_bridge.o \
> >   	drm_cache.o \
> > diff --git a/drivers/gpu/drm/drm_atomic_state_readout.c b/drivers/gpu/d=
rm/drm_atomic_state_readout.c
> > new file mode 100644
> > index 000000000000..c00631800234
> > --- /dev/null
> > +++ b/drivers/gpu/drm/drm_atomic_state_readout.c
> > @@ -0,0 +1,491 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +#include <drm/drm_atomic.h>
> > +#include <drm/drm_atomic_state_readout.h>
> > +#include <drm/drm_bridge.h>
> > +#include <drm/drm_connector.h>
> > +#include <drm/drm_crtc.h>
> > +#include <drm/drm_drv.h>
> > +#include <drm/drm_plane.h>
> > +#include <drm/drm_print.h>
> > +#include <linux/module.h>
> > +#include <linux/sched/mm.h>
> > +
> > +#include "drm_internal.h"
> > +#include "drm_crtc_internal.h"
> > +
> > +struct __drm_atomic_sro_plane {
> > +	struct drm_plane *ptr;
> > +	struct drm_plane_state *state;
> > +};
> > +
> > +struct __drm_atomic_sro_crtc {
> > +	struct drm_crtc *ptr;
> > +	struct drm_crtc_state *state;
> > +};
> > +
> > +struct __drm_atomic_sro_connector {
> > +	struct drm_connector *ptr;
> > +	struct drm_connector_state *state;
> > +};
> > +
> > +struct __drm_atomic_sro_private_obj {
> > +	struct drm_private_obj *ptr;
> > +	struct drm_private_state *state;
> > +};
> > +
> > +struct drm_atomic_sro_state {
> > +	struct drm_device *dev;
> > +	struct __drm_atomic_sro_plane *planes;
> > +	struct __drm_atomic_sro_crtc *crtcs;
> > +	struct __drm_atomic_sro_connector *connectors;
> > +	unsigned int max_connector_index;
> > +	struct __drm_atomic_sro_private_obj *private_objs;
> > +	unsigned int num_private_objs;
>=20
> The private_objs makes me feel a bit uneasy. You add to private_objs array
> dynamically, without any check for the array size. An extra call to
> drm_atomic_sro_set_private_obj_state() will write over the array.
>=20
> If you're sure that can never happen, fine for me.

I don't think it's a concern for private_objs. They do not support
dynamic registration, and we initialize the array with the total number
of private_objs registered, so we over-allocate and cannot (I think?)
end up in a situation where we have a private_obj without a slot.

Maxime

--c3byawpcsa2i7rok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCawannwAKCRAnX84Zoj2+
dmzcAYCAyOfqBZ051ybtzwEJXNjL/Rh3OMhGoQ0GV6mCGMXcPTulpMpmlw/T8OBr
Pdq+2c4BgNzK8V2nMTzwXB3GS7Vt5ilADAQNS/Jqoxujwzu11pw3FziMtBZfHvy/
4HNjMkpobA==
=g8LE
-----END PGP SIGNATURE-----

--c3byawpcsa2i7rok--

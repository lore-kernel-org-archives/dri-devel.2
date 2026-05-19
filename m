Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E0BCD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:56:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AE9310E3C3;
	Tue, 19 May 2026 08:56:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="aDUTRtO+";
	dkim-atps=neutral
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF02310E3C3
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:56:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779180957; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KBv78Z9Q4uNMQIqTapgip9tHSxW9ohBzDJw/dkyZF1J1UpuYBJL+FDKRnPVTzTYzK7cwehTqa/TAgE2WwT+KG+YvyEkhm63aX4sMXgU5/T9XeBw9B5Jh6g8MrjyoERApm2ETNK/8eqym5H6bUTj9o8tIMBRVrxTSRjut2V+5K+s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779180957;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=dpB5NciRt73piPYGVxD0DLmGGkRppeM+/INGsHC7UAE=; 
 b=oFrtisNKJ/7rGEzXzM/Mk5MFxcmaqxraWSuScR6RWdZzZ1xaFAp/yGvsCsCHZ6olqSjkHjcdzH6BQ9uDs5CJKAsZCaVjQvMKPslEHBvNKxtsHI91ok26TEJZEKeyp3cfozR5MFNVYKcK53AeAvfPPdahYoXaZE3MHiCiqGNUhdQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779180957; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=dpB5NciRt73piPYGVxD0DLmGGkRppeM+/INGsHC7UAE=;
 b=aDUTRtO+0VgcOyT8Em6cfDjjV6A2Xkk72plF0raj0DOQuqVRRNuFxHaGV7oVwJf6
 MLtcQldvX5zOGeJovMpfQwXkQebdLT9uDdaqidl6cpdAymgnqkq+JKWd52F/NCs60CV
 ofiJJ7i0vFPvGkiD7cTljm8y3iJvi1eTh6BjiettTAkHG/2vqCZJTpKsvnZZe7/ewal
 m8lWWSnSTEbjE8bOcgWTR9X+5iMMD7361E7V0m+UWvvsG5Q6aMSN/pu7epq7v9k264e
 giZfDsXnrSEe2ZcYsXR75eKvUoWwAc8M2Ec2+oNmj0xdsvAZo6R45QrexB9KQJr3UqT
 2XBuFEhXpw==
Received: by mx.zohomail.com with SMTPS id 1779180956161190.65978070500103;
 Tue, 19 May 2026 01:55:56 -0700 (PDT)
Message-ID: <d12e6d716bc988f028eeaaaed329442965b4431f.camel@icenowy.me>
Subject: Re: [PATCH v3 2/2] drm: verisilicon: add support for cursor planes
From: Icenowy Zheng <uwu@icenowy.me>
To: Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Han Gao
 <rabenda.cn@gmail.com>
Date: Tue, 19 May 2026 16:55:51 +0800
In-Reply-To: <49290671-92ee-4fbc-aef9-972ac976cf42@suse.de>
References: <20260506175610.2542888-1-zhengxingda@iscas.ac.cn>
 <20260506175610.2542888-3-zhengxingda@iscas.ac.cn>
 <49290671-92ee-4fbc-aef9-972ac976cf42@suse.de>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-ZohoMailClient: External
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

=E5=9C=A8 2026-05-07=E5=9B=9B=E7=9A=84 08:07 +0200=EF=BC=8CThomas Zimmerman=
n=E5=86=99=E9=81=93=EF=BC=9A
> Hi
>=20
> Am 06.05.26 um 19:56 schrieb Icenowy Zheng:
> > Verisilicon display controllers support hardware cursors per output
> > port.
> >=20
> > Add support for them as cursor planes.
> >=20
> > Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
>=20
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>=20
> You should get commit access to drm-misc, if you haven't already.
>=20
> https://drm.pages.freedesktop.org/maintainer-tools/committer/commit-acces=
s.html

I raised a request at [1].

It looks like the auto labelling/assigning in the template doesn't work
(they just disappeared after submitting the issue).

[1] https://gitlab.freedesktop.org/drm/misc/kernel/-/work_items/88

Thanks,
Icenowy

>=20
> Best regards
> Thomas
>=20
> > ---
> > Changes in v3:
> > - Moved the validity check for max_cursor_size to
> > =C2=A0=C2=A0 vs_cursor_plane_init().
> > - Removed NULL check for new_plane_state->fb because
> > =C2=A0=C2=A0 drm_atomic_helper_check_plane_state() will set visibility =
to
> > false in
> > =C2=A0=C2=A0 such case.
> > Changes in v2:
> > - Use is_power_of_two instead of switch to validate cursor size.
> > - Remove unneeded format check.
> > - Skip the whole validity check if the plane is invisible
> > (previously
> > =C2=A0=C2=A0 it's only skipped when the plane is not bound to CRTC).
> > - Explicitly set modifiers list (linear only).
> >=20
> > =C2=A0 drivers/gpu/drm/verisilicon/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
> > =C2=A0 drivers/gpu/drm/verisilicon/vs_crtc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 11 +-
> > =C2=A0 drivers/gpu/drm/verisilicon/vs_cursor_plane.c | 272
> > ++++++++++++++++++
> > =C2=A0 .../drm/verisilicon/vs_cursor_plane_regs.h=C2=A0=C2=A0=C2=A0 |=
=C2=A0 44 +++
> > =C2=A0 drivers/gpu/drm/verisilicon/vs_plane.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0 5 files changed, 328 insertions(+), 3 deletions(-)
> > =C2=A0 create mode 100644 drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> > =C2=A0 create mode 100644
> > drivers/gpu/drm/verisilicon/vs_cursor_plane_regs.h
> >=20
> > diff --git a/drivers/gpu/drm/verisilicon/Makefile
> > b/drivers/gpu/drm/verisilicon/Makefile
> > index fd8d805fbcde1..426f4bcaa834d 100644
> > --- a/drivers/gpu/drm/verisilicon/Makefile
> > +++ b/drivers/gpu/drm/verisilicon/Makefile
> > @@ -1,5 +1,6 @@
> > =C2=A0 # SPDX-License-Identifier: GPL-2.0-only
> > =C2=A0=20
> > -verisilicon-dc-objs :=3D vs_bridge.o vs_crtc.o vs_dc.o vs_drm.o
> > vs_hwdb.o vs_plane.o vs_primary_plane.o
> > +verisilicon-dc-objs :=3D vs_bridge.o vs_crtc.o vs_dc.o vs_drm.o
> > vs_hwdb.o \
> > +	vs_plane.o vs_primary_plane.o vs_cursor_plane.o
> > =C2=A0=20
> > =C2=A0 obj-$(CONFIG_DRM_VERISILICON_DC) +=3D verisilicon-dc.o
> > diff --git a/drivers/gpu/drm/verisilicon/vs_crtc.c
> > b/drivers/gpu/drm/verisilicon/vs_crtc.c
> > index f494017130006..5c9714a3e69a7 100644
> > --- a/drivers/gpu/drm/verisilicon/vs_crtc.c
> > +++ b/drivers/gpu/drm/verisilicon/vs_crtc.c
> > @@ -159,7 +159,7 @@ struct vs_crtc *vs_crtc_init(struct drm_device
> > *drm_dev, struct vs_dc *dc,
> > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int output)
> > =C2=A0 {
> > =C2=A0=C2=A0	struct vs_crtc *vcrtc;
> > -	struct drm_plane *primary;
> > +	struct drm_plane *primary, *cursor;
> > =C2=A0=C2=A0	int ret;
> > =C2=A0=20
> > =C2=A0=C2=A0	vcrtc =3D drmm_kzalloc(drm_dev, sizeof(*vcrtc), GFP_KERNEL=
);
> > @@ -175,9 +175,16 @@ struct vs_crtc *vs_crtc_init(struct drm_device
> > *drm_dev, struct vs_dc *dc,
> > =C2=A0=C2=A0		return ERR_PTR(PTR_ERR(primary));
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > +	/* Create our cursor plane */
> > +	cursor =3D vs_cursor_plane_init(drm_dev, dc);
> > +	if (IS_ERR(cursor)) {
> > +		drm_err(drm_dev, "Couldn't create the cursor
> > plane\n");
> > +		return ERR_CAST(cursor);
> > +	}
> > +
> > =C2=A0=C2=A0	ret =3D drmm_crtc_init_with_planes(drm_dev, &vcrtc->base,
> > =C2=A0=C2=A0					 primary,
> > -					 NULL,
> > +					 cursor,
> > =C2=A0=C2=A0					 &vs_crtc_funcs,
> > =C2=A0=C2=A0					 NULL);
> > =C2=A0=C2=A0	if (ret) {
> > diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> > b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> > new file mode 100644
> > index 0000000000000..acb9854fa67ed
> > --- /dev/null
> > +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> > @@ -0,0 +1,272 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2026 Institute of Software, Chinese Academy of
> > Sciences (ISCAS)
> > + *
> > + * Authors:
> > + * Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > + */
> > +
> > +#include <linux/log2.h>
> > +#include <linux/regmap.h>
> > +
> > +#include <drm/drm_atomic.h>
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_crtc.h>
> > +#include <drm/drm_fourcc.h>
> > +#include <drm/drm_framebuffer.h>
> > +#include <drm/drm_gem_atomic_helper.h>
> > +#include <drm/drm_modeset_helper_vtables.h>
> > +#include <drm/drm_plane.h>
> > +#include <drm/drm_print.h>
> > +
> > +#include "vs_crtc.h"
> > +#include "vs_plane.h"
> > +#include "vs_dc.h"
> > +#include "vs_hwdb.h"
> > +#include "vs_cursor_plane_regs.h"
> > +
> > +#define VSDC_MIN_CURSOR_SIZE 32
> > +#define VSDC_MAX_CURSOR_SIZE 256
> > +
> > +#define VSDC_CURSOR_LOCATION_MAX_POSITIVE BIT_MASK(15)
> > +#define VSDC_CURSOR_LOCATION_MAX_NEGATIVE BIT_MASK(5)
> > +
> > +static bool vs_cursor_plane_check_coord(int32_t coord)
> > +{
> > +	if (coord >=3D 0)
> > +		return coord <=3D VSDC_CURSOR_LOCATION_MAX_POSITIVE;
> > +	else
> > +		return (-coord) <=3D
> > VSDC_CURSOR_LOCATION_MAX_NEGATIVE;
> > +}
> > +
> > +static int vs_cursor_plane_atomic_check(struct drm_plane *plane,
> > +					struct drm_atomic_state
> > *state)
> > +{
> > +	struct drm_plane_state *new_plane_state =3D
> > drm_atomic_get_new_plane_state(state,
> > +							=09
> > 		 plane);
> > +	struct drm_crtc *crtc =3D new_plane_state->crtc;
> > +	struct drm_framebuffer *fb =3D new_plane_state->fb;
> > +	struct drm_crtc_state *crtc_state =3D NULL;
> > +	struct vs_crtc *vcrtc;
> > +	struct vs_dc *dc;
> > +	int ret;
> > +
> > +	if (crtc)
> > +		crtc_state =3D drm_atomic_get_new_crtc_state(state,
> > crtc);
> > +
> > +	ret =3D drm_atomic_helper_check_plane_state(new_plane_state,
> > +						=C2=A0 crtc_state,
> > +						=C2=A0
> > DRM_PLANE_NO_SCALING,
> > +						=C2=A0
> > DRM_PLANE_NO_SCALING,
> > +						=C2=A0 true, true);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!new_plane_state->visible)
> > +		return 0; /* Skip validity check */
> > +
> > +	vcrtc =3D drm_crtc_to_vs_crtc(crtc);
> > +	dc =3D vcrtc->dc;
> > +
> > +	/* Only certain PoT square sizes is supported. */
> > +	if (!is_power_of_2(new_plane_state->crtc_w) ||
> > +	=C2=A0=C2=A0=C2=A0 new_plane_state->crtc_w < VSDC_MIN_CURSOR_SIZE ||
> > +	=C2=A0=C2=A0=C2=A0 new_plane_state->crtc_w > dc-
> > >identity.max_cursor_size)
> > +		return -EINVAL;
> > +
> > +	if (new_plane_state->crtc_w !=3D new_plane_state->crtc_h)
> > +		return -EINVAL;
> > +
> > +	/* Check if the cursor is inside the register fields'
> > range */
> > +	if (!vs_cursor_plane_check_coord(new_plane_state->crtc_x)
> > ||
> > +	=C2=A0=C2=A0=C2=A0 !vs_cursor_plane_check_coord(new_plane_state->crtc=
_y))
> > +		return -EINVAL;
> > +
> > +	/* Extra line padding isn't supported */
> > +	if (fb->pitches[0] !=3D
> > +	=C2=A0=C2=A0=C2=A0 drm_format_info_min_pitch(fb->format, 0,
> > new_plane_state->crtc_w))
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +static void vs_cursor_plane_commit(struct vs_dc *dc, unsigned int
> > output)
> > +{
> > +	regmap_set_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
> > +			VSDC_CURSOR_CONFIG_COMMIT |
> > +			VSDC_CURSOR_CONFIG_IMG_UPDATE);
> > +}
> > +
> > +static void vs_cursor_plane_atomic_enable(struct drm_plane *plane,
> > +					=C2=A0=C2=A0 struct drm_atomic_state
> > *atomic_state)
> > +{
> > +	struct drm_plane_state *state =3D
> > drm_atomic_get_new_plane_state(atomic_state,
> > +								=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 plane);
> > +	struct drm_crtc *crtc =3D state->crtc;
> > +	struct vs_crtc *vcrtc =3D drm_crtc_to_vs_crtc(crtc);
> > +	unsigned int output =3D vcrtc->id;
> > +	struct vs_dc *dc =3D vcrtc->dc;
> > +
> > +	regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
> > +			=C2=A0=C2=A0 VSDC_CURSOR_CONFIG_FMT_MASK,
> > +			=C2=A0=C2=A0 VSDC_CURSOR_CONFIG_FMT_ARGB8888);
> > +
> > +	vs_cursor_plane_commit(dc, output);
> > +}
> > +
> > +static void vs_cursor_plane_atomic_disable(struct drm_plane
> > *plane,
> > +					=C2=A0=C2=A0=C2=A0 struct
> > drm_atomic_state *atomic_state)
> > +{
> > +	struct drm_plane_state *state =3D
> > drm_atomic_get_old_plane_state(atomic_state,
> > +								=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 plane);
> > +	struct drm_crtc *crtc =3D state->crtc;
> > +	struct vs_crtc *vcrtc =3D drm_crtc_to_vs_crtc(crtc);
> > +	unsigned int output =3D vcrtc->id;
> > +	struct vs_dc *dc =3D vcrtc->dc;
> > +
> > +	regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
> > +			=C2=A0=C2=A0 VSDC_CURSOR_CONFIG_FMT_MASK,
> > +			=C2=A0=C2=A0 VSDC_CURSOR_CONFIG_FMT_OFF);
> > +
> > +	vs_cursor_plane_commit(dc, output);
> > +}
> > +
> > +static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
> > +					=C2=A0=C2=A0 struct drm_atomic_state
> > *atomic_state)
> > +{
> > +	struct drm_plane_state *state =3D
> > drm_atomic_get_new_plane_state(atomic_state,
> > +								=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 plane);
> > +	struct drm_framebuffer *fb =3D state->fb;
> > +	struct drm_crtc *crtc =3D state->crtc;
> > +	struct vs_dc *dc;
> > +	struct vs_crtc *vcrtc;
> > +	unsigned int output;
> > +	dma_addr_t dma_addr;
> > +
> > +	if (!state->visible) {
> > +		vs_cursor_plane_atomic_disable(plane,
> > atomic_state);
> > +		return;
> > +	}
> > +
> > +	vcrtc =3D drm_crtc_to_vs_crtc(crtc);
> > +	output =3D vcrtc->id;
> > +	dc =3D vcrtc->dc;
> > +
> > +	/* Other sizes should be rejected by atomic_check */
> > +	switch (state->crtc_w) {
> > +	case 32:
> > +		regmap_update_bits(dc->regs,
> > VSDC_CURSOR_CONFIG(output),
> > +				=C2=A0=C2=A0 VSDC_CURSOR_CONFIG_SIZE_MASK,
> > +				=C2=A0=C2=A0 VSDC_CURSOR_CONFIG_SIZE_32);
> > +		break;
> > +	case 64:
> > +		regmap_update_bits(dc->regs,
> > VSDC_CURSOR_CONFIG(output),
> > +				=C2=A0=C2=A0 VSDC_CURSOR_CONFIG_SIZE_MASK,
> > +				=C2=A0=C2=A0 VSDC_CURSOR_CONFIG_SIZE_64);
> > +		break;
> > +	case 128:
> > +		regmap_update_bits(dc->regs,
> > VSDC_CURSOR_CONFIG(output),
> > +				=C2=A0=C2=A0 VSDC_CURSOR_CONFIG_SIZE_MASK,
> > +				=C2=A0=C2=A0 VSDC_CURSOR_CONFIG_SIZE_128);
> > +		break;
> > +	case 256:
> > +		regmap_update_bits(dc->regs,
> > VSDC_CURSOR_CONFIG(output),
> > +				=C2=A0=C2=A0 VSDC_CURSOR_CONFIG_SIZE_MASK,
> > +				=C2=A0=C2=A0 VSDC_CURSOR_CONFIG_SIZE_256);
> > +		break;
> > +	}
> > +
> > +	dma_addr =3D vs_fb_get_dma_addr(fb, &state->src);
> > +
> > +	regmap_write(dc->regs, VSDC_CURSOR_ADDRESS(output),
> > +		=C2=A0=C2=A0=C2=A0=C2=A0 lower_32_bits(dma_addr));
> > +
> > +	/*
> > +	 * The X_OFF and Y_OFF fields define which point does the
> > LOCATION
> > +	 * register represent in the cursor image, and LOCATION
> > register
> > +	 * values are unsigned. To for positive left-top=C2=A0
> > coordinates the
> > +	 * offset is set to 0 and the location is set to the
> > coordinate, for
> > +	 * negative coordinates the location is set to 0 and the
> > offset
> > +	 * is set to the opposite number of the coordinate to
> > offset the
> > +	 * cursor image partly off-screen.
> > +	 */
> > +	if (state->crtc_x >=3D 0) {
> > +		regmap_update_bits(dc->regs,
> > VSDC_CURSOR_CONFIG(output),
> > +				=C2=A0=C2=A0 VSDC_CURSOR_CONFIG_X_OFF_MASK,
> > 0);
> > +		regmap_update_bits(dc->regs,
> > VSDC_CURSOR_LOCATION(output),
> > +				=C2=A0=C2=A0 VSDC_CURSOR_LOCATION_X_MASK,
> > +				=C2=A0=C2=A0 VSDC_CURSOR_LOCATION_X(state-
> > >crtc_x));
> > +	} else {
> > +		regmap_update_bits(dc->regs,
> > VSDC_CURSOR_CONFIG(output),
> > +				=C2=A0=C2=A0 VSDC_CURSOR_CONFIG_X_OFF_MASK,
> > +				=C2=A0=C2=A0 -state->crtc_x);
> > +		regmap_update_bits(dc->regs,
> > VSDC_CURSOR_LOCATION(output),
> > +				=C2=A0=C2=A0 VSDC_CURSOR_LOCATION_X_MASK,
> > 0);
> > +	}
> > +
> > +	if (state->crtc_y >=3D 0) {
> > +		regmap_update_bits(dc->regs,
> > VSDC_CURSOR_CONFIG(output),
> > +				=C2=A0=C2=A0 VSDC_CURSOR_CONFIG_Y_OFF_MASK,
> > 0);
> > +		regmap_update_bits(dc->regs,
> > VSDC_CURSOR_LOCATION(output),
> > +				=C2=A0=C2=A0 VSDC_CURSOR_LOCATION_Y_MASK,
> > +				=C2=A0=C2=A0 VSDC_CURSOR_LOCATION_Y(state-
> > >crtc_y));
> > +	} else {
> > +		regmap_update_bits(dc->regs,
> > VSDC_CURSOR_CONFIG(output),
> > +				=C2=A0=C2=A0 VSDC_CURSOR_CONFIG_Y_OFF_MASK,
> > +				=C2=A0=C2=A0 -state->crtc_y);
> > +		regmap_update_bits(dc->regs,
> > VSDC_CURSOR_LOCATION(output),
> > +				=C2=A0=C2=A0 VSDC_CURSOR_LOCATION_Y_MASK,
> > 0);
> > +	}
> > +
> > +	vs_cursor_plane_commit(dc, output);
> > +}
> > +
> > +static const struct drm_plane_helper_funcs
> > vs_cursor_plane_helper_funcs =3D {
> > +	.atomic_check	=3D vs_cursor_plane_atomic_check,
> > +	.atomic_update	=3D vs_cursor_plane_atomic_update,
> > +	.atomic_enable	=3D vs_cursor_plane_atomic_enable,
> > +	.atomic_disable	=3D vs_cursor_plane_atomic_disable,
> > +};
> > +
> > +static const struct drm_plane_funcs vs_cursor_plane_funcs =3D {
> > +	.atomic_destroy_state	=3D
> > drm_atomic_helper_plane_destroy_state,
> > +	.atomic_duplicate_state	=3D
> > drm_atomic_helper_plane_duplicate_state,
> > +	.disable_plane		=3D drm_atomic_helper_disable_plane,
> > +	.reset			=3D drm_atomic_helper_plane_reset,
> > +	.update_plane		=3D drm_atomic_helper_update_plane,
> > +};
> > +
> > +static const u32 vs_cursor_plane_formats[] =3D {
> > +	DRM_FORMAT_ARGB8888,
> > +};
> > +
> > +static const u64 vs_cursor_plane_modifiers[] =3D {
> > +	DRM_FORMAT_MOD_LINEAR,
> > +	DRM_FORMAT_MOD_INVALID, /* sentinel */
> > +};
> > +
> > +struct drm_plane *vs_cursor_plane_init(struct drm_device *drm_dev,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vs_dc *dc)
> > +{
> > +	int32_t max_cursor_size =3D dc->identity.max_cursor_size;
> > +	struct drm_plane *plane;
> > +
> > +	if (drm_WARN_ON_ONCE(drm_dev, max_cursor_size <
> > VSDC_MIN_CURSOR_SIZE ||
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max_cursor_size >
> > VSDC_MAX_CURSOR_SIZE))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	plane =3D drmm_universal_plane_alloc(drm_dev, struct
> > drm_plane, dev, 0,
> > +					=C2=A0=C2=A0 &vs_cursor_plane_funcs,
> > +					=C2=A0=C2=A0
> > vs_cursor_plane_formats,
> > +					=C2=A0=C2=A0
> > ARRAY_SIZE(vs_cursor_plane_formats),
> > +					=C2=A0=C2=A0
> > vs_cursor_plane_modifiers,
> > +					=C2=A0=C2=A0 DRM_PLANE_TYPE_CURSOR,
> > +					=C2=A0=C2=A0 NULL);
> > +
> > +	if (IS_ERR(plane))
> > +		return plane;
> > +
> > +	drm_plane_helper_add(plane,
> > &vs_cursor_plane_helper_funcs);
> > +
> > +	return plane;
> > +}
> > diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane_regs.h
> > b/drivers/gpu/drm/verisilicon/vs_cursor_plane_regs.h
> > new file mode 100644
> > index 0000000000000..99693f2c95b94
> > --- /dev/null
> > +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane_regs.h
> > @@ -0,0 +1,44 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Copyright (C) 2025 Icenowy Zheng <uwu@icenowy.me>
> > + *
> > + * Based on vs_dc_hw.h, which is:
> > + *=C2=A0=C2=A0 Copyright (C) 2023 VeriSilicon Holdings Co., Ltd.
> > + */
> > +
> > +#ifndef _VS_CURSOR_PLANE_REGS_H_
> > +#define _VS_CURSOR_PLANE_REGS_H_
> > +
> > +#include <linux/bits.h>
> > +
> > +#define VSDC_CURSOR_CONFIG(n)		(0x1468 + 0x1080 * (n))
> > +#define VSDC_CURSOR_CONFIG_FMT_MASK	GENMASK(1, 0)
> > +#define VSDC_CURSOR_CONFIG_FMT_ARGB8888	(0x2 << 0)
> > +#define VSDC_CURSOR_CONFIG_FMT_OFF	(0x0 << 0)
> > +#define VSDC_CURSOR_CONFIG_IMG_UPDATE	BIT(2)
> > +#define VSDC_CURSOR_CONFIG_COMMIT	BIT(3)
> > +#define VSDC_CURSOR_CONFIG_SIZE_MASK	GENMASK(7, 5)
> > +#define VSDC_CURSOR_CONFIG_SIZE_32	(0x0 << 5)
> > +#define VSDC_CURSOR_CONFIG_SIZE_64	(0x1 << 5)
> > +#define VSDC_CURSOR_CONFIG_SIZE_128	(0x2 << 5)
> > +#define VSDC_CURSOR_CONFIG_SIZE_256	(0x3 << 5)
> > +#define VSDC_CURSOR_CONFIG_Y_OFF_MASK	GENMASK(12, 8)
> > +#define VSDC_CURSOR_CONFIG_Y_OFF(v)	((v) << 8)
> > +#define VSDC_CURSOR_CONFIG_X_OFF_MASK	GENMASK(20, 16)
> > +#define VSDC_CURSOR_CONFIG_X_OFF(v)	((v) << 16)
> > +
> > +#define VSDC_CURSOR_ADDRESS(n)		(0x146C + 0x1080 * (n))
> > +
> > +#define VSDC_CURSOR_LOCATION(n)		(0x1470 + 0x1080 *
> > (n))
> > +#define VSDC_CURSOR_LOCATION_X_MASK	GENMASK(14, 0)
> > +#define VSDC_CURSOR_LOCATION_X(v)	((v) << 0)
> > +#define VSDC_CURSOR_LOCATION_Y_MASK	GENMASK(30, 16)
> > +#define VSDC_CURSOR_LOCATION_Y(v)	((v) << 16)
> > +
> > +#define VSDC_CURSOR_BACKGROUND(n)	(0x1474 + 0x1080 * (n))
> > +#define VSDC_CURSOR_BACKGRUOND_DEFAULT	0x00FFFFFF
> > +
> > +#define VSDC_CURSOR_FOREGROUND(n)	(0x1478 + 0x1080 * (n))
> > +#define VSDC_CURSOR_FOREGRUOND_DEFAULT	0x00AAAAAA
> > +
> > +#endif /* _VS_CURSOR_PLANE_REGS_H_ */
> > diff --git a/drivers/gpu/drm/verisilicon/vs_plane.h
> > b/drivers/gpu/drm/verisilicon/vs_plane.h
> > index 41875ea3d66a5..60b5b3a1bc22a 100644
> > --- a/drivers/gpu/drm/verisilicon/vs_plane.h
> > +++ b/drivers/gpu/drm/verisilicon/vs_plane.h
> > @@ -68,5 +68,6 @@ dma_addr_t vs_fb_get_dma_addr(struct
> > drm_framebuffer *fb,
> > =C2=A0=C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct drm_rect *sr=
c_rect);
> > =C2=A0=20
> > =C2=A0 struct drm_plane *vs_primary_plane_init(struct drm_device *dev,
> > struct vs_dc *dc);
> > +struct drm_plane *vs_cursor_plane_init(struct drm_device *dev,
> > struct vs_dc *dc);
> > =C2=A0=20
> > =C2=A0 #endif /* _VS_PLANE_H_ */

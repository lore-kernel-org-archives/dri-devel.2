Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47BEC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47E8810F08B;
	Thu, 27 Aug 2026 14:21:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b0mU+1Vu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36CCF10F08E
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:21:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 589F7600E4;
 Thu, 27 Aug 2026 14:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D121F00A3A;
 Thu, 27 Aug 2026 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787840500;
 bh=yAwHprr3gGTVSCqFGb4BMg8B4Vu9VUvHQO14FMdDV5A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b0mU+1VuntVvgH9YGWVaNNoPoIoGXXYfrsOF03AQiGNFkUg/dP6uP89516zEvPWLD
 O2LVXG8SRceQsYlgTClC86JBpEGGzWGMV4x+FyUSS7GStIZXwiC98iLABVuaAcYpTo
 9j7czrGA/411wMAXE3BFpzQx5sKKNwK41SqO27lSKzchpVGeRnkoLLnhop5K3aEl5M
 lJpcI3pr2KmcrBpaA1scqn8FLmobmaQ16aOt3VhuumiFkNgBSmcsgOpkQV4Wu6aM0b
 1bslen3swIOrgfCGIOMMZLOS6G3dS7yIPW9QH5gF7OO3EeJusNJH3NLW9f+RgatD4f
 ihYSf7fRT8bXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/sysfb: Use preferred panel size for panel
 orientation quirks
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260827140726.420734-3-tzimmermann@suse.de>
References: <20260827140726.420734-1-tzimmermann@suse.de>
 <20260827140726.420734-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 14:21:39 +0000
Message-Id: <20260827142139.E0D121F00A3A@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The sysfb drivers parse unvalidated EDID data to extract the pre=
ferred size.

Pre-existing issues:
- [High] drm_edid_get_preferred_size() incorrectly checks the value pointed=
 to by width/height instead of validating the pointers themselves.
--

commit df008c5490e15b30036ebe81983d7a6c0c6e5b33
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/sysfb: Use preferred panel size for panel orientation quirks

Sysfb drivers currently use the given display mode for looking up the
panel orientation. But the look-up table stores the native geometry of
the panels, so the lookup fails if the current mode sizes differs.

Get the panel's native geometry with drm_edid_get_preferred_size() from
the EDID and use it for looking up the panel orientation.

> diff --git a/drivers/gpu/drm/sysfb/efidrm.c b/drivers/gpu/drm/sysfb/efidr=
m.c
> index 3f9cd5d03efb2..7a7d12003304f 100644
> --- a/drivers/gpu/drm/sysfb/efidrm.c
> +++ b/drivers/gpu/drm/sysfb/efidrm.c
[ ... ]
> @@ -217,6 +218,20 @@ static struct efidrm_device *efidrm_device_create(st=
ruct drm_driver *drv,
>  	if (drm_edid_header_is_valid(dpy->edid.dummy) =3D=3D 8)
>  		sysfb->edid =3D dpy->edid.dummy;
>  #endif
> +
> +	panel_width =3D width;
> +	panel_height =3D height;
> +
> +	if (sysfb->edid) {
> +		const struct drm_edid *drm_edid;
> +
> +		drm_edid =3D drm_edid_alloc(sysfb->edid, EDID_LENGTH);
> +		if (drm_edid) {
> +			drm_edid_get_preferred_size(drm_edid, &panel_width, &panel_height);

[Severity: High]
This isn't a bug introduced by this patch, but I wanted to ask about the
semantics of drm_edid_get_preferred_size(). In drivers/gpu/drm/drm_edid.c,
it does:

	if (*width)
		*width =3D (pt->hactive_hblank_hi & 0xf0) << 4 | pt->hactive_lo;
	if (*height)
		*height =3D (pt->vactive_vblank_hi & 0xf0) << 4 | pt->vactive_lo;

This incorrectly checks the values pointed to by width/height instead of
validating the pointers themselves. A caller passing a NULL pointer for
either width or height will cause a kernel panic (NULL pointer dereference).

Furthermore, passing a pointer to a zero-initialized variable evaluates to
false, causing the function to silently skip populating the preferred size.
While this patch bypasses the crash by passing non-NULL pointers initialized
to >0, is it worth fixing the generic API so other callers do not trip over
this?

[Severity: Medium]
Does parsing an unvalidated EDID block pose a risk here? The sysfb drivers
parse unvalidated EDID data to extract the preferred size.

If the firmware provides a corrupted EDID where only the 8-byte header is
valid, this code extracts geometry from potentially corrupted firmware data,
which can result in bogus resolutions being passed to the panel orientation
quirk lookup.

> +			drm_edid_free(drm_edid);
> +		}
> +	}
> +

[ ... ]
> diff --git a/drivers/gpu/drm/sysfb/ofdrm.c b/drivers/gpu/drm/sysfb/ofdrm.c
> index 819aed466727e..6cf2440d7d9e2 100644
> --- a/drivers/gpu/drm/sysfb/ofdrm.c
> +++ b/drivers/gpu/drm/sysfb/ofdrm.c
[ ... ]
> @@ -994,6 +995,19 @@ static struct ofdrm_device *ofdrm_device_create(stru=
ct drm_driver *drv,
>  		sysfb->fb_gamma_lut_size =3D OFDRM_GAMMA_LUT_SIZE;
>  	sysfb->edid =3D edid;
> =20
> +	panel_width =3D width;
> +	panel_height =3D height;
> +
> +	if (sysfb->edid) {
> +		const struct drm_edid *drm_edid;
> +
> +		drm_edid =3D drm_edid_alloc(sysfb->edid, EDID_LENGTH);
> +		if (drm_edid) {
> +			drm_edid_get_preferred_size(drm_edid, &panel_width, &panel_height);

[Severity: Medium]
Similarly here in ofdrm_device_create(), unvalidated EDID data is parsed.
Could this lead to bogus geometry being extracted from a corrupted EDID?

> +			drm_edid_free(drm_edid);
> +		}
> +	}
> +

[ ... ]
> diff --git a/drivers/gpu/drm/sysfb/vesadrm.c b/drivers/gpu/drm/sysfb/vesa=
drm.c
> index 6a67b2d2e451b..8c52bbac6d2ff 100644
> --- a/drivers/gpu/drm/sysfb/vesadrm.c
> +++ b/drivers/gpu/drm/sysfb/vesadrm.c
[ ... ]
> @@ -484,6 +485,20 @@ static struct vesadrm_device *vesadrm_device_create(=
struct drm_driver *drv,
>  	if (drm_edid_header_is_valid(dpy->edid.dummy) =3D=3D 8)
>  		sysfb->edid =3D dpy->edid.dummy;
>  #endif
> +
> +	panel_width =3D width;
> +	panel_height =3D height;
> +
> +	if (sysfb->edid) {
> +		const struct drm_edid *drm_edid;
> +
> +		drm_edid =3D drm_edid_alloc(sysfb->edid, EDID_LENGTH);
> +		if (drm_edid) {
> +			drm_edid_get_preferred_size(drm_edid, &panel_width, &panel_height);

[Severity: Medium]
Likewise in vesadrm_device_create(), parsing unvalidated EDID data may
result in bogus resolutions being passed to the panel orientation quirk
lookup. Should the EDID be fully validated first?

> +			drm_edid_free(drm_edid);
> +		}
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827140726.4207=
34-1-tzimmermann@suse.de?part=3D2

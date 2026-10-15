Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DDCCC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 144DC112416;
	Thu, 15 Oct 2026 16:50:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D068112416
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:50:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 032F941A66
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 16:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6F01F000C4;
 Thu, 15 Oct 2026 16:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792083004;
 bh=nBr2dZmTyfKKOJyQbVXXAaoBORsIM+drTq84MO4rZvM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lA6W+btD/p1KhGuATcMt8DYxSIk06LsLOP6+T2JHFIEQ/d7cJlYrjkqZWurbQpBwv
 eguqI6Jb4/4Y/ycunJE6Op94ROSiOUV6NlGE4Gm7aIjL/nszDfQ/D3jiIqsBIvkzwM
 FJrWBGX3FX8C6RC7ckE7yEXFM7LRqMuLtm52XbLflMCbAT0erwiJk5/R2h6pVciN/m
 GWLR0kpLD2bBe27cGDQgbUC7pSNV5+yQeCchdfL6LGMtdE1u50H/4vrssYzcfm4VoA
 or5IDUUJyBY4c8H6hDqnWZsteXWQ8KSxTZdToRsGxx/bfjjPuOLciqJwVPkIonax0H
 gplyjV1LvajHA==
Message-ID: <sashiko-outbox-173204@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 18/28] drm/atomic-state-helper: Provide
 atomic_compare_state helpers
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-18-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-18-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 16:50:04 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] drm: atomic SRO state comparison spams on disabled objects
- [Low] drm/atomic-sro: STATE_CHECK_U32 and STATE_CHECK_BOOL cause static_a=
ssert build failures
- [Low] drm/atomic-sro: -Wformat compiler warning in STATE_CHECK_U32_16_16 =
macro
- [Low] drm: missing base state fields in atomic comparison helpers
--

commit a2faf4570ad763a12f621476faaa22b5502a3a73
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic-state-helper: Provide atomic_compare_state helpers

Now that we have introduced some new infrastructure to compare state
instances, provide helpers for the default states.

> diff --git a/drivers/gpu/drm/drm_atomic_sro_helper.c b/drivers/gpu/drm/dr=
m_atomic_sro_helper.c
> index 692a5a24d762c..46a733e4dcce5 100644
> --- a/drivers/gpu/drm/drm_atomic_sro_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_sro_helper.c
[ ... ]
> @@ -408,6 +409,245 @@ int drm_atomic_helper_sro_readout_state(struct drm_=
device *dev)
[ ... ]
> +bool drm_atomic_helper_plane_compare_state(struct drm_plane *plane,
> +					   struct drm_printer *p,
> +					   struct drm_plane_state *expected,
> +					   struct drm_plane_state *actual)
> +{
> +	bool ret =3D true;
> +
> +	STATE_CHECK_PTR(ret, p, plane->name, expected, actual, plane);
> +	STATE_CHECK_PTR(ret, p, plane->name, expected, actual, crtc);
> +
> +	if (expected->fb && actual->fb) {
> +		if (!drm_atomic_helper_fb_compare(p, expected->fb, actual->fb))
> +			ret =3D false;
> +	} else if (!(!expected->fb && !actual->fb)) {
> +		drm_atomic_helper_print_state_mismatch(p,
> +						       plane->name,
> +						       "fb",
> +						       "expected framebuffer is %s, got %s",
> +						       expected->fb ? "non-NULL" : "NULL",
> +						       actual->fb ? "non-NULL" : "NULL");
> +		ret =3D false;
> +	}
> +
> +	STATE_CHECK_S32(ret, p, plane->name, expected, actual, crtc_x);
> +	STATE_CHECK_S32(ret, p, plane->name, expected, actual, crtc_y);

[Severity: Medium]
Will this comparison cause false-positive mismatches when the plane is
disabled?

If expected->fb is NULL, the expected state retains the old coordinates but
the actual state readout is zeroed. Since these properties are compared
unconditionally, could this lead to persistent mismatch warnings in the
kernel log?

> +	STATE_CHECK_U32(ret, p, plane->name, expected, actual, crtc_w);
> +	STATE_CHECK_U32(ret, p, plane->name, expected, actual, crtc_h);
> +	STATE_CHECK_U32_16_16(ret, p, plane->name, expected, actual, src_x);

[Severity: Low]
This problem wasn't introduced by this patch, but using STATE_CHECK_U32_16_=
16
here triggers a -Wformat compiler warning.

The macro uses the %d format specifier for the result of a right shift on a
u32 (sa->f >> 16):

    "expected %d.%06u, got %d.%06u", \
    sa->f >> 16, ((sa->f & 0xffff) * 15625) >> 10, \

Since sa->f is required to be u32, the shift result is an unsigned int.
Passing an unsigned int to %d violates format string rules. Should this be
changed to %u?

> +	STATE_CHECK_U32_16_16(ret, p, plane->name, expected, actual, src_y);
> +	STATE_CHECK_U32_16_16(ret, p, plane->name, expected, actual, src_w);
> +	STATE_CHECK_U32_16_16(ret, p, plane->name, expected, actual, src_h);
> +	STATE_CHECK_S32(ret, p, plane->name, expected, actual, hotspot_x);
> +	STATE_CHECK_S32(ret, p, plane->name, expected, actual, hotspot_y);
> +	STATE_CHECK_U16(ret, p, plane->name, expected, actual, alpha);
> +	STATE_CHECK_U16(ret, p, plane->name, expected, actual, pixel_blend_mode=
);
> +	STATE_CHECK_U32(ret, p, plane->name, expected, actual, rotation);
> +	STATE_CHECK_U32(ret, p, plane->name, expected, actual, zpos);
> +	STATE_CHECK_U32(ret, p, plane->name, expected, actual, normalized_zpos);
> +	STATE_CHECK_U32(ret, p, plane->name, expected, actual, color_encoding);
> +	STATE_CHECK_U32(ret, p, plane->name, expected, actual, color_range);
> +
> +	// TODO: damage clips
> +
> +	STATE_CHECK_BOOL(ret, p, plane->name, expected, actual, ignore_damage_c=
lips);

[Severity: Low]
This problem wasn't introduced by this patch, but using STATE_CHECK_BOOL he=
re
causes a build failure.

The macro uses static_assert(__same_type(sa->f, true)). In the kernel, true
expands to 1 (an int). Comparing a bool with an int evaluates to false,
unconditionally failing the build. Should the macro compare against a boole=
an
variable or type instead?

> +	STATE_CHECK_S32(ret, p, plane->name, expected, actual, src.x1);
> +	STATE_CHECK_S32(ret, p, plane->name, expected, actual, src.x2);
> +	STATE_CHECK_S32(ret, p, plane->name, expected, actual, src.y1);
> +	STATE_CHECK_S32(ret, p, plane->name, expected, actual, src.y2);
> +	STATE_CHECK_S32(ret, p, plane->name, expected, actual, dst.x1);
> +	STATE_CHECK_S32(ret, p, plane->name, expected, actual, dst.x2);
> +	STATE_CHECK_S32(ret, p, plane->name, expected, actual, dst.y1);
> +	STATE_CHECK_S32(ret, p, plane->name, expected, actual, dst.y2);
> +	STATE_CHECK_BOOL(ret, p, plane->name, expected, actual, visible);
> +	STATE_CHECK_U32(ret, p, plane->name, expected, actual, scaling_filter);
> +

[Severity: Low]
Is the color_pipeline property intentionally omitted from the plane state
comparison?

If the hardware state mismatches the software state for this field, it seems
the discrepancy will be silently ignored.

> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_atomic_helper_plane_compare_state);
> +
[ ... ]
> +bool drm_atomic_helper_crtc_compare_state(struct drm_crtc *crtc,
> +					  struct drm_printer *p,
> +					  struct drm_crtc_state *expected,
> +					  struct drm_crtc_state *actual)
> +{
> +	bool ret =3D true;
> +
> +	STATE_CHECK_PTR(ret, p, crtc->name, expected, actual, crtc);
> +	STATE_CHECK_BOOL(ret, p, crtc->name, expected, actual, enable);
> +	STATE_CHECK_BOOL(ret, p, crtc->name, expected, actual, active);
> +	STATE_CHECK_BOOL(ret, p, crtc->name, expected, actual, no_vblank);
> +	STATE_CHECK_U32(ret, p, crtc->name, expected, actual, plane_mask);
> +	STATE_CHECK_U32(ret, p, crtc->name, expected, actual, connector_mask);
> +	STATE_CHECK_U32(ret, p, crtc->name, expected, actual, encoder_mask);
> +
> +	STATE_CHECK_DISPLAY_MODE(ret, p, crtc->name, expected, actual, mode);
> +	STATE_CHECK_DISPLAY_MODE(ret, p, crtc->name, expected, actual, adjusted=
_mode);

[Severity: Medium]
Will this comparison cause false-positive mismatches when the CRTC is inact=
ive?

If expected->active is false, the expected mode may contain previous
user-space values while the actual hardware readout is zeroed. Since these
properties are compared unconditionally, could this cause persistent mismat=
ch
spam in the kernel log?

> +	STATE_CHECK_PROPERTY_BLOB(ret, p, crtc->name, expected, actual, mode_bl=
ob);
> +	STATE_CHECK_PROPERTY_BLOB(ret, p, crtc->name, expected, actual, degamma=
_lut);
> +	STATE_CHECK_PROPERTY_BLOB(ret, p, crtc->name, expected, actual, ctm);
> +	STATE_CHECK_PROPERTY_BLOB(ret, p, crtc->name, expected, actual, gamma_l=
ut);
> +	STATE_CHECK_BOOL(ret, p, crtc->name, expected, actual, vrr_enabled);
> +	STATE_CHECK_BOOL(ret, p, crtc->name, expected, actual, self_refresh_act=
ive);
> +	STATE_CHECK_U32(ret, p, crtc->name, expected, actual, scaling_filter);
> +

[Severity: Low]
Is the background_color property intentionally omitted from the CRTC state
comparison?

> +	return ret;
> +}
> +EXPORT_SYMBOL(drm_atomic_helper_crtc_compare_state);
> +
[ ... ]
> +bool drm_atomic_helper_connector_compare_state(struct drm_connector *con=
n,
> +					       struct drm_printer *p,
> +					       struct drm_connector_state *expected,
> +					       struct drm_connector_state *actual)
> +{
> +	bool ret =3D true;
> +
> +	STATE_CHECK_PTR(ret, p, conn->name, expected, actual, connector);
> +	STATE_CHECK_PTR(ret, p, conn->name, expected, actual, crtc);
> +	STATE_CHECK_PTR(ret, p, conn->name, expected, actual, best_encoder);
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, link_status);

[Severity: Low]
This problem wasn't introduced by this patch, but using STATE_CHECK_U32 on =
an
enum field causes a build failure.

The STATE_CHECK_U32 macro uses static_assert(__same_type(sa->f, (u32)0)).
In C, __builtin_types_compatible_p considers enum types incompatible with
integer types like u32, so this assertion will unconditionally fail when
checking fields like link_status.

> +
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.select_subconn=
ector);
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, tv.subconnector);
> +
> +	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, self_refresh_awa=
re);
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, picture_aspect_ra=
tio);
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, content_type);
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, hdcp_content_type=
);
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, scaling_mode);
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, content_protectio=
n);
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, colorspace);
> +
> +	/*
> +	 * NOTE: We can't check max_bpc and max_requested_bpc because it
> +	 * will typically come from userspace and we can't read it out
> +	 * from the hardware.
> +	 */
> +
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, privacy_screen_sw=
_state);
> +	STATE_CHECK_PROPERTY_BLOB(ret, p, conn->name, expected, actual, hdr_out=
put_metadata);
> +
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, hdmi.broadcast_rg=
b);
> +	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, hdmi.infoframes.=
avi.set);
> +	STATE_CHECK_INFOFRAME(ret, p, conn->name, expected, actual, hdmi.infofr=
ames.avi.data);
> +	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, hdmi.infoframes.=
hdr_drm.set);
> +	STATE_CHECK_INFOFRAME(ret, p, conn->name, expected, actual, hdmi.infofr=
ames.hdr_drm.data);
> +	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, hdmi.infoframes.=
spd.set);
> +	STATE_CHECK_INFOFRAME(ret, p, conn->name, expected, actual, hdmi.infofr=
ames.spd.data);
> +	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, hdmi.infoframes.=
hdmi.set);
> +	STATE_CHECK_INFOFRAME(ret, p, conn->name, expected, actual, hdmi.infofr=
ames.hdmi.data);
> +	STATE_CHECK_BOOL(ret, p, conn->name, expected, actual, hdmi.is_limited_=
range);
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, hdmi.output_bpc);
> +	STATE_CHECK_U32(ret, p, conn->name, expected, actual, hdmi.output_forma=
t);
> +	STATE_CHECK_U64(ret, p, conn->name, expected, actual, hdmi.tmds_char_ra=
te);
> +

[Severity: Low]
Are color_format and hdmi.scrambler_needed intentionally omitted from the
connector state comparison?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D18

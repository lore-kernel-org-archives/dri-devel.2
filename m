Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802E2606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 03:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BH8AQ+Mv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DC9110E082;
	Thu, 26 Nov 2026 03:14:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C81E110E082
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 03:14:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F0CAD61AE5;
 Thu, 26 Nov 2026 03:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955F01F000C4;
 Thu, 26 Nov 2026 03:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795662846;
 bh=rY3G9fUA5suIuVfU5U/3XutqtcxMw8+4/Ev3gpAtooo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BH8AQ+Mvf37wMJDY3Q5LYnXV7+ednyp1tlnAVflJlLdtzgIXvYngMfjlUN9o8b/h2
 1ivtFx9LGQzpJxFva4SM91pY5SheygkKHrkSdc1J+AYxOn4nAFTpyJ200uLtDhYMxN
 xPn3rTnUlC96R19SumTGqexch8pmiUXV4YM8mn5PEmYB3i8rizI5VXsvuvbePCauYh
 LXLKGYBlrqzqzFm02j6aEtnBvhkAONSrQEV5OFFNLGZlaTPY28O3tfp13+5mrehjIX
 dKPD/Jq6W5W7S3eq9hNDiMLelSuYER6qbd/H8wJzM7dQD147dav7DnWH8l4XW3v4L+
 +gvLX/oBeJrHg==
Message-ID: <sashiko-outbox-234681@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vc4: hdmi: Reject modes that don't fit the BCM2711
 timing registers
To: Roy <rongh7426@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126025311.640543-1-rongh7426@gmail.com>
References: <20261126025311.640543-1-rongh7426@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 03:14:06 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] drm/vc4: hdmi: unvalidated DBLCLK fixup in
  vc4_hdmi_encoder_atomic_check()
- [Medium] drm/vc4: hdmi: u32 FIELD_FIT() truncation in
  vc5_hdmi_timings_valid()
- [Medium] drm/vc4: hdmi: unchecked even-field VBP in
  vc5_hdmi_timings_valid()
--

commit cdf386363de742cee9aaccb1142e521a753912f5
Author: Roy <rongh7426@gmail.com>

drm/vc4: hdmi: Reject modes that don't fit the BCM2711 timing registers

This commit adds a timings_valid() variant hook for the BCM2711 and
BCM2712 HDMI controllers to check that mode timings fit in the hardware
timing register fields before modeset.

> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdm=
i.c
> index f3ec65d86078f..4e10cdedb8a8f 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -1254,6 +1254,44 @@ static void vc5_hdmi_set_timings(struct vc4_hdmi *=
vc4_hdmi,
>  	drm_dev_exit(idx);
>  }
> =20
> +/*
> + * Check that every value vc5_hdmi_set_timings() writes fits in its
> + * register field. Such a mode would otherwise be programmed with
> + * truncated timings, and VC4_SET_FIELD() would warn about it on every
> + * modeset.
> + */
> +static enum drm_mode_status
> +vc5_hdmi_timings_valid(const struct drm_display_mode *mode)
> +{
> +	bool interlaced =3D mode->flags & DRM_MODE_FLAG_INTERLACE;
> +	u32 pixel_rep =3D (mode->flags & DRM_MODE_FLAG_DBLCLK) ? 2 : 1;
> +	struct drm_display_mode m;
> +
> +	drm_mode_init(&m, mode);
> +	drm_mode_set_crtcinfo(&m, CRTC_INTERLACE_HALVE_V);
> +
> +	if (!FIELD_FIT(VC5_HDMI_HORZA_HAP_MASK, m.hdisplay * pixel_rep) ||
> +	    !FIELD_FIT(VC5_HDMI_HORZA_HFP_MASK,
> +		       (m.hsync_start - m.hdisplay) * pixel_rep) ||
> +	    !FIELD_FIT(VC5_HDMI_HORZB_HBP_MASK,
> +		       (m.htotal - m.hsync_end) * pixel_rep) ||
> +	    !FIELD_FIT(VC5_HDMI_HORZB_HSP_MASK,
> +		       (m.hsync_end - m.hsync_start) * pixel_rep) ||
> +	    !FIELD_FIT(VC5_HDMI_VERTB_VSPO_MASK, m.htotal >> (2 - pixel_rep)))
> +		return MODE_H_ILLEGAL;
> +
> +	if (!FIELD_FIT(VC5_HDMI_VERTA_VSP_MASK,
> +		       m.crtc_vsync_end - m.crtc_vsync_start) ||
> +	    !FIELD_FIT(VC5_HDMI_VERTA_VFP_MASK,
> +		       m.crtc_vsync_start - m.crtc_vdisplay) ||

[Severity: Medium]
Can FIELD_FIT() miss overflowing values on these shifted masks because
VC4_MASK() casts GENMASK() to u32?

include/linux/bitfield.h:FIELD_FIT() shifts ((typeof(_mask))_val) left by
__bf_shf(_mask) before testing against ~(_mask).  With a 32-bit mask,
that shift discards the upper __bf_shf(_mask) bits of _val.  For
VC5_HDMI_VERTA_VSP_MASK (VC4_MASK(28, 24)), shifting left by 24 drops
bits 8..15, so a mode with m.crtc_vsync_end - m.crtc_vsync_start =3D=3D 256
passes FIELD_FIT() and programs a truncated 0 VSP into HDMI_VERTA0/1.
The masks at shift 16 (VC5_HDMI_HORZA_HFP_MASK, VC5_HDMI_HORZB_HBP_MASK
and VC5_HDMI_VERTA_VFP_MASK) similarly drop bits 16..31.

> +	    !FIELD_FIT(VC5_HDMI_VERTA_VAL_MASK, m.crtc_vdisplay) ||
> +	    !FIELD_FIT(VC4_HDMI_VERTB_VBP_MASK,
> +		       m.crtc_vtotal - m.crtc_vsync_end + interlaced))
> +		return MODE_V_ILLEGAL;

[Severity: Medium]
Should this also check m.crtc_vtotal - m.crtc_vsync_end without
+ interlaced for vertb_even?

vc5_hdmi_set_timings() packs mode->crtc_vtotal - mode->crtc_vsync_end
into VC4_HDMI_VERTB_VBP for vertb_even (HDMI_VERTB0).  When an interlaced
mode has vscan > 1 (e.g. vdisplay =3D vsync_start =3D vsync_end =3D 512,
vtotal =3D 1022, vscan =3D 257), the u16 multiplication in
drm_mode_set_crtcinfo() wraps crtc_vtotal to 255 and crtc_vsync_end to
256.  m.crtc_vtotal - m.crtc_vsync_end + interlaced is 0 and passes this
check, after which vc5_hdmi_set_timings() passes -1 to VC4_SET_FIELD()
for vertb_even and triggers a WARN_ON().

> +
> +	return MODE_OK;
> +}
> +
>  static void vc4_hdmi_recenter_fifo(struct vc4_hdmi *vc4_hdmi)
>  {
>  	struct drm_device *drm =3D vc4_hdmi->connector.dev;
> @@ -1656,6 +1694,14 @@ vc4_hdmi_encoder_mode_valid(struct drm_encoder *en=
coder,
>  {
>  	struct vc4_hdmi *vc4_hdmi =3D encoder_to_vc4_hdmi(encoder);
> =20
> +	if (vc4_hdmi->variant->timings_valid) {
> +		enum drm_mode_status status;
> +
> +		status =3D vc4_hdmi->variant->timings_valid(mode);
> +		if (status !=3D MODE_OK)
> +			return status;
> +	}
> +

[Severity: Medium]
Can the DBLCLK odd-timing fixup in vc4_hdmi_encoder_atomic_check() push
adjusted_mode past the 11-bit VC5_HDMI_HORZB_HBP or VC5_HDMI_HORZB_HSP
limit after vc4_hdmi_encoder_mode_valid() has already approved the mode?

drivers/gpu/drm/vc4/vc4_hdmi.c:vc4_hdmi_encoder_atomic_check() {
    ...
		if (mode->flags & DRM_MODE_FLAG_DBLCLK) {
			if ((mode->hsync_start - mode->hdisplay) & 1)
				mode->hsync_start--;
			if ((mode->hsync_end - mode->hsync_start) & 1)
				mode->hsync_end--;
		}
    ...
}

On BCM2711, a DRM_MODE_FLAG_DBLCLK mode with even hdisplay, even
hsync_start, odd hsync_end and htotal - hsync_end =3D=3D 1023 passes
vc5_hdmi_timings_valid() with (htotal - hsync_end) * 2 =3D=3D 2046 <=3D 204=
7.
vc4_hdmi_encoder_atomic_check() then decrements adjusted_mode.hsync_end
without re-running timings_valid(), so vc5_hdmi_set_timings() sees
(htotal - hsync_end) * 2 =3D=3D 2048, triggers WARN_ON() in VC4_SET_FIELD(),
and writes a truncated 0 HBP to HDMI_HORZB.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126025311.6405=
43-1-rongh7426@gmail.com?part=3D1

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A794C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A68F810E38A;
	Wed, 16 Sep 2026 12:28:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iB/JLZCm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 920DA10E38A;
 Wed, 16 Sep 2026 12:28:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1555F60546;
 Wed, 16 Sep 2026 12:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CEF1F00898;
 Wed, 16 Sep 2026 12:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789561727;
 bh=41e2jXQ9KRiieH18b5OaTBX7DGDqBdgoedzOdwpBI9o=;
 h=Date:From:To:Cc:Subject;
 b=iB/JLZCmoznhnJD+ffJF+xiKSjJVNzzPEx/HQ87Igw5/LYlNmnfhrF3Ek8qGj8SGU
 JlvwcSHZx/M5ndIgqlpTdgrUMXf0Way3GBWSd5P4wAEerxXZekBZMo+TbzLvaVxS1l
 tQ0Y60Blt00wyZGkjwtkSY72L3ttWdeFGAjk2szUDAocJJ7RZEwtcmDTzoo+8pUYtS
 iV2K5BcNSHmu7RGIR8bjFkYCezKHWkqwcjEr91Ks4p2pX4E+I46mCen+zWh9nst4Rg
 YI+i46GnlxDnzmqbpkU+7EoCDTfV0YzTqeM/5q2pGkPp62TIzuFAh3ThqNt9xuWfaF
 vjuuW5yewTqfw==
Date: Wed, 16 Sep 2026 13:28:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: Jani Nikula <jani.nikula@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Nemesa Garg <nemesa.garg@intel.com>,
 Suraj Kandpal <suraj.kandpal@intel.com>
Subject: linux-next: manual merge of the drm-intel tree with the
 drm-intel-fixes tree
Message-ID: <aqqLe8U_PPOE4u7a@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8qPFsYGPFEyoGWa2"
Content-Disposition: inline
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


--8qPFsYGPFEyoGWa2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

  drivers/gpu/drm/i915/display/intel_cursor.c
  drivers/gpu/drm/i915/display/skl_universal_plane.c

between commit:

  a26204be587c5 ("Revert "drm/i915/display: Clear SEL_FETCH_PLANE_CTL on pl=
ane disable"")

=66rom the drm-intel-fixes tree and commits:

  d393529394167 ("Revert "drm/i915/display: Clear SEL_FETCH_PLANE_CTL on pl=
ane disable"")
  a4c0e7f80429e ("drm/i915/psr: Clear stale sel fetch enable bits on sel fe=
tch disable")

=66rom the drm-intel tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/i915/display/intel_cursor.c
index 90173040d8253,4afd275de86ea..0000000000000
--- a/drivers/gpu/drm/i915/display/intel_cursor.c
+++ b/drivers/gpu/drm/i915/display/intel_cursor.c
@@@ -537,7 -537,8 +537,8 @@@ static void i9xx_cursor_disable_sel_fet
  	struct intel_display *display =3D to_intel_display(plane);
  	enum pipe pipe =3D plane->pipe;
 =20
- 	if (!crtc_state->enable_psr2_sel_fetch)
+ 	if (!crtc_state->enable_psr2_sel_fetch &&
+ 	    !crtc_state->clear_psr2_sel_fetch)
  		return;
 =20
  	intel_de_write_dsb(display, dsb, SEL_FETCH_CUR_CTL(pipe), 0);
@@@ -570,8 -571,10 +571,10 @@@ static void i9xx_cursor_update_sel_fetc
  	struct intel_display *display =3D to_intel_display(plane);
  	enum pipe pipe =3D plane->pipe;
 =20
- 	if (!crtc_state->enable_psr2_sel_fetch)
+ 	if (!crtc_state->enable_psr2_sel_fetch) {
+ 		i9xx_cursor_disable_sel_fetch_arm(dsb, plane, crtc_state);
  		return;
+ 	}
 =20
  	if (drm_rect_height(&plane_state->psr2_sel_fetch_area) > 0) {
  		if (crtc_state->enable_psr2_su_region_et) {

diff --combined drivers/gpu/drm/i915/display/skl_universal_plane.c
index 07a6832933521,2636eba2ba465..0000000000000
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@@ -885,7 -885,8 +885,8 @@@ static void icl_plane_disable_sel_fetch
  	struct intel_display *display =3D to_intel_display(plane);
  	enum pipe pipe =3D plane->pipe;
 =20
- 	if (!crtc_state->enable_psr2_sel_fetch)
+ 	if (!crtc_state->enable_psr2_sel_fetch &&
+ 	    !crtc_state->clear_psr2_sel_fetch)
  		return;
 =20
  	intel_de_write_dsb(display, dsb, SEL_FETCH_PLANE_CTL(pipe, plane->id), 0=
);
@@@ -1240,36 -1241,46 +1241,46 @@@ static u32 glk_plane_color_ctl_crtc(con
  	return plane_color_ctl;
  }
 =20
- static u32 glk_plane_color_ctl(const struct intel_plane_state *plane_stat=
e)
+ static u32 glk_plane_color_ctl_input_csc(const struct intel_plane_state *=
plane_state)
  {
  	struct intel_display *display =3D to_intel_display(plane_state);
  	const struct drm_framebuffer *fb =3D plane_state->hw.fb;
  	struct intel_plane *plane =3D to_intel_plane(plane_state->uapi.plane);
+ 	bool color_pipeline =3D !!plane_state->uapi.color_pipeline;
+ 	bool needs_csc =3D color_pipeline ? plane_state->hw.csc_ff_enable : fb->=
format->is_yuv;
+ 	u32 ctl =3D 0;
+=20
+ 	if (!needs_csc)
+ 		return 0;
+=20
+ 	if (!icl_is_hdr_plane(display, plane->id)) {
+ 		switch (plane_state->hw.color_encoding) {
+ 		case DRM_COLOR_YCBCR_BT709:
+ 			ctl |=3D PLANE_COLOR_CSC_MODE_YUV709_TO_RGB709;
+ 			break;
+ 		case DRM_COLOR_YCBCR_BT2020:
+ 			ctl |=3D PLANE_COLOR_CSC_MODE_YUV2020_TO_RGB2020;
+ 			break;
+ 		default:
+ 			ctl |=3D PLANE_COLOR_CSC_MODE_YUV601_TO_RGB601;
+ 		}
+ 	} else {
+ 		ctl |=3D PLANE_COLOR_INPUT_CSC_ENABLE;
+ 	}
+=20
+ 	if (plane_state->hw.color_range =3D=3D DRM_COLOR_YCBCR_FULL_RANGE)
+ 		ctl |=3D PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE;
+=20
+ 	return ctl;
+ }
+=20
+ static u32 glk_plane_color_ctl(const struct intel_plane_state *plane_stat=
e)
+ {
  	u32 plane_color_ctl =3D 0;
 =20
  	plane_color_ctl |=3D PLANE_COLOR_PLANE_GAMMA_DISABLE;
  	plane_color_ctl |=3D glk_plane_color_ctl_alpha(plane_state);
-=20
- 	if (fb->format->is_yuv && !icl_is_hdr_plane(display, plane->id)) {
- 		switch (plane_state->hw.color_encoding) {
- 		case DRM_COLOR_YCBCR_BT709:
- 			plane_color_ctl |=3D PLANE_COLOR_CSC_MODE_YUV709_TO_RGB709;
- 			break;
- 		case DRM_COLOR_YCBCR_BT2020:
- 			plane_color_ctl |=3D
- 				PLANE_COLOR_CSC_MODE_YUV2020_TO_RGB2020;
- 			break;
- 		default:
- 			plane_color_ctl |=3D
- 				PLANE_COLOR_CSC_MODE_YUV601_TO_RGB601;
- 		}
- 		if (plane_state->hw.color_range =3D=3D DRM_COLOR_YCBCR_FULL_RANGE)
- 			plane_color_ctl |=3D PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE;
- 	} else if (fb->format->is_yuv) {
- 		plane_color_ctl |=3D PLANE_COLOR_INPUT_CSC_ENABLE;
- 		if (plane_state->hw.color_range =3D=3D DRM_COLOR_YCBCR_FULL_RANGE)
- 			plane_color_ctl |=3D PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE;
- 	}
+ 	plane_color_ctl |=3D glk_plane_color_ctl_input_csc(plane_state);
 =20
  	if (plane_state->force_black)
  		plane_color_ctl |=3D PLANE_COLOR_PLANE_CSC_ENABLE;
@@@ -1611,7 -1622,8 +1622,8 @@@ icl_plane_update_noarm(struct intel_ds
  	intel_de_write_dsb(display, dsb, PLANE_COLOR_CTL(pipe, plane_id),
  			   plane_color_ctl);
 =20
- 	if (fb->format->is_yuv && icl_is_hdr_plane(display, plane_id))
+ 	if (icl_is_hdr_plane(display, plane_id) &&
+ 	    (fb->format->is_yuv || plane_state->hw.csc_ff_enable))
  		icl_program_input_csc(dsb, plane, plane_state);
 =20
  	skl_write_plane_wm(dsb, plane, crtc_state);
@@@ -1634,10 -1646,8 +1646,8 @@@ static void icl_plane_update_sel_fetch_
  	struct intel_display *display =3D to_intel_display(plane);
  	enum pipe pipe =3D plane->pipe;
 =20
- 	if (!crtc_state->enable_psr2_sel_fetch)
- 		return;
-=20
- 	if (drm_rect_height(&plane_state->psr2_sel_fetch_area) > 0)
+ 	if (crtc_state->enable_psr2_sel_fetch &&
+ 	    drm_rect_height(&plane_state->psr2_sel_fetch_area) > 0)
  		intel_de_write_dsb(display, dsb, SEL_FETCH_PLANE_CTL(pipe, plane->id),
  				   SEL_FETCH_PLANE_CTL_ENABLE);
  	else

--8qPFsYGPFEyoGWa2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqqi3oACgkQJNaLcl1U
h9D/Ugf/R6yXFrQGCQpogWaRdCQ1Q8XAERd7CekAXLWne2yk7j3en3djgcDJ5iAo
VaeTEKQxwSQKsV5Rutefh1w09BztsOnpxKtOwbEd26E6jWxgB9/81lE7xiHSo6BG
XrUIQCS/9uGETnOqcFzrhKP5D0LJoriwNZFzM0S/nKCFQ12YQhQtXbL+qMojLTrx
9AtqnA9ZVagjiVnHBJNb2fcAwtr8R3namds1kgaeaZnVgwy6xb1rgbDeQ2avYVhI
9ghOSugI9TIkDCTd0goB+XP8nbL1wMqY8a3OpiXoRThXfkT3rIq6IVjlLGcHz1ZJ
HzL5IEHRdnAtuQ4SH1LQHgMumVZ61Q==
=IQ4b
-----END PGP SIGNATURE-----

--8qPFsYGPFEyoGWa2--

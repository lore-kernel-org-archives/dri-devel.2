Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE3960A34DC
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F877o0UX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD89910EF52;
	Mon,  2 Nov 2026 14:49:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D4910EF51;
 Mon,  2 Nov 2026 14:49:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A70D541364;
 Mon,  2 Nov 2026 14:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1791F00A1D;
 Mon,  2 Nov 2026 14:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793630992;
 bh=9RIPeV3fKNfRabLfzKqeNznvU5T8sH8COSIN9Y2prVk=;
 h=Date:From:To:Cc:Subject;
 b=F877o0UXz8rCDAXxdt+v/jkwdteLPy0I20OEsMiyxtc0DV25OxHTcaiOIoQMhN4r9
 wu4L9n4IM3qbyOZRRNg/wBSQENYWLgfux+SLSBzuxBxReQUxeo6lCD9sjfPSt7JBo8
 iRgMaMCygaTKak6+hzmc6WZRSWSlYGWKu+VozfIklxH/+ZehKv8OpUZGeGD8DKEL/l
 4Uqi8nO+AlWp8QfJJa6aptp9MULs/CMOmkOaT0XU/cHbPcs+prE2uShAGN+WrbyvGe
 nqeND5p3eO4jFhGJ4Ai5jzprFAQ52ciLvc4ne1XUEsd1wBujLjSL3N3JgKDGU3Cepj
 u6U+UXw9tnNdg==
Date: Mon, 2 Nov 2026 14:49:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: Jouni =?iso-8859-1?Q?H=F6gander?= <jouni.hogander@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Mika Kahola <mika.kahola@intel.com>
Subject: linux-next: manual merge of the drm-intel tree with the
 drm-intel-fixes tree
Message-ID: <auijDJ-9T2YhFE80@sirena.org.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OmMpsowGHg2watvk"
Content-Disposition: inline
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--OmMpsowGHg2watvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

  drivers/gpu/drm/i915/display/intel_psr.c

between commits:

  cbe565475988d ("drm/i915/psr: Clear selective fetch area when duplicating=
 plane state")
  94cb1f08b197d ("drm/i915/display: Add enabled pipe planes into state for =
selective fetch")
  b56721c32eb3a ("drm/i915/psr: Disable linked plane sel fetch as well")
  e30830d21860f ("drm/i915/psr: Don't clip plane state destination rectangl=
e")

=66rom the drm-intel-fixes tree and commits:

  82a273802e29b ("drm/i915/psr: Allow Panel Replay and PSR2 with joiner")
  81492de01598e ("drm/i915/psr: Resolve the PSR encoders through the joiner=
 primary")
  dd038a8d440a9 ("drm/i915/psr: Merge the selective fetch area across joine=
d pipes")
  ce234fd7ac01d ("drm/i915/psr: Derive the alignment loop condition from th=
e SU area")
  6a33b0c495174 ("drm/i915/psr: Split the selective fetch calculation into =
helpers")
  384679cd97c88 ("drm/i915/psr: Take the selective fetch area from pipe_src=
")
  e9b810694a5b1 ("drm/i915/psr: Exclude the joiner secondary from active_no=
n_psr_pipes")
  20470bb876bcf ("drm/i915/psr: Track all joined pipes for frontbuffer trac=
king")
  8621f3bcea6b0 ("drm/i915/psr: Don't clip plane state destination rectangl=
e")
  8330f2041b95f ("drm/i915/psr: Remove drm_info_once on failed selective fe=
tch area")
  1e922ed8c092a ("drm/i915/psr: Skip sel fetch support check for invisible =
planes")
  b10c83af60cbc ("drm/i915/psr: Disable linked plane sel fetch as well")
  0d173898b1115 ("drm/i915/display: Add enabled pipe planes into state for =
selective fetch")
  bd58f0e221386 ("drm/i915/psr: Clear selective fetch area when duplicating=
 plane state")

=66rom the drm-intel tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/i915/display/intel_psr.c
index 17542d812486b,288836d4a993c..0000000000000
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@@ -36,6 -36,7 +36,7 @@@
  #include "intel_cursor_regs.h"
  #include "intel_ddi.h"
  #include "intel_de.h"
+ #include "intel_display.h"
  #include "intel_display_irq.h"
  #include "intel_display_regs.h"
  #include "intel_display_rpm.h"
@@@ -1597,6 -1598,13 +1598,13 @@@ static bool intel_sel_update_config_val
  	struct intel_dp *intel_dp =3D intel_attached_dp(connector);
  	struct intel_display *display =3D to_intel_display(intel_dp);
 =20
+ 	if (crtc_state->joiner_pipes && !crtc_state->dsc.compression_enable &&
+ 	    crtc_state->output_format =3D=3D INTEL_OUTPUT_FORMAT_YCBCR420) {
+ 		drm_dbg_kms(display->drm,
+ 			    "Selective update not enabled, uncompressed joiner does not suppor=
t YUV 4:2:0\n");
+ 		goto unsupported;
+ 	}
+=20
  	if (HAS_PSR2_SEL_FETCH(display) &&
  	    !intel_psr2_sel_fetch_config_valid(intel_dp, crtc_state) &&
  	    !HAS_PSR_HW_TRACKING(display)) {
@@@ -1744,8 -1752,8 +1752,8 @@@ static bool _panel_replay_compute_confi
 =20
  	/* Remaining checks are for eDP only */
 =20
- 	if (to_intel_crtc(crtc_state->uapi.crtc)->pipe !=3D PIPE_A &&
- 	    to_intel_crtc(crtc_state->uapi.crtc)->pipe !=3D PIPE_B)
+ 	/* Every joined pipe needs its own PSR/Panel Replay register block. */
+ 	if (intel_crtc_joined_pipe_mask(crtc_state) & ~(BIT(PIPE_A) | BIT(PIPE_B=
)))
  		return false;
 =20
  	/* 128b/132b Panel Replay is not supported on eDP */
@@@ -1802,6 -1810,19 +1810,19 @@@ static void psr2_dc3co_disable_work(str
  	mutex_unlock(&intel_dp->psr.lock);
  }
 =20
+ /* Frontbuffer bits for every pipe driving this PSR/Panel Replay instance=
=2E */
+ static unsigned int psr_frontbuffer_mask(struct intel_dp *intel_dp)
+ {
+ 	struct intel_display *display =3D to_intel_display(intel_dp);
+ 	unsigned int mask =3D 0;
+ 	enum pipe pipe;
+=20
+ 	for_each_pipe_masked(display, pipe, intel_dp->psr.pipe_mask)
+ 		mask |=3D INTEL_FRONTBUFFER_ALL_MASK(pipe);
+=20
+ 	return mask;
+ }
+=20
  static void
  psr2_dc3co_flush_locked(struct intel_dp *intel_dp, unsigned int frontbuff=
er_bits)
  {
@@@ -1817,8 -1838,7 +1838,7 @@@
  	 * At every frontbuffer flush flip event modified delay of delayed work,
  	 * when delayed work schedules that means display has been idle.
  	 */
- 	if (!(frontbuffer_bits &
- 	    INTEL_FRONTBUFFER_ALL_MASK(intel_dp->psr.pipe)))
+ 	if (!(frontbuffer_bits & psr_frontbuffer_mask(intel_dp)))
  		return;
 =20
  	mod_delayed_work(display->wq.unordered, &intel_dp->psr.dc3co_work,
@@@ -1849,7 -1869,7 +1869,7 @@@ void intel_psr_set_non_psr_pipes(struc
  	active_pipes =3D intel_calc_active_pipes(state, active_pipes);
 =20
  	crtc_state->active_non_psr_pipes =3D active_pipes &
- 		~BIT(to_intel_crtc(crtc_state->uapi.crtc)->pipe);
+ 		~intel_crtc_joined_pipe_mask(crtc_state);
  }
 =20
  void intel_psr_compute_config(struct intel_dp *intel_dp,
@@@ -1877,17 -1897,6 +1897,6 @@@
  		return;
  	}
 =20
- 	/*
- 	 * FIXME figure out what is wrong with PSR+joiner and
- 	 * fix it. Presumably something related to the fact that
- 	 * PSR is a transcoder level feature.
- 	 */
- 	if (crtc_state->joiner_pipes) {
- 		drm_dbg_kms(display->drm,
- 			    "PSR disabled due to joiner\n");
- 		return;
- 	}
-=20
  	/* Only used for state verification. */
  	crtc_state->panel_replay_dsc_support =3D connector->dp.panel_replay_caps=
=2Edsc_support;
  	crtc_state->has_panel_replay =3D _panel_replay_compute_config(crtc_state=
, conn_state);
@@@ -1899,6 -1908,14 +1908,14 @@@
  		return;
 =20
  	crtc_state->has_sel_update =3D intel_sel_update_config_valid(crtc_state,=
 conn_state);
+=20
+ 	/* Plain PSR1 is not supported with joiner. */
+ 	if (crtc_state->joiner_pipes && !crtc_state->has_panel_replay &&
+ 	    !crtc_state->has_sel_update) {
+ 		drm_dbg_kms(display->drm,
+ 			    "PSR disabled, PSR1 not supported with joiner\n");
+ 		crtc_state->has_psr =3D false;
+ 	}
  }
 =20
  void intel_psr_get_config(struct intel_encoder *encoder,
@@@ -2179,6 -2196,7 +2196,7 @@@ static void intel_psr_enable_locked(str
  	intel_dp->psr.panel_replay_enabled =3D crtc_state->has_panel_replay;
  	intel_dp->psr.busy_frontbuffer_bits =3D 0;
  	intel_dp->psr.pipe =3D to_intel_crtc(crtc_state->uapi.crtc)->pipe;
+ 	intel_dp->psr.pipe_mask =3D intel_crtc_joined_pipe_mask(crtc_state);
  	intel_dp->psr.transcoder =3D crtc_state->cpu_transcoder;
  	/* DC5/DC6 requires at least 6 idle frames */
  	val =3D usecs_to_jiffies(intel_get_frame_time_us(crtc_state) * 6);
@@@ -2398,6 -2416,7 +2416,7 @@@ static void intel_psr_disable_locked(st
  	intel_dp->psr.psr2_sel_fetch_cff_enabled =3D false;
  	intel_dp->psr.active_non_psr_pipes =3D 0;
  	intel_dp->psr.pkg_c_latency_used =3D 0;
+ 	intel_dp->psr.pipe_mask =3D 0;
  	cancel_delayed_work(&intel_dp->psr.dc3co_work);
  	intel_dp->psr.dc3co_allowed =3D false;
  }
@@@ -2623,6 -2642,24 +2642,24 @@@ static void intel_psr_force_update(stru
  	intel_de_write(display, CURSURFLIVE(display, intel_dp->psr.pipe), 0);
  }
 =20
+ /*
+  * The joiner secondary has no encoders of its own, its uapi.encoder_mask=
 is
+  * zero. PSR is a transcoder level feature driven by the primary, so take=
 the
+  * encoders from there. Only valid once the state has been swapped in, i.=
e.
+  * from the commit phase.
+  */
+ static u32 psr_encoder_mask(const struct intel_crtc_state *crtc_state)
+ {
+ 	struct intel_crtc *primary_crtc;
+=20
+ 	if (!intel_crtc_is_joiner_secondary(crtc_state))
+ 		return crtc_state->uapi.encoder_mask;
+=20
+ 	primary_crtc =3D intel_primary_crtc(crtc_state);
+=20
+ 	return to_intel_crtc_state(primary_crtc->base.state)->uapi.encoder_mask;
+ }
+=20
  void intel_psr2_program_trans_man_trk_ctl(struct intel_dsb *dsb,
  					  const struct intel_crtc_state *crtc_state)
  {
@@@ -2635,7 -2672,7 +2672,7 @@@
  		return;
 =20
  	for_each_intel_encoder_mask_with_psr(display->drm, encoder,
- 					     crtc_state->uapi.encoder_mask) {
+ 					     psr_encoder_mask(crtc_state)) {
  		struct intel_dp *intel_dp =3D enc_to_intel_dp(encoder);
 =20
  		if (!dsb)
@@@ -2646,9 -2683,11 +2683,11 @@@
  		break;
  	}
 =20
- 	intel_de_write_dsb(display, dsb,
- 			   PSR2_MAN_TRK_CTL(display, cpu_transcoder),
- 			   crtc_state->psr2_man_track_ctl);
+ 	/* The joined pipes drive one transcoder, so program it once. */
+ 	if (!intel_crtc_is_joiner_secondary(crtc_state))
+ 		intel_de_write_dsb(display, dsb,
+ 				   PSR2_MAN_TRK_CTL(display, cpu_transcoder),
+ 				   crtc_state->psr2_man_track_ctl);
 =20
  	if (!crtc_state->enable_psr2_su_region_et)
  		return;
@@@ -2733,12 -2772,11 +2772,11 @@@ static void clip_area_update(struct drm
  		overlap_damage_area->y2 =3D inter.y2;
  }
 =20
- static bool intel_psr2_sel_fetch_pipe_alignment(struct intel_crtc_state *=
crtc_state)
+ static void intel_psr2_sel_fetch_pipe_alignment(struct intel_crtc_state *=
crtc_state)
  {
  	struct intel_display *display =3D to_intel_display(crtc_state);
  	const struct drm_dsc_config *vdsc_cfg =3D &crtc_state->dsc.config;
  	u16 y_alignment;
- 	bool su_area_changed =3D false;
 =20
  	/* ADLP aligns the SU region to vdsc slice height in case dsc is enabled=
 */
  	if (crtc_state->dsc.compression_enable &&
@@@ -2747,18 -2785,12 +2785,12 @@@
  	else
  		y_alignment =3D crtc_state->su_y_granularity;
 =20
- 	if (crtc_state->psr2_su_area.y1 % y_alignment) {
+ 	if (crtc_state->psr2_su_area.y1 % y_alignment)
  		crtc_state->psr2_su_area.y1 -=3D crtc_state->psr2_su_area.y1 % y_alignm=
ent;
- 		su_area_changed =3D true;
- 	}
 =20
- 	if (crtc_state->psr2_su_area.y2 % y_alignment) {
+ 	if (crtc_state->psr2_su_area.y2 % y_alignment)
  		crtc_state->psr2_su_area.y2 =3D ((crtc_state->psr2_su_area.y2 /
  						y_alignment) + 1) * y_alignment;
- 		su_area_changed =3D true;
- 	}
-=20
- 	return su_area_changed;
  }
 =20
  /*
@@@ -2768,8 -2800,7 +2800,7 @@@
  static void
  intel_psr2_sel_fetch_et_alignment(struct intel_atomic_state *state,
  				  struct intel_crtc *crtc,
- 				  struct drm_rect *display_area,
- 				  bool *cursor_in_su_area)
+ 				  struct drm_rect *display_area)
  {
  	struct intel_crtc_state *crtc_state =3D intel_atomic_get_new_crtc_state(=
state, crtc);
  	struct intel_plane_state *new_plane_state;
@@@ -2797,7 -2828,6 +2828,6 @@@
 =20
  		clip_area_update(&crtc_state->psr2_su_area, &new_plane_state->uapi.dst,
  				 display_area);
- 		*cursor_in_su_area =3D true;
  	}
  }
 =20
@@@ -2874,6 -2904,11 +2904,11 @@@ intel_psr_apply_su_area_workarounds(str
  {
  	struct intel_display *display =3D to_intel_display(crtc_state);
 =20
+ 	/*
+ 	 * Called on the merged area, with the joiner primary crtc_state. The
+ 	 * secondary has no encoders of its own and the WAs below have to see
+ 	 * the whole SU region that goes into PSR2_MAN_TRK_CTL.
+ 	 */
  	/* Wa_14014971492 */
  	if (!crtc_state->has_panel_replay &&
  	    ((IS_DISPLAY_VERx100_STEP(display, 1400, STEP_A0, STEP_B0) ||
@@@ -2891,39 -2926,22 +2926,22 @@@
  		intel_psr_apply_pr_link_on_su_wa(crtc_state);
  }
 =20
- int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
- 				struct intel_crtc *crtc)
+ static void psr2_sel_fetch_compute_su_area(struct intel_atomic_state *sta=
te,
+ 					   struct intel_crtc *crtc,
+ 					   bool *full_update)
  {
- 	struct intel_display *display =3D to_intel_display(state);
- 	const struct intel_crtc_state *old_crtc_state =3D
- 		intel_atomic_get_old_crtc_state(state, crtc);
  	struct intel_crtc_state *crtc_state =3D intel_atomic_get_new_crtc_state(=
state, crtc);
  	struct intel_plane_state *new_plane_state, *old_plane_state;
  	struct intel_plane *plane;
  	struct drm_rect display_area =3D {
  		.x1 =3D 0,
  		.y1 =3D 0,
- 		.x2 =3D crtc_state->hw.adjusted_mode.crtc_hdisplay,
- 		.y2 =3D crtc_state->hw.adjusted_mode.crtc_vdisplay,
+ 		.x2 =3D drm_rect_width(&crtc_state->pipe_src),
+ 		.y2 =3D drm_rect_height(&crtc_state->pipe_src),
  	};
- 	bool full_update =3D false, su_area_changed;
  	int i;
 =20
- 	/*
- 	 * Selective fetch is not always usable, for instance it is dropped
- 	 * while pipe CRC is active. The planes keep their selective fetch
- 	 * enable bit set in hardware over that, and a plane disabled while
- 	 * selective fetch is off never gets the bit cleared. Once selective
- 	 * fetch comes back the hardware would resume fetching for a plane that
- 	 * is no longer enabled and keep its DDB range reserved, so have the
- 	 * plane update drop the bit for every plane of the pipe as selective
- 	 * fetch is turned off.
- 	 */
- 	crtc_state->clear_psr2_sel_fetch =3D old_crtc_state->enable_psr2_sel_fet=
ch &&
- 		!crtc_state->enable_psr2_sel_fetch;
-=20
- 	if (!crtc_state->enable_psr2_sel_fetch)
- 		return 0;
+ 	*full_update =3D false;
 =20
  	crtc_state->psr2_su_area.x1 =3D 0;
  	crtc_state->psr2_su_area.y1 =3D -1;
@@@ -2931,8 -2949,8 +2949,8 @@@
  	crtc_state->psr2_su_area.y2 =3D -1;
 =20
  	if (!psr2_sel_fetch_pipe_state_supported(crtc_state)) {
- 		full_update =3D true;
- 		goto skip_su_area_calc;
+ 		*full_update =3D true;
+ 		return;
  	}
 =20
  	/*
@@@ -2953,8 -2971,9 +2971,9 @@@
  		    !old_plane_state->uapi.visible)
  			continue;
 =20
- 		if (!psr2_sel_fetch_plane_state_supported(new_plane_state)) {
- 			full_update =3D true;
+ 		if (new_plane_state->uapi.visible &&
+ 		    !psr2_sel_fetch_plane_state_supported(new_plane_state)) {
+ 			*full_update =3D true;
  			break;
  		}
 =20
@@@ -3003,58 -3022,117 +3022,122 @@@
 =20
  		clip_area_update(&crtc_state->psr2_su_area, &damaged_area, &display_are=
a);
  	}
+ }
 =20
- 	/*
- 	 * TODO: For now we are just using full update in case
- 	 * selective fetch area calculation fails. To optimize this we
- 	 * should identify cases where this happens and fix the area
- 	 * calculation for those.
- 	 */
- 	if (crtc_state->psr2_su_area.y1 =3D=3D -1) {
- 		drm_info_once(display->drm,
- 			      "Selective fetch area calculation failed in pipe %c\n",
- 			      pipe_name(crtc->pipe));
- 		full_update =3D true;
+ static void psr2_sel_fetch_set_su_area(struct intel_atomic_state *state,
+ 				       u8 joined_pipes, int y1, int y2)
+ {
+ 	struct intel_display *display =3D to_intel_display(state);
+ 	struct intel_crtc *crtc;
+=20
+ 	for_each_intel_crtc_in_pipe_mask(display, crtc, joined_pipes) {
+ 		struct intel_crtc_state *crtc_state =3D
+ 			intel_atomic_get_new_crtc_state(state, crtc);
+=20
+ 		crtc_state->psr2_su_area.y1 =3D y1;
+ 		crtc_state->psr2_su_area.y2 =3D y2;
+ 	}
+ }
+=20
+ /*
+  * One transcoder means one SU region. Joining splits the image horizonta=
lly, so
+  * the pipes share the Y range. Returns false if no joined pipe has any d=
amage.
+  */
+ static bool psr2_sel_fetch_merge_su_area(struct intel_atomic_state *state,
+ 					 u8 joined_pipes)
+ {
+ 	struct intel_display *display =3D to_intel_display(state);
+ 	struct intel_crtc_state *crtc_state;
+ 	struct intel_crtc *crtc;
+ 	int y1 =3D INT_MAX, y2 =3D INT_MIN;
+=20
+ 	for_each_intel_crtc_in_pipe_mask(display, crtc, joined_pipes) {
+ 		crtc_state =3D intel_atomic_get_new_crtc_state(state, crtc);
+=20
+ 		/* An empty area must not drag the merged one down. */
+ 		if (crtc_state->psr2_su_area.y1 =3D=3D -1)
+ 			continue;
+=20
+ 		y1 =3D min(y1, crtc_state->psr2_su_area.y1);
+ 		y2 =3D max(y2, crtc_state->psr2_su_area.y2);
  	}
 =20
- 	if (full_update)
- 		goto skip_su_area_calc;
+ 	if (y1 =3D=3D INT_MAX)
+ 		return false;
 =20
- 	intel_psr_apply_su_area_workarounds(crtc_state);
+ 	psr2_sel_fetch_set_su_area(state, joined_pipes, y1, y2);
+=20
+ 	return true;
+ }
+=20
+ /*
+  * Merging only grows the area, so a cursor that missed its own pipe's ar=
ea can
+  * end up partially covered. Realign on the merged area until it stops gr=
owing.
+  */
+ static void psr2_sel_fetch_align_su_area(struct intel_atomic_state *state,
+ 					 u8 joined_pipes)
+ {
+ 	struct intel_display *display =3D to_intel_display(state);
+ 	struct intel_crtc *crtc;
+ 	bool su_area_changed;
 =20
  	do {
- 		bool cursor_in_su_area =3D false;
+ 		su_area_changed =3D false;
 =20
- 		/*
- 		 * Adjust su area to cover cursor fully as necessary
- 		 * (early transport). A visible cursor is in the state
- 		 * even when it is not updated by itself as all planes
- 		 * of the pipe are added into the state before the plane
- 		 * checks when selective fetch is enabled.
- 		 */
- 		intel_psr2_sel_fetch_et_alignment(state, crtc, &display_area,
- 						  &cursor_in_su_area);
+ 		for_each_intel_crtc_in_pipe_mask(display, crtc, joined_pipes) {
+ 			struct intel_crtc_state *crtc_state =3D
+ 				intel_atomic_get_new_crtc_state(state, crtc);
+ 			struct drm_rect display_area =3D {
+ 				.x1 =3D 0,
+ 				.y1 =3D 0,
+ 				.x2 =3D drm_rect_width(&crtc_state->pipe_src),
+ 				.y2 =3D drm_rect_height(&crtc_state->pipe_src),
+ 			};
+ 			struct drm_rect old_su_area =3D crtc_state->psr2_su_area;
 =20
- 		su_area_changed =3D intel_psr2_sel_fetch_pipe_alignment(crtc_state);
+ 			/* Needs the planes already pulled into the state. */
+ 			intel_psr2_sel_fetch_et_alignment(state, crtc, &display_area);
 =20
- 		/*
- 		 * If the cursor was outside the SU area before
- 		 * alignment, the alignment step (which only expands
- 		 * SU) may pull the cursor partially inside, so we
- 		 * must run ET alignment again to fully cover it. But
- 		 * if the cursor was already fully inside before
- 		 * alignment, expanding the SU area won't change that,
- 		 * so no further work is needed.
- 		 */
- 		if (cursor_in_su_area)
- 			break;
+ 			intel_psr2_sel_fetch_pipe_alignment(crtc_state);
+=20
+ 			su_area_changed |=3D !drm_rect_equals(&crtc_state->psr2_su_area,
+ 							    &old_su_area);
+ 		}
+=20
+ 		if (su_area_changed)
+ 			psr2_sel_fetch_merge_su_area(state, joined_pipes);
  	} while (su_area_changed);
+ }
+=20
+ static int psr2_sel_fetch_apply_su_area(struct intel_atomic_state *state,
+ 					struct intel_crtc *crtc,
+ 					bool full_update)
+ {
+ 	struct intel_crtc_state *crtc_state =3D intel_atomic_get_new_crtc_state(=
state, crtc);
+ 	struct intel_plane_state *new_plane_state, *old_plane_state;
+ 	struct intel_plane *plane;
+ 	struct drm_rect display_area =3D {
+ 		.x1 =3D 0,
+ 		.y1 =3D 0,
+ 		.x2 =3D drm_rect_width(&crtc_state->pipe_src),
+ 		.y2 =3D drm_rect_height(&crtc_state->pipe_src),
+ 	};
+ 	int i;
+=20
+ 	/*
+ 	 * On full update the whole pipe is fetched, the plane loop below then
+ 	 * gives every visible plane its full area. Plane states come out of
+ 	 * the duplicate with a zero sized area, so this has to run on full
+ 	 * update as well.
+ 	 */
+ 	if (full_update)
+ 		crtc_state->psr2_su_area =3D display_area;
 =20
 +skip_su_area_calc:
 +	if (full_update)
 +		clip_area_update(&crtc_state->psr2_su_area, &display_area,
 +				 &display_area);
 +
  	/*
  	 * Now that we have the pipe damaged area check if it intersect with
  	 * every plane, if it does set the plane selective fetch area.
@@@ -3107,6 -3185,82 +3190,82 @@@
  	psr2_man_trk_ctl_calc(crtc_state, full_update);
  	crtc_state->pipe_srcsz_early_tpt =3D
  		psr2_pipe_srcsz_early_tpt_calc(crtc_state, full_update);
+=20
+ 	return 0;
+ }
+=20
+ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
+ 				struct intel_crtc *crtc)
+ {
+ 	struct intel_display *display =3D to_intel_display(state);
+ 	const struct intel_crtc_state *old_crtc_state =3D
+ 		intel_atomic_get_old_crtc_state(state, crtc);
+ 	struct intel_crtc_state *crtc_state =3D intel_atomic_get_new_crtc_state(=
state, crtc);
+ 	struct intel_crtc *joined_crtc;
+ 	bool full_update =3D false;
+ 	u8 joined_pipes;
+ 	int ret;
+=20
+ 	/*
+ 	 * Selective fetch is not always usable, for instance it is dropped
+ 	 * while pipe CRC is active. The planes keep their selective fetch
+ 	 * enable bit set in hardware over that, and a plane disabled while
+ 	 * selective fetch is off never gets the bit cleared. Once selective
+ 	 * fetch comes back the hardware would resume fetching for a plane that
+ 	 * is no longer enabled and keep its DDB range reserved, so have the
+ 	 * plane update drop the bit for every plane of the pipe as selective
+ 	 * fetch is turned off.
+ 	 */
+ 	crtc_state->clear_psr2_sel_fetch =3D old_crtc_state->enable_psr2_sel_fet=
ch &&
+ 		!crtc_state->enable_psr2_sel_fetch;
+=20
+ 	if (!crtc_state->enable_psr2_sel_fetch)
+ 		return 0;
+=20
+ 	/* The joined pipes are handled in one go from the primary. */
+ 	if (intel_crtc_is_joiner_secondary(crtc_state))
+ 		return 0;
+=20
+ 	joined_pipes =3D intel_crtc_joined_pipe_mask(crtc_state);
+=20
+ 	for_each_intel_crtc_in_pipe_mask(display, joined_crtc, joined_pipes) {
+ 		psr2_sel_fetch_compute_su_area(state, joined_crtc, &full_update);
+=20
+ 		/* One pipe falling back takes all of them with it. */
+ 		if (full_update)
+ 			break;
+ 	}
+=20
+ 	/*
+ 	 * TODO: For now we are just using full update in case selective fetch
+ 	 * area calculation fails. To optimize this we should identify cases
+ 	 * where this happens and fix the area calculation for those.
+ 	 */
+ 	if (!full_update && !psr2_sel_fetch_merge_su_area(state, joined_pipes))
+ 		full_update =3D true;
+=20
+ 	if (!full_update) {
+ 		/*
+ 		 * The WAs clamp the SU region that ends up in the per
+ 		 * transcoder PSR2_MAN_TRK_CTL, so they have to run on the
+ 		 * merged area rather than on the per pipe ones. crtc_state is
+ 		 * the joiner primary, the only one carrying the encoders the
+ 		 * WAs look at, and the merge guarantees a non empty area.
+ 		 */
+ 		intel_psr_apply_su_area_workarounds(crtc_state);
+ 		psr2_sel_fetch_set_su_area(state, joined_pipes,
+ 					   crtc_state->psr2_su_area.y1,
+ 					   crtc_state->psr2_su_area.y2);
+=20
+ 		psr2_sel_fetch_align_su_area(state, joined_pipes);
+ 	}
+=20
+ 	for_each_intel_crtc_in_pipe_mask(display, joined_crtc, joined_pipes) {
+ 		ret =3D psr2_sel_fetch_apply_su_area(state, joined_crtc, full_update);
+ 		if (ret)
+ 			return ret;
+ 	}
+=20
  	return 0;
  }
 =20
@@@ -3332,7 -3486,7 +3491,7 @@@ void intel_psr_wait_for_idle_locked(con
  		return;
 =20
  	for_each_intel_encoder_mask_with_psr(display->drm, encoder,
- 					     new_crtc_state->uapi.encoder_mask) {
+ 					     psr_encoder_mask(new_crtc_state)) {
  		struct intel_dp *intel_dp =3D enc_to_intel_dp(encoder);
  		int ret;
 =20
@@@ -3621,8 -3775,7 +3780,7 @@@ void intel_psr_invalidate(struct intel_
  			continue;
  		}
 =20
- 		pipe_frontbuffer_bits &=3D
- 			INTEL_FRONTBUFFER_ALL_MASK(intel_dp->psr.pipe);
+ 		pipe_frontbuffer_bits &=3D psr_frontbuffer_mask(intel_dp);
  		intel_dp->psr.busy_frontbuffer_bits |=3D pipe_frontbuffer_bits;
 =20
  		if (pipe_frontbuffer_bits)
@@@ -3702,8 -3855,7 +3860,7 @@@ void intel_psr_flush(struct intel_displ
  			continue;
  		}
 =20
- 		pipe_frontbuffer_bits &=3D
- 			INTEL_FRONTBUFFER_ALL_MASK(intel_dp->psr.pipe);
+ 		pipe_frontbuffer_bits &=3D psr_frontbuffer_mask(intel_dp);
  		intel_dp->psr.busy_frontbuffer_bits &=3D ~pipe_frontbuffer_bits;
 =20
  		/*
@@@ -3979,7 -4131,7 +4136,7 @@@ void intel_psr_lock(const struct intel_
  		return;
 =20
  	for_each_intel_encoder_mask_with_psr(display->drm, encoder,
- 					     crtc_state->uapi.encoder_mask) {
+ 					     psr_encoder_mask(crtc_state)) {
  		struct intel_dp *intel_dp =3D enc_to_intel_dp(encoder);
 =20
  		mutex_lock(&intel_dp->psr.lock);
@@@ -4002,7 -4154,7 +4159,7 @@@ void intel_psr_unlock(const struct inte
  		return;
 =20
  	for_each_intel_encoder_mask_with_psr(display->drm, encoder,
- 					     crtc_state->uapi.encoder_mask) {
+ 					     psr_encoder_mask(crtc_state)) {
  		struct intel_dp *intel_dp =3D enc_to_intel_dp(encoder);
 =20
  		mutex_unlock(&intel_dp->psr.lock);
@@@ -4607,6 -4759,10 +4764,10 @@@ void intel_psr_compute_config_late(stru
  		crtc_state->has_sel_update =3D false;
  		crtc_state->enable_psr2_su_region_et =3D false;
  		crtc_state->enable_psr2_sel_fetch =3D false;
+=20
+ 		/* Plain PSR1 is not supported with joiner. */
+ 		if (crtc_state->joiner_pipes)
+ 			crtc_state->has_psr =3D false;
  	}
 =20
  	/* Wa_18037818876 */

--OmMpsowGHg2watvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmroowsACgkQJNaLcl1U
h9CM8Qf/U5P8hBXCS8o2WjpX5BNLC2Lv++FEEl2klg2d5J8j/tXSf0rPMegn7qOP
OEiRM7HFoATxdPnsJUjufqE0SUCfbjotNy13Zk0lL6o3IvsxSU1znuwFyfDaHgkZ
82ZAE1Kn2PlVypzpzstnqRWNkPftO3H2Hk1yOXRY91P1WzBS/aynHL7CXH7FLZAk
EI9rqHIgCef4h9lPAv+9mKil1/RfjZB0nozsVMm9iMHu8rup7MHQ/Ts7o/qhkPmN
dYMIJIAtIfnxBB0WnVUxl2aZkScIw+VFnwMSY+rsPaytkYojCpJ+FQbUJAZG4ChN
UeuEGUiyi/DJoGu4EixjdcCpzgaLpg==
=C5VS
-----END PGP SIGNATURE-----

--OmMpsowGHg2watvk--

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4E6606A934
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDvspN6m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A922A10EF50;
	Mon,  2 Nov 2026 14:49:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CB2010EF4B;
 Mon,  2 Nov 2026 14:49:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 335B243965;
 Mon,  2 Nov 2026 14:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832BE1F00A17;
 Mon,  2 Nov 2026 14:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793630977;
 bh=OPiT+5sNut9jIyct1/7n9MiZaAuYp/ZVynxMuxiF3eo=;
 h=Date:From:To:Cc:Subject;
 b=kDvspN6mxEDV+Iw046o4aOyLiaPmit0uYTvt4tV7RxxnVb3hqY9z3pgy2MoBSSpbx
 7sCQ8Oum59Qg2C6e0e0KP6NkOALB2lzgeWskGv5EK2UCBUn0rSqVwgPp4NsYZYnAuQ
 6DbP5flu0xtLcQd5QZuUHkBtCb86BaSAT9C2/tfLqCtrf+QynnrJyt1VrKX6+d8U3K
 aTPmDPvHcbAWQDVbNFT/pwMKoXjwBIUTGrDaMee00koL0p+ZjyYd0hQSgDOdOLyTc5
 8uAPiLmyhuqufMfR3vW5SsDvxjNcI0o17uUxdbEqmGWzyyPHuFmWvofzaOW+trAzUA
 pZJFwz6hNUHvw==
Date: Mon, 2 Nov 2026 14:49:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Mika Kahola <mika.kahola@intel.com>,
 Suraj Kandpal <suraj.kandpal@intel.com>,
 Uma Shankar <uma.shankar@intel.com>,
 Vidya Srinivas <vidya.srinivas@intel.com>
Subject: linux-next: manual merge of the drm-intel tree with the
 drm-intel-fixes tree
Message-ID: <auii-xCnyvW_d1ED@sirena.org.uk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fCs3BRg7iJNSnLVM"
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


--fCs3BRg7iJNSnLVM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

  drivers/gpu/drm/i915/display/intel_dp.c

between commit:

  b42b656db1384 ("drm/i915/display: Disable pipe joiner on WCL")

=66rom the drm-intel-fixes tree and commits:

  917676a55a690 ("drm/i915/display: Disable pipe joiner on WCL")
  355ce9db5fcff ("drm/i915/display: Allow forcing the joiner on eDP")
  a1cce75d66ad1 ("drm/i915/dp: Bump the max Link M/N ratio to 22 for DISPLA=
Y_VER >=3D 35")
  cfbcf0a546bdb ("drm/i915/dp: Extend intel_dp_can_support_m_n() for BMG M/=
N bypass")
  244cae26882a9 ("drm/i915/display: Implement Wa_14021768792 for BMG DP for=
 link_m/n ratio > 10")
  3f96e57cda40f ("drm/i915/dp: Add M/N ratio check for DP link config")
  be3b2c9a29aef ("drm/i915/dp_mst: Limit M/N ratio for MST")
  6af30a4f3668d ("drm/i915/display_wa: Add support for Wa_14014191401")
  7a75b5717409c ("drm/i915/dp: Limit M/N ratio for DP")

=66rom the drm-intel tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/i915/display/intel_dp.c
index 47741957935ae,ef164a7976187..0000000000000
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@@ -63,12 -63,14 +63,14 @@@
  #include "intel_de.h"
  #include "intel_dip.h"
  #include "intel_dip_regs.h"
+ #include "intel_display.h"
  #include "intel_display_driver.h"
  #include "intel_display_jiffies.h"
  #include "intel_display_utils.h"
  #include "intel_display_regs.h"
  #include "intel_display_rpm.h"
  #include "intel_display_types.h"
+ #include "intel_display_wa.h"
  #include "intel_dp.h"
  #include "intel_dp_aux.h"
  #include "intel_dp_hdcp.h"
@@@ -473,9 -475,15 +475,15 @@@ bool intel_dp_has_joiner(struct intel_d
  	if (intel_dp->mso_link_count)
  		return false;
 =20
- 	if (intel_dp_is_edp(intel_dp) &&
- 	    !connector->panel.vbt.edp.pipe_joiner_enable)
- 		return false;
+ 	if (intel_dp_is_edp(intel_dp)) {
+ 		bool pipe_joiner_enable =3D connector->panel.vbt.edp.pipe_joiner_enable;
+=20
+ 		if (connector->force_joined_pipes > 1)
+ 			pipe_joiner_enable =3D true;
+=20
+ 		if (!pipe_joiner_enable)
+ 			return false;
+ 	}
 =20
  	return ((DISPLAY_VER(display) >=3D 12 && DISPLAY_VERx100(display) !=3D 3=
002) ||
  		(DISPLAY_VER(display) =3D=3D 11 &&
@@@ -1267,6 -1275,93 +1275,93 @@@ bool intel_dp_has_dsc(const struct inte
  	return true;
  }
 =20
+ static int
+ intel_dp_get_max_m_n_ratio(struct intel_display *display)
+ {
+ 	if (DISPLAY_VER(display) >=3D 35)
+ 		return 22;
+=20
+ 	if (intel_display_wa(display, INTEL_DISPLAY_WA_14014191401))
+ 		return 4;
+=20
+ 	return 10;
+ }
+=20
+ static int intel_dp_link_m_n_ratio(u32 link_m, u32 link_n)
+ {
+ 	if (!link_n)
+ 		return 0;
+=20
+ 	return DIV_ROUND_UP(link_m, link_n);
+ }
+=20
+ static bool
+ intel_dp_can_bypass_m_n_limit(struct intel_display *display, int link_rat=
e,
+ 			      int m_n_ratio, enum transcoder cpu_transcoder)
+ {
+ 	return drm_dp_is_uhbr_rate(link_rate) &&
+ 		intel_display_can_bypass_m_n_limit(display, m_n_ratio, cpu_transcoder);
+ }
+=20
+ bool intel_dp_can_support_m_n(struct intel_display *display,
+ 			      const struct intel_crtc_state *crtc_state,
+ 			      int pixel_clock, int link_rate)
+ {
+ 	int max_m_n_ratio =3D intel_dp_get_max_m_n_ratio(display);
+ 	enum transcoder cpu_transcoder =3D TRANSCODER_A;
+ 	u32 link_m, link_n;
+ 	int m_n_ratio;
+=20
+ 	intel_display_compute_link_m_n(&link_m, &link_n, pixel_clock,
+ 				       intel_dp_link_symbol_clock(link_rate));
+=20
+ 	m_n_ratio =3D intel_dp_link_m_n_ratio(link_m, link_n);
+=20
+ 	if (m_n_ratio <=3D max_m_n_ratio)
+ 		return true;
+=20
+ 	if (crtc_state)
+ 		cpu_transcoder =3D crtc_state->cpu_transcoder;
+=20
+ 	return intel_dp_can_bypass_m_n_limit(display, link_rate, m_n_ratio, cpu_=
transcoder);
+ }
+=20
+ void intel_dp_check_m_n_ratio(const struct intel_crtc_state *crtc_state,
+ 			      struct intel_link_m_n *m_n)
+ {
+ 	struct intel_display *display =3D to_intel_display(crtc_state);
+ 	int max_m_n_ratio =3D intel_dp_get_max_m_n_ratio(display);
+ 	int m_n_ratio;
+=20
+ 	m_n->bypass_m_n_ratio_limit =3D false;
+=20
+ 	m_n_ratio =3D intel_dp_link_m_n_ratio(m_n->link_m, m_n->link_n);
+=20
+ 	if (m_n_ratio <=3D max_m_n_ratio)
+ 		return;
+=20
+ 	if (intel_dp_can_bypass_m_n_limit(display, crtc_state->port_clock, m_n_r=
atio,
+ 					  crtc_state->cpu_transcoder)) {
+ 		m_n->bypass_m_n_ratio_limit =3D true;
+ 		drm_dbg_kms(display->drm,
+ 			    "Bypassing Link_m/Link_n ratio limit (ratio %d)\n",
+ 			    m_n_ratio);
+ 		return;
+ 	}
+=20
+ 	drm_dbg_kms(display->drm,
+ 		    "Link M/N ratio (%d) exceeds max allowed (%d)\n",
+ 		    m_n_ratio, max_m_n_ratio);
+ }
+=20
+ static int intel_dp_mso_pixel_clock(struct intel_dp *intel_dp, int pixel_=
clock)
+ {
+ 	if (!intel_dp->mso_link_count)
+ 		return pixel_clock;
+=20
+ 	return pixel_clock / intel_dp->mso_link_count;
+ }
+=20
  static
  bool intel_dp_can_join(struct intel_dp *intel_dp,
  		       int num_joined_pipes)
@@@ -1302,6 -1397,33 +1397,33 @@@ bool intel_dp_dotclk_valid(struct intel
  	return target_clock <=3D effective_dotclk_limit;
  }
 =20
+ static bool intel_dp_mode_valid_m_n(struct intel_dp *intel_dp, int pixel_=
clock)
+ {
+ 	struct intel_display *display =3D to_intel_display(intel_dp);
+ 	int m_n_pixel_clock =3D intel_dp_mso_pixel_clock(intel_dp, pixel_clock);
+ 	struct intel_dp_link_caps_order order =3D {
+ 		.key =3D INTEL_DP_LINK_CAPS_ORDER_KEY_RATE_LANE,
+ 		.dir =3D INTEL_DP_LINK_CAPS_ORDER_DIR_DESC,
+ 	};
+ 	struct intel_dp_link_config link_config;
+ 	struct intel_dp_link_caps_iter iter;
+ 	bool found =3D false;
+=20
+ 	intel_dp_link_caps_iter_start(&iter, intel_dp->link.caps, order,
+ 				      INTEL_DP_LINK_CAPS_FILTER_ALL);
+ 	for_each_dp_link_config(&iter, &link_config) {
+ 		if (intel_dp_can_support_m_n(display, NULL, m_n_pixel_clock,
+ 					     link_config.rate)) {
+ 			found =3D true;
+=20
+ 			break;
+ 		}
+ 	}
+ 	intel_dp_link_caps_iter_end(&iter);
+=20
+ 	return found;
+ }
+=20
  static enum drm_mode_status
  intel_dp_mode_valid_format(struct intel_connector *connector,
  			   const struct drm_display_mode *mode,
@@@ -1456,6 -1578,9 +1578,9 @@@ intel_dp_mode_valid(struct drm_connecto
  			return status;
  	}
 =20
+ 	if (!intel_dp_mode_valid_m_n(intel_dp, target_clock))
+ 		return MODE_CLOCK_HIGH;
+=20
  	/*
  	 * TODO: Even when using a 4:2:0 sink_format intel_dp_output_format()
  	 * will always choose a 4:4:4 output_format if the DFP can do the
@@@ -2656,6 -2781,49 +2781,49 @@@ intel_dp_dsc_compute_pipe_bpp_limits(st
  	return true;
  }
 =20
+ static bool
+ intel_dp_compute_m_n_ratio_limits(struct intel_dp *intel_dp,
+ 				  struct drm_connector_state *conn_state,
+ 				  const struct intel_crtc_state *crtc_state,
+ 				  struct link_config_limits *limits)
+ {
+ 	struct intel_display *display =3D to_intel_display(intel_dp);
+ 	struct intel_connector *connector =3D to_intel_connector(conn_state->con=
nector);
+ 	struct intel_dp_link_caps *link_caps =3D intel_dp->link.caps;
+ 	struct intel_dp_link_caps_order order =3D
+ 		intel_dp_link_caps_connector_compute_order(connector);
+ 	struct intel_dp_link_caps_filter new_filter =3D INTEL_DP_LINK_CAPS_FILTE=
R_NONE;
+ 	int pixel_clock =3D intel_dp_mso_pixel_clock(intel_dp,
+ 						  intel_dp_mode_clock(crtc_state, conn_state));
+ 	struct intel_dp_link_config link_config;
+ 	struct intel_dp_link_caps_iter iter;
+ 	bool found =3D false;
+=20
+ 	intel_dp_link_caps_iter_start(&iter, link_caps, order, limits->link_conf=
ig_filter);
+ 	for_each_dp_link_config(&iter, &link_config) {
+ 		if (!intel_dp_can_support_m_n(display, crtc_state, pixel_clock,
+ 					      link_config.rate))
+ 			continue;
+=20
+ 		intel_dp_link_caps_filter_add(link_caps, &new_filter, &link_config);
+ 		found =3D true;
+ 	}
+ 	intel_dp_link_caps_iter_end(&iter);
+=20
+ 	if (!found) {
+ 		drm_dbg_kms(display->drm,
+ 			    "[CONNECTOR:%d:%s] No link config with a Link M/N ratio <=3D %d\n",
+ 			    connector->base.base.id, connector->base.name,
+ 			    intel_dp_get_max_m_n_ratio(display));
+=20
+ 		return false;
+ 	}
+=20
+ 	limits->link_config_filter =3D new_filter;
+=20
+ 	return true;
+ }
+=20
  bool
  intel_dp_compute_config_limits(struct intel_dp *intel_dp,
  			       struct drm_connector_state *conn_state,
@@@ -2772,6 -2940,9 +2940,9 @@@
  		limits->link_config_filter =3D new_filter;
  	}
 =20
+ 	if (!intel_dp_compute_m_n_ratio_limits(intel_dp, conn_state, crtc_state,=
 limits))
+ 		return false;
+=20
  	if (!intel_dp_test_compute_config(connector, crtc_state, limits))
  		return false;
 =20
@@@ -3263,6 -3434,9 +3434,9 @@@ static bool can_enable_drrs(struct inte
  	if (pipe_config->vrr.enable)
  		return false;
 =20
+ 	if (pipe_config->dp_m_n.bypass_m_n_ratio_limit)
+ 		return false;
+=20
  	/*
  	 * DRRS and PSR can't be enable together, so giving preference to PSR
  	 * as it allows more power-savings by complete shutting down display,
@@@ -3297,7 -3471,8 +3471,8 @@@ intel_dp_drrs_compute_config(struct int
  	 * FIXME all joined pipes share the same transcoder.
  	 * Need to account for that when updating M/N live.
  	 */
- 	if (has_seamless_m_n(connector) && !pipe_config->joiner_pipes)
+ 	if (has_seamless_m_n(connector) && !pipe_config->joiner_pipes &&
+ 	    !pipe_config->dp_m_n.bypass_m_n_ratio_limit)
  		pipe_config->update_m_n =3D true;
 =20
  	if (!can_enable_drrs(connector, pipe_config, downclock_mode)) {
@@@ -3640,6 -3815,8 +3815,8 @@@ intel_dp_compute_config(struct intel_at
  				       pipe_config->port_clock,
  				       intel_dp_bw_fec_overhead(pipe_config->fec_enable),
  				       &pipe_config->dp_m_n);
+=20
+ 		intel_dp_check_m_n_ratio(pipe_config, &pipe_config->dp_m_n);
  	}
 =20
  	ret =3D intel_dp_compute_min_hblank(pipe_config, conn_state);

--fCs3BRg7iJNSnLVM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmroovoACgkQJNaLcl1U
h9BQswf/XmShDnwUSg0cqZj+WbXkiYC/wcBTz3BnPtX2zT10UbmCWKTeMeD7i7Xk
manAniP7Y4urudeZnmVOTxRyDCdyFT7AqJ6CEqsxlihGKMFg6sSRtpiDio9gcY9/
jtyH8eYX2P+uSY7nmGARxQcni3nYbBHC7NKB1Yu84Bdy0WHL56d/lqgPr/S9rSmw
XhmCuDdql57uuMWHeIM5p8RJ68wAOAuKyGsYuoTcBLfXu2KitlTkZ31qMV3KiwF7
YBNAztRKO1juLyVssw1IfjILlRAokzDktTYfHSkVuOUvy5wvr+00QJW/NBDLP8ux
kOkRG9qWi8lJqlfIoWeDfQpZC+yQJw==
=bP3A
-----END PGP SIGNATURE-----

--fCs3BRg7iJNSnLVM--

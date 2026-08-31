Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C5EC624CE
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 294E910E893;
	Mon, 31 Aug 2026 13:43:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oJt7A5f7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA51710E891;
 Mon, 31 Aug 2026 13:43:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 42D93602BA;
 Mon, 31 Aug 2026 13:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87C11F00ACF;
 Mon, 31 Aug 2026 13:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788183789;
 bh=x1bHfkancCaYMe6fYy0BgP6DOqXkqyCpu8H08GO/7m0=;
 h=Date:From:To:Cc:Subject;
 b=oJt7A5f7zk/IITbfzbAC29sPWk0z1Ou5oNpC7kEBPCXkWI4v2icggrzemLXgL3vLK
 dVS3grw+uQ7kwIVsOnwBLmGna1tAwt35u/UJq9nO5kdAILvManqmABxxoqUM9EExuL
 YuNDB58cZqh5ynYNrdYcskZYmDozyMQiwSu/VCLOd+JtXyrlvSoxnpvQjQ2hc1t/u8
 dbfsjDSwX5s9kDJvevNswOubc2AN+Kqj4/X45X2rZM0q7cXRnW3pKiNSXJwKJP8Vou
 KviptT2emZhirbVi/Z2pa4V8rU974u36rdUiD/F7za00/C14LSBPMeZM02TL/3FDO6
 VWDBeAu3t0iEA==
Date: Mon, 31 Aug 2026 14:43:04 +0100
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
 Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: linux-next: manual merge of the drm-intel tree with the
 drm-intel-fixes tree
Message-ID: <apWE6M_eFoMoNV7T@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P8RMu5SLb3HNCuTg"
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


--P8RMu5SLb3HNCuTg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

  drivers/gpu/drm/i915/display/intel_cdclk.c

between commits:

  aad969968824e ("drm/i915/cdclk: Avoid spurious cdclk sanitization on PTL+=
")
  a154f2ae8eecb ("drm/i915/cdclk: Fix dg2_power_well_count() return type")

=66rom the drm-intel-fixes tree and commits:

  050e8067dcb8f ("drm/i915/cdclk: Hoist intel_cdclk_{pre,post}_notify() cal=
ls upwards")
  22d664affc438 ("drm/i915/cdclk: Introduce CDCLK .{pre,post}_notify() vfun=
cs")
  6dc9d09567047 ("drm/i915/cdclk: Extract bxt_cdclk_pcode_{pre,post}_notify=
()")
  14890a802ea4d ("drm/i915/cdclk: Extract skl_cdclk_pcode_{pre,post}_notify=
()")
  1098a94f822d2 ("drm/i915/cdclk: Extract bdw_cdclk_pcode_{pre,post}_notify=
()")
  e2760d76d1a20 ("drm/i915/cdclk: Unify pcode related debugs")
  9131fd68a86ba ("drm/i915/cdclk: Unify the pcode pre/post notify in bxt_se=
t_cdclk()")
  8961ea13bec45 ("drm/i915/cdclk: s/intel_/dg2_/ for DG2 specific stuff")
  cd4cd31960608 ("drm/i915/cdclk: Drop pointless platform check from bxt_se=
t_cdclk()")
  934b9973f7124 ("drm/i915/cdclk: Stop forcing voltage level to 3 all the t=
ime on DG2")
  e68e1b80d1639 ("drm/i915/cdclk: Notify DG2 pcode about pipe power wells r=
egardless of CDCLK")
  3f8c7b2fdd0e8 ("drm/i915/cdclk: Do the DG2 CDCLK/pipe power well notify p=
roperly")
  dc2a960b64354 ("drm/i915/cdclk: Pass CDCLK in MHz to pcode on DG2")
  bed6347ae41b0 ("drm/i915/cdclk: Don't bail if pcode post nofify fails")
  dcf423710d025 ("drm/i915/cdclk: Fix dg2_power_well_count() return type")
  1ceb1ef81c32e ("drm/i915/cdclk: Introduce has_cd2x_pipe_select()")
  1786d26887817 ("drm/i915/cdclk: Avoid spurious cdclk sanitization on PTL+=
")

=66rom the drm-intel tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/i915/display/intel_cdclk.c
index a1a5720996b70,92e6fca861f64..0000000000000
--- a/drivers/gpu/drm/i915/display/intel_cdclk.c
+++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
@@@ -163,6 -163,9 +163,9 @@@ struct intel_cdclk_funcs=20
  	void (*set_cdclk)(struct intel_display *display,
  			  const struct intel_cdclk_config *cdclk_config,
  			  enum pipe pipe);
+ 	int (*pre_notify)(struct intel_display *display);
+ 	int (*post_notify)(struct intel_display *display,
+ 			   const struct intel_cdclk_config *cdclk_config);
  	int (*modeset_calc_cdclk)(struct intel_atomic_state *state);
  	u8 (*calc_voltage_level)(int cdclk);
  };
@@@ -173,11 -176,45 +176,45 @@@ void intel_cdclk_get_cdclk(struct intel
  	display->cdclk.funcs->get_cdclk(display, cdclk_config);
  }
 =20
+ static int intel_cdclk_pre_notify(struct intel_display *display)
+ {
+ 	int ret;
+=20
+ 	if (!display->cdclk.funcs->pre_notify)
+ 		return 0;
+=20
+ 	ret =3D display->cdclk.funcs->pre_notify(display);
+ 	if (ret)
+ 		drm_err(display->drm,
+ 			"Failed to inform system about start of CDCLK change (%d)\n", ret);
+=20
+ 	return ret;
+ }
+=20
+ static void intel_cdclk_post_notify(struct intel_display *display,
+ 				    const struct intel_cdclk_config *cdclk_config)
+ {
+ 	int ret;
+=20
+ 	if (!display->cdclk.funcs->post_notify)
+ 		return;
+=20
+ 	ret =3D display->cdclk.funcs->post_notify(display, cdclk_config);
+ 	if (ret)
+ 		drm_err(display->drm,
+ 			"Failed to inform system about end of CDCLK change (%d)\n", ret);
+ }
+=20
  static void intel_cdclk_set_cdclk(struct intel_display *display,
  				  const struct intel_cdclk_config *cdclk_config,
  				  enum pipe pipe)
  {
+ 	if (intel_cdclk_pre_notify(display))
+ 		return;
+=20
  	display->cdclk.funcs->set_cdclk(display, cdclk_config, pipe);
+=20
+ 	intel_cdclk_post_notify(display, cdclk_config);
  }
 =20
  static int intel_cdclk_modeset_calc_cdclk(struct intel_atomic_state *stat=
e)
@@@ -872,6 -909,19 +909,19 @@@ static u32 bdw_cdclk_freq_sel(int cdclk
  	}
  }
 =20
+ static int bdw_cdclk_pcode_pre_notify(struct intel_display *display)
+ {
+ 	return intel_parent_pcode_write(display, BDW_PCODE_DISPLAY_FREQ_CHANGE_R=
EQ,
+ 					0x0);
+ }
+=20
+ static int bdw_cdclk_pcode_post_notify(struct intel_display *display,
+ 				       const struct intel_cdclk_config *cdclk_config)
+ {
+ 	return intel_parent_pcode_write(display, HSW_PCODE_DE_WRITE_FREQ_REQ,
+ 					cdclk_config->voltage_level);
+ }
+=20
  static void bdw_set_cdclk(struct intel_display *display,
  			  const struct intel_cdclk_config *cdclk_config,
  			  enum pipe pipe)
@@@ -888,13 -938,6 +938,6 @@@
  		     "trying to change cdclk frequency with cdclk not enabled\n"))
  		return;
 =20
- 	ret =3D intel_parent_pcode_write(display, BDW_PCODE_DISPLAY_FREQ_CHANGE_=
REQ, 0x0);
- 	if (ret) {
- 		drm_err(display->drm,
- 			"failed to inform pcode about cdclk change\n");
- 		return;
- 	}
-=20
  	intel_de_rmw(display, LCPLL_CTL,
  		     0, LCPLL_CD_SOURCE_FCLK);
 =20
@@@ -918,9 -961,6 +961,6 @@@
  	if (ret)
  		drm_err(display->drm, "Switching back to LCPLL failed\n");
 =20
- 	intel_parent_pcode_write(display, HSW_PCODE_DE_WRITE_FREQ_REQ,
- 				 cdclk_config->voltage_level);
-=20
  	intel_de_write(display, CDCLK_FREQ,
  		       DIV_ROUND_CLOSEST(cdclk, 1000) - 1);
 =20
@@@ -1155,6 -1195,21 +1195,21 @@@ static u32 skl_cdclk_freq_sel(struct in
  	}
  }
 =20
+ static int skl_cdclk_pcode_pre_notify(struct intel_display *display)
+ {
+ 	return intel_parent_pcode_request(display, SKL_PCODE_CDCLK_CONTROL,
+ 					  SKL_CDCLK_PREPARE_FOR_CHANGE,
+ 					  SKL_CDCLK_READY_FOR_CHANGE,
+ 					  SKL_CDCLK_READY_FOR_CHANGE, 3);
+ }
+=20
+ static int skl_cdclk_pcode_post_notify(struct intel_display *display,
+ 				       const struct intel_cdclk_config *cdclk_config)
+ {
+ 	return intel_parent_pcode_write(display, SKL_PCODE_CDCLK_CONTROL,
+ 					cdclk_config->voltage_level);
+ }
+=20
  static void skl_set_cdclk(struct intel_display *display,
  			  const struct intel_cdclk_config *cdclk_config,
  			  enum pipe pipe)
@@@ -1162,7 -1217,6 +1217,6 @@@
  	int cdclk =3D cdclk_config->cdclk;
  	int vco =3D cdclk_config->vco;
  	u32 freq_select, cdclk_ctl;
- 	int ret;
 =20
  	/*
  	 * Based on WA#1183 CDCLK rates 308 and 617MHz CDCLK rates are
@@@ -1175,16 -1229,6 +1229,6 @@@
  	drm_WARN_ON_ONCE(display->drm,
  			 display->platform.skylake && vco =3D=3D 8640000);
 =20
- 	ret =3D intel_parent_pcode_request(display, SKL_PCODE_CDCLK_CONTROL,
- 					 SKL_CDCLK_PREPARE_FOR_CHANGE,
- 					 SKL_CDCLK_READY_FOR_CHANGE,
- 					 SKL_CDCLK_READY_FOR_CHANGE, 3);
- 	if (ret) {
- 		drm_err(display->drm,
- 			"Failed to inform PCU about cdclk change (%d)\n", ret);
- 		return;
- 	}
-=20
  	freq_select =3D skl_cdclk_freq_sel(display, cdclk, vco);
 =20
  	if (display->cdclk.hw.vco !=3D 0 &&
@@@ -1220,10 -1264,6 +1264,6 @@@
  	intel_de_write(display, CDCLK_CTL, cdclk_ctl);
  	intel_de_posting_read(display, CDCLK_CTL);
 =20
- 	/* inform PCU of the change */
- 	intel_parent_pcode_write(display, SKL_PCODE_CDCLK_CONTROL,
- 				 cdclk_config->voltage_level);
-=20
  	intel_update_cdclk(display);
  }
 =20
@@@ -1314,7 -1354,7 +1354,7 @@@ static void skl_cdclk_init_hw(struct in
  	cdclk_config.cdclk =3D skl_calc_cdclk(0, cdclk_config.vco);
  	cdclk_config.voltage_level =3D skl_calc_voltage_level(cdclk_config.cdclk=
);
 =20
- 	skl_set_cdclk(display, &cdclk_config, INVALID_PIPE);
+ 	intel_cdclk_set_cdclk(display, &cdclk_config, INVALID_PIPE);
  }
 =20
  static void skl_cdclk_uninit_hw(struct intel_display *display)
@@@ -1325,7 -1365,7 +1365,7 @@@
  	cdclk_config.vco =3D 0;
  	cdclk_config.voltage_level =3D skl_calc_voltage_level(cdclk_config.cdclk=
);
 =20
- 	skl_set_cdclk(display, &cdclk_config, INVALID_PIPE);
+ 	intel_cdclk_set_cdclk(display, &cdclk_config, INVALID_PIPE);
  }
 =20
  struct intel_cdclk_vals {
@@@ -2177,6 -2217,11 +2217,11 @@@ static bool pll_enable_wa_needed(struc
  		display->cdclk.hw.vco > 0;
  }
 =20
+ static bool has_cd2x_pipe_select(struct intel_display *display)
+ {
+ 	return IS_DISPLAY_VER(display, 10, 20) || display->platform.broxton;
+ }
+=20
  static u32 bxt_cdclk_ctl(struct intel_display *display,
  			 const struct intel_cdclk_config *cdclk_config,
  			 enum pipe pipe)
@@@ -2190,7 -2235,7 +2235,7 @@@
 =20
  	val =3D bxt_cdclk_cd2x_div_sel(display, cdclk, vco, waveform);
 =20
- 	if (DISPLAY_VER(display) < 30)
+ 	if (has_cd2x_pipe_select(display))
  		val |=3D bxt_cdclk_cd2x_pipe(display, pipe);
 =20
  	/*
@@@ -2220,6 -2265,29 +2265,29 @@@
  	return val;
  }
 =20
+ static int bxt_cdclk_pcode_pre_notify(struct intel_display *display)
+ {
+ 	/*
+ 	 * BSpec requires us to wait up to 150usec, but that leads to
+ 	 * timeouts; the 2ms used here is based on experiment.
+ 	 */
+ 	return intel_parent_pcode_write_timeout(display, HSW_PCODE_DE_WRITE_FREQ=
_REQ,
+ 						0x80000000, 2);
+ }
+=20
+ static int bxt_cdclk_pcode_post_notify(struct intel_display *display,
+ 				       const struct intel_cdclk_config *cdclk_config)
+ {
+ 	/*
+ 	 * The timeout isn't specified, the 2ms used here is based on
+ 	 * experiment.
+ 	 * FIXME: Waiting for the request completion could be delayed
+ 	 * until the next PCODE request based on BSpec.
+ 	 */
+ 	return intel_parent_pcode_write_timeout(display, HSW_PCODE_DE_WRITE_FREQ=
_REQ,
+ 						cdclk_config->voltage_level, 2);
+ }
+=20
  static void _bxt_set_cdclk(struct intel_display *display,
  			   const struct intel_cdclk_config *cdclk_config,
  			   enum pipe pipe)
@@@ -2259,36 -2327,6 +2327,6 @@@ static void bxt_set_cdclk(struct intel_
  {
  	struct intel_cdclk_config mid_cdclk_config;
  	int cdclk =3D cdclk_config->cdclk;
- 	int ret =3D 0;
-=20
- 	/*
- 	 * Inform power controller of upcoming frequency change.
- 	 * Display versions 14 and beyond do not follow the PUnit
- 	 * mailbox communication, skip
- 	 * this step.
- 	 */
- 	if (DISPLAY_VER(display) >=3D 14 || display->platform.dg2)
- 		; /* NOOP */
- 	else if (DISPLAY_VER(display) >=3D 11)
- 		ret =3D intel_parent_pcode_request(display, SKL_PCODE_CDCLK_CONTROL,
- 						 SKL_CDCLK_PREPARE_FOR_CHANGE,
- 						 SKL_CDCLK_READY_FOR_CHANGE,
- 						 SKL_CDCLK_READY_FOR_CHANGE, 3);
- 	else
- 		/*
- 		 * BSpec requires us to wait up to 150usec, but that leads to
- 		 * timeouts; the 2ms used here is based on experiment.
- 		 */
- 		ret =3D intel_parent_pcode_write_timeout(display,
- 						       HSW_PCODE_DE_WRITE_FREQ_REQ,
- 						       0x80000000, 2);
-=20
- 	if (ret) {
- 		drm_err(display->drm,
- 			"Failed to inform PCU about cdclk change (err %d, freq %d)\n",
- 			ret, cdclk);
- 		return;
- 	}
 =20
  	if (DISPLAY_VER(display) >=3D 20 && cdclk < display->cdclk.hw.cdclk)
  		xe2lpd_mdclk_cdclk_ratio_program(display, cdclk_config);
@@@ -2304,40 -2342,13 +2342,13 @@@
  	if (DISPLAY_VER(display) >=3D 20 && cdclk > display->cdclk.hw.cdclk)
  		xe2lpd_mdclk_cdclk_ratio_program(display, cdclk_config);
 =20
- 	if (DISPLAY_VER(display) >=3D 14)
- 		/*
- 		 * NOOP - No Pcode communication needed for
- 		 * Display versions 14 and beyond
- 		 */;
- 	else if (DISPLAY_VER(display) >=3D 11 && !display->platform.dg2)
- 		ret =3D intel_parent_pcode_write(display, SKL_PCODE_CDCLK_CONTROL,
- 					       cdclk_config->voltage_level);
- 	if (DISPLAY_VER(display) < 11) {
- 		/*
- 		 * The timeout isn't specified, the 2ms used here is based on
- 		 * experiment.
- 		 * FIXME: Waiting for the request completion could be delayed
- 		 * until the next PCODE request based on BSpec.
- 		 */
- 		ret =3D intel_parent_pcode_write_timeout(display,
- 						       HSW_PCODE_DE_WRITE_FREQ_REQ,
- 						       cdclk_config->voltage_level, 2);
- 	}
- 	if (ret) {
- 		drm_err(display->drm,
- 			"PCode CDCLK freq set failed, (err %d, freq %d)\n",
- 			ret, cdclk);
- 		return;
- 	}
-=20
  	intel_update_cdclk(display);
 =20
- 	if (DISPLAY_VER(display) >=3D 11)
- 		/*
- 		 * Can't read out the voltage level :(
- 		 * Let's just assume everything is as expected.
- 		 */
- 		display->cdclk.hw.voltage_level =3D cdclk_config->voltage_level;
+ 	/*
+ 	 * Can't read out the voltage level :(
+ 	 * Let's just assume everything is as expected.
+ 	 */
+ 	display->cdclk.hw.voltage_level =3D cdclk_config->voltage_level;
  }
 =20
  static void bxt_sanitize_cdclk(struct intel_display *display)
@@@ -2381,7 -2392,7 +2392,7 @@@
  	 * dividers both syncing to an active pipe, or asynchronously
  	 * (PIPE_NONE).
  	 */
- 	if (DISPLAY_VER(display) < 30) {
+ 	if (has_cd2x_pipe_select(display)) {
  		cdctl &=3D ~bxt_cdclk_cd2x_pipe_mask(display);
  		cdctl |=3D bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
  	}
@@@ -2437,7 -2448,7 +2448,7 @@@ static void bxt_cdclk_init_hw(struct in
  	cdclk_config.voltage_level =3D
  		intel_cdclk_calc_voltage_level(display, cdclk_config.cdclk);
 =20
- 	bxt_set_cdclk(display, &cdclk_config, INVALID_PIPE);
+ 	intel_cdclk_set_cdclk(display, &cdclk_config, INVALID_PIPE);
  }
 =20
  static void bxt_cdclk_uninit_hw(struct intel_display *display)
@@@ -2449,7 -2460,7 +2460,7 @@@
  	cdclk_config.voltage_level =3D
  		intel_cdclk_calc_voltage_level(display, cdclk_config.cdclk);
 =20
- 	bxt_set_cdclk(display, &cdclk_config, INVALID_PIPE);
+ 	intel_cdclk_set_cdclk(display, &cdclk_config, INVALID_PIPE);
  }
 =20
  /**
@@@ -2579,8 -2590,7 +2590,7 @@@ static bool intel_cdclk_can_cd2x_update
  					const struct intel_cdclk_config *a,
  					const struct intel_cdclk_config *b)
  {
- 	/* Older hw doesn't have the capability */
- 	if (DISPLAY_VER(display) < 10 && !display->platform.broxton)
+ 	if (!has_cd2x_pipe_select(display))
  		return false;
 =20
  	/*
@@@ -2623,19 -2633,15 +2633,15 @@@ void intel_cdclk_dump_config(struct int
  		    cdclk_config->voltage_level);
  }
 =20
- static void intel_pcode_notify(struct intel_display *display,
- 			       u8 voltage_level,
- 			       u8 active_pipe_count,
- 			       u16 cdclk,
- 			       bool cdclk_update_valid,
- 			       bool pipe_count_update_valid)
+ static int dg2_cdclk_pcode_notify(struct intel_display *display,
+ 				  u8 voltage_level,
+ 				  u8 active_pipe_count,
+ 				  u16 cdclk,
+ 				  bool cdclk_update_valid,
+ 				  bool pipe_count_update_valid)
  {
- 	int ret;
  	u32 update_mask =3D 0;
 =20
- 	if (!display->platform.dg2)
- 		return;
-=20
  	update_mask =3D DISPLAY_TO_PCODE_UPDATE_MASK(cdclk, active_pipe_count, v=
oltage_level);
 =20
  	if (cdclk_update_valid)
@@@ -2644,15 -2650,10 +2650,10 @@@
  	if (pipe_count_update_valid)
  		update_mask |=3D DISPLAY_TO_PCODE_PIPE_COUNT_VALID;
 =20
- 	ret =3D intel_parent_pcode_request(display, SKL_PCODE_CDCLK_CONTROL,
- 					 SKL_CDCLK_PREPARE_FOR_CHANGE |
- 					 update_mask,
- 					 SKL_CDCLK_READY_FOR_CHANGE,
- 					 SKL_CDCLK_READY_FOR_CHANGE, 3);
- 	if (ret)
- 		drm_err(display->drm,
- 			"Failed to inform PCU about display config (err %d)\n",
- 			ret);
+ 	return intel_parent_pcode_request(display, SKL_PCODE_CDCLK_CONTROL,
+ 					  update_mask,
+ 					  SKL_CDCLK_READY_FOR_CHANGE,
+ 					  SKL_CDCLK_READY_FOR_CHANGE, 3);
  }
 =20
  static void intel_set_cdclk(struct intel_display *display,
@@@ -2721,15 -2722,17 +2722,17 @@@ static int dg2_power_well_count(struct=
=20
  	return display->platform.dg2 ? hweight8(cdclk_state->active_pipes) : 0;
  }
 =20
- static void intel_cdclk_pcode_pre_notify(struct intel_atomic_state *state)
+ static void dg2_cdclk_pcode_pre_notify(struct intel_atomic_state *state)
  {
  	struct intel_display *display =3D to_intel_display(state);
  	const struct intel_cdclk_state *old_cdclk_state =3D
  		intel_atomic_get_old_cdclk_state(state);
  	const struct intel_cdclk_state *new_cdclk_state =3D
  		intel_atomic_get_new_cdclk_state(state);
- 	unsigned int cdclk =3D 0; u8 voltage_level, num_active_pipes =3D 0;
+ 	u8 voltage_level, num_active_pipes =3D 0;
  	bool change_cdclk, update_pipe_count;
+ 	unsigned int cdclk_mhz =3D 0;
+ 	int ret;
 =20
  	if (!intel_cdclk_changed(&old_cdclk_state->actual,
  				 &new_cdclk_state->actual) &&
@@@ -2750,8 -2753,12 +2753,12 @@@
  	 * if CDCLK is decreasing or not changing, set bits 25:16 to current CDC=
LK,
  	 * which basically means we choose the maximum of old and new CDCLK, if =
we know both
  	 */
- 	if (change_cdclk)
- 		cdclk =3D max(new_cdclk_state->actual.cdclk, old_cdclk_state->actual.cd=
clk);
+ 	if (change_cdclk) {
+ 		unsigned int cdclk =3D max(new_cdclk_state->actual.cdclk,
+ 					 old_cdclk_state->actual.cdclk);
+=20
+ 		cdclk_mhz =3D DIV_ROUND_UP(cdclk, 1000);
+ 	}
 =20
  	/*
  	 * According to "Sequence For Pipe Count Change",
@@@ -2762,19 -2769,24 +2769,24 @@@
  	if (update_pipe_count)
  		num_active_pipes =3D dg2_power_well_count(display, new_cdclk_state);
 =20
- 	intel_pcode_notify(display, voltage_level, num_active_pipes, cdclk,
- 			   change_cdclk, update_pipe_count);
+ 	ret =3D dg2_cdclk_pcode_notify(display, voltage_level, num_active_pipes,=
 cdclk_mhz,
+ 				     change_cdclk, update_pipe_count);
+ 	if (ret)
+ 		drm_err(display->drm,
+ 			"Failed to inform PCODE about start of CDCLK change (%d)\n", ret);
  }
 =20
- static void intel_cdclk_pcode_post_notify(struct intel_atomic_state *stat=
e)
+ static void dg2_cdclk_pcode_post_notify(struct intel_atomic_state *state)
  {
  	struct intel_display *display =3D to_intel_display(state);
  	const struct intel_cdclk_state *new_cdclk_state =3D
  		intel_atomic_get_new_cdclk_state(state);
  	const struct intel_cdclk_state *old_cdclk_state =3D
  		intel_atomic_get_old_cdclk_state(state);
- 	unsigned int cdclk =3D 0; u8 voltage_level, num_active_pipes =3D 0;
+ 	u8 voltage_level, num_active_pipes =3D 0;
  	bool update_cdclk, update_pipe_count;
+ 	unsigned int cdclk_mhz =3D 0;
+ 	int ret;
 =20
  	/* According to "Sequence After Frequency Change", set voltage to used l=
evel */
  	voltage_level =3D new_cdclk_state->actual.voltage_level;
@@@ -2787,8 -2799,11 +2799,11 @@@
  	 * According to "Sequence After Frequency Change",
  	 * set bits 25:16 to current CDCLK
  	 */
- 	if (update_cdclk)
- 		cdclk =3D new_cdclk_state->actual.cdclk;
+ 	if (update_cdclk) {
+ 		unsigned int cdclk =3D new_cdclk_state->actual.cdclk;
+=20
+ 		cdclk_mhz =3D DIV_ROUND_UP(cdclk, 1000);
+ 	}
 =20
  	/*
  	 * According to "Sequence For Pipe Count Change",
@@@ -2799,8 -2814,11 +2814,11 @@@
  	if (update_pipe_count)
  		num_active_pipes =3D dg2_power_well_count(display, new_cdclk_state);
 =20
- 	intel_pcode_notify(display, voltage_level, num_active_pipes, cdclk,
- 			   update_cdclk, update_pipe_count);
+ 	ret =3D dg2_cdclk_pcode_notify(display, voltage_level, num_active_pipes,=
 cdclk_mhz,
+ 				     update_cdclk, update_pipe_count);
+ 	if (ret)
+ 		drm_err(display->drm,
+ 			"Failed to inform PCODE about end of CDCLK change (%d)\n", ret);
  }
 =20
  bool intel_cdclk_is_decreasing_later(struct intel_atomic_state *state)
@@@ -2836,12 -2854,11 +2854,11 @@@ intel_set_cdclk_pre_plane_update(struc
  		return;
 =20
  	if (!intel_cdclk_changed(&old_cdclk_state->actual,
- 				 &new_cdclk_state->actual))
+ 				 &new_cdclk_state->actual) &&
+ 	    dg2_power_well_count(display, old_cdclk_state) =3D=3D
+ 	    dg2_power_well_count(display, new_cdclk_state))
  		return;
 =20
- 	if (display->platform.dg2)
- 		intel_cdclk_pcode_pre_notify(state);
-=20
  	if (new_cdclk_state->disable_pipes) {
  		cdclk_config =3D new_cdclk_state->actual;
  		pipe =3D INVALID_PIPE;
@@@ -2866,6 -2883,9 +2883,9 @@@
 =20
  	drm_WARN_ON(display->drm, !new_cdclk_state->base.changed);
 =20
+ 	if (display->platform.dg2)
+ 		dg2_cdclk_pcode_pre_notify(state);
+=20
  	intel_set_cdclk(display, &cdclk_config, pipe,
  			"Pre changing CDCLK to");
  }
@@@ -2891,12 -2911,11 +2911,11 @@@ intel_set_cdclk_post_plane_update(struc
  		return;
 =20
  	if (!intel_cdclk_changed(&old_cdclk_state->actual,
- 				 &new_cdclk_state->actual))
+ 				 &new_cdclk_state->actual) &&
+ 	    dg2_power_well_count(display, old_cdclk_state) =3D=3D
+ 	    dg2_power_well_count(display, new_cdclk_state))
  		return;
 =20
- 	if (display->platform.dg2)
- 		intel_cdclk_pcode_post_notify(state);
-=20
  	if (!new_cdclk_state->disable_pipes &&
  	    new_cdclk_state->actual.cdclk < old_cdclk_state->actual.cdclk)
  		pipe =3D new_cdclk_state->pipe;
@@@ -2907,6 -2926,9 +2926,9 @@@
 =20
  	intel_set_cdclk(display, &new_cdclk_state->actual, pipe,
  			"Post changing CDCLK to");
+=20
+ 	if (display->platform.dg2)
+ 		dg2_cdclk_pcode_post_notify(state);
  }
 =20
  /* pixels per CDCLK */
@@@ -3942,9 -3964,25 +3964,25 @@@ static const struct intel_cdclk_funcs x
  	.calc_voltage_level =3D xe3lpd_calc_voltage_level,
  };
 =20
+ static const struct intel_cdclk_funcs mtl_cdclk_funcs =3D {
+ 	.get_cdclk =3D bxt_get_cdclk,
+ 	.set_cdclk =3D bxt_set_cdclk,
+ 	.modeset_calc_cdclk =3D bxt_modeset_calc_cdclk,
+ 	.calc_voltage_level =3D rplu_calc_voltage_level,
+ };
+=20
+ static const struct intel_cdclk_funcs dg2_cdclk_funcs =3D {
+ 	.get_cdclk =3D bxt_get_cdclk,
+ 	.set_cdclk =3D bxt_set_cdclk,
+ 	.modeset_calc_cdclk =3D bxt_modeset_calc_cdclk,
+ 	.calc_voltage_level =3D tgl_calc_voltage_level,
+ };
+=20
  static const struct intel_cdclk_funcs rplu_cdclk_funcs =3D {
  	.get_cdclk =3D bxt_get_cdclk,
  	.set_cdclk =3D bxt_set_cdclk,
+ 	.pre_notify =3D skl_cdclk_pcode_pre_notify,
+ 	.post_notify =3D skl_cdclk_pcode_post_notify,
  	.modeset_calc_cdclk =3D bxt_modeset_calc_cdclk,
  	.calc_voltage_level =3D rplu_calc_voltage_level,
  };
@@@ -3952,6 -3990,8 +3990,8 @@@
  static const struct intel_cdclk_funcs tgl_cdclk_funcs =3D {
  	.get_cdclk =3D bxt_get_cdclk,
  	.set_cdclk =3D bxt_set_cdclk,
+ 	.pre_notify =3D skl_cdclk_pcode_pre_notify,
+ 	.post_notify =3D skl_cdclk_pcode_post_notify,
  	.modeset_calc_cdclk =3D bxt_modeset_calc_cdclk,
  	.calc_voltage_level =3D tgl_calc_voltage_level,
  };
@@@ -3959,6 -3999,8 +3999,8 @@@
  static const struct intel_cdclk_funcs ehl_cdclk_funcs =3D {
  	.get_cdclk =3D bxt_get_cdclk,
  	.set_cdclk =3D bxt_set_cdclk,
+ 	.pre_notify =3D skl_cdclk_pcode_pre_notify,
+ 	.post_notify =3D skl_cdclk_pcode_post_notify,
  	.modeset_calc_cdclk =3D bxt_modeset_calc_cdclk,
  	.calc_voltage_level =3D ehl_calc_voltage_level,
  };
@@@ -3966,6 -4008,8 +4008,8 @@@
  static const struct intel_cdclk_funcs icl_cdclk_funcs =3D {
  	.get_cdclk =3D bxt_get_cdclk,
  	.set_cdclk =3D bxt_set_cdclk,
+ 	.pre_notify =3D skl_cdclk_pcode_pre_notify,
+ 	.post_notify =3D skl_cdclk_pcode_post_notify,
  	.modeset_calc_cdclk =3D bxt_modeset_calc_cdclk,
  	.calc_voltage_level =3D icl_calc_voltage_level,
  };
@@@ -3973,6 -4017,8 +4017,8 @@@
  static const struct intel_cdclk_funcs bxt_cdclk_funcs =3D {
  	.get_cdclk =3D bxt_get_cdclk,
  	.set_cdclk =3D bxt_set_cdclk,
+ 	.pre_notify =3D bxt_cdclk_pcode_pre_notify,
+ 	.post_notify =3D bxt_cdclk_pcode_post_notify,
  	.modeset_calc_cdclk =3D bxt_modeset_calc_cdclk,
  	.calc_voltage_level =3D bxt_calc_voltage_level,
  };
@@@ -3980,12 -4026,16 +4026,16 @@@
  static const struct intel_cdclk_funcs skl_cdclk_funcs =3D {
  	.get_cdclk =3D skl_get_cdclk,
  	.set_cdclk =3D skl_set_cdclk,
+ 	.pre_notify =3D skl_cdclk_pcode_pre_notify,
+ 	.post_notify =3D skl_cdclk_pcode_post_notify,
  	.modeset_calc_cdclk =3D skl_modeset_calc_cdclk,
  };
 =20
  static const struct intel_cdclk_funcs bdw_cdclk_funcs =3D {
  	.get_cdclk =3D bdw_get_cdclk,
  	.set_cdclk =3D bdw_set_cdclk,
+ 	.pre_notify =3D bdw_cdclk_pcode_pre_notify,
+ 	.post_notify =3D bdw_cdclk_pcode_post_notify,
  	.modeset_calc_cdclk =3D bdw_modeset_calc_cdclk,
  };
 =20
@@@ -4091,16 -4141,16 +4141,16 @@@ void intel_init_cdclk_hooks(struct inte
  		display->cdclk.funcs =3D &xe3lpd_cdclk_funcs;
  		display->cdclk.table =3D xe3lpd_cdclk_table;
  	} else if (DISPLAY_VER(display) >=3D 20) {
- 		display->cdclk.funcs =3D &rplu_cdclk_funcs;
+ 		display->cdclk.funcs =3D &mtl_cdclk_funcs;
  		display->cdclk.table =3D xe2lpd_cdclk_table;
  	} else if (DISPLAY_VERx100(display) >=3D 1401) {
- 		display->cdclk.funcs =3D &rplu_cdclk_funcs;
+ 		display->cdclk.funcs =3D &mtl_cdclk_funcs;
  		display->cdclk.table =3D xe2hpd_cdclk_table;
  	} else if (DISPLAY_VER(display) >=3D 14) {
- 		display->cdclk.funcs =3D &rplu_cdclk_funcs;
+ 		display->cdclk.funcs =3D &mtl_cdclk_funcs;
  		display->cdclk.table =3D mtl_cdclk_table;
  	} else if (display->platform.dg2) {
- 		display->cdclk.funcs =3D &tgl_cdclk_funcs;
+ 		display->cdclk.funcs =3D &dg2_cdclk_funcs;
  		display->cdclk.table =3D dg2_cdclk_table;
  	} else if (display->platform.alderlake_p) {
  		/* Wa_22011320316:adl-p[a0] */

--P8RMu5SLb3HNCuTg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqVhOcACgkQJNaLcl1U
h9BKZAf7BbCs+146vd6sLlVAS4+UK63GyiBbqM3Ujn8I4EBnWGna/7yJZtUN6o1K
+ApZytIzakezrdZhRT28tbexP7JzCRGNaib4vxUtyZr7o6GfvYS3P/3OUzLDVFpP
5r3UuTyCMIvS1nOamzbvWMH2PB/RiyXNUUDZvcXhc/bXTWJ0wuovlctLWVy+pFS1
ykVnrX7gSvH8cUzPS46ppqP6b1ofZ7DTSm8IkMEtKUuZWBIOUDLz9vjqDAz5tzme
IK/SaYjEGHW60pEcB3eubbjsLCMmnYcHSmBXv7LxcmXL9e0pLEx39ZngWHOKUYWQ
zmYFLAXlBWHDF9bRP8G2pUsf4f83ZQ==
=l9Ku
-----END PGP SIGNATURE-----

--P8RMu5SLb3HNCuTg--

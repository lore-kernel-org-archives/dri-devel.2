Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C837010F2865
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 20:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 347EB10EF44;
	Fri, 27 Mar 2026 20:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aiY/msJ6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B82E10E045
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 20:52:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 204E260054;
 Fri, 27 Mar 2026 20:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED16C19423;
 Fri, 27 Mar 2026 20:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774644755;
 bh=1xQGB852eys/a6yD+PGu559qV2EHPTDKqFngDM5tYtk=;
 h=Date:From:To:Cc:Subject:From;
 b=aiY/msJ6B2WhDQ3TGd6yYK12DD+hCsGtHKb5xVPENFORyO3TaYN2QL3xhGgNcO5mP
 YRUv44NNa+IQE11CQ7Y5R1zefx0+XCwI+I3tjcQ8/UffXZzhkYF3He6g9pOykUrlIo
 mcnVUB5//+O2Jc2A5VYIWh0TJxrx8ZyuGJuPQdyU05J8NEDJWUyEWZViP0l9bfBBlu
 ABOt+TzO9qlkrCLmYfcWQAXCXfNsEyc/QwWaK5IKpawFtYyWBP9geAemLikk3Vc81u
 l3klRorNWTya4JTS4LXmx6zvzRwqrnEOYYUuZvpGwgeeGx/Qgb/QR0flabVdStC6+O
 ExiyqP4ehrGdQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
 id 064AD1AC589B; Fri, 27 Mar 2026 20:52:32 +0000 (GMT)
Date: Fri, 27 Mar 2026 20:52:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Matt Roper <matthew.d.roper@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <acbuEBc-s2V_q2L-@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ya0Y3A2t3bEz6mzT"
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


--ya0Y3A2t3bEz6mzT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/xe/xe_wa.c

between commit:

  56781a4597706c ("drm/xe: Implement recent spec updates to Wa_16025250150")

=66rom the drm-fixes tree and commits:

  a31566762d4075 ("drm/xe: Implement recent spec updates to Wa_16025250150")
  9f49e185ee31d5 ("drm/xe/wa: Drop redundant entries for Wa_16021867713 & W=
a_14019449301")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/xe/xe_wa.c
index d7e309ad9abaf5,546296f0220b5f..00000000000000
--- a/drivers/gpu/drm/xe/xe_wa.c
+++ b/drivers/gpu/drm/xe/xe_wa.c
@@@ -111,6 -111,17 +111,17 @@@
   *    difference of how they are maintained in the code. In xe it uses the
   *    xe_rtp infrastructure so the workarounds can be kept in tables, fol=
lowing
   *    a more declarative approach rather than procedural.
+  *
+  * .. note::
+  *    When a workaround applies to every single known IP version in a ran=
ge,
+  *    the preferred handling is to use a single range-based RTP entry rat=
her
+  *    than individual entries for each version, even if some of the inter=
mediate
+  *    version numbers are currently unused.  If a new intermediate IP ver=
sion
+  *    appears in the future and is enabled in the driver, any existing
+  *    range-based entries that contain the new version number will need t=
o be
+  *    analyzed to determine whether their workarounds should apply to the=
 new
+  *    version, or whether any existing range based entries needs to be sp=
lit
+  *    into two entries that do not include the new intermediate version.
   */
 =20
  #undef XE_REG_MCR
@@@ -120,6 -131,8 +131,8 @@@ __diag_push()
  __diag_ignore_all("-Woverride-init", "Allow field overrides in table");
 =20
  static const struct xe_rtp_entry_sr gt_was[] =3D {
+ 	/* Workarounds applying over a range of IPs */
+=20
  	{ XE_RTP_NAME("14011060649"),
  	  XE_RTP_RULES(MEDIA_VERSION_RANGE(1200, 1255),
  		       ENGINE_CLASS(VIDEO_DECODE),
@@@ -135,6 -148,27 +148,27 @@@
  	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1200, 1260)),
  	  XE_RTP_ACTIONS(CLR(MISCCPCTL, DOP_CLOCK_GATE_RENDER_ENABLE))
  	},
+ 	{ XE_RTP_NAME("16021867713"),
+ 	  XE_RTP_RULES(MEDIA_VERSION_RANGE(1300, 3002),
+ 		       ENGINE_CLASS(VIDEO_DECODE)),
+ 	  XE_RTP_ACTIONS(SET(VDBOX_CGCTL3F1C(0), MFXPIPE_CLKGATE_DIS)),
+ 	  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE),
+ 	},
+ 	{ XE_RTP_NAME("14019449301"),
+ 	  XE_RTP_RULES(MEDIA_VERSION_RANGE(1301, 2000), ENGINE_CLASS(VIDEO_DECOD=
E)),
+ 	  XE_RTP_ACTIONS(SET(VDBOX_CGCTL3F08(0), CG3DDISHRS_CLKGATE_DIS)),
+ 	  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE),
+ 	},
+ 	{ XE_RTP_NAME("16028005424"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3000, 3005), OR,
+ 		       MEDIA_VERSION_RANGE(1301, 3500)),
+ 	  XE_RTP_ACTIONS(SET(GUC_INTR_CHICKEN, DISABLE_SIGNALING_ENGINES))
+ 	},
+ 	{ XE_RTP_NAME("14026578760"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3510, 3511), OR,
+ 		       MEDIA_VERSION(3503)),
+ 	  XE_RTP_ACTIONS(SET(GAMSTLB_CTRL, DIS_PEND_GPA_LINK))
+ 	},
 =20
  	/* DG1 */
 =20
@@@ -191,10 -225,6 +225,6 @@@
 =20
  	/* Xe_LPG */
 =20
- 	{ XE_RTP_NAME("14015795083"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1270, 1271), GRAPHICS_STEP(A0, B0)=
),
- 	  XE_RTP_ACTIONS(CLR(MISCCPCTL, DOP_CLOCK_GATE_RENDER_ENABLE))
- 	},
  	{ XE_RTP_NAME("14018575942"),
  	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1270, 1274)),
  	  XE_RTP_ACTIONS(SET(COMP_MOD_CTRL, FORCE_MISS_FTLB))
@@@ -206,12 -236,6 +236,6 @@@
 =20
  	/* Xe_LPM+ */
 =20
- 	{ XE_RTP_NAME("16021867713"),
- 	  XE_RTP_RULES(MEDIA_VERSION(1300),
- 		       ENGINE_CLASS(VIDEO_DECODE)),
- 	  XE_RTP_ACTIONS(SET(VDBOX_CGCTL3F1C(0), MFXPIPE_CLKGATE_DIS)),
- 	  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE),
- 	},
  	{ XE_RTP_NAME("22016670082"),
  	  XE_RTP_RULES(MEDIA_VERSION(1300)),
  	  XE_RTP_ACTIONS(SET(XELPMP_SQCNT1, ENFORCE_RAR))
@@@ -225,17 -249,6 +249,6 @@@
  	  XE_RTP_ACTIONS(SET(VDBOX_CGCTL3F10(0), IECPUNIT_CLKGATE_DIS)),
  	  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE),
  	},
- 	{ XE_RTP_NAME("16021867713"),
- 	  XE_RTP_RULES(MEDIA_VERSION(2000),
- 		       ENGINE_CLASS(VIDEO_DECODE)),
- 	  XE_RTP_ACTIONS(SET(VDBOX_CGCTL3F1C(0), MFXPIPE_CLKGATE_DIS)),
- 	  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE),
- 	},
- 	{ XE_RTP_NAME("14019449301"),
- 	  XE_RTP_RULES(MEDIA_VERSION(2000), ENGINE_CLASS(VIDEO_DECODE)),
- 	  XE_RTP_ACTIONS(SET(VDBOX_CGCTL3F08(0), CG3DDISHRS_CLKGATE_DIS)),
- 	  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE),
- 	},
 =20
  	/* Xe2_HPG */
 =20
@@@ -251,20 -264,6 +264,6 @@@
  			SET(LSC_CHICKEN_BIT_0_UDW, L3_128B_256B_WRT_DIS))
  	},
 =20
- 	/* Xe2_HPM */
-=20
- 	{ XE_RTP_NAME("16021867713"),
- 	  XE_RTP_RULES(MEDIA_VERSION(1301),
- 		       ENGINE_CLASS(VIDEO_DECODE)),
- 	  XE_RTP_ACTIONS(SET(VDBOX_CGCTL3F1C(0), MFXPIPE_CLKGATE_DIS)),
- 	  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE),
- 	},
- 	{ XE_RTP_NAME("14019449301"),
- 	  XE_RTP_RULES(MEDIA_VERSION(1301), ENGINE_CLASS(VIDEO_DECODE)),
- 	  XE_RTP_ACTIONS(SET(VDBOX_CGCTL3F08(0), CG3DDISHRS_CLKGATE_DIS)),
- 	  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE),
- 	},
-=20
  	/* Xe3_LPG */
 =20
  	{ XE_RTP_NAME("14021871409"),
@@@ -274,43 -273,44 +273,44 @@@
 =20
  	/* Xe3_LPM */
 =20
- 	{ XE_RTP_NAME("16021867713"),
- 	  XE_RTP_RULES(MEDIA_VERSION(3000),
- 		       ENGINE_CLASS(VIDEO_DECODE)),
- 	  XE_RTP_ACTIONS(SET(VDBOX_CGCTL3F1C(0), MFXPIPE_CLKGATE_DIS)),
- 	  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE),
- 	},
  	{ XE_RTP_NAME("16021865536"),
- 	  XE_RTP_RULES(MEDIA_VERSION(3000),
+ 	  XE_RTP_RULES(MEDIA_VERSION_RANGE(3000, 3002),
  		       ENGINE_CLASS(VIDEO_DECODE)),
  	  XE_RTP_ACTIONS(SET(VDBOX_CGCTL3F10(0), IECPUNIT_CLKGATE_DIS)),
  	  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE),
  	},
- 	{ XE_RTP_NAME("16021865536"),
- 	  XE_RTP_RULES(MEDIA_VERSION(3002),
- 		       ENGINE_CLASS(VIDEO_DECODE)),
- 	  XE_RTP_ACTIONS(SET(VDBOX_CGCTL3F10(0), IECPUNIT_CLKGATE_DIS)),
- 	  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE),
- 	},
- 	{ XE_RTP_NAME("16021867713"),
- 	  XE_RTP_RULES(MEDIA_VERSION(3002),
- 		       ENGINE_CLASS(VIDEO_DECODE)),
- 	  XE_RTP_ACTIONS(SET(VDBOX_CGCTL3F1C(0), MFXPIPE_CLKGATE_DIS)),
- 	  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE),
- 	},
  	{ XE_RTP_NAME("14021486841"),
  	  XE_RTP_RULES(MEDIA_VERSION(3000), MEDIA_STEP(A0, B0),
  		       ENGINE_CLASS(VIDEO_DECODE)),
  	  XE_RTP_ACTIONS(SET(VDBOX_CGCTL3F10(0), RAMDFTUNIT_CLKGATE_DIS)),
  	  XE_RTP_ENTRY_FLAG(FOREACH_ENGINE),
  	},
+=20
+ 	/* Xe3P_LPG */
+=20
+ 	{ XE_RTP_NAME("14025160223"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION(3510), GRAPHICS_STEP(A0, B0)),
+ 	  XE_RTP_ACTIONS(SET(MMIOATSREQLIMIT_GAM_WALK_3D,
+ 			     DIS_ATS_WRONLY_PG))
+ 	},
+ 	{ XE_RTP_NAME("14026144927, 16029437861"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION(3510), GRAPHICS_STEP(A0, B0)),
+ 	  XE_RTP_ACTIONS(SET(L3SQCREG2, L3_SQ_DISABLE_COAMA_2WAY_COH |
+ 			     L3_SQ_DISABLE_COAMA))
+ 	},
+ 	{ XE_RTP_NAME("14025635424"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION(3510), GRAPHICS_STEP(A0, B0)),
+ 	  XE_RTP_ACTIONS(SET(GAMSTLB_CTRL2, STLB_SINGLE_BANK_MODE))
+ 	},
  	{ XE_RTP_NAME("16028005424"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3000, 3005)),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION(3510), GRAPHICS_STEP(A0, B0)),
  	  XE_RTP_ACTIONS(SET(GUC_INTR_CHICKEN, DISABLE_SIGNALING_ENGINES))
  	},
  };
 =20
  static const struct xe_rtp_entry_sr engine_was[] =3D {
+ 	/* Workarounds applying over a range of IPs */
+=20
  	{ XE_RTP_NAME("22010931296, 18011464164, 14010919138"),
  	  XE_RTP_RULES(GRAPHICS_VERSION(1200), ENGINE_CLASS(RENDER)),
  	  XE_RTP_ACTIONS(SET(FF_THREAD_MODE(RENDER_RING_BASE),
@@@ -346,6 -346,54 +346,54 @@@
  	  XE_RTP_ACTIONS(SET(FF_SLICE_CS_CHICKEN1(RENDER_RING_BASE),
  			     FFSC_PERCTX_PREEMPT_CTRL))
  	},
+ 	{ XE_RTP_NAME("18032247524"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2004),
+ 		       FUNC(xe_rtp_match_first_render_or_compute)),
+ 	  XE_RTP_ACTIONS(SET(LSC_CHICKEN_BIT_0, SEQUENTIAL_ACCESS_UPGRADE_DISABL=
E))
+ 	},
+ 	{ XE_RTP_NAME("16018712365"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2004),
+ 		       FUNC(xe_rtp_match_first_render_or_compute)),
+ 	  XE_RTP_ACTIONS(SET(LSC_CHICKEN_BIT_0_UDW, XE2_ALLOC_DPA_STARVE_FIX_DIS=
))
+ 	},
+ 	{ XE_RTP_NAME("14020338487"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2004),
+ 		       FUNC(xe_rtp_match_first_render_or_compute)),
+ 	  XE_RTP_ACTIONS(SET(ROW_CHICKEN3, XE2_EUPEND_CHK_FLUSH_DIS))
+ 	},
+ 	{ XE_RTP_NAME("14018471104"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2004),
+ 		       FUNC(xe_rtp_match_first_render_or_compute)),
+ 	  XE_RTP_ACTIONS(SET(LSC_CHICKEN_BIT_0_UDW, ENABLE_SMP_LD_RENDER_SURFACE=
_CONTROL))
+ 	},
+ 	/*
+ 	 * Although this workaround isn't required for the RCS, disabling these
+ 	 * reports has no impact for our driver or the GuC, so we go ahead and
+ 	 * apply this to all engines for simplicity.
+ 	 */
+ 	{ XE_RTP_NAME("16021639441"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2004), OR,
+ 		       MEDIA_VERSION_RANGE(1301, 2000)),
+ 	  XE_RTP_ACTIONS(SET(CSFE_CHICKEN1(0),
+ 			     GHWSP_CSB_REPORT_DIS |
+ 			     PPHWSP_CSB_AND_TIMESTAMP_REPORT_DIS,
+ 			     XE_RTP_ACTION_FLAG(ENGINE_BASE)))
+ 	},
+ 	{ XE_RTP_NAME("14021402888"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 3005), ENGINE_CLASS(RENDER)),
+ 	  XE_RTP_ACTIONS(SET(HALF_SLICE_CHICKEN7, CLEAR_OPTIMIZATION_DISABLE))
+ 	},
+ 	{ XE_RTP_NAME("13012615864"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 3005),
+ 		       FUNC(xe_rtp_match_first_render_or_compute)),
+ 	  XE_RTP_ACTIONS(SET(TDL_TSL_CHICKEN, RES_CHK_SPR_DIS))
+ 	},
+ 	{ XE_RTP_NAME("18041344222"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 3000),
+ 		       FUNC(xe_rtp_match_first_render_or_compute),
+ 		       FUNC(xe_rtp_match_gt_has_discontiguous_dss_groups)),
+ 	  XE_RTP_ACTIONS(SET(TDL_CHICKEN, EUSTALL_PERF_SAMPLING_DISABLE))
+ 	},
 =20
  	/* TGL */
 =20
@@@ -461,11 -509,6 +509,6 @@@
  		       ENGINE_CLASS(COMPUTE)),
  	  XE_RTP_ACTIONS(SET(RING_HWSTAM(RENDER_RING_BASE), ~0))
  	},
- 	{ XE_RTP_NAME("14014999345"),
- 	  XE_RTP_RULES(PLATFORM(PVC), ENGINE_CLASS(COMPUTE),
- 		       GRAPHICS_STEP(B0, C0)),
- 	  XE_RTP_ACTIONS(SET(CACHE_MODE_SS, DISABLE_ECC))
- 	},
 =20
  	/* Xe_LPG */
 =20
@@@ -488,149 -531,36 +531,36 @@@
 =20
  	/* Xe2_LPG */
 =20
- 	{ XE_RTP_NAME("18032247524"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION(2004),
- 		       FUNC(xe_rtp_match_first_render_or_compute)),
- 	  XE_RTP_ACTIONS(SET(LSC_CHICKEN_BIT_0, SEQUENTIAL_ACCESS_UPGRADE_DISABL=
E))
- 	},
- 	{ XE_RTP_NAME("16018712365"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION(2004), FUNC(xe_rtp_match_first_render_or=
_compute)),
- 	  XE_RTP_ACTIONS(SET(LSC_CHICKEN_BIT_0_UDW, XE2_ALLOC_DPA_STARVE_FIX_DIS=
))
- 	},
- 	{ XE_RTP_NAME("14020338487"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION(2004), FUNC(xe_rtp_match_first_render_or=
_compute)),
- 	  XE_RTP_ACTIONS(SET(ROW_CHICKEN3, XE2_EUPEND_CHK_FLUSH_DIS))
- 	},
  	{ XE_RTP_NAME("18034896535, 16021540221"), /* 16021540221: GRAPHICS_STEP=
(A0, B0) */
  	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2004),
  		       FUNC(xe_rtp_match_first_render_or_compute)),
  	  XE_RTP_ACTIONS(SET(ROW_CHICKEN4, DISABLE_TDL_PUSH))
  	},
- 	{ XE_RTP_NAME("14018471104"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION(2004), FUNC(xe_rtp_match_first_render_or=
_compute)),
- 	  XE_RTP_ACTIONS(SET(LSC_CHICKEN_BIT_0_UDW, ENABLE_SMP_LD_RENDER_SURFACE=
_CONTROL))
- 	},
- 	/*
- 	 * These two workarounds are the same, just applying to different
- 	 * engines.  Although Wa_18032095049 (for the RCS) isn't required on
- 	 * all steppings, disabling these reports has no impact for our
- 	 * driver or the GuC, so we go ahead and treat it the same as
- 	 * Wa_16021639441 which does apply to all steppings.
- 	 */
- 	{ XE_RTP_NAME("18032095049, 16021639441"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION(2004)),
- 	  XE_RTP_ACTIONS(SET(CSFE_CHICKEN1(0),
- 			     GHWSP_CSB_REPORT_DIS |
- 			     PPHWSP_CSB_AND_TIMESTAMP_REPORT_DIS,
- 			     XE_RTP_ACTION_FLAG(ENGINE_BASE)))
- 	},
  	{ XE_RTP_NAME("16018610683"),
  	  XE_RTP_RULES(GRAPHICS_VERSION(2004), FUNC(xe_rtp_match_first_render_or=
_compute)),
  	  XE_RTP_ACTIONS(SET(TDL_TSL_CHICKEN, SLM_WMTP_RESTORE))
  	},
- 	{ XE_RTP_NAME("14021402888"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION(2004), ENGINE_CLASS(RENDER)),
- 	  XE_RTP_ACTIONS(SET(HALF_SLICE_CHICKEN7, CLEAR_OPTIMIZATION_DISABLE))
- 	},
- 	{ XE_RTP_NAME("13012615864"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION(2004),
- 		       FUNC(xe_rtp_match_first_render_or_compute)),
- 	  XE_RTP_ACTIONS(SET(TDL_TSL_CHICKEN, RES_CHK_SPR_DIS))
- 	},
 =20
  	/* Xe2_HPG */
 =20
- 	{ XE_RTP_NAME("16018712365"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2002),
- 		       FUNC(xe_rtp_match_first_render_or_compute)),
- 	  XE_RTP_ACTIONS(SET(LSC_CHICKEN_BIT_0_UDW, XE2_ALLOC_DPA_STARVE_FIX_DIS=
))
- 	},
  	{ XE_RTP_NAME("16018737384"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, XE_RTP_END_VERSION_UNDEFINED=
),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2999),
  		       FUNC(xe_rtp_match_first_render_or_compute)),
  	  XE_RTP_ACTIONS(SET(ROW_CHICKEN, EARLY_EOT_DIS))
  	},
- 	{ XE_RTP_NAME("14020338487"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2002),
- 		       FUNC(xe_rtp_match_first_render_or_compute)),
- 	  XE_RTP_ACTIONS(SET(ROW_CHICKEN3, XE2_EUPEND_CHK_FLUSH_DIS))
- 	},
- 	{ XE_RTP_NAME("18032247524"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2002),
- 		       FUNC(xe_rtp_match_first_render_or_compute)),
- 	  XE_RTP_ACTIONS(SET(LSC_CHICKEN_BIT_0, SEQUENTIAL_ACCESS_UPGRADE_DISABL=
E))
- 	},
- 	{ XE_RTP_NAME("14018471104"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2002),
- 		       FUNC(xe_rtp_match_first_render_or_compute)),
- 	  XE_RTP_ACTIONS(SET(LSC_CHICKEN_BIT_0_UDW, ENABLE_SMP_LD_RENDER_SURFACE=
_CONTROL))
- 	},
- 	/*
- 	 * Although this workaround isn't required for the RCS, disabling these
- 	 * reports has no impact for our driver or the GuC, so we go ahead and
- 	 * apply this to all engines for simplicity.
- 	 */
- 	{ XE_RTP_NAME("16021639441"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2002)),
- 	  XE_RTP_ACTIONS(SET(CSFE_CHICKEN1(0),
- 			     GHWSP_CSB_REPORT_DIS |
- 			     PPHWSP_CSB_AND_TIMESTAMP_REPORT_DIS,
- 			     XE_RTP_ACTION_FLAG(ENGINE_BASE)))
- 	},
  	{ XE_RTP_NAME("14019811474"),
  	  XE_RTP_RULES(GRAPHICS_VERSION(2001),
  		       FUNC(xe_rtp_match_first_render_or_compute)),
  	  XE_RTP_ACTIONS(SET(LSC_CHICKEN_BIT_0, WR_REQ_CHAINING_DIS))
  	},
- 	{ XE_RTP_NAME("14021402888"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2002), ENGINE_CLASS(RENDER)),
- 	  XE_RTP_ACTIONS(SET(HALF_SLICE_CHICKEN7, CLEAR_OPTIMIZATION_DISABLE))
- 	},
  	{ XE_RTP_NAME("14021821874, 14022954250"),
  	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2002),
  		       FUNC(xe_rtp_match_first_render_or_compute)),
  	  XE_RTP_ACTIONS(SET(TDL_TSL_CHICKEN, STK_ID_RESTRICT))
  	},
- 	{ XE_RTP_NAME("13012615864"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2002),
- 		       FUNC(xe_rtp_match_first_render_or_compute)),
- 	  XE_RTP_ACTIONS(SET(TDL_TSL_CHICKEN, RES_CHK_SPR_DIS))
- 	},
- 	{ XE_RTP_NAME("18041344222"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2002),
- 		       FUNC(xe_rtp_match_first_render_or_compute),
- 		       FUNC(xe_rtp_match_not_sriov_vf),
- 		       FUNC(xe_rtp_match_gt_has_discontiguous_dss_groups)),
- 	  XE_RTP_ACTIONS(SET(TDL_CHICKEN, EUSTALL_PERF_SAMPLING_DISABLE))
- 	},
-=20
- 	/* Xe2_LPM */
-=20
- 	{ XE_RTP_NAME("16021639441"),
- 	  XE_RTP_RULES(MEDIA_VERSION(2000)),
- 	  XE_RTP_ACTIONS(SET(CSFE_CHICKEN1(0),
- 			     GHWSP_CSB_REPORT_DIS |
- 			     PPHWSP_CSB_AND_TIMESTAMP_REPORT_DIS,
- 			     XE_RTP_ACTION_FLAG(ENGINE_BASE)))
- 	},
-=20
- 	/* Xe2_HPM */
-=20
- 	{ XE_RTP_NAME("16021639441"),
- 	  XE_RTP_RULES(MEDIA_VERSION(1301)),
- 	  XE_RTP_ACTIONS(SET(CSFE_CHICKEN1(0),
- 			     GHWSP_CSB_REPORT_DIS |
- 			     PPHWSP_CSB_AND_TIMESTAMP_REPORT_DIS,
- 			     XE_RTP_ACTION_FLAG(ENGINE_BASE)))
- 	},
 =20
  	/* Xe3_LPG */
 =20
- 	{ XE_RTP_NAME("14021402888"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3000, 3001),
- 		       FUNC(xe_rtp_match_first_render_or_compute)),
- 	  XE_RTP_ACTIONS(SET(HALF_SLICE_CHICKEN7, CLEAR_OPTIMIZATION_DISABLE))
- 	},
  	{ XE_RTP_NAME("18034896535"),
  	  XE_RTP_RULES(GRAPHICS_VERSION(3000), GRAPHICS_STEP(A0, B0),
  		       FUNC(xe_rtp_match_first_render_or_compute)),
@@@ -643,34 -573,33 +573,33 @@@
  				   SMP_FORCE_128B_OVERFETCH))
  	},
  	{ XE_RTP_NAME("14023061436"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3000, 3001),
- 		       FUNC(xe_rtp_match_first_render_or_compute), OR,
- 		       GRAPHICS_VERSION_RANGE(3003, 3005),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3000, 3005),
  		       FUNC(xe_rtp_match_first_render_or_compute)),
  	  XE_RTP_ACTIONS(SET(TDL_CHICKEN, QID_WAIT_FOR_THREAD_NOT_RUN_DISABLE))
  	},
- 	{ XE_RTP_NAME("13012615864"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3000, 3001), OR,
- 		       GRAPHICS_VERSION_RANGE(3003, 3005),
- 		       FUNC(xe_rtp_match_first_render_or_compute)),
- 	  XE_RTP_ACTIONS(SET(TDL_TSL_CHICKEN, RES_CHK_SPR_DIS))
- 	},
  	{ XE_RTP_NAME("16023105232"),
  	  XE_RTP_RULES(MEDIA_VERSION_RANGE(1301, 3000), OR,
  		       GRAPHICS_VERSION_RANGE(2001, 3001)),
  	  XE_RTP_ACTIONS(SET(RING_PSMI_CTL(0), RC_SEMA_IDLE_MSG_DISABLE,
  			     XE_RTP_ACTION_FLAG(ENGINE_BASE)))
  	},
- 	{ XE_RTP_NAME("14021402888"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3003, 3005), FUNC(xe_rtp_match_fir=
st_render_or_compute)),
- 	  XE_RTP_ACTIONS(SET(HALF_SLICE_CHICKEN7, CLEAR_OPTIMIZATION_DISABLE))
+=20
+ 	/* Xe3p_LPG*/
+=20
+ 	{ XE_RTP_NAME("22021149932"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION(3510), GRAPHICS_STEP(A0, B0),
+ 		       FUNC(xe_rtp_match_first_render_or_compute)),
+ 	  XE_RTP_ACTIONS(SET(LSC_CHICKEN_BIT_0_UDW, SAMPLER_LD_LSC_DISABLE))
  	},
- 	{ XE_RTP_NAME("18041344222"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION(3000),
- 		       FUNC(xe_rtp_match_first_render_or_compute),
- 		       FUNC(xe_rtp_match_not_sriov_vf),
- 		       FUNC(xe_rtp_match_gt_has_discontiguous_dss_groups)),
- 	  XE_RTP_ACTIONS(SET(TDL_CHICKEN, EUSTALL_PERF_SAMPLING_DISABLE))
+ 	{ XE_RTP_NAME("14025676848"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION(3510), GRAPHICS_STEP(A0, B0),
+ 		       FUNC(xe_rtp_match_first_render_or_compute)),
+ 	  XE_RTP_ACTIONS(SET(LSC_CHICKEN_BIT_0_UDW, LSCFE_SAME_ADDRESS_ATOMICS_C=
OALESCING_DISABLE))
+ 	},
+ 	{ XE_RTP_NAME("16028951944"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION(3510), GRAPHICS_STEP(A0, B0),
+ 		       FUNC(xe_rtp_match_first_render_or_compute)),
+ 	  XE_RTP_ACTIONS(SET(ROW_CHICKEN5, CPSS_AWARE_DIS))
  	},
  };
 =20
@@@ -708,6 -637,30 +637,30 @@@ static const struct xe_rtp_entry_sr lrc
  	  XE_RTP_RULES(GRAPHICS_VERSION(1200)),
  	  XE_RTP_ACTIONS(SET(COMMON_SLICE_CHICKEN4, DISABLE_TDC_LOAD_BALANCING_C=
ALC))
  	},
+ 	{ XE_RTP_NAME("14019877138"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1255, 2004), ENGINE_CLASS(RENDER)),
+ 	  XE_RTP_ACTIONS(SET(XEHP_PSS_CHICKEN, FD_END_COLLECT))
+ 	},
+ 	{ XE_RTP_NAME("14019386621"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2004), ENGINE_CLASS(RENDER)),
+ 	  XE_RTP_ACTIONS(SET(VF_SCRATCHPAD, XE2_VFG_TED_CREDIT_INTERFACE_DISABLE=
))
+ 	},
+ 	{ XE_RTP_NAME("14019988906"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2004), ENGINE_CLASS(RENDER)),
+ 	  XE_RTP_ACTIONS(SET(XEHP_PSS_CHICKEN, FLSH_IGNORES_PSD))
+ 	},
+ 	{ XE_RTP_NAME("18033852989"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2004), ENGINE_CLASS(RENDER)),
+ 	  XE_RTP_ACTIONS(SET(COMMON_SLICE_CHICKEN1, DISABLE_BOTTOM_CLIP_RECTANGL=
E_TEST))
+ 	},
+ 	{ XE_RTP_NAME("15016589081"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2004), ENGINE_CLASS(RENDER)),
+ 	  XE_RTP_ACTIONS(SET(CHICKEN_RASTER_1, DIS_CLIP_NEGATIVE_BOUNDING_BOX))
+ 	},
+ 	{ XE_RTP_NAME("14026781792"),
+ 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3000, 3510), ENGINE_CLASS(RENDER)),
+ 	  XE_RTP_ACTIONS(SET(FF_MODE, DIS_TE_PATCH_CTRL))
+ 	},
 =20
  	/* DG1 */
 =20
@@@ -744,10 -697,6 +697,6 @@@
  	  XE_RTP_RULES(PLATFORM(DG2)),
  	  XE_RTP_ACTIONS(SET(CACHE_MODE_1, MSAA_OPTIMIZATION_REDUC_DISABLE))
  	},
- 	{ XE_RTP_NAME("14019877138"),
- 	  XE_RTP_RULES(PLATFORM(DG2)),
- 	  XE_RTP_ACTIONS(SET(XEHP_PSS_CHICKEN, FD_END_COLLECT))
- 	},
 =20
  	/* PVC */
 =20
@@@ -765,29 -714,9 +714,9 @@@
  	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1270, 1274)),
  	  XE_RTP_ACTIONS(SET(CACHE_MODE_1, MSAA_OPTIMIZATION_REDUC_DISABLE))
  	},
- 	{ XE_RTP_NAME("14019877138"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(1270, 1274), ENGINE_CLASS(RENDER)),
- 	  XE_RTP_ACTIONS(SET(XEHP_PSS_CHICKEN, FD_END_COLLECT))
- 	},
 =20
  	/* Xe2_LPG */
 =20
- 	{ XE_RTP_NAME("14019386621"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION(2004), ENGINE_CLASS(RENDER)),
- 	  XE_RTP_ACTIONS(SET(VF_SCRATCHPAD, XE2_VFG_TED_CREDIT_INTERFACE_DISABLE=
))
- 	},
- 	{ XE_RTP_NAME("14019877138"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION(2004), ENGINE_CLASS(RENDER)),
- 	  XE_RTP_ACTIONS(SET(XEHP_PSS_CHICKEN, FD_END_COLLECT))
- 	},
- 	{ XE_RTP_NAME("14019988906"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION(2004), ENGINE_CLASS(RENDER)),
- 	  XE_RTP_ACTIONS(SET(XEHP_PSS_CHICKEN, FLSH_IGNORES_PSD))
- 	},
- 	{ XE_RTP_NAME("18033852989"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION(2004), ENGINE_CLASS(RENDER)),
- 	  XE_RTP_ACTIONS(SET(COMMON_SLICE_CHICKEN1, DISABLE_BOTTOM_CLIP_RECTANGL=
E_TEST))
- 	},
  	{ XE_RTP_NAME("14021567978"),
  	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, XE_RTP_END_VERSION_UNDEFINED=
),
  		       ENGINE_CLASS(RENDER)),
@@@ -807,20 -736,9 +736,9 @@@
  			     DIS_PARTIAL_AUTOSTRIP |
  			     DIS_AUTOSTRIP))
  	},
- 	{ XE_RTP_NAME("15016589081"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION(2004), ENGINE_CLASS(RENDER)),
- 	  XE_RTP_ACTIONS(SET(CHICKEN_RASTER_1, DIS_CLIP_NEGATIVE_BOUNDING_BOX))
- 	},
 =20
  	/* Xe2_HPG */
- 	{ XE_RTP_NAME("15010599737"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION(2001), ENGINE_CLASS(RENDER)),
- 	  XE_RTP_ACTIONS(SET(CHICKEN_RASTER_1, DIS_SF_ROUND_NEAREST_EVEN))
- 	},
- 	{ XE_RTP_NAME("14019386621"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2002), ENGINE_CLASS(RENDER)),
- 	  XE_RTP_ACTIONS(SET(VF_SCRATCHPAD, XE2_VFG_TED_CREDIT_INTERFACE_DISABLE=
))
- 	},
+=20
  	{ XE_RTP_NAME("14020756599"),
  	  XE_RTP_RULES(GRAPHICS_VERSION(2001), ENGINE_CLASS(RENDER)),
  	  XE_RTP_ACTIONS(SET(WM_CHICKEN3, HIZ_PLANE_COMPRESSION_DIS))
@@@ -842,18 -760,10 +760,10 @@@
  			     DIS_PARTIAL_AUTOSTRIP |
  			     DIS_AUTOSTRIP))
  	},
- 	{ XE_RTP_NAME("15016589081"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2002), ENGINE_CLASS(RENDER)),
- 	  XE_RTP_ACTIONS(SET(CHICKEN_RASTER_1, DIS_CLIP_NEGATIVE_BOUNDING_BOX))
- 	},
  	{ XE_RTP_NAME("22021007897"),
  	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(2001, 2002), ENGINE_CLASS(RENDER)),
  	  XE_RTP_ACTIONS(SET(COMMON_SLICE_CHICKEN4, SBE_PUSH_CONSTANT_BEHIND_FIX=
_ENABLE))
  	},
- 	{ XE_RTP_NAME("18033852989"),
- 	  XE_RTP_RULES(GRAPHICS_VERSION(2001), ENGINE_CLASS(RENDER)),
- 	  XE_RTP_ACTIONS(SET(COMMON_SLICE_CHICKEN1, DISABLE_BOTTOM_CLIP_RECTANGL=
E_TEST))
- 	},
 =20
  	/* Xe3_LPG */
  	{ XE_RTP_NAME("14021490052"),
@@@ -945,7 -855,8 +855,8 @@@ void xe_wa_process_gt(struct xe_gt *gt
 =20
  	xe_rtp_process_ctx_enable_active_tracking(&ctx, gt->wa_active.gt,
  						  ARRAY_SIZE(gt_was));
- 	xe_rtp_process_to_sr(&ctx, gt_was, ARRAY_SIZE(gt_was), &gt->reg_sr);
+ 	xe_rtp_process_to_sr(&ctx, gt_was, ARRAY_SIZE(gt_was),
+ 			     &gt->reg_sr, false);
  }
  EXPORT_SYMBOL_IF_KUNIT(xe_wa_process_gt);
 =20
@@@ -963,7 -874,8 +874,8 @@@ void xe_wa_process_engine(struct xe_hw_
 =20
  	xe_rtp_process_ctx_enable_active_tracking(&ctx, hwe->gt->wa_active.engin=
e,
  						  ARRAY_SIZE(engine_was));
- 	xe_rtp_process_to_sr(&ctx, engine_was, ARRAY_SIZE(engine_was), &hwe->reg=
_sr);
+ 	xe_rtp_process_to_sr(&ctx, engine_was, ARRAY_SIZE(engine_was),
+ 			     &hwe->reg_sr, false);
  }
 =20
  /**
@@@ -980,7 -892,8 +892,8 @@@ void xe_wa_process_lrc(struct xe_hw_eng
 =20
  	xe_rtp_process_ctx_enable_active_tracking(&ctx, hwe->gt->wa_active.lrc,
  						  ARRAY_SIZE(lrc_was));
- 	xe_rtp_process_to_sr(&ctx, lrc_was, ARRAY_SIZE(lrc_was), &hwe->reg_lrc);
+ 	xe_rtp_process_to_sr(&ctx, lrc_was, ARRAY_SIZE(lrc_was),
+ 			     &hwe->reg_lrc, true);
  }
 =20
  /**

--ya0Y3A2t3bEz6mzT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnG7hAACgkQJNaLcl1U
h9CaIQf9HKr4rLMFWTedBB/d1o4Z/vC901HUeAA3U5F9o3lrAlWiKs9fvv1HVOOK
QtwqZ2U1NoujpyqFmNOpJ9gUGSNMJ11bCyjmEyEGExHjn2WGxJWTjtw3IIAbUtBq
iaUotdZn8YDtvokQmqVq+b+bgOu5ozNY+372HSCYyb/4pQPPTS2JM0ZQko6MaeJf
0pHfONjyhrLvG9EZ0VaCNK2DfG3qntayHYv6DYH4cG7+sBFrVU4UmkEgf0+Zo+sI
Z+6JU2nm04Ouncjyom5PV8roYxBxuNvLsAn0/JshEUtSggK/R1WElfYDxC2uzWCC
BhF4aytEnwOfjR2V7/URDwiWSjnWcA==
=qLU+
-----END PGP SIGNATURE-----

--ya0Y3A2t3bEz6mzT--

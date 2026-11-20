Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820AC606A326
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nhbe8Bnu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE5F9112A6A;
	Fri, 20 Nov 2026 14:03:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 683BE10E1B8;
 Fri, 20 Nov 2026 14:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795183379; x=1826719379;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=N85vvc4fSF3Ek1vq4DxGrkXj0cA6AJnUYVmNJKAjgb0=;
 b=nhbe8BnueTTHKLzwLEk4mIWROOsMeDAw4s20t0LzK+idyOw7xiuUZrnV
 +QJ1Z1UYxDhccso8EiiBgdXcqG7GzlAqGU3fbIi1Ja0R6lNm36hsQtll2
 C5eG2VLO4SSqGceR0imYKLI+wZo3n0TKV1hDtVT3Zuqiq87aNBcZq5EwT
 FGQrXtkzT62K8fW2jxakjpbIlryiyPCGaq2SE1T4k0PH+P1IxQdT59SVO
 Sxj+FMtEgnW6oNmfA5AWxMcJ4OFmgDf+H5zSokSkJuLdMUvhyGhVMsURG
 3nVvA5jVuDgQ0DVyjTqOo6WG2jrq55PUXhA8QM/URNXCMivzT5fb4i5qt g==;
X-CSE-ConnectionGUID: DLC/RJtBR0eNc0l2Fo0PXg==
X-CSE-MsgGUID: fmf00GG/Si6UwfRED0QIsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4104833"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4104833"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 06:02:25 -0800
X-CSE-ConnectionGUID: gcgNO9U3Se22CSrxeF0SKg==
X-CSE-MsgGUID: WeYYhf7dRIyz1fSE8+Gkxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; d="scan'208";a="11041316"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.250])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 06:02:19 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Thomas =?utf-8?Q?Hellstr=C3=B6m?=
 <thomas.hellstrom@linux.intel.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dim-tools@lists.freedesktop.org
Subject: [PULL] drm-intel-next
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Date: Fri, 20 Nov 2026 16:02:17 +0200
Message-ID: <2062b87a51959e18017dcaa23aa5c8368baaf38e@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Hi Dave & Sima -

drm-intel-next-2026-11-20:
drm/i915 feature pull for v7.5:

Features and functionality:
- Add support for Panel Replay and PSR2 with joiner (Mika)
- Add debugfs to force GMBUS bit banging for testing (Naladala)
- Add tracepoints for DSB commit and flip queue (Ville)

Refactoring and cleanups:
- Major display register access refactoring (Ville)
- Optimize gen8/gen11 irq handlers (Ville)
- Panel fitter cleanups and improvements (Ville)
- Use drm_printer for debugfs printing (Jani)
- Scaler cleanups (Micha=C5=82)
- Convert PLL power save workaround to the workaround framework (Mika)
- Switch to __nonnull_args() macro (Dmitry Ilvokhin)
- Separate display and i915 core clock gating (Luca)
- DSB and flip queue fixes and cleanups (Ville)
- Display VT-d cleanups (Ville)
- Clean up GU MISC irq handling (Ville)

Fixes:
- Implement link M/N ratio limits (Suraj, Ankit)
- Selective fetch fixes (Jouni, Mika)
- FBC workarounds and fixes around FP16 formats (Vinod)
- Avoid blocking on delayed DMC wakelock release (Dibin)
- Avoid logging DC3CO transitions (Dibin)
- Fixes to AUX engine busy handling (Luca)
- Fix PTL+ I2C bit banging (Ville)
- Reject < 10 MHz dotclocks early (Ville)

DRM core:
- Some drm_printer conversions (Jani)

Merges:
- Backmerge drm/drm-next for v7.4-rc1 (Jani)

BR,
Jani.

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-next-20=
26-11-20

for you to fetch changes up to 1c9c76bbb563020c25e7c88dd6e50d4155df96eb:

  drm/i915/fb: move intel_dumb_fb_max_stride() to intel_fb.[ch] (2026-11-19=
 14:32:28 +0200)

----------------------------------------------------------------
drm/i915 feature pull for v7.5:

Features and functionality:
- Add support for Panel Replay and PSR2 with joiner (Mika)
- Add debugfs to force GMBUS bit banging for testing (Naladala)
- Add tracepoints for DSB commit and flip queue (Ville)

Refactoring and cleanups:
- Major display register access refactoring (Ville)
- Optimize gen8/gen11 irq handlers (Ville)
- Panel fitter cleanups and improvements (Ville)
- Use drm_printer for debugfs printing (Jani)
- Scaler cleanups (Micha=C5=82)
- Convert PLL power save workaround to the workaround framework (Mika)
- Switch to __nonnull_args() macro (Dmitry Ilvokhin)
- Separate display and i915 core clock gating (Luca)
- DSB and flip queue fixes and cleanups (Ville)
- Display VT-d cleanups (Ville)
- Clean up GU MISC irq handling (Ville)

Fixes:
- Implement link M/N ratio limits (Suraj, Ankit)
- Selective fetch fixes (Jouni, Mika)
- FBC workarounds and fixes around FP16 formats (Vinod)
- Avoid blocking on delayed DMC wakelock release (Dibin)
- Avoid logging DC3CO transitions (Dibin)
- Fixes to AUX engine busy handling (Luca)
- Fix PTL+ I2C bit banging (Ville)
- Reject < 10 MHz dotclocks early (Ville)

DRM core:
- Some drm_printer conversions (Jani)

Merges:
- Backmerge drm/drm-next for v7.4-rc1 (Jani)

----------------------------------------------------------------
Animesh Manna (1):
      drm/i915/cmtg: Disable CMTG after encoder disable in hsw_crtc_disable=
()

Ankit Nautiyal (7):
      drm/i915/display: Add helper to compute link M/N ratio for reuse
      drm/i915/dp_mst: Limit M/N ratio for MST
      drm/i915/dp: Add M/N ratio check for DP link config
      drm/i915/display: Add bits for link_n_extended for DISPLAY >=3D 14
      drm/i915/display_wa: Add support for Wa_14021768792
      drm/i915/display: Implement Wa_14021768792 for BMG DP for link_m/n ra=
tio > 10
      drm/i915/dp: Extend intel_dp_can_support_m_n() for BMG M/N bypass

Dibin Moolakadan Subrahmanian (4):
      drm/i915/dmc: Harden DMC firmware payload parsing
      drm/i915/dmc: Add sanity check for DMC load address
      drm/i915/display: avoid logging DC3CO transitions
      drm/i915/dmc_wl: Avoid blocking on delayed wakelock release

Dmitry Ilvokhin (1):
      drm/i915: switch to __nonnull_args() macro

Dnyaneshwar Bhadane (1):
      drm/i915/cx0_phy: Fix ARL-S host bridge detection

Hanson Wang (1):
      drm/i915/dsb: Realign GOSUB only for QW slots 6 and 7

Imre Deak (6):
      drm/i915/dp_aux: Take the TypeC port lock after the PPS lock
      drm/i915/pps: Hold a TypeC link reference for PPS VDD
      drm/i915/pps: Reset PPS state after TypeC port init on resume
      drm/i915/ptl+: Add TypeC HPD pin selection for port B
      drm/i915/mtl+: Use PHY type to identify TypeC ports in PLL ID lookup
      drm/i915/ptl+: Fix TypeC detection for eDP on port B

Jani Nikula (19):
      drm/{i915, xe}: make intel_dmc_suspend() part of display suspend/shut=
down calls
      drm/i915/display: fix a few i915_reg_t usages that have crept back
      drm/dp: pass struct drm_printer to drm_dp_downstream_debug()
      drm/dp: prefer drm_printf_indent() over inline \t
      drm/i915/debugfs: pass struct drm_printer to intel_plane_info()
      drm/i915/debugfs: pass struct drm_printer to crtc_updates_info()
      drm/i915/debugfs: convert crtc_updates_info() to use drm_printf_inden=
t()
      drm/i915/debugfs: pass struct drm_printer to intel_scaler_info()
      drm/i915/debugfs: pass struct drm_printer to intel_encoder_info()
      drm/i915/debugfs: pass struct drm_printer to intel_crtc_info()
      drm/i915/debugfs: pass struct drm_printer to intel_{dp, dp_mst, hdmi}=
_info()
      drm/i915/debugfs: pass struct drm_printer to intel_hdcp_info()
      drm/i915/debugfs: refactor intel_seq_print_mode() into intel_print_mo=
de()
      drm/i915/debugfs: pass struct drm_printer to intel_connector_info()
      drm/i915/debugfs: prefer drm_printf_indent() over inline \t
      Merge drm/drm-next into drm-intel-next
      drm/i915/display: add and use INTEL_REG_INVALID macro
      drm/i915/de: prefer intel_reg_offset() over i915_mmio_reg_offset()
      drm/i915/fb: move intel_dumb_fb_max_stride() to intel_fb.[ch]

Jouni H=C3=B6gander (12):
      drm/i915/psr: Clear selective fetch area when duplicating plane state
      drm/i915/display: Add enabled pipe planes into state for selective fe=
tch
      drm/i915/psr: Disable linked plane sel fetch as well
      drm/i915/psr: Fix SFF and CFF CTL register bit definitions
      drm/i915/psr: Skip sel fetch support check for invisible planes
      drm/i915/psr: Don't write 0 size area into plane sel fetch area regis=
ters
      drm/i915/psr: Remove drm_info_once on failed selective fetch area
      drm/i915/psr: Don't clip plane state destination rectangle
      drm/i915/psr: Flush on cursor update also when not using Selective Fe=
tch
      drm/i915/psr: Re-arm PSR after flush
      drm/i915/psr: Clear CFF state on flip flush
      drm/i915/display: Flush the fbdev frontbuffer

Luca Coelho (5):
      drm/i915/display: move the SNB FBC workaround comment
      drm/i915/display: separate display and core clock gating
      drm/i915/display: don't write Send Busy back when toggling AUX power
      drm/i915/dp: don't touch the AUX engine while it's still busy
      drm/i915/dp: only complain about a busy AUX engine when it's unexpect=
ed

Micha=C5=82 Grzelak (3):
      drm/i915/scaler: drop unused plane_state argument
      drm/i915/scaler: s/i/scaler_id/
      drm/i915/scaler: return -EINVAL instead of -1

Mika Kahola (11):
      drm/i915/cx0: convert the PLL power save W/A to the display W/A frame=
work
      drm/i915/psr: Track all joined pipes for frontbuffer tracking
      drm/i915/psr: Exclude the joiner secondary from active_non_psr_pipes
      drm/i915/psr: Take the selective fetch area from pipe_src
      drm/i915/psr: Split the selective fetch calculation into helpers
      drm/i915/psr: Derive the alignment loop condition from the SU area
      drm/i915/psr: Merge the selective fetch area across joined pipes
      drm/i915/psr: Resolve the PSR encoders through the joiner primary
      drm/i915/psr: Allow Panel Replay and PSR2 with joiner
      drm/i915/display: Allow forcing the joiner on eDP
      drm/i915/display: Run the selective fetch update after the crtc checks

Mitul Golani (1):
      drm/i915/display: Allow port sync on PTL

Naladala Ramanaidu (1):
      drm/i915/gmbus: Add bit-banging debugfs control

Suraj Kandpal (9):
      drm/i915/dp_mst: Drop dead ret check in mst_stream_compute_link_for_j=
oined_pipes()
      drm/i915/display: Limit NVL TRANS_VTOTAL.Vtotal skip to A-step
      drm/i915/dp: Limit M/N ratio for DP
      drm/i915/display_wa: Add support for Wa_14014191401
      drm/i915/display: Add bits for Wa_14021768792 for linkm/n ratio > 10
      drm/i915/display: Program Wa_14021768792 for linkm/n ratio > 10
      drm/i915/display: Read back and compare Wa_14021768792 state
      drm/i915/display: Dump bypass_m_n_ratio_limit in the crtc state dump
      drm/i915/dp: Bump the max Link M/N ratio to 22 for DISPLAY_VER >=3D 35

Vidya Srinivas (2):
      drm/i915/display: Single scaler per pipe on WCL
      drm/i915/display: Disable pipe joiner on WCL

Ville Syrj=C3=A4l=C3=A4 (75):
      drm/i915/gmbus: Switch GMBUS fully to _fw() register accesses
      drm/i915/dp: Drop using intel_de_read_notrace()
      drm/i915/de: Nuke intel_de_{read,write}_notrace()
      drm/i915/gmbus: Stop frobbing with pin direction in .getsda()/.getscl=
()
      drm/i915/gmbus: Handle the internal pullup disable bits more sensibly
      drm/i915/gmbus: Reorder the PNV clock gating GPIO w/a
      drm/i915/gmbus: Fix i2c bit banging for PTL+
      drm/i915/gmbus: Remove the INTEL_DISPLAY_WA_16025573575 leftovers
      drm/i915: s/PIPEFRAME/PIPEFRAMEHIGH/
      drm/i915: Modernize PIPEFRAMEHIGH/PIPEFRAMEPIXEL bits
      drm/i915/de: Convert intel_de_read64_2x32_volatile() to intel_de_read=
64_2x32_volatile_fw()
      drm/i915/de: Implement intel_de_rmw() by hand
      drm/i915/de: Implement intel_de_posting_read() via intel_de_read()
      drm/xe: Remove unused uncore wrappers
      drm/i915: Give up on DSB/flip queue if we fail to allocate the color =
DSB buffer
      drm/i915: Check use_flipq in intel_crtc_needs_vblank_work()
      drm/i915: Don't initialize flip queue on pre-LNL
      drm/i915: Warn about use_flipq=3D=3Dtrue in MMIO commit codepaths
      drm/i915: Refine vblank evasion DSB check
      drm/i915: Make intel_crtc_needs_vblank_work() easier on the eye
      drm/i915: Extract intel_dsb_supported()
      drm/i915: Use intel_dsb_supported() to determine 'use_dsb'
      drm/i915: Extract commit_dsb_max_cmds()
      drm/i915: Introduce enum intel_commit_type
      drm/i915: Carve intel_atomic_commit_type() up a bit
      drm/i915/dsb: Add tracepoints for DSB commit
      drm/i915/dsb: Add tracepoints for flip queue
      drm/i915: Drop bogus VLV/CHV VT-d stuff
      drm/i915: Optimize VT-d w/a handling a bit
      drm/i915: Document which platforms have VT-d
      drm/i915: Use intel_de_read64_2x32_volatile_fw() for IVB_TIMESTAMP_CT=
R+PIPE_FRMTMSTMP query
      drm/i915: Use intel_de_{read,write}_fw() in BDW+ irq handlers
      drm/i915: Use intel_de_{read,write}_fw() in VLV/CHV irq handlers
      drm/i915: Skip redundant frame/scanline/time reads for async flips
      drm/i915: Don't use intel_de_{read,write}_fw() in bdw_update_{pipe,po=
rt}_irq()
      drm/i915/pfit: s/pch_pfit/pfit/
      drm/i915/pfit: s/intel_pch_pfit/ilk_pfit/
      drm/i915/pfit: Stop using HAS_PCH_SPLIT() in confusing places
      drm/i915/pfit: Introduce intel_pfit_get_config()
      drm/i915/pfit: Rename some pfit functions
      drm/i915/vrr: Fix intel_vrr_dcb_vmin_vblank_start()
      drm/i915/irq: Relocate gen11_gu_misc_irq_ack()
      drm/i915/irq: s/gen11_gu_misc_irq_handler()/intel_display_gse_irq_han=
dler()/
      drm/i915/irq: Extract gen11_gu_misc_irq_postinstall()
      drm/i915/irq: Keep GSE interrupts masked if display is not present
      drm/i915/irq: Reorder GU_MISC vs. display in gen11_irq_postinstall()
      drm/xe: Use intel_display_gse_irq_handler()
      drm/i915/cdclk: Ignore SWF18 in SKL CDCLK sanitization
      drm/i915: Reject < 10 MHz dotclocks early
      drm/i915/de: Introduce dislay->mmio and intel_de_init()
      drm/i915/de: Convert intel_de_{read,write}() into vfuncs
      drm/i915/de: Introduce mmio read/write templates
      drm/i915/de: Eliminate runtime overhead from DMC wakelock on pre-LNL =
platforms
      drm/i915/de: Introduce display->mmio.lock
      drm/i915/uncore: Don't meddle with mmio debug upon user forcewake
      drm/i915/de: Move unclaimed mmio detection into display code
      drm/i915: Nuke HAS_FPGA_DBG_UNCLAIMED()/.has_fpga_dbg
      drm/i915/de: Stop using intel_uncore_{read,write}()
      drm/xe: Nuke the intel_uncore_{read,write}() wrappers
      drm/i915: Move GEN11 irq registers back into i915_reg.h
      drm/i915: Clean up GEN11 irq regs
      drm/i915: Unconfuse i915_get_vblank_counter() variables
      drm/i915/pfit: Extract i965_pfit_get_config()
      drm/i915/pfit: Drop platform check for gmch_pfit.pgm_ratios
      drm/i915/pfit: Unconfuse panel_fitter_scaling()
      drm/i915/pfit: Populate crtc_state->pfit.dst on GMCH platforms
      drm/i915/pfit: Check scaling factor on GMCH
      drm/i915/pfit: Check panel fitter source size on GMCH
      drm/i915/pfit: Extract i9xx_pfit_vscale_ratio() and i9xx_pfit_is_one_=
line_mode()
      drm/i915/pfit: No pfit one line mode on i965+
      drm/i915/pfit: Account for pfit downscaling in pixel rate on GMCH pla=
tforms
      drm/i915/pfit: Allow downscaling on i966+
      drm/i915/irq: Don't call gen8_gt_irq_handler() needlessly
      drm/i915/irq: Don't call gen11_gt_irq_handler() needlessly
      drm/i915/irq: Check the master bit outside gen11_gu_misc_irq_ack()

Vinod Govindapillai (2):
      drm/i915/fbc: update the supported FP16 formats
      drm/i915/fbc: Apply Wa_14028723391

Werner Sembach (1):
      drm/i915/display: Add quirk to force backlight type on some TUXEDO de=
vices

 drivers/gpu/drm/display/drm_dp_helper.c            |  39 +-
 drivers/gpu/drm/i915/display/i9xx_plane.c          |  23 +-
 drivers/gpu/drm/i915/display/i9xx_wm.c             |  11 +-
 drivers/gpu/drm/i915/display/intel_atomic.c        |   3 +-
 drivers/gpu/drm/i915/display/intel_casf.c          |  30 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c         |  13 +-
 drivers/gpu/drm/i915/display/intel_color.c         |   7 +-
 drivers/gpu/drm/i915/display/intel_crtc.c          |  22 +-
 .../gpu/drm/i915/display/intel_crtc_state_dump.c   |  22 +-
 drivers/gpu/drm/i915/display/intel_cursor.c        |  20 +-
 drivers/gpu/drm/i915/display/intel_cx0_phy.c       |   6 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |  16 +-
 drivers/gpu/drm/i915/display/intel_de.c            | 341 ++++++++++++++
 drivers/gpu/drm/i915/display/intel_de.h            |  86 ++--
 drivers/gpu/drm/i915/display/intel_display.c       | 419 ++++++++++-------
 drivers/gpu/drm/i915/display/intel_display.h       |   9 +-
 .../drm/i915/display/intel_display_clock_gating.c  |  24 +
 drivers/gpu/drm/i915/display/intel_display_core.h  |  22 +
 .../gpu/drm/i915/display/intel_display_debugfs.c   | 259 ++++++-----
 .../gpu/drm/i915/display/intel_display_device.c    |  23 +-
 .../gpu/drm/i915/display/intel_display_device.h    |   2 -
 .../gpu/drm/i915/display/intel_display_driver.c    |  35 ++
 .../gpu/drm/i915/display/intel_display_driver.h    |   3 +
 drivers/gpu/drm/i915/display/intel_display_irq.c   | 109 ++---
 drivers/gpu/drm/i915/display/intel_display_irq.h   |   3 +-
 .../gpu/drm/i915/display/intel_display_params.c    |   4 +
 .../gpu/drm/i915/display/intel_display_params.h    |   1 +
 drivers/gpu/drm/i915/display/intel_display_power.c |  10 +-
 .../drm/i915/display/intel_display_power_well.c    |  31 +-
 .../gpu/drm/i915/display/intel_display_reg_defs.h  |   4 +-
 drivers/gpu/drm/i915/display/intel_display_regs.h  |  34 +-
 drivers/gpu/drm/i915/display/intel_display_reset.c |   4 +-
 drivers/gpu/drm/i915/display/intel_display_trace.h | 111 +++++
 drivers/gpu/drm/i915/display/intel_display_types.h |  23 +-
 drivers/gpu/drm/i915/display/intel_display_utils.c |   6 +
 drivers/gpu/drm/i915/display/intel_display_wa.c    |  26 +-
 drivers/gpu/drm/i915/display/intel_display_wa.h    |   4 +-
 drivers/gpu/drm/i915/display/intel_dmc.c           |  11 +-
 drivers/gpu/drm/i915/display/intel_dmc_wl.c        |   6 +-
 drivers/gpu/drm/i915/display/intel_dp.c            | 189 +++++++-
 drivers/gpu/drm/i915/display/intel_dp.h            |   8 +
 drivers/gpu/drm/i915/display/intel_dp_aux.c        | 142 ++++--
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |  22 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |  10 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |   7 +-
 drivers/gpu/drm/i915/display/intel_dsb.c           |  34 +-
 drivers/gpu/drm/i915/display/intel_dsb.h           |   1 +
 drivers/gpu/drm/i915/display/intel_encoder.c       |   4 +-
 drivers/gpu/drm/i915/display/intel_fb.c            |  36 ++
 drivers/gpu/drm/i915/display/intel_fb.h            |   2 +
 drivers/gpu/drm/i915/display/intel_fbc.c           |  44 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c         |  13 +-
 drivers/gpu/drm/i915/display/intel_flipq.c         |  10 +-
 drivers/gpu/drm/i915/display/intel_gmbus.c         | 220 ++++++---
 drivers/gpu/drm/i915/display/intel_gmbus.h         |   2 +
 drivers/gpu/drm/i915/display/intel_hdcp.c          |  27 +-
 drivers/gpu/drm/i915/display/intel_hdcp.h          |   4 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |   2 +-
 drivers/gpu/drm/i915/display/intel_hotplug_irq.c   |  26 +-
 drivers/gpu/drm/i915/display/intel_overlay.c       |  31 +-
 drivers/gpu/drm/i915/display/intel_pfit.c          | 462 ++++++++++++++---=
--
 drivers/gpu/drm/i915/display/intel_pfit.h          |   8 +-
 drivers/gpu/drm/i915/display/intel_pfit_regs.h     |   4 +-
 drivers/gpu/drm/i915/display/intel_plane.c         |  11 +
 drivers/gpu/drm/i915/display/intel_pps.c           |  16 +-
 drivers/gpu/drm/i915/display/intel_psr.c           | 494 +++++++++++++----=
----
 drivers/gpu/drm/i915/display/intel_psr_regs.h      |   4 +-
 drivers/gpu/drm/i915/display/intel_quirks.c        |  24 +
 drivers/gpu/drm/i915/display/intel_quirks.h        |   1 +
 drivers/gpu/drm/i915/display/intel_sprite.c        |  27 +-
 drivers/gpu/drm/i915/display/intel_tc.c            |   9 +-
 drivers/gpu/drm/i915/display/intel_vblank.c        |  73 ++-
 drivers/gpu/drm/i915/display/intel_vrr.c           |  12 +-
 drivers/gpu/drm/i915/display/skl_scaler.c          |  59 ++-
 drivers/gpu/drm/i915/display/skl_universal_plane.c |   3 +-
 drivers/gpu/drm/i915/gem/i915_gem_create.c         |   2 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.h         |   4 +-
 drivers/gpu/drm/i915/gt/intel_gt_irq.h             |   3 +
 drivers/gpu/drm/i915/gt/intel_reset.c              |   4 +
 drivers/gpu/drm/i915/i915_driver.c                 |  22 +-
 drivers/gpu/drm/i915/i915_drv.h                    |   1 -
 drivers/gpu/drm/i915/i915_gem.c                    |   9 +-
 drivers/gpu/drm/i915/i915_irq.c                    |  58 ++-
 drivers/gpu/drm/i915/i915_params.c                 |   4 -
 drivers/gpu/drm/i915/i915_params.h                 |   1 -
 drivers/gpu/drm/i915/i915_reg.h                    |  27 +-
 drivers/gpu/drm/i915/i915_request.h                |   4 +-
 drivers/gpu/drm/i915/intel_clock_gating.c          |  81 ++--
 drivers/gpu/drm/i915/intel_clock_gating.h          |   1 +
 drivers/gpu/drm/i915/intel_uncore.c                | 239 +---------
 drivers/gpu/drm/i915/intel_uncore.h                |  26 --
 drivers/gpu/drm/xe/Makefile                        |   1 +
 .../xe/compat-i915-headers/intel_clock_gating.h    |  14 -
 .../gpu/drm/xe/compat-i915-headers/intel_uncore.h  |  67 ---
 drivers/gpu/drm/xe/display/xe_display.c            |   6 +-
 include/drm/display/drm_dp_helper.h                |   3 +-
 include/drm/intel/intel_gmd_interrupt_regs.h       |  19 -
 97 files changed, 2832 insertions(+), 1627 deletions(-)
 delete mode 100644 drivers/gpu/drm/xe/compat-i915-headers/intel_clock_gati=
ng.h

--=20
Jani Nikula, Intel

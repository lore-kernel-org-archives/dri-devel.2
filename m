Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3998FC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7170B10E55E;
	Tue, 28 Jul 2026 10:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="g3/eAVDJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB3F10E859;
 Tue, 28 Jul 2026 10:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785233233; x=1816769233;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JGaiF4bZcDJ2OYtmcrPSHqMEIHOX0Jb//tse+ADji3A=;
 b=g3/eAVDJXkrT4o/NnC8KlEFT2Vkr2hrgqO2wBkeQIpzcPTU1PKZ7wQx/
 9K09VJipY0R3x2bbRIiBIl9wl0+BFVteYAILXJx5Lko0ARkWpFIG19Z21
 J2tfDaCTM+au8Md50GR9gBdXu6boYamE17EC3LUcvJVzajQA/HFS/2hkz
 pTEJ6YaEOXIx0Gu1FKevjvDbCp4SWXtoVslczdv0BAuTLnpdd0SkDZxtG
 ++J+bf6FH4TawEHRHtFkGr3NDk9TfY/+3k5UnhoRvMaRd/w+Fok8AJAD2
 FS6vnwzhPQVW7nQLL2ZGZhixPZBsjIeCb9Mx59nKAWM70LFwLOcViNgI9 Q==;
X-CSE-ConnectionGUID: fS2nYclqRyyoaO+4uWITvw==
X-CSE-MsgGUID: 2djP7h6RSOSg38NK/DYiXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85852773"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="85852773"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 03:07:12 -0700
X-CSE-ConnectionGUID: PiwpZWrJSPq3Blrki/GnOQ==
X-CSE-MsgGUID: +rt0jrK+TlGQAqp+LK07RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="256997793"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.76])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 03:07:08 -0700
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
Date: Tue, 28 Jul 2026 13:07:05 +0300
Message-ID: <cb1b5a644d75589cbcdcc8ec8160968140426439@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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


Hi Dave & Sima -

Final i915 pull request for v7.3, mostly i915 and xe display.

BR,
Jani.

drm-intel-next-2026-07-28:
drm/i915 feature pull #2 for v7.3:

Features and functionality:
- Enable UHBR link rates on Thunderbolt tunneled links (Imre)
- Reduce Xe3+ PM demand peak bandwidth for power savings (Vinod)
- Add the blend mode property to all planes that support alpha blending (Ch=
aitanya)
- Enable pipe DMC error interrupts for display 30+ (Dibin)
- Add KUnit tests for DP link config selection and fallback (Imre)

Refactoring and cleanups:
- Refactor DP link config selection and unify across use cases (Imre)
- Unify i915 and xe display runtime PM calls (Jani)
- Refactor BIOS framebuffer takeover (Ville)

Fixes:
- Fix HD audio on DP UHBR SST (Kai Vehmanen)
- Fixes to xe driver BIOS framebuffer takeover (Ville)
- Fix 2 pixels-per-clock CDCLK calculation to avoid underruns (Ville)
- Fix incorrectly set VSC SDP Main Stream Attribute (Chaitanya)
- Fix BPC and DSC selection for HDMI sinks (Alexander Kaplan)
- Fix PCON max FRL rate selection (Alexander Kaplan)
- Workaround Xe3P PSR2 screen corruption (Dibin)
- Fix NVL A & B stepping vtotal setting (Suraj)
- Fix xe DPT allocation paths (Maarten)
- Prefer system memory instead of stolen for new framebuffers in xe (Maarte=
n)
- Fix transcoder mask sizes (John Harrison)
- Clear stale UV/Y plane DDB entries on plane disable (Vinod)
- Fix some DP AUX backlight control issues, again (Suraj)
- Fix switching between HDCP 1.4 and 2.2 authentication (Suraj)
- Remove unnecessary Xe2_LPD+ FBC plane width and surface size limits (Vino=
d)
- Ensure non-zero DSB safe window for PTL+ (Ankit)
- Fix bandwidth calculation to account for 16 DRAM channels (Uma)
- Fix NV12 ceiling division for bigjoiner case (Vidya)

DRM core changes:
- Add Thunderbolt UHBR tunneling support (Imre)


The following changes since commit 8e27f752037e72ccee9c4a7c4a6202ecf3daf603:

  drm/i915/ltphy: Fix SSC Enablement bit in PORT_CLOCK_CTL (2026-07-02 09:1=
9:23 +0530)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-next-20=
26-07-28

for you to fetch changes up to f0cabcc880aba3f05ca59d735f6d166b7fceca80:

  drm/i915/fbc: No surface size restrictions from LNL onwards (2026-07-24 1=
1:48:36 +0300)

----------------------------------------------------------------
drm/i915 feature pull #2 for v7.3:

Features and functionality:
- Enable UHBR link rates on Thunderbolt tunneled links (Imre)
- Reduce Xe3+ PM demand peak bandwidth for power savings (Vinod)
- Add the blend mode property to all planes that support alpha blending (Ch=
aitanya)
- Enable pipe DMC error interrupts for display 30+ (Dibin)
- Add KUnit tests for DP link config selection and fallback (Imre)

Refactoring and cleanups:
- Refactor DP link config selection and unify across use cases (Imre)
- Unify i915 and xe display runtime PM calls (Jani)
- Refactor BIOS framebuffer takeover (Ville)

Fixes:
- Fix HD audio on DP UHBR SST (Kai Vehmanen)
- Fixes to xe driver BIOS framebuffer takeover (Ville)
- Fix 2 pixels-per-clock CDCLK calculation to avoid underruns (Ville)
- Fix incorrectly set VSC SDP Main Stream Attribute (Chaitanya)
- Fix BPC and DSC selection for HDMI sinks (Alexander Kaplan)
- Fix PCON max FRL rate selection (Alexander Kaplan)
- Workaround Xe3P PSR2 screen corruption (Dibin)
- Fix NVL A & B stepping vtotal setting (Suraj)
- Fix xe DPT allocation paths (Maarten)
- Prefer system memory instead of stolen for new framebuffers in xe (Maarte=
n)
- Fix transcoder mask sizes (John Harrison)
- Clear stale UV/Y plane DDB entries on plane disable (Vinod)
- Fix some DP AUX backlight control issues, again (Suraj)
- Fix switching between HDCP 1.4 and 2.2 authentication (Suraj)
- Remove unnecessary Xe2_LPD+ FBC plane width and surface size limits (Vino=
d)
- Ensure non-zero DSB safe window for PTL+ (Ankit)
- Fix bandwidth calculation to account for 16 DRAM channels (Uma)
- Fix NV12 ceiling division for bigjoiner case (Vidya)

DRM core changes:
- Add Thunderbolt UHBR tunneling support (Imre)

----------------------------------------------------------------
Alexander Kaplan (2):
      drm/i915/dp: Prefer DSC over 6 bpc uncompressed output for HDMI sinks
      drm/i915/dp: Ignore the sink's DSC max FRL rate without a PCON DSC en=
coder

Ankit Nautiyal (1):
      drm/i915/display: Ensure a non-zero safe window from PTL onwards

Chaitanya Kumar Borah (3):
      drm/i915/display: expose blend mode on alpha-capable planes
      drm/i915/dp: s/intel_dp_needs_vsc_sdp/intel_dp_needs_vsc_colorimetry
      drm/i915/dp: set VSC_SDP MSA delegation only for capable sinks

Colin Ian King (1):
      drm/i915/bw: Fix spelling mistake "threshod" -> "threshold"

Dibin Moolakadan Subrahmanian (2):
      drm/i915/psr: Block DC3CO entry during active frame
      drm/i915/dmc: Enable PIPEDMC_ERROR interrupt on display version 30+

Imre Deak (40):
      drm/i915/doc: Document DP link capabilities
      drm/i915/dp_link_caps: Factor out helper to get link config by index
      drm/i915/dp_link_caps: Add support for link rate, lane count iteratio=
n orders
      drm/i915/dp_link_caps: Add link configuration iterator
      drm/i915/dp_link_caps: Add helper to get iteration order for a connec=
tor
      drm/i915/dp_link_caps: Validate max link limits
      drm/i915/dp_link_caps: Add filter for enabled link configurations
      drm/i915/dp_link_caps: Re-enable link configurations after a link res=
et
      drm/i915/dp_link_caps: Re-enable link configurations after sink caps =
change
      drm/i915/dp_link_caps: Drop noupdate postfix from max link limit set =
helpers
      drm/i915/dp_link_caps: Add debugfs entry showing allowed configuratio=
ns
      drm/i915/dp: Add link configuration filter for modeset computation
      drm/i915/dp_link_caps: Add helper to query max BW link configuration
      drm/i915/dp: Query max BW config via link_caps during mode validation
      drm/i915/dp_tunnel: Query max BW config via link_caps for BW computat=
ion
      drm/i915/dp_test: Use link caps for compliance link configs
      drm/i915/dp: Iterate configurations via link_caps for SST non-DSC
      drm/i915/dp: Iterate configurations via link_caps for SST DSC
      drm/i915/dp: Use link caps for eDP DSC config selection
      drm/i915/dp_mst: Use link caps for non-DSC config selection
      drm/i915/dp_mst: Use link caps for MST DSC config selection
      drm/i915/dp: Remove min/max link config limits
      drm/i915/dp_link_training: Reset the max link limits in the fallback =
code
      drm/i915/dp_link_training: Use config iterator for fallback
      drm/i915/dp_link_training: Disable failed config during fallback
      drm/i915/kunit: Enable KUnit tests
      drm/i915/kunit: Add DP link test stub
      drm/xe/kunit: Add display test config
      drm/xe/kunit: Build DP link display tests
      drm/i915/kunit: Setup DP link test context
      drm/i915/kunit: Export link training and caps funcs for testing
      drm/i915/kunit: DP link: add baseline fixed table reference test
      drm/i915/kunit: DP link: add update config tests
      drm/i915/kunit: DP link: add fallback tests
      drm/dp_tunnel: Add UHBR tunneling support
      drm/i915/dp: End link configuration loops properly
      drm/i915/dp: Enable SST fallback between UHBR and non-UHBR rates
      drm/i915/dp: Remove UHBR dependency from SST fallback kunit test
      drm/i915/dp: Disable UHBR link configs with 1/2 lanes
      drm/i915/dp_tunnel: Add UHBR tunneling support

Jani Nikula (9):
      drm/i915: call intel_uncore_runtime_resume() for each gt
      drm/i915: call intel_display_power_runtime_resume() on suspend error =
path
      drm/i915: move some display runtime suspend operations earlier
      drm/i915: add intel_display_driver_pm_runtime*() functions
      drm/{i915, xe}: add new intel_display_driver_runtime_pm_{enable, disa=
ble}()
      drm/xe/display: separate d3cold handling from xe_display_pm_runtime_s=
uspend_late()
      drm/xe/display: add xe_display_pm_runtime_resume_early()
      drm/xe/display: unify runtime suspend/resume with i915 for non-d3cold
      drm/i915/mst: limit DP MST ESI service loop

John Harrison (1):
      drm/i915/display: Fix too few bits in transcoder mask variables

Kai Vehmanen (1):
      drm/i915/audio: treat UHBR SST like MST for cpu_transcoder signalling

Maarten Lankhorst (2):
      drm/xe: Fix DPT allocation paths.
      drm/xe/display: Do not allocate into stolen for new framebuffers.

Suraj Kandpal (3):
      drm/i915/display: Skip TRANS_VTOTAL.Vtotal write on NVL pre-C0
      drm/i915/backlight: Remove DP_EDP_BACKLIGHT_AUX_ENABLE_CAP check for =
DPCD backlight
      drm/i915/hdcp: Make hdcp2_encrypted and hdcp_encrypted mutually exclu=
sive

Uma Shankar (2):
      drm/i915/dram: Interpret 0xF populated-channel count as 16
      drm/i915/bw: Update bw calculation to account for 16 channels

Vidya Srinivas (1):
      drm/i915/display: Fix NV12 ceiling division for bigjoiner case

Ville Syrj=C3=A4l=C3=A4 (15):
      drm/i915: Disable the plane if initial plane config readout failed
      drm/i915/fbdev: Extract bios_fb_ok()
      drm/i915: Throw away the BIOS fb if has the wrong depth/bpp
      drm/i915: Use drm_dbg_kms() for initial FB debugs
      drm/xe: Do the initial FB size alignment earlier
      drm/xe: Print a debug message if we have no stolen for the initial FB
      drm/xe: Abstract the initial FB PTE checks a bit
      drm/xe: Check the PTE local memory bit for initial FB in stolen
      drm/xe: s/bar2/lmembar/
      drm/i915: Fix BIOS FB memory region name debug prints
      drm/i915: Print the phys_base in addition to the dma_addr for the BIO=
S FB
      drm/i915/cdclk: Use intel_cdclk_ppc() in intel_modeset_readout_hw_sta=
te()
      drm/i915/cdclk: Introduce HAS_2PPC()
      drm/i915/cdclk: Introduce crtc_state->pixel_rate_cdclk
      drm/i915/cdclk: Deal with 2 PPC hscale issues when calculating min CD=
CLK

Vinod Govindapillai (10):
      drm/i915/wm: clear the plane ddb_y entries on plane disable
      drm/i915/pm_demand: introduce HAS_PMDEMAND macro
      drm/i915/display: sagv pre/post plane calls to check pmdemand support
      drm/i915/bw: Extract icl_init_qgv_info()
      drm/i915/bw: extract update_sagv_status()
      drm/i915/bw: avoid replicating the update_sagv_status() calls
      drm/i915/bw: introduce the peak bandwidth threshold
      drm/xe/display: Expose plane max width/height helpers to global scope
      drm/i915/fbc: No need of any hardcoded plane width limit from LNL+
      drm/i915/fbc: No surface size restrictions from LNL onwards

 .../gpu/intel-display/dp-link-capabilities.rst     |   11 +
 Documentation/gpu/intel-display/index.rst          |    1 +
 drivers/gpu/drm/display/drm_dp_tunnel.c            |  116 +-
 drivers/gpu/drm/i915/.kunitconfig                  |    9 +
 drivers/gpu/drm/i915/Kconfig.debug                 |   12 +
 drivers/gpu/drm/i915/Makefile                      |    2 +
 drivers/gpu/drm/i915/display/hsw_ips.c             |    2 +-
 drivers/gpu/drm/i915/display/i9xx_plane.c          |    8 +-
 drivers/gpu/drm/i915/display/intel_audio.c         |   55 +-
 drivers/gpu/drm/i915/display/intel_bw.c            |  112 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c         |    6 +-
 drivers/gpu/drm/i915/display/intel_cdclk.h         |    1 +
 drivers/gpu/drm/i915/display/intel_cursor.c        |    3 +
 drivers/gpu/drm/i915/display/intel_ddi.c           |   10 +-
 drivers/gpu/drm/i915/display/intel_display.c       |   76 +-
 drivers/gpu/drm/i915/display/intel_display_core.h  |    2 +
 .../gpu/drm/i915/display/intel_display_device.h    |    3 +
 .../gpu/drm/i915/display/intel_display_driver.c    |   71 +
 .../gpu/drm/i915/display/intel_display_driver.h    |    8 +
 drivers/gpu/drm/i915/display/intel_display_irq.c   |    2 +-
 drivers/gpu/drm/i915/display/intel_display_power.c |    4 +-
 drivers/gpu/drm/i915/display/intel_display_regs.h  |    3 +
 drivers/gpu/drm/i915/display/intel_display_types.h |   10 +-
 drivers/gpu/drm/i915/display/intel_display_wa.c    |    4 +
 drivers/gpu/drm/i915/display/intel_display_wa.h    |    2 +
 drivers/gpu/drm/i915/display/intel_dmc.c           |   10 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |  407 +++---
 drivers/gpu/drm/i915/display/intel_dp.h            |   15 +-
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |    7 +-
 drivers/gpu/drm/i915/display/intel_dp_link_caps.c  |  759 ++++++++++-
 drivers/gpu/drm/i915/display/intel_dp_link_caps.h  |  172 ++-
 .../gpu/drm/i915/display/intel_dp_link_training.c  |  232 ++--
 .../gpu/drm/i915/display/intel_dp_link_training.h  |   31 +
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |   79 +-
 drivers/gpu/drm/i915/display/intel_dp_test.c       |  107 +-
 drivers/gpu/drm/i915/display/intel_dp_test.h       |    3 +-
 drivers/gpu/drm/i915/display/intel_dp_tunnel.c     |   53 +-
 drivers/gpu/drm/i915/display/intel_dp_tunnel.h     |   17 +
 drivers/gpu/drm/i915/display/intel_dram.c          |   14 +-
 drivers/gpu/drm/i915/display/intel_fbc.c           |   21 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c         |   35 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c          |    2 +
 drivers/gpu/drm/i915/display/intel_initial_plane.c |    6 +-
 drivers/gpu/drm/i915/display/intel_modeset_setup.c |   30 +-
 drivers/gpu/drm/i915/display/intel_plane.c         |   55 +
 drivers/gpu/drm/i915/display/intel_plane.h         |    5 +
 drivers/gpu/drm/i915/display/intel_pmdemand.c      |   12 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |   16 +
 drivers/gpu/drm/i915/display/intel_sprite.c        |   22 +-
 drivers/gpu/drm/i915/display/intel_vrr.c           |    6 +
 drivers/gpu/drm/i915/display/skl_universal_plane.c |   55 +-
 drivers/gpu/drm/i915/display/skl_universal_plane.h |    9 +
 drivers/gpu/drm/i915/display/skl_watermark.c       |    8 +-
 drivers/gpu/drm/i915/display/tests/Makefile        |    7 +
 .../drm/i915/display/tests/intel_dp_link_test.c    | 1408 ++++++++++++++++=
++++
 drivers/gpu/drm/i915/i915_driver.c                 |   58 +-
 drivers/gpu/drm/i915/i915_initial_plane.c          |   12 +-
 drivers/gpu/drm/xe/.gitignore                      |    1 +
 drivers/gpu/drm/xe/.kunitconfig-display            |   11 +
 drivers/gpu/drm/xe/Makefile                        |    3 +
 drivers/gpu/drm/xe/display/tests/Makefile          |   13 +
 drivers/gpu/drm/xe/display/xe_display.c            |   44 +-
 drivers/gpu/drm/xe/display/xe_display.h            |    2 +
 drivers/gpu/drm/xe/display/xe_display_bo.c         |   33 +-
 drivers/gpu/drm/xe/display/xe_fb_pin.c             |   33 +-
 drivers/gpu/drm/xe/display/xe_initial_plane.c      |   58 +-
 drivers/gpu/drm/xe/xe_pm.c                         |    2 +
 drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c             |   16 +-
 include/drm/display/drm_dp.h                       |   12 +
 include/drm/display/drm_dp_tunnel.h                |   21 +
 70 files changed, 3739 insertions(+), 716 deletions(-)
 create mode 100644 Documentation/gpu/intel-display/dp-link-capabilities.rst
 create mode 100644 drivers/gpu/drm/i915/.kunitconfig
 create mode 100644 drivers/gpu/drm/i915/display/tests/Makefile
 create mode 100644 drivers/gpu/drm/i915/display/tests/intel_dp_link_test.c
 create mode 100644 drivers/gpu/drm/xe/.kunitconfig-display
 create mode 100644 drivers/gpu/drm/xe/display/tests/Makefile

--=20
Jani Nikula, Intel

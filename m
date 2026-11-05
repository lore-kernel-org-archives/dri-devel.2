Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3297606EE9A
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ix7z9f4i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F2FB112482;
	Thu,  5 Nov 2026 13:57:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEE7C11247C;
 Thu,  5 Nov 2026 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793887030; x=1825423030;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=Od4jEaEJe3RbVAekVt5Hue7vzh9m42lzO4/ChOWUR6k=;
 b=Ix7z9f4iwNEGvSFg/CFw8+08pO+Mk8nHENbVzwjjP9VOHWeU6/n4sMMH
 6jubORJtstc34GwHmAdBVhdksvTL4HB+gp9w9Q2wq4v2WGaFyTSg9VOI+
 s96Ut9R3xHTx0zAObnckbH700T6I5vwfAy2gTPBsqWkibrfG1CIgz2Akx
 MgrrtX4x3L+q3IU/MWR3Ell6CLCUls+tVgGQnq/o2ElH6Zs4aQnaKRjp5
 rqTQ83tqU9i7tYiGZAn6q4D6AhiSI+wJ6hfwCkl/kLixTt3MATDwuW9Cn
 UVLXqO6lNRWg749+v4+PS/vsdVU/Feh1WA6OG5JmE0T1iQ/cbw5jmMfUr w==;
X-CSE-ConnectionGUID: 7ckZzfQYRqa32gjpMyVH2w==
X-CSE-MsgGUID: Nx6WlVDhTmeb0N67gQUVlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2668453"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2668453"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 05:57:09 -0800
X-CSE-ConnectionGUID: 7GgftNeJRGOPz1GaIFwgjg==
X-CSE-MsgGUID: 3iXBjFepTPO+th+xLTxqFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7180192"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.157])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 05:57:05 -0800
Date: Thu, 5 Nov 2026 15:57:03 +0200
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dim-tools@lists.freedesktop.org
Subject: [PULL] drm-intel-fixes
Message-ID: <auyLLyt1cpOQYL4n@jlahtine-mobl>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave & Sima,

Here goes drm-intel-fixes towards v7.4-rc2.

Fix for GitLab #8991 regression, backlight fixes for TUXEDO devices,
display pipe scaler/joiner fixes for WCL, PSR fixes and assorted
smaller fixes.

Regards, Joonas

***

drm-intel-fixes-2026-11-05:

- Fix GitLab #8991 where tiled displays (LG UltraFine 5K) broken on PTL
- Limit NVL TRANS_VTOTAL.Vtotal skip display workaround to A-step
- Single scaler per pipe number to 1 and disable pipe joiner on WCL
- Add quirk to force backlight type on some TUXEDO devices

- Fix "CMTG: A disable timeout" splat
- Fix intel_vrr_dcb_vmin_vblank_start
- Bunch of PSR fixes
- Static checker fixes

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-11-05

for you to fetch changes up to 01aa63eade529680cb28fce40f2357bf392a249f:

  drm/i915/vrr: Fix intel_vrr_dcb_vmin_vblank_start() (2026-11-03 09:13:41 +0200)

----------------------------------------------------------------
- Fix GitLab #8991 where tiled displays (LG UltraFine 5K) broken on PTL
- Limit NVL TRANS_VTOTAL.Vtotal skip display workaround to A-step
- Single scaler per pipe number to 1 and disable pipe joiner on WCL
- Add quirk to force backlight type on some TUXEDO devices

- Fix "CMTG: A disable timeout" splat
- Fix intel_vrr_dcb_vmin_vblank_start
- Bunch of PSR fixes
- Static checker fixes

----------------------------------------------------------------
Animesh Manna (1):
      drm/i915/cmtg: Disable CMTG after encoder disable in hsw_crtc_disable()

Jouni Högander (5):
      drm/i915/psr: Clear selective fetch area when duplicating plane state
      drm/i915/display: Add enabled pipe planes into state for selective fetch
      drm/i915/psr: Disable linked plane sel fetch as well
      drm/i915/psr: Fix SFF and CFF CTL register bit definitions
      drm/i915/psr: Don't clip plane state destination rectangle

Lu Yao (1):
      drm/i915/gem: Reset err for each fence entry

Mitul Golani (1):
      drm/i915/display: Allow port sync on PTL

Suraj Kandpal (1):
      drm/i915/display: Limit NVL TRANS_VTOTAL.Vtotal skip to A-step

Vidya Srinivas (2):
      drm/i915/display: Single scaler per pipe on WCL
      drm/i915/display: Disable pipe joiner on WCL

Ville Syrjälä (1):
      drm/i915/vrr: Fix intel_vrr_dcb_vmin_vblank_start()

Werner Sembach (1):
      drm/i915/display: Add quirk to force backlight type on some TUXEDO devices

 drivers/gpu/drm/i915/display/intel_ddi.c           |  2 +-
 drivers/gpu/drm/i915/display/intel_display.c       | 19 +++--
 .../gpu/drm/i915/display/intel_display_device.c    |  5 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |  4 +-
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  | 22 ++++-
 drivers/gpu/drm/i915/display/intel_plane.c         | 11 +++
 drivers/gpu/drm/i915/display/intel_psr.c           | 96 ++++++++++------------
 drivers/gpu/drm/i915/display/intel_psr_regs.h      |  4 +-
 drivers/gpu/drm/i915/display/intel_quirks.c        | 24 ++++++
 drivers/gpu/drm/i915/display/intel_quirks.h        |  1 +
 drivers/gpu/drm/i915/display/intel_vrr.c           | 12 ++-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |  2 +-
 12 files changed, 131 insertions(+), 71 deletions(-)

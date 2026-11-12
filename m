Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0098606A335
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dRU513k0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 143EF10FF45;
	Thu, 12 Nov 2026 09:10:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 842F510FF3E;
 Thu, 12 Nov 2026 09:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794474600; x=1826010600;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding;
 bh=D+KrG+Uev7dIQStbteS+EXo9ZQQi74+39Xfll8JsYMk=;
 b=dRU513k0roxXs5frjniTCfnDxClalkDY9KEE1tQrFPVHXX96ty5cVSQo
 FIZVVhQRndgZPDfAkSKat4c2iPBy8ZUaRVnBfut88MkrYdUpXlNI3p9oS
 voR5rAsWoypjR1BTSVmS1/oEJQ7+ReSsgE4DjYvl82sPMNsDeEOAa+/ZZ
 V0kX5NOFaRQFLC/YKmL/VU9Sxeqwpa+SWnOT0VVEaykSDSvOE0QTCbXos
 ZUeSWt0urvta0JlU+7x7bktV84Bo7XEmbdlCDStddMxRsqqah7eVdU6gV
 AWKPrdsNWs1+2KeJFPZ5KsflcWxjq3FDWwb/NK95zt7y6FTU+A7A+8tRN A==;
X-CSE-ConnectionGUID: 9DpVhIHLRKKzLB9WlVLW8w==
X-CSE-MsgGUID: zYHISLRySYGlcxwRAdJeQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3350977"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3350977"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 01:10:00 -0800
X-CSE-ConnectionGUID: FoYJbgqhS9S4LxKG1a/UiQ==
X-CSE-MsgGUID: x8x/O8pTSf+oxETqKbqhLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8778610"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.13])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 01:09:56 -0800
Date: Thu, 12 Nov 2026 11:09:53 +0200
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
Message-ID: <avWCYSLHWGPjYq7z@jlahtine-mobl>
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

Here goes drm-intel-fixes PR towards v7.4-rc3.

Fixes to address ASUS Zenbook Duo display issues and bunch of PSR fixes.

Regards, Joonas

***

drm-intel-fixes-2026-11-12:

- Fix for PTL GitLab #9196: eDP-2 on DDI B ends up in a state where any enable fails
- PSR fixes

The following changes since commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb:

  Linux 7.4-rc2 (2026-11-08 16:22:20 -0800)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-11-12

for you to fetch changes up to 9bf9ced37e60a6c947a481385cd9ed919f14cf36:

  drm/i915/psr: Clear CFF state on flip flush (2026-11-11 10:17:05 +0200)

----------------------------------------------------------------
- Fix for PTL GitLab #9196: eDP-2 on DDI B ends up in a state where any enable fails
- PSR fixes

----------------------------------------------------------------
Imre Deak (6):
      drm/i915/dp_aux: Take the TypeC port lock after the PPS lock
      drm/i915/pps: Hold a TypeC link reference for PPS VDD
      drm/i915/pps: Reset PPS state after TypeC port init on resume
      drm/i915/ptl+: Add TypeC HPD pin selection for port B
      drm/i915/mtl+: Use PHY type to identify TypeC ports in PLL ID lookup
      drm/i915/ptl+: Fix TypeC detection for eDP on port B

Jouni Högander (4):
      drm/i915/psr: Flush on cursor update also when not using Selective Fetch
      drm/i915/display: Flush the fbdev frontbuffer
      drm/i915/psr: Re-arm PSR after flush
      drm/i915/psr: Clear CFF state on flip flush

 drivers/gpu/drm/i915/display/intel_ddi.c      |  6 ++--
 drivers/gpu/drm/i915/display/intel_display.c  | 11 ++++++
 drivers/gpu/drm/i915/display/intel_dp_aux.c   | 39 ++++++++++----------
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c |  3 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c    | 13 +++----
 drivers/gpu/drm/i915/display/intel_pps.c      | 14 ++++++++
 drivers/gpu/drm/i915/display/intel_psr.c      | 52 ++++++++++++++-------------
 drivers/gpu/drm/i915/display/intel_tc.c       |  9 +++--
 8 files changed, 91 insertions(+), 56 deletions(-)

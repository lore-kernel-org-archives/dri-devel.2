Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BE710FC462
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 23:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5995F10E26E;
	Wed,  8 Apr 2026 23:35:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nKEPPyxc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DAE010E134;
 Wed,  8 Apr 2026 23:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775691306; x=1807227306;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=riEb8SlmbpNIOdCKmX1Z736fQTquJv2ekIdTMFXIu9I=;
 b=nKEPPyxcxBwnP71uV6vfAeXiUlIhkWNDwAQABP1Svikgf88LB0IGxJ7j
 Mx0R1OfG7eUdYYURBOraXhF+tWFPtd+UleSELZziaKsasLAdHbtJWNq5V
 QbGHaZwiruLFsmYtoqASvAMX1RQF7SQcgHTpkAlkIBAEX5wGwDRrlvsUc
 Q0lxs+8XGs7qIQF7nIw1C+epUI8XcPOb8t/iIMzCXL+hHvC5w+PTa4d9P
 Ems17WOWp8rU0oLFdMlu1XLf8TALyE+fj3Fxc0poBXVdrNzKhtuCC1ujk
 W41GsAFKdXuuMZbKz8LX2ijZ2iEkEypyrc02/GyAtBSYERS63sfOrifs/ w==;
X-CSE-ConnectionGUID: 6OcYYXoMSq65HrUf+2H0/g==
X-CSE-MsgGUID: 7xDw4bEkTHmygBxDtCB2BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76591329"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="76591329"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 16:35:05 -0700
X-CSE-ConnectionGUID: R6jZ7H4YRAi+nHTVqKNt1w==
X-CSE-MsgGUID: mNDx3/N3RGefmSg9zfejdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="230272992"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.73])
 by fmviesa004-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 16:35:01 -0700
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Simona Vetter <simona.vetter@ffwll.ch>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jani Nikula <jani.nikula@intel.com>,
 =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 0/6] drm/i915/reset: Solve display vs. GPU reset deadlock,
 again
Date: Thu,  9 Apr 2026 02:34:52 +0300
Message-ID: <20260408233458.22666-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
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

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Apparently we lost proper display vs. GPU reset deadlock
handling. Try to bring it back, using a modern dma-fence
based approach.

Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Christian König <christian.koenig@amd.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Jouni Högander <jouni.hogander@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

Ville Syrjälä (6):
  dma-buf: Remove old lies about dma_fence_wait_any_timeout() not
    accepting some fences
  drm/i915/reset: Reorganize display reset code
  drm/i915/reset: Move pending_fb_pin handling to i915
  drm/xe/display: Add init_clock_gating.h stubs
  drm/i915/reset: Handle the display vs. GPU reset deadlock using a
    custom dma-fence
  drm/i915/display: Make fence timeout infinite

 drivers/dma-buf/dma-fence.c                   |   5 +-
 drivers/gpu/drm/i915/display/intel_display.c  |  34 ++++--
 .../gpu/drm/i915/display/intel_display_core.h |   7 +-
 .../drm/i915/display/intel_display_driver.c   |   5 +
 .../drm/i915/display/intel_display_power.c    |   2 -
 .../drm/i915/display/intel_display_reset.c    | 103 +++++++++++++++---
 .../drm/i915/display/intel_display_reset.h    |   8 +-
 drivers/gpu/drm/i915/display/intel_overlay.c  |  10 +-
 drivers/gpu/drm/i915/gt/intel_reset.c         |  26 +++--
 drivers/gpu/drm/i915/i915_dpt.c               |   5 +-
 drivers/gpu/drm/i915/i915_drv.h               |   2 +
 drivers/gpu/drm/i915/i915_fb_pin.c            |   9 +-
 drivers/gpu/drm/i915/i915_overlay.c           |   6 +
 drivers/gpu/drm/xe/Makefile                   |   1 +
 .../compat-i915-headers/intel_clock_gating.h  |  10 +-
 15 files changed, 168 insertions(+), 65 deletions(-)

-- 
2.52.0


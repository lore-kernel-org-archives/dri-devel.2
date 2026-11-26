Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8C606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kO+c5kDQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1595710E2DC;
	Thu, 26 Nov 2026 08:40:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D5810E1D7;
 Thu, 26 Nov 2026 08:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795682412; x=1827218412;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=00U5HdvPIcUAOyjC+Ix14nGAiDk3/VE1h1kzDh/+zvI=;
 b=kO+c5kDQWsDq54buOhimXWAThTDN38TOwTNK2I/IxyJ3CQOPerWzSjS6
 duB1Ofz/PGwZprnVRGh0t7DuiHS7gax2dWMy+0NsgWOsTmXUbCjMNfoUd
 LC17xlKpZg4GfjYQFRoSXPq2n4pbJkbJMoQm4ykkbt44ikB5yDB6QFM/S
 P92yxRJvDe6uaXXJ07tE/ATnOp3nM9C1hPeMAclFz2sYj1McU7GBkm6wr
 rbLHgCDnP113XvVz4O9FSZXvh0hUNaEqY404SnZgf70uuggbU1RNpaSBf
 7B0wSqDUV5luJdE10H5hD9/X4r5pKDpRMy1qEDtUWrOCCwI/2rnT+Qflb g==;
X-CSE-ConnectionGUID: 4gYr0e52RSubLNS8rpMVgQ==
X-CSE-MsgGUID: AaC0tcdsTDmlcw8I8OBtzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4488500"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4488500"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 00:40:12 -0800
X-CSE-ConnectionGUID: d9PLpn6nTquZ+DEDlEiJCw==
X-CSE-MsgGUID: cXuZomnVSEydEO8QsyMobQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12125642"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by orviesa007.jf.intel.com with ESMTP; 26 Nov 2026 00:40:09 -0800
From: Arun R Murthy <arun.r.murthy@intel.com>
Subject: [PATCH v6 00/13] drm/i915/dp: Add support for the DP symbol based
 timing generator
Date: Thu, 26 Nov 2026 14:04:55 +0530
Message-Id: <20261126-vlk-64036-dp-symbol-tg-v6-0-835a4f5c0a12@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADDvB2sC/4XPwWrDMAyA4VcpPs/DlhXZ2WnvMXZobLk1S5MSB
 7NS8u5ze1kWCDv+An1Cd5F5SpzF2+EuJi4pp3GoQS8H4c/H4cQyhdoCFJBWYGXpvyShMiTDVeb
 bpRt7OZ9ksOARAFxDLOrydeKYvp/wx2ftc8rzON2ed4p+TP8li5ZKeqSI3EWyHN7TMHP/6seLe
 JAF1ozbZaAyaBy23kATDGwZs2baXcZUhloFgIActd0y+MtohbsMViYoikz1NTq2W6ZZMaB2maY
 yXXTRus6AVX+YZVl+ABsvrlrYAQAA
X-Change-ID: 20261027-vlk-64036-dp-symbol-tg-d72c4222856e
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 chaitanya.kumar.borah@intel.com, uma.shankar@intel.com, 
 suraj.kandpal@intel.com, Arun R Murthy <arun.r.murthy@intel.com>
X-Mailer: b4 0.15-dev
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Xe3p adds a DP link layer (LL) symbol based timing generator, as an
alternative to the pixel clock based one. It generates the transcoder
timings in LL symbol cycles instead of pixels, which makes the per-line
symbol insertion for 8b/10b MST and 128b/132b SST/MST compliant with
the DP 2.1 hblank symbol cycle count. This reduces the line-to-line
hblank jitter that some sinks can't handle, and the Min Hblank
mechanism can't be used together with it.

This series computes the LL symbol HACT/HTOTAL/CHUNK_SIZE and the 128
bit Data M/N for the symbol based timing generator, programs and enables
it, and drops the Link M/N ratio limit, which only applies to the pixel
based timing generator. If the symbol based timing generator can't be
used (MSO/eDP splitter, timings out of range, Data M/N above 1.0), the
pixel based one is kept.

Patch overview:
 - Patch 1 factors out the DSC slice count and link bpp lookup, to be
   shared with the Min Hblank computation.
 - Patch 2 adds the symbol based timing generator registers.
 - Patch 3 adds the symbol based timing generator state to the crtc
   state, with its state dump and state checker comparison.
 - Patch 4 adds HAS_DP_SYMBOL_TG().
 - Patch 5 computes the timing generator parameters.
 - Patch 6 programs and enables the timing generator, including the
   state readout.
 - Patch 7 lifts the Link M/N ratio limit when the symbol based timing
   generator is used.

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: chaitanya.kumar.borah@intel.com
Cc: uma.shankar@intel.com
Cc: suraj.kandpal@intel.com
To: intel-gfx@lists.freedesktop.org
To: intel-xe@lists.freedesktop.org
To: dri-devel@lists.freedesktop.org

Bspec: 68922
Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
---
Changes in v6:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v5: https://lore.kernel.org/r/20261120-vlk-64036-dp-symbol-tg-v5-0-bf8f78b32709@intel.com

Changes in v5:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v4: https://lore.kernel.org/r/20261104-vlk-64036-dp-symbol-tg-v4-0-d06fe6c466a9@intel.com

Changes in v4:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v3: https://lore.kernel.org/r/20261029-vlk-64036-dp-symbol-tg-v3-0-69022424ef17@intel.com

Changes in v3:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v2: https://lore.kernel.org/r/20261028-vlk-64036-dp-symbol-tg-v2-0-43849c325d32@intel.com

Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20261027-vlk-64036-dp-symbol-tg-v1-0-c46f4ebf67ed@intel.com

---
Arun R Murthy (13):
      drm/i915/dp: Factor out the DSC slice count and link bpp lookup
      drm/i915/display: Add the DP link layer symbol timing generator registers
      drm/i915/display: Add the DP symbol timing generator crtc state
      drm/i915/display: Add HAS_DP_SYMBOL_TG()
      drm/dp: Add the DPCD definitions of the Rx minimum Hblank
      drm/i915/dp: Compute the DP symbol based timing generator parameters
      drm/i915/display: Program the DP symbol based timing generator
      drm/i915/dp: Don't limit the Link M/N ratio with the symbol timing generator
      drm/i915/dp: Select the symbol TG Data M/N matching the active PLL
      drm/i915/dp: Prune the modes not fitting the DP symbol timing generator
      drm/dp: Add a helper for the DP BW margin overhead
      drm/i915/dp: Account for the symbol TG in the DP BW calculations
      drm/i915/dp: Enable the DP symbol TG

 drivers/gpu/drm/display/drm_dp_helper.c            |  86 ++--
 drivers/gpu/drm/i915/display/intel_audio.c         |  28 +-
 .../gpu/drm/i915/display/intel_crtc_state_dump.c   |  11 +
 drivers/gpu/drm/i915/display/intel_ddi.c           |   2 +
 drivers/gpu/drm/i915/display/intel_display.c       | 125 +++++-
 drivers/gpu/drm/i915/display/intel_display.h       |   1 +
 drivers/gpu/drm/i915/display/intel_display_core.h  |   5 +
 .../gpu/drm/i915/display/intel_display_debugfs.c   |   3 +
 .../gpu/drm/i915/display/intel_display_device.h    |   1 +
 drivers/gpu/drm/i915/display/intel_display_regs.h  |  38 ++
 drivers/gpu/drm/i915/display/intel_display_types.h |  24 +
 drivers/gpu/drm/i915/display/intel_dp.c            | 493 +++++++++++++++++++--
 drivers/gpu/drm/i915/display/intel_dp.h            |  25 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c        | 119 ++++-
 drivers/gpu/drm/i915/display/intel_dp_tunnel.c     |   4 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |  31 ++
 drivers/gpu/drm/i915/display/intel_dpll_mgr.h      |   2 +
 include/drm/display/drm_dp.h                       |   5 +
 include/drm/display/drm_dp_helper.h                |   1 +
 19 files changed, 894 insertions(+), 110 deletions(-)
---
base-commit: d56ff005f0d16ec136ee31fe3238eb447fefdc1a
change-id: 20261027-vlk-64036-dp-symbol-tg-d72c4222856e

Best regards,
-- 
Arun R Murthy <arun.r.murthy@intel.com>


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B2606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TPNx8CCP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A054610E960;
	Mon, 26 Oct 2026 05:40:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3532310E95C;
 Mon, 26 Oct 2026 05:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993213; x=1824529213;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/j/inK6MAQBVerP3lUM7rCMRHX50k1F0US25dbpFbqw=;
 b=TPNx8CCPMQ/+WFfsfWy8HD0evi/UGVnHoE3xZBZ6VuZmoG1O87rKa8EU
 fHkTFqHSBfYgfxO7a6RrDtx87adofq1FvheqwuWFAsbuyQo6p6dDcCtZd
 osILOqO7b0/ly0oeh7U8V4SXt1jlH6EIDCxpguxcdnf5RFFt3MShwKf+a
 +HoBiyxikTjOOdNDs31KllZbJa0cKFBRdP7spbsAIc126aOqKurmLnuk3
 56gFEhKJ9vKYlJSfe8ohJ2qdhMv2KVknQuD9CgEma+aqEJXuGiG6UeHN6
 6BtebtXhLFGjo9bSk7lxF3o4sTlXO9KBolMJ73nns3YwpSlQHq6OrlL0T Q==;
X-CSE-ConnectionGUID: dJmkv/ZGSNK4P4odLlwfYg==
X-CSE-MsgGUID: OKleMRjtSFaT5BG7NWqtpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550147"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550147"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:40:13 -0700
X-CSE-ConnectionGUID: WV3T4yj+SqWycOXmUyBQog==
X-CSE-MsgGUID: qS1ldeGZQrOT7M4J/hHmzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6001823"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:40:11 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 00/20] Enable DP2.1 alpm
Date: Mon, 26 Oct 2026 11:09:11 +0530
Message-ID: <20261026054001.799894-1-animesh.manna@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ALPM support added on DP2.1 and xe3p will support DP2.1 alpm.
This patch series extending alpm supoort for DP2.1.

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>

Animesh Manna (20):
  drm/i915/alpm: Program zero-based LFPS half cycle duration
  drm/dp: Add DPCD definitions for DP2.1 ALPM capability
  drm/i915/alpm: Move alpm sink capability readout into a separate
    function
  drm/i915/alpm: alpm_init() for DP2.1
  drm/i915/alpm: Enable debugfs for DP2.1
  drm/i915/alpm: Refactor Auxless wake time calculation
  drm/i915/alpm: Auxless wake time calculation for Xe3p
  drm/i915/alpm: Modify AUX_LESS_WAKE_TIME bitfield for xe3lpd
  drm/i915/alpm: table based establishment period
  drm/i915/alpm: Half LFPS cycle calculation
  drm/i915/alpm: Modify LFPS cycle count for DP ALPM
  drm/i915/alpm: Modify LFPS_CYCLE_COUNT bitfield for xe3lpd
  drm/i915/alpm: Program LTTPR count for DP 2.1 ALPM
  drm/i915/alpm: Enable MAC Transmitting LFPS for LT PHY
  drm/i915/alpm: Compute and program switch to active latency
  drm/i915/alpm: Replace is_edp() with alpm_is_possible()
  drm/i915/alpm: Disallow ALPM for UHBR link rate
  drm/i915/alpm: Compute ALPM config before PSR config
  drm/i915/alpm: Introduce has_alpm to decouple from pr/psr2/lobf
  drm/i915/dp: Enable AS SDP for DP Panel Replay with AUX-less ALPM

 drivers/gpu/drm/i915/display/intel_alpm.c     | 443 +++++++++++++++---
 drivers/gpu/drm/i915/display/intel_alpm.h     |  17 +-
 drivers/gpu/drm/i915/display/intel_cx0_phy.c  |   2 +-
 drivers/gpu/drm/i915/display/intel_ddi.c      |   5 +-
 .../drm/i915/display/intel_display_types.h    |   6 +
 drivers/gpu/drm/i915/display/intel_dp.c       |  22 +-
 .../drm/i915/display/intel_dp_link_training.c |  22 +-
 drivers/gpu/drm/i915/display/intel_lt_phy.c   |  27 ++
 drivers/gpu/drm/i915/display/intel_lt_phy.h   |   2 +
 .../gpu/drm/i915/display/intel_lt_phy_regs.h  |   3 +
 drivers/gpu/drm/i915/display/intel_psr.c      |  23 +-
 drivers/gpu/drm/i915/display/intel_psr.h      |   5 +-
 drivers/gpu/drm/i915/display/intel_psr_regs.h |  16 +-
 include/drm/display/drm_dp.h                  |   5 +-
 14 files changed, 490 insertions(+), 108 deletions(-)

-- 
2.43.0


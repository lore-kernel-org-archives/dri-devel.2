Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440CDCA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C3EB10E441;
	Mon, 12 Oct 2026 04:14:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32DAE10E3D0;
 Mon, 12 Oct 2026 04:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778468; x=1823314468;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P7gjmNbySVBopQSvayu8jfosxCZE5DfpclDNWmTLgSw=;
 b=DsBrwp2jjvmmacBDrTQz5ghb3EQFj78CFvwwTLNxCgCxZY8oJXP4QN70
 2BJT9PI3Dn8DBPo/x3Ms0DPdSjzW0p+e+AOjjH9LBLFOoqPwxygBw6f0r
 oKdMdTK9ImRS+nv0/eyyl/oD/ZYEwVw+7ZUTli7rlv3F5hQFpTSz4fOya
 maAhEjJV1g0FGzT0qKNPTn0g5zqjlv2DvmLVMyMUDrZc5j0Tm0RqchBRQ
 sCjfoLjtdny8LvoCkCsICHcmUDCDbMV5rEF/5ZUEh9W1gnTvoIS6NTlHb
 qiNZx22GPy/psBXzN/fKTusI0oOBBvvDAAkAglhoAY7raFYs5PZJEF+ch g==;
X-CSE-ConnectionGUID: pw/OBXYgSpup5vcHookJzA==
X-CSE-MsgGUID: cVdP9WzJSc2QXFSFLyANlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380826"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380826"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:28 -0700
X-CSE-ConnectionGUID: s+piBdDuSf6tehayd0ebIQ==
X-CSE-MsgGUID: Sj62htgaSNeUtIcaJjU2bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256344"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:26 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 06/56] drm/i915/display: Add new members in crtc_state for
 FRL configuration
Date: Mon, 12 Oct 2026 09:27:15 +0530
Message-ID: <20261012035806.3361439-7-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
MIME-Version: 1.0
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

Add new struture to store FRL related configurations for a pipe.
These members to be calculated during compute config phase, when FRL
mode is to be used.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 .../drm/i915/display/intel_display_types.h    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 8a2128473f4f..019f7b1b7c29 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1467,6 +1467,32 @@ struct intel_crtc_state {
 
 	/* to track changes in plane color blocks */
 	bool plane_color_changed;
+
+	struct {
+		/* Go for FRL training */
+		bool enable;
+
+		/* Enable resource based scheduling */
+		bool rsrc_sched_en;
+
+		/* can be either 3 or 4 lanes */
+		u8 required_lanes;
+
+		/* required rate - can be 3, 6, 8, 10, 12 Gbps */
+		u8 required_rate;
+
+		/* FRL DFM Parameters */
+		u32 tb_borrowed, tb_actual, tb_threshold_min, active_char_buf_threshold;
+
+		/* FRL DFM DSC Tribytes */
+		u32 hcactive_tb, hctotal_tb;
+
+		/* Clock parameters in KHz */
+		u32 div18;
+
+		/* link m/n */
+		u32 link_m, link_n;
+	} frl;
 };
 
 enum intel_pipe_crc_source {
-- 
2.50.1


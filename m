Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3920A10854BE
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9045710E785;
	Wed, 18 Mar 2026 09:26:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="N50FXlH1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3057110E784;
 Wed, 18 Mar 2026 09:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773826009; x=1805362009;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/m2hja6OiafspbAgPt54JiZVY8gUs/E/1h382G8guOs=;
 b=N50FXlH16q8vQX/liJFJvqjme0aLkYUJJNtNbwZm9mkpASXXg6/hPINh
 kHlyFtF/K6Bj0BQhWK4CFqhMUOccEAzPucrCmyLCmmOeV2U5lkQoL/1gh
 LsE+mwsOaLLQBOhqq34OxI9RkeOwIMDQXS2njDHe8PwOGsiNBLp8s/YkF
 DX1KJaFToK7L3/HyiZfKC1Jf6WRKDk7fgHUG74BuwaqQwvKt53FoZdfRl
 cV/60QOoCisMSvVI+n6gHHonclQPI5TtX88l6fD6OP3Q8R0+ejTDYjyUY
 I4dUB7WuPvxM9ZoHqdqSbaB5eF8A8jqVuqeu7DMlG+6RGPctBBRUQLvQ7 A==;
X-CSE-ConnectionGUID: m2fmymvcQz68ZF2ppD8TGQ==
X-CSE-MsgGUID: jqtZfkfQT3+ISlqk7eleIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85953868"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="85953868"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 02:26:49 -0700
X-CSE-ConnectionGUID: U70a2Oz3S0CnKBqAf4b0xQ==
X-CSE-MsgGUID: orvzxyUnTA+38dd86Qdf+A==
X-ExtLoop1: 1
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.223.74.76])
 by fmviesa003.fm.intel.com with ESMTP; 18 Mar 2026 02:26:46 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, imre.deak@intel.com, jani.nikula@intel.com,
 arun.r.murthy@intel.com, Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v8 2/3] drm/i915/display: Add hook to check optimization
 support for Intel platforms
Date: Wed, 18 Mar 2026 14:26:41 +0530
Message-Id: <20260318085642.3621166-3-animesh.manna@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20260318085642.3621166-1-animesh.manna@intel.com>
References: <20260318085642.3621166-1-animesh.manna@intel.com>
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

Add a hook that uses the drm core tunneling function to check
whether panel replay bandwidth optimization support is present.

v2: Move DISPLAY_VER() check to
intel_dp_tunnel_pr_optimization_supported(). [Jouni]

Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp_tunnel.c | 18 ++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp_tunnel.h |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_tunnel.c b/drivers/gpu/drm/i915/display/intel_dp_tunnel.c
index 1fd1ac8d556d..b81ac9a2d727 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_tunnel.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_tunnel.c
@@ -296,6 +296,24 @@ bool intel_dp_tunnel_bw_alloc_is_enabled(struct intel_dp *intel_dp)
 	return drm_dp_tunnel_bw_alloc_is_enabled(intel_dp->tunnel);
 }
 
+/**
+ * intel_dp_tunnel_pr_optimization_supported - Query the PR BW optimization support
+ * @intel_dp: DP port object
+ *
+ * Query whether a DP tunnel supports the PR BW optimization.
+ *
+ * Returns %true if the BW allocation mode is supported on @intel_dp.
+ */
+bool intel_dp_tunnel_pr_optimization_supported(struct intel_dp *intel_dp)
+{
+	struct intel_display *display = to_intel_display(intel_dp);
+
+	if (DISPLAY_VER(display) < 35)
+		return false;
+
+	return drm_dp_tunnel_pr_optimization_supported(intel_dp->tunnel);
+}
+
 /**
  * intel_dp_tunnel_suspend - Suspend a DP tunnel connected on a port
  * @intel_dp: DP port object
diff --git a/drivers/gpu/drm/i915/display/intel_dp_tunnel.h b/drivers/gpu/drm/i915/display/intel_dp_tunnel.h
index 7f0f720e8dca..03e147736b65 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_tunnel.h
+++ b/drivers/gpu/drm/i915/display/intel_dp_tunnel.h
@@ -32,6 +32,7 @@ void intel_dp_tunnel_resume(struct intel_dp *intel_dp,
 void intel_dp_tunnel_suspend(struct intel_dp *intel_dp);
 
 bool intel_dp_tunnel_bw_alloc_is_enabled(struct intel_dp *intel_dp);
+bool intel_dp_tunnel_pr_optimization_supported(struct intel_dp *intel_dp);
 
 void
 intel_dp_tunnel_atomic_cleanup_inherited_state(struct intel_atomic_state *state);
@@ -76,6 +77,11 @@ static inline bool intel_dp_tunnel_bw_alloc_is_enabled(struct intel_dp *intel_dp
 	return false;
 }
 
+static inline bool intel_dp_tunnel_pr_optimization_supported(struct intel_dp *intel_dp)
+{
+	return false;
+}
+
 static inline void
 intel_dp_tunnel_atomic_cleanup_inherited_state(struct intel_atomic_state *state) {}
 
-- 
2.29.0


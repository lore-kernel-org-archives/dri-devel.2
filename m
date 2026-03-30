Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1903110F3DCD
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6260110E6EB;
	Mon, 30 Mar 2026 14:06:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OwWc2dys";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4865410E714;
 Mon, 30 Mar 2026 14:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774879600; x=1806415600;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lZ3z8uv2d7NxnWU6np9BRzha+5HqxaYoS6vw3e1JJc4=;
 b=OwWc2dys7qBUhG29tiVAdXaFpXqIQZIvWctYCXsODfOKRAB+wUQTqD/Z
 BqXMOKxJ5XUu8TBS0KnXaNKySD0IaJ7e+ZfY/tiG+p0v3DPik7y2HQ2Z+
 FKcK0dQeAIc3IC0PqEfFaHDFn/TqtLnQXZIMMyWgEvMCbwC/feRIGcljz
 4Yx+hiXEktadyolsgTFjCpHh1MpETPuqJyR+Mg2Ok8SF48ToffnPFaIPx
 y76GKC8Klfh7GZM0mZhx83WHezm+tKGkUOMDtc+uipwzwhqSQ6OedptsS
 nn5bjUhWpwwrxr1QzZLxlvTbADb0uphghEHmsq2sJYOb8bvx+MZrC2g/n Q==;
X-CSE-ConnectionGUID: QN2MO7HPT4myR83Ty5NwVA==
X-CSE-MsgGUID: ENiFpZPwQjCpxCy4cY5ecg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79474791"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="79474791"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 07:06:40 -0700
X-CSE-ConnectionGUID: 31MMfiecS/KGH6J32Ajykw==
X-CSE-MsgGUID: kWXUF9Q/S0GyTBHbRh95cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="249271598"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.223.74.76])
 by fmviesa001.fm.intel.com with ESMTP; 30 Mar 2026 07:06:37 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Animesh Manna <animesh.manna@intel.com>,
 =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
Subject: [PATCH v10 2/3] drm/i915/display: Add hook to check optimization
 support for Intel platforms
Date: Mon, 30 Mar 2026 19:06:19 +0530
Message-Id: <20260330133620.3750559-3-animesh.manna@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20260330133620.3750559-1-animesh.manna@intel.com>
References: <20260330133620.3750559-1-animesh.manna@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp_tunnel.c | 18 ++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp_tunnel.h |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp_tunnel.c b/drivers/gpu/drm/i915/display/intel_dp_tunnel.c
index 7363c9817297..11712a151f72 100644
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
index 10ab9eebcef6..8273e681a512 100644
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


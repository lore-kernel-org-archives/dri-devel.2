Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73F910F3DF0
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C371D10E6FA;
	Mon, 30 Mar 2026 14:06:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QMnK6Xi6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0462710E6EB;
 Mon, 30 Mar 2026 14:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774879598; x=1806415598;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vLd80wTN8FzV6D69QdJ5xLg3bhEtlwZAzWtGLRwVDoc=;
 b=QMnK6Xi6swNVGK53y6BSBqBR4NW5Q1PlsJ9C8Z63Z5cMDTTuX2Ol+F40
 NTTUp1+32Fiqz+j2CHDse4cdrs2BDVASI5TRVeo5lp0gqAvzoOpyc1eWR
 IteW5ocz24xTWXJ2pIN/yl+Vj19oP8T7k/FaawJGTBtC6mVglGDFmVWrj
 To1WQPWYxmtRD5WaLcEXeVMcOPXXV6REbSqe46ehXAtWRlenY6FR9oqbq
 BUT+c+C2ynaBDHV29YVg0WRYhnB7Zx6lSLc6/Ga8ZY7Zm1ag8tmzRxptu
 ypHlz2cTWxzhZCCT+PbeWb1iuZQ/faI3+sXyJPvGOQRUb9C6eNKCklY3L A==;
X-CSE-ConnectionGUID: KEEDUEg7Qm+gfhBNm2SXxg==
X-CSE-MsgGUID: Yu2/40hqSY6DmC6RXFQcJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="79474786"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="79474786"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 07:06:37 -0700
X-CSE-ConnectionGUID: OufKWQYCQ7SYgmMT6XDXIQ==
X-CSE-MsgGUID: UmILm6cGQUay2RQJIR+O9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="249271553"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.223.74.76])
 by fmviesa001.fm.intel.com with ESMTP; 30 Mar 2026 07:06:34 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Animesh Manna <animesh.manna@intel.com>,
 =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
 Imre Deak <imre.deak@intel.com>
Subject: [PATCH v10 1/3] drm/display: Add drm helper to check pr optimization
 support
Date: Mon, 30 Mar 2026 19:06:18 +0530
Message-Id: <20260330133620.3750559-2-animesh.manna@intel.com>
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

Add api to check panel replay optimization supported or not to
drm-core DP tunneling framework which can be used by other driver
as well.

v2: Split generic drm changes from Intel specific changes. [Jouni]

Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
Suggested-by: Imre Deak <imre.deak@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/display/drm_dp_tunnel.c | 17 +++++++++++++++++
 include/drm/display/drm_dp_tunnel.h     |  6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_dp_tunnel.c b/drivers/gpu/drm/display/drm_dp_tunnel.c
index 6519b4244728..08dc5d26b2c5 100644
--- a/drivers/gpu/drm/display/drm_dp_tunnel.c
+++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
@@ -149,6 +149,7 @@ struct drm_dp_tunnel {
 	bool bw_alloc_enabled:1;
 	bool has_io_error:1;
 	bool destroyed:1;
+	bool pr_optimization_support:1;
 };
 
 struct drm_dp_tunnel_group_state;
@@ -508,6 +509,8 @@ create_tunnel(struct drm_dp_tunnel_mgr *mgr,
 
 	tunnel->bw_alloc_supported = tunnel_reg_bw_alloc_supported(regs);
 	tunnel->bw_alloc_enabled = tunnel_reg_bw_alloc_enabled(regs);
+	tunnel->pr_optimization_support = tunnel_reg(regs, DP_TUNNELING_CAPABILITIES) &
+					  DP_PANEL_REPLAY_OPTIMIZATION_SUPPORT;
 
 	if (!add_tunnel_to_group(mgr, drv_group_id, tunnel)) {
 		kfree(tunnel);
@@ -1036,6 +1039,20 @@ bool drm_dp_tunnel_bw_alloc_is_enabled(const struct drm_dp_tunnel *tunnel)
 }
 EXPORT_SYMBOL(drm_dp_tunnel_bw_alloc_is_enabled);
 
+/**
+ * drm_dp_tunnel_pr_optimization_supported - Query the PR BW optimization support
+ * @tunnel: Tunnel object
+ *
+ * Query if the PR BW optimization is supported for @tunnel.
+ *
+ * Returns %true if the PR BW optimiation is supported for @tunnel.
+ */
+bool drm_dp_tunnel_pr_optimization_supported(const struct drm_dp_tunnel *tunnel)
+{
+	return tunnel && tunnel->pr_optimization_support;
+}
+EXPORT_SYMBOL(drm_dp_tunnel_pr_optimization_supported);
+
 static int clear_bw_req_state(struct drm_dp_aux *aux)
 {
 	u8 bw_req_mask = DP_BW_REQUEST_SUCCEEDED | DP_BW_REQUEST_FAILED;
diff --git a/include/drm/display/drm_dp_tunnel.h b/include/drm/display/drm_dp_tunnel.h
index 87212c847915..4aa3ce9fd829 100644
--- a/include/drm/display/drm_dp_tunnel.h
+++ b/include/drm/display/drm_dp_tunnel.h
@@ -53,6 +53,7 @@ int drm_dp_tunnel_destroy(struct drm_dp_tunnel *tunnel);
 int drm_dp_tunnel_enable_bw_alloc(struct drm_dp_tunnel *tunnel);
 int drm_dp_tunnel_disable_bw_alloc(struct drm_dp_tunnel *tunnel);
 bool drm_dp_tunnel_bw_alloc_is_enabled(const struct drm_dp_tunnel *tunnel);
+bool drm_dp_tunnel_pr_optimization_supported(const struct drm_dp_tunnel *tunnel);
 int drm_dp_tunnel_alloc_bw(struct drm_dp_tunnel *tunnel, int bw);
 int drm_dp_tunnel_get_allocated_bw(struct drm_dp_tunnel *tunnel);
 int drm_dp_tunnel_update_state(struct drm_dp_tunnel *tunnel);
@@ -140,6 +141,11 @@ static inline bool drm_dp_tunnel_bw_alloc_is_enabled(const struct drm_dp_tunnel
 	return false;
 }
 
+static inline bool drm_dp_tunnel_pr_optimization_supported(const struct drm_dp_tunnel *tunnel)
+{
+	return false;
+}
+
 static inline int
 drm_dp_tunnel_alloc_bw(struct drm_dp_tunnel *tunnel, int bw)
 {
-- 
2.29.0


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50A5C982C1
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3785810EE39;
	Tue, 15 Sep 2026 18:39:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nY5a7dPM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34A3D10E2D4;
 Tue, 15 Sep 2026 18:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789497549; x=1821033549;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y2NaKDg/1mgsqgUnYHc+ObHeStKfKXjFM+s5WhaLIb0=;
 b=nY5a7dPMrMy17MJH4KrRY0Je5Sh+ME/aNL5OKRXEa0egTKqZZ7aFhnb5
 URjprw917JA33FPKywEv0b9yrPMWJFsnq5IJX6CXRlD3Y0yqYMTMr6f8A
 +qbXdvl0Vz+ccq1gUC9cK2wp5TYxha7AmyUkfhp4NWrwCp6aphq39ZkWJ
 jy1YqnJm5T2EqHXNjsN3rChYmVjRxky9mC4LCwX8eTYIuM6c1Jq/ZBjP4
 2zuFNzXfBX6OZECAOelCjQt7trLP/vTFmGY060iT3xTQ9nT8lX8/N56oz
 szRImD/rRYmUyo8tF8DuUKcsF+TdZCOSHv3UAkURyn1CEGrPxqqFlouBg g==;
X-CSE-ConnectionGUID: 2ZjqoxcQQYCuWbx/h+zVVQ==
X-CSE-MsgGUID: ffoGkCkaSPKTlUKcHnMrzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92380274"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92380274"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:39:09 -0700
X-CSE-ConnectionGUID: uGVk5F8wTfCx00z8MEB41A==
X-CSE-MsgGUID: y7Z3+BbkTdu3GMZYAicvLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298148471"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 11:39:06 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v6 04/18] drm/i915/alpm: Enable debugfs for DP2.1
Date: Tue, 15 Sep 2026 23:34:35 +0530
Message-Id: <20260915180449.277933-5-animesh.manna@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20260915180449.277933-1-animesh.manna@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
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

Enable ALPM debug info through lobf debug info.

v2: cosmetic change. [Suraj]
v3: Use common api instead of DISPLAY_VER check in multiple places. [Jani]
v4: Add display-version check as it dropped for EDP.

Cc: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 4801fc6bade2..901493bb1448 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -739,8 +739,10 @@ void intel_alpm_lobf_debugfs_add(struct intel_connector *connector)
 	struct intel_display *display = to_intel_display(connector);
 	struct dentry *root = connector->base.debugfs_entry;
 
-	if (DISPLAY_VER(display) < 20 ||
-	    connector->base.connector_type != DRM_MODE_CONNECTOR_eDP)
+	if (DISPLAY_VER(display) < 20)
+		return;
+
+	if (!intel_alpm_source_supported(connector))
 		return;
 
 	debugfs_create_file("i915_edp_lobf_debug", 0644, root,
-- 
2.29.0


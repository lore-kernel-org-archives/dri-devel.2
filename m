Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A1606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nddPU0tN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D4E410E984;
	Mon, 26 Oct 2026 05:40:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 918B610E961;
 Mon, 26 Oct 2026 05:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993229; x=1824529229;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=38qzkxCYP7XmebCK74SLhgvdd2jQfZvcCsgrD/HWAKA=;
 b=nddPU0tN5kymuesTJwszWAL2Wkiig2gtXkVNoYI/pbk4UA6y14U2snc2
 YGxiFvyhzvvlZAKGCW+dUyvftwMzhJmslQKRwfJ4ybIjzAcD8zY2XtiTx
 HZ8AaOtrURH9n8DstyJ7slvvn5x2ZBgyn9qvQjDgCZXup+T8306sPVkD8
 fkBdyEKZWpKoeWW3ISpG6IftxFJrY086Mh3HdYPAby2haAD6pm1ceGhpy
 +OnjX3Xi3sJ3qTVPoLDzo23nlLKF2tuXd4p0/GBbnVsatVjNbLuBD5u1g
 tHgJE0rtY/kBqN71hAc/iybihlKxv2LXsjcjJ7mXJz+AzpCuEjX3zMjc7 Q==;
X-CSE-ConnectionGUID: LBel0nVfSyyd04NZoFmRBA==
X-CSE-MsgGUID: Z6jIN381TGSUF4wbFmT/ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550185"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550185"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:40:29 -0700
X-CSE-ConnectionGUID: /mLOObpxQ22aioXUxEavOA==
X-CSE-MsgGUID: 0GuiPUPKS1C6h4B9dYR4mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6001859"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:40:27 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 05/20] drm/i915/alpm: Enable debugfs for DP2.1
Date: Mon, 26 Oct 2026 11:09:16 +0530
Message-ID: <20261026054001.799894-6-animesh.manna@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026054001.799894-1-animesh.manna@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable ALPM debug info through lobf debug info.

As LOBF debugfs entries are now created for both DP and eDP connectors,
rename i915_edp_lobf_debug/i915_edp_lobf_info to i915_lobf_debug/
i915_lobf_info. The connector type is already part of the debugfs path.

v2: cosmetic change. [Suraj]
v3: Use common api instead of DISPLAY_VER check in multiple places. [Jani]
v4: Add display-version check as it dropped for EDP.
v5:
- Rename debugfs entries to i915_lobf_debug/i915_lobf_info. [Jouni]
- Rebase on intel_alpm_source_supported() taking intel_dp and skip
  MST connectors as they have no fixed encoder.

Cc: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 31 ++++++++++++++---------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index b6307862b756..12dc79198494 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -680,7 +680,7 @@ void intel_alpm_lobf_enable(const struct intel_crtc_state *new_crtc_state)
 	}
 }
 
-static int i915_edp_lobf_info_show(struct seq_file *m, void *data)
+static int i915_lobf_info_show(struct seq_file *m, void *data)
 {
 	struct intel_connector *connector = m->private;
 	struct intel_display *display = to_intel_display(connector);
@@ -714,10 +714,10 @@ static int i915_edp_lobf_info_show(struct seq_file *m, void *data)
 	return ret;
 }
 
-DEFINE_SHOW_ATTRIBUTE(i915_edp_lobf_info);
+DEFINE_SHOW_ATTRIBUTE(i915_lobf_info);
 
 static int
-i915_edp_lobf_debug_get(void *data, u64 *val)
+i915_lobf_debug_get(void *data, u64 *val)
 {
 	struct intel_connector *connector = data;
 	struct intel_dp *intel_dp = enc_to_intel_dp(connector->encoder);
@@ -728,7 +728,7 @@ i915_edp_lobf_debug_get(void *data, u64 *val)
 }
 
 static int
-i915_edp_lobf_debug_set(void *data, u64 val)
+i915_lobf_debug_set(void *data, u64 val)
 {
 	struct intel_connector *connector = data;
 	struct intel_dp *intel_dp = enc_to_intel_dp(connector->encoder);
@@ -738,8 +738,8 @@ i915_edp_lobf_debug_set(void *data, u64 val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(i915_edp_lobf_debug_fops,
-			i915_edp_lobf_debug_get, i915_edp_lobf_debug_set,
+DEFINE_SIMPLE_ATTRIBUTE(i915_lobf_debug_fops,
+			i915_lobf_debug_get, i915_lobf_debug_set,
 			"%llu\n");
 
 void intel_alpm_lobf_debugfs_add(struct intel_connector *connector)
@@ -747,15 +747,22 @@ void intel_alpm_lobf_debugfs_add(struct intel_connector *connector)
 	struct intel_display *display = to_intel_display(connector);
 	struct dentry *root = connector->base.debugfs_entry;
 
-	if (DISPLAY_VER(display) < 20 ||
-	    connector->base.connector_type != DRM_MODE_CONNECTOR_eDP)
+	if (DISPLAY_VER(display) < 20)
+		return;
+
+	if (connector->base.connector_type != DRM_MODE_CONNECTOR_eDP &&
+	    connector->base.connector_type != DRM_MODE_CONNECTOR_DisplayPort)
+		return;
+
+	if (connector->mst.dp ||
+	    !intel_alpm_source_supported(intel_attached_dp(connector)))
 		return;
 
-	debugfs_create_file("i915_edp_lobf_debug", 0644, root,
-			    connector, &i915_edp_lobf_debug_fops);
+	debugfs_create_file("i915_lobf_debug", 0644, root,
+			    connector, &i915_lobf_debug_fops);
 
-	debugfs_create_file("i915_edp_lobf_info", 0444, root,
-			    connector, &i915_edp_lobf_info_fops);
+	debugfs_create_file("i915_lobf_info", 0444, root,
+			    connector, &i915_lobf_info_fops);
 }
 
 void intel_alpm_disable(struct intel_dp *intel_dp)
-- 
2.43.0


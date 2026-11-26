Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61F1606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SdEozRov
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4080112191;
	Thu, 26 Nov 2026 08:40:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0954112192;
 Thu, 26 Nov 2026 08:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795682453; x=1827218453;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=jjSHgv5NHgALkJrUaM+q0r5mZroFNaoonWNmAte8yYw=;
 b=SdEozRovRXIbCjQaIDOXqfPuUqxHe5Q1YFNiI4r2z3Z6UyCxfzntIgLZ
 tDB5zaOkzWK2cgPOf/kMmieDbHU/IdgLQzBrZkIt3lNvwzUMOFUCLb65/
 s/xIFhzxFE7jNxcJ26QfyjpZdWrZGgcpQhE+zUUxSgmqqGh4StcHpmq6O
 p1TE5rBIlhcLZsh/R+sK8O5+wZs8cQlNI2YvlsTA5WuAENnhd5Ws/pwmc
 V1gwbTfhZW79IRwm11T7FnT91LdKUJPsz6Awy2nikTzgoj8YZrOGYFIgr
 PXHkPqppg6eXqmnL9ndq1zsluxvs7haYVnCh7nBfFUpD6J/6ksChA92Z4 w==;
X-CSE-ConnectionGUID: jEZPZfEARBOkohh262bMGg==
X-CSE-MsgGUID: z8ZQVFlIT5eLVSy8newewA==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4488607"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4488607"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 00:40:46 -0800
X-CSE-ConnectionGUID: bNVEPH2ESSK9EW7oBYiaYA==
X-CSE-MsgGUID: 624jf+zaTPu2rGatm9aXxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12125760"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by orviesa007.jf.intel.com with ESMTP; 26 Nov 2026 00:40:43 -0800
From: Arun R Murthy <arun.r.murthy@intel.com>
Date: Thu, 26 Nov 2026 14:05:08 +0530
Subject: [PATCH v6 13/13] drm/i915/dp: Enable the DP symbol TG
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vlk-64036-dp-symbol-tg-v6-13-835a4f5c0a12@intel.com>
References: <20261126-vlk-64036-dp-symbol-tg-v6-0-835a4f5c0a12@intel.com>
In-Reply-To: <20261126-vlk-64036-dp-symbol-tg-v6-0-835a4f5c0a12@intel.com>
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

Enable symbol TG for 8b/10b MST and 128b/132b SST/MST on the platforms
supporting it.

v6: dropped debugfs knob (Jani N)

Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_core.h  |  5 ++++
 .../gpu/drm/i915/display/intel_display_debugfs.c   |  3 ++
 drivers/gpu/drm/i915/display/intel_dp.c            | 32 ++++++++++------------
 3 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_core.h b/drivers/gpu/drm/i915/display/intel_display_core.h
index c80b4a2f74f9e92f5623b7fc736bcff507240800..eaf8de1ba885c234eea01983d775fedbd23411ca 100644
--- a/drivers/gpu/drm/i915/display/intel_display_core.h
+++ b/drivers/gpu/drm/i915/display/intel_display_core.h
@@ -397,6 +397,11 @@ struct intel_display {
 		u32 mmio_base;
 	} dsi;
 
+	struct {
+		/* Debugfs knob: use the pixel based DP timing generator instead */
+		bool disable_symbol_tg;
+	} dp;
+
 	struct {
 		const struct dram_info *info;
 	} dram;
diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index 3e302f23f24749ed02fee6e50aba85d350550345..bb5f78ec4433adc66f865ec6fdc5302e3013255b 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -841,6 +841,9 @@ void intel_display_debugfs_register(struct intel_display *display)
 	debugfs_create_file("i915_fifo_underrun_reset", 0644, debugfs_root,
 			    display, &i915_fifo_underrun_reset_ops);
 
+	debugfs_create_bool("i915_dp_disable_symbol_tg", 0644, debugfs_root,
+			    &display->dp.disable_symbol_tg);
+
 	drm_debugfs_create_files(intel_display_debugfs_list,
 				 ARRAY_SIZE(intel_display_debugfs_list),
 				 debugfs_root, display->drm->primary);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 217b5d1e082f2bb9ee15773e382c528700671584..aa170f742954000a94c30c6de339cc7810deebcc 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1271,13 +1271,13 @@ bool intel_dp_has_dsc(const struct intel_connector *connector)
 }
 
 /*
- * The symbol based timing generator is to be used for 8b/10b MST and 128b/132b
- * SST/MST, but only once all the pieces needed for that are in place, which is
- * done by a later patch.
+ * The symbol based timing generator is used for 8b/10b MST and 128b/132b
+ * SST/MST, unless disabled by the i915_dp_disable_symbol_tg debugfs knob.
  */
 bool intel_dp_use_symbol_tg(struct intel_display *display, bool is_mst, bool is_uhbr)
 {
-	return false;
+	return HAS_DP_SYMBOL_TG(display) && !display->dp.disable_symbol_tg &&
+		(is_mst || is_uhbr);
 }
 
 static int
@@ -4004,7 +4004,7 @@ int intel_dp_compute_symbol_tg(struct intel_dp *intel_dp,
 
 	/* MSO is only used with 8b/10b SST, where the symbol TG isn't used */
 	if (drm_WARN_ON(display->drm, crtc_state->splitter.enable))
-		return 0;
+		return -EINVAL;
 
 	ret = intel_dp_compute_dsc_slices_and_link_bpp(crtc_state, connector,
 						       &dsc_slices, &link_bpp_x16);
@@ -4019,12 +4019,11 @@ int intel_dp_compute_symbol_tg(struct intel_dp *intel_dp,
 	hblank_cycles = cycles.hblank;
 	chunk_cycles = cycles.chunk;
 
-	if (!intel_dp_symbol_tg_cycles_in_range(&cycles)) {
-		drm_dbg_kms(display->drm,
-			    "LL symbol timings out of range (hactive %d, hblank %d, chunk %d), using pixel TG\n",
-			    hactive_cycles, hblank_cycles, chunk_cycles);
-		return 0;
-	}
+	/* The link config search already checked that the timings fit. */
+	if (drm_WARN(display->drm, !intel_dp_symbol_tg_cycles_in_range(&cycles),
+		     "LL symbol timings out of range (hactive %d, hblank %d, chunk %d)\n",
+		     hactive_cycles, hblank_cycles, chunk_cycles))
+		return -EINVAL;
 
 	if (is_uhbr) {
 		ch_num = 1568768;
@@ -4077,12 +4076,11 @@ int intel_dp_compute_symbol_tg(struct intel_dp *intel_dp,
 				     (u64)ch_num * (ssc_num / ssc_gcd),
 				     data_n[ssc]);
 
-		if (intel_dp_cmp_u128(data_m[ssc], data_n[ssc]) > 0) {
-			drm_dbg_kms(display->drm,
-				    "LL symbol data M/N ratio exceeds 1.0 (SSC %s), using pixel TG\n",
-				    str_enabled_disabled(ssc));
-			return 0;
-		}
+		/* The link config search already checked that the stream fits. */
+		if (drm_WARN(display->drm, intel_dp_cmp_u128(data_m[ssc], data_n[ssc]) > 0,
+			     "LL symbol data M/N ratio exceeds 1.0 (SSC %s)\n",
+			     str_enabled_disabled(ssc)))
+			return -EINVAL;
 	}
 
 	tg->enable = true;

-- 
2.25.1


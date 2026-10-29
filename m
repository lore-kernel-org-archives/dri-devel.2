Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416FA606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ljKNXwbf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E50E10FECC;
	Thu, 29 Oct 2026 01:42:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E61AD10E750;
 Thu, 29 Oct 2026 01:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793238142; x=1824774142;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=20Q87JdkKRnvZeyEIj8uc4vpDLD9nS7zji+KjjF3RtI=;
 b=ljKNXwbfGUWx1+fTqVDx95J2NHpoGUE4YsBgauw59b5x5AUvtM6HD9Ke
 LJAg9T+frSSEvyVSkH1ytnZMZ9hnRVUxcpiSZHjeWiUpNpDskc0eQstT7
 eXaMEwcNwZrmCYpwIAzdjKY97leJXhfqqFLsifZvov2cAusK4OIqlPCMt
 pKhF2RT8bHPTnUOQFwQZXeaEjRwtUD6iy2uuojqgTRreRx81UaxG/kPCQ
 6DtlKqgLYMCBzCK/rHwe9+Fyh++Dn763p1y+JZC95RzoVB07WMnzJg+IB
 hiV3lZM6Az5J4w6Hej4ScY4Qo8g63aLwLp2zuFn5/W82Wyr7nIL0/5FhN w==;
X-CSE-ConnectionGUID: gvIrCN0xSZC8u5nPC4W+dA==
X-CSE-MsgGUID: fRozIEojQ/KwqcXwVSEN7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2006013"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="2006013"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 18:42:22 -0700
X-CSE-ConnectionGUID: is2PbkGUSy+fkG+Q1AzIxQ==
X-CSE-MsgGUID: oB4Y9rp1TXSNsYF2SwF9JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="6823197"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO intel.com)
 ([10.245.245.30])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 18:42:20 -0700
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: [RFC 2/5] drm/i915/selftests: Port GT-dependent selftests to work
 with multi-GT (low-hanging fruits part 2)
Date: Thu, 29 Oct 2026 02:41:52 +0100
Message-ID: <20261029014155.55865-3-krzysztof.niemiec@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029014155.55865-1-krzysztof.niemiec@intel.com>
References: <20261029014155.55865-1-krzysztof.niemiec@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some tests aren't passed a GT directly and don't reference them, but run
only under the condition of the GT not being wedged. Update the top-level
selftest functions of these tests to abort when some GT is wedged.

Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
---

I made an assumption here, that if ANY of the GTs are wedged, the test
should abort. It is of course possible to make it so that only if ALL
GTs are wedged, the test should abort. Former is probably safer but if
there's good arguments for the latter I can change it.

 drivers/gpu/drm/i915/gem/selftests/huge_pages.c  |  8 ++++++--
 drivers/gpu/drm/i915/selftests/i915_active.c     |  8 ++++++--
 drivers/gpu/drm/i915/selftests/i915_perf.c       |  8 ++++++--
 drivers/gpu/drm/i915/selftests/i915_request.c    |  8 ++++++--
 .../gpu/drm/i915/selftests/intel_memory_region.c | 16 ++++++++++++----
 5 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
index 44718e728291..a8ae65ddb073 100644
--- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
+++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
@@ -2012,14 +2012,18 @@ int i915_gem_huge_page_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(igt_ppgtt_huge_fill),
 		SUBTEST(igt_ppgtt_64K),
 	};
+	struct intel_gt *gt;
+	unsigned int id;
 
 	if (!HAS_PPGTT(i915)) {
 		pr_info("PPGTT not supported, skipping live-selftests\n");
 		return 0;
 	}
 
-	if (intel_gt_is_wedged(to_gt(i915)))
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (intel_gt_is_wedged(gt))
+			return 0;
+	}
 
 	return i915_live_subtests(tests, i915);
 }
diff --git a/drivers/gpu/drm/i915/selftests/i915_active.c b/drivers/gpu/drm/i915/selftests/i915_active.c
index 9fea2fabeac4..4e1d3ccdf8c6 100644
--- a/drivers/gpu/drm/i915/selftests/i915_active.c
+++ b/drivers/gpu/drm/i915/selftests/i915_active.c
@@ -256,9 +256,13 @@ int i915_active_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(live_active_retire),
 		SUBTEST(live_active_barrier),
 	};
+	struct intel_gt *gt;
+	unsigned int id;
 
-	if (intel_gt_is_wedged(to_gt(i915)))
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (intel_gt_is_wedged(gt))
+			return 0;
+	}
 
 	return i915_subtests(tests, i915);
 }
diff --git a/drivers/gpu/drm/i915/selftests/i915_perf.c b/drivers/gpu/drm/i915/selftests/i915_perf.c
index e9469e27f42a..e64d3b430994 100644
--- a/drivers/gpu/drm/i915/selftests/i915_perf.c
+++ b/drivers/gpu/drm/i915/selftests/i915_perf.c
@@ -425,13 +425,17 @@ int i915_perf_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(live_noa_gpr),
 	};
 	struct i915_perf *perf = &i915->perf;
+	struct intel_gt *gt;
+	unsigned int id;
 	int err;
 
 	if (!perf->metrics_kobj || !perf->ops.enable_metric_set)
 		return 0;
 
-	if (intel_gt_is_wedged(to_gt(i915)))
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (intel_gt_is_wedged(gt))
+			return 0;
+	}
 
 	err = alloc_empty_config(&i915->perf);
 	if (err)
diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
index e1a7c454a0a9..6bf8ba474497 100644
--- a/drivers/gpu/drm/i915/selftests/i915_request.c
+++ b/drivers/gpu/drm/i915/selftests/i915_request.c
@@ -3295,9 +3295,13 @@ int i915_request_perf_selftests(struct drm_i915_private *i915)
 		SUBTEST(perf_series_engines),
 		SUBTEST(perf_parallel_engines),
 	};
+	struct intel_gt *gt;
+	unsigned int id;
 
-	if (intel_gt_is_wedged(to_gt(i915)))
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (intel_gt_is_wedged(gt))
+			return 0;
+	}
 
 	return i915_subtests(tests, i915);
 }
diff --git a/drivers/gpu/drm/i915/selftests/intel_memory_region.c b/drivers/gpu/drm/i915/selftests/intel_memory_region.c
index 8307390943a2..20f85db9e3f3 100644
--- a/drivers/gpu/drm/i915/selftests/intel_memory_region.c
+++ b/drivers/gpu/drm/i915/selftests/intel_memory_region.c
@@ -1380,14 +1380,18 @@ int intel_memory_region_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(igt_lmem_write_cpu),
 		SUBTEST(igt_lmem_write_gpu),
 	};
+	struct intel_gt *gt;
+	unsigned int id;
 
 	if (!HAS_LMEM(i915)) {
 		pr_info("device lacks LMEM support, skipping\n");
 		return 0;
 	}
 
-	if (intel_gt_is_wedged(to_gt(i915)))
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (intel_gt_is_wedged(gt))
+			return 0;
+	}
 
 	return i915_live_subtests(tests, i915);
 }
@@ -1397,9 +1401,13 @@ int intel_memory_region_perf_selftests(struct drm_i915_private *i915)
 	static const struct i915_subtest tests[] = {
 		SUBTEST(perf_memcpy),
 	};
+	struct intel_gt *gt;
+	unsigned int id;
 
-	if (intel_gt_is_wedged(to_gt(i915)))
-		return 0;
+	for_each_gt(gt, i915, id) {
+		if (intel_gt_is_wedged(gt))
+			return 0;
+	}
 
 	return i915_live_subtests(tests, i915);
 }
-- 
2.55.0


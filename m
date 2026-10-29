Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D20606A320
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UH/ksQ7z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 675F110FEE7;
	Thu, 29 Oct 2026 01:42:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB5310FEE7;
 Thu, 29 Oct 2026 01:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793238154; x=1824774154;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=erAxQWKLvVURhvSEdWyHJxnwUcJeJ/1Mxr55xxDGwMA=;
 b=UH/ksQ7zVPH6ugvbH1CyauTxkm4xrnQ11jWyyR2R21oWbczaY5NHq8XY
 MvhqBSCTGWH1tWwLq1cWV3U8lidnjuciZJPNMdfXCU03Ct3kLczSziQTD
 dSjU+6t30RcwgqxC9VlR2x4jFET4dk7bbfgeLVazhiIM+y9lNzOO1gRnT
 8ASxye9Qg3d9QdYzARjpjqh4vn/Klm2aiU+qPTE0f27fBnww6YPqk5iIp
 iOanJLhzqf7Zk3NFTXELKGcUWm1fSyer8SqWhTm0WnTYCKn7HUeLyHWYs
 AARguk2lSpqM8tIkWjbfIIyc5r7STO9LI0EZoa4FRs00gjVb2XErgq097 w==;
X-CSE-ConnectionGUID: Hwbxe1CeRJiZb0Vb2xg+hQ==
X-CSE-MsgGUID: RDTEf2BpQXGVMOVM4uuypw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2006039"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="2006039"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 18:42:34 -0700
X-CSE-ConnectionGUID: nVV8OuktQDi8rl6nvQ0D/w==
X-CSE-MsgGUID: SX9cRXlkSM6wWTmhGZ1gtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="6823214"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO intel.com)
 ([10.245.245.30])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 18:42:31 -0700
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: [RFC 4/5] drm/i915/sefltests: Port i915_gem_context.c selftest file
 to multi-gt
Date: Thu, 29 Oct 2026 02:41:54 +0100
Message-ID: <20261029014155.55865-5-krzysztof.niemiec@intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

the __igt_ctx_sseu() function iterates over the engines in a system, but
only calls igt_global_reset_lock() on to_gt() (so GT0). Move the lock
deeper into the function such that the call is done for a specific
gt depending on which engine is currently being selected via engine->gt.

Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
---

This is opinionated as stated in the cover letter, the alternative way
to run this is to pass a GT to the test itself, and run it in a
for_each_gt loop, and then skip on engines that don't belong to the
currently processed GT.

Also same assumption as in patch 2, using essentially || instead of &&
for checking wedge.

 .../drm/i915/gem/selftests/i915_gem_context.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
index 9d405098f9e7..afa170a4c740 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
@@ -1249,9 +1249,6 @@ __igt_ctx_sseu(struct drm_i915_private *i915,
 	if (GRAPHICS_VER(i915) < 9)
 		return 0;
 
-	if (flags & TEST_RESET)
-		igt_global_reset_lock(to_gt(i915));
-
 	obj = i915_gem_object_create_internal(i915, PAGE_SIZE);
 	if (IS_ERR(obj)) {
 		ret = PTR_ERR(obj);
@@ -1295,6 +1292,9 @@ __igt_ctx_sseu(struct drm_i915_private *i915,
 			goto out_put;
 		}
 
+		if (flags & TEST_RESET)
+			igt_global_reset_lock(engine->gt);
+
 		ret = intel_context_pin(ce);
 		if (ret)
 			goto out_ce;
@@ -1323,6 +1323,8 @@ __igt_ctx_sseu(struct drm_i915_private *i915,
 		intel_context_unpin(ce);
 out_ce:
 		intel_context_put(ce);
+		if (flags & TEST_RESET)
+			igt_global_reset_unlock(engine->gt);
 	} while (!ret);
 
 	if (igt_flush_test(i915))
@@ -1332,9 +1334,6 @@ __igt_ctx_sseu(struct drm_i915_private *i915,
 	i915_gem_object_put(obj);
 
 out_unlock:
-	if (flags & TEST_RESET)
-		igt_global_reset_unlock(to_gt(i915));
-
 	if (ret)
 		pr_err("%s: Failed with %d!\n", name, ret);
 
@@ -1908,9 +1907,13 @@ int i915_gem_context_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(igt_shared_ctx_exec),
 		SUBTEST(igt_vm_isolation),
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


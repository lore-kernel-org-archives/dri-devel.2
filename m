Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0561606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jlrK3Pzd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03B0110FEDA;
	Thu, 29 Oct 2026 01:42:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 098F110E750;
 Thu, 29 Oct 2026 01:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793238148; x=1824774148;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W8e+lrjsOtIm8x6nggEevj8naZ3EJZq0qoNTruoYzyM=;
 b=jlrK3PzdxcS8edoPmu8C8cEI4xanZJVPAm5H35qEg/OrYlJAg8HIGf4w
 HqwQlHQcar4/TTsCKhRC+kE0EugQ1z4TtvI60RvYIVBT+nttuscTMASq4
 ti6So9vmnipeIt5G+szIiudZVchk3dSLHPY8TTB7LAWL657l8be5Kb7wD
 QE2w11mjDZrumnJRcWz4Ydyu2C9l6emrGdHZp0qGaj251DewCnejJlvtB
 u7DZexf1/xBhig9MqkFSP8KPnRb7H9m1fVNorUsB62f+VS7GVCZQ3789i
 ksiIXs6WQ1JFDjWSq8dgicI25p8i1IYl8e3m55/6t38oQrFYnPrecqABH A==;
X-CSE-ConnectionGUID: dULgdK0eQyu9EcJ/ZtRfnw==
X-CSE-MsgGUID: muvzABU3Q5OuhFWUMR02+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2006026"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="2006026"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 18:42:28 -0700
X-CSE-ConnectionGUID: KPqHRhMFS42UkFvRmQa+nA==
X-CSE-MsgGUID: yT0DO2dmSxSD+QIMyVfHtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="6823206"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO intel.com)
 ([10.245.245.30])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 18:42:26 -0700
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: [RFC 3/5] drm/i915/selftests: Port i915_gem_gtt.c selftest file to
 multi-gt
Date: Thu, 29 Oct 2026 02:41:53 +0100
Message-ID: <20261029014155.55865-4-krzysztof.niemiec@intel.com>
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

Port the gtt selftets to test multiple GTs instead of just GT0. Mock
device tests stay on the to_gt() macro, as the mock device is hard-coded
to have a single gt at the point of writing the patch.

Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
---

Another assumption I made: we don't know anything a priori about any
shared GGTTs. This in truth is not really the case cause the multi-GT
platforms we do have in i915 do share a GGTT across GTs (namely GT_MEDIA
gets assigned GT0's GGTT). So the assumption can be strengthened at the
loss of genericity.

 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 32 +++++++++++++------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
index e6bd06774816..a2b8c1753daf 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -152,7 +152,8 @@ fake_dma_object(struct drm_i915_private *i915, u64 size)
 
 static int igt_ppgtt_alloc(void *arg)
 {
-	struct drm_i915_private *dev_priv = arg;
+	struct intel_gt *gt = arg;
+	struct drm_i915_private *dev_priv = gt->i915;
 	struct i915_ppgtt *ppgtt;
 	struct i915_gem_ww_ctx ww;
 	u64 size, last, limit;
@@ -163,7 +164,7 @@ static int igt_ppgtt_alloc(void *arg)
 	if (!HAS_PPGTT(dev_priv))
 		return 0;
 
-	ppgtt = i915_ppgtt_create(to_gt(dev_priv), 0);
+	ppgtt = i915_ppgtt_create(gt, 0);
 	if (IS_ERR(ppgtt))
 		return PTR_ERR(ppgtt);
 
@@ -1194,11 +1195,12 @@ static int misaligned_pin(struct i915_address_space *vm,
 	return 0;
 }
 
-static int exercise_ppgtt(struct drm_i915_private *dev_priv,
+static int exercise_ppgtt(struct intel_gt *gt,
 			  int (*func)(struct i915_address_space *vm,
 				      u64 hole_start, u64 hole_end,
 				      unsigned long end_time))
 {
+	struct drm_i915_private *dev_priv = gt->i915;
 	struct i915_ppgtt *ppgtt;
 	IGT_TIMEOUT(end_time);
 	struct file *file;
@@ -1211,7 +1213,7 @@ static int exercise_ppgtt(struct drm_i915_private *dev_priv,
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ppgtt = i915_ppgtt_create(to_gt(dev_priv), 0);
+	ppgtt = i915_ppgtt_create(gt, 0);
 	if (IS_ERR(ppgtt)) {
 		err = PTR_ERR(ppgtt);
 		goto out_free;
@@ -1280,12 +1282,12 @@ static int sort_holes(void *priv, const struct list_head *A,
 		return 1;
 }
 
-static int exercise_ggtt(struct drm_i915_private *i915,
+static int exercise_ggtt(struct intel_gt *gt,
 			 int (*func)(struct i915_address_space *vm,
 				     u64 hole_start, u64 hole_end,
 				     unsigned long end_time))
 {
-	struct i915_ggtt *ggtt = to_gt(i915)->ggtt;
+	struct i915_ggtt *ggtt = gt->ggtt;
 	u64 hole_start, hole_end, last = 0;
 	struct drm_mm_node *node;
 	IGT_TIMEOUT(end_time);
@@ -1349,8 +1351,9 @@ static int igt_ggtt_page(void *arg)
 {
 	const unsigned int count = PAGE_SIZE/sizeof(u32);
 	I915_RND_STATE(prng);
-	struct drm_i915_private *i915 = arg;
-	struct i915_ggtt *ggtt = to_gt(i915)->ggtt;
+	struct intel_gt *gt = arg;
+	struct drm_i915_private *i915 = gt->i915;
+	struct i915_ggtt *ggtt = gt->ggtt;
 	struct drm_i915_gem_object *obj;
 	intel_wakeref_t wakeref;
 	struct drm_mm_node tmp;
@@ -1976,8 +1979,17 @@ int i915_gem_gtt_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(igt_ggtt_page),
 		SUBTEST(igt_ggtt_misaligned_pin),
 	};
+	struct intel_gt *gt;
+	uint32_t id;
+	int err;
 
-	GEM_BUG_ON(offset_in_page(to_gt(i915)->ggtt->vm.total));
+	for_each_gt(gt, i915, id) {
+		GEM_BUG_ON(offset_in_page(gt->ggtt->vm.total));
 
-	return i915_live_subtests(tests, i915);
+		err = intel_gt_live_subtests(tests, gt);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
-- 
2.55.0


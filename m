Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F83CDE010
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 05:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E11310E313;
	Fri, 26 Jun 2026 05:26:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CBY/Hixc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 738DF10E2EF;
 Fri, 26 Jun 2026 05:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782451570; x=1813987570;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6BkGb7vt73iD+1MX4LuDu0911A5EIvXWZyidx3fvNCU=;
 b=CBY/Hixchbtzil2wgp3uVNQasZB/EJSibi7KovV+SwXfAEufNNpweUUt
 xmrynJ1DOfcanrjgNGlLy53elk+RweOXHnnJ6H9oAdoEJ7zb+G6pUIyh7
 ND0A0JgkZlBn0TxdMwBAaKbdLLnyRzZBTdUK+qx71iF2vllmMjD0wFQuh
 3m0N7haSF/8Z+IXjuIkim8EIIXtcEqXC26Dyw30eL1e0ruIFPNIXOKwXA
 8UqYN1DST+HymjTC//2xvU6f6kBgQqL0stPK/OgezOiuMiarwylzjNdx4
 5/dbGxzd5JZcmr0ksHTWpybtOXT/hmWYgEnOTrtLSdXF7gZddTEbtgC9q A==;
X-CSE-ConnectionGUID: PekutrYhRX6hKKThWYVqIQ==
X-CSE-MsgGUID: 7L2XMaJoSKazopfBrUUbOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="94730315"
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; d="scan'208";a="94730315"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 22:26:10 -0700
X-CSE-ConnectionGUID: 3OPbp6c0QZqOZLHJBtflfA==
X-CSE-MsgGUID: yqONAcKFSZS+LZ3si+nCTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,225,1774335600"; d="scan'208";a="281334177"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.40])
 by orviesa002.jf.intel.com with ESMTP; 25 Jun 2026 22:26:10 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>, dri-devel@lists.freedesktop.org,
 Shuicheng Lin <shuicheng.lin@intel.com>,
 Matt Roper <matthew.d.roper@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Maciej Plewka <maciej.plewka@intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v8] drm/i915/dg2: Add per-context control for Wa_22013059131
Date: Fri, 26 Jun 2026 05:25:51 +0000
Message-ID: <20260626052551.1327022-1-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
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

Wa_22013059131 sets FORCE_1_SUB_MESSAGE_PER_FRAGMENT in LSC_CHICKEN_BIT_0
at engine init, but this is known to cause GPU hangs in certain workloads.
Add I915_CONTEXT_PARAM_WA_22013059131 so userspace that handles the
workaround itself (e.g. by limiting SLM size) can set it to 1 to let the
kernel know bit 15 programming is not needed for that context.

LSC_CHICKEN_BIT_0 is not context-saved by hardware, so the kernel restores
the correct value on every context switch via the indirect context
batchbuffer to avoid leaking state between contexts. The old unconditional
application of Wa22013059131 in intel_workarounds.c is removed.

v8:
- Clarify in the uAPI comment that setting this parameter only opts out
  of LSC_CHICKEN_BIT_0 bit 15 (FORCE_1_SUB_MESSAGE_PER_FRAGMENT);
  LSC_CHICKEN_BIT_0_UDW MAXREQS_PER_BANK remains unconditionally
  programmed by the kernel as the other part of Wa_22013059131

v7:
- Reject ioctl with -ENODEV on non-DG2-G11 platforms

v6:
- Remove excessive blank lines

v5:
- Remove fix and stable

v4:
- Add a link of the userspace using this API

v3:
- Kernel-internal context will not change workaround settings

Bspec: 54833
Link: https://github.com/intel/compute-runtime/pull/919
Cc: dri-devel@lists.freedesktop.org
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Maciej Plewka <maciej.plewka@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Signed-off-by: Jia Yao <jia.yao@intel.com>
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_context.c   | 14 ++++++
 .../gpu/drm/i915/gem/i915_gem_context_types.h |  1 +
 drivers/gpu/drm/i915/gt/intel_context_types.h |  1 +
 drivers/gpu/drm/i915/gt/intel_lrc.c           | 43 ++++++++++++++++++-
 drivers/gpu/drm/i915/gt/intel_workarounds.c   | 10 ++---
 include/uapi/drm/i915_drm.h                   | 15 +++++++
 6 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index 6ac0f23570f3..048393264ede 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -911,6 +911,17 @@ static int set_proto_ctx_param(struct drm_i915_file_private *fpriv,
 			ret = -EINVAL;
 		break;
 
+	case I915_CONTEXT_PARAM_WA_22013059131:
+		if (args->size)
+			ret = -EINVAL;
+		else if (!IS_DG2_G11(i915))
+			ret = -ENODEV;
+		else if (args->value)
+			pc->user_flags |= BIT(UCONTEXT_WA_22013059131);
+		else
+			pc->user_flags &= ~BIT(UCONTEXT_WA_22013059131);
+		break;
+
 	case I915_CONTEXT_PARAM_RECOVERABLE:
 		if (args->size)
 			ret = -EINVAL;
@@ -1003,6 +1014,9 @@ static int intel_context_set_gem(struct intel_context *ce,
 	if (test_bit(UCONTEXT_LOW_LATENCY, &ctx->user_flags))
 		__set_bit(CONTEXT_LOW_LATENCY, &ce->flags);
 
+	if (test_bit(UCONTEXT_WA_22013059131, &ctx->user_flags))
+		__set_bit(CONTEXT_WA_22013059131, &ce->flags);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context_types.h b/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
index 0267c924634b..4efc0e758d3b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context_types.h
@@ -338,6 +338,7 @@ struct i915_gem_context {
 #define UCONTEXT_RECOVERABLE		3
 #define UCONTEXT_PERSISTENCE		4
 #define UCONTEXT_LOW_LATENCY		5
+#define UCONTEXT_WA_22013059131		6
 
 	/**
 	 * @flags: small set of booleans
diff --git a/drivers/gpu/drm/i915/gt/intel_context_types.h b/drivers/gpu/drm/i915/gt/intel_context_types.h
index 10070ee4d74c..84011ce7c84d 100644
--- a/drivers/gpu/drm/i915/gt/intel_context_types.h
+++ b/drivers/gpu/drm/i915/gt/intel_context_types.h
@@ -133,6 +133,7 @@ struct intel_context {
 #define CONTEXT_EXITING			13
 #define CONTEXT_LOW_LATENCY		14
 #define CONTEXT_OWN_STATE		15
+#define CONTEXT_WA_22013059131		16
 
 	struct {
 		u64 timeout_us;
diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/gt/intel_lrc.c
index 147d22907960..13344ebb847e 100644
--- a/drivers/gpu/drm/i915/gt/intel_lrc.c
+++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
@@ -1348,6 +1348,37 @@ gen12_invalidate_state_cache(u32 *cs)
 	return cs;
 }
 
+static u32 *
+dg2_g11_emit_wa_22013059131(const struct intel_context *ce, u32 *cs)
+{
+	/*
+	 * While re-writing LSC_CHICKEN_BIT_0 for Wa_22013059131, the
+	 * other bits of the register will also get overwritten.  The
+	 * hardware default for all other bits is 0, but any workarounds
+	 * that adjust the other bits in the lower dword of the register
+	 * also need to be re-applied here.  At the moment that's just
+	 * Wa_22014226127, which is always set for DG2-G11 platforms.
+	 */
+	u32 val = DISABLE_D8_D16_COASLESCE;
+
+	/*
+	 * Wa_22013059131: only set FORCE_1_SUB_MESSAGE_PER_FRAGMENT for
+	 * userspace contexts that have not opted out.  Kernel-internal
+	 * contexts (gem_context == NULL) never run shader workloads that
+	 * require this workaround, so skip them unconditionally.
+	 */
+	if (rcu_access_pointer(ce->gem_context) &&
+	    !test_bit(CONTEXT_WA_22013059131, &ce->flags)) {
+		val |= FORCE_1_SUB_MESSAGE_PER_FRAGMENT;
+	}
+
+	*cs++ = MI_LOAD_REGISTER_IMM(1);
+	*cs++ = i915_mmio_reg_offset(LSC_CHICKEN_BIT_0);
+	*cs++ = val;
+
+	return cs;
+}
+
 static u32 *
 gen12_emit_indirect_ctx_rcs(const struct intel_context *ce, u32 *cs)
 {
@@ -1371,6 +1402,10 @@ gen12_emit_indirect_ctx_rcs(const struct intel_context *ce, u32 *cs)
 	    IS_DG2(ce->engine->i915))
 		cs = dg2_emit_draw_watermark_setting(cs);
 
+	/* Wa_22013059131:dg2 */
+	if (IS_DG2_G11(ce->engine->i915))
+		cs = dg2_g11_emit_wa_22013059131(ce, cs);
+
 	return cs;
 }
 
@@ -1387,7 +1422,13 @@ gen12_emit_indirect_ctx_xcs(const struct intel_context *ce, u32 *cs)
 						    PIPE_CONTROL_INSTRUCTION_CACHE_INVALIDATE,
 						    0);
 
-	return gen12_emit_aux_table_inv(ce->engine, cs);
+	cs = gen12_emit_aux_table_inv(ce->engine, cs);
+
+	/* Wa_22013059131:dg2 */
+	if (IS_DG2_G11(ce->engine->i915))
+		cs = dg2_g11_emit_wa_22013059131(ce, cs);
+
+	return cs;
 }
 
 static u32 *xehp_emit_fastcolor_blt_wabb(const struct intel_context *ce, u32 *cs)
diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
index 24ea5d8d529c..ef6eea3ab597 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
@@ -2840,7 +2840,11 @@ general_render_compute_wa_init(struct intel_engine_cs *engine, struct i915_wa_li
 	if (IS_GFX_GT_IP_STEP(gt, IP_VER(12, 70), STEP_A0, STEP_B0) ||
 	    IS_GFX_GT_IP_STEP(gt, IP_VER(12, 71), STEP_A0, STEP_B0) ||
 	    IS_DG2(i915)) {
-		/* Wa_22014226127 */
+		/*
+		 * Wa_22014226127: Note that this workaround also needs to be
+		 * re-applied in intel_lrc.c when LSC_CHICKEN_BIT_0 is
+		 * re-written for Wa_22013059131.
+		 */
 		wa_mcr_write_or(wal, LSC_CHICKEN_BIT_0, DISABLE_D8_D16_COASLESCE);
 	}
 
@@ -2867,10 +2871,6 @@ general_render_compute_wa_init(struct intel_engine_cs *engine, struct i915_wa_li
 				     MAXREQS_PER_BANK,
 				     REG_FIELD_PREP(MAXREQS_PER_BANK, 2));
 
-		/* Wa_22013059131:dg2 */
-		wa_mcr_write_or(wal, LSC_CHICKEN_BIT_0,
-				FORCE_1_SUB_MESSAGE_PER_FRAGMENT);
-
 		/*
 		 * Wa_22012654132
 		 *
diff --git a/include/uapi/drm/i915_drm.h b/include/uapi/drm/i915_drm.h
index 535cb68fdb5c..dc7e143536ef 100644
--- a/include/uapi/drm/i915_drm.h
+++ b/include/uapi/drm/i915_drm.h
@@ -2172,6 +2172,21 @@ struct drm_i915_gem_context_param {
  * Note that this is a debug API not available on production kernel builds.
  */
 #define I915_CONTEXT_PARAM_CONTEXT_IMAGE	0xf
+
+/*
+ * I915_CONTEXT_PARAM_WA_22013059131:
+ *
+ * Default value 0 means the kernel sets LSC_CHICKEN_BIT_0 bit 15
+ * (FORCE_1_SUB_MESSAGE_PER_FRAGMENT) for this context as part of
+ * Wa_22013059131.  Set to 1 to inform the kernel that userspace is
+ * handling the SLM contention workaround itself (e.g. by limiting SLM
+ * size), so bit 15 programming is not needed for this context.
+ *
+ * Note: LSC_CHICKEN_BIT_0_UDW MAXREQS_PER_BANK (bits 39:37) is the
+ * other part of Wa_22013059131 and remains unconditionally programmed
+ * by the kernel regardless of this setting.  DG2-G11 only.
+ */
+#define I915_CONTEXT_PARAM_WA_22013059131	0x10
 /* Must be kept compact -- no holes and well documented */
 
 	/** @value: Context parameter value to be set or queried */
-- 
2.43.0


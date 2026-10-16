Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A1FCC6B2D
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 03:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B56F10EC52;
	Fri, 16 Oct 2026 03:31:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C79BD10E3F9;
 Fri, 16 Oct 2026 03:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792121490; x=1823657490;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xetyEjynhVCN5hDqix5XAUHGHDRZL1gWVRExB71wEF0=;
 b=YBqfFUVW7FdSVDrvBX6l2ilFGRnK9/wFB8hdR6pHanQUfm3otF9++TAQ
 NDnx73bGWsqEklYxxS/xGlC5Alx4c3jnQdoLWmTLd5uYX76TeQyKkWq5C
 kwqCg3mFQX1FMl+2uRL/sGgN0XjyKhMHHtuJblDcMjcKAt9TFLOPcgm8x
 vyevwcesp8HHU7MUmonUx3PKcdwfsyLXFQzl933RivY0DWzdg/o0LMHVV
 Kwv+/9nI0QPWYpzyL69g2FfxK4ifnjgeqlr33XQkdIaFls91NFMSNRnhT
 yPErxAAxvYXEVzPZMpVaTS0QfrivWVUcVBLUC38G4GX+yImK6QaVxPjZC w==;
X-CSE-ConnectionGUID: +P7NMMWRRs2RE4vekZvb6g==
X-CSE-MsgGUID: Zd4H6r7LRtqNZs94mP8yWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="894683"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="894683"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 20:31:11 -0700
X-CSE-ConnectionGUID: 3vo0JgA7Ru+ptPxWNJDlPA==
X-CSE-MsgGUID: YNKXWVIdQUKpVlvl++nK4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2274730"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.38])
 by orviesa010.jf.intel.com with ESMTP; 15 Oct 2026 20:31:10 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>, dri-devel@lists.freedesktop.org,
 Shuicheng Lin <shuicheng.lin@intel.com>,
 Matt Roper <matthew.d.roper@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Maciej Plewka <maciej.plewka@intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v13] drm/i915/dg2: Add per-client control for Wa_22013059131
Date: Fri, 16 Oct 2026 03:31:02 +0000
Message-ID: <20261016033102.529239-1-jia.yao@intel.com>
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
kernel know bit 15 programming is not needed. The register is not
context-saved by hardware, so the value is programmed on context switch
via the indirect context batchbuffer, and the old unconditional write in
intel_workarounds.c is removed.

LSC_CHICKEN_BIT_0 is shared by the RCS and CCS engines, not per-context
state, and GuC only runs RCS and CCS concurrently when they share an
address space, i.e. belong to the same DRM client. Tracking the opt-out
per client is therefore both necessary and sufficient to avoid the race.
The value is latched once, by whichever comes first between an explicit
CONTEXT_CREATE_EXT_SETPARAM and the first context of the client being
submitted, and a later request for the opposite value gets -EINVAL; this
covers the default context (id 0) and needs no new ioctl. The client is
the unit of consistency, not the register's true isolation boundary:
unrelated clients can still override each other on RCS and CCS, which is
unchanged from current behaviour.

v13:
- Reject any value other than 0 or 1 with -EINVAL, instead of silently
  treating any non-zero value the same as 1, so other values remain
  available to give explicit meaning to in the future (Matt)
- Drop the v11 ctx_setparam() support for
  I915_CONTEXT_PARAM_WA_22013059131 added by Sashiko for context 0
  coverage. The parameter is creation-time only and current
  compute-runtime usage relies solely on CONTEXT_CREATE_EXT_SETPARAM.
  Retain getparam() support. (Matt)
- Rename I915_WA_22013059131_{UNSET,KERNEL,USERSPACE} to
  I915_WA_22013059131_CLIENT_{UNSET,KERNEL,USERSPACE} to distinguish them
  from the CONTEXT_WA_22013059131_APPLY context flag (Matt)

v12:
- Don't dereference ce->gem_context / ctx->client from lrc_update_regs(),
  which also runs from reset paths (guc_reset_state(), lrc_reset()) where
  the ctx lifetime is not guaranteed by the caller. Latch the decision
  once into CONTEXT_WA_22013059131_APPLY from
  intel_context_alloc_state(), where the pinner holds a ctx reference,
  and only sample that bit afterwards (Sashiko)

v11:
- Add the missing I915_CONTEXT_PARAM_WA_22013059131 cases to
  ctx_setparam() and i915_gem_context_getparam_ioctl(), so the
  parameter can also be set on an already-finalized context (e.g. the
  default context, id 0) and queried back, not just set at proto-context
  creation time (Sashiko)

v10:
- Move the opt-out from intel_context to i915_drm_client, latched once
  per client (by explicit setparam or first LRC init) instead of tracked
  per intel_context, so all contexts of a client - including the
  default context - always agree and conflicting requests get -EINVAL
  (Joonas, Sashiko, Matt)
- Note that GuC's requirement for RCS/CCS contexts to share an address
  space before running concurrently is what makes client-wide latching
  sufficient to prevent the race (Matt)
- Document that this requirement applies to the whole fd, so userspace
  sharing an fd across an interop boundary must coordinate ordering
  itself

v9:
- Restrict Wa_22013059131 to compute engine only in
  gen12_emit_indirect_ctx_xcs() (Sashiko)

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
---
 drivers/gpu/drm/i915/gem/i915_gem_context.c   | 53 +++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_context.c       |  2 +
 drivers/gpu/drm/i915/gt/intel_context_types.h |  1 +
 drivers/gpu/drm/i915/gt/intel_lrc.c           | 59 ++++++++++++++++++-
 drivers/gpu/drm/i915/gt/intel_lrc.h           |  3 +
 drivers/gpu/drm/i915/gt/intel_workarounds.c   | 10 ++--
 drivers/gpu/drm/i915/i915_drm_client.h        | 57 ++++++++++++++++++
 include/uapi/drm/i915_drm.h                   | 25 ++++++++
 8 files changed, 204 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index 6ac0f23570f3..c2d70fbde7d3 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -874,6 +874,39 @@ static int set_proto_ctx_sseu(struct drm_i915_file_private *fpriv,
 	return 0;
 }
 
+/*
+ * Wa_22013059131:dg2 - Latch who owns LSC_CHICKEN_BIT_0 bit 15 for every
+ * context of @fpriv.  The register is shared by the RCS and CCS engines, so
+ * the first context to express a preference decides for the whole client
+ * and any later context asking for the opposite is rejected, rather than
+ * letting the two race over the register at context-switch time.
+ *
+ * The owner is also latched, to the kernel, the first time a context of
+ * the client is pinned (see lrc_latch_wa_22013059131()), so opting out is
+ * only possible while none of the client's RCS/CCS contexts has run yet.
+ */
+static int set_client_wa_22013059131(struct drm_i915_file_private *fpriv,
+				     u64 value)
+{
+	int want;
+
+	/*
+	 * Only 0 and 1 are currently defined; reject anything else now so
+	 * that other values remain available to give explicit meaning to in
+	 * the future, rather than silently treating them as 1 today.
+	 */
+	if (value > 1)
+		return -EINVAL;
+
+	want = value ? I915_WA_22013059131_CLIENT_USERSPACE :
+		      I915_WA_22013059131_CLIENT_KERNEL;
+
+	if (i915_drm_client_latch_wa_22013059131(fpriv->client, want) != want)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int set_proto_ctx_param(struct drm_i915_file_private *fpriv,
 			       struct i915_gem_proto_context *pc,
 			       struct drm_i915_gem_context_param *args)
@@ -911,6 +944,15 @@ static int set_proto_ctx_param(struct drm_i915_file_private *fpriv,
 			ret = -EINVAL;
 		break;
 
+	case I915_CONTEXT_PARAM_WA_22013059131:
+		if (args->size)
+			ret = -EINVAL;
+		else if (!IS_DG2_G11(i915))
+			ret = -ENODEV;
+		else
+			ret = set_client_wa_22013059131(fpriv, args->value);
+		break;
+
 	case I915_CONTEXT_PARAM_RECOVERABLE:
 		if (args->size)
 			ret = -EINVAL;
@@ -2249,6 +2291,7 @@ static int ctx_setparam(struct drm_i915_file_private *fpriv,
 	case I915_CONTEXT_PARAM_RINGSIZE:
 	case I915_CONTEXT_PARAM_VM:
 	case I915_CONTEXT_PARAM_ENGINES:
+	case I915_CONTEXT_PARAM_WA_22013059131: /* creation-time only */
 	default:
 		ret = -EINVAL;
 		break;
@@ -2583,6 +2626,16 @@ int i915_gem_context_getparam_ioctl(struct drm_device *dev, void *data,
 		ret = get_protected(ctx, args);
 		break;
 
+	case I915_CONTEXT_PARAM_WA_22013059131:
+		if (!IS_DG2_G11(ctx->i915)) {
+			ret = -ENODEV;
+		} else {
+			args->size = 0;
+			args->value = atomic_read(&file_priv->client->wa_22013059131_owner) ==
+				      I915_WA_22013059131_CLIENT_USERSPACE;
+		}
+		break;
+
 	case I915_CONTEXT_PARAM_NO_ZEROMAP:
 	case I915_CONTEXT_PARAM_BAN_PERIOD:
 	case I915_CONTEXT_PARAM_ENGINES:
diff --git a/drivers/gpu/drm/i915/gt/intel_context.c b/drivers/gpu/drm/i915/gt/intel_context.c
index b1b8695ba7c9..dc1b69631046 100644
--- a/drivers/gpu/drm/i915/gt/intel_context.c
+++ b/drivers/gpu/drm/i915/gt/intel_context.c
@@ -13,6 +13,7 @@
 #include "intel_context.h"
 #include "intel_engine.h"
 #include "intel_engine_pm.h"
+#include "intel_lrc.h"
 #include "intel_ring.h"
 
 static struct kmem_cache *slab_ce;
@@ -80,6 +81,7 @@ int intel_context_alloc_state(struct intel_context *ce)
 			if (ctx->client)
 				i915_drm_client_add_context_objects(ctx->client,
 								    ce);
+			lrc_latch_wa_22013059131(ce, ctx);
 			i915_gem_context_put(ctx);
 		}
 	}
diff --git a/drivers/gpu/drm/i915/gt/intel_context_types.h b/drivers/gpu/drm/i915/gt/intel_context_types.h
index 10070ee4d74c..928eab48f38d 100644
--- a/drivers/gpu/drm/i915/gt/intel_context_types.h
+++ b/drivers/gpu/drm/i915/gt/intel_context_types.h
@@ -133,6 +133,7 @@ struct intel_context {
 #define CONTEXT_EXITING			13
 #define CONTEXT_LOW_LATENCY		14
 #define CONTEXT_OWN_STATE		15
+#define CONTEXT_WA_22013059131_APPLY	16 /* see lrc_latch_wa_22013059131() */
 
 	struct {
 		u64 timeout_us;
diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/gt/intel_lrc.c
index 147d22907960..c94b7e3d3980 100644
--- a/drivers/gpu/drm/i915/gt/intel_lrc.c
+++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
@@ -5,9 +5,11 @@
 
 #include <drm/drm_print.h>
 
+#include "gem/i915_gem_context.h"
 #include "gem/i915_gem_lmem.h"
 
 #include "gen8_engine_cs.h"
+#include "i915_drm_client.h"
 #include "i915_drv.h"
 #include "i915_perf.h"
 #include "i915_reg.h"
@@ -1348,6 +1350,50 @@ gen12_invalidate_state_cache(u32 *cs)
 	return cs;
 }
 
+/* Latched on first pin while the pinner holds a ctx ref; see intel_context_alloc_state(). */
+void lrc_latch_wa_22013059131(struct intel_context *ce,
+			      struct i915_gem_context *ctx)
+{
+	int owner;
+
+	if (!IS_DG2_G11(ce->engine->i915))
+		return;
+
+	/* Only RCS and CCS ever emit this workaround; don't latch for others. */
+	if (ce->engine->class != RENDER_CLASS && ce->engine->class != COMPUTE_CLASS)
+		return;
+
+	owner = I915_WA_22013059131_CLIENT_KERNEL;
+	if (ctx->client)
+		owner = i915_drm_client_latch_wa_22013059131(ctx->client, owner);
+
+	if (owner != I915_WA_22013059131_CLIENT_USERSPACE)
+		set_bit(CONTEXT_WA_22013059131_APPLY, &ce->flags);
+}
+
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
+	if (test_bit(CONTEXT_WA_22013059131_APPLY, &ce->flags))
+		val |= FORCE_1_SUB_MESSAGE_PER_FRAGMENT;
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
@@ -1371,6 +1417,10 @@ gen12_emit_indirect_ctx_rcs(const struct intel_context *ce, u32 *cs)
 	    IS_DG2(ce->engine->i915))
 		cs = dg2_emit_draw_watermark_setting(cs);
 
+	/* Wa_22013059131:dg2 */
+	if (IS_DG2_G11(ce->engine->i915))
+		cs = dg2_g11_emit_wa_22013059131(ce, cs);
+
 	return cs;
 }
 
@@ -1387,7 +1437,14 @@ gen12_emit_indirect_ctx_xcs(const struct intel_context *ce, u32 *cs)
 						    PIPE_CONTROL_INSTRUCTION_CACHE_INVALIDATE,
 						    0);
 
-	return gen12_emit_aux_table_inv(ce->engine, cs);
+	cs = gen12_emit_aux_table_inv(ce->engine, cs);
+
+	/* Wa_22013059131:dg2 */
+	if (IS_DG2_G11(ce->engine->i915))
+		if (ce->engine->class == COMPUTE_CLASS)
+			cs = dg2_g11_emit_wa_22013059131(ce, cs);
+
+	return cs;
 }
 
 static u32 *xehp_emit_fastcolor_blt_wabb(const struct intel_context *ce, u32 *cs)
diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.h b/drivers/gpu/drm/i915/gt/intel_lrc.h
index 7111bae759f3..cc204ac2d7bf 100644
--- a/drivers/gpu/drm/i915/gt/intel_lrc.h
+++ b/drivers/gpu/drm/i915/gt/intel_lrc.h
@@ -14,6 +14,7 @@
 #include "intel_context.h"
 
 struct drm_i915_gem_object;
+struct i915_gem_context;
 struct i915_gem_ww_ctx;
 struct intel_engine_cs;
 struct intel_ring;
@@ -35,6 +36,8 @@ void lrc_fini_wa_ctx(struct intel_engine_cs *engine);
 
 int lrc_alloc(struct intel_context *ce,
 	      struct intel_engine_cs *engine);
+void lrc_latch_wa_22013059131(struct intel_context *ce,
+			      struct i915_gem_context *ctx);
 void lrc_reset(struct intel_context *ce);
 void lrc_fini(struct intel_context *ce);
 void lrc_destroy(struct kref *kref);
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
diff --git a/drivers/gpu/drm/i915/i915_drm_client.h b/drivers/gpu/drm/i915/i915_drm_client.h
index 2e7a50d16a88..684a66bcd71f 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.h
+++ b/drivers/gpu/drm/i915/i915_drm_client.h
@@ -45,8 +45,65 @@ struct i915_drm_client {
 	 * @past_runtime: Accumulation of pphwsp runtimes from closed contexts.
 	 */
 	atomic64_t past_runtime[I915_LAST_UABI_ENGINE_CLASS + 1];
+
+	/**
+	 * @wa_22013059131_owner: Who programs Wa_22013059131 for this client.
+	 *
+	 * One of the I915_WA_22013059131_* values below.  Latched once, on
+	 * the first of either I915_CONTEXT_PARAM_WA_22013059131 being set or
+	 * a context of this client being pinned for the first time
+	 * (intel_context_alloc_state(), which holds ce->pin_mutex and a
+	 * reference on the context), and read-only afterwards.  See
+	 * i915_drm_client_latch_wa_22013059131().
+	 */
+	atomic_t wa_22013059131_owner;
 };
 
+/*
+ * Wa_22013059131:dg2 - who programs LSC_CHICKEN_BIT_0's
+ * FORCE_1_SUB_MESSAGE_PER_FRAGMENT bit for the contexts of a client.
+ *
+ * LSC_CHICKEN_BIT_0 is shared by the RCS and CCS engines rather than being
+ * part of the saved context image, so it cannot be tracked per context.
+ * GuC only lets RCS and CCS run concurrently when their contexts share an
+ * address space, so tracking this per DRM client (which forces every
+ * address space of that client to agree) is sufficient to avoid contexts
+ * that could actually run at the same time racing over the register.
+ *
+ * I915_WA_22013059131_CLIENT_UNSET must be 0 as the client is zero-initialised.
+ */
+#define I915_WA_22013059131_CLIENT_UNSET	0
+#define I915_WA_22013059131_CLIENT_KERNEL	1
+#define I915_WA_22013059131_CLIENT_USERSPACE	2
+
+/**
+ * i915_drm_client_latch_wa_22013059131 - Latch Wa_22013059131 ownership
+ * @client: the DRM client
+ * @want: I915_WA_22013059131_CLIENT_KERNEL or I915_WA_22013059131_CLIENT_USERSPACE
+ *
+ * Claim @want as the owner of Wa_22013059131 for @client, unless an owner
+ * has already been latched.  Callers that must not change the owner pass
+ * the value they rely on and compare it against the return value.
+ *
+ * The value is latched with a single cmpxchg so that no extra locking is
+ * needed.  This matters because the callers run with different locks held:
+ * GEM_CONTEXT_CREATE_EXT_SETPARAM does not hold &proto_context_lock, while
+ * GEM_CONTEXT_SETPARAM does, and intel_context_alloc_state() holds
+ * ce->pin_mutex instead.
+ *
+ * Returns: the owner in effect for @client, never I915_WA_22013059131_CLIENT_UNSET.
+ */
+static inline int
+i915_drm_client_latch_wa_22013059131(struct i915_drm_client *client, int want)
+{
+	int owner;
+
+	owner = atomic_cmpxchg(&client->wa_22013059131_owner,
+			       I915_WA_22013059131_CLIENT_UNSET, want);
+
+	return owner == I915_WA_22013059131_CLIENT_UNSET ? want : owner;
+}
+
 static inline struct i915_drm_client *
 i915_drm_client_get(struct i915_drm_client *client)
 {
diff --git a/include/uapi/drm/i915_drm.h b/include/uapi/drm/i915_drm.h
index 535cb68fdb5c..94553daec4a2 100644
--- a/include/uapi/drm/i915_drm.h
+++ b/include/uapi/drm/i915_drm.h
@@ -2172,6 +2172,31 @@ struct drm_i915_gem_context_param {
  * Note that this is a debug API not available on production kernel builds.
  */
 #define I915_CONTEXT_PARAM_CONTEXT_IMAGE	0xf
+
+/*
+ * I915_CONTEXT_PARAM_WA_22013059131:
+ *
+ * Default value 0 means the kernel sets LSC_CHICKEN_BIT_0 bit 15
+ * (FORCE_1_SUB_MESSAGE_PER_FRAGMENT) as part of Wa_22013059131.  Set to 1
+ * to inform the kernel that userspace is handling the SLM contention
+ * workaround itself (e.g. by limiting SLM size), so bit 15 programming is
+ * not needed.  Only 0 and 1 are valid; any other value is rejected with
+ * -EINVAL.
+ *
+ * LSC_CHICKEN_BIT_0 is shared by the RCS and CCS engines, so this setting
+ * takes effect for every context of the calling DRM client (the whole file
+ * descriptor), not just the context the ioctl is issued on.  It is latched
+ * once, by whichever comes first: an explicit call to this parameter, or
+ * any context of the client being submitted for the first time.  A later
+ * request for the opposite value fails with -EINVAL.  Userspace that wants
+ * to opt out must therefore do so before submitting any work on this fd,
+ * including via the default context (id 0) created on open().
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


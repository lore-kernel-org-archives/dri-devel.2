Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6FACA5FAD
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC89510E54F;
	Tue, 29 Sep 2026 17:23:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nshZXqVZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7FE610E358;
 Tue, 29 Sep 2026 17:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790702604; x=1822238604;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=auoReVPy5aArenUP45/ye425ExBly8JLU0CEoRgvKzM=;
 b=nshZXqVZ72ZW2/usKoTbo6xhUKovrdGRTqHy5K7OSIy8St0uC1Un14hp
 nuLrDAa1q0d5aPfH90IbyOM8BouAViNjJAuxWe/+TR8nhtccobAQXFMin
 AMT8esqA4jNg4bqYJRmFljSbHw27kDXCmO/XB8/zdMWUkmD820JmnjmYS
 Hf5Y1gHVIQJukD7tMEk4QMD/FAdgJoXWspeh9OsgVf2Mdmw1we1bJy94s
 5gNZrHHF4piP/6T0Q/Q2Jgt1sL9ACqEGWo2t6bVjPUq96UISYnrzD9FwR
 bDpwrCBnNQ2o6qH0TCMO4+Ei3DohhqSprzhV7+wGNihgeCvOmuNEq4LPr Q==;
X-CSE-ConnectionGUID: WsJnEeeNQlKW743yjieksA==
X-CSE-MsgGUID: vn/SKGFbQei6f0ZFDqu2Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="100761091"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="100761091"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 10:23:24 -0700
X-CSE-ConnectionGUID: dn7NXi/sRwGHxZbnQT+6yw==
X-CSE-MsgGUID: dtip0hlWSGeRG3HzYsKsNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="274641597"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.54.85])
 by fmviesa010.fm.intel.com with ESMTP; 29 Sep 2026 10:23:23 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>, dri-devel@lists.freedesktop.org,
 Shuicheng Lin <shuicheng.lin@intel.com>,
 Matt Roper <matthew.d.roper@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Maciej Plewka <maciej.plewka@intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v11] drm/i915/dg2: Add per-client control for Wa_22013059131
Date: Tue, 29 Sep 2026 17:23:20 +0000
Message-ID: <20260929172320.3481617-1-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630223946.2107382-1-jia.yao@intel.com>
References: <20260630223946.2107382-1-jia.yao@intel.com>
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
GEM_CONTEXT_SETPARAM and the first context of the client being
submitted, and a later request for the opposite value gets -EINVAL; this
covers the default context (id 0) and needs no new ioctl. The client is
the unit of consistency, not the register's true isolation boundary:
unrelated clients can still override each other on RCS and CCS, which is
unchanged from current behaviour.

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
 drivers/gpu/drm/i915/gem/i915_gem_context.c | 51 ++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_lrc.c         | 68 ++++++++++++++++++++-
 drivers/gpu/drm/i915/gt/intel_workarounds.c | 10 +--
 drivers/gpu/drm/i915/i915_drm_client.h      | 54 ++++++++++++++++
 include/uapi/drm/i915_drm.h                 | 24 ++++++++
 5 files changed, 201 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index 6ac0f23570f3..f9dc1553af7e 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -874,6 +874,29 @@ static int set_proto_ctx_sseu(struct drm_i915_file_private *fpriv,
 	return 0;
 }
 
+/*
+ * Wa_22013059131:dg2 - Latch who owns LSC_CHICKEN_BIT_0 bit 15 for every
+ * context of @fpriv.  The register is shared by the RCS and CCS engines, so
+ * the first context to express a preference decides for the whole client
+ * and any later context asking for the opposite is rejected, rather than
+ * letting the two race over the register at context-switch time.
+ *
+ * The owner is also latched, to the kernel, by the first context of the
+ * client to initialise its LRC, so opting out is only possible while none
+ * of the client's contexts has been used yet.
+ */
+static int set_client_wa_22013059131(struct drm_i915_file_private *fpriv,
+				     u64 value)
+{
+	int want = value ? I915_WA_22013059131_USERSPACE :
+			   I915_WA_22013059131_KERNEL;
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
@@ -911,6 +934,15 @@ static int set_proto_ctx_param(struct drm_i915_file_private *fpriv,
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
@@ -2243,6 +2275,15 @@ static int ctx_setparam(struct drm_i915_file_private *fpriv,
 		ret = set_context_image(ctx, args);
 		break;
 
+	case I915_CONTEXT_PARAM_WA_22013059131:
+		if (args->size)
+			ret = -EINVAL;
+		else if (!IS_DG2_G11(ctx->i915))
+			ret = -ENODEV;
+		else
+			ret = set_client_wa_22013059131(fpriv, args->value);
+		break;
+
 	case I915_CONTEXT_PARAM_PROTECTED_CONTENT:
 	case I915_CONTEXT_PARAM_NO_ZEROMAP:
 	case I915_CONTEXT_PARAM_BAN_PERIOD:
@@ -2583,6 +2624,16 @@ int i915_gem_context_getparam_ioctl(struct drm_device *dev, void *data,
 		ret = get_protected(ctx, args);
 		break;
 
+	case I915_CONTEXT_PARAM_WA_22013059131:
+		if (!IS_DG2_G11(ctx->i915)) {
+			ret = -ENODEV;
+		} else {
+			args->size = 0;
+			args->value = atomic_read(&file_priv->client->wa_22013059131_owner) ==
+				      I915_WA_22013059131_USERSPACE;
+		}
+		break;
+
 	case I915_CONTEXT_PARAM_NO_ZEROMAP:
 	case I915_CONTEXT_PARAM_BAN_PERIOD:
 	case I915_CONTEXT_PARAM_ENGINES:
diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/gt/intel_lrc.c
index 147d22907960..4cb849629063 100644
--- a/drivers/gpu/drm/i915/gt/intel_lrc.c
+++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
@@ -8,6 +8,7 @@
 #include "gem/i915_gem_lmem.h"
 
 #include "gen8_engine_cs.h"
+#include "i915_drm_client.h"
 #include "i915_drv.h"
 #include "i915_perf.h"
 #include "i915_reg.h"
@@ -1348,6 +1349,60 @@ gen12_invalidate_state_cache(u32 *cs)
 	return cs;
 }
 
+static bool ctx_needs_wa_22013059131(const struct intel_context *ce)
+{
+	struct i915_gem_context *gem_ctx;
+	bool needed = false;
+
+	/*
+	 * Kernel-internal contexts (gem_context == NULL) never run the
+	 * shader workloads that require this workaround.
+	 *
+	 * For userspace contexts the choice belongs to the client, so latch
+	 * the kernel as the owner unless the client has already opted out.
+	 * This batchbuffer is what programs the register, and it is built
+	 * only once per context (see lrc_pin()), so from here on the client
+	 * can no longer opt out and set_client_wa_22013059131() will reject
+	 * any attempt to.
+	 */
+	rcu_read_lock();
+	gem_ctx = rcu_dereference(ce->gem_context);
+	if (gem_ctx) {
+		int owner = I915_WA_22013059131_KERNEL;
+
+		if (gem_ctx->client)
+			owner = i915_drm_client_latch_wa_22013059131(gem_ctx->client, owner);
+
+		needed = owner != I915_WA_22013059131_USERSPACE;
+	}
+	rcu_read_unlock();
+
+	return needed;
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
+	if (ctx_needs_wa_22013059131(ce))
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
@@ -1371,6 +1426,10 @@ gen12_emit_indirect_ctx_rcs(const struct intel_context *ce, u32 *cs)
 	    IS_DG2(ce->engine->i915))
 		cs = dg2_emit_draw_watermark_setting(cs);
 
+	/* Wa_22013059131:dg2 */
+	if (IS_DG2_G11(ce->engine->i915))
+		cs = dg2_g11_emit_wa_22013059131(ce, cs);
+
 	return cs;
 }
 
@@ -1387,7 +1446,14 @@ gen12_emit_indirect_ctx_xcs(const struct intel_context *ce, u32 *cs)
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
index 2e7a50d16a88..fe85cdd597a0 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.h
+++ b/drivers/gpu/drm/i915/i915_drm_client.h
@@ -45,8 +45,62 @@ struct i915_drm_client {
 	 * @past_runtime: Accumulation of pphwsp runtimes from closed contexts.
 	 */
 	atomic64_t past_runtime[I915_LAST_UABI_ENGINE_CLASS + 1];
+
+	/**
+	 * @wa_22013059131_owner: Who programs Wa_22013059131 for this client.
+	 *
+	 * One of the I915_WA_22013059131_* values below.  Latched once, on
+	 * the first of either I915_CONTEXT_PARAM_WA_22013059131 being set or
+	 * a context of this client initialising its LRC, and read-only
+	 * afterwards.  See i915_drm_client_latch_wa_22013059131().
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
+ * I915_WA_22013059131_UNSET must be 0 as the client is zero-initialised.
+ */
+#define I915_WA_22013059131_UNSET	0
+#define I915_WA_22013059131_KERNEL	1
+#define I915_WA_22013059131_USERSPACE	2
+
+/**
+ * i915_drm_client_latch_wa_22013059131 - Latch Wa_22013059131 ownership
+ * @client: the DRM client
+ * @want: I915_WA_22013059131_KERNEL or I915_WA_22013059131_USERSPACE
+ *
+ * Claim @want as the owner of Wa_22013059131 for @client, unless an owner
+ * has already been latched.  Callers that must not change the owner pass
+ * the value they rely on and compare it against the return value.
+ *
+ * The value is latched with a single cmpxchg so that no extra locking is
+ * needed.  This matters because the callers run with different locks held:
+ * GEM_CONTEXT_CREATE_EXT_SETPARAM does not hold &proto_context_lock, while
+ * GEM_CONTEXT_SETPARAM does, and the LRC init path holds neither.
+ *
+ * Returns: the owner in effect for @client, never I915_WA_22013059131_UNSET.
+ */
+static inline int
+i915_drm_client_latch_wa_22013059131(struct i915_drm_client *client, int want)
+{
+	int owner;
+
+	owner = atomic_cmpxchg(&client->wa_22013059131_owner,
+			       I915_WA_22013059131_UNSET, want);
+
+	return owner == I915_WA_22013059131_UNSET ? want : owner;
+}
+
 static inline struct i915_drm_client *
 i915_drm_client_get(struct i915_drm_client *client)
 {
diff --git a/include/uapi/drm/i915_drm.h b/include/uapi/drm/i915_drm.h
index 535cb68fdb5c..a9821e2cc3a2 100644
--- a/include/uapi/drm/i915_drm.h
+++ b/include/uapi/drm/i915_drm.h
@@ -2172,6 +2172,30 @@ struct drm_i915_gem_context_param {
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
+ * not needed.
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


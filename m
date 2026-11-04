Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FF4606A32C
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Vudnw+Ue
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BAED10FCE3;
	Wed,  4 Nov 2026 16:14:19 +0000 (UTC)
X-Greylist: delayed 391 seconds by postgrey-1.36 at gabe;
 Wed, 04 Nov 2026 16:14:12 UTC
Received: from mta0.migadu.com (out-87.mta0.migadu.com [91.218.175.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E63DA10FCF7
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 16:14:12 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=TEEBqA5mys4k9gU+dMidncfMYOQA4DDB7pbBCcoYQ8w=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793808851; v=1; x=1794413651;
 b=Vudnw+UeQcWghBHT6KkQ/NDmRdo/zhFuwtr9DpJ7V2qZ6E9YB+E17/mcS8Yg0HdKXtFIeaiV
 PtJ3WwEy0JVViv7ayNF7EtP2srKbFGi2YRbPalt2sR0dQbyi69hAxHuyucqTiLKH33DEVUcrTCT
 eN1rISlP7NjZ/Sczx23lwvV0=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id ae6b6b9431f873b0;
 Wed, 04 Nov 2026 16:08:04 +0000
X-Mizu-Trace-ID: ae6b6b9431f873b0
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Vineet Gupta <vineet.gupta@linux.dev>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 llvm@lists.linux.dev
Subject: [PATCH 4/4] drm/i915: Avoid -Wconstant-logical-operand with GCC 17
Date: Wed,  4 Nov 2026 08:07:21 -0800
Message-ID: <20261104160722.1637541-5-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104160722.1637541-1-vineet.gupta@linux.dev>
References: <20261104160722.1637541-1-vineet.gupta@linux.dev>
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

GCC 17 adds -Wconstant-logical-operand to -Wall. It warns when an operand
of && or || folds to a constant other than 0 or 1. Three places break the
build with CONFIG_WERROR=y:

  include/drm/intel/reg_bits.h:27:48: error: use of logical '&&' with constant operand '256' [-Werror=constant-logical-operand]
  drivers/gpu/drm/i915/i915_config.c:13:43: error: use of logical '&&' with constant operand '10000' [-Werror=constant-logical-operand]
  drivers/gpu/drm/i915/gem/i915_gem_context.c:999:45: error: use of logical '&&' with constant operand '20000' [-Werror=constant-logical-operand]

clang has the same warning, but it checks only a constant right operand
outside a macro. Here each constant is a left operand, and
IS_POWER_OF_2() is also a macro.

Commit 1a839e016e49 ("drm/i915: remove IS_ACTIVE") moved
CONFIG_DRM_I915_FENCE_TIMEOUT to the left of && to avoid the clang
warning. That does not help with GCC 17.

Compare each constant against 0, as commit aeedd3a82678 ("drm/i915: Avoid
-Wconstant-logical-operand in nsecs_to_jiffies_timeout()") did.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 drivers/gpu/drm/i915/gem/i915_gem_context.c | 2 +-
 drivers/gpu/drm/i915/i915_config.c          | 2 +-
 include/drm/intel/reg_bits.h                | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index c58ffa5a8fa6..1639639dd290 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -996,7 +996,7 @@ static int intel_context_set_gem(struct intel_context *ce,
 	    intel_engine_has_semaphores(ce->engine))
 		__set_bit(CONTEXT_USE_SEMAPHORES, &ce->flags);
 
-	if (CONFIG_DRM_I915_REQUEST_TIMEOUT &&
+	if (CONFIG_DRM_I915_REQUEST_TIMEOUT != 0 &&
 	    ctx->i915->params.request_timeout_ms) {
 		unsigned int timeout_ms = ctx->i915->params.request_timeout_ms;
 
diff --git a/drivers/gpu/drm/i915/i915_config.c b/drivers/gpu/drm/i915/i915_config.c
index 9e13b1be407c..9bbebe0a6a70 100644
--- a/drivers/gpu/drm/i915/i915_config.c
+++ b/drivers/gpu/drm/i915/i915_config.c
@@ -10,7 +10,7 @@
 
 unsigned long i915_fence_context_timeout(u64 context)
 {
-	if (CONFIG_DRM_I915_FENCE_TIMEOUT && context)
+	if (CONFIG_DRM_I915_FENCE_TIMEOUT != 0 && context)
 		return msecs_to_jiffies_timeout(CONFIG_DRM_I915_FENCE_TIMEOUT);
 
 	return 0;
diff --git a/include/drm/intel/reg_bits.h b/include/drm/intel/reg_bits.h
index 2a9066e1d808..f913c3e61f39 100644
--- a/include/drm/intel/reg_bits.h
+++ b/include/drm/intel/reg_bits.h
@@ -24,7 +24,7 @@
 /*
  * Local integer constant expression version of is_power_of_2().
  */
-#define IS_POWER_OF_2(__x)		((__x) && (((__x) & ((__x) - 1)) == 0))
+#define IS_POWER_OF_2(__x)		((__x) != 0 && (((__x) & ((__x) - 1)) == 0))
 
 /**
  * REG_FIELD_PREP8() - Prepare a u8 bitfield value
-- 
2.53.0-Meta


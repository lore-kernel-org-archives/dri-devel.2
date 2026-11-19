Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B610606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bnAsOEVF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D34F610E83A;
	Thu, 19 Nov 2026 17:03:47 +0000 (UTC)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 621AC10F060
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:03:41 +0000 (UTC)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-8615cc92488so2112494a34.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795107820; x=1795712620;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qy2irnGqx6K+sOHQKn/6LJjKtvMxLRwvuq6H13mT8VU=;
 b=bnAsOEVFo6AUpYavG/CAb5VgA+DHtRo363fmK53RUBQVYTGlZea1/BetRN1lWizSbn
 ug8EhI+VtI/5RtJDzTVT90OSTyXxC+EBdl2/PB0Qnaa47Ra/ID3wPY5mP2WUMajT8U4S
 ktBXrqrbBYWVNdXL3AxXqTJ+t0bciSNJ1XXQBLB7a3Nmubm7MR1HH8EvzM7h02ou4CgW
 1APSjq5ez811Z4aXixRcQDnqRN9LvEjUxmtdkLzUZZbZag82XgbHGG5wbmkUDAIYd6Yn
 B8o+nvGUqN06Mwc3JvPuO0DWmMP4+0EJhXEEJhYmT4tHwGWy0V+jzT2n2Utsx59nuUMC
 b1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795107820; x=1795712620;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qy2irnGqx6K+sOHQKn/6LJjKtvMxLRwvuq6H13mT8VU=;
 b=kwCKg49oMBZvijtgRQZyafsBfMIsuelyseToBH2ytpAqV69L41oEHYxkxEdBGkwY3T
 dIMHnDOissTmztBEmlrhg1bwGZJJy9QTNPGVCLstbuZTS/2oO376erSkpEqaHbeA3B2g
 b/Dm1kGoWwJsTJ+UzxCVoeSNpiUX+N7X/+PKVSnxqhbzHbh3YhOa7sEyY1Fu8CtS/ULz
 OiTEd12wYTqZ7TZPaSdeLEkrN5jaZXvclOFOW8z8EtfWogLqRIR1SjAui/DYMqFJX7mU
 4z3NxwQWqj9JCgNR3LE2UdRlBlNYA8p9RAcFM5oR9sqUbVTud02pK+fwR5ofssRcwdZc
 qnYQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFRFEEqAYGUFPNa8BYBQOHQDPuvOtOG6j2W6V1GuAosBbQrRUC+Zq3B9uJoPh92NHe7WCiEJjLz3Wo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9EzSa5UNdJphcsElE+U3bo5sEaaPLqlgUa5WPJKQdM4wl64MFH
 m4GpcUWb2YkuWdX/HhkOqBFUZMsJqhU7BUGCOKWEWUECO1vQyx0+JcP2Jbu77ll4BBHF2li9Zc5
 4llE9jsbx3Q==
X-Received: from iojj7.prod.google.com ([2002:a05:6602:8207:b0:9e3:4940:4cc3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1814:b0:567:ba0d:a565
 with SMTP id 5614622812f47-57a0df4586bmr501975b6e.68.1795107819855; Thu, 19
 Nov 2026 09:03:39 -0800 (PST)
Date: Thu, 19 Nov 2026 09:03:34 -0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119170335.1508386-1-irogers@google.com>
Subject: [PATCH] drm/amd/pm: Fix SMU_FEATURE_BIT_INIT overwriting feature bits
From: Ian Rogers <irogers@google.com>
To: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Elkin Cruz <elkin@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SMU_FEATURE_BIT_INIT(bit) expands to a designated array initializer:

  [bit / BITS_PER_LONG] = (1UL << (bit % BITS_PER_LONG))

In C, listing multiple designated initializers for the same array index
within an initializer list overwrites the previous value for that index
instead of ORing the bits together. Because amdgpu's Makefile passes
-Wno-override-init, these collisions went unnoticed at build time.

Across all 17 *_dpm_features tables in swsmu, every DPM feature bit in
each unsigned long word except the last one listed was silently dropped
from the static bitmap (for example, 10 of 11 feature bits in
smu_v14_0_0_dpm_features and smu_v15_0_0_dpm_features were zeroed). As
a result, *_is_dpm_running() only tested at most one feature bit per
word and could falsely report DPM as disabled when other listed DPM
features were active.

Replace SMU_FEATURE_BIT_INIT() with a variadic SMU_FEATURE_BITS_INIT()
macro that ORs the requested feature bits into the two 64-bit halves of
the 128-bit bitmap at compile time (with compile-time range checks
against SMU_FEATURE_MAX) and emits the words via BITMAP_FROM_U64() so
both 64-bit and 32-bit little/big-endian targets are handled properly.
Update all 17 *_dpm_features definitions to use SMU_FEATURE_BITS_INIT().

Found by enabling Clang's -Winitializer-overrides on an x86_64
allyesconfig build, with AI coding assistant help to audit the warning
and prepare the fix. Verified with a standalone C bitmap test and
incremental Clang builds; not runtime-tested on AMD GPU hardware.

Fixes: e37fb0f81838 ("drm/amd/pm: Use feature bits data structure")
Fixes: 7b88453a476c ("drm/amd/pm: Change get_enabled_mask signature")
Fixes: 2beedc3a92b7 ("drm/amd/pm: Add initial support for smu v15_0_8")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 47 +++++++++++++------
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 17 ++++---
 .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   | 11 ++---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 21 ++++-----
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 21 ++++-----
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 23 ++++-----
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 21 ++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 17 +++----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 11 ++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  | 27 +++++------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  | 23 ++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 21 ++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 17 +++----
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 23 ++++-----
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 27 +++++------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 13 +++--
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 27 +++++------
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 13 +++--
 18 files changed, 177 insertions(+), 203 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 9d47d2ab1b49..51c799192f00 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -23,6 +23,9 @@
 #define __AMDGPU_SMU_H__
 
 #include <linux/acpi_amd_wbrf.h>
+#include <linux/args.h>
+#include <linux/bitmap.h>
+#include <linux/build_bug.h>
 #include <linux/units.h>
 
 #include "amdgpu.h"
@@ -499,21 +502,37 @@ struct smu_feature_bits {
 };
 
 /*
- * Helpers for initializing smu_feature_bits statically.
- * Use SMU_FEATURE_BIT_INIT() which automatically handles array indexing:
- *   static const struct smu_feature_bits example = {
- *       .bits = {
- *           SMU_FEATURE_BIT_INIT(5),
- *           SMU_FEATURE_BIT_INIT(10),
- *           SMU_FEATURE_BIT_INIT(65),
- *           SMU_FEATURE_BIT_INIT(100)
- *       }
- *   };
+ * Helpers for initializing smu_feature_bits statically:
+ *   static const struct smu_feature_bits example =
+ *       SMU_FEATURE_BITS_INIT(5, 10, 65, 100);
  */
-#define SMU_FEATURE_BITS_ELEM(bit) ((bit) / BITS_PER_LONG)
-#define SMU_FEATURE_BITS_POS(bit) ((bit) % BITS_PER_LONG)
-#define SMU_FEATURE_BIT_INIT(bit) \
-	[SMU_FEATURE_BITS_ELEM(bit)] = (1UL << SMU_FEATURE_BITS_POS(bit))
+static_assert(SMU_FEATURE_MAX == 128);
+#define __SMU_FEAT_U64(w, b) \
+	(BUILD_BUG_ON_ZERO((unsigned int)(b) >= SMU_FEATURE_MAX) + \
+	 (((b) / 64 == (w)) ? BIT_ULL((b) % 64) : 0ULL))
+#define __SMU_FEAT_OR_1(w, b)		__SMU_FEAT_U64(w, b)
+#define __SMU_FEAT_OR_2(w, b, ...)	(__SMU_FEAT_U64(w, b) | __SMU_FEAT_OR_1(w, __VA_ARGS__))
+#define __SMU_FEAT_OR_3(w, b, ...)	(__SMU_FEAT_U64(w, b) | __SMU_FEAT_OR_2(w, __VA_ARGS__))
+#define __SMU_FEAT_OR_4(w, b, ...)	(__SMU_FEAT_U64(w, b) | __SMU_FEAT_OR_3(w, __VA_ARGS__))
+#define __SMU_FEAT_OR_5(w, b, ...)	(__SMU_FEAT_U64(w, b) | __SMU_FEAT_OR_4(w, __VA_ARGS__))
+#define __SMU_FEAT_OR_6(w, b, ...)	(__SMU_FEAT_U64(w, b) | __SMU_FEAT_OR_5(w, __VA_ARGS__))
+#define __SMU_FEAT_OR_7(w, b, ...)	(__SMU_FEAT_U64(w, b) | __SMU_FEAT_OR_6(w, __VA_ARGS__))
+#define __SMU_FEAT_OR_8(w, b, ...)	(__SMU_FEAT_U64(w, b) | __SMU_FEAT_OR_7(w, __VA_ARGS__))
+#define __SMU_FEAT_OR_9(w, b, ...)	(__SMU_FEAT_U64(w, b) | __SMU_FEAT_OR_8(w, __VA_ARGS__))
+#define __SMU_FEAT_OR_10(w, b, ...)	(__SMU_FEAT_U64(w, b) | __SMU_FEAT_OR_9(w, __VA_ARGS__))
+#define __SMU_FEAT_OR_11(w, b, ...)	(__SMU_FEAT_U64(w, b) | __SMU_FEAT_OR_10(w, __VA_ARGS__))
+#define __SMU_FEAT_OR_12(w, b, ...)	(__SMU_FEAT_U64(w, b) | __SMU_FEAT_OR_11(w, __VA_ARGS__))
+#define __SMU_FEAT_OR_13(w, b, ...)	(__SMU_FEAT_U64(w, b) | __SMU_FEAT_OR_12(w, __VA_ARGS__))
+#define __SMU_FEAT_OR_14(w, b, ...)	(__SMU_FEAT_U64(w, b) | __SMU_FEAT_OR_13(w, __VA_ARGS__))
+#define __SMU_FEAT_OR_15(w, b, ...)	(__SMU_FEAT_U64(w, b) | __SMU_FEAT_OR_14(w, __VA_ARGS__))
+#define __SMU_FEAT_WORD(w, ...) \
+	(CONCATENATE(__SMU_FEAT_OR_, COUNT_ARGS(__VA_ARGS__))(w, __VA_ARGS__))
+#define SMU_FEATURE_BITS_INIT(...) { \
+	.bits = { \
+		BITMAP_FROM_U64(__SMU_FEAT_WORD(0, __VA_ARGS__)), \
+		BITMAP_FROM_U64(__SMU_FEAT_WORD(1, __VA_ARGS__)), \
+	} \
+}
 
 enum smu_feature_list {
 	SMU_FEATURE_LIST_SUPPORTED,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index edb0393505ba..770717356780 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -69,15 +69,14 @@
 
 static int arcturus_init_ppt_limits(struct smu_context *smu);
 
-static const struct smu_feature_bits arcturus_dpm_features = {
-	.bits = { SMU_FEATURE_BIT_INIT(FEATURE_DPM_PREFETCHER_BIT),
-		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
-		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_UCLK_BIT),
-		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_SOCCLK_BIT),
-		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_MP0CLK_BIT),
-		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_FCLK_BIT),
-		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_XGMI_BIT) }
-};
+static const struct smu_feature_bits arcturus_dpm_features =
+	SMU_FEATURE_BITS_INIT(FEATURE_DPM_PREFETCHER_BIT,
+			      FEATURE_DPM_GFXCLK_BIT,
+			      FEATURE_DPM_UCLK_BIT,
+			      FEATURE_DPM_SOCCLK_BIT,
+			      FEATURE_DPM_MP0CLK_BIT,
+			      FEATURE_DPM_FCLK_BIT,
+			      FEATURE_DPM_XGMI_BIT);
 
 #define smnPCIE_ESM_CTRL			0x111003D0
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index bb9620666dae..693ae98f7b17 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -60,13 +60,10 @@ static struct gfx_user_settings {
 
 static uint32_t cyan_skillfish_sclk_default;
 
-static const struct smu_feature_bits cyan_skillfish_dpm_features = {
-	.bits = {
-		SMU_FEATURE_BIT_INIT(FEATURE_FCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_SOC_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_GFX_DPM_BIT)
-	}
-};
+static const struct smu_feature_bits cyan_skillfish_dpm_features =
+	SMU_FEATURE_BITS_INIT(FEATURE_FCLK_DPM_BIT,
+			      FEATURE_SOC_DPM_BIT,
+			      FEATURE_GFX_DPM_BIT);
 
 static struct cmn2asic_msg_mapping cyan_skillfish_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			0),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f8ca5eb9adc6..886b4f053d43 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -60,18 +60,15 @@
 
 static int navi10_init_ppt_limits(struct smu_context *smu);
 
-static const struct smu_feature_bits navi10_dpm_features = {
-	.bits = {
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_PREFETCHER_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFX_PACE_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_UCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_SOCCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_MP0CLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_LINK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_DCEFCLK_BIT)
-	}
-};
+static const struct smu_feature_bits navi10_dpm_features =
+	SMU_FEATURE_BITS_INIT(FEATURE_DPM_PREFETCHER_BIT,
+			      FEATURE_DPM_GFXCLK_BIT,
+			      FEATURE_DPM_GFX_PACE_BIT,
+			      FEATURE_DPM_UCLK_BIT,
+			      FEATURE_DPM_SOCCLK_BIT,
+			      FEATURE_DPM_MP0CLK_BIT,
+			      FEATURE_DPM_LINK_BIT,
+			      FEATURE_DPM_DCEFCLK_BIT);
 
 #define SMU_11_0_GFX_BUSY_THRESHOLD 15
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b42897e7c066..12ff3f7468d1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -62,18 +62,15 @@
 
 static int sienna_cichlid_init_ppt_limits(struct smu_context *smu);
 
-static const struct smu_feature_bits sienna_cichlid_dpm_features = {
-	.bits = {
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_PREFETCHER_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_UCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_LINK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_SOCCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_FCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_DCEFCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_MP0CLK_BIT)
-	}
-};
+static const struct smu_feature_bits sienna_cichlid_dpm_features =
+	SMU_FEATURE_BITS_INIT(FEATURE_DPM_PREFETCHER_BIT,
+			      FEATURE_DPM_GFXCLK_BIT,
+			      FEATURE_DPM_UCLK_BIT,
+			      FEATURE_DPM_LINK_BIT,
+			      FEATURE_DPM_SOCCLK_BIT,
+			      FEATURE_DPM_FCLK_BIT,
+			      FEATURE_DPM_DCEFCLK_BIT,
+			      FEATURE_DPM_MP0CLK_BIT);
 
 #define SMU_11_0_7_GFX_BUSY_THRESHOLD 15
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index b38bc49c43dd..09ceed17a83a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -60,19 +60,16 @@
 
 static int vangogh_init_ppt_limits(struct smu_context *smu);
 
-static const struct smu_feature_bits vangogh_dpm_features = {
-	.bits = {
-		SMU_FEATURE_BIT_INIT(FEATURE_CCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_VCN_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_FCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_SOCCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_MP0CLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_LCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_SHUBCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DCFCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_GFX_DPM_BIT)
-	}
-};
+static const struct smu_feature_bits vangogh_dpm_features =
+	SMU_FEATURE_BITS_INIT(FEATURE_CCLK_DPM_BIT,
+			      FEATURE_VCN_DPM_BIT,
+			      FEATURE_FCLK_DPM_BIT,
+			      FEATURE_SOCCLK_DPM_BIT,
+			      FEATURE_MP0CLK_DPM_BIT,
+			      FEATURE_LCLK_DPM_BIT,
+			      FEATURE_SHUBCLK_DPM_BIT,
+			      FEATURE_DCFCLK_DPM_BIT,
+			      FEATURE_GFX_DPM_BIT);
 
 /*
  * SMU support new GFXOFF residency log interface since version 4.63.62.00,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 1b1ffe19d002..771d5e37a064 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -64,18 +64,15 @@
 
 static int aldebaran_init_ppt_limits(struct smu_context *smu);
 
-static const struct smu_feature_bits aldebaran_dpm_features = {
-	.bits = {
-		SMU_FEATURE_BIT_INIT(FEATURE_DATA_CALCULATIONS),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_UCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_SOCCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_FCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_LCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_XGMI_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_VCN_BIT)
-	}
-};
+static const struct smu_feature_bits aldebaran_dpm_features =
+	SMU_FEATURE_BITS_INIT(FEATURE_DATA_CALCULATIONS,
+			      FEATURE_DPM_GFXCLK_BIT,
+			      FEATURE_DPM_UCLK_BIT,
+			      FEATURE_DPM_SOCCLK_BIT,
+			      FEATURE_DPM_FCLK_BIT,
+			      FEATURE_DPM_LCLK_BIT,
+			      FEATURE_DPM_XGMI_BIT,
+			      FEATURE_DPM_VCN_BIT);
 
 #define smnPCIE_ESM_CTRL			0x111003D0
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index e80087e35e19..377ab8ca62fb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -67,16 +67,13 @@ static int
 smu_v13_0_0_upload_overdrive_table(struct smu_context *smu,
 				   OverDriveTableExternal_t *od_table);
 
-static const struct smu_feature_bits smu_v13_0_0_dpm_features = {
-	.bits = {
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_UCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_LINK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_SOCCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_FCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_MP0CLK_BIT)
-	}
-};
+static const struct smu_feature_bits smu_v13_0_0_dpm_features =
+	SMU_FEATURE_BITS_INIT(FEATURE_DPM_GFXCLK_BIT,
+			      FEATURE_DPM_UCLK_BIT,
+			      FEATURE_DPM_LINK_BIT,
+			      FEATURE_DPM_SOCCLK_BIT,
+			      FEATURE_DPM_FCLK_BIT,
+			      FEATURE_DPM_MP0CLK_BIT);
 
 #define MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE	0x4000
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 1691a0be4f7d..de4112cce046 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -60,13 +60,10 @@
 #define SMU_13_0_12_FEA_MAP(smu_feature, smu_13_0_12_feature)                    \
 	[smu_feature] = { 1, (smu_13_0_12_feature) }
 
-static const struct smu_feature_bits smu_v13_0_12_dpm_features = {
-	.bits = {
-		SMU_FEATURE_BIT_INIT(FEATURE_DATA_CALCULATION),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_FCLK)
-	}
-};
+static const struct smu_feature_bits smu_v13_0_12_dpm_features =
+	SMU_FEATURE_BITS_INIT(FEATURE_DATA_CALCULATION,
+			      FEATURE_DPM_GFXCLK,
+			      FEATURE_DPM_FCLK);
 
 #define NUM_JPEG_RINGS_FW	10
 #define NUM_JPEG_RINGS_GPU_METRICS(gpu_metrics) \
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index a9d558f5b739..f893b82ba109 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -56,21 +56,18 @@
 #define SMU_13_0_4_UMD_PSTATE_SOCCLK			938
 #define SMU_13_0_4_UMD_PSTATE_FCLK			1875
 
-static const struct smu_feature_bits smu_v13_0_4_dpm_features = {
-	.bits = {
-		SMU_FEATURE_BIT_INIT(FEATURE_CCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_VCN_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_FCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_SOCCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_MP0CLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_LCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_SHUBCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DCFCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_ISP_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_IPU_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_GFX_DPM_BIT)
-	}
-};
+static const struct smu_feature_bits smu_v13_0_4_dpm_features =
+	SMU_FEATURE_BITS_INIT(FEATURE_CCLK_DPM_BIT,
+			      FEATURE_VCN_DPM_BIT,
+			      FEATURE_FCLK_DPM_BIT,
+			      FEATURE_SOCCLK_DPM_BIT,
+			      FEATURE_MP0CLK_DPM_BIT,
+			      FEATURE_LCLK_DPM_BIT,
+			      FEATURE_SHUBCLK_DPM_BIT,
+			      FEATURE_DCFCLK_DPM_BIT,
+			      FEATURE_ISP_DPM_BIT,
+			      FEATURE_IPU_DPM_BIT,
+			      FEATURE_GFX_DPM_BIT);
 
 static struct cmn2asic_msg_mapping smu_v13_0_4_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			1),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index f95b15af436d..56be6daeb9f8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -51,19 +51,16 @@
 #define mmMP1_C2PMSG_33                                                                                (0xbee261 + 0xb00000 / 4)
 #define mmMP1_C2PMSG_33_BASE_IDX                                                                   0
 
-static const struct smu_feature_bits smu_v13_0_5_dpm_features = {
-	.bits = {
-		SMU_FEATURE_BIT_INIT(FEATURE_CCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_FCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_LCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_GFX_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_VCN_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DCFCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_SOCCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_MP0CLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_SHUBCLK_DPM_BIT)
-	}
-};
+static const struct smu_feature_bits smu_v13_0_5_dpm_features =
+	SMU_FEATURE_BITS_INIT(FEATURE_CCLK_DPM_BIT,
+			      FEATURE_FCLK_DPM_BIT,
+			      FEATURE_LCLK_DPM_BIT,
+			      FEATURE_GFX_DPM_BIT,
+			      FEATURE_VCN_DPM_BIT,
+			      FEATURE_DCFCLK_DPM_BIT,
+			      FEATURE_SOCCLK_DPM_BIT,
+			      FEATURE_MP0CLK_DPM_BIT,
+			      FEATURE_SHUBCLK_DPM_BIT);
 
 static struct cmn2asic_msg_mapping smu_v13_0_5_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			1),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 95e288327e45..560909cee9ed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -78,18 +78,15 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_14.bin");
 
 static int smu_v13_0_6_init_ppt_limits(struct smu_context *smu);
 
-static const struct smu_feature_bits smu_v13_0_6_dpm_features = {
-	.bits = {
-		SMU_FEATURE_BIT_INIT(FEATURE_DATA_CALCULATION),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_UCLK),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_SOCCLK),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_FCLK),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_LCLK),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_XGMI),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_VCN)
-	}
-};
+static const struct smu_feature_bits smu_v13_0_6_dpm_features =
+	SMU_FEATURE_BITS_INIT(FEATURE_DATA_CALCULATION,
+			      FEATURE_DPM_GFXCLK,
+			      FEATURE_DPM_UCLK,
+			      FEATURE_DPM_SOCCLK,
+			      FEATURE_DPM_FCLK,
+			      FEATURE_DPM_LCLK,
+			      FEATURE_DPM_XGMI,
+			      FEATURE_DPM_VCN);
 
 #define smnPCIE_ESM_CTRL 0x93D0
 #define smnPCIE_LC_LINK_WIDTH_CNTL 0x1a340288
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 13e7e33fa0eb..693e3987ccf8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -67,16 +67,13 @@ static int
 smu_v13_0_7_upload_overdrive_table(struct smu_context *smu,
 				   OverDriveTableExternal_t *od_table);
 
-static const struct smu_feature_bits smu_v13_0_7_dpm_features = {
-	.bits = {
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_UCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_LINK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_SOCCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_FCLK_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DPM_MP0CLK_BIT)
-	}
-};
+static const struct smu_feature_bits smu_v13_0_7_dpm_features =
+	SMU_FEATURE_BITS_INIT(FEATURE_DPM_GFXCLK_BIT,
+			      FEATURE_DPM_UCLK_BIT,
+			      FEATURE_DPM_LINK_BIT,
+			      FEATURE_DPM_SOCCLK_BIT,
+			      FEATURE_DPM_FCLK_BIT,
+			      FEATURE_DPM_MP0CLK_BIT);
 
 #define smnMP1_FIRMWARE_FLAGS_SMU_13_0_7   0x3b10028
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index edc3fedca9f8..18f379a13efa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -55,19 +55,16 @@
 #define SMU_13_0_1_UMD_PSTATE_SOCCLK		              678
 #define SMU_13_0_1_UMD_PSTATE_FCLK			          1800
 
-static const struct smu_feature_bits yellow_carp_dpm_features = {
-	.bits = {
-		SMU_FEATURE_BIT_INIT(FEATURE_CCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_VCN_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_FCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_SOCCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_MP0CLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_LCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_SHUBCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DCFCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_GFX_DPM_BIT)
-	}
-};
+static const struct smu_feature_bits yellow_carp_dpm_features =
+	SMU_FEATURE_BITS_INIT(FEATURE_CCLK_DPM_BIT,
+			      FEATURE_VCN_DPM_BIT,
+			      FEATURE_FCLK_DPM_BIT,
+			      FEATURE_SOCCLK_DPM_BIT,
+			      FEATURE_MP0CLK_DPM_BIT,
+			      FEATURE_LCLK_DPM_BIT,
+			      FEATURE_SHUBCLK_DPM_BIT,
+			      FEATURE_DCFCLK_DPM_BIT,
+			      FEATURE_GFX_DPM_BIT);
 
 static struct cmn2asic_msg_mapping yellow_carp_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			1),
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index c83c58d5a2e2..5b4aaf58ac55 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -75,21 +75,18 @@
 #define SMU_14_0_4_UMD_PSTATE_GFXCLK			938
 #define SMU_14_0_4_UMD_PSTATE_SOCCLK			938
 
-static const struct smu_feature_bits smu_v14_0_0_dpm_features = {
-	.bits = {
-		SMU_FEATURE_BIT_INIT(FEATURE_CCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_VCN_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_FCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_SOCCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_LCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_SHUBCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DCFCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_ISP_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_IPU_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_GFX_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_VPE_DPM_BIT)
-	}
-};
+static const struct smu_feature_bits smu_v14_0_0_dpm_features =
+	SMU_FEATURE_BITS_INIT(FEATURE_CCLK_DPM_BIT,
+			      FEATURE_VCN_DPM_BIT,
+			      FEATURE_FCLK_DPM_BIT,
+			      FEATURE_SOCCLK_DPM_BIT,
+			      FEATURE_LCLK_DPM_BIT,
+			      FEATURE_SHUBCLK_DPM_BIT,
+			      FEATURE_DCFCLK_DPM_BIT,
+			      FEATURE_ISP_DPM_BIT,
+			      FEATURE_IPU_DPM_BIT,
+			      FEATURE_GFX_DPM_BIT,
+			      FEATURE_VPE_DPM_BIT);
 
 enum smu_mall_pg_config {
 	SMU_MALL_PG_CONFIG_PMFW_CONTROL = 0,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 6a12d6f8c9dd..20aea7b748ed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -63,13 +63,12 @@ static int smu_v14_0_2_init_ppt_limits(struct smu_context *smu);
 static int smu_v14_0_2_get_overdrive_table(struct smu_context *smu,
 					   OverDriveTableExternal_t *od_table);
 
-static const struct smu_feature_bits smu_v14_0_2_dpm_features = {
-	.bits = { SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
-		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_UCLK_BIT),
-		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_LINK_BIT),
-		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_SOCCLK_BIT),
-		  SMU_FEATURE_BIT_INIT(FEATURE_DPM_FCLK_BIT) }
-};
+static const struct smu_feature_bits smu_v14_0_2_dpm_features =
+	SMU_FEATURE_BITS_INIT(FEATURE_DPM_GFXCLK_BIT,
+			      FEATURE_DPM_UCLK_BIT,
+			      FEATURE_DPM_LINK_BIT,
+			      FEATURE_DPM_SOCCLK_BIT,
+			      FEATURE_DPM_FCLK_BIT);
 
 #define SMU14_DRIVER_IF_VERSION_SMU_V14_0_2 0x2E
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 6e875787434e..14b5cfbec736 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -66,21 +66,18 @@
 #define SMU_15_0_UMD_PSTATE_FCLK 1800
 
 
-static const struct smu_feature_bits smu_v15_0_0_dpm_features = {
-	.bits = {
-		SMU_FEATURE_BIT_INIT(FEATURE_CCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_VCN_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_FCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_SOCCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_LCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_SHUBCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_DCFCLK_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_ISP_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_NPU_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_GFX_DPM_BIT),
-		SMU_FEATURE_BIT_INIT(FEATURE_VPE_DPM_BIT)
-	}
-};
+static const struct smu_feature_bits smu_v15_0_0_dpm_features =
+	SMU_FEATURE_BITS_INIT(FEATURE_CCLK_DPM_BIT,
+			      FEATURE_VCN_DPM_BIT,
+			      FEATURE_FCLK_DPM_BIT,
+			      FEATURE_SOCCLK_DPM_BIT,
+			      FEATURE_LCLK_DPM_BIT,
+			      FEATURE_SHUBCLK_DPM_BIT,
+			      FEATURE_DCFCLK_DPM_BIT,
+			      FEATURE_ISP_DPM_BIT,
+			      FEATURE_NPU_DPM_BIT,
+			      FEATURE_GFX_DPM_BIT,
+			      FEATURE_VPE_DPM_BIT);
 
 enum smu_mall_pg_config {
 	SMU_MALL_PG_CONFIG_PMFW_CONTROL = 0,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 520317453053..3fc2675fa3fd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -85,13 +85,12 @@
 
 static int smu_v15_0_8_init_ppt_limits(struct smu_context *smu);
 
-static const struct smu_feature_bits smu_v15_0_8_dpm_features = {
-	.bits = { SMU_FEATURE_BIT_INIT(FEATURE_ID_DATA_CALCULATION),
-		  SMU_FEATURE_BIT_INIT(FEATURE_ID_DPM_GFXCLK),
-		  SMU_FEATURE_BIT_INIT(FEATURE_ID_DPM_UCLK),
-		  SMU_FEATURE_BIT_INIT(FEATURE_ID_DPM_FCLK),
-		  SMU_FEATURE_BIT_INIT(FEATURE_ID_DPM_GL2CLK) }
-};
+static const struct smu_feature_bits smu_v15_0_8_dpm_features =
+	SMU_FEATURE_BITS_INIT(FEATURE_ID_DATA_CALCULATION,
+			      FEATURE_ID_DPM_GFXCLK,
+			      FEATURE_ID_DPM_UCLK,
+			      FEATURE_ID_DPM_FCLK,
+			      FEATURE_ID_DPM_GL2CLK);
 
 static const struct cmn2asic_msg_mapping smu_v15_0_8_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
-- 
2.56.1.708.g77570a6a1d-goog


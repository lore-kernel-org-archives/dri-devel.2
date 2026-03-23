Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CF6F4613C
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 21:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4859410E43C;
	Mon, 23 Mar 2026 21:13:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LoA86Z/y";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AFDD10E43C
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 21:13:48 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso43009325e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 14:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774300427; x=1774905227; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=luGYbAu3L/MMzGDBscD3dEzD8DKDJmx0o7N9tgbOkNQ=;
 b=LoA86Z/yYCHZ4HeRFaOhMt0OmjxNozj7uz/1gN3095WGgf76cQE0Jvq9EOq6eb76JY
 RD/y4FGM62AXXdXnsG03BOnVR+qbkRx+UOBBmibtoSe8IixGSJDTGK1u4NGE5yhkSqa0
 dSb/JvGsFf1Mffa91y3FKZWTN8rXpgDH1sXNLEjT8XcApOuRI9tse1p5ksOWXv18/Qpy
 gUBJNjY9ZtfTkYeRsQ98J84JsZSg3So+Ooa/uOVF4pJGuRq9XAvdXkPqG9Bsbc9kvbXE
 2t3oL23fqQSJ78NmqJQv0N7G5IgPF5+cnAlDGb0nlEDddYvNsTS30k3JULWwm6jPBeQp
 MuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774300427; x=1774905227;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=luGYbAu3L/MMzGDBscD3dEzD8DKDJmx0o7N9tgbOkNQ=;
 b=QyfnocN9ukF8T12TZtSLRajE4Ui0fSGkctFgsrf7PbhoaDQTYM/rGbUYb6Tv5yrCiW
 cF6zPKnt3elI/DuhfMyDxqA7xmAfMJKyqTtuj5jSnZ5sR3XCfcEwSL5627FeAJQUSp2k
 zXG5uHyVcTPxZBSWuXCxLpNr8PLQj7zHP8Sb5Yq/0N2yYEqbZsNioEQvrDAfV0z66rkV
 ossbIty6Zbt8yGnQRu62f0eT/P1jBuiuBrfAxX4m/vrKR7pm2HnrQkt2JCb1cFVQ3mS2
 X432maGckrORErrU7v7PohtqieIUk+Zjxstluud4iloR57xwqqDQj4tsKyR7IitTJSNU
 Y8jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQPs45RqakNlBaYDxjw6iFRFtcFiEHrMFYIJXs53yS5nkaf22mxWyS4mtTjAAWJKCBjN6CgBxGc5I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0UVMkF2WyNan/0iqXLnrlg2UzESFtDKvITFrqM+2rsTSftev/
 L8qVvgCzUObNRiF8tEcy84DeGTd0L2kxHQf4PPizCVA3nwClkcqOSOZt
X-Gm-Gg: ATEYQzwiNKHjNh9CCtUlylwlkz1YCOQWExw6WZA/7GFOacKsopLwSddMZ4WI85VSXQ4
 DzvC09H23wnjaPn6wJDL4exdGaIeeVcz1opPNkvyVeR3TdFZMu6mdNJZjErl3Yu7k5OYQWVaWMa
 XROLYBqVHbUxOYXQavcCo2eiri5MX8rLdcsNBcPIqbSG35oh9gN3bY5p1cAlHwdQK+SOKox+WQG
 USaKGUlz6wQuhhmiAeLoQdRjlYedesv1zCRl64YhFeQ9A8UJ7IzqCez0bQrvfoU2IqICgB3wptE
 ofdJgSpCtoONGM5N1WV4w0tD3vavAkGgsksEaHa5Er9pb/Ap9znEyUZYcp7Z0LE4qsHlmeGsYBH
 89vlzc4iji9OJY6aJx5R4JpeStA0NyNT+NVa5v54gWd3AWDlFYqik2CD4BzYcYxyVu0G3aYaA5v
 /zGXreJC6YXDnXxe1vdgktWV46uLx9jGXNGhfRDD/V+zA5CH4iuiPkTNIlyDf104V96xoY
X-Received: by 2002:a05:600c:8b31:b0:485:3428:774c with SMTP id
 5b1f17b1804b1-4870f1f40b8mr13880815e9.4.1774300426045; 
 Mon, 23 Mar 2026 14:13:46 -0700 (PDT)
Received: from ionutnechita-arz2022.localdomain
 ([2a02:2f0e:c902:a000:c04:4ac8:5f83:76e1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487117077cbsm146625e9.6.2026.03.23.14.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 14:13:45 -0700 (PDT)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 Ionut Nechita <ionut_n2001@yahoo.com>
Subject: [PATCH] drm/amd/display: Wire up dcn10_dio_construct() for all
 pre-DCN401 generations
Date: Mon, 23 Mar 2026 23:13:43 +0200
Message-ID: <20260323211343.263909-1-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Ionut Nechita <ionut_n2001@yahoo.com>

Description:
 - Commit b82f0759346617b2 ("drm/amd/display: Migrate DIO registers access
   from hwseq to dio component") moved DIO_MEM_PWR_CTRL register access
   behind the new dio abstraction layer but only created the dio object for
   DCN 4.01. On all other generations (DCN 10/20/21/201/30/301/302/303/
   31/314/315/316/32/321/35/351/36), the dio pointer is NULL, causing the
   register write to be silently skipped.

   This results in AFMT HDMI memory not being powered on during init_hw,
   which can cause HDMI audio failures and display issues on affected
   hardware including Renoir/Cezanne (DCN 2.1) APUs that use dcn10_init_hw.

   Call dcn10_dio_construct() in each older DCN generation's resource.c
   to create the dio object, following the same pattern as DCN 4.01. This
   ensures the dio pointer is non-NULL and the mem_pwr_ctrl callback works
   through the dio abstraction for all DCN generations.

Fixes: b82f0759346617b2 ("drm/amd/display: Migrate DIO registers access from hwseq to dio component.")
Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
---
 .../dc/resource/dcn10/dcn10_resource.c        | 41 ++++++++++++++++++
 .../dc/resource/dcn20/dcn20_resource.c        | 42 ++++++++++++++++++
 .../dc/resource/dcn201/dcn201_resource.c      | 41 ++++++++++++++++++
 .../dc/resource/dcn21/dcn21_resource.c        | 34 +++++++++++++++
 .../dc/resource/dcn30/dcn30_resource.c        | 42 ++++++++++++++++++
 .../dc/resource/dcn301/dcn301_resource.c      | 42 ++++++++++++++++++
 .../dc/resource/dcn302/dcn302_resource.c      | 41 ++++++++++++++++++
 .../dc/resource/dcn303/dcn303_resource.c      | 41 ++++++++++++++++++
 .../dc/resource/dcn31/dcn31_resource.c        | 40 +++++++++++++++++
 .../dc/resource/dcn314/dcn314_resource.c      | 40 +++++++++++++++++
 .../dc/resource/dcn315/dcn315_resource.c      | 40 +++++++++++++++++
 .../dc/resource/dcn316/dcn316_resource.c      | 40 +++++++++++++++++
 .../dc/resource/dcn32/dcn32_resource.c        | 43 +++++++++++++++++++
 .../dc/resource/dcn321/dcn321_resource.c      | 43 +++++++++++++++++++
 .../dc/resource/dcn35/dcn35_resource.c        | 43 +++++++++++++++++++
 .../dc/resource/dcn351/dcn351_resource.c      | 43 +++++++++++++++++++
 .../dc/resource/dcn36/dcn36_resource.c        | 43 +++++++++++++++++++
 17 files changed, 699 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
index bbe185e15eb67..4663456a736a2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
@@ -71,6 +71,7 @@
 #include "dce/dce_dmcu.h"
 #include "dce/dce_aux.h"
 #include "dce/dce_i2c.h"
+#include "dio/dcn10/dcn10_dio.h"
 
 #ifndef mmDP0_DP_DPHY_INTERNAL_CTRL
 	#define mmDP0_DP_DPHY_INTERNAL_CTRL		0x210f
@@ -444,6 +445,33 @@ static const struct dcn_hubbub_mask hubbub_mask = {
 		HUBBUB_MASK_SH_LIST_DCN10(_MASK)
 };
 
+static const struct dcn_dio_registers dio_regs = {
+		DIO_REG_LIST_DCN10()
+};
+
+#define DIO_MASK_SH_LIST(mask_sh)\
+		HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh)
+
+static const struct dcn_dio_shift dio_shift = {
+		DIO_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn_dio_mask dio_mask = {
+		DIO_MASK_SH_LIST(_MASK)
+};
+
+static struct dio *dcn10_dio_create(struct dc_context *ctx)
+{
+	struct dcn10_dio *dio10 = kzalloc_obj(struct dcn10_dio);
+
+	if (!dio10)
+		return NULL;
+
+	dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask);
+
+	return &dio10->base;
+}
+
 static int map_transmitter_id_to_phy_instance(
 	enum transmitter transmitter)
 {
@@ -917,6 +945,11 @@ static void dcn10_resource_destruct(struct dcn10_resource_pool *pool)
 	kfree(pool->base.hubbub);
 	pool->base.hubbub = NULL;
 
+	if (pool->base.dio != NULL) {
+		kfree(TO_DCN10_DIO(pool->base.dio));
+		pool->base.dio = NULL;
+	}
+
 	for (i = 0; i < pool->base.pipe_count; i++) {
 		if (pool->base.opps[i] != NULL)
 			pool->base.opps[i]->funcs->opp_destroy(&pool->base.opps[i]);
@@ -1653,6 +1686,14 @@ static bool dcn10_resource_construct(
 		goto fail;
 	}
 
+	/* DIO */
+	pool->base.dio = dcn10_dio_create(ctx);
+	if (pool->base.dio == NULL) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create dio!\n");
+		goto fail;
+	}
+
 	if (!resource_construct(num_virtual_links, dc, &pool->base,
 			&res_create_funcs))
 		goto fail;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 8b555187ac753..74e8d229c9dd3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -82,6 +82,7 @@
 #include "dce/dce_dmcu.h"
 #include "dce/dce_aux.h"
 #include "dce/dce_i2c.h"
+#include "dio/dcn10/dcn10_dio.h"
 #include "vm_helper.h"
 
 #include "link_enc_cfg.h"
@@ -550,6 +551,33 @@ static const struct dcn_hubbub_mask hubbub_mask = {
 		HUBBUB_MASK_SH_LIST_DCN20(_MASK)
 };
 
+static const struct dcn_dio_registers dio_regs = {
+		DIO_REG_LIST_DCN10()
+};
+
+#define DIO_MASK_SH_LIST(mask_sh)\
+		HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh)
+
+static const struct dcn_dio_shift dio_shift = {
+		DIO_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn_dio_mask dio_mask = {
+		DIO_MASK_SH_LIST(_MASK)
+};
+
+static struct dio *dcn20_dio_create(struct dc_context *ctx)
+{
+	struct dcn10_dio *dio10 = kzalloc_obj(struct dcn10_dio);
+
+	if (!dio10)
+		return NULL;
+
+	dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask);
+
+	return &dio10->base;
+}
+
 #define vmid_regs(id)\
 [id] = {\
 		DCN20_VMID_REG_LIST(id)\
@@ -1104,6 +1132,12 @@ static void dcn20_resource_destruct(struct dcn20_resource_pool *pool)
 		kfree(pool->base.hubbub);
 		pool->base.hubbub = NULL;
 	}
+
+	if (pool->base.dio != NULL) {
+		kfree(TO_DCN10_DIO(pool->base.dio));
+		pool->base.dio = NULL;
+	}
+
 	for (i = 0; i < pool->base.pipe_count; i++) {
 		if (pool->base.dpps[i] != NULL)
 			dcn20_dpp_destroy(&pool->base.dpps[i]);
@@ -2692,6 +2726,14 @@ static bool dcn20_resource_construct(
 		goto create_fail;
 	}
 
+	/* DIO */
+	pool->base.dio = dcn20_dio_create(ctx);
+	if (pool->base.dio == NULL) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create dio!\n");
+		goto create_fail;
+	}
+
 	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
 		pool->base.dscs[i] = dcn20_dsc_create(ctx, i);
 		if (pool->base.dscs[i] == NULL) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
index 4ea76e46ab15d..e289be70efb54 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
@@ -56,6 +56,7 @@
 #include "dce/dce_aux.h"
 #include "dce/dce_i2c.h"
 #include "dcn10/dcn10_resource.h"
+#include "dio/dcn10/dcn10_dio.h"
 
 #include "cyan_skillfish_ip_offset.h"
 
@@ -755,6 +756,33 @@ static struct hubbub *dcn201_hubbub_create(struct dc_context *ctx)
 	return &hubbub->base;
 }
 
+static const struct dcn_dio_registers dio_regs = {
+		DIO_REG_LIST_DCN10()
+};
+
+#define DIO_MASK_SH_LIST(mask_sh)\
+		HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh)
+
+static const struct dcn_dio_shift dio_shift = {
+		DIO_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn_dio_mask dio_mask = {
+		DIO_MASK_SH_LIST(_MASK)
+};
+
+static struct dio *dcn201_dio_create(struct dc_context *ctx)
+{
+	struct dcn10_dio *dio10 = kzalloc_obj(struct dcn10_dio);
+
+	if (!dio10)
+		return NULL;
+
+	dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask);
+
+	return &dio10->base;
+}
+
 static struct timing_generator *dcn201_timing_generator_create(
 		struct dc_context *ctx,
 		uint32_t instance)
@@ -930,6 +958,11 @@ static void dcn201_resource_destruct(struct dcn201_resource_pool *pool)
 		pool->base.hubbub = NULL;
 	}
 
+	if (pool->base.dio != NULL) {
+		kfree(TO_DCN10_DIO(pool->base.dio));
+		pool->base.dio = NULL;
+	}
+
 	for (i = 0; i < pool->base.pipe_count; i++) {
 		if (pool->base.dpps[i] != NULL)
 			dcn201_dpp_destroy(&pool->base.dpps[i]);
@@ -1276,6 +1309,14 @@ static bool dcn201_resource_construct(
 		goto create_fail;
 	}
 
+	/* DIO */
+	pool->base.dio = dcn201_dio_create(ctx);
+	if (pool->base.dio == NULL) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create dio!\n");
+		goto create_fail;
+	}
+
 	if (!resource_construct(num_virtual_links, dc, &pool->base,
 			&res_create_funcs))
 		goto create_fail;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 0f4307f8f3dd5..4333baac96ad7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -84,6 +84,7 @@
 #include "dce/dce_dmcu.h"
 #include "dce/dce_aux.h"
 #include "dce/dce_i2c.h"
+#include "dio/dcn10/dcn10_dio.h"
 #include "dcn21_resource.h"
 #include "vm_helper.h"
 #include "dcn20/dcn20_vmid.h"
@@ -329,6 +330,25 @@ static const struct dcn_hubbub_mask hubbub_mask = {
 		HUBBUB_MASK_SH_LIST_DCN21(_MASK)
 };
 
+static const struct dcn_dio_registers dio_regs = {
+		DIO_REG_LIST_DCN10()
+};
+
+static const struct dcn_dio_shift dio_shift = { 0 };
+
+static const struct dcn_dio_mask dio_mask = { 0 };
+
+static struct dio *dcn21_dio_create(struct dc_context *ctx)
+{
+	struct dcn10_dio *dio10 = kzalloc_obj(struct dcn10_dio);
+
+	if (!dio10)
+		return NULL;
+
+	dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask);
+
+	return &dio10->base;
+}
 
 #define vmid_regs(id)\
 [id] = {\
@@ -677,6 +697,12 @@ static void dcn21_resource_destruct(struct dcn21_resource_pool *pool)
 		kfree(pool->base.hubbub);
 		pool->base.hubbub = NULL;
 	}
+
+	if (pool->base.dio != NULL) {
+		kfree(TO_DCN10_DIO(pool->base.dio));
+		pool->base.dio = NULL;
+	}
+
 	for (i = 0; i < pool->base.pipe_count; i++) {
 		if (pool->base.dpps[i] != NULL)
 			dcn20_dpp_destroy(&pool->base.dpps[i]);
@@ -1654,6 +1680,14 @@ static bool dcn21_resource_construct(
 		goto create_fail;
 	}
 
+	/* DIO */
+	pool->base.dio = dcn21_dio_create(ctx);
+	if (pool->base.dio == NULL) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create dio!\n");
+		goto create_fail;
+	}
+
 	for (i = 0; i < pool->base.res_cap->num_dsc; i++) {
 		pool->base.dscs[i] = dcn21_dsc_create(ctx, i);
 		if (pool->base.dscs[i] == NULL) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index 2fa86b9587ed0..87b7b4ee04c64 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -60,6 +60,7 @@
 #include "dml/display_mode_vba.h"
 #include "dcn30/dcn30_dccg.h"
 #include "dcn10/dcn10_resource.h"
+#include "dio/dcn10/dcn10_dio.h"
 #include "link_service.h"
 #include "dce/dce_panel_cntl.h"
 
@@ -886,6 +887,33 @@ static struct hubbub *dcn30_hubbub_create(struct dc_context *ctx)
 	return &hubbub3->base;
 }
 
+static const struct dcn_dio_registers dio_regs = {
+		DIO_REG_LIST_DCN10()
+};
+
+#define DIO_MASK_SH_LIST(mask_sh)\
+		HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh)
+
+static const struct dcn_dio_shift dio_shift = {
+		DIO_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn_dio_mask dio_mask = {
+		DIO_MASK_SH_LIST(_MASK)
+};
+
+static struct dio *dcn30_dio_create(struct dc_context *ctx)
+{
+	struct dcn10_dio *dio10 = kzalloc_obj(struct dcn10_dio);
+
+	if (!dio10)
+		return NULL;
+
+	dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask);
+
+	return &dio10->base;
+}
+
 static struct timing_generator *dcn30_timing_generator_create(
 		struct dc_context *ctx,
 		uint32_t instance)
@@ -1095,6 +1123,12 @@ static void dcn30_resource_destruct(struct dcn30_resource_pool *pool)
 		kfree(pool->base.hubbub);
 		pool->base.hubbub = NULL;
 	}
+
+	if (pool->base.dio != NULL) {
+		kfree(TO_DCN10_DIO(pool->base.dio));
+		pool->base.dio = NULL;
+	}
+
 	for (i = 0; i < pool->base.pipe_count; i++) {
 		if (pool->base.dpps[i] != NULL)
 			dcn30_dpp_destroy(&pool->base.dpps[i]);
@@ -2464,6 +2498,14 @@ static bool dcn30_resource_construct(
 		goto create_fail;
 	}
 
+	/* DIO */
+	pool->base.dio = dcn30_dio_create(ctx);
+	if (pool->base.dio == NULL) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create dio!\n");
+		goto create_fail;
+	}
+
 	/* HUBPs, DPPs, OPPs and TGs */
 	for (i = 0; i < pool->base.pipe_count; i++) {
 		pool->base.hubps[i] = dcn30_hubp_create(ctx, i);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index 7842bee57e636..6bb1c62124bb4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -59,6 +59,7 @@
 #include "dml/display_mode_vba.h"
 #include "dcn301/dcn301_dccg.h"
 #include "dcn10/dcn10_resource.h"
+#include "dio/dcn10/dcn10_dio.h"
 #include "dcn30/dcn30_dio_stream_encoder.h"
 #include "dcn301/dcn301_dio_link_encoder.h"
 #include "dcn301/dcn301_panel_cntl.h"
@@ -843,6 +844,33 @@ static struct hubbub *dcn301_hubbub_create(struct dc_context *ctx)
 	return &hubbub3->base;
 }
 
+static const struct dcn_dio_registers dio_regs = {
+		DIO_REG_LIST_DCN10()
+};
+
+#define DIO_MASK_SH_LIST(mask_sh)\
+		HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh)
+
+static const struct dcn_dio_shift dio_shift = {
+		DIO_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn_dio_mask dio_mask = {
+		DIO_MASK_SH_LIST(_MASK)
+};
+
+static struct dio *dcn301_dio_create(struct dc_context *ctx)
+{
+	struct dcn10_dio *dio10 = kzalloc_obj(struct dcn10_dio);
+
+	if (!dio10)
+		return NULL;
+
+	dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask);
+
+	return &dio10->base;
+}
+
 static struct timing_generator *dcn301_timing_generator_create(
 	struct dc_context *ctx, uint32_t instance)
 {
@@ -1066,6 +1094,12 @@ static void dcn301_destruct(struct dcn301_resource_pool *pool)
 		kfree(pool->base.hubbub);
 		pool->base.hubbub = NULL;
 	}
+
+	if (pool->base.dio != NULL) {
+		kfree(TO_DCN10_DIO(pool->base.dio));
+		pool->base.dio = NULL;
+	}
+
 	for (i = 0; i < pool->base.pipe_count; i++) {
 		if (pool->base.dpps[i] != NULL)
 			dcn301_dpp_destroy(&pool->base.dpps[i]);
@@ -1582,6 +1616,14 @@ static bool dcn301_resource_construct(
 		goto create_fail;
 	}
 
+	/* DIO */
+	pool->base.dio = dcn301_dio_create(ctx);
+	if (pool->base.dio == NULL) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create dio!\n");
+		goto create_fail;
+	}
+
 	j = 0;
 	/* HUBPs, DPPs, OPPs and TGs */
 	for (i = 0; i < pool->base.pipe_count; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
index 1874d5d6b7820..d02aafd06fd45 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
@@ -46,6 +46,7 @@
 #include "dml/dcn30/dcn30_fpu.h"
 
 #include "dcn10/dcn10_resource.h"
+#include "dio/dcn10/dcn10_dio.h"
 
 #include "link_service.h"
 
@@ -253,6 +254,33 @@ static const struct dcn20_vmid_mask vmid_masks = {
 		DCN20_VMID_MASK_SH_LIST(_MASK)
 };
 
+static const struct dcn_dio_registers dio_regs = {
+		DIO_REG_LIST_DCN10()
+};
+
+#define DIO_MASK_SH_LIST(mask_sh)\
+		HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh)
+
+static const struct dcn_dio_shift dio_shift = {
+		DIO_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn_dio_mask dio_mask = {
+		DIO_MASK_SH_LIST(_MASK)
+};
+
+static struct dio *dcn302_dio_create(struct dc_context *ctx)
+{
+	struct dcn10_dio *dio10 = kzalloc_obj(struct dcn10_dio);
+
+	if (!dio10)
+		return NULL;
+
+	dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask);
+
+	return &dio10->base;
+}
+
 static struct hubbub *dcn302_hubbub_create(struct dc_context *ctx)
 {
 	int i;
@@ -1022,6 +1050,11 @@ static void dcn302_resource_destruct(struct resource_pool *pool)
 		pool->hubbub = NULL;
 	}
 
+	if (pool->dio != NULL) {
+		kfree(TO_DCN10_DIO(pool->dio));
+		pool->dio = NULL;
+	}
+
 	for (i = 0; i < pool->pipe_count; i++) {
 		if (pool->dpps[i] != NULL) {
 			kfree(TO_DCN20_DPP(pool->dpps[i]));
@@ -1372,6 +1405,14 @@ static bool dcn302_resource_construct(
 		goto create_fail;
 	}
 
+	/* DIO */
+	pool->dio = dcn302_dio_create(ctx);
+	if (pool->dio == NULL) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create dio!\n");
+		goto create_fail;
+	}
+
 	/* HUBPs, DPPs, OPPs and TGs */
 	for (i = 0; i < pool->pipe_count; i++) {
 		pool->hubps[i] = dcn302_hubp_create(ctx, i);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
index d52201cb359fd..30b1403112c6c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
@@ -46,6 +46,7 @@
 #include "dml/dcn30/dcn30_fpu.h"
 
 #include "dcn10/dcn10_resource.h"
+#include "dio/dcn10/dcn10_dio.h"
 
 #include "link_service.h"
 
@@ -249,6 +250,33 @@ static const struct dcn20_vmid_mask vmid_masks = {
 		DCN20_VMID_MASK_SH_LIST(_MASK)
 };
 
+static const struct dcn_dio_registers dio_regs = {
+		DIO_REG_LIST_DCN10()
+};
+
+#define DIO_MASK_SH_LIST(mask_sh)\
+		HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh)
+
+static const struct dcn_dio_shift dio_shift = {
+		DIO_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn_dio_mask dio_mask = {
+		DIO_MASK_SH_LIST(_MASK)
+};
+
+static struct dio *dcn303_dio_create(struct dc_context *ctx)
+{
+	struct dcn10_dio *dio10 = kzalloc_obj(struct dcn10_dio);
+
+	if (!dio10)
+		return NULL;
+
+	dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask);
+
+	return &dio10->base;
+}
+
 static struct hubbub *dcn303_hubbub_create(struct dc_context *ctx)
 {
 	int i;
@@ -966,6 +994,11 @@ static void dcn303_resource_destruct(struct resource_pool *pool)
 		pool->hubbub = NULL;
 	}
 
+	if (pool->dio != NULL) {
+		kfree(TO_DCN10_DIO(pool->dio));
+		pool->dio = NULL;
+	}
+
 	for (i = 0; i < pool->pipe_count; i++) {
 		if (pool->dpps[i] != NULL) {
 			kfree(TO_DCN20_DPP(pool->dpps[i]));
@@ -1304,6 +1337,14 @@ static bool dcn303_resource_construct(
 		goto create_fail;
 	}
 
+	/* DIO */
+	pool->dio = dcn303_dio_create(ctx);
+	if (pool->dio == NULL) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create dio!\n");
+		goto create_fail;
+	}
+
 	/* HUBPs, DPPs, OPPs and TGs */
 	for (i = 0; i < pool->pipe_count; i++) {
 		pool->hubps[i] = dcn303_hubp_create(ctx, i);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 2055f1f8af652..4e9c041c707a6 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -64,6 +64,7 @@
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
+#include "dio/dcn10/dcn10_dio.h"
 #include "dio/virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
@@ -810,6 +811,21 @@ static const struct dcn20_vmid_mask vmid_masks = {
 		DCN20_VMID_MASK_SH_LIST(_MASK)
 };
 
+static const struct dcn_dio_registers dio_regs = {
+		DIO_REG_LIST_DCN10()
+};
+
+#define DIO_MASK_SH_LIST(mask_sh)\
+		HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh)
+
+static const struct dcn_dio_shift dio_shift = {
+		DIO_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn_dio_mask dio_mask = {
+		DIO_MASK_SH_LIST(_MASK)
+};
+
 static const struct resource_caps res_cap_dcn31 = {
 	.num_timing_generator = 4,
 	.num_opp = 4,
@@ -1021,6 +1037,18 @@ static struct mpc *dcn31_mpc_create(
 	return &mpc30->base;
 }
 
+static struct dio *dcn31_dio_create(struct dc_context *ctx)
+{
+	struct dcn10_dio *dio10 = kzalloc_obj(struct dcn10_dio);
+
+	if (!dio10)
+		return NULL;
+
+	dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask);
+
+	return &dio10->base;
+}
+
 static struct hubbub *dcn31_hubbub_create(struct dc_context *ctx)
 {
 	int i;
@@ -1396,6 +1424,10 @@ static void dcn31_resource_destruct(struct dcn31_resource_pool *pool)
 		kfree(pool->base.hubbub);
 		pool->base.hubbub = NULL;
 	}
+	if (pool->base.dio != NULL) {
+		kfree(TO_DCN10_DIO(pool->base.dio));
+		pool->base.dio = NULL;
+	}
 	for (i = 0; i < pool->base.pipe_count; i++) {
 		if (pool->base.dpps[i] != NULL)
 			dcn31_dpp_destroy(&pool->base.dpps[i]);
@@ -2063,6 +2095,14 @@ static bool dcn31_resource_construct(
 		goto create_fail;
 	}
 
+	/* DIO */
+	pool->base.dio = dcn31_dio_create(ctx);
+	if (pool->base.dio == NULL) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create dio!\n");
+		goto create_fail;
+	}
+
 	/* HUBPs, DPPs, OPPs and TGs */
 	for (i = 0; i < pool->base.pipe_count; i++) {
 		pool->base.hubps[i] = dcn31_hubp_create(ctx, i);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index 1939f720ba295..e26a6427916a0 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -66,6 +66,7 @@
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
+#include "dio/dcn10/dcn10_dio.h"
 #include "dio/virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
@@ -822,6 +823,21 @@ static const struct dcn20_vmid_mask vmid_masks = {
 		DCN20_VMID_MASK_SH_LIST(_MASK)
 };
 
+static const struct dcn_dio_registers dio_regs = {
+		DIO_REG_LIST_DCN10()
+};
+
+#define DIO_MASK_SH_LIST(mask_sh)\
+		HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh)
+
+static const struct dcn_dio_shift dio_shift = {
+		DIO_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn_dio_mask dio_mask = {
+		DIO_MASK_SH_LIST(_MASK)
+};
+
 static const struct resource_caps res_cap_dcn314 = {
 	.num_timing_generator = 4,
 	.num_opp = 4,
@@ -1079,6 +1095,18 @@ static struct mpc *dcn31_mpc_create(
 	return &mpc30->base;
 }
 
+static struct dio *dcn314_dio_create(struct dc_context *ctx)
+{
+	struct dcn10_dio *dio10 = kzalloc_obj(struct dcn10_dio);
+
+	if (!dio10)
+		return NULL;
+
+	dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask);
+
+	return &dio10->base;
+}
+
 static struct hubbub *dcn31_hubbub_create(struct dc_context *ctx)
 {
 	int i;
@@ -1455,6 +1483,10 @@ static void dcn314_resource_destruct(struct dcn314_resource_pool *pool)
 		kfree(pool->base.hubbub);
 		pool->base.hubbub = NULL;
 	}
+	if (pool->base.dio != NULL) {
+		kfree(TO_DCN10_DIO(pool->base.dio));
+		pool->base.dio = NULL;
+	}
 	for (i = 0; i < pool->base.pipe_count; i++) {
 		if (pool->base.dpps[i] != NULL)
 			dcn31_dpp_destroy(&pool->base.dpps[i]);
@@ -1987,6 +2019,14 @@ static bool dcn314_resource_construct(
 		goto create_fail;
 	}
 
+	/* DIO */
+	pool->base.dio = dcn314_dio_create(ctx);
+	if (pool->base.dio == NULL) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create dio!\n");
+		goto create_fail;
+	}
+
 	/* HUBPs, DPPs, OPPs and TGs */
 	for (i = 0; i < pool->base.pipe_count; i++) {
 		pool->base.hubps[i] = dcn31_hubp_create(ctx, i);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index e8377c190f635..131a6cd4c7352 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -63,6 +63,7 @@
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
+#include "dio/dcn10/dcn10_dio.h"
 #include "dio/virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
@@ -809,6 +810,21 @@ static const struct dcn20_vmid_mask vmid_masks = {
 		DCN20_VMID_MASK_SH_LIST(_MASK)
 };
 
+static const struct dcn_dio_registers dio_regs = {
+		DIO_REG_LIST_DCN10()
+};
+
+#define DIO_MASK_SH_LIST(mask_sh)\
+		HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh)
+
+static const struct dcn_dio_shift dio_shift = {
+		DIO_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn_dio_mask dio_mask = {
+		DIO_MASK_SH_LIST(_MASK)
+};
+
 static const struct resource_caps res_cap_dcn31 = {
 	.num_timing_generator = 4,
 	.num_opp = 4,
@@ -1020,6 +1036,18 @@ static struct mpc *dcn31_mpc_create(
 	return &mpc30->base;
 }
 
+static struct dio *dcn315_dio_create(struct dc_context *ctx)
+{
+	struct dcn10_dio *dio10 = kzalloc_obj(struct dcn10_dio);
+
+	if (!dio10)
+		return NULL;
+
+	dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask);
+
+	return &dio10->base;
+}
+
 static struct hubbub *dcn31_hubbub_create(struct dc_context *ctx)
 {
 	int i;
@@ -1397,6 +1425,10 @@ static void dcn315_resource_destruct(struct dcn315_resource_pool *pool)
 		kfree(pool->base.hubbub);
 		pool->base.hubbub = NULL;
 	}
+	if (pool->base.dio != NULL) {
+		kfree(TO_DCN10_DIO(pool->base.dio));
+		pool->base.dio = NULL;
+	}
 	for (i = 0; i < pool->base.pipe_count; i++) {
 		if (pool->base.dpps[i] != NULL)
 			dcn31_dpp_destroy(&pool->base.dpps[i]);
@@ -2012,6 +2044,14 @@ static bool dcn315_resource_construct(
 		goto create_fail;
 	}
 
+	/* DIO */
+	pool->base.dio = dcn315_dio_create(ctx);
+	if (pool->base.dio == NULL) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create dio!\n");
+		goto create_fail;
+	}
+
 	/* HUBPs, DPPs, OPPs and TGs */
 	for (i = 0; i < pool->base.pipe_count; i++) {
 		pool->base.hubps[i] = dcn31_hubp_create(ctx, i);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 045ce01bd74eb..c8c0ce6efcfdc 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -63,6 +63,7 @@
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
+#include "dio/dcn10/dcn10_dio.h"
 #include "dio/virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
@@ -804,6 +805,21 @@ static const struct dcn20_vmid_mask vmid_masks = {
 		DCN20_VMID_MASK_SH_LIST(_MASK)
 };
 
+static const struct dcn_dio_registers dio_regs = {
+		DIO_REG_LIST_DCN10()
+};
+
+#define DIO_MASK_SH_LIST(mask_sh)\
+		HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh)
+
+static const struct dcn_dio_shift dio_shift = {
+		DIO_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn_dio_mask dio_mask = {
+		DIO_MASK_SH_LIST(_MASK)
+};
+
 static const struct resource_caps res_cap_dcn31 = {
 	.num_timing_generator = 4,
 	.num_opp = 4,
@@ -1013,6 +1029,18 @@ static struct mpc *dcn31_mpc_create(
 	return &mpc30->base;
 }
 
+static struct dio *dcn316_dio_create(struct dc_context *ctx)
+{
+	struct dcn10_dio *dio10 = kzalloc_obj(struct dcn10_dio);
+
+	if (!dio10)
+		return NULL;
+
+	dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask);
+
+	return &dio10->base;
+}
+
 static struct hubbub *dcn31_hubbub_create(struct dc_context *ctx)
 {
 	int i;
@@ -1392,6 +1420,10 @@ static void dcn316_resource_destruct(struct dcn316_resource_pool *pool)
 		kfree(pool->base.hubbub);
 		pool->base.hubbub = NULL;
 	}
+	if (pool->base.dio != NULL) {
+		kfree(TO_DCN10_DIO(pool->base.dio));
+		pool->base.dio = NULL;
+	}
 	for (i = 0; i < pool->base.pipe_count; i++) {
 		if (pool->base.dpps[i] != NULL)
 			dcn31_dpp_destroy(&pool->base.dpps[i]);
@@ -1887,6 +1919,14 @@ static bool dcn316_resource_construct(
 		goto create_fail;
 	}
 
+	/* DIO */
+	pool->base.dio = dcn316_dio_create(ctx);
+	if (pool->base.dio == NULL) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create dio!\n");
+		goto create_fail;
+	}
+
 	/* HUBPs, DPPs, OPPs and TGs */
 	for (i = 0; i < pool->base.pipe_count; i++) {
 		pool->base.hubps[i] = dcn31_hubp_create(ctx, i);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index c7fd604024d64..c3a6ae14de18b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -66,6 +66,7 @@
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
 #include "dio/virtual/virtual_stream_encoder.h"
+#include "dio/dcn10/dcn10_dio.h"
 #include "dml/display_mode_vba.h"
 #include "dcn32/dcn32_dccg.h"
 #include "dcn10/dcn10_resource.h"
@@ -643,6 +644,19 @@ static const struct dcn20_vmid_mask vmid_masks = {
 		DCN20_VMID_MASK_SH_LIST(_MASK)
 };
 
+static struct dcn_dio_registers dio_regs;
+
+#define DIO_MASK_SH_LIST(mask_sh)\
+		HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh)
+
+static const struct dcn_dio_shift dio_shift = {
+		DIO_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn_dio_mask dio_mask = {
+		DIO_MASK_SH_LIST(_MASK)
+};
+
 static const struct resource_caps res_cap_dcn32 = {
 	.num_timing_generator = 4,
 	.num_opp = 4,
@@ -833,6 +847,22 @@ static struct clock_source *dcn32_clock_source_create(
 	return NULL;
 }
 
+static struct dio *dcn32_dio_create(struct dc_context *ctx)
+{
+	struct dcn10_dio *dio10 = kzalloc_obj(struct dcn10_dio);
+
+	if (!dio10)
+		return NULL;
+
+#undef REG_STRUCT
+#define REG_STRUCT dio_regs
+	DIO_REG_LIST_DCN10();
+
+	dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask);
+
+	return &dio10->base;
+}
+
 static struct hubbub *dcn32_hubbub_create(struct dc_context *ctx)
 {
 	int i;
@@ -1494,6 +1524,11 @@ static void dcn32_resource_destruct(struct dcn32_resource_pool *pool)
 	if (pool->base.dccg != NULL)
 		dcn_dccg_destroy(&pool->base.dccg);
 
+	if (pool->base.dio != NULL) {
+		kfree(TO_DCN10_DIO(pool->base.dio));
+		pool->base.dio = NULL;
+	}
+
 	if (pool->base.oem_device != NULL) {
 		struct dc *dc = pool->base.oem_device->ctx->dc;
 
@@ -2373,6 +2408,14 @@ static bool dcn32_resource_construct(
 		goto create_fail;
 	}
 
+	/* DIO */
+	pool->base.dio = dcn32_dio_create(ctx);
+	if (pool->base.dio == NULL) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create dio!\n");
+		goto create_fail;
+	}
+
 	/* HUBPs, DPPs, OPPs, TGs, ABMs */
 	for (i = 0, j = 0; i < pool->base.res_cap->num_timing_generator; i++) {
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index c1582c27ac872..990aec7eb3d07 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -69,6 +69,7 @@
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
 #include "dio/virtual/virtual_stream_encoder.h"
+#include "dio/dcn10/dcn10_dio.h"
 #include "dml/display_mode_vba.h"
 #include "dcn32/dcn32_dccg.h"
 #include "dcn10/dcn10_resource.h"
@@ -639,6 +640,19 @@ static const struct dcn20_vmid_mask vmid_masks = {
 		DCN20_VMID_MASK_SH_LIST(_MASK)
 };
 
+static struct dcn_dio_registers dio_regs;
+
+#define DIO_MASK_SH_LIST(mask_sh)\
+		HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh)
+
+static const struct dcn_dio_shift dio_shift = {
+		DIO_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn_dio_mask dio_mask = {
+		DIO_MASK_SH_LIST(_MASK)
+};
+
 static const struct resource_caps res_cap_dcn321 = {
 	.num_timing_generator = 4,
 	.num_opp = 4,
@@ -827,6 +841,22 @@ static struct clock_source *dcn321_clock_source_create(
 	return NULL;
 }
 
+static struct dio *dcn321_dio_create(struct dc_context *ctx)
+{
+	struct dcn10_dio *dio10 = kzalloc_obj(struct dcn10_dio);
+
+	if (!dio10)
+		return NULL;
+
+#undef REG_STRUCT
+#define REG_STRUCT dio_regs
+	DIO_REG_LIST_DCN10();
+
+	dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask);
+
+	return &dio10->base;
+}
+
 static struct hubbub *dcn321_hubbub_create(struct dc_context *ctx)
 {
 	int i;
@@ -1474,6 +1504,11 @@ static void dcn321_resource_destruct(struct dcn321_resource_pool *pool)
 	if (pool->base.dccg != NULL)
 		dcn_dccg_destroy(&pool->base.dccg);
 
+	if (pool->base.dio != NULL) {
+		kfree(TO_DCN10_DIO(pool->base.dio));
+		pool->base.dio = NULL;
+	}
+
 	if (pool->base.oem_device != NULL) {
 		struct dc *dc = pool->base.oem_device->ctx->dc;
 
@@ -1872,6 +1907,14 @@ static bool dcn321_resource_construct(
 		goto create_fail;
 	}
 
+	/* DIO */
+	pool->base.dio = dcn321_dio_create(ctx);
+	if (pool->base.dio == NULL) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create dio!\n");
+		goto create_fail;
+	}
+
 	/* HUBPs, DPPs, OPPs, TGs, ABMs */
 	for (i = 0, j = 0; i < pool->base.res_cap->num_timing_generator; i++) {
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 3494a40cea99f..598b2f25881da 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -71,6 +71,7 @@
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
 #include "dio/virtual/virtual_stream_encoder.h"
+#include "dio/dcn10/dcn10_dio.h"
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
 #include "dcn35/dcn35_dccg.h"
@@ -664,6 +665,19 @@ static const struct dcn20_vmid_mask vmid_masks = {
 		DCN20_VMID_MASK_SH_LIST(_MASK)
 };
 
+static struct dcn_dio_registers dio_regs;
+
+#define DIO_MASK_SH_LIST(mask_sh)\
+		HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh)
+
+static const struct dcn_dio_shift dio_shift = {
+		DIO_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn_dio_mask dio_mask = {
+		DIO_MASK_SH_LIST(_MASK)
+};
+
 static const struct resource_caps res_cap_dcn35 = {
 	.num_timing_generator = 4,
 	.num_opp = 4,
@@ -973,6 +987,22 @@ static struct mpc *dcn35_mpc_create(
 	return &mpc30->base;
 }
 
+static struct dio *dcn35_dio_create(struct dc_context *ctx)
+{
+	struct dcn10_dio *dio10 = kzalloc_obj(struct dcn10_dio);
+
+	if (!dio10)
+		return NULL;
+
+#undef REG_STRUCT
+#define REG_STRUCT dio_regs
+	DIO_REG_LIST_DCN10();
+
+	dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask);
+
+	return &dio10->base;
+}
+
 static struct hubbub *dcn35_hubbub_create(struct dc_context *ctx)
 {
 	int i;
@@ -1563,6 +1593,11 @@ static void dcn35_resource_destruct(struct dcn35_resource_pool *pool)
 
 	if (pool->base.dccg != NULL)
 		dcn_dccg_destroy(&pool->base.dccg);
+
+	if (pool->base.dio != NULL) {
+		kfree(TO_DCN10_DIO(pool->base.dio));
+		pool->base.dio = NULL;
+	}
 }
 
 static struct hubp *dcn35_hubp_create(
@@ -2033,6 +2068,14 @@ static bool dcn35_resource_construct(
 		goto create_fail;
 	}
 
+	/* DIO */
+	pool->base.dio = dcn35_dio_create(ctx);
+	if (pool->base.dio == NULL) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create dio!\n");
+		goto create_fail;
+	}
+
 	/* HUBPs, DPPs, OPPs and TGs */
 	for (i = 0; i < pool->base.pipe_count; i++) {
 		pool->base.hubps[i] = dcn35_hubp_create(ctx, i);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 080bc7f24ffaa..7e15d07df7a33 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -50,6 +50,7 @@
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
 #include "dio/virtual/virtual_stream_encoder.h"
+#include "dio/dcn10/dcn10_dio.h"
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
 #include "dcn35/dcn35_dccg.h"
@@ -644,6 +645,19 @@ static const struct dcn20_vmid_mask vmid_masks = {
 		DCN20_VMID_MASK_SH_LIST(_MASK)
 };
 
+static struct dcn_dio_registers dio_regs;
+
+#define DIO_MASK_SH_LIST(mask_sh)\
+		HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh)
+
+static const struct dcn_dio_shift dio_shift = {
+		DIO_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn_dio_mask dio_mask = {
+		DIO_MASK_SH_LIST(_MASK)
+};
+
 static const struct resource_caps res_cap_dcn351 = {
 	.num_timing_generator = 4,
 	.num_opp = 4,
@@ -953,6 +967,22 @@ static struct mpc *dcn35_mpc_create(
 	return &mpc30->base;
 }
 
+static struct dio *dcn351_dio_create(struct dc_context *ctx)
+{
+	struct dcn10_dio *dio10 = kzalloc_obj(struct dcn10_dio);
+
+	if (!dio10)
+		return NULL;
+
+#undef REG_STRUCT
+#define REG_STRUCT dio_regs
+	DIO_REG_LIST_DCN10();
+
+	dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask);
+
+	return &dio10->base;
+}
+
 static struct hubbub *dcn35_hubbub_create(struct dc_context *ctx)
 {
 	int i;
@@ -1543,6 +1573,11 @@ static void dcn351_resource_destruct(struct dcn351_resource_pool *pool)
 
 	if (pool->base.dccg != NULL)
 		dcn_dccg_destroy(&pool->base.dccg);
+
+	if (pool->base.dio != NULL) {
+		kfree(TO_DCN10_DIO(pool->base.dio));
+		pool->base.dio = NULL;
+	}
 }
 
 static struct hubp *dcn35_hubp_create(
@@ -2005,6 +2040,14 @@ static bool dcn351_resource_construct(
 		goto create_fail;
 	}
 
+	/* DIO */
+	pool->base.dio = dcn351_dio_create(ctx);
+	if (pool->base.dio == NULL) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create dio!\n");
+		goto create_fail;
+	}
+
 	/* HUBPs, DPPs, OPPs and TGs */
 	for (i = 0; i < pool->base.pipe_count; i++) {
 		pool->base.hubps[i] = dcn35_hubp_create(ctx, i);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index af51ac4ea59e2..83fee2ca61bff 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -50,6 +50,7 @@
 #include "dce/dce_hwseq.h"
 #include "clk_mgr.h"
 #include "dio/virtual/virtual_stream_encoder.h"
+#include "dio/dcn10/dcn10_dio.h"
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
 #include "dcn35/dcn35_dccg.h"
@@ -651,6 +652,19 @@ static const struct dcn20_vmid_mask vmid_masks = {
 		DCN20_VMID_MASK_SH_LIST(_MASK)
 };
 
+static struct dcn_dio_registers dio_regs;
+
+#define DIO_MASK_SH_LIST(mask_sh)\
+		HWS_SF(, DIO_MEM_PWR_CTRL, I2C_LIGHT_SLEEP_FORCE, mask_sh)
+
+static const struct dcn_dio_shift dio_shift = {
+		DIO_MASK_SH_LIST(__SHIFT)
+};
+
+static const struct dcn_dio_mask dio_mask = {
+		DIO_MASK_SH_LIST(_MASK)
+};
+
 static const struct resource_caps res_cap_dcn36 = {
 	.num_timing_generator = 4,
 	.num_opp = 4,
@@ -960,6 +974,22 @@ static struct mpc *dcn35_mpc_create(
 	return &mpc30->base;
 }
 
+static struct dio *dcn36_dio_create(struct dc_context *ctx)
+{
+	struct dcn10_dio *dio10 = kzalloc_obj(struct dcn10_dio);
+
+	if (!dio10)
+		return NULL;
+
+#undef REG_STRUCT
+#define REG_STRUCT dio_regs
+	DIO_REG_LIST_DCN10();
+
+	dcn10_dio_construct(dio10, ctx, &dio_regs, &dio_shift, &dio_mask);
+
+	return &dio10->base;
+}
+
 static struct hubbub *dcn35_hubbub_create(struct dc_context *ctx)
 {
 	int i;
@@ -1550,6 +1580,11 @@ static void dcn36_resource_destruct(struct dcn36_resource_pool *pool)
 
 	if (pool->base.dccg != NULL)
 		dcn_dccg_destroy(&pool->base.dccg);
+
+	if (pool->base.dio != NULL) {
+		kfree(TO_DCN10_DIO(pool->base.dio));
+		pool->base.dio = NULL;
+	}
 }
 
 static struct hubp *dcn35_hubp_create(
@@ -2012,6 +2047,14 @@ static bool dcn36_resource_construct(
 		goto create_fail;
 	}
 
+	/* DIO */
+	pool->base.dio = dcn36_dio_create(ctx);
+	if (pool->base.dio == NULL) {
+		BREAK_TO_DEBUGGER();
+		dm_error("DC: failed to create dio!\n");
+		goto create_fail;
+	}
+
 	/* HUBPs, DPPs, OPPs and TGs */
 	for (i = 0; i < pool->base.pipe_count; i++) {
 		pool->base.hubps[i] = dcn35_hubp_create(ctx, i);
-- 
2.53.0


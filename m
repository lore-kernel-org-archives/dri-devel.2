Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC3A606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NwEkjKZg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0783F10E831;
	Fri, 13 Nov 2026 20:27:07 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B78210E831
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 20:27:00 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-8b10d24345dso15364077b3.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 12:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794601619; x=1795206419; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PhtC0JxauQcPDOHIrZsgxbd4a5t2+eo0s+cAxRye7WY=;
 b=NwEkjKZgDgsnb4kHkySdgdQ3SeWOBgbtJfoJ/C1TKdfhlYSQ05MG2EO0G4j2yV7RTI
 maTO+wGBs6K3UxdsbkdA5DjbQCzNO/iJG6c2fRcJZAxzrmX2x5QxPd1Fi8lmIcfFKSl9
 EeJsuRjr8MOaHdJJq5TqSg3UezXTQpEPwzVK/mJuZKqNwNPzIIMJhxyQ34ydymbPLJMh
 8ZoP8fsNnOYoJqP7Yi2bvnZJD2Jqt0TDM+LqTEUeDYAilWJ/kO8AA+rYPFwoocg9W/wO
 vEGwkslEHAdnPSQV2laDVTdmP80GMX0meBmF88eWycOZEndQUQwdOlUzBGqNLeorYA/R
 3+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794601619; x=1795206419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PhtC0JxauQcPDOHIrZsgxbd4a5t2+eo0s+cAxRye7WY=;
 b=UFGMkZ36hYH0Ow5d30GzwT6IyOD5uBdSQiUBz44qFuMAD6AtvTK1BMRiSeOwzmsk7Z
 NRwW0u8xsJs0TD1hAriU4PzIl5CknlP5XjZpdTUiZFaMrPR/3oI9cofdHqon0fCSb+XF
 8IwFJldkqqVuacdh7g75dS7r97NWTUgcLSp8GHlL7+27fh/kQIxP5OofyCC2RtPw76PO
 kTfcVrSW4Z52JZqCux/8bXB/js+IFEKV4J44MYjujGMMT6GjLTVwsMimv960xVIqwQbI
 HuHzBTz/S6w5aaLUpQpx1fIWKwzW+pWyBYp6Sa3jBbsAVUG/6oDDTTSanpwl6qk3LB3D
 qiWQ==
X-Gm-Message-State: APuU4Z+vbkTuEeGRdByWm0UbOMcJLAST2i/p9NAznNtiExzvlVMi11d9
 VS3B2HKjxlc4b71IZmjj19ntNjvxqgnfn5zP75dYma+9EJy38lgNeSRBWExUoUjC/vU=
X-Gm-Gg: AYBFou0OYCt3qwZOSQtI+kbTYrP/qT9625hC5eSTusg9t5wKTlQ39atyBgYIxjqO8bo
 Kc9ToTLUAIAZxvQXbzo9osQrF6roDFVfZEB+oiW95UjID2wmKuHJFTIyfH4yujPqFtztfL2vBC1
 c5kEOl9HY4zbG2fx0y8VBzbaQBeuD70b0cyuYr7weArIY4LF8/9nGL8XwAW17YmVo01gv0yrN/j
 WJM183CMgmOtj7FCSI1c6ufTw8zQyLxMVMvuSoskjFbnuaB0f3/budACQKZkMGECSPYvBEn5ewW
 yUMnHgEit+bzHkUYziJwdybf20ONxjmzSCk6uH6d0onbYns45EVXjKsxflI3Q6bGi+MdJlFzLEp
 E3kBogmthJOKOAznpaKJy3gMcDcR5YdqD5ABQ1LWUrxf/LTfJ6Z8JqLCww4VqHLo9dCp5zc3pJl
 Jz2rCZ2ASEeT50kw0HUaifQ4AInRKjjyMTxf4h+kcMUr25uQDqTQ6kN+eObAA/sY2DsEEOqWCqV
 OoYNCiWBOdiZ9JNuv5pPijHDUdf4F6UGN0oo3str+e6XgtrACYhJAKgrJZ7bs/2JrWwwIXTuMcp
 lE2iFVkA1sMSHmUiPj9lgcXHPm29eEWi54FrLkIw6SEYDqCykNHrWxfuNmc4KzVRowOM5lD8JXd
 9KG8102gq6yfv
X-Received: by 2002:a05:690c:f02:b0:8aa:5af3:e420 with SMTP id
 00721157ae682-8b4aa295b19mr24457817b3.11.1794601619027; 
 Fri, 13 Nov 2026 12:26:59 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:fd83:f7ad:7c00:7806])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa8edcffsm29139727b3.11.2026.11.13.12.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 12:26:58 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Gabriel Gama <operatingsystemsdepression@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Joseph Telaak <joseph@telaak.dev>
Subject: [PATCH 10/10] drm/gma500: add software-only KUnit coverage for SGX MMU
Date: Fri, 13 Nov 2026 17:26:48 -0300
Message-ID: <20261113202648.15717-1-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
References: <CAFGNeaiEVnm_b8OBEELseBg9JDgm_PuDzZG2pQu8KxFPnzANyQ@mail.gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Exercise software page-table insertion, range validation, collisions,
rollback and removal without a device or MMIO. Keep fixture partial-init
cleanup NULL-safe and idempotent because KUnit calls exit after init
failure. These tests do not validate GPU TLB/cache behavior or rendering.

Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>
---
diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
index dc4c56638819289919e2fd90d9c2be32fdfd6170..b6e2dda1383b65f6216b061b78a3f78fb6753fb5 100644
--- a/drivers/gpu/drm/gma500/Kconfig
+++ b/drivers/gpu/drm/gma500/Kconfig
@@ -16,3 +16,13 @@
 	  Say yes for an experimental 2D KMS framebuffer driver for the
 	  Intel GMA500 (Poulsbo), Intel GMA600 (Moorestown/Oak Trail) and
 	  Intel GMA3600/3650 (Cedar Trail).
+
+config DRM_GMA500_KUNIT_TEST
+	bool "KUnit tests for the GMA500 SGX page tables" if !KUNIT_ALL_TESTS
+	depends on DRM_GMA500=y && KUNIT=y
+	default KUNIT_ALL_TESTS
+	help
+	  Run software-only tests for SGX page-table range validation,
+	  rollback, mapping collisions and removal. The tests use a software
+	  page directory with no device or hardware context, and never
+	  submit commands to the GPU or access its registers.
diff --git a/drivers/gpu/drm/gma500/Makefile b/drivers/gpu/drm/gma500/Makefile
index 58fed80c7392a02c317011365c9ce3165412bf3d..069400d70ba8cda62992f9efab9de5010ddf9b75 100644
--- a/drivers/gpu/drm/gma500/Makefile
+++ b/drivers/gpu/drm/gma500/Makefile
@@ -39,4 +39,6 @@
 gma500_gfx-$(CONFIG_ACPI) +=  opregion.o
 gma500_gfx-$(CONFIG_DRM_FBDEV_EMULATION) +=  fbdev.o
 
+gma500_gfx-$(CONFIG_DRM_GMA500_KUNIT_TEST) += mmu_test.o
+
 obj-$(CONFIG_DRM_GMA500) += gma500_gfx.o
diff --git a/drivers/gpu/drm/gma500/mmu_test.c b/drivers/gpu/drm/gma500/mmu_test.c
new file mode 100644
index 0000000000000000000000000000000000000000..eebfaab2dde8159d0fc97da4b1bc49c7a003315d
--- /dev/null
+++ b/drivers/gpu/drm/gma500/mmu_test.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* SGX page-table tests. No device, hardware context, or MMIO is required. */
+#include <kunit/test.h>
+#include <linux/highmem.h>
+
+#include "mmu.h"
+#include "psb_drv.h"
+
+struct psb_mmu_test_context {
+	struct psb_mmu_driver driver;
+	struct psb_mmu_pd *pd;
+	struct page *pages[4];
+};
+
+static int psb_mmu_test_init(struct kunit *test)
+{
+	struct psb_mmu_test_context *ctx;
+	int i;
+
+	test->priv = NULL;
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	test->priv = ctx;
+	spin_lock_init(&ctx->driver.lock);
+	init_rwsem(&ctx->driver.sem);
+	ctx->pd = psb_mmu_alloc_pd(&ctx->driver, 1, 0);
+	if (!ctx->pd)
+		return -ENOMEM;
+	for (i = 0; i < ARRAY_SIZE(ctx->pages); i++) {
+		ctx->pages[i] = alloc_page(GFP_DMA32);
+		if (!ctx->pages[i])
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+static void psb_mmu_test_exit(struct kunit *test)
+{
+	struct psb_mmu_test_context *ctx = test->priv;
+	int i;
+
+	if (!ctx)
+		return;
+
+	if (ctx->pd) {
+		psb_mmu_free_pagedir(ctx->pd);
+		ctx->pd = NULL;
+	}
+	for (i = 0; i < ARRAY_SIZE(ctx->pages); i++) {
+		if (ctx->pages[i]) {
+			__free_page(ctx->pages[i]);
+			ctx->pages[i] = NULL;
+		}
+	}
+	test->priv = NULL;
+}
+
+static u32 psb_mmu_test_pte(struct psb_mmu_pd *pd, u32 address)
+{
+	struct psb_mmu_pt *pt = pd->tables[address >> PSB_PDE_SHIFT];
+	u32 *entries;
+	u32 value;
+
+	if (!pt)
+		return pd->invalid_pte;
+	entries = kmap_local_page(pt->p);
+	value = entries[(address >> PAGE_SHIFT) & 0x3ff];
+	kunmap_local(entries);
+	return value;
+}
+
+static void psb_mmu_zero_pages_test(struct kunit *test)
+{
+	struct psb_mmu_test_context *ctx = test->priv;
+
+	KUNIT_EXPECT_EQ(test, psb_mmu_insert_pages(ctx->pd, NULL, 0, 0,
+						   0, 0, 0), 0);
+	KUNIT_EXPECT_EQ(test, psb_mmu_insert_pfn_sequence(ctx->pd, 0,
+							  0, 0, 0), 0);
+	psb_mmu_remove_pages(ctx->pd, 0, 0, 0, 0);
+	psb_mmu_remove_pfn_sequence(ctx->pd, 0, 0);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->pd->tables[0], NULL);
+}
+
+static void psb_mmu_zero_pages_existing_test(struct kunit *test)
+{
+	struct psb_mmu_test_context *ctx = test->priv;
+	u32 retained;
+
+	KUNIT_ASSERT_EQ(test, psb_mmu_insert_pages(ctx->pd, ctx->pages,
+						   0x1000, 1, 0, 0, 0), 0);
+	retained = psb_mmu_test_pte(ctx->pd, 0x1000);
+	KUNIT_EXPECT_EQ(test, psb_mmu_insert_pages(ctx->pd, NULL,
+						   0x1000, 0, 0, 1, 0), 0);
+	KUNIT_EXPECT_EQ(test, psb_mmu_insert_pfn_sequence(ctx->pd, 0,
+							  0x1000, 0, 0), 0);
+	psb_mmu_remove_pages(ctx->pd, 0x1000, 0, 0, 1);
+	psb_mmu_remove_pfn_sequence(ctx->pd, 0x1000, 0);
+	KUNIT_EXPECT_EQ(test, psb_mmu_test_pte(ctx->pd, 0x1000), retained);
+	KUNIT_EXPECT_EQ(test, ctx->pd->tables[0]->count, 1U);
+}
+
+static void psb_mmu_range_test(struct kunit *test)
+{
+	struct psb_mmu_test_context *ctx = test->priv;
+
+	KUNIT_EXPECT_EQ(test, psb_mmu_insert_pages(ctx->pd, ctx->pages,
+						   1, 1, 0, 0, 0), -EINVAL);
+	KUNIT_EXPECT_EQ(test, psb_mmu_insert_pages(ctx->pd, ctx->pages,
+						   0xfffff000UL, 2, 0, 0, 0),
+			-ERANGE);
+	KUNIT_EXPECT_EQ(test, psb_mmu_insert_pages(ctx->pd, ctx->pages,
+						   0, 4, 0, 4, 0), -EINVAL);
+	KUNIT_EXPECT_EQ(test, psb_mmu_insert_pages(ctx->pd, ctx->pages,
+						   0, 4, 3, 4, 0), -EINVAL);
+	KUNIT_EXPECT_EQ(test, psb_mmu_insert_pages(ctx->pd, ctx->pages,
+						   0, 4, 2, 1, 0), -EINVAL);
+	KUNIT_EXPECT_EQ(test, psb_mmu_insert_pages(ctx->pd, ctx->pages,
+						   0, 4, 2, U32_MAX, 0), -ERANGE);
+	KUNIT_EXPECT_EQ(test, psb_mmu_insert_pages(ctx->pd, NULL,
+						   0, 1, 0, 0, 0), -EINVAL);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->pd->tables[0], NULL);
+}
+
+static void psb_mmu_last_page_test(struct kunit *test)
+{
+	struct psb_mmu_test_context *ctx = test->priv;
+
+	KUNIT_ASSERT_EQ(test, psb_mmu_insert_pages(ctx->pd, ctx->pages,
+						   0xfffff000UL, 1, 0, 0, 0), 0);
+	KUNIT_EXPECT_EQ(test, psb_mmu_test_pte(ctx->pd, 0xfffff000),
+			(u32)(page_to_pfn(ctx->pages[0]) << PAGE_SHIFT) |
+			PSB_PTE_VALID);
+	psb_mmu_remove_pages(ctx->pd, 0xfffff000UL, 1, 0, 0);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->pd->tables[1023], NULL);
+}
+
+static void psb_mmu_directory_boundary_test(struct kunit *test)
+{
+	struct psb_mmu_test_context *ctx = test->priv;
+
+	KUNIT_ASSERT_EQ(test, psb_mmu_insert_pages(ctx->pd, ctx->pages,
+						   0x3ff000, 2, 0, 0, 0), 0);
+	KUNIT_EXPECT_EQ(test, ctx->pd->tables[0]->count, 1U);
+	KUNIT_EXPECT_EQ(test, ctx->pd->tables[1]->count, 1U);
+	psb_mmu_remove_pages(ctx->pd, 0x3ff000, 2, 0, 0);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->pd->tables[0], NULL);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->pd->tables[1], NULL);
+}
+
+static void psb_mmu_collision_rollback_test(struct kunit *test)
+{
+	struct psb_mmu_test_context *ctx = test->priv;
+	u32 retained;
+
+	KUNIT_ASSERT_EQ(test, psb_mmu_insert_pages(ctx->pd, ctx->pages + 3,
+						   0x400000, 1, 0, 0, 0), 0);
+	retained = psb_mmu_test_pte(ctx->pd, 0x400000);
+	KUNIT_EXPECT_EQ(test, psb_mmu_insert_pages(ctx->pd, ctx->pages,
+						   0x3ff000, 2, 0, 0, 0), -EBUSY);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->pd->tables[0], NULL);
+	KUNIT_EXPECT_EQ(test, psb_mmu_test_pte(ctx->pd, 0x400000), retained);
+	KUNIT_EXPECT_EQ(test, ctx->pd->tables[1]->count, 1U);
+}
+
+static void psb_mmu_tiled_rollback_test(struct kunit *test)
+{
+	struct psb_mmu_test_context *ctx = test->priv;
+	u32 retained;
+
+	KUNIT_ASSERT_EQ(test, psb_mmu_insert_pages(ctx->pd, ctx->pages + 3,
+						   0x8000, 1, 0, 0, 0), 0);
+	retained = psb_mmu_test_pte(ctx->pd, 0x8000);
+	KUNIT_EXPECT_EQ(test, psb_mmu_insert_pages(ctx->pd, ctx->pages,
+						   0x3000, 4, 2, 4, 0), -EBUSY);
+	KUNIT_EXPECT_EQ(test, psb_mmu_test_pte(ctx->pd, 0x3000), 0U);
+	KUNIT_EXPECT_EQ(test, psb_mmu_test_pte(ctx->pd, 0x4000), 0U);
+	KUNIT_EXPECT_EQ(test, psb_mmu_test_pte(ctx->pd, 0x7000), 0U);
+	KUNIT_EXPECT_EQ(test, psb_mmu_test_pte(ctx->pd, 0x8000), retained);
+	KUNIT_EXPECT_EQ(test, ctx->pd->tables[0]->count, 1U);
+}
+
+static void psb_mmu_pfn_range_test(struct kunit *test)
+{
+	struct psb_mmu_test_context *ctx = test->priv;
+
+	KUNIT_EXPECT_EQ(test, psb_mmu_insert_pfn_sequence(ctx->pd, 0x100000,
+							  0, 1, 0), -ERANGE);
+	KUNIT_EXPECT_EQ(test, psb_mmu_insert_pfn_sequence(ctx->pd, 0xfffff,
+							  0, 2, 0), -ERANGE);
+	KUNIT_ASSERT_EQ(test, psb_mmu_insert_pfn_sequence(ctx->pd, 0xfffff,
+							  0, 1, 0), 0);
+	KUNIT_EXPECT_EQ(test, psb_mmu_test_pte(ctx->pd, 0), 0xfffff001U);
+	psb_mmu_remove_pfn_sequence(ctx->pd, 0, 1);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->pd->tables[0], NULL);
+}
+
+static void psb_mmu_pfn_rollback_test(struct kunit *test)
+{
+	struct psb_mmu_test_context *ctx = test->priv;
+	u32 retained;
+
+	KUNIT_ASSERT_EQ(test, psb_mmu_insert_pfn_sequence(ctx->pd, 0x100,
+							  0x400000, 1, 0), 0);
+	retained = psb_mmu_test_pte(ctx->pd, 0x400000);
+	KUNIT_EXPECT_EQ(test, psb_mmu_insert_pfn_sequence(ctx->pd, 0x200,
+							  0x3ff000, 2, 0), -EBUSY);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->pd->tables[0], NULL);
+	KUNIT_EXPECT_EQ(test, psb_mmu_test_pte(ctx->pd, 0x400000), retained);
+	KUNIT_EXPECT_EQ(test, ctx->pd->tables[1]->count, 1U);
+}
+
+static void psb_mmu_remove_hole_test(struct kunit *test)
+{
+	struct psb_mmu_test_context *ctx = test->priv;
+
+	KUNIT_ASSERT_EQ(test, psb_mmu_insert_pages(ctx->pd, ctx->pages,
+						   0x1000, 1, 0, 0, 0), 0);
+	psb_mmu_remove_pages(ctx->pd, 0x2000, 1, 0, 0);
+	KUNIT_EXPECT_EQ(test, ctx->pd->tables[0]->count, 1U);
+	psb_mmu_remove_pages(ctx->pd, 0x1000, 1, 0, 0);
+	psb_mmu_remove_pfn_sequence(ctx->pd, 0x400000, 1);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->pd->tables[0], NULL);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->pd->tables[1], NULL);
+}
+
+static struct kunit_case psb_mmu_test_cases[] = {
+	KUNIT_CASE(psb_mmu_zero_pages_test),
+	KUNIT_CASE(psb_mmu_zero_pages_existing_test),
+	KUNIT_CASE(psb_mmu_range_test),
+	KUNIT_CASE(psb_mmu_last_page_test),
+	KUNIT_CASE(psb_mmu_directory_boundary_test),
+	KUNIT_CASE(psb_mmu_collision_rollback_test),
+	KUNIT_CASE(psb_mmu_tiled_rollback_test),
+	KUNIT_CASE(psb_mmu_pfn_range_test),
+	KUNIT_CASE(psb_mmu_pfn_rollback_test),
+	KUNIT_CASE(psb_mmu_remove_hole_test),
+	{}
+};
+
+static struct kunit_suite psb_mmu_test_suite = {
+	.name = "psb_mmu",
+	.init = psb_mmu_test_init,
+	.exit = psb_mmu_test_exit,
+	.test_cases = psb_mmu_test_cases,
+};
+
+kunit_test_suite(psb_mmu_test_suite);

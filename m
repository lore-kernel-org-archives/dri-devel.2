Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E63606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MHTlOSMW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C8F710F075;
	Mon,  9 Nov 2026 06:33:35 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447DF10F047
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 06:33:22 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-8b30cbfa628so6030497b3.0
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 22:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794206001; x=1794810801; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bbiYo4XQdqtXLflBIgUQ6cqwEM2/qO2HLfR2tdik1Z4=;
 b=MHTlOSMWGRBelDu10gLWtAGaHl4+utcH/JAdcDOpcS/wfITju5fkXhTvkBHuQQd/ar
 fSbzgWbrtkxqP7WS67QeX6ZPnzDjwBKnF8KXk8n1w+sarSi40Jt0P91aj5rR8zC1GC0p
 YZ6Ejb1U/fTyyrHgXDyhzWp8ApWdIdJLCt127aiatjTX3MrEIC4FNAA8JysNfylLke5B
 4CoaV9ZLCoEYxcXAQAn0vb1p3fApaCQj0RMC7vR8ULWu90vCSXtJ1P/rq2MY0xoYeifI
 FS1lRpWXR42PX93F+ctWOndKQMXgRnmo0ZcByjRC4y8U4WYuXp7ohEfxfyMdhgrYsgTZ
 mt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794206001; x=1794810801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bbiYo4XQdqtXLflBIgUQ6cqwEM2/qO2HLfR2tdik1Z4=;
 b=knuTzmSK0ZQJnJvXpDQ9a0p0I+n6Br52GlErHb33OdNpIP2wX58d5JJFKLcAWnoBbR
 f7niLCbC42BgQ0DlkzKnO6mynU3gluT4M3a4iT/5rReDWmOCIg0qKCHe6E+Gnfi+EFYH
 B+UzwgMIqT3pOVU5l2IUegwAKfCQN+ogLu7hl4fanWU3uxtM+Nk5ZVjGZwd3AzD5TSQd
 G3JyrnKhTDbapqsv4cZzcALOwd8gqW14n8yzYxQPocqKoTUNTszp7s7iHfJEIDBzYDKX
 E0MTNXCau1xOuC68CQE7xmO3StqLqcQcD/D0DcBw3kZFfs2JFTizQcYzdKRz3Zpk5cDY
 u1hw==
X-Gm-Message-State: APuU4Z9ukztrv6eA5MB27iuQdIF/wROnZBbEFVCWmDFYpyp26uxma+cK
 WQ6nCWUHf9woLK3H8x2xZvBCAXAgiTwggntKBII6d4jdH2izdwxMx8Qatx/DWA==
X-Gm-Gg: AYBFou2Q097XZqxEZ0CvS3jsGNhFzIbAVoXoYgsMzckAwBXATPMSBDoP0AgYLZDY0UF
 9nFxj4lkVzg1UwsRDJP9VxqGz4XeSVaWgHSF8MuIKX+9YN23vkyNvIiJmnEL1e9y57MSE1xrKWG
 2MHmVX1IUmOWUQ8t197jfr8W7+8bqTiSxtk1W1EF/akOmV7HDwDm0vcaL/XmIScMvXSH1knzYPJ
 ZRKkCRXyg01GvvvjAngS4HgwA84pFs8zd8Sv2n5vWcwPJsRfXBQIESdmeuk9C0oiNMVVq8GdqCM
 I3cifuAyywalByNm5NgFo2qIfWQxdfPnCzKqCVQ9lMoKYa64UASFbYF6Q0LsIkErDXbUPRRkTLB
 Mpf6FmSPFkl9x0Sfj9tQfip2J4nseP6Pw90015n5y+u6HWw0ELpEq9q3rQxbF7BnriOeWccp/U1
 f6lt7FsQ0YWZPykKrq+lBuICe+xi7hRrJS4Uz4hjVBrU7IyBD3VltSnc16xnj/fs9lI0+uN4OFh
 esoTjH9M0xEOOyLoW4tXiNPRVVlRMe7mWDDriuOcBXzfiIZHgQfMZbjVgvwwCbVfl5yTKdxn8TR
 YwYwFMl4Yrvfyd7KcwlE3ZdzuZGINWV4qz5cm2Zh8Xe0c7cpbY6GOAgD9ffnQqxyjwU=
X-Received: by 2002:a05:690c:97:b0:8b3:4911:2dad with SMTP id
 00721157ae682-8b36ca11c14mr19725807b3.30.1794206001186; 
 Sun, 08 Nov 2026 22:33:21 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:8485:f8a0:b2aa:dee6])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b36bc43733sm29035827b3.33.2026.11.08.22.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 22:33:20 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: patrik.r.jakobsson@gmail.com
Subject: [RFC PATCH v2 6/6] drm/gma500: Add software-only KUnit coverage for
 SGX page tables
Date: Mon,  9 Nov 2026 03:33:03 -0300
Message-ID: <20261109063303.32658-7-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109063303.32658-1-operatingsystemsdepression@gmail.com>
References: <20261109063303.32658-1-operatingsystemsdepression@gmail.com>
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

Add KUnit cases for invalid ranges and tiles, the final GPU page,
directory crossings, PFN limits, collision rollback and removal holes.

The optional built-in fixture uses a software page directory with no DRM
device and hw_context=-1. It performs no MMIO or GPU submission.

KUnit calls the per-case exit callback even after init fails. Use one
NULL-safe cleanup for partial initialization and clear released pointers
and test->priv so repeated cleanup cannot release resources twice.

Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>
---
 drivers/gpu/drm/gma500/Kconfig    |  10 ++
 drivers/gpu/drm/gma500/Makefile   |   2 +
 drivers/gpu/drm/gma500/mmu_test.c | 230 ++++++++++++++++++++++++++++++
 3 files changed, 242 insertions(+)
 create mode 100644 drivers/gpu/drm/gma500/mmu_test.c

diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
index dc4c56638..b6e2dda13 100644
--- a/drivers/gpu/drm/gma500/Kconfig
+++ b/drivers/gpu/drm/gma500/Kconfig
@@ -16,3 +16,13 @@ config DRM_GMA500
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
index 58fed80c7..069400d70 100644
--- a/drivers/gpu/drm/gma500/Makefile
+++ b/drivers/gpu/drm/gma500/Makefile
@@ -39,4 +39,6 @@ gma500_gfx-y += \
 gma500_gfx-$(CONFIG_ACPI) +=  opregion.o
 gma500_gfx-$(CONFIG_DRM_FBDEV_EMULATION) +=  fbdev.o
 
+gma500_gfx-$(CONFIG_DRM_GMA500_KUNIT_TEST) += mmu_test.o
+
 obj-$(CONFIG_DRM_GMA500) += gma500_gfx.o
diff --git a/drivers/gpu/drm/gma500/mmu_test.c b/drivers/gpu/drm/gma500/mmu_test.c
new file mode 100644
index 000000000..f9dbe66cd
--- /dev/null
+++ b/drivers/gpu/drm/gma500/mmu_test.c
@@ -0,0 +1,230 @@
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
+	for (i = 0; i < ARRAY_SIZE(ctx->pages); i++) {
+		if (ctx->pages[i]) {
+			__free_page(ctx->pages[i]);
+			ctx->pages[i] = NULL;
+		}
+	}
+	if (ctx->pd) {
+		psb_mmu_free_pagedir(ctx->pd);
+		ctx->pd = NULL;
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

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CF6606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fq5o2D9m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4D7710E685;
	Mon,  9 Nov 2026 05:55:18 +0000 (UTC)
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com
 [74.125.224.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 841DB10E125
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 05:55:11 +0000 (UTC)
Received: by mail-yx1-f48.google.com with SMTP id
 956f58d0204a3-67990a45e02so433486d50.3
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 21:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794203710; x=1794808510; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/bvRK7S+n7S4510c95Yn3kuWggctXxRt3R5XIeRhEL8=;
 b=fq5o2D9mDq9c3VUmEdhUdzWk9RfS1tOuOAgzqLFniLlXE3oP1KwB5dyED5rphar2gY
 tOU6XcwfPViLVh4wwUz/hqzqotZ+h6Zwd/iKl7MyBRsUGxqFONEBu6DPIaJq/f0HAYZq
 nn+XCVLmUCh+867V2twZfgQ+lxXG25SD6x6jw2JmRpQSM7aV/VS1bI2nKQegPzdNgVwT
 vD5YFEXnK//G/i4vj40eou4PHe7MayDWh6OjWpL3nl4jjKU2+ly7BZyOMbBZq7bMO0Ip
 58/0ZE3N0KsPsXkp9cBLT/ko/CDJ+biTmnPi/XEBZHsT0FN5MjcfHsyehpGUywwd4Nl7
 bN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794203710; x=1794808510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/bvRK7S+n7S4510c95Yn3kuWggctXxRt3R5XIeRhEL8=;
 b=neR+y7aRmbQvCY+r8WVrIt9U0QImtXMjrBIb3cx7FZgv6pBHdjjfipyi911jWwM1SU
 nC2zgQxekFP0+6loppsI8oWOd3LOzkkjFBdrXADSPQ4Qs/+bc7Qrs5vXHlQhrO6NTQOl
 TMEuRxu3zzOhhmhaq4CndC1p4RYuiyHCkwBV1yFfGo4MTjBngs2R5v3EleNaZNnb01Rp
 rSfyLJY0tO6JbO4DGUuI2XZFNTBNKoAIhPGlERbkQhvjG83vlVv/xggcEB2QaWlRG9w6
 fEInP3llH14dW4KfQwPUiLM/GdeOqb5BVsECLDWSaF8f9UYjec/9398LbW7fzWEqNIEz
 JB2A==
X-Gm-Message-State: APuU4Z9j8ejiv84sdutQSft9K9fwBPcNmvQMjxeBDgKvszBUU4/M+egd
 LIWLfV/aqg/pxIDOkwDCoHJZkRsMa09TXay9aWchI1OcXwCCjD7axsIKkK/BoJx3
X-Gm-Gg: AYBFou0HzUnNWxUQw94XmUOAhmxmbsGhRhZH/MWswwAxEriXMPQuK+79sZQsrkZWEDU
 z6lCxBMjWtT8pPEmNhj+lbqvGdmOXLjqs+Kc9gzlDltoTEcPyYr3B3KvYjNQ6WH7RdDITrANb/+
 UeNtKNxfbBmpt+W6qo74Ob9IdU4sNRv7gWfEEDX2f0DQoJjpiFDBGNEfP11iDv6tWY1POUQwb46
 /ak19eK9Azv/IOV+pHrp/kfpXvrzXA6hfIQXRI8kB5WCxOxK0N0+HWmW5FxKlhLA8MNBGaXEjHy
 IVNtfo6tvxWrRbzcqwdJc7scA7sPkALqnUM9tvJbAiiKrZ73RF/krcpeEHodP3WrtOhdr3t4pWE
 VftRNsvQ6IdpLoFMz5wvcEGioy2QD8t4wf0eTYtYrGlWy8VHurMv35igEPiggwKubN7aRoWC6pB
 CmiNWi6XKJzJ0/kHTkaHaSSFEnNHoczpDfY2pR5T1v7zyQ2FR4pQdpECRReBf1mqM0Q9RXTJ+Li
 mV46C1ZD/5K/zmxop074IOIFuaDC2y8AD6QHTGA0Fdv+O7GsV0GEUDoSTXFRnk3qRx9xS9sb3pL
 d2xhVJzNHYPsnYeuORlCXmrCSvCiyWk9JM2PkaNGO8GHmDbCBsrFdl4Ng960O6pyexE=
X-Received: by 2002:a05:690e:1488:b0:67c:1e85:bbe8 with SMTP id
 956f58d0204a3-67c3d9bece0mr2355943d50.52.1794203710371; 
 Sun, 08 Nov 2026 21:55:10 -0800 (PST)
Received: from localhost.localdomain
 ([2804:1254:81a4:f900:8485:f8a0:b2aa:dee6])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67c3b83e8bdsm3312398d50.1.2026.11.08.21.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 21:55:10 -0800 (PST)
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: patrik.r.jakobsson@gmail.com,
 Gabriel Gama <operatingsystemsdepression@gmail.com>
Subject: [RFC PATCH 6/6] drm/gma500: Add software-only KUnit coverage for SGX
 page tables
Date: Mon,  9 Nov 2026 02:54:50 -0300
Message-ID: <20261109055451.17458-7-operatingsystemsdepression@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109055451.17458-1-operatingsystemsdepression@gmail.com>
References: <20261109055451.17458-1-operatingsystemsdepression@gmail.com>
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

Signed-off-by: Gabriel Gama <operatingsystemsdepression@gmail.com>

---
 drivers/gpu/drm/gma500/Kconfig    |  10 ++
 drivers/gpu/drm/gma500/Makefile   |   2 +
 drivers/gpu/drm/gma500/mmu_test.c | 222 ++++++++++++++++++++++++++++++
 3 files changed, 234 insertions(+)
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
index 000000000..0581c7d9a
--- /dev/null
+++ b/drivers/gpu/drm/gma500/mmu_test.c
@@ -0,0 +1,222 @@
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
+		if (!ctx->pages[i]) {
+			while (i--)
+				__free_page(ctx->pages[i]);
+			psb_mmu_free_pagedir(ctx->pd);
+			return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
+static void psb_mmu_test_exit(struct kunit *test)
+{
+	struct psb_mmu_test_context *ctx = test->priv;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ctx->pages); i++)
+		__free_page(ctx->pages[i]);
+	psb_mmu_free_pagedir(ctx->pd);
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

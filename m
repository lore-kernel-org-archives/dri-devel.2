Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BC9606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=uA0Udi4N
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 239E810F89F;
	Tue,  3 Nov 2026 21:38:29 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013005.outbound.protection.outlook.com
 [40.93.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B50310F879;
 Tue,  3 Nov 2026 21:38:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfI+ialANO82J1wiY+1CIdYKdaLZiLhRw7pjP1VWWqRwyqmfUYAZWCZxKk1gnY6VYlRPNq6xBmlpqoMxl1WBSXeDY7Ji+v3Xrh94rvrnNAuuiy4zVxhA1sZKVlh7ur7bUi7lwjGIsdlEvAJEpShas2Do8Syg5yR6GH5G9Fr2vPlSiBEGCjNTRdKZFI+IhplL4Q63TQtgubYC0XjAP0ZReMaVClMTAIBwXJXlA6Abx947Y8ojFj9A5Lb7IGSOHKmNwGtJaPktbBZa+JdNLusOpu0LreYBBIURIcO+BXxin8/4CksZ3kfY7YsWY8/906sAf+cyoEJnArSCoasDT1RshA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QazXXsJ0E6+lgHH91Yyp2NsiTQBLG436xiF1pFssi98=;
 b=BMokiyX5j8vflJhSF/JAQvWN2iT5m70fXNvTp/+e/S5EDl40rZwWQw85Kvwr0AZxPoO52/qcBf33cNphk/I/UjURzc6BVg3aJkvYG46A9nItXsXQHsRtypuHgf9n6JBSS1pJnheGX1+w33ksT2Kj/RSXd/M3wsHyQNuRKnA5s2AXlBJfOD5L35UMwtBj9AB1i29qjGs3zAT/iT4h+bqbx9/wk7s62MHqKWMbsUiUhAANhep83aA2cHMqhat/qVwwn/kesBRdaw/iwyD3eOfLz7SZhdvQ3Xp4GQZTFSeSoz1BIAwgE341e1vJkmMEvzuTwX88gws87TJncgRLGEQ9nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QazXXsJ0E6+lgHH91Yyp2NsiTQBLG436xiF1pFssi98=;
 b=uA0Udi4Nrf//mP3xTfFRkW6HhDPQBT+jLCjzFF6rCu3NN9sor4YDEb+d8G+r19yk/uvnw1LKXtNhdsvoHZC/QtJdooGZuDLGuLovG1CiR1r+Oqri+3WbDVuOB0UuTaA1yS7Buv4omTu/Nn57J5oos7cCfhVXJeIp/i3IMM4UrqA=
Received: from BN1PR13CA0019.namprd13.prod.outlook.com (2603:10b6:408:e2::24)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 21:38:09 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::9b) by BN1PR13CA0019.outlook.office365.com
 (2603:10b6:408:e2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 21:38:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 21:38:08 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 15:38:06 -0600
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 15:38:06 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v1 06/13] drm/tests: test colorop prepare_fb and cleanup_fb
 helpers
Date: Tue, 3 Nov 2026 16:37:49 -0500
Message-ID: <20261103213756.618024-7-harry.wentland@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103213756.618024-1-harry.wentland@amd.com>
References: <20261103213756.618024-1-harry.wentland@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 3040e52a-a038-48b6-e769-08df39f2c0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|261022075727099003|261021121427099003|261028144727099003|261102123227099003|261026140227099003|261009221727099003|261009221227099003|261009220027099003|261009223027099003|261009223327099003|261022115727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: Exx4fsbbZnrZj7esNrk78BK5CU8OG80EYMOM3U//vrwAitoxlgPJi0xJQTiWf82ADy/rID9s5/M7O0B8dZGGnzxfNZYKdlxogjQQYcn/a9BGVsB9AhuYc+cy7tXG+b1zJ1pHetgNbcnZNJYqI6xTUvGAYVtJmbFkaW65hWl7pjPvaKbWyASomGbCRjPjJhh4NSoIp0ex5K2aT4XK7R5qwmyBeUGeft+5dWkbjFtXuZEOBp+4/WKw/n4cX/vpSFCuJQfOMPM7d62ADsOywnV03Vty0sS0oeuy5fOdzK79WhKlF+eluf4zHqfD61dzYbh0Iv2s5BWnm+XaqINmUae/H9f0RjLTnkd7+gdpg2lnAkaQUdJEzJ8aHA1EYLRE2X5lb9iG6OdL05Hw+IhDurB72b7nagx2eMUnc/FwGanE+D7etW+6CPYOYiKL4pQGksjk2dNNvgUatxjksXhwnLL1lfpskHXsq7fJM0KSkasvVHli0T4q13wIdIFUZteq7QKUaxe5SUR5YbciZ1jlpCfh5j4QGsc4OYjGXO+aRupHsaUpav6pqploWvgilrKPf5hHAheYToH+ugAgQ+8MvMRE7ClGZ1X6XC8MW09x1/i5h4ZwymKKknvMkkqxHqxmiDkHl7VxV0BAdsYt0VzpuSFqJtmFrscq61dYcUNtNI4BICY5XLknq2ixNJ6GFJR5S8xsFcV0A7BLFQ0H0cOvtw2PQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261022075727099003)(261021121427099003)(261028144727099003)(261102123227099003)(261026140227099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223027099003)(261009223327099003)(261022115727099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bvl/a+VOu0pI4DP8w6QdlSoIm8ZcxF8EsbxAiHN+wCDK3AT0+iw+RkznVWr0mdP8C4ttFS6keAD/lvd3ODvM7w3zB71VARWEBbxe/DsfvxcmEINaegc/6mnQCzqMZ7sSlKrrljppAbV9bcV7GTjG7eMc4TZCHOorDFZyytfNusawEMMss3RbycCEljeY6LZ3juw8Sa08X1eKZZiM28SZSiYxQEuvRQSok54MZV1B9lQMaVufmtaGOAWmbNssB5TcabOeaRwO6KKbMedUkGCh6iXixMfcdsRtFW5Bx58AdqSaHjbEV6eWvNrTb9lLwwb2gl8AppEUq6siD8KPaQ/5BTK4pc06lR6lIFHcPagR5qm7iCgx4GnTrBI01yHW8OL3Rkdz6kOH1EZR9pYj30WhDtmIBQqKgecQYnS74PpZ5omLLBL2nX3NSPVvWHlYRd6+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:38:08.9719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3040e52a-a038-48b6-e769-08df39f2c0d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_atomic_helper_prepare_planes() prepares the framebuffers of the
colorops in a commit before those of the planes, and has to unwind
them on every failure path. Each prepared colorop state has to be
cleaned up exactly once, on the abort path through
drm_atomic_helper_unprepare_planes() or, after the state swap, through
drm_atomic_helper_cleanup_planes() on the old state.

Add KUnit tests with mock colorop and plane helpers that record their
calls and can fail on request. Check that:

- colorops are prepared once, before the planes;
- a failing colorop unwinds only the colorops prepared before it;
- a failing plane prepare_fb or begin_fb_access cleans up all
  colorops;
- unprepare_planes() cleans up the new colorop states;
- cleanup_planes() after the swap cleans up the old colorop states.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/tests/Makefile                |   1 +
 .../gpu/drm/tests/drm_colorop_helper_test.c   | 397 ++++++++++++++++++
 2 files changed, 398 insertions(+)
 create mode 100644 drivers/gpu/drm/tests/drm_colorop_helper_test.c

diff --git a/drivers/gpu/drm/tests/Makefile b/drivers/gpu/drm/tests/Makefile
index 42207df1d1c8..4bf8696fa49c 100644
--- a/drivers/gpu/drm/tests/Makefile
+++ b/drivers/gpu/drm/tests/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_KUNIT_TEST) += \
 	drm_atomic_commit_test.o \
 	drm_bridge_test.o \
 	drm_cmdline_parser_test.o \
+	drm_colorop_helper_test.o \
 	drm_connector_test.o \
 	drm_damage_helper_test.o \
 	drm_dp_mst_helper_test.o \
diff --git a/drivers/gpu/drm/tests/drm_colorop_helper_test.c b/drivers/gpu/drm/tests/drm_colorop_helper_test.c
new file mode 100644
index 000000000000..2a650500dd60
--- /dev/null
+++ b/drivers/gpu/drm/tests/drm_colorop_helper_test.c
@@ -0,0 +1,397 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for the colorop prepare_fb and cleanup_fb atomic helper hooks
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_colorop.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_kunit_helpers.h>
+#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_modeset_lock.h>
+
+#include <kunit/test.h>
+#include <kunit/test-bug.h>
+
+#define TEST_NUM_COLOROPS	3
+
+struct colorop_hook_calls {
+	int prepared;
+	int cleaned;
+	int prepare_seq;
+	struct drm_colorop_state *prepared_state;
+	struct drm_colorop_state *cleaned_state;
+};
+
+struct colorop_test_priv {
+	struct drm_device *drm;
+	struct drm_plane *plane;
+	struct drm_colorop *colorops[TEST_NUM_COLOROPS];
+	struct drm_atomic_commit *state;
+
+	/* Fault injection */
+	int colorop_fail_at;
+	int plane_prepare_ret;
+	int plane_begin_access_ret;
+
+	/* Recorded calls */
+	int seq;
+	struct colorop_hook_calls colorop[TEST_NUM_COLOROPS];
+	int plane_prepared;
+	int plane_prepare_seq;
+	int plane_cleaned;
+	int plane_end_access;
+};
+
+static struct colorop_test_priv *colorop_test_priv(void)
+{
+	return kunit_get_current_test()->priv;
+}
+
+static int colorop_test_prepare_fb(struct drm_colorop *colorop,
+				   struct drm_colorop_state *new_state)
+{
+	struct colorop_test_priv *priv = colorop_test_priv();
+	struct colorop_hook_calls *calls = &priv->colorop[colorop->index];
+
+	calls->prepared++;
+	calls->prepare_seq = priv->seq++;
+	calls->prepared_state = new_state;
+
+	return (int)colorop->index == priv->colorop_fail_at ? -EIO : 0;
+}
+
+static void colorop_test_cleanup_fb(struct drm_colorop *colorop,
+				    struct drm_colorop_state *state)
+{
+	struct colorop_test_priv *priv = colorop_test_priv();
+	struct colorop_hook_calls *calls = &priv->colorop[colorop->index];
+
+	calls->cleaned++;
+	calls->cleaned_state = state;
+}
+
+static const struct drm_colorop_helper_funcs colorop_test_helper_funcs = {
+	.prepare_fb = colorop_test_prepare_fb,
+	.cleanup_fb = colorop_test_cleanup_fb,
+};
+
+static const struct drm_colorop_funcs colorop_test_funcs = {
+	.destroy = drm_colorop_destroy,
+};
+
+static int plane_test_prepare_fb(struct drm_plane *plane,
+				 struct drm_plane_state *new_state)
+{
+	struct colorop_test_priv *priv = colorop_test_priv();
+
+	priv->plane_prepared++;
+	priv->plane_prepare_seq = priv->seq++;
+
+	return priv->plane_prepare_ret;
+}
+
+static void plane_test_cleanup_fb(struct drm_plane *plane,
+				  struct drm_plane_state *state)
+{
+	colorop_test_priv()->plane_cleaned++;
+}
+
+static int plane_test_begin_fb_access(struct drm_plane *plane,
+				      struct drm_plane_state *new_state)
+{
+	return colorop_test_priv()->plane_begin_access_ret;
+}
+
+static void plane_test_end_fb_access(struct drm_plane *plane,
+				     struct drm_plane_state *new_state)
+{
+	colorop_test_priv()->plane_end_access++;
+}
+
+static const struct drm_plane_helper_funcs plane_test_helper_funcs = {
+	.prepare_fb = plane_test_prepare_fb,
+	.cleanup_fb = plane_test_cleanup_fb,
+	.begin_fb_access = plane_test_begin_fb_access,
+	.end_fb_access = plane_test_end_fb_access,
+};
+
+static void colorop_test_pipeline_destroy(void *drm)
+{
+	drm_colorop_pipeline_destroy(drm);
+}
+
+static void colorop_test_acquire_fini(void *ptr)
+{
+	struct drm_modeset_acquire_ctx *ctx = ptr;
+
+	drm_modeset_drop_locks(ctx);
+	drm_modeset_acquire_fini(ctx);
+}
+
+/*
+ * Create a plane with a chain of colorops, and an atomic state containing the
+ * plane and all colorops.
+ */
+static int colorop_test_init(struct kunit *test)
+{
+	struct drm_modeset_acquire_ctx *ctx;
+	struct colorop_test_priv *priv;
+	struct drm_plane_state *plane_state;
+	struct device *dev;
+	int i, ret;
+
+	priv = kunit_kzalloc(test, sizeof(*priv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, priv);
+	priv->colorop_fail_at = -1;
+	test->priv = priv;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	priv->drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+							sizeof(*priv->drm), 0,
+							DRIVER_MODESET | DRIVER_ATOMIC);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->drm);
+
+	priv->plane = drm_kunit_helper_create_primary_plane(test, priv->drm, NULL,
+							    &plane_test_helper_funcs,
+							    NULL, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->plane);
+
+	/* Destroy the colorops after the atomic state that references them. */
+	ret = kunit_add_action_or_reset(test, colorop_test_pipeline_destroy,
+					priv->drm);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	for (i = 0; i < TEST_NUM_COLOROPS; i++) {
+		struct drm_colorop *colorop;
+
+		colorop = kzalloc_obj(*colorop);
+		KUNIT_ASSERT_NOT_NULL(test, colorop);
+
+		ret = drm_plane_colorop_mult_init(priv->drm, colorop, priv->plane,
+						  &colorop_test_funcs,
+						  DRM_COLOROP_FLAG_ALLOW_BYPASS);
+		if (ret)
+			kfree(colorop);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+
+		drm_colorop_helper_add(colorop, &colorop_test_helper_funcs);
+		if (i)
+			drm_colorop_set_next_property(priv->colorops[i - 1], colorop);
+		priv->colorops[i] = colorop;
+	}
+
+	drm_mode_config_reset(priv->drm);
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	drm_modeset_acquire_init(ctx, 0);
+	ret = kunit_add_action_or_reset(test, colorop_test_acquire_fini, ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	priv->state = drm_kunit_helper_atomic_state_alloc(test, priv->drm, ctx);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, priv->state);
+
+	plane_state = drm_atomic_get_plane_state(priv->state, priv->plane);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_state);
+
+	for (i = 0; i < TEST_NUM_COLOROPS; i++) {
+		struct drm_colorop_state *colorop_state;
+
+		colorop_state = drm_atomic_get_colorop_state(priv->state,
+							     priv->colorops[i]);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, colorop_state);
+	}
+
+	return 0;
+}
+
+static struct drm_colorop_state *
+colorop_test_new_state(struct colorop_test_priv *priv, int i)
+{
+	return drm_atomic_get_new_colorop_state(priv->state, priv->colorops[i]);
+}
+
+/*
+ * A successful prepare_planes() prepares every colorop in the commit once,
+ * before the planes, without cleaning anything up. Aborting the commit with
+ * unprepare_planes() then cleans up every new colorop state once.
+ */
+static void drm_test_colorop_prepare_then_unprepare(struct kunit *test)
+{
+	struct colorop_test_priv *priv = test->priv;
+	int i, ret;
+
+	ret = drm_atomic_helper_prepare_planes(priv->drm, priv->state);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, priv->plane_prepared, 1);
+	for (i = 0; i < TEST_NUM_COLOROPS; i++) {
+		struct colorop_hook_calls *calls = &priv->colorop[i];
+
+		KUNIT_EXPECT_EQ(test, calls->prepared, 1);
+		KUNIT_EXPECT_PTR_EQ(test, calls->prepared_state,
+				    colorop_test_new_state(priv, i));
+		KUNIT_EXPECT_LT(test, calls->prepare_seq, priv->plane_prepare_seq);
+		KUNIT_EXPECT_EQ(test, calls->cleaned, 0);
+	}
+
+	drm_atomic_helper_unprepare_planes(priv->drm, priv->state);
+
+	KUNIT_EXPECT_EQ(test, priv->plane_cleaned, 1);
+	KUNIT_EXPECT_EQ(test, priv->plane_end_access, 1);
+	for (i = 0; i < TEST_NUM_COLOROPS; i++) {
+		struct colorop_hook_calls *calls = &priv->colorop[i];
+
+		KUNIT_EXPECT_EQ(test, calls->cleaned, 1);
+		KUNIT_EXPECT_PTR_EQ(test, calls->cleaned_state,
+				    colorop_test_new_state(priv, i));
+	}
+}
+
+/*
+ * After the state swap, cleanup_planes() cleans up the old colorop states,
+ * which were current before the commit, and leaves the new ones prepared.
+ */
+static void drm_test_colorop_cleanup_after_swap(struct kunit *test)
+{
+	struct colorop_test_priv *priv = test->priv;
+	struct drm_colorop_state *old_state[TEST_NUM_COLOROPS];
+	int i, ret;
+
+	for (i = 0; i < TEST_NUM_COLOROPS; i++)
+		old_state[i] = priv->colorops[i]->state;
+
+	ret = drm_atomic_helper_prepare_planes(priv->drm, priv->state);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = drm_atomic_helper_swap_state(priv->state, false);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	drm_atomic_helper_cleanup_planes(priv->drm, priv->state);
+
+	KUNIT_EXPECT_EQ(test, priv->plane_cleaned, 1);
+	for (i = 0; i < TEST_NUM_COLOROPS; i++) {
+		struct colorop_hook_calls *calls = &priv->colorop[i];
+
+		KUNIT_EXPECT_PTR_EQ(test, priv->colorops[i]->state,
+				    calls->prepared_state);
+		KUNIT_EXPECT_EQ(test, calls->cleaned, 1);
+		KUNIT_EXPECT_PTR_EQ(test, calls->cleaned_state, old_state[i]);
+	}
+}
+
+static const int colorop_fail_at_params[] = { 0, 1, TEST_NUM_COLOROPS - 1 };
+
+static void colorop_fail_at_desc(const int *fail_at, char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "colorop %d", *fail_at);
+}
+
+KUNIT_ARRAY_PARAM(colorop_fail_at, colorop_fail_at_params, colorop_fail_at_desc);
+
+/*
+ * When a colorop fails to prepare, only the colorops prepared before it are
+ * cleaned up, and the planes are not prepared.
+ */
+static void drm_test_colorop_prepare_fail(struct kunit *test)
+{
+	struct colorop_test_priv *priv = test->priv;
+	int fail_at = *(const int *)test->param_value;
+	int i, ret;
+
+	priv->colorop_fail_at = fail_at;
+
+	ret = drm_atomic_helper_prepare_planes(priv->drm, priv->state);
+	KUNIT_EXPECT_EQ(test, ret, -EIO);
+
+	KUNIT_EXPECT_EQ(test, priv->plane_prepared, 0);
+	KUNIT_EXPECT_EQ(test, priv->plane_cleaned, 0);
+	for (i = 0; i < TEST_NUM_COLOROPS; i++) {
+		struct colorop_hook_calls *calls = &priv->colorop[i];
+
+		KUNIT_EXPECT_EQ(test, calls->prepared, i <= fail_at);
+		KUNIT_EXPECT_EQ(test, calls->cleaned, i < fail_at);
+		if (i < fail_at)
+			KUNIT_EXPECT_PTR_EQ(test, calls->cleaned_state,
+					    colorop_test_new_state(priv, i));
+	}
+}
+
+/*
+ * When a plane fails to prepare after the colorops, every colorop is cleaned
+ * up once. The failing plane is not.
+ */
+static void drm_test_colorop_plane_prepare_fail(struct kunit *test)
+{
+	struct colorop_test_priv *priv = test->priv;
+	int i, ret;
+
+	priv->plane_prepare_ret = -EIO;
+
+	ret = drm_atomic_helper_prepare_planes(priv->drm, priv->state);
+	KUNIT_EXPECT_EQ(test, ret, -EIO);
+
+	KUNIT_EXPECT_EQ(test, priv->plane_prepared, 1);
+	KUNIT_EXPECT_EQ(test, priv->plane_cleaned, 0);
+	for (i = 0; i < TEST_NUM_COLOROPS; i++) {
+		struct colorop_hook_calls *calls = &priv->colorop[i];
+
+		KUNIT_EXPECT_EQ(test, calls->prepared, 1);
+		KUNIT_EXPECT_EQ(test, calls->cleaned, 1);
+		KUNIT_EXPECT_PTR_EQ(test, calls->cleaned_state,
+				    colorop_test_new_state(priv, i));
+	}
+}
+
+/*
+ * When a plane fails begin_fb_access, the prepared plane and every colorop
+ * are cleaned up once.
+ */
+static void drm_test_colorop_plane_begin_access_fail(struct kunit *test)
+{
+	struct colorop_test_priv *priv = test->priv;
+	int i, ret;
+
+	priv->plane_begin_access_ret = -EIO;
+
+	ret = drm_atomic_helper_prepare_planes(priv->drm, priv->state);
+	KUNIT_EXPECT_EQ(test, ret, -EIO);
+
+	KUNIT_EXPECT_EQ(test, priv->plane_prepared, 1);
+	KUNIT_EXPECT_EQ(test, priv->plane_cleaned, 1);
+	KUNIT_EXPECT_EQ(test, priv->plane_end_access, 0);
+	for (i = 0; i < TEST_NUM_COLOROPS; i++) {
+		struct colorop_hook_calls *calls = &priv->colorop[i];
+
+		KUNIT_EXPECT_EQ(test, calls->prepared, 1);
+		KUNIT_EXPECT_EQ(test, calls->cleaned, 1);
+		KUNIT_EXPECT_PTR_EQ(test, calls->cleaned_state,
+				    colorop_test_new_state(priv, i));
+	}
+}
+
+static struct kunit_case drm_colorop_helper_tests[] = {
+	KUNIT_CASE(drm_test_colorop_prepare_then_unprepare),
+	KUNIT_CASE(drm_test_colorop_cleanup_after_swap),
+	KUNIT_CASE_PARAM(drm_test_colorop_prepare_fail, colorop_fail_at_gen_params),
+	KUNIT_CASE(drm_test_colorop_plane_prepare_fail),
+	KUNIT_CASE(drm_test_colorop_plane_begin_access_fail),
+	{ }
+};
+
+static struct kunit_suite drm_colorop_helper_test_suite = {
+	.name = "drm_colorop_helper",
+	.init = colorop_test_init,
+	.test_cases = drm_colorop_helper_tests,
+};
+
+kunit_test_suite(drm_colorop_helper_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for the colorop atomic helper hooks");
+MODULE_LICENSE("GPL");
-- 
2.56.0


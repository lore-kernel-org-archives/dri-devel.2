Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DE8606A319
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 00:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=nolZDpVu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FC711128F8;
	Fri, 23 Oct 2026 00:12:22 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F09210E503;
 Fri, 23 Oct 2026 00:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=7TDlshyNWHzEDeF6wDXUjyADsRX+/pODorwUW4NFjRM=; b=
 nolZDpVupy4Si0DWsG6sZFSdw5kufyGmcKRf21+gZk15o87qfB0gWcyIdgg/+ayppJg6gmgFDVhhW
 ThAY0H10kf959DBrlG6kv+aYV/epSXDTHVa2G1Jw/yn0nICLssCay08Og/Ikk2aWTQBLjBiXc1rPR
 ol5lmjdiTLDwotlyohgjsoSSppLz80BkkcsHfgZh1OpZwf1SoM/b1XKLn6fdyvZHzSttaEnnFmAKP
 iX5bZx3C56vsZJuHZe2GPaoF0TmIrpwg/J13oCglB8vt3pJznWcIvbQINa6DatgdkQwkYoMJxA5yv
 Az6AWpQidNfCrzMle1OBN/l+6MfUzVpR/A==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xK2tF-007JL0-9a; Fri, 23 Oct 2026 02:12:09 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v2 1/2] drm/amd/display: Fix some memory lifetime issues in
 KUnit tests
Date: Thu, 22 Oct 2026 17:11:38 -0700
Message-ID: <20261023001139.2374085-2-John.Harrison@Igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023001139.2374085-1-John.Harrison@Igalia.com>
References: <20261023001139.2374085-1-John.Harrison@Igalia.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When running the KUnit tests with memory debugging enabled, a bunch of
use-after-free errors are hit. Fix them by using the appropriate alloc
manager in the appropriate position.

v2: Fix wb & MST issues by re-ordering the allocs instead (apparently
kmemleak lies about not leaking objects in UML KUNIT runs!?).

Signed-off-by: John Harrison <John.Harrison@Igalia.com>
CC: Alex Hung <alex.hung@amd.com>
CC: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c | 2 +-
 .../amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c | 7 +++++--
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    | 7 ++++---
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 5fdf8ce023b9..aa72934e1fea 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -9702,7 +9702,7 @@ dm_test_conn_init_ctx_alloc(struct kunit *test, enum signal_type signal)
 	ctx->adev->mode_info.num_crtc = 1;
 	dm_test_create_mode_props(test, ctx->adev);
 
-	pdev = kunit_kzalloc(test, sizeof(*pdev), GFP_KERNEL);
+	pdev = drmm_kzalloc(ctx->drm, sizeof(*pdev), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, pdev);
 	device_initialize(&pdev->dev);
 	pdev->dev.parent = dev;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index eafa3e6733a6..5a848dd5cd0f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -3808,6 +3808,11 @@ dm_mst_test_alloc_dsc_link_ctx(struct kunit *test, int total_avail_slots)
 	KUNIT_ASSERT_EQ(test,
 			kunit_add_action_or_reset(test, dm_mst_test_dsc_link_drop_locks, ctx), 0);
 
+	/* Must be allocatd prior to drm_kunit_helper_atomic_state_alloc to prevent
+	 * use-after-free on cleanup */
+	port = kunit_kzalloc(test, sizeof(*port), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, port);
+
 	ctx->state = drm_kunit_helper_atomic_state_alloc(test, ctx->drm, &ctx->acquire_ctx);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->state);
 
@@ -3833,11 +3838,9 @@ dm_mst_test_alloc_dsc_link_ctx(struct kunit *test, int total_avail_slots)
 	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
 	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
 	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
-	port = kunit_kzalloc(test, sizeof(*port), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, link_srv);
 	KUNIT_ASSERT_NOT_NULL(test, res_pool);
 	KUNIT_ASSERT_NOT_NULL(test, sink);
-	KUNIT_ASSERT_NOT_NULL(test, port);
 
 	link_srv->mst_decide_link_encoding_format = dm_mst_test_mst_encoding_format;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
index 4bc033fdfa97..047ac88cb2a9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
@@ -486,6 +486,10 @@ static void dm_test_wb_connector_init_success(struct kunit *test)
 	struct dc *dc;
 	int ret;
 
+	/* Must be allocated before adev to prevent use-after-free on cleanup */
+	wbcon = kunit_kzalloc(test, sizeof(*wbcon), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, wbcon);
+
 	adev = dm_kunit_alloc_adev(test);
 	adev->mode_info.num_crtc = 1;
 	dm = &adev->dm;
@@ -500,9 +504,6 @@ static void dm_test_wb_connector_init_success(struct kunit *test)
 	dc->links[0] = link;
 	dm->dc = dc;
 
-	wbcon = kunit_kzalloc(test, sizeof(*wbcon), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, wbcon);
-
 	ret = amdgpu_dm_wb_connector_init(dm, wbcon, 0);
 
 	KUNIT_EXPECT_EQ(test, ret, 0);
-- 
2.43.0


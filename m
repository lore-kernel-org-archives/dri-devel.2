Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830F5606A32F
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=OXTrGs+P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0CA710E488;
	Thu, 22 Oct 2026 17:37:18 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 745B710E46E;
 Thu, 22 Oct 2026 17:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=qamfClWRYrhIHnH1n7xYSLqdEQ7se1uV1kfI6/268pQ=; b=
 OXTrGs+PmHKLXrkx2QWYggpTmu5qOKSbsLL5jbaPXvpRTRe+cCRcBT50MfHOSJrBD3f2For8xGIlq
 9E7JTL6WHF47/252tTRVn83ovCAW1WnN9ZytxvQl/AMZl+BVA+UzKpUqVeXLuZCFiCHdLb3GrzX7P
 HTiWe75uO72tb6E2vomHUSisRo/YDB/lFZiA1vfLAhJN7YbJsBEQCAeonoTkqUAG07/Hq1lDMp6dv
 2eHvPGgUZqJVA/vMXc3YK9KbERnyJ31jPOhN3S7nP+NbqF0CJGehkKxjs1dEH+aAB4erA0RwEgt3r
 yRFNExmwRJR6eRq33pM0DNqvskMtKIEHKw==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJwiy-0071Z2-6s; Thu, 22 Oct 2026 19:37:08 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 1/3] drm/amd/display: Fix some memory lifetime issues in KUnit
 tests
Date: Thu, 22 Oct 2026 10:36:53 -0700
Message-ID: <20261022173655.2318987-2-John.Harrison@Igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022173655.2318987-1-John.Harrison@Igalia.com>
References: <20261022173655.2318987-1-John.Harrison@Igalia.com>
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
manager (which might be none - write back connectors and DP MST ports
both have their own lifetime management).

Signed-off-by: John Harrison <John.Harrison@Igalia.com>
CC: Alex Hung <alex.hung@amd.com>
CC: Harry Wentland <harry.wentland@amd.com>
---
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c  | 2 +-
 .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c  | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

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
index eafa3e6733a6..5dc6cd880169 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -3833,7 +3833,7 @@ dm_mst_test_alloc_dsc_link_ctx(struct kunit *test, int total_avail_slots)
 	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
 	res_pool = kunit_kzalloc(test, sizeof(*res_pool), GFP_KERNEL);
 	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
-	port = kunit_kzalloc(test, sizeof(*port), GFP_KERNEL);
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, link_srv);
 	KUNIT_ASSERT_NOT_NULL(test, res_pool);
 	KUNIT_ASSERT_NOT_NULL(test, sink);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
index 4bc033fdfa97..f3b64a66cf28 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
@@ -500,7 +500,7 @@ static void dm_test_wb_connector_init_success(struct kunit *test)
 	dc->links[0] = link;
 	dm->dc = dc;
 
-	wbcon = kunit_kzalloc(test, sizeof(*wbcon), GFP_KERNEL);
+	wbcon = kzalloc_obj(*wbcon);
 	KUNIT_ASSERT_NOT_NULL(test, wbcon);
 
 	ret = amdgpu_dm_wb_connector_init(dm, wbcon, 0);
-- 
2.43.0


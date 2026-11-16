Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5499A606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tpgey13t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 952BB10EEDD;
	Mon, 16 Nov 2026 10:31:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33C5C10E346;
 Mon, 16 Nov 2026 10:31:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1966C41868;
 Mon, 16 Nov 2026 10:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1233D1F000CC;
 Mon, 16 Nov 2026 10:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825064;
 bh=J++ORV7lO/AQlkLUgWNDSmIiFLjI6/3drkOSo7UGgg8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Tpgey13tbr+Zaa42pYHGa9DTFTH0eWdcKwTn/s2NObJQlPfAbcAkx8am6uI5Em+8j
 LmTQbYpCFl2Eld7AnccdpNpuk473bBWFVK2UOP89cFHtg7+GasGe0s8ysaE5HbCjey
 gJ07UNaLDlk2a1TWmSqwCYo0oqQmbKMMrz/+nV42XmhUe53m7HBAvJtPyHYmXbV46y
 gTScvcV0pHM4+P+mq49zqcYlRgsuEJxe4vIO0fX1sPlnPE+4RCpJ4mIa5AJQC2hnWT
 Thry4tzTDdOj8MqlU88OeA7BFWD3Hj8JKtffqFRRPJMd1LBCyvCjHHNwoITa6iEFv1
 msV+8xYUst7pQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:18 +0100
Subject: [PATCH v2 02/64] drm/amdgpu: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261116-drm-no-more-config-reset-v2-2-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3532; i=mripard@kernel.org;
 h=from:subject:message-id; bh=we0mVOcw8bEtWp8Jj5zKh9enC3da9UcJqIrzaeo67eU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bjtef+SZ/mO27xaTC/avHerPME5a6ZvC7afzVklH8
 r3XTmaljqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRNayMDeeFXQwne+oKi5lF
 umXqlDJmbU4um7Xigdxz1bDeOfMj32lFGyn5f6os/9J8snGx3CRFxobtGr3fVi1rey/ck5a/jt1
 g/q3sMsttwdurGXuTfYpNPia3rO3r6ypwf+V0QHB7hOX0TAA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c                              | 4 +++-
 .../gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c    | 3 ++-
 .../gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c    | 4 +++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 5c7e2172a372..1f8b531eb946 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -359,11 +359,13 @@ static int amdgpu_vkms_output_init(struct drm_device *dev, struct
 	if (ret) {
 		DRM_ERROR("Failed to attach connector to encoder\n");
 		goto err_attach;
 	}
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		goto err_attach;
 
 	return 0;
 
 err_attach:
 	drm_encoder_cleanup(encoder);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 254797fa76a6..b8e1fa2378aa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -9963,11 +9963,12 @@ dm_test_force_ctx_alloc(struct kunit *test, const struct drm_connector_funcs *fu
 			drmm_encoder_init(ctx->drm, encoder, NULL,
 					  DRM_MODE_ENCODER_TMDS, NULL), 0);
 	encoder->crtc = crtc;
 	ctx->aconnector->base.encoder = encoder;
 
-	drm_mode_config_reset(ctx->drm);
+	KUNIT_ASSERT_EQ(test,
+			drm_mode_config_create_initial_state(ctx->drm), 0);
 
 	drm_modeset_acquire_init(&ctx->acquire_ctx, 0);
 	ctx->drm->mode_config.acquire_ctx = &ctx->acquire_ctx;
 	KUNIT_ASSERT_EQ(test,
 			kunit_add_action_or_reset(test, dm_test_force_drop_locks, ctx), 0);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index 8c3e32f40a96..c9fa8308d254 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -3791,11 +3791,13 @@ dm_mst_test_alloc_dsc_link_ctx(struct kunit *test, int total_avail_slots)
 	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
 	KUNIT_ASSERT_EQ(test,
 			drmm_connector_init(ctx->drm, &ctx->aconnector->base,
 					    &dm_mst_test_dsc_link_conn_funcs,
 					    DRM_MODE_CONNECTOR_DisplayPort, NULL), 0);
-	drm_mode_config_reset(ctx->drm);
+
+	KUNIT_ASSERT_EQ(test,
+			drm_mode_config_create_initial_state(ctx->drm), 0);
 
 	KUNIT_ASSERT_EQ(test,
 			drm_dp_mst_topology_mgr_init(&ctx->aconnector->mst_mgr, ctx->drm,
 						     &ctx->aconnector->dm_dp_aux.aux, 16, 4,
 						     ctx->aconnector->base.base.id), 0);

-- 
2.56.1


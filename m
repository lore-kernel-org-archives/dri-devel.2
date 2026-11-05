Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB6606A32D
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSrK3f7s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287C11125FF;
	Thu,  5 Nov 2026 15:30:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A767A1125FF;
 Thu,  5 Nov 2026 15:30:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 74CE1436AF;
 Thu,  5 Nov 2026 15:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61921F00A17;
 Thu,  5 Nov 2026 15:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892621;
 bh=f8wkGOeqdr9pn/y4Aqu039JA6nWq3yudpkpDEr1rZFE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=FSrK3f7sOql/y8wZSzn5LJ1yu79K9t5jRsUQDS2BQw93CtFBBn7Pwr/YQoNFRrijg
 HY79UnvpFe6wBilLJ/qfxJqGk9pfezidaCKJ5E33BFGFX0J+efizwSDOzo37Y3MNzC
 yVkWtNsRwqX27lSo+47vbzvMTRMj27PNfeGj6zeM3XDmjbVSdPPDuRBLXFEI6KIRVy
 b9IjrGbXrCVCdBqbWuUkg1TNJeChapBsHSL5ppIZdkq5e2zKUSG0zdsS2xzR1DnOTR
 Wnxk/5bQS1OggjksZGTjZzxnpNkaSK+6HfTtyZO2YxwY6Z9pApzi/0/CpzbMB59fJk
 jA2PltIcoxerA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:11 +0100
Subject: [PATCH RESEND 02/83] drm/amdgpu: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261105-drm-no-more-config-reset-v1-2-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2805; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1MTSHO9pBKc60kjKwiLlQWG73uMkotyRJA4xLAgEmNM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFtyr/ti672HjrUD2vuP75Kd+EZra5WNvX7RVsju6Z
 GrHmqszOqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBE7KYw1tl+KPqxY8KsY3dS
 2IV/lLe2+b4uVg3aemnvFb7gipb6k1Ir9tX4WF86WTP5isTPohmzfBkbLtwVTaiX/DXD/b/V/Jd
 rPr+oOdGy6ERV14yex+eU7Lesvm+oN1F+W1wKg0/hn/krjHb9AQA=
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
@@ -362,5 +362,7 @@ static int amdgpu_vkms_output_init(struct drm_device *dev, struct
 	}
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		goto err_attach;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 009a017194e3..7966690dca96 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -9966,5 +9966,6 @@ dm_test_force_ctx_alloc(struct kunit *test, const struct drm_connector_funcs *fu
 	ctx->aconnector->base.encoder = encoder;
 
-	drm_mode_config_reset(ctx->drm);
+	KUNIT_ASSERT_EQ(test,
+			drm_mode_config_create_initial_state(ctx->drm), 0);
 
 	drm_modeset_acquire_init(&ctx->acquire_ctx, 0);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index 8c3e32f40a96..c9fa8308d254 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -3794,5 +3794,7 @@ dm_mst_test_alloc_dsc_link_ctx(struct kunit *test, int total_avail_slots)
 					    &dm_mst_test_dsc_link_conn_funcs,
 					    DRM_MODE_CONNECTOR_DisplayPort, NULL), 0);
-	drm_mode_config_reset(ctx->drm);
+
+	KUNIT_ASSERT_EQ(test,
+			drm_mode_config_create_initial_state(ctx->drm), 0);
 
 	KUNIT_ASSERT_EQ(test,

-- 
2.55.0


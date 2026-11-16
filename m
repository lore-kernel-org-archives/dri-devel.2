Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA1A606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRy2FHpz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41F2210EF04;
	Mon, 16 Nov 2026 10:33:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 782A610EE6A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:33:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6130D40833;
 Mon, 16 Nov 2026 10:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B534D1F000C4;
 Mon, 16 Nov 2026 10:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825182;
 bh=i0fdeTDPIP7dPpi9pb5vaTOgG8E1RPOS1cbFt4WOdLw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=hRy2FHpzceWJIHoo4utTwHmpGl8LapyGsbaFWwEVXVIjnVdhuUJ/dkFQkARpJzLaW
 sg2h14MbIFK5ftTzSCb70kjFseUPmtyPM8pgNp0m4GegLsptjPwwkOSwx8B93nue2f
 ZXitrJZxaQYbJeeBBEMB6ugt95lTzAdOqX2flvOSVyweJtqQ9Aajk98xGaC3NXyZps
 QiF3brXXK0/sAaIvCSH9coSOywnFqb4cSrtHeTyg89zAsIWfP0WCQfdRN/Cnfg8unJ
 DGMfkKOdVRAgfnq/qSIPi5sz/gzxHiqMc4qW2wk4Qg/W4dAhqRBLa7mpoOnBHt0NlZ
 0d1s9OKuIPD6A==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:55 +0100
Subject: [PATCH v2 39/64] drm/tests: drm_atomic_test: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-39-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025; i=mripard@kernel.org;
 h=from:subject:message-id; bh=/hECOVLpDOkFEKgLTce4AfjZnyIejEwxS7Q3VreSI7c=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bgfe0bt/6Q+zVuA/9qzlbNmHE5qmRHB9Wlom+8ZB5
 TQvy9V1HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiSyczNiybsOZQuuzxbsWb
 SVfdkjKtjIINDyW72jHPPrLJ4b7RbnETKc27ght1rQ41qohfDPa6ylhnJWTk9e37sm1ez5V9jQ5
 qeHEL33jFtkw94OecYhZxfb8l4YvOxrtpvy+KirET2Xz16xYA
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
 drivers/gpu/drm/tests/drm_atomic_commit_test.c | 3 +--
 drivers/gpu/drm/tests/drm_atomic_test.c        | 4 +++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_atomic_commit_test.c b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
index 97f60ce68b3e..a02859a0d8bf 100644
--- a/drivers/gpu/drm/tests/drm_atomic_commit_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
@@ -133,12 +133,11 @@ drm_atomic_test_init_drm_components(struct kunit *test, bool has_connectors)
 		drm_connector_attach_encoder(conn, &priv->encoders[i]);
 	}
 
 done:
 	ret = drm_mode_config_create_initial_state(drm);
-	if (ret)
-		return ERR_PTR(ret);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	return priv;
 }
 
 static int set_up_atomic_state(struct kunit *test,
diff --git a/drivers/gpu/drm/tests/drm_atomic_test.c b/drivers/gpu/drm/tests/drm_atomic_test.c
index 541a0062f143..5e156d09e56f 100644
--- a/drivers/gpu/drm/tests/drm_atomic_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_test.c
@@ -84,11 +84,13 @@ static struct drm_atomic_test_priv *create_device(struct kunit *test)
 
 	drm_connector_helper_add(connector, &drm_atomic_init_connector_helper_funcs);
 
 	drm_connector_attach_encoder(connector, enc);
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return priv;
 }
 
 static void drm_test_drm_atomic_get_connector_for_encoder(struct kunit *test)

-- 
2.56.1


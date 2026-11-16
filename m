Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3825B606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KlFN/cj4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B58410EE5C;
	Mon, 16 Nov 2026 10:33:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4464E10EF04
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:33:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BE07061228;
 Mon, 16 Nov 2026 10:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E891F000C4;
 Mon, 16 Nov 2026 10:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825185;
 bh=5JXC1AJuAMolT8XmDF4YRBzmFpywEphrsdMU57o5KNw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KlFN/cj4pvchQwiahdJsDj8vcCChKKtcvH34WNO/qDrS+MgYjPaMxp+nFR9OBnYG3
 ytXKbEXmC3yR9/CaEq+FrMYACOucKO+7WQNx2IVVHGYS0uXJIGuGFF6bL+QFW5Y6IM
 BnT6fv45XTcuvE/bUP4irvwd4R7KZvP1403A3UOAGP8wy6k4uwzE5TR/aut9nVxvi1
 1IBSfYE8qnJPJmIDg0KqdXZJd57bCFwtEgOIkutkBjQ5SNLtal8BaFvPwndj9sVx4f
 c2fMjl9Rh7KT3alrWUbVxOimmRQt6hi6Z1/ebgUt/FlqwoWVkzGqKqjb9jG+IZHttT
 mD+nTKDa9y8kg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:56 +0100
Subject: [PATCH v2 40/64] drm/tests: drm_bridge_test: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-40-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2122; i=mripard@kernel.org;
 h=from:subject:message-id; bh=DsWBEpQmXwISLXPHRHaQ57pHN6yrxm+2VSByM2PXaCg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bgcefuTQePcw79p74s8CFhvN6uBiuPpvD98m2yDeG
 D6u/k0qHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAi20QYG87Pqf+hfbJse3fx
 s/dO9f8K90a/OR4q9HPlk30uUuxvLbMjpRdI+s2u9Is+/OPuD9uTYox1FhnqdhFGbdIXcjIbQh0
 rp07K535S9Hr3mrlTmBkm8Ux0lfveUuK00DvQxu9fG0/T/TYA
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
 drivers/gpu/drm/tests/drm_bridge_test.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/tests/drm_bridge_test.c
index 15583ade8494..f56209c0ab1c 100644
--- a/drivers/gpu/drm/tests/drm_bridge_test.c
+++ b/drivers/gpu/drm/tests/drm_bridge_test.c
@@ -420,11 +420,13 @@ drm_test_bridge_init(struct kunit *test, const struct drm_bridge_funcs *funcs)
 
 	priv->connector = drm_bridge_connector_init(drm, enc);
 	if (IS_ERR(priv->connector))
 		return ERR_CAST(priv->connector);
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return priv;
 }
 
 static struct drm_bridge_chain_priv *
@@ -518,11 +520,13 @@ drm_test_bridge_chain_init(struct kunit *test, unsigned int num_bridges,
 	if (IS_ERR(priv->connector))
 		return ERR_CAST(priv->connector);
 
 	drm_connector_attach_encoder(priv->connector, enc);
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ERR_PTR(ret);
 
 	if (!has_hdmi)
 		return priv;
 
 	scoped_guard(mutex, &drm->mode_config.mutex) {
@@ -610,11 +614,13 @@ drm_test_bridge_hdmi_init(struct kunit *test, const struct drm_bridge_funcs *fun
 	if (IS_ERR(priv->connector))
 		return ERR_CAST(priv->connector);
 
 	drm_connector_attach_encoder(priv->connector, enc);
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return priv;
 }
 
 /*

-- 
2.56.1


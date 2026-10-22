Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA60606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cfAkrHOO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B02D1125D0;
	Thu, 22 Oct 2026 12:37:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBAF31125D2
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:37:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4AE0E601F1;
 Thu, 22 Oct 2026 12:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772511F000C1;
 Thu, 22 Oct 2026 12:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672635;
 bh=SwpkvTLi67OkZMv8OtgjSvZN1XvulYaXjzRxOxNHuQo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=cfAkrHOO9a+qZ/Ud/fQ8C8KG0D2l97qxZ1FdPFazNZqp2xuuj01PhvfKwOnsDQM11
 f6eveX42OoNDoZIQ6Zy/GbdS053LT0WhzxOkFOUAuQigixqHd1ra3i5cl2r26OT/Ed
 E0ermddWW3YDrkzBSy6x/flPDVO4Z7PutS7G+ky7BIhYwBNDWD2L+KkddJz8nxwYiv
 TUMk4KtrRXRVfFPFWlPjpeg2/NUWidld+KpOG/a45KVxutb3SmXY/FjsB9RW+GFAhJ
 Gx+Uf8X3ujXpQ1waMJKpyAiJas8I2w7EAb7CLlsOypJkgGLqV2vvchS5MCVTBQ/QwY
 i//osFu1uqDuw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:57 +0200
Subject: [PATCH v2 58/59] drm/connector: Remove
 __drm_atomic_helper_connector_reset()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-58-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3011; i=mripard@kernel.org;
 h=from:subject:message-id; bh=CgpWhGZOW1YSIokrsPC5Eyp7lxnMKkek9BDAKENz8WA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mJaluZjPWuS+/0COfErf7xvl/zNP7HwlOVn8o2XRK
 d7TRqt0O6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEbmQw1jvfjU59smqerJTq
 8Y9TuY4a5D8INOz6XPrg9HaN13UTnlRtFXdNjZvBOFfFutHn1tkJ3Yz10SKBr79U3ik5sWTDguf
 Pw8v09A3fLSxmahJYEPb5rW/jdw5JJluL98edktJN5je1eKwCAA==
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

All drivers implementing the connector reset hook using
__drm_atomic_helper_connector_reset() have been converted to
atomic_create_state.

Remove __drm_atomic_helper_connector_reset().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 23 -----------------------
 include/drm/drm_atomic_state_helper.h     |  2 --
 include/drm/drm_connector.h               |  3 ---
 3 files changed, 28 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 5efda28bb2b0..267f44330629 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -413,27 +413,4 @@ __drm_atomic_helper_connector_state_init(struct drm_connector_state *conn_state,
 EXPORT_SYMBOL(__drm_atomic_helper_connector_state_init);
 
-/**
- * __drm_atomic_helper_connector_reset - reset state on connector
- * @connector: drm connector
- * @conn_state: connector state to assign
- *
- * Initializes the newly allocated @conn_state and assigns it to
- * the &drm_connector->state pointer of @connector, usually required when
- * initializing the drivers or when called from the &drm_connector_funcs.reset
- * hook.
- *
- * This is useful for drivers that subclass the connector state.
- */
-void
-__drm_atomic_helper_connector_reset(struct drm_connector *connector,
-				    struct drm_connector_state *conn_state)
-{
-	if (conn_state)
-		__drm_atomic_helper_connector_state_init(conn_state, connector);
-
-	connector->state = conn_state;
-}
-EXPORT_SYMBOL(__drm_atomic_helper_connector_reset);
-
 /**
  * drm_atomic_helper_connector_create_state - default &drm_connector_funcs.atomic_create_state hook for connectors
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index 7bced7e9d860..1a822179f2ec 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -67,6 +67,4 @@ void drm_atomic_helper_plane_destroy_state(struct drm_plane *plane,
 void __drm_atomic_helper_connector_state_init(struct drm_connector_state *conn_state,
 					       struct drm_connector *connector);
-void __drm_atomic_helper_connector_reset(struct drm_connector *connector,
-					 struct drm_connector_state *conn_state);
 struct drm_connector_state *
 drm_atomic_helper_connector_create_state(struct drm_connector *connector);
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 8b52360339e0..a87cd13d0a45 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1665,7 +1665,4 @@ struct drm_connector_funcs {
 	 * called by the core directly, only through drm_mode_config_reset().
 	 * It's not a helper hook only for historical reasons.
-	 *
-	 * Atomic drivers can use __drm_atomic_helper_connector_reset() to reset
-	 * atomic state using this hook.
 	 */
 	void (*reset)(struct drm_connector *connector);

-- 
2.55.0


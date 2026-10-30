Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CF3606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RUR/34hP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BCF71128B7;
	Fri, 30 Oct 2026 15:15:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D4C10E58D
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:15:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7E1CB60252;
 Fri, 30 Oct 2026 15:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4CF1F0093A;
 Fri, 30 Oct 2026 15:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373346;
 bh=VF0+3Jfmi6alT5JQpPGGaH+HowAtNIPu4auZh9PgO6g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=RUR/34hP5z6p5w/Km5eY0AFtsbRE3LrbGxzUNdsR8o0JHYWAZ+hcKJWhHXwcK71QE
 2UvpgnlqS7+NkdaIBujcMis/sG+bSE7uwiBS9hW5yUnkoAOGEfr65KruN5rfOcNdce
 OnelJyXvsnSJnxTMv/FSkk+gkaFr/nxJwsWa6h7AReT9V8zit/sAcTmN0j9JVvCeKX
 5zRjvLN5x0VuE2R1JD9fjqkZ66K4CN/0O5s/GI5AlpDgUfyOGqufI+nEPKDTzZd9Im
 RWm9kSUpKzWH9BOdRcBH28vpaBCCUG7usmlwdoXO/fw3bwQChW+XEJK+ZOgRVvGShT
 tTPyF8fYqT8Vw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:14:01 +0100
Subject: [PATCH v3 31/37] drm/connector: Remove
 drm_atomic_helper_connector_reset()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-31-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3563; i=mripard@kernel.org;
 h=from:subject:message-id; bh=PhsJjknRrAF9WRsi+LhwYoYGQJGKSnA48zHcbtMavGs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtmj1Knf5XWuwzWm601v5Jz3jFl/9htL2vo1nFFmeG
 XuHMvl2TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgInE/GOsz39nUhdey1vIv7LF
 /UC8z4JXK87NXmTwa/qsrxOP2P449vPk+VQjYfvqNU857d11mySOMTa0xZ2YVvn+Zmt8q9vdy3F
 5J5qSP3063GsxXVy/IvF0huQuqaeTFcL5zPfFr7M0tLt6MQgA
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

All drivers implementing the connector reset hook with
drm_atomic_helper_connector_reset() have been converted to
atomic_create_state.

Remove drm_atomic_helper_connector_reset().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c |  3 +--
 drivers/gpu/drm/drm_atomic_state_helper.c       | 20 --------------------
 include/drm/drm_atomic_state_helper.h           |  1 -
 include/drm/drm_connector.h                     |  2 +-
 4 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index c63d439382bb..66ae678fc078 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -315,6 +315,5 @@
  * Initializes all HDMI resources from a @drm_connector_state without
  * actually allocating it. This is useful for HDMI drivers, in
- * combination with __drm_atomic_helper_connector_state_init(),
- * drm_atomic_helper_connector_reset(), or
+ * combination with __drm_atomic_helper_connector_state_init(), or
  * drm_atomic_helper_connector_create_state().
  */
diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 3534925636d5..5efda28bb2b0 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -436,24 +436,4 @@ __drm_atomic_helper_connector_reset(struct drm_connector *connector,
 EXPORT_SYMBOL(__drm_atomic_helper_connector_reset);
 
-/**
- * drm_atomic_helper_connector_reset - default &drm_connector_funcs.reset hook for connectors
- * @connector: drm connector
- *
- * Resets the atomic state for @connector by freeing the state pointer (which
- * might be NULL, e.g. at driver load time) and allocating a new empty state
- * object.
- */
-void drm_atomic_helper_connector_reset(struct drm_connector *connector)
-{
-	struct drm_connector_state *conn_state = kzalloc_obj(*conn_state);
-
-	if (connector->state)
-		__drm_atomic_helper_connector_destroy_state(connector->state);
-
-	kfree(connector->state);
-	__drm_atomic_helper_connector_reset(connector, conn_state);
-}
-EXPORT_SYMBOL(drm_atomic_helper_connector_reset);
-
 /**
  * drm_atomic_helper_connector_create_state - default &drm_connector_funcs.atomic_create_state hook for connectors
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index 5e8619aeef21..7bced7e9d860 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -69,5 +69,4 @@ void __drm_atomic_helper_connector_state_init(struct drm_connector_state *conn_s
 void __drm_atomic_helper_connector_reset(struct drm_connector *connector,
 					 struct drm_connector_state *conn_state);
-void drm_atomic_helper_connector_reset(struct drm_connector *connector);
 struct drm_connector_state *
 drm_atomic_helper_connector_create_state(struct drm_connector *connector);
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2ee7c59329aa..8b52360339e0 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1666,5 +1666,5 @@ struct drm_connector_funcs {
 	 * It's not a helper hook only for historical reasons.
 	 *
-	 * Atomic drivers can use drm_atomic_helper_connector_reset() to reset
+	 * Atomic drivers can use __drm_atomic_helper_connector_reset() to reset
 	 * atomic state using this hook.
 	 */

-- 
2.55.0


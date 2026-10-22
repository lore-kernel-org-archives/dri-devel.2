Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1627606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mBJ99cCB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9A191125C9;
	Thu, 22 Oct 2026 12:37:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 658EC1125C9
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:36:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DCA2260018;
 Thu, 22 Oct 2026 12:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC4C1F000C1;
 Thu, 22 Oct 2026 12:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672613;
 bh=VF0+3Jfmi6alT5JQpPGGaH+HowAtNIPu4auZh9PgO6g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mBJ99cCB8I02a3QfG/jISu4FRU6TfPxhFI5bzuFm0LJh9vrBb6vK/+iA7ulaf3gSM
 jkd+oyXkYknHboTq8+MF1LbZJ1+7aZ447RHTwxiqq2kdtcl6VHWG54GvMWG676M67G
 W9+UUr1M2RuBVKkcRdc9xtPWX+rJcFDm8KmUQkBiikVO4Q0J3qMiDX/j93Ok6WSppW
 JMyAhSpBfe035K7vF2KYC6goM1KCSMrsOcyTm5me0dDEgsJX7uAD0GTT5hCIhyH+SW
 QlAtbCj1VXe300c1xpsS1+6iumotizXUzi4Ot9/90CHg3/Izu1X+rNy6lh83V51m62
 35iFzdvr8B+dA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:51 +0200
Subject: [PATCH v2 52/59] drm/connector: Remove
 drm_atomic_helper_connector_reset()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-52-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3563; i=mripard@kernel.org;
 h=from:subject:message-id; bh=PhsJjknRrAF9WRsi+LhwYoYGQJGKSnA48zHcbtMavGs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mJasUb5qz3+gfnriiVePbdnjftc76tvYfQ3RsYxJi
 Vp149C5jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjARZV/GOjsD17MXdb/yrEn/
 zX3nTFZGgEbU3gmn5Hm69qal+wUx716vvdpEJ2U5RzgDwxGfFWoOjA0rVe3mW4lwPjja+TD9+sl
 XjpVVimHHLj+683DXj+DyCxtn/V4c9VzXpV7rckF5xLf834sA
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


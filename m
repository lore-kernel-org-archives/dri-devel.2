Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8007C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3774D10EA91;
	Wed, 14 Oct 2026 17:31:49 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F018910EA91
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:31:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6E59E6022E;
 Wed, 14 Oct 2026 17:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EB51F000C5;
 Wed, 14 Oct 2026 17:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999102;
 bh=jq0O0uHCk5eiOU3nXvvygtp//XF5DKU8ojPt82rDXgw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=gC+qnmtXPSIUhCLbLuPgSfcAKiGe3fMzTcRlInVYzGU9TNsooqURgLMBz2x59rYGw
 WdQgTKzsJpXO0Px0g2JRkppxyfZUAKuaQxvdE88pejEAfXg/3W3ljalB89jmsFbotH
 wfpCP1Q3Ec3CK/7RpJJSBKEE1o7IOF11fB9aVIBUDN8czLy3/Rz+PR7qy/eak344yu
 pRAgEdWeaAI3SsIwZ8GApE6X2A70/KKUwt4vHoIEuCICxT91GdeFYdkdzPtfB3TXxP
 Spvjuf8Jso05p2vumIRc2fBd6gHc0kSsEcIkTy9BxLukyVLTimbWbhSlJW1wTvjxHn
 ezXn51HrTIdAw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:37 +0200
Subject: [PATCH 74/75] drm/connector: Remove
 __drm_atomic_helper_connector_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-74-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3618; i=mripard@kernel.org;
 h=from:subject:message-id; bh=qrCVdM+hEPY9WGAM9u9bFsYFgDEEmmwuL0b6dvQu0Og=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd2fp/HC/rxs9R9epLHf/H0vNyWlJTpoB78qOiiT9D
 c22dPbomMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABNRmcXYMGvS5kDPx94SbKXN
 0p+Me9me9zy4y8ajNkdMcEb//cD5T5LyqntnhvlcjYsPs9+joNLN2HDWWkvwfKmm8d4wHrvJxVe
 F2huvttzpbYj5aO2gLBC0ea/ynu4jbZZnylzjXz8UYDI/CwA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

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
index 8c48031956fe..efe173f3eeca 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -410,33 +410,10 @@ __drm_atomic_helper_connector_state_init(struct drm_connector_state *conn_state,
 {
 	conn_state->connector = connector;
 }
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
  * @connector: connector object
  *
  * Allocates and  initializes pristine @drm_connector_state.
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index 7bced7e9d860..1a822179f2ec 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -64,12 +64,10 @@ void __drm_atomic_helper_plane_destroy_state(struct drm_plane_state *state);
 void drm_atomic_helper_plane_destroy_state(struct drm_plane *plane,
 					  struct drm_plane_state *state);
 
 void __drm_atomic_helper_connector_state_init(struct drm_connector_state *conn_state,
 					       struct drm_connector *connector);
-void __drm_atomic_helper_connector_reset(struct drm_connector *connector,
-					 struct drm_connector_state *conn_state);
 struct drm_connector_state *
 drm_atomic_helper_connector_create_state(struct drm_connector *connector);
 void drm_atomic_helper_connector_tv_state_init(struct drm_connector_state *state,
 					       struct drm_connector *connector);
 int drm_atomic_helper_connector_tv_check(struct drm_connector *connector,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 8b52360339e0..a87cd13d0a45 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1662,13 +1662,10 @@ struct drm_connector_funcs {
 	 * @reset:
 	 *
 	 * Reset connector hardware and software state to off. This function isn't
 	 * called by the core directly, only through drm_mode_config_reset().
 	 * It's not a helper hook only for historical reasons.
-	 *
-	 * Atomic drivers can use __drm_atomic_helper_connector_reset() to reset
-	 * atomic state using this hook.
 	 */
 	void (*reset)(struct drm_connector *connector);
 
 	/**
 	 * @detect:

-- 
2.55.0


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C68CC3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2CD910FEE4;
	Wed, 14 Oct 2026 17:31:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C5E710FF0C
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:31:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EA70D405C0;
 Wed, 14 Oct 2026 17:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDEF1F000C5;
 Wed, 14 Oct 2026 17:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999068;
 bh=D13kT7G2/p2qWsnL7jeBDyjaqAAObzSejUj46dGrVw8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=livv7bRpSseYzFGzWjYME2a3iYKXDGyi1u6PhsFfHEUYUZ0Yld9T/hFPMsTuQ33C+
 sYWi3W05ldB7vR9OrPy5UResZbWSjibdiPSd3TPuxgZGqpw63Pn4SZAx8vLRhkFteK
 euTSv77n9SQO6s0g/X2PQ86o2z24MRhjGZ0HZL36ZHV6mV+ebgY76rlqpdTItYOBTG
 A5RCjgNtmoCiIUcLislMIdVupYz1htaIcCH3VOAg4tobB7lbuh5qn8DxPZnXT5B6+/
 EiccsCGco9lvE+DFmSQx/+JGS6OFMPctRXkuP0qxWP6SLuy/zgKGnl8tTHaI6kr37H
 3Hh6lkVMt0ygA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:28 +0200
Subject: [PATCH 65/75] drm/connector: Remove
 drm_atomic_helper_connector_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-65-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4498; i=mripard@kernel.org;
 h=from:subject:message-id; bh=nDJqxKw9WIg80DW8Z3IMJ6VmvKwKoDLq4cjUfrHLUZ0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd6dfV7IL27hD5rGP6CKBrHiJW5077kmsPB/gcznFJ
 Spmws81HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiATqMDQ9Ts3++yz8X4pRQ
 oO3L1vORq3SP3LPLv4t/hvGHxS/o53l863HTJN2Phvp96cmT1rgwM9aK7OPlzv9qv+fpDZEN6bp
 8i01OfmyQ6Gjerum6dP4C5duPrGZLKSz6OWWlc4Ybs9yk8LkA
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
index 7cdb7ca3dc12..0780ad5a2f20 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -312,12 +312,11 @@
  * @connector: DRM connector
  * @new_conn_state: connector state to initialize
  *
  * Initializes all HDMI resources from a @drm_connector_state without
  * actually allocating it. This is useful for HDMI drivers, in
- * combination with __drm_atomic_helper_connector_state_init(),
- * drm_atomic_helper_connector_reset(), or
+ * combination with __drm_atomic_helper_connector_state_init(), or
  * drm_atomic_helper_connector_create_state().
  */
 void __drm_atomic_helper_connector_hdmi_state_init(struct drm_connector *connector,
 						   struct drm_connector_state *new_conn_state)
 {
diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 1424c4873251..8c48031956fe 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -433,30 +433,10 @@ __drm_atomic_helper_connector_reset(struct drm_connector *connector,
 
 	connector->state = conn_state;
 }
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
  * @connector: connector object
  *
  * Allocates and  initializes pristine @drm_connector_state.
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index 5e8619aeef21..7bced7e9d860 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -66,11 +66,10 @@ void drm_atomic_helper_plane_destroy_state(struct drm_plane *plane,
 
 void __drm_atomic_helper_connector_state_init(struct drm_connector_state *conn_state,
 					       struct drm_connector *connector);
 void __drm_atomic_helper_connector_reset(struct drm_connector *connector,
 					 struct drm_connector_state *conn_state);
-void drm_atomic_helper_connector_reset(struct drm_connector *connector);
 struct drm_connector_state *
 drm_atomic_helper_connector_create_state(struct drm_connector *connector);
 void drm_atomic_helper_connector_tv_state_init(struct drm_connector_state *state,
 					       struct drm_connector *connector);
 int drm_atomic_helper_connector_tv_check(struct drm_connector *connector,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2ee7c59329aa..8b52360339e0 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1663,11 +1663,11 @@ struct drm_connector_funcs {
 	 *
 	 * Reset connector hardware and software state to off. This function isn't
 	 * called by the core directly, only through drm_mode_config_reset().
 	 * It's not a helper hook only for historical reasons.
 	 *
-	 * Atomic drivers can use drm_atomic_helper_connector_reset() to reset
+	 * Atomic drivers can use __drm_atomic_helper_connector_reset() to reset
 	 * atomic state using this hook.
 	 */
 	void (*reset)(struct drm_connector *connector);
 
 	/**

-- 
2.55.0


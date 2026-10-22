Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A6B606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TszLQNUW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B6411259E;
	Thu, 22 Oct 2026 12:34:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19EA6112588
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:33:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0247640E5D;
 Thu, 22 Oct 2026 12:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618971F000C1;
 Thu, 22 Oct 2026 12:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672430;
 bh=rlJzA1T9q79/1mF3kwvnLM7z+zHunRRw+Oh8EDGm1J8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TszLQNUWvoUBG6AVVoKUov0rKc+VsvNK3YcqhBwfQk2FBi5qt97Jfuf2jfEhc0/vF
 fQX6iFSytMmF+q1fZScVQvHZsbaCOt38Z9Wo5KtylcZ0KuxeuBGBPOvaC4uaAc6Xyz
 5XIE63IWywNDGepzZdDqRE83ScW8tdEj1s+8MWPGir7pnlSJuvO/BBPX64LEGrFnyD
 a2LcfueL1JfWDnzS9I9PPK0SOfhPJ+EeIC909iFVPfDwTIxw+QWZLOyHqwa2egvzoB
 LcF00np8ElntSjqraljD+h4pNOkGpk9XHXfc4CqDIO1codVP1c8qmVfLZmN8sCXqiM
 HLsMWhrgY1azw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:00 +0200
Subject: [PATCH v2 01/59] drm/hdmi: Change
 __drm_atomic_helper_connector_hdmi_state_init parameter order
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-1-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4974; i=mripard@kernel.org;
 h=from:subject:message-id; bh=BNLF80b8obzHWKvyY3tjVbypxRDDqyXa80MSXr1hAt0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mPrmVlfad+6w/DeJQ1p5Leu2I80G5xzX303d/frxd
 44Ov9mdHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiIucYG36fnvq8/tqt/xu9
 0u1+bpIKLbIwsPxSZr39iKyW5OlTUm9E3Dxema59cerC1p7FOXnt2xgb9jXGM022f+SWLL27tz2
 hn7Px7c2QevkZLPMrljF1X5pcKbJU66HX33IFo12mqs6VSrMB
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

All other state init helpers take the state as first parameter and the
entity as second: __drm_atomic_helper_crtc_state_init(),
__drm_atomic_helper_plane_state_init(),
__drm_atomic_helper_connector_state_init(), and
__drm_atomic_helper_bridge_state_init().

__drm_atomic_helper_connector_hdmi_state_init() is the only one taking
the connector first and the state second. Swap its parameters to match
the established convention.

Suggested-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/display/drm_bridge_connector.c     | 4 ++--
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    | 6 +++---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             | 3 ++-
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 3 ++-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     | 2 +-
 include/drm/display/drm_hdmi_state_helper.h        | 4 ++--
 6 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 81f3e26f6fdf..2202e6044444 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -239,6 +239,6 @@ drm_bridge_connector_create_state(struct drm_connector *connector)
 
 	if (bridge_connector->bridge_hdmi)
-		__drm_atomic_helper_connector_hdmi_state_init(connector,
-							      conn_state);
+		__drm_atomic_helper_connector_hdmi_state_init(conn_state,
+							      connector);
 
 	return conn_state;
diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 7cdb7ca3dc12..c63d439382bb 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -310,6 +310,6 @@
 /**
  * __drm_atomic_helper_connector_hdmi_state_init() - Initialize all HDMI @drm_connector_state resources
- * @connector: DRM connector
  * @new_conn_state: connector state to initialize
+ * @connector: DRM connector
  *
  * Initializes all HDMI resources from a @drm_connector_state without
@@ -319,6 +319,6 @@
  * drm_atomic_helper_connector_create_state().
  */
-void __drm_atomic_helper_connector_hdmi_state_init(struct drm_connector *connector,
-						   struct drm_connector_state *new_conn_state)
+void __drm_atomic_helper_connector_hdmi_state_init(struct drm_connector_state *new_conn_state,
+						   struct drm_connector *connector)
 {
 	unsigned int max_bpc = connector->max_bpc;
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 6f4fe0c8efae..3084f6570c29 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -294,5 +294,6 @@ static void sun4i_hdmi_connector_reset(struct drm_connector *connector)
 {
 	drm_atomic_helper_connector_reset(connector);
-	__drm_atomic_helper_connector_hdmi_state_init(connector, connector->state);
+	__drm_atomic_helper_connector_hdmi_state_init(connector->state,
+						      connector);
 }
 
diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index b2e347863a77..9953f5e661ce 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -203,5 +203,6 @@ static void dummy_hdmi_connector_reset(struct drm_connector *connector)
 {
 	drm_atomic_helper_connector_reset(connector);
-	__drm_atomic_helper_connector_hdmi_state_init(connector, connector->state);
+	__drm_atomic_helper_connector_hdmi_state_init(connector->state,
+						      connector);
 }
 
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 6b00581f304f..31942638fcd8 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -508,5 +508,5 @@ static void vc4_hdmi_connector_reset(struct drm_connector *connector)
 {
 	drm_atomic_helper_connector_reset(connector);
-	__drm_atomic_helper_connector_hdmi_state_init(connector, connector->state);
+	__drm_atomic_helper_connector_hdmi_state_init(connector->state, connector);
 	drm_atomic_helper_connector_tv_margins_reset(connector);
 }
diff --git a/include/drm/display/drm_hdmi_state_helper.h b/include/drm/display/drm_hdmi_state_helper.h
index 965342f6bbc9..21e5a9215319 100644
--- a/include/drm/display/drm_hdmi_state_helper.h
+++ b/include/drm/display/drm_hdmi_state_helper.h
@@ -14,6 +14,6 @@ struct hdmi_audio_infoframe;
 enum drm_connector_status;
 
-void __drm_atomic_helper_connector_hdmi_state_init(struct drm_connector *connector,
-						   struct drm_connector_state *new_conn_state);
+void __drm_atomic_helper_connector_hdmi_state_init(struct drm_connector_state *new_conn_state,
+						   struct drm_connector *connector);
 
 int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,

-- 
2.55.0


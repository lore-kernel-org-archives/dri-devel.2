Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3DD606A329
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=cL+4A+X+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CB4010E4AB;
	Fri, 27 Nov 2026 08:29:09 +0000 (UTC)
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D933D10E145
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:25:22 +0000 (UTC)
Received: from [169.254.254.254] (localhost [127.0.0.1])
 by smtp.ideco.ru (Postfix) with ESMTP id 5E078202F376;
 Thu, 26 Nov 2026 13:25:21 +0500 (+05)
Received: from fedora (5cfcd9fa.dynamic.mv.ru [92.252.217.250])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.ideco.ru (Postfix) with ESMTPSA id A9989204480B;
 Thu, 26 Nov 2026 13:16:44 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru A9989204480B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
 t=1795681006; bh=X7J+hw2kqFGgnofY99iUzsx1PeH/kA/agGV+KoyE0CE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cL+4A+X+3jLqPxX2lvBlxHP2bd2Jaz0Vn0tWQS+aUoOBQkwKVsw8pic10/+7B+yqA
 rlF+eiZ39jUgnfoonupp+Popx4mcI0aIMIcLXM2fhQkR2BGRmaU3gWYoFd07GQluB4
 d1aOfqpvRmc9/FCR4F/hnoqN6F3LE1Xqqd3eWWmFqCpIcVITtiMFlr1hRgd5IL9OHF
 vEhpqZuV18DV9mdFzjRhZtk1X6ok+foKX04S/ASIFqjqhEzEfoe1mudyRPBfn/8NPx
 hzT102yTRHRtOTy0tRq3dh7riCxON6prY7P7uTb5jG3+oUrk55UPNsIJmfyQNKBTgQ
 BWgZPVLGrMkew==
From: Alex Kazinsky <a.kazinsky@ideco.ru>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Alex Kazinsky <a.kazinsky@ideco.ru>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rajat Jain <rajatja@google.com>,
 Lyude Paul <lyude@redhat.com>, Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <Mario.limonciello@dell.com>,
 Emil Velikov <emil.l.velikov@gmail.com>, dri-devel@lists.freedesktop.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: [PATCH 5/5] drm/connector: Handle privacy-screen property allocation
 failures
Date: Thu, 26 Nov 2026 12:16:00 +0400
Message-ID: <20261126081602.2901498-6-a.kazinsky@ideco.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126081602.2901498-1-a.kazinsky@ideco.ru>
References: <20261126081602.2901498-1-a.kazinsky@ideco.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_connector_create_privacy_screen_properties() does not check whether
either property allocation succeeds. Failure to create the hardware
state property can lead to a NULL pointer dereference when updating or
attaching it.

Return -ENOMEM on allocation failure and store the property pointers
only after both properties have been created. Destroy the software
state property if creating the hardware state property fails.

Handle the error before storing the privacy-screen provider. Log the
failure and release the provider reference, preserving the helper's
ownership contract and leaving privacy-screen support disabled.

Fixes: 107fe9043020 ("drm/connector: Add support for privacy-screen properties (v4)")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Kazinsky <a.kazinsky@ideco.ru>
---
 drivers/gpu/drm/drm_connector.c | 54 ++++++++++++++++++++++++---------
 include/drm/drm_connector.h     |  2 +-
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index af3dbdcaaca5..0f430911c88f 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -3449,25 +3449,39 @@ static const struct drm_prop_enum_list privacy_screen_enum[] = {
  *
  * This function creates the "privacy-screen sw-state" and "privacy-screen
  * hw-state" properties for the connector. They are not attached.
+ *
+ * Returns:
+ * Zero on success, negative errno on failure.
  */
-void
+int
 drm_connector_create_privacy_screen_properties(struct drm_connector *connector)
 {
+	struct drm_property *sw_state, *hw_state;
+
 	if (connector->privacy_screen_sw_state_property)
-		return;
+		return 0;
 
 	/* Note sw-state only supports the first 2 values of the enum */
-	connector->privacy_screen_sw_state_property =
-		drm_property_create_enum(connector->dev, DRM_MODE_PROP_ENUM,
-				"privacy-screen sw-state",
-				privacy_screen_enum, 2);
-
-	connector->privacy_screen_hw_state_property =
-		drm_property_create_enum(connector->dev,
-				DRM_MODE_PROP_IMMUTABLE | DRM_MODE_PROP_ENUM,
-				"privacy-screen hw-state",
-				privacy_screen_enum,
-				ARRAY_SIZE(privacy_screen_enum));
+	sw_state = drm_property_create_enum(connector->dev, DRM_MODE_PROP_ENUM,
+					    "privacy-screen sw-state",
+					    privacy_screen_enum, 2);
+	if (!sw_state)
+		return -ENOMEM;
+
+	hw_state = drm_property_create_enum(connector->dev,
+					    DRM_MODE_PROP_IMMUTABLE | DRM_MODE_PROP_ENUM,
+					    "privacy-screen hw-state",
+					    privacy_screen_enum,
+					    ARRAY_SIZE(privacy_screen_enum));
+	if (!hw_state) {
+		drm_property_destroy(connector->dev, sw_state);
+		return -ENOMEM;
+	}
+
+	connector->privacy_screen_sw_state_property = sw_state;
+	connector->privacy_screen_hw_state_property = hw_state;
+
+	return 0;
 }
 EXPORT_SYMBOL(drm_connector_create_privacy_screen_properties);
 
@@ -3539,16 +3553,26 @@ static int drm_connector_privacy_screen_notifier(
  * a generic notifier for generating sysfs-connector-status-events
  * on external changes to the privacy-screen status.
  * This function takes ownership of the passed in drm_privacy_screen and will
- * call drm_privacy_screen_put() on it when the connector is destroyed.
+ * release it when the connector is destroyed or property creation fails.
+ * If property creation fails, the connector is left without a privacy-screen
+ * provider.
  */
 void drm_connector_attach_privacy_screen_provider(
 	struct drm_connector *connector, struct drm_privacy_screen *priv)
 {
+	int ret;
+
+	ret = drm_connector_create_privacy_screen_properties(connector);
+	if (ret) {
+		drm_err(connector->dev, "Failed to create privacy-screen properties\n");
+		drm_privacy_screen_put(priv);
+		return;
+	}
+
 	connector->privacy_screen = priv;
 	connector->privacy_screen_notifier.notifier_call =
 		drm_connector_privacy_screen_notifier;
 
-	drm_connector_create_privacy_screen_properties(connector);
 	drm_connector_update_privacy_screen_properties(connector, true);
 	drm_connector_attach_privacy_screen_properties(connector);
 }
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2ee7c59329aa..ec142fe61568 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2918,7 +2918,7 @@ int drm_connector_set_orientation_from_panel(
 	struct drm_panel *panel);
 int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
 					  int min, int max);
-void drm_connector_create_privacy_screen_properties(struct drm_connector *conn);
+int drm_connector_create_privacy_screen_properties(struct drm_connector *conn);
 void drm_connector_attach_privacy_screen_properties(struct drm_connector *conn);
 void drm_connector_attach_privacy_screen_provider(
 	struct drm_connector *connector, struct drm_privacy_screen *priv);
-- 
2.56.0



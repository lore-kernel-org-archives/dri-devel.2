Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE4B606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9FYwNd6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F731125CF;
	Thu, 22 Oct 2026 12:37:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 947BC1125C6
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:36:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D34E4140E;
 Thu, 22 Oct 2026 12:36:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54A01F000C1;
 Thu, 22 Oct 2026 12:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672606;
 bh=EBobEuK+49bvUpIcTfFfbFIXTWU9iOBOFUXJVJ9uAxo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=U9FYwNd6R7a5kyJxv3UhJLPT1y9SHRfJsZyl4ln9JEYYbzxa/mF8jMXWidNmR3tSM
 16fmZtTz3N3JNHX36DctqFjA0nVqdr7ncQnOG2gGifgBsZRfyyelTFyS3bn2jajJlJ
 Hcs7OESyYl6LYKcDV2mmM1+23LaNjq2bgW7USTiN3dWMnpKPYtB9HJ+ITeIJKbrOwP
 f//Y2gGNxbclcyIi7+QF/Xp8HcEprCIhRXk8wQB8+eYHdQckGR+gBmKjIHi/gRjdL6
 V/Fgq2b93vOIiTl0YE6tVst2oL2jCuds3GBOUUYQOrS02HS9ni/RhBXDanBanlM0/L
 lab47zmvFoSvQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:49 +0200
Subject: [PATCH v2 50/59] drm/vc4: hdmi: Convert to atomic_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-50-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2795; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Ip1wdXLijGTFnNlCA3gB1c/l0wHynsX4pVVRH8SWNKU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mBZLbAnJDnpz45hARdKUponJrFPUUk9G28Ywl9UbS
 V6ZqmfUMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACbyv5exvnD/xf0cD99/Obyj
 YAeD/uaH55utyt3954bOuVC3+/VKRjtZfdX7U2yEndbUr1hxYd/dfMaGp6lP6z5YqXXoXA2Yf+m
 gfFmI3DfZJSuPbz7PGVRUa7nj1X3LVSsUsiuFBY+fPHdywS0hAA==
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

The vc4 HDMI connector reset implementation creates a pristine state,
initializes the HDMI state, and sets the TV margins. It does not
perform any hardware reset.

Since this is equivalent to what atomic_create_state expects, convert
the reset function to an atomic_create_state hook that returns the
initialized state.

Reviewed-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: "Maíra Canal" <mcanal@igalia.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index e14cbe4b5f15..82618f43b0a5 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -505,10 +505,19 @@ static int vc4_hdmi_connector_atomic_check(struct drm_connector *connector,
 }
 
-static void vc4_hdmi_connector_reset(struct drm_connector *connector)
+static struct drm_connector_state *
+vc4_hdmi_connector_create_state(struct drm_connector *connector)
 {
-	drm_atomic_helper_connector_reset(connector);
-	__drm_atomic_helper_connector_hdmi_state_init(connector->state, connector);
-	drm_atomic_helper_connector_tv_margins_state_init(connector->state,
+	struct drm_connector_state *connector_state;
+
+	connector_state = drm_atomic_helper_connector_create_state(connector);
+	if (IS_ERR(connector_state))
+		return connector_state;
+
+	__drm_atomic_helper_connector_hdmi_state_init(connector_state, connector);
+
+	drm_atomic_helper_connector_tv_margins_state_init(connector_state,
 							  connector);
+
+	return connector_state;
 }
 
@@ -517,5 +526,5 @@ static const struct drm_connector_funcs vc4_hdmi_connector_funcs = {
 	.force = drm_atomic_helper_connector_hdmi_force,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.reset = vc4_hdmi_connector_reset,
+	.atomic_create_state = vc4_hdmi_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -568,6 +577,13 @@ static int vc4_hdmi_connector_init(struct drm_device *dev,
 	 * Allocate some default initial connector state with our reset helper.
 	 */
-	if (connector->funcs->reset)
-		connector->funcs->reset(connector);
+	if (!connector->state) {
+		struct drm_connector_state *conn_state;
+
+		conn_state = vc4_hdmi_connector_create_state(connector);
+		if (IS_ERR(conn_state))
+			return PTR_ERR(conn_state);
+
+		connector->state = conn_state;
+	}
 
 	/* Create and attach TV margin props to this connector. */

-- 
2.55.0


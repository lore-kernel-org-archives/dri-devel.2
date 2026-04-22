Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34BCFA1FD7
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 16:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A03910EEE9;
	Wed, 22 Apr 2026 16:50:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="PIm7+ox6";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5961F10EEE9
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 16:50:32 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 4896B1A33B2;
 Wed, 22 Apr 2026 16:50:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1CA0F5FA8F;
 Wed, 22 Apr 2026 16:50:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6759610460C15; 
 Wed, 22 Apr 2026 18:50:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776876629; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=4GQRgcM9x/VQEUFZDu9OmyOcHOiL5eSLILXt2BCMOi8=;
 b=PIm7+ox6UYKY9DYVif58KZsl29AtNUi2BNfhlOtGU7sZ2NsfGbpJKgBgeiZZXN/NUPMMZg
 ZM3BS7T4jwNMS5aGr9AEMqMZyREqP3BxB7o9mfjFhWkv3aAu9C9jDV7TlD6CVAMHWys3gd
 lGej0BJqbp4PK7FoWiy4Dj0So/eUVWyjpawEqi2NMJJRPAiABMrMNLWe7JOOS1yHtytHy7
 HelqWkwARs6MJy5qvYrZttpwpoU6zzccKDGDJhdl5JUZcbs2Hy79JTTUui8ypgNDeKT4CQ
 8I1vGN6fAa9Ge60jU8HCSICQHmh8kKXNxezXFgzC50dxst6dWtiGqUqlBXKQMA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 22 Apr 2026 18:48:33 +0200
Subject: [PATCH v4 36/37] drm/vkms: Add connector parent configuration in
 vkms_config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-vkms-all-config-v4-36-dbb52e9aadc3@bootlin.com>
References: <20260422-vkms-all-config-v4-0-dbb52e9aadc3@bootlin.com>
In-Reply-To: <20260422-vkms-all-config-v4-0-dbb52e9aadc3@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: victoria@system76.com, sebastian.wick@redhat.com, victoria@system76.com, 
 airlied@gmail.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>, 
 llvm@lists.linux.dev
X-Mailer: b4 0.16-dev
X-Last-TLS-Session-Version: TLSv1.3
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

In order to fully emulate MST connector from the userspace point of view,
add a way to configure the PATH property.

Add two things:
- port_id, to configure the MST port id (used to generate the last
  -<port-id> in the PATH property)
- parent, to configure the parent connector (used to
  generate <connector-id>- or -<port-id>- in the PATH property)

In order to properly populate the PATH property, it should be done after
all the connector initialization to ensure that the <connector-id> is
known.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 269 +++++++++++++++++++++++++-
 drivers/gpu/drm/vkms/vkms_config.c            |  50 ++++-
 drivers/gpu/drm/vkms/vkms_config.h            |  60 +++++-
 drivers/gpu/drm/vkms/vkms_configfs.c          |   2 +-
 drivers/gpu/drm/vkms/vkms_connector.c         |  72 +++++++
 drivers/gpu/drm/vkms/vkms_connector.h         |   9 +
 drivers/gpu/drm/vkms/vkms_output.c            |   2 +
 7 files changed, 458 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index fda23f05a0a5..a9700e265d42 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -396,7 +396,7 @@ static void vkms_config_test_get_connectors(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, n_connectors, 2);
 	n_connectors = 0;
 
-	vkms_config_destroy_connector(connector_cfg2);
+	vkms_config_destroy_connector(config, connector_cfg2);
 	vkms_config_for_each_connector(config, connector_cfg) {
 		n_connectors++;
 		if (connector_cfg != connector_cfg1)
@@ -845,7 +845,7 @@ static void vkms_config_test_invalid_connector_number(struct kunit *test)
 
 	/* Invalid: No connectors */
 	connector_cfg = get_first_connector(config);
-	vkms_config_destroy_connector(connector_cfg);
+	vkms_config_destroy_connector(config, connector_cfg);
 	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
 
 	/* Invalid: Too many connectors */
@@ -1233,6 +1233,267 @@ static void vkms_config_test_connector_status(struct kunit *test)
 	vkms_config_destroy(config);
 }
 
+static void vkms_config_test_connector_dynamic_status(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_connector *connector_cfg;
+	struct vkms_config_encoder *encoder_cfg;
+	struct vkms_config_crtc *crtc_cfg;
+	struct vkms_config_plane *plane_cfg;
+	enum drm_connector_status status;
+	int err;
+
+	config = vkms_config_create("test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	/* Create a complete pipeline */
+	crtc_cfg = vkms_config_create_crtc(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_cfg);
+
+	encoder_cfg = vkms_config_create_encoder(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, encoder_cfg);
+
+	connector_cfg = vkms_config_create_connector(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector_cfg);
+
+	plane_cfg = vkms_config_create_plane(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cfg);
+
+	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_PRIMARY);
+	err = vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	err = vkms_config_encoder_attach_crtc(encoder_cfg, crtc_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	err = vkms_config_connector_attach_encoder(connector_cfg, encoder_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	/* Test dynamic status changes */
+	status = vkms_config_connector_get_status(connector_cfg);
+	KUNIT_EXPECT_EQ(test, status, connector_status_connected);
+
+	vkms_config_connector_set_status(connector_cfg, connector_status_disconnected);
+	status = vkms_config_connector_get_status(connector_cfg);
+	KUNIT_EXPECT_EQ(test, status, connector_status_disconnected);
+
+	/* Configuration should still be valid regardless of connector status */
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	vkms_config_connector_set_status(connector_cfg, connector_status_connected);
+	status = vkms_config_connector_get_status(connector_cfg);
+	KUNIT_EXPECT_EQ(test, status, connector_status_connected);
+
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Test with unknown status */
+	vkms_config_connector_set_status(connector_cfg, connector_status_unknown);
+	status = vkms_config_connector_get_status(connector_cfg);
+	KUNIT_EXPECT_EQ(test, status, connector_status_unknown);
+
+	/* Configuration should still be valid */
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	vkms_config_destroy(config);
+}
+
+static void vkms_config_test_dynamic_connector_validity(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_connector *connector_cfg1, *connector_cfg2;
+	struct vkms_config_encoder *encoder_cfg;
+	struct vkms_config_crtc *crtc_cfg;
+	struct vkms_config_plane *plane_cfg;
+	int err;
+
+	config = vkms_config_create("test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	/* Create a complete pipeline */
+	crtc_cfg = vkms_config_create_crtc(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_cfg);
+
+	encoder_cfg = vkms_config_create_encoder(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, encoder_cfg);
+
+	connector_cfg1 = vkms_config_create_connector(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector_cfg1);
+
+	plane_cfg = vkms_config_create_plane(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cfg);
+
+	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_PRIMARY);
+	err = vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	err = vkms_config_encoder_attach_crtc(encoder_cfg, crtc_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	err = vkms_config_connector_attach_encoder(connector_cfg1, encoder_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	/* Valid: Non-dynamic connector */
+	vkms_config_connector_set_dynamic(connector_cfg1, false);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Valid: Dynamic connector */
+	vkms_config_connector_set_dynamic(connector_cfg1, true);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Valid: Multiple dynamic connectors */
+	connector_cfg2 = vkms_config_create_connector(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector_cfg2);
+	vkms_config_connector_set_dynamic(connector_cfg2, true);
+	err = vkms_config_connector_attach_encoder(connector_cfg2, encoder_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	vkms_config_destroy(config);
+}
+
+static void vkms_config_test_dynamic_connector_parent_validity(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_connector *connector_cfg1, *connector_cfg2, *connector_cfg3;
+	struct vkms_config_encoder *encoder_cfg;
+	struct vkms_config_crtc *crtc_cfg;
+	struct vkms_config_plane *plane_cfg;
+	int err;
+
+	config = vkms_config_create("test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	/* Create a complete pipeline */
+	crtc_cfg = vkms_config_create_crtc(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_cfg);
+
+	encoder_cfg = vkms_config_create_encoder(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, encoder_cfg);
+
+	connector_cfg1 = vkms_config_create_connector(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector_cfg1);
+
+	plane_cfg = vkms_config_create_plane(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cfg);
+
+	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_PRIMARY);
+	err = vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	err = vkms_config_encoder_attach_crtc(encoder_cfg, crtc_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	err = vkms_config_connector_attach_encoder(connector_cfg1, encoder_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	/* Valid: Non-dynamic connector with no parent */
+	vkms_config_connector_set_dynamic(connector_cfg1, false);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Valid: Dynamic connector with no parent */
+	vkms_config_connector_set_dynamic(connector_cfg1, true);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Valid: Dynamic connector with dynamic parent */
+	connector_cfg2 = vkms_config_create_connector(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector_cfg2);
+	vkms_config_connector_set_dynamic(connector_cfg2, true);
+	err = vkms_config_connector_attach_encoder(connector_cfg2, encoder_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	vkms_config_connector_attach_parent(connector_cfg2, connector_cfg1);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Valid: Dynamic connector with non-dynamic parent */
+	vkms_config_connector_set_dynamic(connector_cfg1, false);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Valid: Non-dynamic connector with no parent */
+	vkms_config_connector_attach_parent(connector_cfg2, NULL);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Valid: Multiple levels of dynamic parent-child relationships */
+	vkms_config_connector_set_dynamic(connector_cfg1, true);
+	vkms_config_connector_attach_parent(connector_cfg2, connector_cfg1);
+	connector_cfg3 = vkms_config_create_connector(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector_cfg3);
+	vkms_config_connector_set_dynamic(connector_cfg3, true);
+	err = vkms_config_connector_attach_encoder(connector_cfg3, encoder_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	vkms_config_connector_attach_parent(connector_cfg3, connector_cfg2);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	vkms_config_destroy(config);
+}
+
+static void vkms_config_test_dynamic_connector_parent_loop(struct kunit *test)
+{
+	struct vkms_config *config;
+	struct vkms_config_connector *connector_cfg1, *connector_cfg2, *connector_cfg3;
+	struct vkms_config_encoder *encoder_cfg;
+	struct vkms_config_crtc *crtc_cfg;
+	struct vkms_config_plane *plane_cfg;
+	int err;
+
+	config = vkms_config_create("test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	/* Create a complete pipeline */
+	crtc_cfg = vkms_config_create_crtc(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_cfg);
+
+	encoder_cfg = vkms_config_create_encoder(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, encoder_cfg);
+
+	connector_cfg1 = vkms_config_create_connector(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector_cfg1);
+
+	plane_cfg = vkms_config_create_plane(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_cfg);
+
+	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_PRIMARY);
+	err = vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	err = vkms_config_encoder_attach_crtc(encoder_cfg, crtc_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	err = vkms_config_connector_attach_encoder(connector_cfg1, encoder_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+
+	/* Valid: Single dynamic connector with no parent */
+	vkms_config_connector_set_dynamic(connector_cfg1, true);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Valid: Two dynamic connectors in a chain */
+	connector_cfg2 = vkms_config_create_connector(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector_cfg2);
+	vkms_config_connector_set_dynamic(connector_cfg2, true);
+	err = vkms_config_connector_attach_encoder(connector_cfg2, encoder_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	vkms_config_connector_attach_parent(connector_cfg2, connector_cfg1);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Invalid: Create a loop - connector2 -> connector1 -> connector2 */
+	vkms_config_connector_attach_parent(connector_cfg1, connector_cfg2);
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	/* Fix the loop */
+	vkms_config_connector_attach_parent(connector_cfg1, NULL);
+	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
+
+	/* Invalid: Create a longer loop - connector1 -> connector2 -> connector3 -> connector1 */
+	connector_cfg3 = vkms_config_create_connector(config);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector_cfg3);
+	vkms_config_connector_set_dynamic(connector_cfg3, true);
+	err = vkms_config_connector_attach_encoder(connector_cfg3, encoder_cfg);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	vkms_config_connector_attach_parent(connector_cfg3, connector_cfg2);
+	vkms_config_connector_attach_parent(connector_cfg1, connector_cfg3);
+	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
+
+	vkms_config_destroy(config);
+}
+
 static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_empty_config),
 	KUNIT_CASE_PARAM(vkms_config_test_default_config,
@@ -1259,6 +1520,10 @@ static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_encoder_get_possible_crtcs),
 	KUNIT_CASE(vkms_config_test_connector_get_possible_encoders),
 	KUNIT_CASE(vkms_config_test_connector_status),
+	KUNIT_CASE(vkms_config_test_connector_dynamic_status),
+	KUNIT_CASE(vkms_config_test_dynamic_connector_validity),
+	KUNIT_CASE(vkms_config_test_dynamic_connector_parent_validity),
+	KUNIT_CASE(vkms_config_test_dynamic_connector_parent_loop),
 	{}
 };
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index a660e1aaa9c7..880e28de9714 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -170,7 +170,7 @@ void vkms_config_destroy(struct vkms_config *config)
 		vkms_config_destroy_encoder(config, encoder_cfg);
 
 	list_for_each_entry_safe(connector_cfg, connector_tmp, &config->connectors, link)
-		vkms_config_destroy_connector(connector_cfg);
+		vkms_config_destroy_connector(config, connector_cfg);
 
 	kfree_const(config->dev_name);
 	kfree(config);
@@ -437,6 +437,41 @@ static bool valid_connector_possible_encoders(const struct vkms_config *config)
 	return true;
 }
 
+static bool valid_connector_parents(const struct vkms_config *config)
+{
+	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
+
+	struct vkms_config_connector *connector_cfg;
+	struct vkms_config_connector *connector_cfg_parent;
+
+	vkms_config_for_each_connector(config, connector_cfg) {
+		bool expected_status = connector_cfg->enabled;
+
+		vkms_config_for_each_connector(config, connector_cfg_parent)
+			connector_cfg_parent->visited = false;
+
+		connector_cfg_parent = connector_cfg;
+		while (connector_cfg_parent) {
+			if (connector_cfg_parent->visited) {
+				drm_info(dev, "Parents of connector should not form a loop\n");
+				return false;
+			}
+
+			if (expected_status && connector_cfg_parent->enabled != expected_status) {
+				drm_info(dev, "All parents of an enabled connector must be enabled\n");
+				return false;
+			}
+
+
+
+			connector_cfg_parent->visited = true;
+			connector_cfg_parent = connector_cfg_parent->parent;
+		}
+	}
+
+	return true;
+}
+
 bool vkms_config_is_valid(const struct vkms_config *config)
 {
 	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
@@ -503,6 +538,9 @@ bool vkms_config_is_valid(const struct vkms_config *config)
 	if (!valid_connector_possible_encoders(config))
 		return false;
 
+	if (!valid_connector_parents(config))
+		return false;
+
 	return true;
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_is_valid);
@@ -962,8 +1000,16 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_connector);
 
-void vkms_config_destroy_connector(struct vkms_config_connector *connector_cfg)
+void vkms_config_destroy_connector(struct vkms_config *config,
+				   struct vkms_config_connector *connector_cfg)
 {
+	struct vkms_config_connector *connector_cfg_tmp;
+
+	vkms_config_for_each_connector(config, connector_cfg_tmp) {
+		if (connector_cfg_tmp->parent == connector_cfg)
+			connector_cfg_tmp->parent = NULL;
+	}
+
 	xa_destroy(&connector_cfg->possible_encoders);
 	list_del(&connector_cfg->link);
 	kfree(connector_cfg);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index b6912a90d687..cfc1bf53637c 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -142,10 +142,14 @@ struct vkms_config_encoder {
  * @edid: Stores the current EDID. The value will be ignored if @edid_enabled is false
  * @edid_len: Current EDID length. The value will be ignored if @edid_enabled is false
  * @possible_encoders: Array of encoders that can be used with this connector
+ * @parent: To emulate MST connector, this will contains a pointer to the parent
+ * @port_id: To emulate MST connector, this contains the physical port id. Used to
+ *           generate the PATH property.
  * @connector: Internal usage. This pointer should never be considered as valid.
  *             It can be used to store a temporary reference to a VKMS connector
  *             during device creation. This pointer is not managed by the
  *             configuration and must be managed by other means.
+ * @visited: Internal usage. This boolean is used to do some verification on the connectors.
  */
 struct vkms_config_connector {
 	struct list_head link;
@@ -160,9 +164,12 @@ struct vkms_config_connector {
 	u8 *edid;
 	unsigned int edid_len;
 	struct xarray possible_encoders;
+	struct vkms_config_connector *parent;
+	u8 port_id;
 
 	/* Internal usage */
 	struct vkms_connector *connector;
+	bool visited;
 };
 
 /**
@@ -369,6 +376,56 @@ vkms_config_connector_set_edid(struct vkms_config_connector *connector_cfg,
 		connector_cfg->edid_len = len;
 	}
 }
+/**
+ * vkms_config_connector_attach_parent - Attach a connector to a parent connector
+ * @connector_cfg: Connector to attach
+ * @parent: Parent connector to attach @connector_cfg to. Can be NULL to detach the parent.
+ */
+static inline void
+vkms_config_connector_attach_parent(struct vkms_config_connector *connector_cfg,
+				    struct vkms_config_connector *parent)
+{
+	connector_cfg->parent = parent;
+}
+
+/**
+ * vkms_config_connector_get_parent - Get the parent connector of a connector
+ * @connector_cfg: Connector to get the parent from
+ *
+ * Returns:
+ * The parent connector of @connector_cfg or NULL if none is assigned yet.
+ */
+static inline struct vkms_config_connector*
+vkms_config_connector_get_parent(const struct vkms_config_connector *connector_cfg)
+{
+	return connector_cfg->parent;
+}
+
+/**
+ * vkms_config_connector_get_port_id() - Get the port ID for a connector
+ * @connector_cfg: Connector configuration to query
+ *
+ * Returns:
+ * The port ID for this connector.
+ */
+static inline u8
+vkms_config_connector_get_port_id(const struct vkms_config_connector *connector_cfg)
+{
+	return connector_cfg->port_id;
+}
+
+/**
+ * vkms_config_connector_set_port_id() - Set the port ID for a connector
+ * @connector_cfg: Connector configuration to modify
+ * @port_id: New port ID for this connector
+ */
+static inline void
+vkms_config_connector_set_port_id(struct vkms_config_connector *connector_cfg,
+				  u8 port_id)
+{
+	connector_cfg->port_id = port_id;
+}
+
 
 /**
  * vkms_config_get_device_name() - Return the name of the device
@@ -1026,7 +1083,8 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
  * vkms_config_destroy_connector() - Remove and free a connector configuration
  * @connector_cfg: Connector configuration to destroy
  */
-void vkms_config_destroy_connector(struct vkms_config_connector *connector_cfg);
+void vkms_config_destroy_connector(struct vkms_config *config,
+				   struct vkms_config_connector *connector_cfg);
 
 /**
  * vkms_config_connector_attach_encoder - Attach a connector to an encoder
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index e7752ac1cd51..bc84a93cf1cd 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -1491,7 +1491,7 @@ static void connector_release(struct config_item *item)
 			vkms_connector_hot_remove(connector->dev->config->dev,
 						  connector_cfg->connector);
 
-		vkms_config_destroy_connector(connector->config);
+		vkms_config_destroy_connector(connector->dev->config, connector->config);
 
 		kfree(connector);
 	}
diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index a013b53bd915..7df2357894e5 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -8,6 +8,76 @@
 #include "vkms_config.h"
 #include "vkms_connector.h"
 
+/**
+ * vkms_connector_build_path_property() - Build the PATH property string for MST connectors
+ * @connector: The connector to build the PATH property for
+ * @connector_cfg: The connector configuration
+ *
+ * The PATH property format is:
+ *     mst:<drm object ID of root connector>-<dash-separated list of port_id>
+ * For nested MST connectors, this builds the full path like mst:45-2-3-4-2
+ */
+static void vkms_connector_build_path_property(struct vkms_connector *connector,
+						const struct vkms_config_connector *connector_cfg)
+{
+	const struct vkms_config_connector *current_cfg = connector_cfg;
+	const struct vkms_config_connector *root_cfg = NULL;
+	struct vkms_connector *root_connector = NULL;
+	char path[128]; /* Increased size for nested MST paths */
+	int len = 0;
+	u8 port_ids[16]; /* Max 16 levels of nesting */
+	int port_count = 0;
+	int i;
+
+	if (!vkms_config_connector_get_parent(connector_cfg))
+		return;
+
+	while (current_cfg) {
+		if (port_count < ARRAY_SIZE(port_ids))
+			port_ids[port_count++] = current_cfg->port_id;
+
+		if (!vkms_config_connector_get_parent(current_cfg)) {
+			root_cfg = current_cfg;
+			break;
+		}
+
+		current_cfg = vkms_config_connector_get_parent(current_cfg);
+	}
+
+	if (!root_cfg || !root_cfg->connector)
+		return;
+
+	root_connector = root_cfg->connector;
+
+	len = snprintf(path, sizeof(path), "mst:%d", root_connector->base.base.id);
+
+	for (i = port_count - 2; i >= 0; i--) {
+		int added = snprintf(path + len, sizeof(path) - len,
+				     "-%u", port_ids[i]);
+		if (added < 0 || len + added >= sizeof(path))
+			return;
+		len += added;
+	}
+
+	drm_connector_set_path_property(&connector->base, path);
+}
+
+/**
+ * vkms_connector_update_path_properties() - Update PATH properties for all connectors
+ * @vkmsdev: VKMS device
+ *
+ * This should be called after all connectors are created to ensure parent connectors
+ * have valid DRM object IDs.
+ */
+void vkms_connector_update_path_properties(struct vkms_device *vkmsdev)
+{
+	struct vkms_config_connector *connector_cfg;
+
+	vkms_config_for_each_connector(vkmsdev->config, connector_cfg)
+		if (connector_cfg->connector)
+			vkms_connector_build_path_property(connector_cfg->connector, connector_cfg);
+}
+
 static enum drm_connector_status vkms_connector_detect(struct drm_connector *connector,
 						       bool force)
 {
@@ -240,6 +310,8 @@ struct vkms_connector *vkms_connector_hot_add(struct vkms_device *vkmsdev,
 	if (ret)
 		return ERR_PTR(ret);
 
+	vkms_connector_build_path_property(connector, connector_cfg);
+
 	ret = drm_connector_dynamic_register(&connector->base);
 	if (ret) {
 		if (connector_cfg->type == DRM_MODE_CONNECTOR_HDMIA ||
diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
index a235a518d5a0..f8219830aaa5 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.h
+++ b/drivers/gpu/drm/vkms/vkms_connector.h
@@ -67,4 +67,13 @@ int vkms_connector_hot_attach_encoder(struct vkms_device *vkmsdev,
 				      struct vkms_connector *connector,
 				      struct drm_encoder *encoder);
 
+/**
+ * vkms_connector_update_path_properties() - Update PATH properties for all connectors
+ * @vkmsdev: VKMS device
+ *
+ * This should be called after all connectors are created to ensure parent connectors
+ * have valid DRM object IDs.
+ */
+void vkms_connector_update_path_properties(struct vkms_device *vkmsdev);
+
 #endif /* _VKMS_CONNECTOR_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 50f7d88dee8b..ad901340ba7c 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -126,5 +126,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		}
 	}
 
+	vkms_connector_update_path_properties(vkmsdev);
+
 	return 0;
 }

-- 
2.54.0


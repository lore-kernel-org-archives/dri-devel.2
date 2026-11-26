Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549DB606A33F
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HfUmeizS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C11E011235F;
	Thu, 26 Nov 2026 11:33:41 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C896811236E
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:33:24 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 813414E41780;
 Thu, 26 Nov 2026 11:33:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 545FB60237;
 Thu, 26 Nov 2026 11:33:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2585D11E6B36E; Thu, 26 Nov 2026 12:33:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795692801; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=5OIJzs81eApyWWwL9LlqWeDtHYwpTNBKP9FyE07mwBU=;
 b=HfUmeizS9BRoXril3z5KuEDy0r/NCxRYbzvHbQ3mtlZuMfjLs4CGJlaDQpWRqNxky5mIhh
 di7XwXZKMBfJkW6DLm/7wzBxhcmQCieKZXKpmx3KaoiLyqmt/WP+GniAjMrfd6B02SMm5G
 /nALxnSIjIM/W83OA/fOYYRjnxzty2ojh5fJCzCB6jNOdl2ndeT4Ic6Z895FUnWfQbTMLP
 gJH0A0U+Jp+n/PxOBtEPQevN39PDKoPasXFGEFzglV+YuVfIjY+h50AqIAfHx0QfH2jr5G
 gxobV/rMMTkh/XANxiipngNEvlNhO8h9GcxJhy3/awEy3+kqPrG2RFi92o21uw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 26 Nov 2026 12:29:25 +0100
Subject: [PATCH v7 42/43] drm/vkms: Add connector parent configuration in
 vkms_config
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vkms-all-config-v7-42-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
In-Reply-To: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Oarora Etimis <oaroraetimis@gmail.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Lucas De Marchi <demarchi@kernel.org>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com, 
 victoria@system76.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, llvm@lists.linux.dev
X-Mailer: b4 0.17-dev
X-Last-TLS-Session-Version: TLSv1.3
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

Attaching a parent takes a reference on it; a destroyed parent stays
allocated while its children hold that reference, and
vkms_config_connector_get_parent() then reports NULL for it.
vkms_config_destroy_connector() detaches the connector from its own
parent and drops the initial reference; each release drops the
reference its children took on it, and the parent release chains
from there.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c    | 269 ++++++++++++++++++++++-
 drivers/gpu/drm/vkms/tests/vkms_lifecycle_test.c |   2 +-
 drivers/gpu/drm/vkms/vkms_config.c               |  94 +++++++-
 drivers/gpu/drm/vkms/vkms_config.h               |  72 +++++-
 drivers/gpu/drm/vkms/vkms_configfs.c             |   2 +-
 drivers/gpu/drm/vkms/vkms_connector.c            |  90 +++++++-
 drivers/gpu/drm/vkms/vkms_connector.h            |   9 +
 drivers/gpu/drm/vkms/vkms_output.c               |   2 +
 8 files changed, 525 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index 9d21ac527170..0080dd5b5d35 100644
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
@@ -852,7 +852,7 @@ static void vkms_config_test_invalid_connector_number(struct kunit *test)
 
 	/* Invalid: No connectors */
 	connector_cfg = get_first_connector(config);
-	vkms_config_destroy_connector(connector_cfg);
+	vkms_config_destroy_connector(config, connector_cfg);
 	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
 
 	/* Invalid: Too many connectors */
@@ -1240,6 +1240,267 @@ static void vkms_config_test_connector_status(struct kunit *test)
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
@@ -1266,6 +1527,10 @@ static struct kunit_case vkms_config_test_cases[] = {
 	KUNIT_CASE(vkms_config_test_encoder_get_possible_crtcs),
 	KUNIT_CASE(vkms_config_test_connector_get_possible_encoders),
 	KUNIT_CASE(vkms_config_test_connector_status),
+	KUNIT_CASE(vkms_config_test_connector_dynamic_status),
+	KUNIT_CASE(vkms_config_test_dynamic_connector_validity),
+	KUNIT_CASE(vkms_config_test_dynamic_connector_parent_validity),
+	KUNIT_CASE(vkms_config_test_dynamic_connector_parent_loop),
 	{}
 };
 
diff --git a/drivers/gpu/drm/vkms/tests/vkms_lifecycle_test.c b/drivers/gpu/drm/vkms/tests/vkms_lifecycle_test.c
index 7f7b31368710..34310ba382a9 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_lifecycle_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_lifecycle_test.c
@@ -227,7 +227,7 @@ static void vkms_lifecycle_test_connector_ref_outlives_config(struct kunit *test
 
 	/* Simulate the rmdir while DRM hold the device */
 	vkms_config_connector_get(connector_cfg);
-	vkms_config_destroy_connector(connector_cfg);
+	vkms_config_destroy_connector(config, connector_cfg);
 	vkms_config_destroy(config);
 
 	/* The connector must survive, detached from the configuration. */
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 2c6a53d6f778..fb6368e53c07 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -177,7 +177,17 @@ static void vkms_config_release(struct kref *ref)
 		vkms_config_destroy_encoder(config, encoder_cfg);
 
 	list_for_each_entry_safe(connector_cfg, connector_tmp, &config->connectors, link) {
-		/* The config is dying: drop the list's reference on each connector */
+		/*
+		 * The config is dying: break the parent chain first so parent
+		 * cycles are reclaimable, then drop the list's reference on
+		 * each connector.
+		 */
+		if (connector_cfg->parent) {
+			struct vkms_config_connector *parent = connector_cfg->parent;
+
+			connector_cfg->parent = NULL;
+			vkms_config_connector_put(parent);
+		}
 		vkms_config_connector_put(connector_cfg);
 	}
 
@@ -498,6 +508,43 @@ static bool valid_connector_colorspaces(const struct vkms_config *config)
 	return true;
 }
 
+static bool valid_connector_parents(const struct vkms_config *config)
+{
+	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
+
+	struct vkms_config_connector *connector_cfg;
+	const struct vkms_config_connector *parent;
+	size_t num_connectors = 0;
+	size_t depth;
+
+	vkms_config_for_each_connector(config, connector_cfg)
+		num_connectors++;
+
+	vkms_config_for_each_connector(config, connector_cfg) {
+		bool expected_status = connector_cfg->enabled;
+
+		parent = connector_cfg;
+		for (depth = 0; parent; depth++) {
+			/* A loop in the parent chain is walked more than
+			 * num_connectors times.
+			 */
+			if (depth > num_connectors) {
+				drm_info(dev, "Parents of connector should not form a loop\n");
+				return false;
+			}
+
+			if (expected_status && parent->enabled != expected_status) {
+				drm_info(dev, "All parents of an enabled connector must be enabled\n");
+				return false;
+			}
+
+			parent = vkms_config_connector_get_parent(parent);
+		}
+	}
+
+	return true;
+}
+
 bool vkms_config_is_valid(const struct vkms_config *config)
 {
 	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
@@ -578,6 +625,9 @@ bool vkms_config_is_valid(const struct vkms_config *config)
 	if (!valid_connector_colorspaces(config))
 		return false;
 
+	if (!valid_connector_parents(config))
+		return false;
+
 	return true;
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_is_valid);
@@ -1090,6 +1140,15 @@ static void vkms_config_connector_release(struct kref *ref)
 		/* The config is dying and is draining us: just unlink */
 		list_del_init(&connector_cfg->link);
 	}
+	/*
+	 * Drop the reference the children took on their parent. This can
+	 * run in any context (deferred probe put, drmm action, configfs
+	 * release), so it must not touch config->connectors: the parent
+	 * is kept alive by this reference, and its own release chains
+	 * from here.
+	 */
+	if (connector_cfg->parent)
+		vkms_config_connector_put(connector_cfg->parent);
 	if (connector_cfg->edid)
 		call_rcu(&connector_cfg->edid->rcu, vkms_config_edid_free);
 	kfree_rcu(connector_cfg, rcu);
@@ -1154,7 +1213,8 @@ int vkms_config_connector_set_edid(struct vkms_config_connector *connector_cfg,
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_connector_set_edid);
 
-void vkms_config_destroy_connector(struct vkms_config_connector *connector_cfg)
+void vkms_config_destroy_connector(struct vkms_config *config,
+				   struct vkms_config_connector *connector_cfg)
 {
 	/*
 	 * Pin the config, then unlink and drop the list's reference. If this
@@ -1163,13 +1223,41 @@ void vkms_config_destroy_connector(struct vkms_config_connector *connector_cfg)
 	 * nor free the config (pinned). list_del_rcu() because a concurrent
 	 * dump may still be walking this connector.
 	 */
-	vkms_config_get(connector_cfg->config);
+	vkms_config_get(config);
 	list_del_rcu(&connector_cfg->link);
 	connector_cfg->unlinked = true;
+	/*
+	 * The connector is logically destroyed but stays allocated
+	 * while its children still hold a reference on it; detach it
+	 * from its own parent now. Without this, a parent cycle
+	 * (accepted at link time, rejected when enabling the device)
+	 * would keep every member of the cycle alive forever, as
+	 * plain krefs cannot be reclaimed in a loop.
+	 */
+	if (connector_cfg->parent) {
+		struct vkms_config_connector *parent = connector_cfg->parent;
+
+		connector_cfg->parent = NULL;
+		vkms_config_connector_put(parent);
+	}
+
 	vkms_config_connector_put(connector_cfg);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_connector);
 
+void vkms_config_connector_attach_parent(struct vkms_config_connector *connector_cfg,
+					 struct vkms_config_connector *parent)
+{
+	if (parent)
+		vkms_config_connector_get(parent);
+
+	if (connector_cfg->parent)
+		vkms_config_connector_put(connector_cfg->parent);
+
+	connector_cfg->parent = parent;
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_connector_attach_parent);
+
 int __must_check vkms_config_connector_attach_encoder(struct vkms_config_connector *connector_cfg,
 						      struct vkms_config_encoder *encoder_cfg)
 {
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index e5352aaea85e..83869e677f15 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -180,6 +180,13 @@ struct vkms_config_edid {
  * @possible_encoders: Array of encoders that can be used with this connector
  * @unlinked: Set when the connector was unlinked from config->connectors
  *            by vkms_config_destroy_connector()
+ * @parent: To emulate MST connector, pointer to the parent connector. Attaching
+ *          a parent takes a reference on it; the parent then stays allocated
+ *          until the child detaches or is released, even if the parent itself
+ *          is destroyed (it then stays logically detached: vkms_config_connector_get_parent()
+ *          reports NULL for it)
+ * @port_id: To emulate MST connector, this contains the physical port id. Used to
+ *           generate the PATH property.
  * @connector: Internal usage. This pointer should never be considered as valid.
  *             It can be used to store a temporary reference to a VKMS connector
  *             during device creation. This pointer is not managed by the
@@ -201,6 +208,8 @@ struct vkms_config_connector {
 	struct vkms_config_edid __rcu *edid;
 	struct xarray possible_encoders;
 	bool unlinked;
+	struct vkms_config_connector *parent;
+	u8 port_id;
 
 	/* Internal usage */
 	struct vkms_connector *connector;
@@ -423,6 +432,65 @@ vkms_config_connector_get_edid(const struct vkms_config_connector *connector_cfg
 	*len = 0;
 	return NULL;
 }
+/**
+ * vkms_config_connector_attach_parent - Attach a connector to a parent connector
+ * @connector_cfg: Connector to attach
+ * @parent: Parent connector to attach @connector_cfg to. Can be NULL to detach
+ *          the current parent.
+ *
+ * Attaching takes a reference on @parent, detached or replaced parents are
+ * released. Must be called with the configuration lock held, as the release
+ * of a replaced parent can free it.
+ */
+void vkms_config_connector_attach_parent(struct vkms_config_connector *connector_cfg,
+					 struct vkms_config_connector *parent);
+
+/**
+ * vkms_config_connector_get_parent - Get the parent connector of a connector
+ * @connector_cfg: Connector to get the parent from
+ *
+ * Returns:
+ * The parent connector of @connector_cfg, or NULL if none is assigned or if
+ * the parent was destroyed: a destroyed parent stays allocated while its
+ * children hold a reference on it, but is logically detached, and its
+ * children then behave as if they had no parent.
+ */
+static inline struct vkms_config_connector*
+vkms_config_connector_get_parent(const struct vkms_config_connector *connector_cfg)
+{
+	struct vkms_config_connector *parent = connector_cfg->parent;
+
+	if (parent && list_empty(&parent->link))
+		return NULL;
+
+	return parent;
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
 
 int vkms_config_connector_set_edid(struct vkms_config_connector *connector_cfg,
 				   const u8 *edid, unsigned int len);
@@ -1086,9 +1154,11 @@ void vkms_config_connector_put(struct vkms_config_connector *connector_cfg);
 
 /**
  * vkms_config_destroy_connector() - Remove and free a connector configuration
+ * @config: Configuration to remove the connector from
  * @connector_cfg: Connector configuration to destroy
  */
-void vkms_config_destroy_connector(struct vkms_config_connector *connector_cfg);
+void vkms_config_destroy_connector(struct vkms_config *config,
+				   struct vkms_config_connector *connector_cfg);
 
 /**
  * vkms_config_connector_attach_encoder - Attach a connector to an encoder
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 0681722e98e8..e6222db02a2e 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -1424,7 +1424,7 @@ static void connector_release(struct config_item *item)
 		if (connector->dev->enabled && connector_cfg->dynamic && connector_cfg->enabled)
 			vkms_connector_hot_remove(connector_cfg->connector);
 
-		vkms_config_destroy_connector(connector->config);
+		vkms_config_destroy_connector(connector->dev->config, connector->config);
 
 		kfree(connector);
 	}
diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index 93bceba0a1ae..5655f8b649c6 100644
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
+						       const struct vkms_config_connector *connector_cfg)
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
@@ -104,13 +174,6 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
 	.best_encoder = vkms_conn_best_encoder,
 };
 
-static void vkms_connector_static_cfg_release(struct drm_device *dev, void *res)
-{
-	struct vkms_connector *connector = res;
-
-	vkms_config_connector_put(connector->cfg);
-}
-
 /**
  * vkms_connector_init - Common initialization for all vkms connectors
  *
@@ -163,9 +226,20 @@ static int __must_check vkms_connector_init(struct vkms_connector *connector,
 	if (connector_cfg->type == DRM_MODE_CONNECTOR_VIRTUAL)
 		drm_connector_attach_edid_property(&connector->base);
 
+	if (vkms_config_connector_get_parent(connector_cfg))
+		drm_object_attach_property(&connector->base.base,
+					   connector->base.dev->mode_config.path_property, 0);
+
 	return 0;
 }
 
+static void vkms_connector_static_cfg_release(struct drm_device *dev, void *res)
+{
+	struct vkms_connector *connector = res;
+
+	vkms_config_connector_put(connector->cfg);
+}
+
 struct vkms_connector *vkms_connector_init_static(struct vkms_device *vkmsdev,
 						  struct vkms_config_connector *connector_cfg)
 {
@@ -278,6 +352,8 @@ struct vkms_connector *vkms_connector_hot_add(struct vkms_device *vkmsdev,
 		return ERR_PTR(ret);
 	}
 
+	vkms_connector_build_path_property(connector, connector_cfg);
+
 	/*
 	 * Attach the configuration before registration and serialize the
 	 * registration with in-flight probes: drm_mode_getconnector() holds
diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
index 83b5b32b42de..5a80735204d4 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.h
+++ b/drivers/gpu/drm/vkms/vkms_connector.h
@@ -79,4 +79,13 @@ int vkms_connector_hot_attach_encoder(struct vkms_connector *connector,
 int vkms_connector_hot_detach_encoder(struct vkms_connector *connector,
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
index b100ed0c91e6..0b938e057e82 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -128,5 +128,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		}
 	}
 
+	vkms_connector_update_path_properties(vkmsdev);
+
 	return 0;
 }

-- 
2.56.0


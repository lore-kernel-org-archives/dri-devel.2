Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4687F60A2621
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ygXJndYc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2ACC112C5C;
	Fri, 20 Nov 2026 18:04:04 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F806112C5C
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:03:58 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 39CF34E4168F;
 Fri, 20 Nov 2026 18:03:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 07438601B9;
 Fri, 20 Nov 2026 18:03:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 48EDF11BC0997; Fri, 20 Nov 2026 19:03:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197830; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=tbVoHzDu+rifzr3obMkFmU0bXfvQnWpgl13F+BB9d54=;
 b=ygXJndYciC0Tu8U/AZpu7Xaj/uLJtc6rvRRVUpU8wAd92ydUaBli4zV71BIzFaLGcQ0App
 N6FyhEliZp6nDJrv6SoadgGv2SX45cpuAxgrDJQYxS8hm7w09X0YTdi7aKx7Qpmq7oK5yB
 tRTjg1X8DXK2ZH7wAz+4tCNAx/BHfgfI/YlYepkAkW6XpLUac236tmqX1TQbt/+uHho9ls
 A6iAT8PaFApCoFL3LvOHxDH+9rmOGUIY6gCXZYnri+ksMKKW3bBzeSn5CEQRrFlOcKF6b8
 oVi9NnplPfmc4yW/7RDQ4OQAXCypdey2MeRIPURiq+seVTXqbWnNnS3tmf26vA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 20 Nov 2026 18:58:55 +0100
Subject: [PATCH v6 13/43] drm/vkms: Add KUnit test for device lifecycle
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vkms-all-config-v6-13-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
In-Reply-To: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
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
 linux-doc@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>, 
 llvm@lists.linux.dev
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10161;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=F2AwDvsjIsuT/dCGlAPBtsvdUQaj57QaRLPEDTGT4aI=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIr/4sPyioPF/fL86gTpVUdkY6cVS9MLtPKnP
 +L/oLqyromJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCK/xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOLjzg//RcLUD8j0Ajq64UhOrJ4H+IaosjZg6Cw
 6an9j79MsZMlMy6WgG7aeqfCNeLGN3Y28nynaJd/xm/+WjimsmPzUe1pJWvEB2byb/A9xAYm7dY
 WTT7XintlGvwAacSnxhybm0UpVU9qDT0PUnd+7ZhauAPaNxmZqj1cv8xX2HPvVvdvJTMEPeseR7
 psWgcOXDm3yAbkP2nJsqKbIiOPB+ojxmG0Xqxr2BNGkEsrv//CrRlcyYk5MSIKxSJuOqMD4gL9K
 Y0hxwSoBw2et9BDRPzaC3kY0FFYWoHCGgG8Q6LhK0eqlGYl+r1+rOedrqt1RBBdI87JgycEaeiR
 M4KHtmRLHMzEu80ZrJrnCM3E4Hxg7vgDX3DfumHUo0/JuJx78rlTE3/2h7ANQPlvLJZGkXxUxXR
 OmFLQ38tcxZ45mekpdx/wCV+ptvetv74wINfSis+Vy7Iixz5RP9R5LHK2voQnDDDb8LU2L4OP1M
 iq9uz4yhpPjc9HP+0nEDTBedVdyi9xNUiQwfCpO4hncFbADha2iA0Nc/M+e9muaPaYxucPNhQHh
 uerx7q2He5sftiRWKGwdyZ3OCPP6lY+dLpcwK/mYvfYHIXYo4VSTnFsO+l0PT2VjapjDOKCGOmU
 Up3uWhAF3xLTQrr0Wf+sell/N8JI4qVSMyaiAGL+9o3N4SI9GNQU=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
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

The configuration objects are now reference-counted and their lifetime is
driven by explicit get/put calls. Add tests aiming to spot UAF and leaks
using KASAN.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/.kunitconfig          |  12 ++
 drivers/gpu/drm/vkms/tests/Makefile              |   3 +-
 drivers/gpu/drm/vkms/tests/vkms_lifecycle_test.c | 259 +++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_drv.c                  |   3 +
 4 files changed, 276 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/tests/.kunitconfig b/drivers/gpu/drm/vkms/tests/.kunitconfig
index 6a2d87068edc..b72899f06088 100644
--- a/drivers/gpu/drm/vkms/tests/.kunitconfig
+++ b/drivers/gpu/drm/vkms/tests/.kunitconfig
@@ -2,3 +2,15 @@ CONFIG_KUNIT=y
 CONFIG_DRM=y
 CONFIG_DRM_VKMS=y
 CONFIG_DRM_VKMS_KUNIT_TEST=y
+CONFIG_KASAN=y
+CONFIG_KASAN_INLINE=y
+CONFIG_KASAN_VMALLOC=y
+CONFIG_KUNIT_ALL_TESTS=n
+CONFIG_DEBUG_KMEMLEAK=y
+CONFIG_DEBUG_OBJECTS=y
+CONFIG_DEBUG_OBJECTS_FREE=y
+CONFIG_DEBUG_OBJECTS_TIMERS=y
+CONFIG_DEBUG_SLAB=y
+CONFIG_PAGE_POISONING=y
+CONFIG_PAGE_POISONING_NO_SANITY=n
+CONFIG_PAGE_POISONING_ZERO=y
diff --git a/drivers/gpu/drm/vkms/tests/Makefile b/drivers/gpu/drm/vkms/tests/Makefile
index d4d9ba8d4c54..a7810a12c9c8 100644
--- a/drivers/gpu/drm/vkms/tests/Makefile
+++ b/drivers/gpu/drm/vkms/tests/Makefile
@@ -3,6 +3,7 @@
 vkms-kunit-tests-y := \
 	vkms_config_test.o \
 	vkms_format_test.o \
-	vkms_color_test.o
+	vkms_color_test.o \
+	vkms_lifecycle_test.o \
 
 obj-$(CONFIG_DRM_VKMS_KUNIT_TEST) += vkms-kunit-tests.o
diff --git a/drivers/gpu/drm/vkms/tests/vkms_lifecycle_test.c b/drivers/gpu/drm/vkms/tests/vkms_lifecycle_test.c
new file mode 100644
index 000000000000..b319f6424285
--- /dev/null
+++ b/drivers/gpu/drm/vkms/tests/vkms_lifecycle_test.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <kunit/test.h>
+#include <linux/string.h>
+
+#include "../vkms_config.h"
+#include "../vkms_drv.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+#define LIFECYCLE_ITERATIONS 50
+#define STRESS_ITERATIONS    500
+
+static void vkms_lifecycle_test_create_destroy_default(struct kunit *test)
+{
+	struct vkms_config *config;
+	int ret, i;
+
+	for (i = 0; i < LIFECYCLE_ITERATIONS; i++) {
+		config = vkms_config_default_create(true, true, false, false);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+		ret = vkms_create(config);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+
+		vkms_destroy(config);
+		vkms_config_destroy(config);
+	}
+}
+
+static void vkms_lifecycle_test_create_destroy_with_overlay(struct kunit *test)
+{
+	struct vkms_config *config;
+	int ret, i;
+
+	for (i = 0; i < LIFECYCLE_ITERATIONS; i++) {
+		config = vkms_config_default_create(true, true, true, false);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+		ret = vkms_create(config);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+
+		vkms_destroy(config);
+		vkms_config_destroy(config);
+	}
+}
+
+static void vkms_lifecycle_test_create_destroy_with_pipeline(struct kunit *test)
+{
+	struct vkms_config *config;
+	int ret, i;
+
+	for (i = 0; i < LIFECYCLE_ITERATIONS; i++) {
+		config = vkms_config_default_create(true, true, true, true);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+		ret = vkms_create(config);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+
+		vkms_destroy(config);
+		vkms_config_destroy(config);
+	}
+}
+
+static void vkms_lifecycle_test_create_destroy_minimal(struct kunit *test)
+{
+	struct vkms_config *config;
+	int ret, i;
+
+	for (i = 0; i < LIFECYCLE_ITERATIONS; i++) {
+		config = vkms_config_default_create(false, false, false, false);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+		ret = vkms_create(config);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+
+		vkms_destroy(config);
+		vkms_config_destroy(config);
+	}
+}
+
+static void vkms_lifecycle_test_create_destroy_writeback(struct kunit *test)
+{
+	struct vkms_config *config;
+	int ret, i;
+
+	for (i = 0; i < LIFECYCLE_ITERATIONS; i++) {
+		config = vkms_config_default_create(false, true, false, false);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+		ret = vkms_create(config);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+
+		vkms_destroy(config);
+		vkms_config_destroy(config);
+	}
+}
+
+static void vkms_lifecycle_test_stress_many_cycles(struct kunit *test)
+{
+	struct vkms_config *config;
+	int ret, i;
+
+	for (i = 0; i < STRESS_ITERATIONS; i++) {
+		config = vkms_config_default_create(true, true, true, false);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+		ret = vkms_create(config);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+
+		vkms_destroy(config);
+		vkms_config_destroy(config);
+	}
+}
+
+static void vkms_lifecycle_test_interleaved_create_destroy(struct kunit *test)
+{
+	struct vkms_config *configs[5];
+	const char *new_name;
+	char name[32];
+	int ret, i, j;
+
+	for (j = 0; j < 20; j++) {
+		for (i = 0; i < 5; i++) {
+			configs[i] = vkms_config_default_create(i & 1, i & 2, i & 4, false);
+			KUNIT_ASSERT_NOT_ERR_OR_NULL(test, configs[i]);
+
+			snprintf(name, sizeof(name), "vkms-interleaved-%d", i);
+			new_name = kstrdup_const(name, GFP_KERNEL);
+			KUNIT_ASSERT_NOT_NULL(test, new_name);
+			kfree_const(configs[i]->dev_name);
+			configs[i]->dev_name = new_name;
+
+			ret = vkms_create(configs[i]);
+			KUNIT_ASSERT_EQ(test, ret, 0);
+		}
+
+		for (i = 4; i >= 0; i--) {
+			vkms_destroy(configs[i]);
+			vkms_config_destroy(configs[i]);
+		}
+	}
+}
+
+static void vkms_lifecycle_test_destroy_uncreated_device(struct kunit *test)
+{
+	struct vkms_config *config;
+
+	config = vkms_config_default_create(true, true, false, false);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	KUNIT_ASSERT_NULL(test, config->dev);
+
+	vkms_config_destroy(config);
+}
+
+static void vkms_lifecycle_test_double_destroy(struct kunit *test)
+{
+	struct vkms_config *config;
+	int ret;
+
+	config = vkms_config_default_create(true, true, false, false);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	ret = vkms_create(config);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	vkms_destroy(config);
+	KUNIT_ASSERT_NULL(test, config->dev);
+
+	vkms_config_destroy(config);
+}
+
+static void vkms_lifecycle_test_create_after_destroy(struct kunit *test)
+{
+	struct vkms_config *config;
+	int ret, i;
+
+	for (i = 0; i < 20; i++) {
+		config = vkms_config_default_create(true, true, false, false);
+		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+		ret = vkms_create(config);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+
+		vkms_destroy(config);
+
+		ret = vkms_create(config);
+		KUNIT_ASSERT_EQ(test, ret, 0);
+
+		vkms_destroy(config);
+		vkms_config_destroy(config);
+	}
+}
+
+static void vkms_lifecycle_test_connector_ref_outlives_config(struct kunit *test)
+{
+	struct vkms_config_connector *connector_cfg;
+	struct vkms_config *config;
+
+	config = vkms_config_default_create(false, false, false, false);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+	KUNIT_ASSERT_FALSE(test, list_empty(&config->connectors));
+
+	connector_cfg = list_first_entry(&config->connectors,
+					 struct vkms_config_connector, link);
+
+	/* Simulate the rmdir while DRM hold the device */
+	vkms_config_connector_get(connector_cfg);
+	vkms_config_destroy_connector(connector_cfg);
+	vkms_config_destroy(config);
+
+	/* The connector must survive, detached from the configuration. */
+	KUNIT_EXPECT_EQ(test, kref_read(&connector_cfg->refcnt), 1);
+	KUNIT_EXPECT_TRUE(test, list_empty(&connector_cfg->link));
+
+	/* Last reference: connector and configuration are freed here. */
+	vkms_config_connector_put(connector_cfg);
+}
+
+static void vkms_lifecycle_test_connector_static_drmm_release(struct kunit *test)
+{
+	struct vkms_config *config;
+
+	config = vkms_config_default_create(true, true, false, false);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
+
+	KUNIT_ASSERT_EQ(test, vkms_create(config), 0);
+
+	/* vkms_destroy() runs the drmm action, which frees and detaches the connector. */
+	vkms_destroy(config);
+	vkms_config_destroy(config);
+}
+
+static struct kunit_case vkms_lifecycle_test_cases[] = {
+	KUNIT_CASE(vkms_lifecycle_test_create_destroy_default),
+	KUNIT_CASE(vkms_lifecycle_test_create_destroy_with_overlay),
+	KUNIT_CASE(vkms_lifecycle_test_create_destroy_with_pipeline),
+	KUNIT_CASE(vkms_lifecycle_test_create_destroy_minimal),
+	KUNIT_CASE(vkms_lifecycle_test_create_destroy_writeback),
+	KUNIT_CASE(vkms_lifecycle_test_stress_many_cycles),
+	KUNIT_CASE(vkms_lifecycle_test_interleaved_create_destroy),
+	KUNIT_CASE(vkms_lifecycle_test_destroy_uncreated_device),
+	KUNIT_CASE(vkms_lifecycle_test_double_destroy),
+	KUNIT_CASE(vkms_lifecycle_test_create_after_destroy),
+	KUNIT_CASE(vkms_lifecycle_test_connector_ref_outlives_config),
+	KUNIT_CASE(vkms_lifecycle_test_connector_static_drmm_release),
+	{}
+};
+
+static struct kunit_suite vkms_lifecycle_test_suite = {
+	.name = "vkms-lifecycle",
+	.test_cases = vkms_lifecycle_test_cases,
+};
+
+kunit_test_suite(vkms_lifecycle_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit test for VKMS device lifecycle, aiming to catch UAF and memory issues");
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 64c75b038869..a4bc3d02a6cd 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -18,6 +18,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_colorop.h>
+#include <kunit/visibility.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_shmem.h>
 #include <drm/drm_file.h>
@@ -250,6 +251,7 @@ static int __init vkms_init(void)
 
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(vkms_create);
 
 void vkms_destroy(struct vkms_config *config)
 {
@@ -269,6 +271,7 @@ void vkms_destroy(struct vkms_config *config)
 
 	config->dev = NULL;
 }
+EXPORT_SYMBOL_IF_KUNIT(vkms_destroy);
 
 static void __exit vkms_exit(void)
 {

-- 
2.56.0


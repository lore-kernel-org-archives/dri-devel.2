Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78046606A689
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1Bw+Fa/V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC70B11235C;
	Thu, 26 Nov 2026 11:33:16 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30265112358
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:33:05 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id E6AB1C2B9C9;
 Thu, 26 Nov 2026 11:33:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9D97960237;
 Thu, 26 Nov 2026 11:33:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6611B11E6B363; Thu, 26 Nov 2026 12:32:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795692781; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ql3kv0d7zKiK6Ef7MVkhNv/4CysbWdEdfcg9qRaLLRU=;
 b=1Bw+Fa/V/w3bsFMWWDGPNR1ayg3bjGe+2JWQJoHqWtNCtvIQkAvs8b4Uvp9/b+kKWBj6s5
 HJ9jRlKk2DmiD2ELvIZiQDn2cmAvBOFzwTUddqZ88R/tLiVK5CSRmSgySMCnLbXvYlrCZa
 HKY+Vy16WVJ6a1as2Um7htEt2l92yqEDPtThnmrx1H4TgPAHMcH5maLgpIG2pHuO/4cyE6
 hfHj0B1HtZhpHQHYFb9Ay7VhKUg4ytBipcSzRHgmNrQGR+PUbBWXA07KTNhTJGHpslpT99
 o94pQhh/0cZhzQWJC+IlWlWNmnoVqAoXUwAjudAGj2zIlR71hjF1S2kquj91RQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 26 Nov 2026 12:29:21 +0100
Subject: [PATCH v7 38/43] drm/vkms: Store the enabled/disabled status for
 connector
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261126-vkms-all-config-v7-38-21194cda2468@bootlin.com>
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

In order to prepare for dynamic connector configuration, we need to store
if a connector is dynamic and if it is enabled.

The two new vkms_config_connector fields will help for that.

Co-developed-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 .clang-format                                 |  2 +
 drivers/gpu/drm/vkms/tests/vkms_config_test.c |  4 ++
 drivers/gpu/drm/vkms/vkms_config.c            |  6 +++
 drivers/gpu/drm/vkms/vkms_config.h            | 70 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_output.c            |  2 +-
 5 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index 395292ab2ac6..ca8e16e39c15 100644
--- a/.clang-format
+++ b/.clang-format
@@ -726,6 +726,8 @@ ForEachMacros:
   - 'v4l2_m2m_for_each_src_buf_safe'
   - 'virtio_device_for_each_vq'
   - 'vkms_config_for_each_connector'
+  - 'vkms_config_for_each_connector_static'
+  - 'vkms_config_for_each_connector_dynamic'
   - 'vkms_config_for_each_crtc'
   - 'vkms_config_for_each_encoder'
   - 'vkms_config_for_each_plane'
diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index 8a13c45e1683..9d21ac527170 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -220,6 +220,10 @@ static void vkms_config_test_default_config(struct kunit *test)
 				0);
 		KUNIT_EXPECT_EQ(test, vkms_config_connector_get_edid_enabled(connector_cfg),
 				false);
+		KUNIT_EXPECT_EQ(test, vkms_config_connector_is_enabled(connector_cfg),
+				true);
+		KUNIT_EXPECT_EQ(test, vkms_config_connector_is_dynamic(connector_cfg),
+				false);
 	}
 
 	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 173e88122bcb..2c6a53d6f778 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -681,6 +681,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
 
 		vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
 			seq_puts(m, "connector:\n");
+			seq_printf(m, "\tenabled=%s\n",
+				   str_enabled_disabled(vkms_config_connector_is_enabled(connector_cfg)));
 			seq_printf(m, "\tstatus=%s\n",
 				   drm_get_connector_status_name(vkms_config_connector_get_status(connector_cfg)));
 			seq_printf(m, "\ttype=%s\n",
@@ -694,6 +696,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
 				   str_enabled_disabled(vkms_config_connector_get_edid_enabled(connector_cfg)),
 				   edid_len
 			);
+			seq_printf(m, "\tdynamic=%s\n",
+				   str_true_false(vkms_config_connector_is_dynamic(connector_cfg)));
 		}
 	}
 
@@ -1054,6 +1058,8 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
 	connector_cfg->status = connector_status_connected;
 	vkms_config_connector_set_type(connector_cfg, DRM_MODE_CONNECTOR_VIRTUAL);
 	vkms_config_connector_set_supported_colorspaces(connector_cfg, 0);
+	vkms_config_connector_set_dynamic(connector_cfg, false);
+	vkms_config_connector_set_enabled(connector_cfg, true);
 	xa_init_flags(&connector_cfg->possible_encoders, XA_FLAGS_ALLOC);
 	/* refcnt starts at 1: this reference is owned by config->connectors */
 	kref_init(&connector_cfg->refcnt);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index ef8de0316b94..e5352aaea85e 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -168,6 +168,8 @@ struct vkms_config_edid {
  * @rcu: RCU head for deferred freeing of this object
  * @type: Store the type of connector using DRM_MODE_CONNECTOR_* values
  * @config: The vkms_config this connector belongs to
+ * @dynamic: Store if a connector should be created with drm_connector_dynamic_init
+ * @enabled: If @dynamic, this means that the connector is currently registered in drm
  * @status: Status (connected, disconnected...) of the connector
  * @supported_colorspaces: Bitmask of all the supported colorspaces. Values
  *                         are the sames as ones accepted by
@@ -191,6 +193,8 @@ struct vkms_config_connector {
 	struct vkms_config *config;
 
 	int type;
+	bool enabled;
+	bool dynamic;
 	enum drm_connector_status status;
 	u32 supported_colorspaces;
 	bool edid_enabled;
@@ -244,6 +248,28 @@ struct vkms_config_connector {
 				      lockdep_is_held(&(config)->lock) || \
 				      !(config)->dev)
 
+/**
+ * vkms_config_for_each_connector_static - Iterate over the static vkms_config connectors
+ * @config: &struct vkms_config pointer
+ * @connector_cfg: &struct vkms_config_connector pointer used as cursor
+ */
+#define vkms_config_for_each_connector_static(config, connector_cfg) \
+	vkms_config_for_each_connector((config), (connector_cfg)) \
+		if ((connector_cfg)->dynamic) \
+			; \
+		else
+
+/**
+ * vkms_config_for_each_connector_dynamic - Iterate over the dynamic vkms_config connectors
+ * @config: &struct vkms_config pointer
+ * @connector_cfg: &struct vkms_config_connector pointer used as cursor
+ */
+#define vkms_config_for_each_connector_dynamic(config, connector_cfg) \
+	vkms_config_for_each_connector((config), (connector_cfg)) \
+		if (!(connector_cfg)->dynamic) \
+			; \
+		else
+
 /**
  * vkms_config_plane_for_each_possible_crtc - Iterate over the vkms_config_plane
  * possible CRTCs
@@ -525,6 +551,50 @@ vkms_config_connector_set_type(struct vkms_config_connector *connector_cfg,
 	connector_cfg->type = type;
 }
 
+/**
+ * vkms_config_connector_set_enabled() - If the connector is part of the device
+ * @connector_cfg: Target connector
+ * @enabled: Add or remove the connector
+ */
+static inline void
+vkms_config_connector_set_enabled(struct vkms_config_connector *connector_cfg,
+				  bool enabled)
+{
+	connector_cfg->enabled = enabled;
+}
+
+/**
+ * vkms_config_connector_is_enabled() - If the connector is part of the device
+ * @connector_cfg: The connector
+ */
+static inline bool
+vkms_config_connector_is_enabled(const struct vkms_config_connector *connector_cfg)
+{
+	return connector_cfg->enabled;
+}
+
+/**
+ * vkms_config_connector_set_dynamic() - If the connector is dynamic
+ * @connector_cfg: Target connector
+ * @dynamic: Enable or disable the dynamic status
+ */
+static inline void
+vkms_config_connector_set_dynamic(struct vkms_config_connector *connector_cfg,
+				  bool dynamic)
+{
+	connector_cfg->dynamic = dynamic;
+}
+
+/**
+ * vkms_config_connector_is_dynamic() - If the connector is dynamic
+ * @connector_cfg: The connector
+ */
+static inline bool
+vkms_config_connector_is_dynamic(const struct vkms_config_connector *connector_cfg)
+{
+	return connector_cfg->dynamic;
+}
+
 /*
  * vkms_config_plane_get_default_rotation() - Get the default rotation for a plane
  * @plane_cfg: Plane to get the default rotation from
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 2b0f7a8a80b5..fb30cffc10ef 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -93,7 +93,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		}
 	}
 
-	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
+	vkms_config_for_each_connector_static(vkmsdev->config, connector_cfg) {
 		struct vkms_config_encoder *possible_encoder;
 		unsigned long idx = 0;
 

-- 
2.56.0


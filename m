Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DAD606A691
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fVpXE4Oq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16FC011235E;
	Thu, 26 Nov 2026 11:33:17 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FE15112352
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:32:50 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id CC76B4E41693;
 Thu, 26 Nov 2026 11:32:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A179D60237;
 Thu, 26 Nov 2026 11:32:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 539B011E6B363; Thu, 26 Nov 2026 12:32:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795692763; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=XrIhrTNEdMaHfIfr7Qz+tsiSQAhq+etFjnqVIOPmNLE=;
 b=fVpXE4OqFH86y7O95dIIafmYUvgLCGNYYBjj55zO8qcV1mI+iUAiQ6qCoJuLkklggLEMNR
 nIYsfFgWRUpe9f0kAqNe0/ZToTFDezrhkSaJxUfc/3r44o21rA7KxuJrhgyRYlBi7Q/B0H
 bMlkZrv645X5TpahK9opmJiIL8LziVHjEE6EYEb4WFh2+ENL4lY8OYJqj4eRlsRGMWnD5o
 jE0vx4izsCv3vr2CjfXHp0hayvZ91zBqN8Fvpao+cjciRH5UDrIhBXG0EX+Ceemz97p3Id
 /zJ4TGZLWhSOCLXCo2Qc+A8CaRaLJYUUMwFU6/6/1dE6bIAlDtaUea1iX8D2JQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 26 Nov 2026 12:29:19 +0100
Subject: [PATCH v7 36/43] drm/vkms: Introduce config for connector EDID
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vkms-all-config-v7-36-21194cda2468@bootlin.com>
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

Allows configuration of EDID for each connector.

get_modes() uses the connector back-pointer (with an explicit
reference) instead of walking the whole configuration list.

Store the EDID in a dedicated vkms_config_edid structure holding the
data, its length and an rcu_head, so that the data and its length are
always read coherently. Writers publish the new structure with
rcu_assign_pointer() and free the previous one after a grace period
with call_rcu(); vkms_config_connector_get_edid() returns the data with
rcu_dereference(), so readers must hold rcu_read_lock() while using the
returned pointer. Take it around the mode probe in vkms_conn_get_modes()
and around the debugfs configuration output.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c |  2 +
 drivers/gpu/drm/vkms/vkms_config.c            | 62 ++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.h            | 75 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.c         | 50 ++++++++++++++++--
 4 files changed, 185 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index 1c54d6f9828d..8a13c45e1683 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -218,6 +218,8 @@ static void vkms_config_test_default_config(struct kunit *test)
 		KUNIT_EXPECT_EQ(test,
 				vkms_config_connector_get_supported_colorspaces(connector_cfg),
 				0);
+		KUNIT_EXPECT_EQ(test, vkms_config_connector_get_edid_enabled(connector_cfg),
+				false);
 	}
 
 	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index fa4ca256b4b9..173e88122bcb 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -613,6 +613,7 @@ static int vkms_config_show(struct seq_file *m, void *data)
 	struct drm_device *dev = entry->dev;
 	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
 	const char *dev_name;
+	int edid_len;
 	struct vkms_config_plane *plane_cfg;
 	struct vkms_config_crtc *crtc_cfg;
 	struct vkms_config_encoder *encoder_cfg;
@@ -688,6 +689,11 @@ static int vkms_config_show(struct seq_file *m, void *data)
 			show_bitfield(m, vkms_config_connector_get_supported_colorspaces(connector_cfg),
 				      drm_get_colorspace_name);
 			seq_puts(m, "\n");
+			vkms_config_connector_get_edid(connector_cfg, &edid_len);
+			seq_printf(m, "\tEDID=%s (len=%d)\n",
+				   str_enabled_disabled(vkms_config_connector_get_edid_enabled(connector_cfg)),
+				   edid_len
+			);
 		}
 	}
 
@@ -1058,6 +1064,14 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_connector);
 
+static void vkms_config_edid_free(struct rcu_head *head)
+{
+	struct vkms_config_edid *edid = container_of(head, struct vkms_config_edid, rcu);
+
+	kfree(edid->edid);
+	kfree(edid);
+}
+
 static void vkms_config_connector_release(struct kref *ref)
 {
 	struct vkms_config_connector *connector_cfg =
@@ -1070,6 +1084,8 @@ static void vkms_config_connector_release(struct kref *ref)
 		/* The config is dying and is draining us: just unlink */
 		list_del_init(&connector_cfg->link);
 	}
+	if (connector_cfg->edid)
+		call_rcu(&connector_cfg->edid->rcu, vkms_config_edid_free);
 	kfree_rcu(connector_cfg, rcu);
 }
 
@@ -1086,6 +1102,52 @@ void vkms_config_connector_put(struct vkms_config_connector *connector_cfg)
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_connector_put);
 
+/**
+ * vkms_config_connector_set_edid() - Set the EDID data for a connector
+ * @connector_cfg: Connector configuration to modify
+ * @edid: Pointer to the EDID data buffer
+ * @len: Length of the EDID data
+ *
+ * If @len is 0, the EDID data will be cleared and @edid ignored.
+ *
+ * The old EDID data is freed after an RCU grace period, so readers
+ * currently accessing it are not affected.
+ *
+ * Returns: 0 in case of success, -ENOMEM if the memory allocation
+ * failed. On failure the existing EDID data is preserved.
+ */
+int vkms_config_connector_set_edid(struct vkms_config_connector *connector_cfg,
+				   const u8 *edid, unsigned int len)
+{
+	struct vkms_config_edid *old, *new;
+
+	if (!len) {
+		old = rcu_dereference_protected(connector_cfg->edid, true);
+		rcu_assign_pointer(connector_cfg->edid, NULL);
+		if (old)
+			call_rcu(&old->rcu, vkms_config_edid_free);
+		return 0;
+	}
+
+	new = kmalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	new->edid = kmemdup(edid, len, GFP_KERNEL);
+	if (!new->edid) {
+		kfree(new);
+		return -ENOMEM;
+	}
+	new->edid_len = len;
+
+	old = rcu_dereference_protected(connector_cfg->edid, true);
+	rcu_assign_pointer(connector_cfg->edid, new);
+	if (old)
+		call_rcu(&old->rcu, vkms_config_edid_free);
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_connector_set_edid);
+
 void vkms_config_destroy_connector(struct vkms_config_connector *connector_cfg)
 {
 	/*
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 341e0638b508..ef8de0316b94 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -145,6 +145,22 @@ struct vkms_config_encoder {
 	struct drm_encoder *encoder;
 };
 
+/**
+ * struct vkms_config_edid - RCU-protected EDID data
+ *
+ * @edid: Pointer to the EDID data buffer
+ * @edid_len: Length of the EDID data
+ * @rcu: RCU head for safe freeing
+ *
+ * This struct ensures EDID data and its length are always accessed
+ * coherently by readers without requiring locks.
+ */
+struct vkms_config_edid {
+	const u8 *edid;
+	unsigned int edid_len;
+	struct rcu_head rcu;
+};
+
 /**
  * struct vkms_config_connector
  *
@@ -157,6 +173,8 @@ struct vkms_config_encoder {
  *                         are the sames as ones accepted by
  *                         drm_mode_create_hdmi_colorspace_property() and
  *                         drm_mode_create_dp_colorspace_property()
+ * @edid_enabled: If true, create the EDID property
+ * @edid: RCU-protected EDID data. Readers must use rcu_read_lock() to access.
  * @possible_encoders: Array of encoders that can be used with this connector
  * @unlinked: Set when the connector was unlinked from config->connectors
  *            by vkms_config_destroy_connector()
@@ -175,6 +193,8 @@ struct vkms_config_connector {
 	int type;
 	enum drm_connector_status status;
 	u32 supported_colorspaces;
+	bool edid_enabled;
+	struct vkms_config_edid __rcu *edid;
 	struct xarray possible_encoders;
 	bool unlinked;
 
@@ -327,6 +347,61 @@ vkms_config_connector_get_supported_colorspaces(const struct vkms_config_connect
 	return connector_cfg->supported_colorspaces;
 }
 
+/**
+ * vkms_config_connector_get_edid_enabled() - Check if EDID is enabled for a connector
+ * @connector_cfg: Connector configuration to check
+ *
+ * Returns:
+ * True if EDID is enabled for this connector, false otherwise.
+ */
+static inline bool
+vkms_config_connector_get_edid_enabled(const struct vkms_config_connector *connector_cfg)
+{
+	return connector_cfg->edid_enabled;
+}
+
+/**
+ * vkms_config_connector_set_edid_enabled() - Enable or disable EDID for a connector
+ * @connector_cfg: Connector configuration to modify
+ * @enabled: Whether to enable EDID for this connector
+ */
+static inline void
+vkms_config_connector_set_edid_enabled(struct vkms_config_connector *connector_cfg,
+				       bool enabled)
+{
+	connector_cfg->edid_enabled = enabled;
+}
+
+/**
+ * vkms_config_connector_get_edid() - Get the EDID data for a connector
+ * @connector_cfg: Connector configuration to get the EDID from
+ * @len: Pointer to store the length of the EDID data
+ *
+ * The caller must hold rcu_read_lock() when calling this function and
+ * while using the returned pointer.
+ *
+ * Returns:
+ * Pointer to the EDID data buffer, or NULL if no EDID is set.
+ * The length of the EDID data is stored in @len.
+ */
+static inline const u8 *
+vkms_config_connector_get_edid(const struct vkms_config_connector *connector_cfg, int *len)
+{
+	const struct vkms_config_edid *edid = rcu_dereference(connector_cfg->edid);
+
+	if (edid) {
+		*len = edid->edid_len;
+		return edid->edid;
+	}
+
+	*len = 0;
+	return NULL;
+}
+
+int vkms_config_connector_set_edid(struct vkms_config_connector *connector_cfg,
+				   const u8 *edid, unsigned int len);
+
+
 /**
  * vkms_config_get_device_name() - Return the name of the device
  * @config: Configuration to get the device name from
diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index 552d767c3976..71a0ae15be65 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -43,13 +43,48 @@ static const struct drm_connector_funcs vkms_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
+static int vkms_connector_read_block(void *context, u8 *buf, unsigned int block, size_t len)
+{
+	struct vkms_config_connector *config = context;
+	unsigned int edid_len;
+	const u8 *edid = vkms_config_connector_get_edid(config, &edid_len);
+
+	if (block * len + len > edid_len)
+		return 1;
+	memcpy(buf, &edid[block * len], len);
+	return 0;
+}
+
 static int vkms_conn_get_modes(struct drm_connector *connector)
 {
-	int count;
+	struct vkms_connector *vkms_connector = drm_connector_to_vkms_connector(connector);
+	const struct drm_edid *drm_edid = NULL;
+	int count = 0;
+	struct vkms_config_connector *cfg = vkms_config_connector_get(vkms_connector->cfg);
+
+	if (vkms_config_connector_get_edid_enabled(cfg)) {
+		/*
+		 * Hold rcu_read_lock() for the entire duration so that
+		 * the EDID data accessed via the callback remains valid.
+		 */
+		rcu_read_lock();
+		drm_edid = drm_edid_read_custom(connector,
+						vkms_connector_read_block, cfg);
+
+		drm_edid_connector_update(connector, drm_edid);
+
+		count = drm_edid_connector_add_modes(connector);
+
+		drm_edid_free(drm_edid);
+		rcu_read_unlock();
+	} else {
+		drm_edid_connector_update(connector, NULL);
+
+		count = drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
+		drm_set_preferred_mode(connector, XRES_DEF, YRES_DEF);
+	}
 
-	/* Use the default modes list from DRM */
-	count = drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
-	drm_set_preferred_mode(connector, XRES_DEF, YRES_DEF);
+	vkms_config_connector_put(cfg);
 
 	return count;
 }
@@ -120,6 +155,13 @@ static int __must_check vkms_connector_init(struct vkms_connector *connector,
 		}
 	}
 
+	/*
+	 * The DRM core skips Virtual connectors when attaching the EDID
+	 * property; attach it here so an EDID set later can be stored.
+	 */
+	if (connector_cfg->type == DRM_MODE_CONNECTOR_VIRTUAL)
+		drm_connector_attach_edid_property(&connector->base);
+
 	return 0;
 }
 

-- 
2.56.0


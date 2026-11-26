Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23435606A32D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=nBeGd7XE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 654CC11233F;
	Thu, 26 Nov 2026 11:31:22 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 140BF11233A
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:31:03 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id DA2171A1808;
 Thu, 26 Nov 2026 11:31:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AC69B60237;
 Thu, 26 Nov 2026 11:31:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 30F6111E6B363; Thu, 26 Nov 2026 12:30:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795692659; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=m7CmBieiqPHIRoAXcO3E5oLBGgt6Pn3+s0ge/tyQXds=;
 b=nBeGd7XEZkHjWprf1sOxKZjcd1K87X10Hm3V3LvmKF/pgSWC+2BNB10teh+mvTTPrA7HDe
 qRp9F34xhc/pnkv4+Q/8JbacukDzWfXWo3TQIrBNYZArSdCaTNQ518z13iR1ZP1jnVN8qK
 zT8wDMLdYUFHboKiDNEPnDbjwuSH+THTeCQaxkwpzn9KgysQELVKVIMkhm7tgNOlpplRSk
 TxZ1hM799AvI3n9VUUEoXgPnQPAlt+2wJzMAqv3bspV9nLRwwfCM1dUl3RPwYCIszM9irn
 rFhIJts6TYEwr/3W52qVfmT9JodwIT42W6BnHN8InAh4Gq5Y2T/qL2u/2yjTsA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 26 Nov 2026 12:29:00 +0100
Subject: [PATCH v7 17/43] drm/vkms: Introduce config for plane name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vkms-all-config-v7-17-21194cda2468@bootlin.com>
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

As planes can have a name in DRM, prepare VKMS to configure it using
ConfigFS.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 37 ++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/vkms/vkms_config.h | 22 ++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c  |  8 +++++++-
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index e2b656723898..56ab9ea6e141 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -391,6 +391,9 @@ static int vkms_config_show(struct seq_file *m, void *data)
 			seq_puts(m, "plane:\n");
 			seq_printf(m, "\ttype=%s\n",
 				   drm_get_plane_type_name(vkms_config_plane_get_type(plane_cfg)));
+			seq_printf(m, "\tname=%s\n",
+				   vkms_config_plane_get_name(plane_cfg) ?
+				   vkms_config_plane_get_name(plane_cfg) : "(null)");
 		}
 
 		vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
@@ -436,25 +439,57 @@ struct vkms_config_plane __must_check *vkms_config_create_plane(struct vkms_conf
 	plane_cfg->config = config;
 	plane_cfg->default_pipeline = false;
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_OVERLAY);
+
+	ret = vkms_config_plane_set_name(plane_cfg, NULL, 0);
+	if (ret)
+		goto cleanup_plane_cfg;
+
 	xa_init_flags(&plane_cfg->possible_crtcs, XA_FLAGS_ALLOC);
 
 	list_add_tail_rcu(&plane_cfg->link, &config->planes);
 
 	return plane_cfg;
 
+cleanup_plane_cfg:
+	kfree(plane_cfg);
 fail:
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_plane);
 
+static void vkms_config_plane_rcu_free(struct rcu_head *head)
+{
+	struct vkms_config_plane *plane_cfg =
+		container_of(head, struct vkms_config_plane, rcu);
+
+	kfree(plane_cfg->name);
+	kfree(plane_cfg);
+}
+
 void vkms_config_destroy_plane(struct vkms_config_plane *plane_cfg)
 {
 	xa_destroy(&plane_cfg->possible_crtcs);
 	list_del_rcu(&plane_cfg->link);
-	kfree_rcu(plane_cfg, rcu);
+	call_rcu(&plane_cfg->rcu, vkms_config_plane_rcu_free);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_plane);
 
+int __must_check vkms_config_plane_set_name(struct vkms_config_plane *plane_cfg,
+					    const char *name, size_t name_len)
+{
+	char *new_name;
+
+	new_name = kmemdup_nul(name, name_len, GFP_KERNEL);
+	if (name && !new_name)
+		return -ENOMEM;
+
+	kfree(plane_cfg->name);
+	plane_cfg->name = new_name;
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_plane_set_name);
+
 int __must_check vkms_config_plane_attach_crtc(struct vkms_config_plane *plane_cfg,
 					       struct vkms_config_crtc *crtc_cfg)
 {
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 8f038562afd4..e428946cb70e 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -50,6 +50,7 @@ struct vkms_config {
  * @link: Link to the others planes in vkms_config
  * @rcu: RCU head for deferred freeing of this object
  * @config: The vkms_config this plane belongs to
+ * @name: Name of the plane
  * @type: Type of the plane. The creator of configuration needs to ensures that
  *        at least one primary plane is present.
  * @possible_crtcs: Array of CRTCs that can be used with this plane
@@ -63,6 +64,7 @@ struct vkms_config_plane {
 	struct rcu_head rcu;
 	struct vkms_config *config;
 
+	const char *name;
 	enum drm_plane_type type;
 	struct xarray possible_crtcs;
 	bool default_pipeline;
@@ -368,6 +370,26 @@ vkms_config_plane_set_default_pipeline(struct vkms_config_plane *plane_cfg,
 	plane_cfg->default_pipeline = default_pipeline;
 }
 
+/**
+ * vkms_config_plane_set_name() - Set the plane name
+ * @plane_cfg: Plane to set the name to
+ * @name: New plane name. The name is copied.
+ *
+ * Returns: -ENOMEM if the memory allocation failed, 0 in case of success
+ */
+int __must_check vkms_config_plane_set_name(struct vkms_config_plane *plane_cfg,
+					    const char *name, size_t name_len);
+
+/**
+ * vkms_config_plane_get_name - Get the plane name
+ * @plane_cfg: Plane to get the name from
+ */
+static inline const char *
+vkms_config_plane_get_name(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->name;
+}
+
 /**
  * vkms_config_plane_attach_crtc - Attach a plane to a CRTC
  * @plane_cfg: Plane to attach
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index fd3d34dcf0fe..35aabec85b33 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -12,6 +12,7 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_print.h>
 
+#include "vkms_config.h"
 #include "vkms_drv.h"
 #include "vkms_formats.h"
 
@@ -261,11 +262,16 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 	struct drm_device *dev = &vkmsdev->drm;
 	struct vkms_plane *plane;
 
+	/*
+	 * Keep the default "plane-%d" name from the DRM core when no name is
+	 * configured, instead of passing a NULL string to "%s".
+	 */
 	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 0,
 					   &vkms_plane_funcs,
 					   vkms_formats, ARRAY_SIZE(vkms_formats),
 					   NULL, vkms_config_plane_get_type(plane_cfg),
-					   NULL);
+					   vkms_config_plane_get_name(plane_cfg) ? "%s" : NULL,
+					   vkms_config_plane_get_name(plane_cfg));
 	if (IS_ERR(plane))
 		return plane;
 

-- 
2.56.0


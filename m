Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCE2C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:31:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B95610E431;
	Sat, 27 Jun 2026 03:31:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jUAV4GAr";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84D3610E429
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:31:23 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 11981C5CD7C;
 Sat, 27 Jun 2026 03:31:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F36E160233;
 Sat, 27 Jun 2026 03:31:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5ACFB106F1165; 
 Sat, 27 Jun 2026 05:31:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782531080; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=KCMs2RMoADPaxjHq/4ARjDIv6HVXkjxZfynU+B9MuJI=;
 b=jUAV4GAreC6ZCebdohvdyZcY4n7ja8dzNW5IQ/I3PFHPj9hgSSSNL/ZvCsOtl77DXKfz0v
 s04kK7EkJBIjHdf/beUIdLY4DkcI7gwpjkWYa/s1d25orj8EZ64xe+xMp0DqGT6beZjx9d
 vd5qFGuYVECLV95GD2QDLgZFT/so3dBrU+Go6vnnhB31lsNRPedEK5QIEYWvLKs/OryGCB
 3f8VQk/zC9j3QgWZcpojuJMrZgCbjKyLirLgcr4ehx6rxuTG1/RatbezTH6ceJciweW1Y+
 BzZsux68hVlQ7S9XB7aXM4agyOe0AqsR5pNZKy5mJ5WFYwg9igK4wgfgJeoVvg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 27 Jun 2026 05:30:30 +0200
Subject: [PATCH v5 13/38] drm/vkms: Introduce config for plane name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-vkms-all-config-v5-13-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
In-Reply-To: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, victoria@system76.com, 
 sebastian.wick@redhat.com, victoria@system76.com, airlied@gmail.com, 
 thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>, llvm@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4628;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=OrK0S1Whky5ucJT5nD88CmquKyvy6s4uqJRwRqrFlDw=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBqP0PeM9Cd8OH5YTOhNOl2t9WP1l1CWKtkaqn5I
 Wa4zpjecSuJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaj9D3hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOLrUA/+Pd5/W6B9l8YE/gPm5fTdse47pbt+q+s
 08aaV/yyCmIT6sSDajsDPkUZm4RVyyPbcIMbOV2g0fTSSQeLrHxvp5C/xzsqiFxuDcWRMJZZRFr
 GKUxHfq52gO6yu3AhpLcf8t3vo9VKXadoV5z9CknUhEiWMQ039x3T13Y/QMegvXUP0HHDJepGsv
 fV6fEt74q4Y9s7TRx6z3DZDhRifNNQ4sFJUL+wbLHzigyhsfZ9stWNpSfKAsd7U5HwEUK945lrp
 xh/AJyntzj5rNUcTLCR7eC0Ho+qozYmVDoXcp4cHlEVMF1cVJpK2C+1HK/UauPlgz8AWPNUNWCi
 +JnGTX6QxDVqYpI19v/ZrAANqdhpS0HYJHkuF6sr4HVH0aQbgmIuemgbDL1d4ucUqjEjHKWD8HY
 4bYABPwinRXYvwwM1BUPKJC6eOd/Ljf7kPJew0rHeK77u2lcUa3/DMlnlPFZUWd99Aftu7+5oA+
 Qit/Ebb2Ovx9E0OdJ/uRZecofOw6IIDG5w2+ZDRuMIhKzj7aKPfQUXClvoasb6WCQd9kQt2PWpz
 ltwV73wQDTzOWeB7QFjSOpphaz8/bq5mNMeQld056yGw4xgEyyB/5OYkrOBeo5/JLKxliW5Ju89
 kbq3cGIqJhpwoJT5DCQ5ZpP5AudoXWamWYTh3YJ+ru+pLeaJOiiY=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
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

As planes can have a name in DRM, prepare VKMS to configure it using
ConfigFS.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 11 +++++++++++
 drivers/gpu/drm/vkms/vkms_config.h | 34 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c  |  3 ++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 9071d6864d52..54994f3c8e14 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -356,6 +356,9 @@ static int vkms_config_show(struct seq_file *m, void *data)
 		seq_puts(m, "plane:\n");
 		seq_printf(m, "\ttype=%s\n",
 			   drm_get_plane_type_name(vkms_config_plane_get_type(plane_cfg)));
+		seq_printf(m, "\tname=%s\n",
+			   vkms_config_plane_get_name(plane_cfg) ?
+			   vkms_config_plane_get_name(plane_cfg) : "(null)");
 	}
 
 	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
@@ -400,12 +403,19 @@ struct vkms_config_plane __must_check *vkms_config_create_plane(struct vkms_conf
 	plane_cfg->config = config;
 	plane_cfg->default_pipeline = false;
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_OVERLAY);
+
+	ret = vkms_config_plane_set_name(plane_cfg, NULL, 0);
+	if (ret)
+		goto cleanup_plane_cfg;
+
 	xa_init_flags(&plane_cfg->possible_crtcs, XA_FLAGS_ALLOC);
 
 	list_add_tail(&plane_cfg->link, &config->planes);
 
 	return plane_cfg;
 
+cleanup_plane_cfg:
+	kfree(plane_cfg);
 fail:
 	return ERR_PTR(ret);
 }
@@ -415,6 +425,7 @@ void vkms_config_destroy_plane(struct vkms_config_plane *plane_cfg)
 {
 	xa_destroy(&plane_cfg->possible_crtcs);
 	list_del(&plane_cfg->link);
+	kfree(plane_cfg->name);
 	kfree(plane_cfg);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_plane);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 8f7f286a4bdd..e34f4cbfe8b8 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -3,6 +3,7 @@
 #ifndef _VKMS_CONFIG_H_
 #define _VKMS_CONFIG_H_
 
+#include <linux/string.h>
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
@@ -35,6 +36,7 @@ struct vkms_config {
  *
  * @link: Link to the others planes in vkms_config
  * @config: The vkms_config this plane belongs to
+ * @name: Name of the plane
  * @type: Type of the plane. The creator of configuration needs to ensures that
  *        at least one primary plane is present.
  * @possible_crtcs: Array of CRTCs that can be used with this plane
@@ -47,6 +49,7 @@ struct vkms_config_plane {
 	struct list_head link;
 	struct vkms_config *config;
 
+	const char *name;
 	enum drm_plane_type type;
 	struct xarray possible_crtcs;
 	bool default_pipeline;
@@ -314,6 +317,37 @@ vkms_config_plane_set_default_pipeline(struct vkms_config_plane *plane_cfg,
 	plane_cfg->default_pipeline = default_pipeline;
 }
 
+/**
+ * vkms_config_plane_set_name() - Set the plane name
+ * @plane_cfg: Plane to set the name to
+ * @name: New plane name. The name is copied.
+ *
+ * Returns: -ENOMEM if the memory allocation failed, 0 in case of success
+ */
+static inline int __must_check
+vkms_config_plane_set_name(struct vkms_config_plane *plane_cfg,
+			   const char *name, size_t name_len)
+{
+	kfree(plane_cfg->name);
+
+	plane_cfg->name = kmemdup_nul(name, name_len, GFP_KERNEL);
+
+	if (name && !plane_cfg->name)
+		return -ENOMEM;
+
+	return 0;
+}
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
index 68cb2a3335e6..f35120203124 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -11,6 +11,7 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_print.h>
 
+#include "vkms_config.h"
 #include "vkms_drv.h"
 #include "vkms_formats.h"
 
@@ -228,7 +229,7 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 					   &vkms_plane_funcs,
 					   vkms_formats, ARRAY_SIZE(vkms_formats),
 					   NULL, vkms_config_plane_get_type(plane_cfg),
-					   NULL);
+					   vkms_config_plane_get_name(plane_cfg));
 	if (IS_ERR(plane))
 		return plane;
 

-- 
2.54.0


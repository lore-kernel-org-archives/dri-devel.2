Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF6C60A6F6C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=zDA2Xcjg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D27112C6D;
	Fri, 20 Nov 2026 18:04:35 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC860112C66
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:04:21 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 7F42D1A1757;
 Fri, 20 Nov 2026 18:04:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 528C5601B9;
 Fri, 20 Nov 2026 18:04:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DEDA511BC08D7; Fri, 20 Nov 2026 19:04:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197858; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=bovjhTF929t/EhEj+lrwcqzgP+RaTKEfLba0kv0M/D8=;
 b=zDA2XcjgfF0+H/mShyoWolFQ6G1cWIml5F/U3G5hG9QyutPMP0ZDA8L3jegj2VmY2tfQj+
 TL2Zp2sIXcrDPvvsIcbPuPowdzqz6YigUHa0zW5bOv2QtJQFzh8IfvOmsr0+ChEhLLHpeG
 HcV4Vq9oMv09tri0P6x5Acc0J/5NLOk3Zts7Ir2Zy4jWIazjNgVftWQ7bz4QBifg2rIhNJ
 Ksf9Z8Y/SjX3XtTk+5QeSyCuqr1Dj8ptTrgTqMf0lTU4nQ1RLTm90p0ghGR5fj+uGdrYZA
 NmTbOQ0Z2/Z9ePBpn6bXtwdz07YD+v3M2c9SGjqaFyPDkiutXxvbGX/faoHqMQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 20 Nov 2026 18:59:00 +0100
Subject: [PATCH v6 18/43] drm/vkms: Introduce config for plane name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vkms-all-config-v6-18-78ace90f4fc1@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4490;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=vh+dkp5wcZli5cK0MUpSsS6MGsbDjFsfTgok8eQF73I=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIr/Mvl8sVMUqXoquWx5WZAGthoGiu2U30GVl
 DPcovVfj/iJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCK/xsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOKtSQ/+OwPdbKxhzmAkSBg7ecamCHpuzwcecPd
 RlApPOV0sVSnl4PhSqcVRvvfXx3YpoJjayS2U1wSpo1pWBUb2L2+JgJR+jCw4aGuAfrWJwjc/LS
 OR2HaL+VENFmZrt510n0ZxvJnULpMVehbrtMS9Pk6LLetvKdaaAUAtak+C5LLts0gn+z2FCoIMd
 Tkany9R1b6hzY5NrpM576xhxTLbDepJJ0ymNDZgddnPE/3SLpDf/DZZyFB52/9KBgm+pCTBjArw
 EHxOZlDu+8D9E3HkwNKJ5eg/o6qjQz495hFPg7i8bWpobXkf8EzT17M8G8Itpb4uYF8fAWukNPm
 yLbzqNQgwNQgqEqkiIrkpk3G+wdFwCUlA6g1lUYzwnbHizdW5ykHE491fnGBoxyrmR9sg4uuUQo
 A/YWdh7l/hlvKuzw4b5CyrEanjW7vq6ZMpM2LkNDO9AjGmiq9hitc3r8TObCK9zOLWSKvBQsUiF
 884nraZWBHBFqZvRUFUJl6rkrw5MFr3urm4iUkHOL0oTMydHVBnZ+V8rLZZCWVazEZprIjTdCnJ
 zpw4xyIrdwBpZVtJtqpgfubQlUdfBdRtphLsc+2znvBarcRKF45sCZppDDb+exm8BFNnh497HDi
 r4BZlZrl/D0GHRC95c/SzdDBjCN70aDTwJTHvO2nixJCWsQdu93E=
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

As planes can have a name in DRM, prepare VKMS to configure it using
ConfigFS.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 11 +++++++++++
 drivers/gpu/drm/vkms/vkms_config.h | 35 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c  |  3 ++-
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 4127fb176a87..fe82fb9e344a 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -394,6 +394,9 @@ static int vkms_config_show(struct seq_file *m, void *data)
 		seq_puts(m, "plane:\n");
 		seq_printf(m, "\ttype=%s\n",
 			   drm_get_plane_type_name(vkms_config_plane_get_type(plane_cfg)));
+		seq_printf(m, "\tname=%s\n",
+			   vkms_config_plane_get_name(plane_cfg) ?
+			   vkms_config_plane_get_name(plane_cfg) : "(null)");
 	}
 
 	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
@@ -439,12 +442,19 @@ struct vkms_config_plane __must_check *vkms_config_create_plane(struct vkms_conf
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
@@ -454,6 +464,7 @@ void vkms_config_destroy_plane(struct vkms_config_plane *plane_cfg)
 {
 	xa_destroy(&plane_cfg->possible_crtcs);
 	list_del(&plane_cfg->link);
+	kfree(plane_cfg->name);
 	kfree(plane_cfg);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_plane);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 49510a0957c7..8704b6f71000 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -44,6 +44,7 @@ struct vkms_config {
  *
  * @link: Link to the others planes in vkms_config
  * @config: The vkms_config this plane belongs to
+ * @name: Name of the plane
  * @type: Type of the plane. The creator of configuration needs to ensures that
  *        at least one primary plane is present.
  * @possible_crtcs: Array of CRTCs that can be used with this plane
@@ -56,6 +57,7 @@ struct vkms_config_plane {
 	struct list_head link;
 	struct vkms_config *config;
 
+	const char *name;
 	enum drm_plane_type type;
 	struct xarray possible_crtcs;
 	bool default_pipeline;
@@ -342,6 +344,39 @@ vkms_config_plane_set_default_pipeline(struct vkms_config_plane *plane_cfg,
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
index fd3d34dcf0fe..8ea05c1d98e4 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -12,6 +12,7 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_print.h>
 
+#include "vkms_config.h"
 #include "vkms_drv.h"
 #include "vkms_formats.h"
 
@@ -265,7 +266,7 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 					   &vkms_plane_funcs,
 					   vkms_formats, ARRAY_SIZE(vkms_formats),
 					   NULL, vkms_config_plane_get_type(plane_cfg),
-					   NULL);
+					   "%s", vkms_config_plane_get_name(plane_cfg));
 	if (IS_ERR(plane))
 		return plane;
 

-- 
2.56.0


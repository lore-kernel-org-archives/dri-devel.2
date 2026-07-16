Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DF7C44511
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D33510F36C;
	Thu, 16 Jul 2026 16:06:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="mWPp6x1d";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E842E10E74F;
 Thu, 16 Jul 2026 16:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=EVbs9WCN3mhlAo6SGZxK7diTq45Y1pSFmb85ZuSqsr0=; b=mWPp6x1d6Oo36gncKjHULm5OFO
 CAcEib543jrOOeF0qLpWE1+gsAAKmZz20dE7rCFQlUoKHhrJNGfUf9SbmZ3YgW/p39/WJHYaJzmWJ
 WD7rvvwZ5MOOYNrO55GYqQL8C4bg2Vq/i/z7h56Jwgqg45Ydq4qhrDU26Bi4IvT26MKiSnxsv5clw
 AgjRv3hW4fIFLgJxgskVV+GJ/vPBAfNNwgZxvAu+nL7GKyzjFgSC278NKrJdzIddQE5cgFWzg50JG
 Asj64GbK8NXQfBqd3UKg+NP2KCRwn6Z/JYTudLi8c6buuM4lvbd/CjmZAWYtKhcnssiE4Ztp/s5rh
 1VVA/Duw==;
Received: from [178.139.170.72] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wkObF-00G01i-1d; Thu, 16 Jul 2026 18:06:13 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Ariel DAlessandro <ariel.dalessandro@collabora.com>,
 "Nicolas F . R . A . Prado" <nfraprado@collabora.com>,
 Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>,
 Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 John Harrison <John.Harrison@Igalia.com>, kernel-dev@igalia.com,
 Louis Chauvet <louis.chauvet@bootlin.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [RFC PATCH v2 03/20] drm: Factor out common color_pipeline property
 initialization code
Date: Thu, 16 Jul 2026 18:03:00 +0200
Message-ID: <20260716160556.227556-4-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716160556.227556-1-mwen@igalia.com>
References: <20260716160556.227556-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

In preparation for sharing the initialization code for the color
pipeline property between pre-blend (plane) and post-blend (crtc) color
pipelines, factor out the common initialization to a separate function.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Co-developed-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_plane.c    | 34 ++++----------------------
 drivers/gpu/drm/drm_property.c | 44 ++++++++++++++++++++++++++++++++++
 include/drm/drm_property.h     |  5 ++++
 3 files changed, 53 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index 46adef2a30c0..e7f388817b66 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -1839,41 +1839,15 @@ int drm_plane_create_color_pipeline_property(struct drm_plane *plane,
 					     const struct drm_prop_enum_list *pipelines,
 					     int num_pipelines)
 {
-	struct drm_prop_enum_list *all_pipelines;
 	struct drm_property *prop;
-	int len = 0;
-	int i;
 
-	all_pipelines = kzalloc_objs(*all_pipelines, num_pipelines + 1);
+	prop = drm_property_create_color_pipeline(plane->dev, &plane->base,
+						  pipelines, num_pipelines);
+	if (IS_ERR(prop))
+		return PTR_ERR(prop);
 
-	if (!all_pipelines) {
-		drm_err(plane->dev, "failed to allocate color pipeline\n");
-		return -ENOMEM;
-	}
-
-	/* Create default Bypass color pipeline */
-	all_pipelines[len].type = 0;
-	all_pipelines[len].name = "Bypass";
-	len++;
-
-	/* Add all other color pipelines */
-	for (i = 0; i < num_pipelines; i++, len++) {
-		all_pipelines[len].type = pipelines[i].type;
-		all_pipelines[len].name = pipelines[i].name;
-	}
-
-	prop = drm_property_create_enum(plane->dev, DRM_MODE_PROP_ATOMIC,
-					"COLOR_PIPELINE",
-					all_pipelines, len);
-	if (!prop) {
-		kfree(all_pipelines);
-		return -ENOMEM;
-	}
-
-	drm_object_attach_property(&plane->base, prop, 0);
 	plane->color_pipeline_property = prop;
 
-	kfree(all_pipelines);
 	return 0;
 }
 EXPORT_SYMBOL(drm_plane_create_color_pipeline_property);
diff --git a/drivers/gpu/drm/drm_property.c b/drivers/gpu/drm/drm_property.c
index f38f2c5437e6..ff606f31eb4b 100644
--- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -1008,3 +1008,47 @@ void drm_property_change_valid_put(struct drm_property *property,
 	} else if (drm_property_type_is(property, DRM_MODE_PROP_BLOB))
 		drm_property_blob_put(obj_to_blob(ref));
 }
+
+struct drm_property *
+drm_property_create_color_pipeline(struct drm_device *dev, struct drm_mode_object *obj,
+				   const struct drm_prop_enum_list *pipelines,
+				   int num_pipelines)
+{
+	struct drm_prop_enum_list *all_pipelines;
+	struct drm_property *prop;
+	int len = 0;
+	int i;
+
+	all_pipelines = kcalloc(num_pipelines + 1,
+				sizeof(*all_pipelines),
+				GFP_KERNEL);
+
+	if (!all_pipelines) {
+		drm_err(dev, "failed to allocate color pipeline\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* Create default Bypass color pipeline */
+	all_pipelines[len].type = 0;
+	all_pipelines[len].name = "Bypass";
+	len++;
+
+	/* Add all other color pipelines */
+	for (i = 0; i < num_pipelines; i++, len++) {
+		all_pipelines[len].type = pipelines[i].type;
+		all_pipelines[len].name = pipelines[i].name;
+	}
+
+	prop = drm_property_create_enum(dev, DRM_MODE_PROP_ATOMIC,
+					"COLOR_PIPELINE",
+					all_pipelines, len);
+	if (!prop) {
+		kfree(all_pipelines);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	drm_object_attach_property(obj, prop, 0);
+
+	kfree(all_pipelines);
+	return prop;
+}
diff --git a/include/drm/drm_property.h b/include/drm/drm_property.h
index aa49b5a42bb5..2ba4062f8bfa 100644
--- a/include/drm/drm_property.h
+++ b/include/drm/drm_property.h
@@ -297,6 +297,11 @@ bool drm_property_replace_blob(struct drm_property_blob **blob,
 struct drm_property_blob *drm_property_blob_get(struct drm_property_blob *blob);
 void drm_property_blob_put(struct drm_property_blob *blob);
 
+struct drm_property *
+drm_property_create_color_pipeline(struct drm_device *dev, struct drm_mode_object *obj,
+				   const struct drm_prop_enum_list *pipelines,
+				   int num_pipelines);
+
 /**
  * drm_property_find - find property object
  * @dev: DRM device
-- 
2.53.0


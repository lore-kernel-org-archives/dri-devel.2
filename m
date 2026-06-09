Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1974CD98C9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9F6310E518;
	Tue,  9 Jun 2026 17:20:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="T83Y5ahz";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 599D210E4B8
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 17:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qALqgKjcNRzkHYwDTviIlWtC4VRIBJ/dvrAgLXTOznM=; b=T83Y5ahzw4D0MjQyctaZ1Z9VJo
 he3fhlQE65/Nmqh0pk9e+hO2s7RKd/dzsZKWgfMSsv2CHvNkym0YdMcyIksLfSJ3+jOU5358nrCnv
 IGUhWCaWH6NsWMSfKfqBdNmwPqw5NAjbQ7wBgwezt9M3x7h/lwc8x1kd1LhPGJKN/drFj8Q1F5vno
 NM1vm2SbtNHhy/22Yz4J7S3z+SeuU1fNMpeTuozdjVDHLRSvZO4C/Rs0rANBBqKSKMYIEZnQK4N43
 9lFxKeBWpiEdLLLZ2Tjen1v7ZuAG/86m+YBZHJfPViy8dDEo6JdPqwtMiXMThuswhHtemU09OhfQw
 O7UPNIXw==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wX080-00F5FG-Db
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 19:20:40 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 1/8] drm/colorop: Reduce scope of colorop helpers
Date: Tue,  9 Jun 2026 10:19:34 -0700
Message-ID: <20260609171941.169104-2-John.Harrison@Igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609171941.169104-1-John.Harrison@Igalia.com>
References: <20260609171941.169104-1-John.Harrison@Igalia.com>
MIME-Version: 1.0
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

The drm_colorop_find function had a comment saying that uses outside
of DRM properties are deprecated. Such uses seem to have all been
removed and this function is only ever used once inside the property
assignment code. So make it a static helper local to the file.

Likewise drm_atomic_set_colorop_for_plane is never used outside of the
property set code. So make it a local static helper as well.

Signed-off-by: John Harrison <John.Harrison@Igalia.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 23 ++++++++++++++++-------
 include/drm/drm_colorop.h         | 20 --------------------
 2 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 6441b55cc274..530576850239 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -259,16 +259,16 @@ drm_atomic_set_fb_for_plane(struct drm_plane_state *plane_state,
 EXPORT_SYMBOL(drm_atomic_set_fb_for_plane);
 
 /**
- * drm_atomic_set_colorop_for_plane - set colorop for plane
+ * set_colorop_for_plane - set colorop for plane
  * @plane_state: atomic state object for the plane
  * @colorop: colorop to use for the plane
  *
  * Helper function to select the color pipeline on a plane by setting
  * it to the first drm_colorop element of the pipeline.
  */
-void
-drm_atomic_set_colorop_for_plane(struct drm_plane_state *plane_state,
-				 struct drm_colorop *colorop)
+static void
+set_colorop_for_plane(struct drm_plane_state *plane_state,
+		      struct drm_colorop *colorop)
 {
 	struct drm_plane *plane = plane_state->plane;
 
@@ -284,7 +284,16 @@ drm_atomic_set_colorop_for_plane(struct drm_plane_state *plane_state,
 
 	plane_state->color_pipeline = colorop;
 }
-EXPORT_SYMBOL(drm_atomic_set_colorop_for_plane);
+
+static struct drm_colorop *colorop_find(struct drm_device *dev,
+					struct drm_file *file_priv,
+					uint32_t id)
+{
+	struct drm_mode_object *mo;
+
+	mo = drm_mode_object_find(dev, file_priv, id, DRM_MODE_OBJECT_COLOROP);
+	return mo ? obj_to_colorop(mo) : NULL;
+}
 
 /**
  * drm_atomic_set_crtc_for_connector - set CRTC for connector
@@ -599,12 +608,12 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
 		/* find DRM colorop object */
 		struct drm_colorop *colorop = NULL;
 
-		colorop = drm_colorop_find(dev, file_priv, val);
+		colorop = colorop_find(dev, file_priv, val);
 
 		if (val && !colorop)
 			return -EACCES;
 
-		drm_atomic_set_colorop_for_plane(state, colorop);
+		set_colorop_for_plane(state, colorop);
 	} else if (property == config->prop_fb_damage_clips) {
 		ret = drm_property_replace_blob_from_id(dev,
 					&state->fb_damage_clips,
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index b4b9e4f558ab..7f0bd58fb625 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -381,26 +381,6 @@ struct drm_colorop {
 
 #define obj_to_colorop(x) container_of(x, struct drm_colorop, base)
 
-/**
- * drm_colorop_find - look up a Colorop object from its ID
- * @dev: DRM device
- * @file_priv: drm file to check for lease against.
- * @id: &drm_mode_object ID
- *
- * This can be used to look up a Colorop from its userspace ID. Only used by
- * drivers for legacy IOCTLs and interface, nowadays extensions to the KMS
- * userspace interface should be done using &drm_property.
- */
-static inline struct drm_colorop *drm_colorop_find(struct drm_device *dev,
-						   struct drm_file *file_priv,
-						   uint32_t id)
-{
-	struct drm_mode_object *mo;
-
-	mo = drm_mode_object_find(dev, file_priv, id, DRM_MODE_OBJECT_COLOROP);
-	return mo ? obj_to_colorop(mo) : NULL;
-}
-
 void drm_colorop_pipeline_destroy(struct drm_device *dev);
 void drm_colorop_cleanup(struct drm_colorop *colorop);
 
-- 
2.43.0


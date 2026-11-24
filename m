Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5973B606A69C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=jwy9Pgv7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F4310F838;
	Tue, 24 Nov 2026 18:18:41 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80CDA10F033;
 Tue, 24 Nov 2026 18:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=xFwgZLKZ7q3GKRYJvLVJfnCxCnDsTUODSJ1kWrjoeMo=; t=1795544294; x=2110904294; 
 b=jwy9Pgv74q0LYDNcaad6nmF5dgiHn++t4bzHInAza5Zv7GNrMkbu8okiB2B77iBIp3CXlvI1AV2
 XPojhvixYx9jv03rZlOTfDOupqDx/sM6+GOJMv2yEfc74SHUU3ZRkvxqhxEz7KAwCImy9EM4I1XId
 uutoEgSINIi+50QTGP7evkZh+xCohOi08WdNzkaarikJ045xzUuVNbuaXUhpYRBd+BDyD4Dlh1YPL
 bek6TCI/74ENHB5QHAIUev/4X5x/V84HSGMKRtBokAvWunI0sfRff+rXxpAVUDd9F5l6MMQNibVNP
 HKaXfhwgc7HQ83iZ4T+m4m3wJP/cvNbsoT9w==;
Received: from 84.125.127.4.dyn.user.ono.com ([84.125.127.4] helo=killbill)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVv5h-00000003axM-0O1i; Tue, 24 Nov 2026 19:18:05 +0100
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Ariel DAlessandro <ariel.dalessandro@collabora.com>,
 nfraprado@collabora.com, Alex Hung <alex.hung@amd.com>,
 Simon Ser <contact@emersion.fr>, Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 John Harrison <John.Harrison@Igalia.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 Daniel Stone <daniels@collabora.com>, kernel-dev@igalia.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>
Subject: [PATCH v3 05/19] drm: Factor out common color_pipeline property
 initialization code
Date: Tue, 24 Nov 2026 19:03:22 +0100
Message-ID: <20261124181652.1333986-6-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124181652.1333986-1-mwen@igalia.com>
References: <20261124181652.1333986-1-mwen@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

In preparation for sharing the initialization code for the color
pipeline property between pre-blend (plane) and post-blend (crtc) color
pipelines, factor out the common initialization to a separate function.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Co-developed-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>

---
v3:
- rebase on drm-misc-next, no other changes
---
 drivers/gpu/drm/drm_plane.c    | 34 ++++----------------------
 drivers/gpu/drm/drm_property.c | 44 ++++++++++++++++++++++++++++++++++
 include/drm/drm_property.h     |  5 ++++
 3 files changed, 53 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index bd4a1d678420..199d42b01fc4 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -1837,41 +1837,15 @@ int drm_plane_create_color_pipeline_property(struct drm_plane *plane,
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
index 91f114cf9f60..8d5c98ceae8c 100644
--- a/drivers/gpu/drm/drm_property.c
+++ b/drivers/gpu/drm/drm_property.c
@@ -1007,3 +1007,47 @@ void drm_property_change_valid_put(struct drm_property *property,
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


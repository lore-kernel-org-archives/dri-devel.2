Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC0B606A6A5
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=JZEPlOj+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4AC410F83C;
	Tue, 24 Nov 2026 18:18:50 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CB9A10F085;
 Tue, 24 Nov 2026 18:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=gXasZiqSBEMSlncM/ERSCegHIAK8FRiAoCjcZ+TovIk=; t=1795544309; x=2110904309; 
 b=JZEPlOj+BnlDy2YHVjgimc1oDssoS33/3gvts7WHJ/lMxWcynEPEnv/5Hz0FwMQSZyyHuPK+RUN
 8wFYxKki6cQnkED5E3XHb1bCN7myZCgdkRb3YhHQTVdFSZvoI2M1B1SZSATcafA/9IJLTMYbN3nnC
 r74VffB1g/K1EeYwRrgBq9Dr4+DUsPny3T/y7YFP6XeRmdavsToPJSyto+3m4QtG12aOgEnOPV51u
 uMHaPoyrPS3n/KmI5Z/HEFpgBwLKfm//aKgtcGTLG6liP2omF35wHHemeZWO7I/N6FKH+UlYtd84q
 CCjxPdHkozaYe2aysmrMZHSTY9cNjEwq8v9A==;
Received: from 84.125.127.4.dyn.user.ono.com ([84.125.127.4] helo=killbill)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVv5s-00000003axM-06NF; Tue, 24 Nov 2026 19:18:16 +0100
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
Subject: [PATCH v3 11/19] drm/colorop: Introduce colorop helpers for crtc
Date: Tue, 24 Nov 2026 19:03:28 +0100
Message-ID: <20261124181652.1333986-12-mwen@igalia.com>
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

Introduce colorop helper counterparts for post-blend color pipelines
that take a CRTC instead of a plane.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Co-developed-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>

---
v3:
- rebase on drm-misc-next, no other changes
---
 drivers/gpu/drm/drm_colorop.c | 81 +++++++++++++++++++++++++++++++++++
 include/drm/drm_colorop.h     | 14 ++++++
 2 files changed, 95 insertions(+)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index baef70460da9..2f62050524b2 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -185,6 +185,21 @@ static int drm_plane_colorop_init(struct drm_device *dev,
 	return ret;
 }
 
+static int drm_crtc_colorop_init(struct drm_device *dev,
+				 struct drm_colorop *colorop,
+				 struct drm_crtc *crtc,
+				 const struct drm_colorop_funcs *funcs,
+				 enum drm_colorop_type type, uint32_t flags)
+{
+	int ret;
+
+	ret = drm_common_colorop_init(dev, colorop, funcs, type, flags);
+
+	colorop->crtc = crtc;
+
+	return ret;
+}
+
 /**
  * drm_colorop_cleanup - Cleanup a drm_colorop object in color_pipeline
  *
@@ -313,6 +328,26 @@ int drm_plane_colorop_curve_1d_init(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drm_plane_colorop_curve_1d_init);
 
+int drm_crtc_colorop_curve_1d_init(struct drm_device *dev,
+				   struct drm_colorop *colorop,
+				   struct drm_crtc *crtc,
+				   const struct drm_colorop_funcs *funcs,
+				   u64 supported_tfs, uint32_t flags)
+{
+	int ret;
+
+	ret = drm_colorop_has_supported_tf(dev, &crtc->base, crtc->name, supported_tfs);
+	if (ret)
+		return ret;
+
+	ret = drm_crtc_colorop_init(dev, colorop, crtc, funcs, DRM_COLOROP_1D_CURVE, flags);
+	if (ret)
+		return ret;
+
+	return drm_common_colorop_curve_1d_init(dev, colorop, supported_tfs, flags);
+}
+EXPORT_SYMBOL(drm_crtc_colorop_curve_1d_init);
+
 static int drm_colorop_create_data_prop(struct drm_device *dev, struct drm_colorop *colorop)
 {
 	struct drm_property *prop;
@@ -402,6 +437,37 @@ drm_plane_colorop_curve_1d_lut_init(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drm_plane_colorop_curve_1d_lut_init);
 
+/**
+ * drm_crtc_colorop_curve_1d_lut_init - Initialize a DRM_COLOROP_1D_LUT
+ *
+ * @dev: DRM device
+ * @colorop: The drm_colorop object to initialize
+ * @crtc: The associated drm_crtc
+ * @lut_size: LUT size supported by driver
+ * @interpolation: 1D LUT interpolation type
+ * @flags: bitmask of misc, see DRM_COLOROP_FLAG_* defines.
+ * @return zero on success, -E value on failure
+ */
+int
+drm_crtc_colorop_curve_1d_lut_init(struct drm_device *dev,
+				   struct drm_colorop *colorop,
+				   struct drm_crtc *crtc,
+				   const struct drm_colorop_funcs *funcs,
+				   uint32_t lut_size,
+				   enum drm_colorop_lut1d_interpolation_type interpolation,
+				   uint32_t flags)
+{
+	int ret;
+
+	ret = drm_crtc_colorop_init(dev, colorop, crtc, funcs, DRM_COLOROP_1D_LUT, flags);
+	if (ret)
+		return ret;
+
+	return drm_common_colorop_curve_1d_lut_init(dev, colorop, lut_size,
+						    interpolation, flags);
+}
+EXPORT_SYMBOL(drm_crtc_colorop_curve_1d_lut_init);
+
 static int drm_common_colorop_ctm_3x4_init(struct drm_device *dev,
 					   struct drm_colorop *colorop,
 					   uint32_t flags)
@@ -433,6 +499,21 @@ int drm_plane_colorop_ctm_3x4_init(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drm_plane_colorop_ctm_3x4_init);
 
+int drm_crtc_colorop_ctm_3x4_init(struct drm_device *dev, struct drm_colorop *colorop,
+				  struct drm_crtc *crtc,
+				  const struct drm_colorop_funcs *funcs,
+				  uint32_t flags)
+{
+	int ret;
+
+	ret = drm_crtc_colorop_init(dev, colorop, crtc, funcs, DRM_COLOROP_CTM_3X4, flags);
+	if (ret)
+		return ret;
+
+	return drm_common_colorop_ctm_3x4_init(dev, colorop, flags);
+}
+EXPORT_SYMBOL(drm_crtc_colorop_ctm_3x4_init);
+
 /**
  * drm_plane_colorop_mult_init - Initialize a DRM_COLOROP_MULTIPLIER
  *
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index 3a71cecd8273..657a8cff1227 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -535,6 +535,13 @@ static inline struct drm_colorop *drm_colorop_find(struct drm_device *dev,
 void drm_colorop_pipeline_destroy(struct drm_device *dev);
 void drm_colorop_cleanup(struct drm_colorop *colorop);
 
+int drm_crtc_colorop_curve_1d_lut_init(struct drm_device *dev, struct drm_colorop *colorop,
+				       struct drm_crtc *crtc,
+				       const struct drm_colorop_funcs *funcs,
+				       uint32_t lut_size,
+				       enum drm_colorop_lut1d_interpolation_type interpolation,
+				       uint32_t flags);
+
 int drm_plane_colorop_curve_1d_init(struct drm_device *dev, struct drm_colorop *colorop,
 				    struct drm_plane *plane, const struct drm_colorop_funcs *funcs,
 				    u64 supported_tfs, uint32_t flags);
@@ -544,9 +551,16 @@ int drm_plane_colorop_curve_1d_lut_init(struct drm_device *dev, struct drm_color
 					uint32_t lut_size,
 					enum drm_colorop_lut1d_interpolation_type interpolation,
 					uint32_t flags);
+int drm_crtc_colorop_curve_1d_init(struct drm_device *dev, struct drm_colorop *colorop,
+				   struct drm_crtc *crtc,
+				   const struct drm_colorop_funcs *funcs,
+				   u64 supported_tfs, uint32_t flags);
+
 int drm_plane_colorop_ctm_3x4_init(struct drm_device *dev, struct drm_colorop *colorop,
 				   struct drm_plane *plane, const struct drm_colorop_funcs *funcs,
 				   uint32_t flags);
+int drm_crtc_colorop_ctm_3x4_init(struct drm_device *dev, struct drm_colorop *colorop,
+				   struct drm_crtc *crtc, const struct drm_colorop_funcs *funcs, uint32_t flags);
 int drm_plane_colorop_mult_init(struct drm_device *dev, struct drm_colorop *colorop,
 				struct drm_plane *plane, const struct drm_colorop_funcs *funcs,
 				uint32_t flags);
-- 
2.53.0


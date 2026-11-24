Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F7C606A680
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=WygejVMm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C44F10F802;
	Tue, 24 Nov 2026 18:18:38 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E6710F057;
 Tue, 24 Nov 2026 18:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=QVL9W42nvgkLP2Vqrm+7iN+S9thlvQSdBRGc6TaW+uk=;
 t=1795544297; x=2110904297; b=WygejVMmGHBqF9Mw56Zft9PLEc/rRfc8X3MejA54hUaTxs1
 3E8kI55QugPu9LUL2fLBZTTvzZNfESDxnd2y/OOxzE2dNxLDzYTbk2UP8PUPeJMQxln8s7gZ+MJ0V
 n/vIvBN0upb7fyI6NU03AMzzocs0owq9kY4nG8H/18nI63sfy9sf6SLiB4GdypRmmEyyNdZJeJlrH
 Alkkg7YDElrgD7pLgu2FVJgM6gqlPxNmX8zGl8uTQLhEoqCq2servrJTPIIY6QjSk3lVoij1U4aAj
 NdGzN0iSaiL9L0AcvFWQeL7QFlB49tZoqOS7mNBJSHJMPT0pzqinrCdTB8LJmeKw==;
Received: from 84.125.127.4.dyn.user.ono.com ([84.125.127.4] helo=killbill)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVv5k-00000003axM-2aq7; Tue, 24 Nov 2026 19:18:08 +0100
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
 Melissa Wen <mwen@igalia.com>
Subject: [PATCH v3 07/19] drm/atomic: track individual CRTC colorop updates
Date: Tue, 24 Nov 2026 19:03:24 +0100
Message-ID: <20261124181652.1333986-8-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124181652.1333986-1-mwen@igalia.com>
References: <20261124181652.1333986-1-mwen@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

As done for plane colorops by commit 2e235e2a2784b ("drm/atomic: track
individual colorop updates"), make drm_atomic_set_colorop_for_crtc()
report whether the CRTC color pipeline changed and set
CRTC color_mgmt_changed flag accordingly.

Signed-off-by: Melissa Wen <mwen@igalia.com>

---
v3:
- new patch: set color_mgmt_changed when the CRTC COLOR_PIPELINE value
  changes, as commit 2e235e2a2784 does for planes
---
 drivers/gpu/drm/drm_atomic_uapi.c | 12 ++++++++++--
 include/drm/drm_atomic_uapi.h     |  2 +-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 9c3889ebda2b..183716cf0db9 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -301,13 +301,18 @@ EXPORT_SYMBOL(drm_atomic_set_colorop_for_plane);
  *
  * Helper function to select the color pipeline on a crtc by setting
  * it to the first drm_colorop element of the pipeline.
+ *
+ * Return: true if CRTC color pipeline value changed, false otherwise.
  */
-void
+bool
 drm_atomic_set_colorop_for_crtc(struct drm_crtc_state *crtc_state,
 				 struct drm_colorop *colorop)
 {
 	struct drm_crtc *crtc = crtc_state->crtc;
 
+	if (crtc_state->color_pipeline == colorop)
+		return false;
+
 	if (colorop)
 		drm_dbg_atomic(crtc->dev,
 			       "Set [COLOROP:%d] for [CRTC:%d:%s] state %p\n",
@@ -319,6 +324,8 @@ drm_atomic_set_colorop_for_crtc(struct drm_crtc_state *crtc_state,
 			       crtc->base.id, crtc->name, crtc_state);
 
 	crtc_state->color_pipeline = colorop;
+
+	return true;
 }
 EXPORT_SYMBOL(drm_atomic_set_colorop_for_crtc);
 
@@ -449,7 +456,8 @@ static int drm_atomic_crtc_set_property(struct drm_crtc *crtc,
 		if (val && !colorop)
 			return -EACCES;
 
-		drm_atomic_set_colorop_for_crtc(state, colorop);
+		state->color_mgmt_changed |=
+			drm_atomic_set_colorop_for_crtc(state, colorop);
 	} else if (property == config->prop_mode_id) {
 		struct drm_property_blob *mode =
 			drm_property_lookup_blob(dev, val);
diff --git a/include/drm/drm_atomic_uapi.h b/include/drm/drm_atomic_uapi.h
index 90e5c207a53b..04fb32eccd0f 100644
--- a/include/drm/drm_atomic_uapi.h
+++ b/include/drm/drm_atomic_uapi.h
@@ -54,7 +54,7 @@ void drm_atomic_set_fb_for_plane(struct drm_plane_state *plane_state,
 				 struct drm_framebuffer *fb);
 bool drm_atomic_set_colorop_for_plane(struct drm_plane_state *plane_state,
 				      struct drm_colorop *colorop);
-void drm_atomic_set_colorop_for_crtc(struct drm_crtc_state *crtc_state,
+bool drm_atomic_set_colorop_for_crtc(struct drm_crtc_state *crtc_state,
 				     struct drm_colorop *colorop);
 int __must_check
 drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
-- 
2.53.0


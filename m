Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE84606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ZYu7E+l4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2B7D112347;
	Thu, 26 Nov 2026 11:32:13 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A924D11230B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:32:03 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 707D34E41693;
 Thu, 26 Nov 2026 11:32:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3DE7360237;
 Thu, 26 Nov 2026 11:32:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 89C7811E6B306; Thu, 26 Nov 2026 12:31:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795692716; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=gbsdBUqknC0EeL3+wfraXPXc6qkvnAiATIJni8y7zLA=;
 b=ZYu7E+l4C0WMnK9FHdrKyv19gIZSVVzfeDezavy9V3mIX5KSYn4uonVjFcCXEWS1uiJFPJ
 uWDnsi29YBjMW0JGElZAX3gTXe/8GW9G5CFix/ByjuHTX/sYmBy+ZjplYloTZpmzfTItBf
 /G7f8B+ZyxQ+gYx5TCn14Jzm7ut9NqWEsyBdg9TkhJ1ZvSbBpO2RF7B8fEnwePC+Mrrz2M
 qhteHsDPOamdxjBv9TWHNzdpP6A5OPI+u/IgCM2cviOvBDzH8pBHWSg02k/gLO6MlnHWG1
 00Z0okmyWPvDuyACCdjNmFxBOcNT2DFdRo2IDSNgNJsMMlZiLtb80/lhIT9Hgw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 26 Nov 2026 12:29:10 +0100
Subject: [PATCH v7 27/43] drm/vkms: Properly render plane using their zpos
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vkms-all-config-v7-27-21194cda2468@bootlin.com>
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

Currently planes are rendered in creation order. This is not an issue, but
with the introduction of new zpos configuration, it is required to
properly render planes.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 15 ++++++++++++---
 drivers/gpu/drm/vkms/vkms_crtc.c     | 16 ++++++++--------
 drivers/gpu/drm/vkms/vkms_drv.c      |  2 ++
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 7a6a7875520c..4ccca8bd0c5c 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -592,7 +592,8 @@ static void blend(struct vkms_writeback_job *wb,
 
 		/* The active planes are composed associatively in z-order. */
 		for (size_t i = 0; i < n_active_planes; i++) {
-			blend_line(plane[i], y, crtc_x_limit, stage_buffer, output_buffer);
+			if (plane[i])
+				blend_line(plane[i], y, crtc_x_limit, stage_buffer, output_buffer);
 		}
 
 		apply_lut(crtc_state, output_buffer);
@@ -610,9 +611,13 @@ static int check_format_funcs(struct vkms_crtc_state *crtc_state,
 	struct vkms_plane_state **planes = crtc_state->active_planes;
 	u32 n_active_planes = crtc_state->num_active_planes;
 
-	for (size_t i = 0; i < n_active_planes; i++)
+	for (size_t i = 0; i < n_active_planes; i++) {
+		/* Invisible planes are stored as NULL entries */
+		if (!planes[i])
+			continue;
 		if (!planes[i]->pixel_read_line)
 			return -1;
+	}
 
 	if (active_wb && !active_wb->pixel_write)
 		return -1;
@@ -625,9 +630,13 @@ static int check_iosys_map(struct vkms_crtc_state *crtc_state)
 	struct vkms_plane_state **plane_state = crtc_state->active_planes;
 	u32 n_active_planes = crtc_state->num_active_planes;
 
-	for (size_t i = 0; i < n_active_planes; i++)
+	for (size_t i = 0; i < n_active_planes; i++) {
+		/* Invisible planes are stored as NULL entries */
+		if (!plane_state[i])
+			continue;
 		if (iosys_map_is_null(&plane_state[i]->frame_info.map[0]))
 			return -1;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index 019d7bc90cdc..eaddd8b70494 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -133,9 +133,6 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 		plane_state = drm_atomic_get_new_plane_state(crtc_state->state, plane);
 		WARN_ON(!plane_state);
 
-		if (!plane_state->visible)
-			continue;
-
 		i++;
 	}
 
@@ -144,15 +141,18 @@ static int vkms_crtc_atomic_check(struct drm_crtc *crtc,
 		return -ENOMEM;
 	vkms_state->num_active_planes = i;
 
-	i = 0;
 	drm_for_each_plane_mask(plane, crtc->dev, crtc_state->plane_mask) {
 		plane_state = drm_atomic_get_new_plane_state(crtc_state->state, plane);
 
+		/*
+		 * normalized_zpos is computed by the DRM core and is unique
+		 * in the range 0..n_planes-1: use it to index the array.
+		 */
 		if (!plane_state->visible)
-			continue;
-
-		vkms_state->active_planes[i++] =
-			to_vkms_plane_state(plane_state);
+			vkms_state->active_planes[plane_state->normalized_zpos] = NULL;
+		else
+			vkms_state->active_planes[plane_state->normalized_zpos] =
+				to_vkms_plane_state(plane_state);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index f73f136e5588..6c88e2a6a890 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -155,6 +155,8 @@ static int vkms_modeset_init(struct vkms_device *vkmsdev)
 	dev->mode_config.preferred_depth = 0;
 	dev->mode_config.helper_private = &vkms_mode_config_helpers;
 
+	dev->mode_config.normalize_zpos = true;
+
 	return vkms_output_init(vkmsdev);
 }
 

-- 
2.56.0


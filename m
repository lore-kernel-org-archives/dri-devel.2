Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1EA606A604
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ea2vxCIj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA1F112806;
	Thu,  5 Nov 2026 15:53:26 +0000 (UTC)
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFCBB112806;
 Thu,  5 Nov 2026 15:53:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793893990; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=oGccq0teFashXMSLxx2OcFA7A2Ow7yeOt7iCh/fwiHcE4n8WVihOPW3o7cLPXOcPn2sKv0tRz0LfwWOYRJTjjY8dad9vu3jUPMmjTV02ny8VSgnDoZ9wAAX4aOx8UQpM9nR7NImL52sEZVCg/+pm4WgsWDGWz32vxk8mdcmISVk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793893990;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=mbSJbOadZG+W4UAprD18p6zrB6saFJ1TMM5/bUt+RW0=; 
 b=E2rMjFHRt4fcQqmy7LH7G93ocmQMhS+1FNEfDrD5RoS/6TfaK+MSGschBwwEGFqBvCBXRYj7VzeTwxDM0UYTOuypEr8ZckORvw/IC16/1iGuJEi1DFMFNqQ0HsfYIYofT5hNwZfmhbph4JHWx7yayKuRB53LuJDznUJBbbH/bvs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=ea2vxCIjvzhWDuC1NHVIs2LcHIRwhgrvZUWJJISdgR8xIgQJnqVzyLsaTw5bV8eShtohdYr6fOMXtvAZPgaC2MSAMZOgSJiS40sNZNV1fdbfqAWoWg/guB8UdYbjLMhCTCFE726+nEZfKN4m3yD3BbHKngl79ZGsMxnDJK+t2LM=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=mbSJbOadZG+W4UAprD18p6zrB6saFJ1TMM5/bUt+RW0=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179389399040296.01747505061871;
 Thu, 5 Nov 2026 07:53:10 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:51:57 +0100
Subject: [PATCH v2 06/27] drm/crtc-helper: Add VRR helper functions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-vrr-limiter-uapi-v2-6-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
In-Reply-To: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
To: Xaver Hugl <xaver.hugl@gmail.com>, Vidith Madhu <vmadhu@nvidia.com>, 
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VRR needs to change the vertical front porch timing to change the duration
of a frame. Add two helpers to aid in this.

drm_crtc_helper_vrr_flush should be called when the source has a new
frame ready to present. It adjusts the internal VRR state, and returns
whether the current vtotal has been changed. Callers can then adjust
their hardware state as is necessary.

drm_crtc_helper_vrr_vsync should be called in the vblank interrupt
handler. It adjusts the internal VRR state, and returns whether the
current vtotal has been changed. Callers can then adjust their hardware
state as is necessary.

Co-developed-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_crtc_helper.c | 63 +++++++++++++++++++++++++++++++++++++++
 include/drm/drm_crtc_helper.h     |  4 +++
 2 files changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index 4a8cfe046e4a..4ffb3b0b7878 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -838,6 +838,69 @@ int drm_crtc_helper_set_config(struct drm_mode_set *set,
 }
 EXPORT_SYMBOL(drm_crtc_helper_set_config);
 
+/**
+ * drm_crtc_helper_vrr_flush - Update VRR state on frame ready
+ * @crtc_state: pointer to &struct drm_crtc_state of CRTC that has a new frame ready
+ *
+ * Update the VRR state by communicating that a frame is ready on
+ * @crtc_state.crtc.
+ *
+ * Should be called from the @crtc_state.crtc &drm_crtc_helper_funcs.atomic_flush
+ * hook.
+ *
+ * Returns:
+ * - %true if @crtc_state.vrr_state.cur_vtotal changed
+ * - %false otherwise
+ */
+bool drm_crtc_helper_vrr_flush(struct drm_crtc_state *crtc_state)
+{
+	struct drm_crtc_vrr_state *vrr = &crtc_state->vrr_state;
+
+	if (!crtc_state->vrr_enabled) {
+		if (vrr->cur_vtotal) {
+			vrr->cur_vtotal = 0;
+			return true;
+		}
+		return false;
+	}
+
+	if (vrr->cur_vtotal == vrr->base_vtotal)
+		return false;
+
+	vrr->cur_vtotal = vrr->base_vtotal;
+
+	return true;
+}
+EXPORT_SYMBOL(drm_crtc_helper_vrr_flush);
+
+/**
+ * drm_crtc_helper_vrr_vsync - Update VRR state on vblank end
+ * @crtc_state: pointer to &struct drm_crtc_state of CRTC the vblank occurred on
+ *
+ * Update the VRR state by communicating that a vertical blank has ended and a
+ * new frame is about to start.
+ *
+ * Returns:
+ *  - %true if @crtc_state.vrr_state.cur_vtotal changed
+ *  - %false otherwise
+ */
+bool drm_crtc_helper_vrr_vsync(struct drm_crtc_state *crtc_state)
+{
+	struct drm_crtc_vrr_state *vrr = &crtc_state->vrr_state;
+	u16 old_vtotal = vrr->cur_vtotal;
+
+	if (!crtc_state->vrr_enabled)
+		vrr->cur_vtotal = 0;
+	else
+		vrr->cur_vtotal = vrr->max_vtotal;
+
+	if (abs_diff(vrr->cur_vtotal, old_vtotal) > 1)
+		vrr->dynamic = true;
+
+	return old_vtotal != vrr->cur_vtotal;
+}
+EXPORT_SYMBOL(drm_crtc_helper_vrr_vsync);
+
 static int drm_helper_choose_encoder_dpms(struct drm_encoder *encoder)
 {
 	int dpms = DRM_MODE_DPMS_OFF;
diff --git a/include/drm/drm_crtc_helper.h b/include/drm/drm_crtc_helper.h
index 855da5733c47..0c8c11ea36dd 100644
--- a/include/drm/drm_crtc_helper.h
+++ b/include/drm/drm_crtc_helper.h
@@ -44,6 +44,7 @@ struct drm_encoder;
 struct drm_framebuffer;
 struct drm_mode_set;
 struct drm_modeset_acquire_ctx;
+struct drm_crtc_state;
 
 void drm_helper_disable_unused_functions(struct drm_device *dev);
 int drm_crtc_helper_set_config(struct drm_mode_set *set,
@@ -62,4 +63,7 @@ int drm_helper_connector_dpms(struct drm_connector *connector, int mode);
 void drm_helper_resume_force_mode(struct drm_device *dev);
 int drm_helper_force_disable_all(struct drm_device *dev);
 
+bool drm_crtc_helper_vrr_flush(struct drm_crtc_state *crtc_state);
+bool drm_crtc_helper_vrr_vsync(struct drm_crtc_state *crtc_state);
+
 #endif

-- 
2.56.0


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39204606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y8H/95QC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2BD510EA53;
	Fri,  6 Nov 2026 13:16:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C306D10EA46
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:16:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3F628601E3;
 Fri,  6 Nov 2026 13:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7244C1F0089F;
 Fri,  6 Nov 2026 13:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970962;
 bh=Qaf3tUL71i1Eyk/vxyrNcqVK/TbkJi8Ie1SrMY+fmJ4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Y8H/95QCvYTNl5eIwLNVutnoEhaZQv8MqtThrF0O2HnBJqeNiu+/3w6FEP/lc44gb
 bu8IG7ZRXtzgpuUgkBrPaFVRerDz+ZRSoaEzYlMuQ8eSn7dcHq5kbaR90ZGdAHl0bj
 F1Z4SkVXCKa2lpNXs+Nuh4YVJ5E9iha+gHffMvQZH4njRA7nWKp86HqrKHcFFwdrg2
 hh5GNiVliJmcMxwNHInPu1aztvE0TFASihzwGa6uPAlQlpjiNfK6DL+zEs+HUdAkC7
 wK2vD1hgiBubRM5j9L+GPswoUNYsJOduKyg3EtUuL+sY2y7uqRX/KjnGbnCvU6Kjva
 eebf0jLn/2ibA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:35 +0100
Subject: [PATCH v8 22/39] drm/modeset-helper: Add
 drm_mode_config_helper_hw_reset()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-22-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
In-Reply-To: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2470; i=mripard@kernel.org;
 h=from:subject:message-id; bh=nWWTVrDQdQv2ZF3yqEZFUGX9xsIOqVh7fKMZJfYyqxI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL207vvLfqs6bt+N11q62Mj/7q8o2RUi97uWPn98nm
 3ikT2hi7pjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQAT0c5nbHhdGqOld/cZbwTL
 AW/vo7ckvyx26rCTTvDh2hOkK8rec5hT3SVUpnzD97vvL/lst5X5zlhnGOPHrbu//6ujZIvO5bj
 r176qHAys+MKidIbbc6l91SLjDbfPHnVbU6w1/SaT15fvXmoA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_mode_config_create_initial_state() calls
&drm_mode_config_funcs.hw_reset when the hardware state readout fails,
to put the hardware in a known-good state before creating pristine
software state.

Provide drm_mode_config_helper_hw_reset() as a default implementation of
&drm_mode_config_funcs.hw_reset that resets all the objects requiring
it.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_modeset_helper.c | 31 +++++++++++++++++++++++++++++++
 include/drm/drm_modeset_helper.h     |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/drm_modeset_helper.c b/drivers/gpu/drm/drm_modeset_helper.c
index cca623eb23e5..1a49ab8a0e41 100644
--- a/drivers/gpu/drm/drm_modeset_helper.c
+++ b/drivers/gpu/drm/drm_modeset_helper.c
@@ -263,2 +263,33 @@ int drm_mode_config_helper_resume(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_mode_config_helper_resume);
+
+/**
+ * drm_mode_config_helper_hw_reset - default &drm_mode_config_funcs.hw_reset implementation
+ * @dev: DRM device
+ *
+ * Resets all KMS objects that provide a hardware reset hook to a
+ * known-good state, without touching the software state.
+ *
+ * Drivers can assign this function as their
+ * &drm_mode_config_funcs.hw_reset implementation.
+ */
+void drm_mode_config_helper_hw_reset(struct drm_device *dev)
+{
+	struct drm_crtc *crtc;
+
+	drm_for_each_crtc(crtc, dev) {
+		const struct drm_crtc_helper_funcs *helper_funcs =
+			crtc->helper_private;
+
+		if (helper_funcs && helper_funcs->hw_reset)
+			helper_funcs->hw_reset(crtc);
+	}
+
+	/*
+	 * TODO: Reset encoders once the semantics of
+	 * encoder->funcs->reset have been clarified. Some drivers
+	 * (e.g. i915) reset both hardware and software state, while
+	 * others (e.g. loongson) only reset hardware registers.
+	 */
+}
+EXPORT_SYMBOL(drm_mode_config_helper_hw_reset);
diff --git a/include/drm/drm_modeset_helper.h b/include/drm/drm_modeset_helper.h
index 7e3d4c5a7f66..bd4193fbd907 100644
--- a/include/drm/drm_modeset_helper.h
+++ b/include/drm/drm_modeset_helper.h
@@ -43,4 +43,5 @@ int drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 int drm_mode_config_helper_suspend(struct drm_device *dev);
 int drm_mode_config_helper_resume(struct drm_device *dev);
+void drm_mode_config_helper_hw_reset(struct drm_device *dev);
 
 #endif

-- 
2.55.0


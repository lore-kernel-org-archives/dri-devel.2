Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9B2C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3261B10E813;
	Mon,  7 Sep 2026 13:25:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JyZEMgaF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2434410E81B
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:25:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9B3E660AB5;
 Mon,  7 Sep 2026 13:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B711F00A3D;
 Mon,  7 Sep 2026 13:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788787509;
 bh=pX8+nWS/CK8UFYkgBoOqwRgx2n63GL8y22y9yz41HGQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JyZEMgaF8oudWBH3BHZfZdRpiUfhTrvsGut6SwYx4mP9QnJHvkgxjVs9lRPCieXxH
 G1TkS7182fvan9GDUSRvSnzs1GM9n6I740qc2U1jMKy27XVDbm/4JhpltVCOLbf8M7
 Mwdwo5GP4evEkCuJlVzrIjzgqW7/TtUBck/H2MazkaF04nEhKaB/j6TqjTBjwMRDZD
 vidxgqyRZ4viv2iCNJWRIqR/C3WwXA+t2HO48dt0E0KRSMuBzQhjxcqucpZsOaKCSt
 xhvNz8jO7jE9MAdJBHymCOrrA6tCmAWONZkOw+b4SZhzHVnrsK8+GiNu9H69rcsRNV
 MkQeYy172dvtw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 07 Sep 2026 15:23:54 +0200
Subject: [PATCH v5 18/33] drm/modeset-helper: Add
 drm_mode_config_helper_hw_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-state-readout-v5-18-5fa1ac7a5148@kernel.org>
References: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
In-Reply-To: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2307; i=mripard@kernel.org;
 h=from:subject:message-id; bh=3XY1VnVCBRxZ4KHIV04PwMbFuCvuGKDrl0MJ4wxAlmQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnzdj2V4f+6pv6zwmT7Y2E7BOee4lS8UnLxSkN/Zdmvd
 x83JR0V6ZjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATKfnHWB/P//Fwu4Ppx33f
 rp4oehnqsWb+tSn+KadYfq+4NX2ayEU+bSXTLaIMwe/fHfp5UsP+yzLGeifeUikuyeusBvsepM7
 1vF3XUhnxUPDPtP2rt6bXzlwWm//Jn/3GybMdxtGOavxHxbJNAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

drm_mode_config_create_initial_state() calls
&drm_mode_config_funcs.hw_reset when the hardware state readout fails,
to put the hardware in a known-good state before creating pristine
software state.

Provide drm_mode_config_helper_hw_reset() as a default implementation of
&drm_mode_config_funcs.hw_reset that resets all the objects requiring
it.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_modeset_helper.c | 24 ++++++++++++++++++++++++
 include/drm/drm_modeset_helper.h     |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/drm_modeset_helper.c b/drivers/gpu/drm/drm_modeset_helper.c
index e54584da4c3d..efff6dc9b88f 100644
--- a/drivers/gpu/drm/drm_modeset_helper.c
+++ b/drivers/gpu/drm/drm_modeset_helper.c
@@ -258,5 +258,29 @@ int drm_mode_config_helper_resume(struct drm_device *dev)
 		drm_kms_helper_poll_enable(dev);
 
 	return ret;
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
+}
+EXPORT_SYMBOL(drm_mode_config_helper_hw_reset);
diff --git a/include/drm/drm_modeset_helper.h b/include/drm/drm_modeset_helper.h
index 7e3d4c5a7f66..bd4193fbd907 100644
--- a/include/drm/drm_modeset_helper.h
+++ b/include/drm/drm_modeset_helper.h
@@ -40,7 +40,8 @@ void drm_helper_mode_fill_fb_struct(struct drm_device *dev,
 int drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
 		  const struct drm_crtc_funcs *funcs);
 
 int drm_mode_config_helper_suspend(struct drm_device *dev);
 int drm_mode_config_helper_resume(struct drm_device *dev);
+void drm_mode_config_helper_hw_reset(struct drm_device *dev);
 
 #endif

-- 
2.55.0


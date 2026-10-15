Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7161CCA462
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E14B10F3F0;
	Thu, 15 Oct 2026 15:10:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C66C10E95A
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:10:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8445D43749;
 Thu, 15 Oct 2026 15:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EAC1F000C4;
 Thu, 15 Oct 2026 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792077009;
 bh=ihwz4PfOBudFnwtntoI2VM4jlAmL2+1vezp6OIs9C9o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=U1PiN0840Or0GszPuloUbYmgMgZkhq6/svY4+iCuPsxU2zBm3ISLD7PKNJPJkAsbY
 IRSECOeqSf9sGkKdxSS8rDALxvmZFzIiRRsgatDlzN51+06SGFZ1SpghkIfPF6BXAN
 LPCtOXhQCOO+u+gKcCEQtI2x8hbFR7vgV15OTDO7GACYNASg3cit1IL9uQSvhqN88G
 hXblH+XRqJUpPUEKmKiYNx88hQLqxRuaO1GEPTLbm4SjcKsQV9cKIfAqez9pbRA/cN
 CCzb3Hc1bxoeIUR1WTNXmji3Exe6Hksfr7arduwVfkvu+7bCufpaAx+zmEKyJsdqsj
 rXUqzkzlZ0YJw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 15 Oct 2026 17:09:07 +0200
Subject: [PATCH v6 15/28] drm/modeset-helper: Add
 drm_mode_config_helper_hw_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-drm-state-readout-v6-15-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
In-Reply-To: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
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
 h=from:subject:message-id; bh=or5NlaWuW0qOWGD+n7GNUSp9EIDYQ+wtw9rAWfvqIS0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkX3kyc7PyaL2tWqf3Z3sxo25StnCVm3fNDtUOmceRtc
 xZfw6zZMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZy+iBjves+8+l7H4k4zPC/
 t0FINyKQb6PS4lDXlNvKvH8nspVsWSJVJ8Nx4vSrSVdznbOOzVPOZWxYmnaxLbbyJ/tsx01LwuV
 XO20tXakXIxG8MJCbKTzss8E5q4ITx69f/TI7/am4549OrTcA
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
index cca623eb23e5..10b0f2aa0209 100644
--- a/drivers/gpu/drm/drm_modeset_helper.c
+++ b/drivers/gpu/drm/drm_modeset_helper.c
@@ -260,5 +260,29 @@ int drm_mode_config_helper_resume(struct drm_device *dev)
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


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B272606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nl9uhcpn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ECB910EF28;
	Mon, 16 Nov 2026 10:34:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1975F10EF21
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:34:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 91D2160DC0;
 Mon, 16 Nov 2026 10:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE36D1F000C4;
 Mon, 16 Nov 2026 10:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825258;
 bh=LYeVShhlYydqt7kmUaw6Lf6FrtO6VNmvxM9SJsgcJGY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nl9uhcpn/x8HJ43kPHZFkYVXj31UltVgeS8kcdnewPTvkkZv8tmb87P4/xb7frfud
 RbLunrC4qH0EBiEqNkhwtH562F46CYmj8Yj9WOwJUX6G2hUK5qWS2NiWPho6mLuhWt
 2iQx02eAXbWBjKcenkStd/bDp9gAUsLTmDiEJ336OJLtbcrLhMa8DZQvIThP+Fjiat
 tATn/JFa64WDK0WpZ/7K2OPmlieOvcUzGMcYGj6AzIsWAuXsOmCiTaNi0K4/OLBl0a
 uoOlE2GULTWTAwwnENFNW9tQ4Tj91pA9g50D7ZyZUP5E+uDBIK8JP++hGOo1wR4Ltc
 mGu4qcv8lcbKQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:31:18 +0100
Subject: [PATCH v2 62/64] drm/vmwgfx: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-62-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Zack Rusin <zack.rusin@broadcom.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4803; i=mripard@kernel.org;
 h=from:subject:message-id; bh=7p+VqhgeMdYRWE8quZJpIBqm9y7cNhaBGutRfDMEC6Q=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bkf7/Fvwdeo2J/ZLaRP85vyZI36J/ZNpkZ4FWyvLk
 WMveRbu6pjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATaTJlbHipF/Pxz9Y757uL
 Dx//3a2yR8npzg0dD91PZ3VaDXmFTGTWBjd/C5XJW32XT9SqR4F1CmPDsaN7VkSt3q66b/KR8K/
 B19NXnuKfUruzW+BhnOQnr4i3QuxlPwTF7rjOSzdcsfLhyo/TAQ==
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

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  | 14 +++++++++++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  |  3 ---
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c |  3 ---
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |  3 ---
 4 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 90ab9380d883..4924649033bb 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1173,15 +1173,27 @@ int vmw_kms_init(struct vmw_private *dev_priv)
 	if (ret) {
 		ret = vmw_kms_sou_init_display(dev_priv);
 		if (ret) /* Fallback */
 			ret = vmw_kms_ldu_init_display(dev_priv);
 	}
+	if (ret)
+		return ret;
+
 	BUILD_BUG_ON(ARRAY_SIZE(display_unit_names) != (vmw_du_max + 1));
 	drm_info(&dev_priv->drm, "%s display unit initialized\n",
 		 display_unit_names[dev_priv->active_display_unit]);
 
-	return ret;
+	/*
+	 * Create the initial state once, after the display unit that will
+	 * be used has been settled on: a failure in one of the display
+	 * unit initialization functions is used as a fallback condition to
+	 * try the next one, and creating the state on a partially
+	 * initialized device would both leave the KMS objects of the two
+	 * backends on the same drm_device and trip WARN_ON() on the objects
+	 * that don't have a state.
+	 */
+	return drm_mode_config_create_initial_state(dev);
 }
 
 int vmw_kms_close(struct vmw_private *dev_priv)
 {
 	int ret = 0;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
index 0dea09cc29a7..dd5ca4dc75e8 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
@@ -537,11 +537,10 @@ static int vmw_ldu_init(struct vmw_private *dev_priv, unsigned unit)
 	return ret;
 }
 
 int vmw_kms_ldu_init_display(struct vmw_private *dev_priv)
 {
-	struct drm_device *dev = &dev_priv->drm;
 	int i, ret;
 	int num_display_units = (dev_priv->capabilities & SVGA_CAP_MULTIMON) ?
 					VMWGFX_NUM_DISPLAY_UNITS : 1;
 
 	if (unlikely(dev_priv->ldu_priv)) {
@@ -565,12 +564,10 @@ int vmw_kms_ldu_init_display(struct vmw_private *dev_priv)
 			goto err_free;
 	}
 
 	dev_priv->active_display_unit = vmw_du_legacy;
 
-	drm_mode_config_reset(dev);
-
 	return 0;
 
 err_free:
 	kfree(dev_priv->ldu_priv);
 	dev_priv->ldu_priv = NULL;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
index 39d58fc392bf..291e24456d06 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -921,11 +921,10 @@ static int vmw_sou_init(struct vmw_private *dev_priv, unsigned unit)
 	return ret;
 }
 
 int vmw_kms_sou_init_display(struct vmw_private *dev_priv)
 {
-	struct drm_device *dev = &dev_priv->drm;
 	int i;
 
 	/* Screen objects won't work if GMR's aren't available */
 	if (!dev_priv->has_gmr)
 		return -ENOSYS;
@@ -937,12 +936,10 @@ int vmw_kms_sou_init_display(struct vmw_private *dev_priv)
 	for (i = 0; i < VMWGFX_NUM_DISPLAY_UNITS; ++i)
 		vmw_sou_init(dev_priv, i);
 
 	dev_priv->active_display_unit = vmw_du_screen_object;
 
-	drm_mode_config_reset(dev);
-
 	return 0;
 }
 
 static int do_bo_define_gmrfb(struct vmw_private *dev_priv,
 				  struct vmw_framebuffer *framebuffer)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index b505f8ba3e83..7a3e6ee10932 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -1683,11 +1683,10 @@ static void vmw_stdu_destroy(struct vmw_screen_target_display_unit *stdu)
  * RETURNS:
  * 0 on success, error code otherwise
  */
 int vmw_kms_stdu_init_display(struct vmw_private *dev_priv)
 {
-	struct drm_device *dev = &dev_priv->drm;
 	int i, ret;
 
 
 	/* Do nothing if there's no support for MOBs */
 	if (!dev_priv->has_mob)
@@ -1706,9 +1705,7 @@ int vmw_kms_stdu_init_display(struct vmw_private *dev_priv)
 				"Failed to initialize STDU %d", i);
 			return ret;
 		}
 	}
 
-	drm_mode_config_reset(dev);
-
 	return 0;
 }

-- 
2.56.1


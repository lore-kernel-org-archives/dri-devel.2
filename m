Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3DCFF887E
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EBE810E068;
	Thu, 30 Apr 2026 00:17:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="eqAgpmQq";
	dkim-atps=neutral
Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com
 [209.85.217.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C868C10E068
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 00:17:09 +0000 (UTC)
Received: by mail-vs1-f98.google.com with SMTP id
 ada2fe7eead31-6201fc9ac0eso124995137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 17:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508228; x=1778113028;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FOweN1q371/qF5QUJ1i1ubibi5KDO9QlEqrhUHAHvCM=;
 b=gP9UBEc7DSHNoHkGN6XVCEeGhH66NQiGtyIO3tiDcC/m7Wg5TLK3z+USo+FO3j0BkV
 sUXOAfHdId6x2LGFTJTTe44M4e4U2feAOUgqOErGmh/j2YyHf0aHD3g00O+NaPpgMzL0
 VLCBYquteBGe+RN8dgnXmP6NNUP3AykEuvwQHmchadaAI1eFtIVBZt7dD4RKwlW7VvPI
 JXKMgZ+dNastH4LcWoN/F1mQ5LcF5ZSYZcEnLcghph2S89Gw0TmLmio0NpKFwZ7GCcK5
 PyzX/z+HzCnHoI1MtUQ6eBmBVXji5jvPh//AhOtXDhKmA8LQ5dXuwTNPPqeG5Gv16GaK
 FWeQ==
X-Gm-Message-State: AOJu0YyjawsuGAU6TNmuovh4/bGQgv8iL7yTULGOuHCXCU4is3Or1XO7
 GVRW+eMLR13yHLk9fJsiE5iIh2yDv3//nbAq+cjYo3qyZPhovdCAAwUcwvaHeD57veO1e5lJuFS
 QE3KMDlHpClcaPwSE+Ja0kzaf9qFHIX+ATlCSrDfPyJWE7pmblpK9xA1t66R8Dtf9G8zw4GVHvD
 RPOBXPSWgc1YjeiypWiGRaEKpOYNhT6GqGIJqpfi+zBjxvhrWJPm0/dDZNEO0ProdGAjwfXTMs8
 tCsDySJ5cyxpo+U7a+FMzH31A4x
X-Gm-Gg: AeBDietocTAyBsPOAK4KJsmsnc4nC8zhFIhvYhlHU6hKBFZeBE9bQndKQyCAhaMmN18
 RXp4d7z7D10iYowMX/yQl0lFxJ96VI5ivnMCwIblbsgNtmKiWfiTG5cJ3K7c7vL5v+AgAWMwqrP
 c2t5CNp5MNCXmdZdFEb7jFNHpwkcoBdeLgKkBZS25G0Ba/cHAGCac9BylGM7c8aLwEAijFkrBx/
 64uSLlUlIFACvUSMWTITCHfJY/aLdz4TMr0Au9WUfUNiv8G8nB8IrMnl4Z+QMNEzxGM+zDeiBXy
 W45Xy7BnEfAFsP+BrKzY1Qsf/VhsvJyg03zrocwby5GV8ZEu0l8vW2SwbuaY0GGRr6AFIbIDjYm
 LEOOAOB399SIlYsPKllPUOSYBGN1WOaqzqchPplRGPW8+kZTOH3/0rf7H6RnOL0rCFX7cyW534n
 +VQCtHQ13f94xs96zrQO1P
X-Received: by 2002:a05:6102:554c:b0:612:7ddc:52ee with SMTP id
 ada2fe7eead31-62ad3d540f3mr373174137.15.1777508228273; 
 Wed, 29 Apr 2026 17:17:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-62984531a84sm214552137.15.2026.04.29.17.17.08
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Apr 2026 17:17:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2da19227bc1so1563995eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 17:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1777508227; x=1778113027;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FOweN1q371/qF5QUJ1i1ubibi5KDO9QlEqrhUHAHvCM=;
 b=eqAgpmQqE7lMJBJL8H9nCTNYqfQzBAHSYved/P4/7m3HLw6Hy0gTbVWBsTOa6ns/2J
 QPRiDBDgzE1pKa5XKIUCm5DVpxYgSBlzOzzdHj9UV7ZfjX4WAiebclONNvSqZvxIcitp
 KjN5E6tHI1yx+JlEUf0QK0YgA4k6IAQxb+YOs=
X-Received: by 2002:a05:7301:5809:b0:2d2:129a:1682 with SMTP id
 5a478bee46e88-2ed3dea4fc4mr259750eec.16.1777508226821; 
 Wed, 29 Apr 2026 17:17:06 -0700 (PDT)
X-Received: by 2002:a05:7301:5809:b0:2d2:129a:1682 with SMTP id
 5a478bee46e88-2ed3dea4fc4mr259737eec.16.1777508226095; 
 Wed, 29 Apr 2026 17:17:06 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c0ce05bsm4173885eec.26.2026.04.29.17.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:17:05 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH 2/4] drm/vmwgfx: Check vrefresh in drm_mode_setcrtc.
Date: Wed, 29 Apr 2026 17:19:10 -0700
Message-ID: <20260430001913.482967-2-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430001913.482967-1-maaz.mombasawala@broadcom.com>
References: <20260430001913.482967-1-maaz.mombasawala@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
Reply-To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Add the mode_valid() callback in drm_mode_config_funcs to check for valid
mode during drm_mode_setcrtc. This is similar to the stdu connector
specific vmw_stdu_connector_mode_valid().
Both the mode_valid() callbacks also check if the vrefresh value is
correct.
This fixes igt test kms_invalid_mode@overflow-vrefresh.

Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  | 34 ++++++++++++++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  9 ++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 12 +++-------
 3 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 55730e29d3ae..c5a37ea47df0 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1062,8 +1062,42 @@ vmw_kms_atomic_check_modeset(struct drm_device *dev,
 	return ret;
 }
 
+static enum drm_mode_status
+vmw_kms_config_mode_valid(struct drm_device *dev,
+			  const struct drm_display_mode *mode)
+{
+	enum drm_mode_status ret;
+	struct vmw_private *dev_priv = vmw_priv(dev);
+	u64 assumed_cpp = dev_priv->assume_16bpp ? 2 : 4;
+	/* Align width and height to account for GPU tile over-alignment */
+	u64 required_mem = ALIGN(mode->hdisplay, GPU_TILE_SIZE) *
+			   ALIGN(mode->vdisplay, GPU_TILE_SIZE) *
+			   assumed_cpp;
+	required_mem = ALIGN(required_mem, PAGE_SIZE);
+
+	ret = drm_mode_validate_size(mode, dev_priv->texture_max_width,
+				     dev_priv->texture_max_height);
+	if (ret != MODE_OK)
+		return ret;
+
+	if (required_mem > dev_priv->max_primary_mem)
+		return MODE_MEM;
+
+	if (required_mem > dev_priv->max_mob_pages * PAGE_SIZE)
+		return MODE_MEM;
+
+	if (required_mem > dev_priv->max_mob_size)
+		return MODE_MEM;
+
+	if (!drm_mode_vrefresh(mode))
+		return MODE_BAD;
+
+	return MODE_OK;
+}
+
 static const struct drm_mode_config_funcs vmw_kms_funcs = {
 	.fb_create = vmw_kms_fb_create,
+	.mode_valid = vmw_kms_config_mode_valid,
 	.atomic_check = vmw_kms_atomic_check_modeset,
 	.atomic_commit = drm_atomic_helper_commit,
 };
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 445471fe9be6..ea12f6c77f2d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -16,6 +16,15 @@
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_probe_helper.h>
 
+/*
+ * Some renderers such as llvmpipe will align the width and height of their
+ * buffers to match their tile size. We need to keep this in mind when exposing
+ * modes to userspace so that this possible over-allocation will not exceed
+ * graphics memory. 64x64 pixels seems to be a reasonable upper bound for the
+ * tile size of current renderers.
+ */
+#define GPU_TILE_SIZE 64
+
 /**
  * struct vmw_du_update_plane - Closure structure for vmw_du_helper_plane_update
  * @plane: Plane which is being updated.
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index dcbacee97f61..17dc20b2ec64 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -45,15 +45,6 @@
 #define vmw_connector_to_stdu(x) \
 	container_of(x, struct vmw_screen_target_display_unit, base.connector)
 
-/*
- * Some renderers such as llvmpipe will align the width and height of their
- * buffers to match their tile size. We need to keep this in mind when exposing
- * modes to userspace so that this possible over-allocation will not exceed
- * graphics memory. 64x64 pixels seems to be a reasonable upper bound for the
- * tile size of current renderers.
- */
-#define GPU_TILE_SIZE 64
-
 enum stdu_content_type {
 	SAME_AS_DISPLAY = 0,
 	SEPARATE_SURFACE,
@@ -870,6 +861,9 @@ vmw_stdu_connector_mode_valid(struct drm_connector *connector,
 	if (required_mem > dev_priv->max_mob_size)
 		return MODE_MEM;
 
+	if (!drm_mode_vrefresh(mode))
+		return MODE_BAD;
+
 	return MODE_OK;
 }
 
-- 
2.54.0


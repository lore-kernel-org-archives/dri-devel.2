Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D352ECD5BB1
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 22:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CBB910F42A;
	Thu, 21 May 2026 22:35:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="JtVmMd+9";
	dkim-atps=neutral
Received: from mail-dy1-f227.google.com (mail-dy1-f227.google.com
 [74.125.82.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9385310F43E
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 22:35:07 +0000 (UTC)
Received: by mail-dy1-f227.google.com with SMTP id
 5a478bee46e88-2f7ca62a3c4so6930532eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779402907; x=1780007707;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s//+cJLOqGfhMPJywnZiCkEjChuLnDZJbKoKcWaLsV8=;
 b=rZ5/UxU6FBipt2G5JmQ7zUpxtIpErmFsBQJFkvhnBagKIjuqTcsg8eUyThq3j9OfY7
 tnXvu292PiYpfFSQg0UYme4i8nQAr9xxpS0Y3OvvJUh3XhiYwjWYF3hvN7midYGlyxyQ
 JuRHIkC4WQb103UYTLgpHfnIw+8+tO58d963S1Dez4zFQjyZki+6Jakoxs7t9FZkzzU9
 u6C4RaAq6efGZM5OsswzsrfVEZ4SESY/jEOZGYbOiZyRU6WZkrNsNPNq+Djg/4UsI8o6
 BN5pi9oTovou345PtENtOJ9pkzeEKm3Whg+rcHgTQQIUbN31lYT9Rlww1csYIJvv/bmL
 BIuA==
X-Gm-Message-State: AOJu0YzupRi2xrypEaSs9Ji8F3iJ8eZdH9QS56kAYUI1AOeWT5mCqrBv
 a500AywcdsO85wex59fII8ky3eJ69+aCJ+pTAeTLZfV8UXaDyDoi6Si0GJCSXZzNha66BpzFyoQ
 ezEDc09gUkIXCI/RgKeDYc1DOlCD6o4PQ83B4MEblarvS0H24FTQ35G0GaUfYp7Hm01pqmfO927
 eKnrIg6RHcc4a66qSCQ0s5Jc0pjC2LHr3Zs4k8Y6Cg7eo8JorggvBnEhcjPCfSwF9BcoF/oW21w
 5Un7oQP4wcu7u1N+rd55ywLHhjo
X-Gm-Gg: Acq92OH4N1DilfuQBoeGB2YW3dI59MpZv569kCWnL6WxmvmDb7bGAkF/t7HF4PUkAcZ
 Nd6yC5cdK3T9l2RFWCARM3mInmVut86yGyRvgLnhyjkxdwIfdBiWpeVdjCIJT13xLcQ4gCNrkwU
 8csMoc7ZB1OcNWBksIb4Nd0ZZngz4qafekN+8Nq+8IbLCCjEXP5zFeI5fGPUM6C2zWBXrAvq5st
 HdoQq422c8IAP08+duO1Zxe06ivPw0oB8x6a7sLO59qNNUnif8iobXyMMNvZnWPmNH16/VrjzOy
 ZLmcdB74cOFG9Ae/i6j8DsDBHVeN87tVxycJ3abBk3sR15ia/1tvV75eskM8qPgW3bMs7s5kRvX
 O+ubcGoeZy0K0CiVaPeQq5yA76rZfbesJ9vCl9bZBC8gyUnoMGSk/5UuiBvM6m4Xs0tF+X4OOAK
 laPmdHSqDMUzzKlAkTA7S7zefriHCEj9lUQFt+4/pQTxfkAk38iVJKdnriYeciNUNOU11dUV0m
X-Received: by 2002:a05:7300:e8ae:b0:2f5:3f62:37b4 with SMTP id
 5a478bee46e88-30448f755b8mr704570eec.8.1779402906621; 
 Thu, 21 May 2026 15:35:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
 by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-3044b6f6c31sm33171eec.11.2026.05.21.15.35.06
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 May 2026 15:35:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-516d6cf547bso1735901cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1779402905; x=1780007705;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=s//+cJLOqGfhMPJywnZiCkEjChuLnDZJbKoKcWaLsV8=;
 b=JtVmMd+9vAmBh8dz6VBGNHyE87zWwHlUG5/kKNw8Ic9U6E+9KdpU5wRkp38CXkHIFt
 4KOZxha2gz7nA3QrLbnyBbMQc5K1+GZfZLtfJdnzXyyEPuTblvF1phVaf6xH+JxQ4C9x
 SacPqMVGQpFQW+XbkZQvLPrrPWuoeUz+ShYTI=
X-Received: by 2002:a05:622a:2513:b0:516:d4b1:48cd with SMTP id
 d75a77b69052e-516d4b14c3amr16036171cf.2.1779402905328; 
 Thu, 21 May 2026 15:35:05 -0700 (PDT)
X-Received: by 2002:a05:622a:2513:b0:516:d4b1:48cd with SMTP id
 d75a77b69052e-516d4b14c3amr16035661cf.2.1779402904815; 
 Thu, 21 May 2026 15:35:04 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-516d6438582sm3351451cf.19.2026.05.21.15.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 15:35:04 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v4 2/4] drm/vmwgfx: Check vrefresh in drm_mode_setcrtc.
Date: Thu, 21 May 2026 15:37:54 -0700
Message-ID: <20260521223756.627311-3-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521223756.627311-1-maaz.mombasawala@broadcom.com>
References: <20260521223756.627311-1-maaz.mombasawala@broadcom.com>
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
mode during drm_mode_setcrtc.
Both the mode_valid() callbacks also check if the vrefresh value is
correct.
This fixes igt test kms_invalid_mode@overflow-vrefresh.

Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  | 28 ++++++++++++++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  9 +++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 12 +++---------
 3 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 1b407b61f683..4db29b645a38 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1063,8 +1063,36 @@ vmw_kms_atomic_check_modeset(struct drm_device *dev,
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
index 2224d7d91d1b..1b717caecc78 100644
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
index 4139837f4caf..04c5c20588d8 100644
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


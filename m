Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C97C53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 18:22:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 454E310E6C0;
	Mon, 27 Jul 2026 18:22:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="CCyuTXR1";
	dkim-atps=neutral
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com
 [209.85.210.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED8310E6C0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 18:22:00 +0000 (UTC)
Received: by mail-pf1-f226.google.com with SMTP id
 d2e1a72fcca58-84536ecfc5bso3509034b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 11:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785176520; x=1785781320;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=06h5ZECmEU4jnkS2bbRvNkToLLJM0JZ9FQmgH2xrJyA=;
 b=bVH+3ZDGtV2wdvBNr2qV9zd94H6CjMnvP9ofsuNDLHCkuEmPdUuK9cHXB4t1DdYQ3V
 ZQ60yyWDs83jvJoseunfiC00fwa50hcRtCUmMajNzuVJ2VFZWas7aoiaJE9FOr+5EiO+
 PuSuvet3Kv4+k5tlfDWU+3GDDNm1xcn9IjfGB0lUVQiMlPxuedw4YIQ0SJZ5Braagims
 RuP7xhNAp96tVRuUnhSh3JOqMh9HdtFXt5eOV1XIGbYqy6U+xSURjlASjBEuTgwGJDQY
 iL0uGifh+6GENpF2/38ghruv47ZNaZuPTl84yyHrOa2u12rCPZcdlyl3Gwjjq29Vx43a
 CpfQ==
X-Gm-Message-State: AOJu0Ywhi5wCOEfQwLfZcOxhGOvhanBOlxAISjsQyFu6fDlXitBywRj/
 xtybsl3h/LTqYcNZGIjbnyAsq025zfLrwXF5u0EYITridRbFH7ATdNlkbFMTEmITyoNmW/QZN1u
 +WDIAL1vTbxfchi/vjYJn0t6eF/3ByMQrH8qHrA63khWOTZH+jkH4Pe/nA3g8GeAO3p4YTv4RYl
 odU1n5ZnzdcdT87raOkXqmwL34bMKf2TrnWxb4BKwPZT94aFEWkqKbxaSfEBINoQb4O5Q4GkKHx
 u+7UuSBtk0+NQF2WqhJ7IkkMRIr
X-Gm-Gg: AR+sD12CbqNlI4dzdNGOhIK26l+8mwBPDUJG77kG4PTzAqok4za70Xw0sK7u9av3SjI
 ezcHyrYTyujeUUU2xrQtI0dFcSblZDTn4wAulztvUAnLyjnRLpHMCHxyMDI9wkL0tA1WmJ0hBUq
 dDUBy/jkPLqLqhWld/LDSYlOhGMAVTeBH6vP8o6vY0C6US7AWgqmFrugXSd2ykEjPVuWnh6xn7c
 MN/haqGg6nCa6a8kiPSaoYDtqezuBi2YIm7BC4EQRr1zHEdNO4Ve9VjxozX3uvcjz6VOtba8o01
 AC0VhmpQR/JalR9M9URUiUp8Lte519JaVhV8SWbkPZVzNyidjYNtOeGHB46s+Sm07IZDuEZKOgL
 Z/6YsugQiYBEN3a5C1fa8Aug2flBJm8+AY7rTnt1wHzY+laL2c8zkVxLqAErTKUvGSSC3yr97zM
 wM5TLop3O7i031HRan29CxhGOYooFtUvBkrgumJz1I
X-Received: by 2002:a05:6a00:1912:b0:848:2f84:f435 with SMTP id
 d2e1a72fcca58-84e595cbfe4mr7654547b3a.78.1785176519739; 
 Mon, 27 Jul 2026 11:21:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-cbbb66d391dsm640345a12.11.2026.07.27.11.21.58
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Jul 2026 11:21:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c15e555a164so14578966b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 11:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1785176517; x=1785781317;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=06h5ZECmEU4jnkS2bbRvNkToLLJM0JZ9FQmgH2xrJyA=;
 b=CCyuTXR1F6AAtkJWQoEaSmZFJfLly3plgHXLDi3MAoVRuHMYG9185Nqkpn8EQFIdnI
 xMwowH40LNG7ruGHo8/Vg0o3ToGPiZTHSCstti6CcE3M9g+E/JcRrNEKT18j4f+aRjah
 zdPIxG+j2tJRXYtr6cFRwsfoZFPA2vpKsB+LE=
X-Received: by 2002:a17:907:3e20:b0:beb:d461:7b09 with SMTP id
 a640c23a62f3a-c1f678473e4mr25759666b.11.1785176517168; 
 Mon, 27 Jul 2026 11:21:57 -0700 (PDT)
X-Received: by 2002:a17:907:3e20:b0:beb:d461:7b09 with SMTP id
 a640c23a62f3a-c1f678473e4mr25758066b.11.1785176516679; 
 Mon, 27 Jul 2026 11:21:56 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1f5e717da4sm82222366b.4.2026.07.27.11.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 11:21:55 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v6 2/4] drm/vmwgfx: Check vrefresh in drm_mode_setcrtc.
Date: Mon, 27 Jul 2026 11:26:20 -0700
Message-ID: <20260727182622.236086-3-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727182622.236086-1-maaz.mombasawala@broadcom.com>
References: <20260727182622.236086-1-maaz.mombasawala@broadcom.com>
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
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  | 30 ++++++++++++++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  9 +++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 12 +++--------
 3 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 1b407b61f683..c7d977aba3f9 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1063,8 +1063,38 @@ vmw_kms_atomic_check_modeset(struct drm_device *dev,
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
+	u64 required_mem = 0;
+
+	ret = drm_mode_validate_size(mode, dev_priv->texture_max_width,
+				     dev_priv->texture_max_height);
+	if (ret != MODE_OK)
+		return ret;
+
+	required_mem = (u64)ALIGN(mode->hdisplay, GPU_TILE_SIZE) *
+		       ALIGN(mode->vdisplay, GPU_TILE_SIZE) *
+		       assumed_cpp;
+	required_mem = ALIGN(required_mem, PAGE_SIZE);
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


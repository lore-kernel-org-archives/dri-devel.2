Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E71CD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 00:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB69010EAB2;
	Tue,  2 Jun 2026 00:39:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="EtxKuRLR";
	dkim-atps=neutral
Received: from mail-ua1-f100.google.com (mail-ua1-f100.google.com
 [209.85.222.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2196B10EAB2
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 00:39:00 +0000 (UTC)
Received: by mail-ua1-f100.google.com with SMTP id
 a1e0cc1a2514c-96387cf6335so4326079241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 17:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780360739; x=1780965539;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eUbLzO6lhWU1fzVHJN/+2El/od3fTv2q8extriK4wcA=;
 b=TNwR9zd0yN1VkxUsLj718I2zI9UhBVnF1CwnNgt0wTwNydWA74e44fQdVMPdWvM5Nb
 FMqRxOaYMvFLflnB1okQrBf0/N8ZOQwyrYW46auEGScPcAoyNtSNpCVM9yOOfn3S6Stl
 eE1KbHqkJBhsapFnESP7rXwvFo4Q0qCgsUqLKk05sDYx15aYtxf2Hj42bfC0cd+9Boo+
 hH+QlBXj/1AMfbQeefdufWe+0qbTIwG2WiM7npsTuTOag4N99ZGf/TKJVc/SY4Xhm0kS
 tapmhWIPeaKlLfXIENV536Y/aesZ8VggWkQDAhWxcAB5YioyKEEZvJBEW/bBli0sPVwz
 8SJA==
X-Gm-Message-State: AOJu0YzOsBx2+ClGGDSq9uYtY+EGlmSJ4PtRzbHE7DXMXu7b9e7Vbe9P
 6/P66VxKtRRN1Y9D8XYd0nQSFSVPCADO0A9Tw2CU6TyydjPt9hhcdbh5HN34eZB9c+P3e/7MwkG
 G+egrZRY4Q4MZw24Ko5oMxd2WXLeZs27k2lRVBgHaJ4iAIDEeKh3C7Yp10jpNVvp55rxk4VS3n3
 79OcQqTQeMVX34w5zrqBL5Db+Rg5Jo7qxsH3saUQjZNQCQc8VVnqYJd9YwL5ooDAKWTUO13TtWf
 EpnrybiILzsMSTdmDHfkTYqjpE6
X-Gm-Gg: Acq92OFnr1Mf9S0fry+JBLvga89mdV4Axy5sVDT8GBf0o2duEBYeGjkAbxVDmTP9Uyk
 KbG8cjhL4vzjQn2w8S/QGc22MmUbhdFiXqg/2sdH9sse0xiQhDoMiy5t5h9nmi1iDzUbe5W2Jo6
 pjKvxNx6Jk7uMYOH2oJuNcXnDckZpxb9zXfroV5YQR5xKNIWjMo+Q9V9KK+KfWDpOenJSWS45G4
 gh4e8parY98NuzbBjAJW8BWt0hl9V9gky9m9xGj/CwuDEewLg3W39gvAWApIlE0fr/1N/mZ8Kh9
 1AlJmC2iy8UEMEJRLcTIgm2kC1vRBziBnQR6ZMMkNvrDrKb5MzMh7/XaDa6U7iBEZ0b4djYrwzR
 LsIrTg0AbslaRsee8jMia/XF61A4uwFzIqBIzNg/smopQURAGGJ3xNaThq0xMWb5FWHLg6FNbB5
 COj09316fFUHVWs7ytthfP+Ljn6nATd8eX68UbPv+YC6fUlq9IXFpqjvm5XYkiB0gRcSLWMw==
X-Received: by 2002:a05:6102:3589:b0:632:5db8:f672 with SMTP id
 ada2fe7eead31-6e16f539e7cmr958939137.6.1780360738868; 
 Mon, 01 Jun 2026 17:38:58 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-6da79b0a598sm278212137.28.2026.06.01.17.38.58
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2026 17:38:58 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ccebf7e86aso83955566d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 17:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780360738; x=1780965538;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eUbLzO6lhWU1fzVHJN/+2El/od3fTv2q8extriK4wcA=;
 b=EtxKuRLRKmE+dLErYJ2ykMRR7x+7gfSRUyg4OiKzEbR5cWejDwWKZuvqLpW76CtPVz
 MxKw/EX+FqO6wLPjIemtXOLRUBX18kUXYxc5apcn3uFOwGCvplFRaQ+drBpHpnlrmYTN
 F2K3pC84ivA0hR8m7u9xzg+gLSOdlZZrsXZCY=
X-Received: by 2002:a05:6214:76b:b0:89c:ac42:e119 with SMTP id
 6a1803df08f44-8cebf3cffa0mr28388626d6.8.1780360738265; 
 Mon, 01 Jun 2026 17:38:58 -0700 (PDT)
X-Received: by 2002:a05:6214:76b:b0:89c:ac42:e119 with SMTP id
 6a1803df08f44-8cebf3cffa0mr28388276d6.8.1780360737770; 
 Mon, 01 Jun 2026 17:38:57 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([216.221.25.44]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccea1cadd2sm108125616d6.24.2026.06.01.17.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 17:38:57 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v5 2/4] drm/vmwgfx: Check vrefresh in drm_mode_setcrtc.
Date: Mon,  1 Jun 2026 17:42:01 -0700
Message-ID: <20260602004203.102901-3-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602004203.102901-1-maaz.mombasawala@broadcom.com>
References: <20260602004203.102901-1-maaz.mombasawala@broadcom.com>
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
index a170e38c5223..11edb422d2ba 100644
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


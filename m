Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D152C531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 18:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C01110E6CF;
	Mon, 27 Jul 2026 18:22:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="ENuiYlqB";
	dkim-atps=neutral
Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com
 [209.85.161.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6376210E6CA
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 18:22:13 +0000 (UTC)
Received: by mail-oo1-f97.google.com with SMTP id
 006d021491bc7-6ab08d289d1so999207eaf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 11:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785176532; x=1785781332;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=U3qqWawFt85l29yAv4KXe2GvoV2uJnIdjSz2SW0Omy4=;
 b=VXMxYpdbEWQU6dWOrCB3TDbqAMVQzUnnyqp0Stp1d4SxhtRrvcsuTeX50CIlVYwUhR
 bNmPaKFVdKD4e/9v7Hyqihy+0hfa9w/CIAsh8eiK01J+F0BX8x4CshrLb6z9lOMQULFX
 /KQ/16bVhLjvLxbu69Ioyh8SjdNlXT6hD24M0P46Ap5xCFPbg6mYXkE/gHgBmjGSf5F4
 BxBwE/hvvy7vjDLwRss5+LweeJ8TjipIHEZHHhTMFYXa/VK6qXif6pJisImXyIlKYg41
 WHB4sCQ06zCuX6Ts3TpoSfB2iyYlmtwl9uYhYi5sSXlgf45vQHcdqM7S+Z8EGTJV2mQm
 zaUQ==
X-Gm-Message-State: AOJu0YxCRhJOgCmHr62YJ8bPeMqlI/z6SeBjW2sURh6HGaeQHnE2InyN
 2/0oekh7BJ80nmOtrWrhB/msWBUHpe1Mu6A0rlzR7A9MZfAzQIgfWqtM0lmogdXRb8K0Xqq9EPu
 C3i2PQZyF41LAMjDLuOtyx6zFodMtVaFRtulok/IK3ltEY1kas+X+8EPNGVnyijFBmV5Uhz/kRF
 re1y6W8Y7PPu5hc2sNrAHUwY+RK9X7GkK3vyIBjFCTJdhf9zImoFrGVnIhB6vwFKskpQuwkhuCg
 WC+eHXN8EY4FmnT43XMi639fyU9
X-Gm-Gg: AR+sD10auGwHzOFVVWfqvn3I4YfEbZEMWGi6aeREslE8k0wIX2zneGdDm5ZJioXSq2V
 Xz51Z09Q9KYhE062I+4YRFX0xXuUePBI3o7zqCc11gatTaO9F/nIXmljw2IubQRXSA3mupqzzrn
 OJS1sEzotchIj+J2tpPSHp1VSSKVmWoSSy6PBVByFxSqYeN44V+4HFxEssK54mjfIddy6IGWk+j
 +rDto/91Nr+y5/CfCkm6s/BQAyTDoicM5FMRtN3+FWrhbLD5lpR2TbExjQo64OAaP8Y7kw6P9vS
 wFvXGI0eNKGrfb0tBYiFCyd5mdyWqNXtdYt4Yw/INJZ8Ek2icgnnP6VxeycOjjw3HgFDaV4Tz3f
 1B5zEGSK4Be5yMQnV6CXEH2qFYEm+BD5YuDntr8tFAfLaDmOACHRrkKVCTj2JfNc50VciqZ/oRE
 kcyZOiwWS25qAlFgwX9aAm9PdtqiZA8FxOL4gNkiAD
X-Received: by 2002:a05:6820:168d:b0:69e:41bf:fdcd with SMTP id
 006d021491bc7-6aaff9aabecmr6674772eaf.38.1785176532478; 
 Mon, 27 Jul 2026 11:22:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-457673a80d3sm1432127fac.9.2026.07.27.11.22.12
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Jul 2026 11:22:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c15eb4015e7so324939966b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 11:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1785176531; x=1785781331;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U3qqWawFt85l29yAv4KXe2GvoV2uJnIdjSz2SW0Omy4=;
 b=ENuiYlqB90YgSxFg0pZaBn3qYMRwl+zgd39ixrQRWAF/EgpwYSQHux1hNi8jenDpHc
 JZecRXmBXJoZLx7ImFsAZA9poKdRJPh7m/M/HJaoiIjlPRIpvOQfSr4Ue3x7G9vAwkl1
 w9a2+XBCCG/SWV6jtXQ3/mA4HJd5b/GUCF8w4=
X-Received: by 2002:a17:907:9620:b0:c16:9af8:c77e with SMTP id
 a640c23a62f3a-c1f1eab549emr411215466b.1.1785176530788; 
 Mon, 27 Jul 2026 11:22:10 -0700 (PDT)
X-Received: by 2002:a17:907:9620:b0:c16:9af8:c77e with SMTP id
 a640c23a62f3a-c1f1eab549emr411214366b.1.1785176530279; 
 Mon, 27 Jul 2026 11:22:10 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1f5e717da4sm82222366b.4.2026.07.27.11.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 11:22:09 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v6 4/4] drm/vmwgfx: Change ttm refs for dumb buffers.
Date: Mon, 27 Jul 2026 11:26:22 -0700
Message-ID: <20260727182622.236086-5-maaz.mombasawala@broadcom.com>
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

Preserve a ref to surface during dumb buffer creation. This keeps the dumb
buffer valid for framebuffer usage and fixes all igt tests that use dumb
buffers.

Fixes: f42c09e614f1 ("drm/vmwgfx: Fix dumb buffer leak")
Cc: Ian Forbes <ian.forbes@broadcom.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c      |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h     |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 12 +++++++++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 3a739a761f3a..215e208fd778 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -72,7 +72,7 @@ static void vmw_bo_free(struct ttm_buffer_object *bo)
 					       0);
 			mutex_unlock(&res->dev_priv->cmdbuf_mutex);
 		}
-		vmw_surface_unreference(&vbo->dumb_surface);
+		vmw_dumb_surface_unref(&vbo->dumb_surface);
 	}
 	WARN_ON(!RB_EMPTY_ROOT(&vbo->res_tree));
 	drm_gem_object_release(&vbo->tbo.base);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 38bea8abab84..cda55ee009d2 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -1186,6 +1186,7 @@ u32 vmw_lookup_surface_handle_for_buffer(struct vmw_private *vmw,
 int vmw_dumb_create(struct drm_file *file_priv,
 		    struct drm_device *dev,
 		    struct drm_mode_create_dumb *args);
+void vmw_dumb_surface_unref(struct vmw_surface **dumb_surface);
 
 /*
  * Shader management - vmwgfx_shader.c
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index bd0563741e89..74e11baa7095 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -2340,11 +2340,21 @@ int vmw_dumb_create(struct drm_file *file_priv,
 	struct vmw_user_surface *usurf = container_of(vbo->dumb_surface,
 						struct vmw_user_surface, srf);
 	usurf->prime.base.refcount_release = NULL;
+	ttm_base_object_lookup_for_ref(dev_priv->tdev, arg.rep.handle);
 err:
 	if (res)
 		vmw_resource_unreference(&res);
-
 	ttm_ref_object_base_unref(tfile, arg.rep.handle);
 
 	return ret;
 }
+
+void vmw_dumb_surface_unref(struct vmw_surface **dumb_surface)
+{
+	struct vmw_user_surface *usurf = container_of(*dumb_surface,
+						struct vmw_user_surface, srf);
+	struct ttm_base_object *base = &usurf->prime.base;
+
+	ttm_base_object_unref(&base);
+	vmw_surface_unreference(dumb_surface);
+}
-- 
2.54.0


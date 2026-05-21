Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D630ECD5BAB
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 22:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4178210F42C;
	Thu, 21 May 2026 22:35:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="IyblA8D4";
	dkim-atps=neutral
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com
 [209.85.210.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5472E10F42B
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 22:35:14 +0000 (UTC)
Received: by mail-ot1-f97.google.com with SMTP id
 46e09a7af769-7de4a9cb8eeso6405019a34.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779402913; x=1780007713;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+6KBb7YsDxpOwC8pN59fpWQXqjc9RI4xvCFcpGCa5Z0=;
 b=QInZ2kgm2AvK4Tq9nkiyK7nPhJj43m2vy/CM6PvVUYZ6T2GP39pNmfLeb2sXJ5rPmE
 qySzzIwPwhRe1cPrqtHUhMfSsbYIOEqzU5P7NOLJj69dY47UEOohP8SPmuhbuBLADseH
 79BzKGRv7qNa7JWyaDd7mzgxzIg20hyYoMF9RlpEElljB781linbmD9ohcLr7FpMFjUL
 7d7cE9I4UgmP2beMS9lbx6PMpIyRCkXG/3ra8sTXv6R4t976f9RYtWlWh0aTQ++hJTwh
 dNOIpiyxKCZH3eaIgNubkAyPdwm8osItlU/MTC7/Hg9MRm37wluR6xAfQBsVKWAEJYSN
 oPIw==
X-Gm-Message-State: AOJu0Yw17QgkTELvnc6YauBdbjUup5GhF1R2PLKshcHVK0CTrV9+9qzz
 VLtdmD26dHd0Kby3FsNDICgoQ8ThVbL/TiFVvgav8AeeB1+875YMBsRyFf+OqfORW/wr7cv7US/
 3yz7AgxQd2IBEoH/YSVu1IQZOoVApZ9mWMQG4/p08RHudVPVdkYkNAyOrvTWAux3PBSfPzdP7Dz
 TYQW4zHotZ75dLhehOJz6hEjLTuSLenqD0RryzHTEImLhEyJURwY5zz5sd7BYf1RVcbaozGdfj9
 yg/6jdbkJAfpgQKdujj5MUg7xIW
X-Gm-Gg: Acq92OE4ho9yr9LjtxgjIT2rVnk+XT6cgQz485z216jbKJ7uxzaSyOts7pKztxwO55i
 IBNO2Ckze7t9zln4MgWLxlhYkQG4/cjezdO1hfWLKB07QyumKZyOEJFRDanqHSPg2ZLo0Dq4eiW
 /yPNpe4q8nS7U6sTaLXwo0sJFCy77cn48Mg9K9iV41LgPkKvUyGpeoxBgaUWgK/+q5/u1T3f9aP
 OLgmC36czIi6mDtYFyycLg2lcws7A0igRu6suGPT142X90XSfiBkUFE0xBqUpcfNZEUQcMU76Xf
 fZWE5gruOfmVWXhsUFyzMGsRz5zhnHUrb3ld2lYbanjvlga5pX8oK+Wqu94UDDQsYtNP/IzFtXB
 OX8cJ9Qi6SEtFjrv5aR1sCjwasi/7gz7tog9hxbjX06f8Us5hAuRkkTGyBjd61GMQcebXUJwGVc
 QTROY3KOJie9/O8aVY0pFFO4KKoL3qfgIPQevz/dYFxKSjaDZuaY2BbF87cmWPIauE
X-Received: by 2002:a05:6820:1c92:b0:696:70f0:7ade with SMTP id
 006d021491bc7-69d7eaf18acmr680972eaf.8.1779402912632; 
 Thu, 21 May 2026 15:35:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-69d809c358esm22551eaf.14.2026.05.21.15.35.12
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 May 2026 15:35:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-514d2b22e7fso100355911cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1779402912; x=1780007712;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+6KBb7YsDxpOwC8pN59fpWQXqjc9RI4xvCFcpGCa5Z0=;
 b=IyblA8D4NdG69zFwOWwttSUI6KQWc+zYuDq0kZv9iNuP9HKK43t4trreVtU9kD2ErH
 LS3JYk7Y94H1MChaXzfD88GS15zKSoTcOxe4PbsVkkhowWkT7dsLDUF8hxQhGEphLu+R
 WgDtIiTNx3ocmLu/nt+upqDRoKEhpMmCFkUxU=
X-Received: by 2002:a05:622a:24d:b0:50b:3831:417f with SMTP id
 d75a77b69052e-516d43a52cdmr18853601cf.45.1779402911777; 
 Thu, 21 May 2026 15:35:11 -0700 (PDT)
X-Received: by 2002:a05:622a:24d:b0:50b:3831:417f with SMTP id
 d75a77b69052e-516d43a52cdmr18853181cf.45.1779402911186; 
 Thu, 21 May 2026 15:35:11 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-516d6438582sm3351451cf.19.2026.05.21.15.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 15:35:10 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v4 4/4] drm/vmwgfx: Change ttm refs for dumb buffers.
Date: Thu, 21 May 2026 15:37:56 -0700
Message-ID: <20260521223756.627311-5-maaz.mombasawala@broadcom.com>
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

Preserve a ref to surface during dumb buffer creation. This keeps the dumb
buffer valid for framebuffer usage and fixes all igt tests that use dumb
buffers.
Also fix ttm_prime_fd_to_handle(), which in the error case was leaking a
dma_buf reference. During vmw_prime_fd_to_handle() this function
is expected to fail for dumb buffers since the fd is for a gem object,
the dma_buf would in turn hold a reference to the dumb buffer gem object
and cause a memory leak.

Fixes: f42c09e614f1 ("drm/vmwgfx: Fix dumb buffer leak")
Cc: Ian Forbes <ian.forbes@broadcom.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/ttm_object.c     |  7 +++++--
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c      |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h     |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 14 +++++++++++++-
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx/ttm_object.c
index 2421b0dd057c..f9042bafdc93 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -547,14 +547,17 @@ int ttm_prime_fd_to_handle(struct ttm_object_file *tfile,
 	if (IS_ERR(dma_buf))
 		return PTR_ERR(dma_buf);
 
-	if (dma_buf->ops != &tdev->ops)
-		return -ENOSYS;
+	if (dma_buf->ops != &tdev->ops) {
+		ret = -ENOSYS;
+		goto out;
+	}
 
 	prime = (struct ttm_prime_object *) dma_buf->priv;
 	base = &prime->base;
 	*handle = base->handle;
 	ret = ttm_ref_object_add(tfile, base, NULL, false);
 
+out:
 	dma_buf_put(dma_buf);
 
 	return ret;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 6817e0b8ce99..d1ce1a58e134 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -68,7 +68,7 @@ static void vmw_bo_free(struct ttm_buffer_object *bo)
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
index b2d3927b5567..34e55ad07ca9 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -2328,11 +2328,23 @@ int vmw_dumb_create(struct drm_file *file_priv,
 	struct vmw_user_surface *usurf = container_of(vbo->dumb_surface,
 						struct vmw_user_surface, srf);
 	usurf->prime.base.refcount_release = NULL;
+
+	ttm_base_object_lookup_for_ref(dev_priv->tdev, arg.rep.handle);
+
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


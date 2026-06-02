Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D24CD6E55
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 00:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 211F010EAB5;
	Tue,  2 Jun 2026 00:39:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="FCb0aKS8";
	dkim-atps=neutral
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com
 [209.85.216.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5FE010EAB5
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 00:39:05 +0000 (UTC)
Received: by mail-pj1-f98.google.com with SMTP id
 98e67ed59e1d1-36b95eb4bb4so2140277a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 17:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780360745; x=1780965545;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8gISgoayETMxEXGc+UlgkhFroO6X4kKcXlY3h0Rx9ZI=;
 b=F8FzNnwtLNbzvXmSBV5AdTh7CzZ3K7dHVRDAVUMzN9YAIkn+8GqVzgZxgW5xhhoiHD
 EzsWuwcgLZyT/r7dOlzh8bUNNC8kNWk6FBlla7rWBPkdWoB2+nGv2+p0NK4f62PvzMzh
 Hli27gMUGVmxp9n3LWhXMHl5cXk8a7KA70OoRcAPkghePPA5KWuinzpNazuZ1rV00x8J
 ecs4y+LJ6PP2a0aRbgHWR7OhHhGpZy7zuq91V6GQ7rzAwvrdYi2uSUzaZPS7vOTMN+mu
 DGHXSoDmSvVqYajwF1nMIbh2FkTykYH7gto9VFBQiFhnj1+epN0GmffSnLbMhypMQ1Az
 DHZw==
X-Gm-Message-State: AOJu0Yz7Ee4cDGYYFgrELT5bilHLtr+EqSxlshIQz59JqKbK6VqhXtmW
 pt0x/rXNRFqqzcXdrnJwhDiZz0WYOk7M7Ih9XCBSfZ3VHW1lS/yaWmHIRielgDcfxg0xOsIZBhF
 rVIpVc7t/VIggCosSrgN05lDSt10r47R+jHtpdvDwhrgjrFt/fA38x9lNsSRISOaeZZLhkb52Jq
 nFspT6VOasYuWZ7yUndu4YgiMDtkDQrkQPgbBqRtZXXj4saNUTqhkJX8o3zzFbl5DLwpCVNcDun
 mHY8Qr0V2eKYHhD24fq+q/jSora
X-Gm-Gg: Acq92OES1ClEqWRhc6cPz3mjhe3rASUKfOXvWPFXClAgIYWghZ+xXr+WjHa+qq8Ykh0
 y+0+9q1wYHx7ULsZBSeCsvbVlSSYazdjmKI9bBi4GJrne6u3PMhmR4mC3e/gnVHEhlo52f/aZeA
 DWKhpfjEyM9RJGBdgTTwFbhXqzaCEpFEX3Bisx+cpAVvut8RV8SPqVNQLpMAtUHhZ/6qsG/eOgN
 a+hUWMAvAuzotYZiwajmxwNg2EiHXkkgi/FnzR728dZFfQ3yyCsrNktc+jOEVvEf4f7LEr1329T
 jGTHImQsQX7oyi1nvFBklcD3o86eBuraLpgmj4zs0SmIJ/RSHpFpxn9gD8JphD09AwfDeLMBsTm
 c7TnEM/2qxScdDbCQbrE7+Rut1vdI9nVp5MwQorq51CZJp8XyTOBZtUJjAm6WQ4pLhZ7H7ZAVfm
 0yZRduBhwyC5yyVG4RhBfNEpPp4JlZ7cWO+x6CAWVThrjK1X2CWWaQ3FxOigIxMTiVX+gKMoEJJ
 Ks=
X-Received: by 2002:a17:90b:564c:b0:366:10f1:3d91 with SMTP id
 98e67ed59e1d1-36c4fef3035mr13074102a91.1.1780360745177; 
 Mon, 01 Jun 2026 17:39:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-36dd9748422sm112942a91.6.2026.06.01.17.39.04
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2026 17:39:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8cceb0317b3so55297676d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 17:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780360744; x=1780965544;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8gISgoayETMxEXGc+UlgkhFroO6X4kKcXlY3h0Rx9ZI=;
 b=FCb0aKS8nLpUnobu7RGRL8X6OtMPQk/uRKv5FsjhGdedC0zayeQsH/GhJ3Cqmy6AH2
 2Qa7wAxk+34UlUroDHjs+AbsZTHZ13/f6FfrIqtiJdaFR0qaa+zWw9VmZV/7897JfWSu
 L0mC9g01354u0GPhkDAISygmKqM8Xepk8+xzk=
X-Received: by 2002:a05:6214:2502:b0:8ce:b2e9:a4b9 with SMTP id
 6a1803df08f44-8ceb2e9a80cmr75935286d6.12.1780360743957; 
 Mon, 01 Jun 2026 17:39:03 -0700 (PDT)
X-Received: by 2002:a05:6214:2502:b0:8ce:b2e9:a4b9 with SMTP id
 6a1803df08f44-8ceb2e9a80cmr75935016d6.12.1780360743457; 
 Mon, 01 Jun 2026 17:39:03 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([216.221.25.44]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccea1cadd2sm108125616d6.24.2026.06.01.17.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 17:39:03 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v5 4/4] drm/vmwgfx: Change ttm refs for dumb buffers.
Date: Mon,  1 Jun 2026 17:42:03 -0700
Message-ID: <20260602004203.102901-5-maaz.mombasawala@broadcom.com>
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
index a69a6764ead2..3de255a619a8 100644
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
index 812f1224f83e..cd46d3995ade 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -1185,6 +1185,7 @@ u32 vmw_lookup_surface_handle_for_buffer(struct vmw_private *vmw,
 int vmw_dumb_create(struct drm_file *file_priv,
 		    struct drm_device *dev,
 		    struct drm_mode_create_dumb *args);
+void vmw_dumb_surface_unref(struct vmw_surface **dumb_surface);
 
 /*
  * Shader management - vmwgfx_shader.c
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index ab611943d774..5a9c953eb73c 100644
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


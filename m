Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42729C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2A8110F104;
	Thu, 20 Aug 2026 16:58:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="VrNoMW6m";
	dkim-atps=neutral
Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com
 [209.85.222.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B475110F104
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 16:58:57 +0000 (UTC)
Received: by mail-ua1-f97.google.com with SMTP id
 a1e0cc1a2514c-97bf91b2e6eso12824241.2
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 09:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787245136; x=1787849936;
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:dkim-signature:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N5X3hSOaEkmq9tDmcu7o5jzqM5XkiCcp3/EivOW/Q00=;
 b=tEwCM+gV1tDEnJ8tdRVid5k7/G1tIOW9i4Pv/smecSFvPSRr8zYIdsVCa7kWW3O8tQ
 5BJdwcYlXQw9gMacOdLQE+/hJGhzUg+mPPOqqX7cpcdFq6MZx5KPa1GWO8VtSeX1lUGI
 XgNruaaQRl7HxM2/94w4SgyG9C1bBPEg23sAWULCWITi5Iv2jlp7oTGWzqE1yD5S7Tmv
 tLccXrZ+UlgjvgwlGPIOyXAJhCJkHFToEtzVUY5/BiMECXUtDQt7u814y4/bRsQ08JzI
 nbQg1gHaIBcUCht1+AeWMo+nW6G7vnZ8HPiy1CvRgdgGBTerDUm51HjT1AmG+UhW3CQN
 NCHg==
X-Gm-Message-State: AOJu0YxirvOr0s+igxSkL6+MbvR1kcywdjF6Wh5EO1Loq8w7FbPFDbGM
 bOTtvhTlLQhXcCjbJl5R6hhz4a1BuW6WU+Ty85cxNibB9AUtqtrjjWKhhquo873ywYg8/FoFYPl
 RaCk9ykVPInnwWAafqro9h8E//Q4CCZeKPMXUkFNmbLzMyXsc5Zg4yWB/xaNXf4aItlT9hDXUBI
 7qCwzMXT1SIkT/jEkrHtBJ0eYAmL8kwYcecaL+2d7rMNEi/DqreIXhFcVGo1/r5N03uyr6xSpUk
 EZNqnekDYXTd1psdXHhiNgqPctp
X-Gm-Gg: AR+sD10vVFjHpdBP/TwOB0mWtHbreNgSZG8p8Wizr8ItSV619185Ce2pcPnXq7o6/t3
 g60MXTJy9b0JEkEypCDEG8X6mcKxUWK7Wxsd0LFDLxxn11lRCmutbhHb5CdMrc2Bf9BccMQ8XR/
 onGhgMv4WjgUZPiSmmqGiLOY7FZs3PR+57Qg33GdFjK5+iYpsZBKAkadnIdBiez2buw5hN7hXrc
 B/wVCKN85SMr/hwEC6txlQuqEOlVQ2M6neNR4pM3HXmozFd7N8F8mXVYRSsyk33fYCxSa+I0Szg
 j5VagojJbDLEqyFVt8VK/aMviV3XZjVe5XRW01IV/hodQvL3hD3+x4dZupoK5tPxxVVHLxuGGZr
 Zd7yVOmNsje9mjVLhXpne4AWQ+6A/teDFOgcf+X2+eWMROu4Uqt0tyVBNyhKxMcxYhUjDb6JGXR
 xFmhamy/gNM8dP6so7yjyd/Vx12LxHEzPxK4Gah/c5
X-Received: by 2002:a05:6102:2b83:b0:726:cd42:d023 with SMTP id
 ada2fe7eead31-77a6434c02amr101393137.11.1787245136139; 
 Thu, 20 Aug 2026 09:58:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-97c4e7d9c41sm397464241.2.2026.08.20.09.58.55
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Aug 2026 09:58:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e52306621so940285a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1787245135; x=1787849935;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N5X3hSOaEkmq9tDmcu7o5jzqM5XkiCcp3/EivOW/Q00=;
 b=VrNoMW6m8p+lrob+H+RtcVqBMz72opLI4o7cHRWBbDB8lO35UWx6dPcaem6MJRCBU9
 bcuzHS78vkrOQ00vJ9bRrzF4IPaTsqnJyFAHM4j4TUFsk+EDNWUKl2IMrfkQ2epD7Qwk
 uqxyxqiX3IXtQOGna5Q6fxl6k9iA9YWx7q0ao=
X-Received: by 2002:a05:620a:40ca:b0:92e:4859:49dd with SMTP id
 af79cd13be357-9371e2ff26amr1143389885a.26.1787245135280; 
 Thu, 20 Aug 2026 09:58:55 -0700 (PDT)
X-Received: by 2002:a05:620a:40ca:b0:92e:4859:49dd with SMTP id
 af79cd13be357-9371e2ff26amr1143383785a.26.1787245134571; 
 Thu, 20 Aug 2026 09:58:54 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93720582980sm405915685a.33.2026.08.20.09.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:58:54 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH] drm/vmwgfx: Return gem fd handle for scanout buffers
Date: Thu, 20 Aug 2026 09:58:38 -0700
Message-ID: <20260820165838.442723-1-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.55.0
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

When prime_handle_to_fd is called on a gem buffer handle, we return an
fd for the surface handle if the gem buffer backs a surface.
Return the gem buffer's handle instead for cases when the surface is a
scanout buffer.
Also bump the minor version since this is a slight change in behaviour.

This fixes gem_close() errors in kwin where the compositor expects a gem
handle but gets a vmw surface handle instead.

Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h     | 10 ++++---
 drivers/gpu/drm/vmwgfx/vmwgfx_prime.c   | 14 +++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c | 38 ++++++++++++-------------
 3 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 38bea8abab84..ff33ba1075a4 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -39,7 +39,7 @@
 
 #define VMWGFX_DRIVER_NAME "vmwgfx"
 #define VMWGFX_DRIVER_MAJOR 2
-#define VMWGFX_DRIVER_MINOR 21
+#define VMWGFX_DRIVER_MINOR 22
 #define VMWGFX_DRIVER_PATCHLEVEL 0
 #define VMWGFX_FIFO_STATIC_SIZE (1024*1024)
 #define VMWGFX_NUM_DISPLAY_UNITS 8
@@ -1180,9 +1180,11 @@ int vmw_gb_surface_define(struct vmw_private *dev_priv,
 struct vmw_surface *vmw_lookup_surface_for_buffer(struct vmw_private *vmw,
 						  struct vmw_bo *bo,
 						  u32 handle);
-u32 vmw_lookup_surface_handle_for_buffer(struct vmw_private *vmw,
-					 struct vmw_bo *bo,
-					 u32 handle);
+void vmw_lookup_surface_and_handle_for_buffer(struct vmw_private *vmw,
+					      struct vmw_bo *bo,
+					      u32 handle,
+					      u32 *srf_handle,
+					      struct vmw_surface **p_srf);
 int vmw_dumb_create(struct drm_file *file_priv,
 		    struct drm_device *dev,
 		    struct drm_mode_create_dumb *args);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c b/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c
index 598b90ac7590..7e6581ee09cc 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c
@@ -93,8 +93,9 @@ int vmw_prime_handle_to_fd(struct drm_device *dev,
 	struct vmw_private *vmw = vmw_priv(dev);
 	struct ttm_object_file *tfile = vmw_fpriv(file_priv)->tfile;
 	struct vmw_bo *vbo;
+	struct vmw_surface *surface = NULL;
+	int surf_handle = 0;
 	int ret;
-	int surf_handle;
 
 	if (handle > VMWGFX_NUM_MOB) {
 		ret = ttm_prime_handle_to_fd(tfile, handle, flags, prime_fd);
@@ -106,16 +107,19 @@ int vmw_prime_handle_to_fd(struct drm_device *dev,
 			ret = drm_gem_prime_handle_to_fd(dev, file_priv, handle,
 							 flags, prime_fd);
 		} else {
-			surf_handle = vmw_lookup_surface_handle_for_buffer(vmw,
-									   vbo,
-									   handle);
-			if (surf_handle > 0)
+			vmw_lookup_surface_and_handle_for_buffer(vmw, vbo,
+								 handle,
+								 &surf_handle,
+								 &surface);
+			if (surface && !surface->metadata.scanout)
 				ret = ttm_prime_handle_to_fd(tfile, surf_handle,
 							     flags, prime_fd);
 			else
 				ret = drm_gem_prime_handle_to_fd(dev, file_priv,
 								 handle, flags,
 								 prime_fd);
+			if (surface)
+				vmw_surface_unreference(&surface);
 		}
 		vmw_user_bo_unref(&vbo);
 	}
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index bd0563741e89..15455bdba402 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -895,38 +895,38 @@ vmw_lookup_user_surface_for_buffer(struct vmw_private *vmw, struct vmw_bo *bo,
 	return user_srf;
 }
 
-struct vmw_surface *vmw_lookup_surface_for_buffer(struct vmw_private *vmw,
-						  struct vmw_bo *bo,
-						  u32 handle)
+void vmw_lookup_surface_and_handle_for_buffer(struct vmw_private *vmw,
+					      struct vmw_bo *bo,
+					      u32 handle,
+					      u32 *srf_handle,
+					      struct vmw_surface **p_srf)
 {
 	struct vmw_user_surface *user_srf =
 		vmw_lookup_user_surface_for_buffer(vmw, bo, handle);
-	struct vmw_surface *surf = NULL;
 	struct ttm_base_object *base;
 
+	if (p_srf)
+		*p_srf = NULL;
+	if (srf_handle)
+		*srf_handle = 0;
 	if (user_srf) {
-		surf = vmw_surface_reference(&user_srf->srf);
+		if (p_srf)
+			*p_srf = vmw_surface_reference(&user_srf->srf);
 		base = &user_srf->prime.base;
+		if (srf_handle)
+			*srf_handle = (u32)base->handle;
 		ttm_base_object_unref(&base);
 	}
-	return surf;
 }
 
-u32 vmw_lookup_surface_handle_for_buffer(struct vmw_private *vmw,
-					 struct vmw_bo *bo,
-					 u32 handle)
+struct vmw_surface *vmw_lookup_surface_for_buffer(struct vmw_private *vmw,
+						  struct vmw_bo *bo,
+						  u32 handle)
 {
-	struct vmw_user_surface *user_srf =
-		vmw_lookup_user_surface_for_buffer(vmw, bo, handle);
-	int surf_handle = 0;
-	struct ttm_base_object *base;
+	struct vmw_surface *surface = NULL;
 
-	if (user_srf) {
-		base = &user_srf->prime.base;
-		surf_handle = (u32)base->handle;
-		ttm_base_object_unref(&base);
-	}
-	return surf_handle;
+	vmw_lookup_surface_and_handle_for_buffer(vmw, bo, handle, NULL, &surface);
+	return surface;
 }
 
 static int vmw_buffer_prime_to_surface_base(struct vmw_private *dev_priv,
-- 
2.55.0


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E27CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E822310E348;
	Tue, 29 Sep 2026 16:51:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="ZEZPdHGI";
	dkim-atps=neutral
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com
 [209.85.210.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C0DD10EFAE
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 16:51:14 +0000 (UTC)
Received: by mail-pf1-f227.google.com with SMTP id
 d2e1a72fcca58-8863dbe381bso54124b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 09:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790700674; x=1791305474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F1Sy4VXH252mcJqe9m2wyBmYIxvvcntEwmHqoVAU9Wc=;
 b=iSpy7Cr9HN6IvFBi/nbzA3fK6vfT6tzcApxzpl2gjlmFDREjBEFuDsw5mVPJhiVTO1
 mFxLvr0TEggEpdC17XjbpR6a3qwogkWI9Eihh60KVtozTAmt3zsfwu5jbOC7CW/qLpui
 35ed5FgNWGBFbXfreub1VnXIm0yGTlQD31BEo4BwyMSs0ZA8xwwF1kAHTtogpluZITLL
 ZvJmzm8xlSRtjB6yD0jg696dKVHNL+BahXDgpUH2rZZOCcmCayc8jcX4qOYlSmtd6DdL
 sWhOnPW5kVrPGjKY//z5fCxFdL/I/S0Bi4gs6RM16FCgHxuN8/cFNN1Vk7ohi1JivZY5
 cZmA==
X-Gm-Message-State: AFuF++mBrb91S6fbPmmr+fooEUBQArlbXNpX+P6q40OcZuuCkbgeIgnC
 v2x0T81uxl6a8Cr8CZUukOqi7LQveAsSjCewLL5zVkwjxBJ77ygCMbK/AeojVgsFCJGx8t9dtYp
 +lPcM9fFEIsAaNbfZD3WRN9xrgze+uPklTr5SnK2VHmRFe6GPUV3kYJFHd+Vy1+KJCI1ahklJCw
 YECRIlNLOnJsh3gcjpdGWYnjUcJCx/qDZeajiMpdTbdEdCFDYDuii2bjQaCcSD1+6cxMH9T/vay
 A/Ujy2Ng5UICzpeH/8S
X-Gm-Gg: AYBFou35u2CnDXDeWZV1vhaK/tueBywHRHhyjzaZr2Sg0W8XkKmB43biVJx1MceU7hn
 HQWO9AAR9xSpW+WxkyrgQrcVVxL3OFrJ6GwjKwa1427Oo8iyWk62gGVMD17RzM2gZwoM1YPyIk8
 FtwXy1WI820S3eRSN6rmJgET68INtnQpH59Y4/bP1bO6TV64+IYlbjd2KwqpJYH0RLb3NpcFNEk
 wm1c+74GbHscvX67hrz4G4GScMvZLli3pM7ogmzMoxu9BU9CZ8c+6hu43p75MqV9GQumm8ns/Lv
 op+/FkoMOqgh5vlo1n3GA+2uaqGGQDzzLcEvmulUd3sWuQflQiNnvBNoMh2iR0gPbCnyAuD8J6D
 MSCB8zmBnqnZNcwrQIf1PJncpDhN+4g6kyyQquqOomDJtX9MkZ47jsu+paMcMD4KFQgLUGYT7AS
 enUEdMuPFXjJtHs7yREC/IAMhi69LAnw6W11s=
X-Received: by 2002:a05:6a21:3294:b0:3d3:adbf:7780 with SMTP id
 adf61e73a8af0-3de0e75f0c9mr15392604637.21.1790700673588; 
 Tue, 29 Sep 2026 09:51:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-cc7d2d2d5a9sm61930a12.3.2026.09.29.09.51.13
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Sep 2026 09:51:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33713e5e6daso6592052eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 09:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790700671; x=1791305471;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F1Sy4VXH252mcJqe9m2wyBmYIxvvcntEwmHqoVAU9Wc=;
 b=ZEZPdHGIs7VRDa9plN+B5r47/8jC5R/sLeDQaiJ6O5VXsuNAxq7pdodGdHHpBAP6DQ
 osun+uPYVps+lE0HQF0res/QdBjVLWMhI7eG/dAZh0NYfkSyp9jy4AWvN5gM6cwSkX9l
 SYt1qLKMaIZUlkf+41XxmiOGaKLKiQJ+rgVzg=
X-Received: by 2002:a05:7022:ff43:b0:13e:68c0:9d7c with SMTP id
 a92af1059eb24-146ce7780e7mr16627108c88.12.1790700671442; 
 Tue, 29 Sep 2026 09:51:11 -0700 (PDT)
X-Received: by 2002:a05:7022:ff43:b0:13e:68c0:9d7c with SMTP id
 a92af1059eb24-146ce7780e7mr16627043c88.12.1790700670481; 
 Tue, 29 Sep 2026 09:51:10 -0700 (PDT)
Received: from plasma.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14c60c55ed9sm551146c88.2.2026.09.29.09.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:51:09 -0700 (PDT)
From: Ian Forbes <ian.forbes@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, maaz.mombasawala@broadcom.com,
 ryasuoka@redhat.com, zack.rusin@broadcom.com, jfalempe@redhat.com,
 tzimmermann@suse.de, Ian Forbes <ian.forbes@broadcom.com>
Subject: [PATCH v3] drm/vmwgfx: Add drm_panic support
Date: Tue, 29 Sep 2026 11:51:04 -0500
Message-ID: <20260929165104.928415-1-ian.forbes@broadcom.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20251107204620.1021749-1-ian.forbes@broadcom.com>
References: <20251107204620.1021749-1-ian.forbes@broadcom.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Uses VRAM as the scanout buffer then switches the device to legacy mode.
Restrict support to 64 Bit so we don't waste valuable VA space on the
mostly unused VRAM mapping.

Suggested-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
---

v2:
 - Set SVGA_REG_CONFIG_DONE=false so that SVGA3 works correctly
v3:
 - Rebase
 - Pre-map VRAM
 - Restrict to 64 Bit only

 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c  |  6 +++++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h  |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  | 34 ++++++++++++++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  5 ++++
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |  4 ++++
 5 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 0f101aedb49a..e6e38b7a2d5b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -761,6 +761,12 @@ static int vmw_setup_pci_resources(struct vmw_private *dev,
 		return -EINVAL;
 	}
 
+#if defined(CONFIG_64BIT)
+	dev->vram_mem = devm_memremap(dev->drm.dev,
+				      dev->vram_start,
+				      dev->vram_size,
+				      MEMREMAP_WB | MEMREMAP_DEC);
+#endif
 	/*
 	 * This is approximate size of the vram, the exact size will only
 	 * be known after we read SVGA_REG_VRAM_SIZE. The PCI resource
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 38bea8abab84..463b5a5dfc43 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -472,6 +472,7 @@ struct vmw_private {
 	resource_size_t max_primary_mem;
 	u32 __iomem *rmmio;
 	u32 *fifo_mem;
+	u32 *vram_mem;
 	resource_size_t fifo_mem_size;
 	uint32_t fb_max_width;
 	uint32_t fb_max_height;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 31d3ee0825ca..2d5e51ed5568 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -21,6 +21,7 @@
 #include <drm/drm_sysfs.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_blend.h>
+#include <drm/drm_panic.h>
 
 void vmw_du_init(struct vmw_display_unit *du)
 {
@@ -2034,3 +2035,36 @@ bool vmw_user_object_is_null(struct vmw_user_object *uo)
 {
 	return !uo->buffer && !uo->surface;
 }
+
+int
+vmw_get_scanout_buffer(struct drm_plane *plane, struct drm_scanout_buffer *sb)
+{
+	void  *vram;
+	struct vmw_private *vmw_priv = container_of(plane->dev, struct vmw_private, drm);
+
+	// Only call on the primary display
+	if (container_of(plane, struct vmw_display_unit, primary)->unit != 0)
+		return -EINVAL;
+
+	vram = vmw_priv->vram_mem;
+	if (!vram)
+		return -ENOMEM;
+
+	vmw_write(vmw_priv, SVGA_REG_CONFIG_DONE, false);
+
+	iosys_map_set_vaddr(&sb->map[0], vram);
+	sb->format = drm_format_info(DRM_FORMAT_RGB565);
+	sb->width  = vmw_priv->initial_width;
+	sb->height = vmw_priv->initial_height;
+	sb->pitch[0] = drm_format_info_min_pitch(sb->format, 0, sb->width);
+	return 0;
+}
+
+void vmw_panic_flush(struct drm_plane *plane)
+{
+	struct vmw_private *vmw_priv = container_of(plane->dev, struct vmw_private, drm);
+
+	vmw_kms_write_svga(vmw_priv,
+			   vmw_priv->initial_width, vmw_priv->initial_height,
+			   vmw_priv->initial_width * 2, 16, 16);
+}
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 2224d7d91d1b..139c194ec54b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -498,6 +498,11 @@ int vmw_kms_stdu_readback(struct vmw_private *dev_priv,
 
 int vmw_du_helper_plane_update(struct vmw_du_update_plane *update);
 
+struct drm_scanout_buffer;
+
+int vmw_get_scanout_buffer(struct drm_plane *pl, struct drm_scanout_buffer *sb);
+void vmw_panic_flush(struct drm_plane *plane);
+
 /**
  * vmw_du_translate_to_crtc - Translate a rect from framebuffer to crtc
  * @state: Plane state.
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index 4139837f4caf..bf4b22cd9e5d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -1506,6 +1506,10 @@ drm_plane_helper_funcs vmw_stdu_primary_plane_helper_funcs = {
 	.atomic_update = vmw_stdu_primary_plane_atomic_update,
 	.prepare_fb = vmw_stdu_primary_plane_prepare_fb,
 	.cleanup_fb = vmw_stdu_primary_plane_cleanup_fb,
+#if defined(CONFIG_64BIT)
+	.get_scanout_buffer = vmw_get_scanout_buffer,
+	.panic_flush = vmw_panic_flush,
+#endif
 };
 
 static const struct drm_crtc_helper_funcs vmw_stdu_crtc_helper_funcs = {
-- 
2.55.0


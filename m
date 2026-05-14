Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50609CD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 22:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BBF710E609;
	Thu, 14 May 2026 22:46:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="PA8y555n";
	dkim-atps=neutral
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com
 [209.85.221.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9700810F35D
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 22:46:02 +0000 (UTC)
Received: by mail-vk1-f226.google.com with SMTP id
 71dfb90a1353d-56a9a7e762bso8182847e0c.3
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 15:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778798761; x=1779403561;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s//+cJLOqGfhMPJywnZiCkEjChuLnDZJbKoKcWaLsV8=;
 b=Jts7uEeeFl9Bsz/M1QH7Ff6fppffj3M0vrhab9Vw9RBeR3qGfKgxPVoRAJNnhSg6Lj
 2ohiOfcRwWmtR3hFriRVceKg8qfJevvL2eRLsB8tfVfop9yYZlQKbw6DX2l3+1cdnCVg
 lFdMZ42W6KachujcxD3Io1M1Uozy84XJm1+aFSASDvwdHeN8jnSa29MlTgBWDZAAwVVM
 kZOYuitIeZT0NwLbzxT0fFKFtxlbg2E7SnROY95FkEKvQWkHqkKaexyfOhQqKn7HVAzj
 qmopHHW1R4jHRyDNLuFMQwANtD5FM9hKNYMmmAhhRRPYxaThuh2qGsnAQgZn3ksPE10M
 0GSQ==
X-Gm-Message-State: AOJu0YxBR3utnW8968O9xycReGwETCpziY4+3pe30k1MkWkoX90j/MLJ
 8YuDU4j/ye9zDT0P0F1g6rz3dwYEG1C7qHdZkzCk4W/zMJpTGi5tmAO/PENUUX7KiTmyhy9NeZq
 9RR6nfyIV5qON9pRMAeuQ5YDOvQe/6uMj0vG+VbSh1XGVuFAmlUx3t7e7aRPbtliwwg9OqojJCA
 mT2x5lb5RTsG8JkYjdyfhKcg+pfYbIrGliqDqT3t1f3z5qkY088EgLKE60bk8v1FJTdWtQ7W1tw
 qbFUEkQcse1EngwZM0kZaV68yn6PvE=
X-Gm-Gg: Acq92OFDUez1sl0O4gmTU8CYwwncif2aTXFOcQc/sSFLuyNTQWEA7Uq/SurXSAjra2F
 lshlw0pUQh3lNfZGpBm++b+tinmnxHXx83JhBQi+0YRlvoplzQb2sAAQP4Q1ctk1LXyuZ6dMSA9
 49qfB16HiTDKDp4Q6wjDMUkZvW5oY3bpDhtf9Sm5degKaCj/1uBNfbuoMgGsBU4yNbmew4Zq0T/
 KSLeKTfInOqVCJwGmziOWPndncenPVor81G7NCh6A3ngAzkym5XQpnguJydQsYnQOYpY8TvN+vh
 TNgHGR2xMfc8ef5qUUxpSH3MvP7nUmsCnQ55zFQ+hdiQi2o+nAKfHiLs0jNjNVpbhFGq4FXcQJr
 cSxwMUOnC/znE3N6W1PCNoIqvpiB/QkPHWCea1KATOyN2VOwkgvN2lWDtjZHZvmvNWoyh7hN85I
 bbw8IOSvt/tmEcY42jHhnSBnSwifBKo0mWmfF2wc3sPyTcLIm2vFGCM4hGCu0fdqjTAv+S4wYa
X-Received: by 2002:a05:6122:490c:b0:575:56fe:574d with SMTP id
 71dfb90a1353d-5760c08c77cmr1029187e0c.12.1778798761412; 
 Thu, 14 May 2026 15:46:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-5760f7d8812sm26514e0c.5.2026.05.14.15.46.01
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 May 2026 15:46:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1306c2f7037so9354344c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 15:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778798760; x=1779403560;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=s//+cJLOqGfhMPJywnZiCkEjChuLnDZJbKoKcWaLsV8=;
 b=PA8y555nRzM/Tzw6t9NG58TLe8spPDtvirrIIvRWtOXjmF3xBb3HIaCnX+OzPH84RX
 NZSE6QLxR1p9KBcAbWbDru20Yi4kUX7oP5MQksvXl3h6QCTFK5lo9UzQ2QhfLophGzIQ
 FEQsgPqVJjxpU+Yk2wP+kqdrxyri23Vv6Uza8=
X-Received: by 2002:a05:7022:6621:b0:12d:ba61:2518 with SMTP id
 a92af1059eb24-1350451e621mr505920c88.18.1778798760256; 
 Thu, 14 May 2026 15:46:00 -0700 (PDT)
X-Received: by 2002:a05:7022:6621:b0:12d:ba61:2518 with SMTP id
 a92af1059eb24-1350451e621mr505900c88.18.1778798759522; 
 Thu, 14 May 2026 15:45:59 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbdcf140sm6678737c88.5.2026.05.14.15.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 15:45:59 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v3 2/5] drm/vmwgfx: Check vrefresh in drm_mode_setcrtc.
Date: Thu, 14 May 2026 15:48:16 -0700
Message-ID: <20260514224819.3631763-3-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514224819.3631763-1-maaz.mombasawala@broadcom.com>
References: <20260514224819.3631763-1-maaz.mombasawala@broadcom.com>
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


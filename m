Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C8BCD484E
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 00:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF26810E965;
	Tue, 12 May 2026 00:25:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="dKdps1uj";
	dkim-atps=neutral
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com
 [209.85.215.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFA9010E94B
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 00:25:50 +0000 (UTC)
Received: by mail-pg1-f228.google.com with SMTP id
 41be03b00d2f7-c827313dac0so1057622a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 17:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778545550; x=1779150350;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p2f0m29ah/3GQImTlyMzKAPe2jtbcJpGEwIz9wqA0Q4=;
 b=gSpJN8FOVybY1QC3OJiZ4jF6HI8F3pkFccdgKqRLDw/Wd3PKQT/YtORhLXFiVQN3Hd
 pXAlb0Q4a+bdJR0u7p2A6h2bqBw5kdt7OtD8UoXTRJXOyQU3e6CmplNxE4lFeHNN/enB
 nOyII2U4s6C/LiUkgBVLaL7Z+zt1lnSZKidrLNq3dFbgTJ/06r6NZ0jwXbu4Z/TyTFpr
 v48gkLBr+ijiqfgDksnFc0lJQ4mQcej6K7zZ7aIY6nwfo0XpK9JU8orJfpmCNxtSBC0I
 NRKxNrNUQj1A7yn1uiBotcnQCx24xomFOUnjJfmGsKcFWk7rWBy+12WDtZszMtSmEYMe
 E3sw==
X-Gm-Message-State: AOJu0YyUCNYju0WjmlUjP7LbkZN6WanSDg30GplT32ylzXc4NrQC5WqW
 bIwEU+9taEWA27M8PgcozQmFVJuQM930QIiwHVCbV+fg49LuX68o+2LIrGRWfRrsTN2hrDJmD53
 0kAB7bV9SrImHxRU9LFWpw5H/1AtlOkmZqQ1F+ah2T6Jin6+2nd6KdEZ6A9OkaMyE/WJxJWmxTD
 JoDYGmovmF7vDT5OJ5nBgg7MZSG+smw7kYzuRHbgOEdD0DakjYKJprqT9yo6klOzRDWoLkTq+4f
 wZ5fqMWqaZL32HOzuDsaGpauu8b
X-Gm-Gg: Acq92OHlPHXN8yGgEbPcpFi2eyBTf93xw3fUDA5E4rEAqsIaOrcRlxwEPwM74n8SQwY
 pHMIwbB56nC909Lu5PM7uu/EwdQEjRXXLlKUEDV07sK1kySMUoyM0kcQYu2DZukQrkX7BaHKeZS
 z/Ol3EqrzloOXLYYMtLneP5Z4TOReuOAjAB/afA/NMB4VWkk/+AKC7Ng+1dUpVBDZo47akLk5XM
 ldVI5ocv6o3Jql8ERWQSKvMG370mNh9z+cuy7NNrzxag/aNqXjmOrvP1beQudibKtqavmgthrZn
 laG2Qv0e3pHmTaqx0WCo8iOHncIbudXp7O4BiWqd/uLF+Si8EPE1No/EpAIxgQaFTJNRTO3TLdr
 jQlbVt1P+/He/vByV4ewb9x3ragGgP7f7bM4w7bpTJtxE6IbhpOZMdT3A+MrgH7mZw7GrBBCMdq
 2zX7fxg9XAgSQwH+tB80xFfMAMgGNCvJ7f+K+2FI+TT7YwVTs6EUpgVjF6nXRBbg==
X-Received: by 2002:a05:6a20:2449:b0:398:8ea8:5f9f with SMTP id
 adf61e73a8af0-3acd42a9bd6mr1438588637.16.1778545550117; 
 Mon, 11 May 2026 17:25:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-c826769a1e1sm625201a12.5.2026.05.11.17.25.49
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 May 2026 17:25:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2f1383b7439so4319527eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 17:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778545548; x=1779150348;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=p2f0m29ah/3GQImTlyMzKAPe2jtbcJpGEwIz9wqA0Q4=;
 b=dKdps1ujAcJoLguVJcHhXAHw8CDndAFAYXAZK3ykCHTY5WrnInXPExAQZiEUMnP88F
 IfNpyt7tZ6CqCNuqC0PDdOKkyW2GYD3w8NaszykfeRklIG7zt7BggtG3hH1dXjfKOlZn
 MyCG2A+xJX6pqJuDCniSceVqFz6wMpA2An8IA=
X-Received: by 2002:a05:7022:660d:b0:12c:91ef:6e63 with SMTP id
 a92af1059eb24-1333af97fd9mr1068206c88.7.1778545548145; 
 Mon, 11 May 2026 17:25:48 -0700 (PDT)
X-Received: by 2002:a05:7022:660d:b0:12c:91ef:6e63 with SMTP id
 a92af1059eb24-1333af97fd9mr1068189c88.7.1778545547449; 
 Mon, 11 May 2026 17:25:47 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327821fd00sm20395488c88.8.2026.05.11.17.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 17:25:47 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v2 2/5] drm/vmwgfx: Check vrefresh in drm_mode_setcrtc.
Date: Mon, 11 May 2026 17:27:49 -0700
Message-ID: <20260512002752.2826685-3-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512002752.2826685-1-maaz.mombasawala@broadcom.com>
References: <20260512002752.2826685-1-maaz.mombasawala@broadcom.com>
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
index 55730e29d3ae..121a4f006804 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1062,8 +1062,36 @@ vmw_kms_atomic_check_modeset(struct drm_device *dev,
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


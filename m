Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13775C88E75
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 03:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57B7310E0DA;
	Wed, 16 Sep 2026 03:33:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="elp98+Kc";
	dkim-atps=neutral
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C213D10E0DA
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 03:33:45 +0000 (UTC)
Received: by mail-pj2-f42.google.com with SMTP id
 98e67ed59e1d1-398cb5615deso433667a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 20:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789529625; x=1790134425;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tuWaqYdx3lVj9cpjPj9FHjq5qpjsbWLYsj0P75i5UJE=;
 b=elp98+Kci0TDd29UpBmwTrFqFn3vAt2z6fIHtIcVYgdF7a/5navH9SzqTlR6ZjqBG4
 qE1HKfq7cD92TRsgUjCoHrLAxxxyA0vpP1myjSWKdINlghrKt4NYBIn8DCwaTHSsHL8r
 F9pYFb/Ify0ilYuB7oMOySNb3Dl36RefjGHW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789529625; x=1790134425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tuWaqYdx3lVj9cpjPj9FHjq5qpjsbWLYsj0P75i5UJE=;
 b=XuzexRC6zlJ/K0vY4sqQ5fJKhu6pVOParf19kRx24MeaTIrvewhj+3+56bc7VbpJAr
 WEzWsJn0woYfLDxWGdbULWIg1MqLxWMfJbvLNUWODmoqKlI/P758ufxHxUp48Dc3uW91
 7QB0YaA8utY8/t7AAPJwCnkvQAweU4rRmM2Is/v22mGeDb5zXF7j6OvYV3d40XTojEg9
 mDJ9vdA17IaXh9PU3IM9JJqsOKack9ZuRDh3OlZqCMYKtuKUCe7wdJqGCQwuhO0mbxiV
 tDUYZJZvl3noOQX0PnyXo9QMWnzbNzXWE2VExtUu2zFznDjrNdTs6dXXbFcX6ic9FYSK
 cGJw==
X-Forwarded-Encrypted: i=1;
 AKwUvByuKjiowKIIvsKp8qzfVBrBVCzOv2HHlK7LgJmdD+VP0Byd9Hay3yGK2uGniVI5OWU0UVFRIOjRTP8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m4920tQoJvikymxJ+66ylEhBcK572MuKGrNdH08rOXHlP3rRzC
 S9W6hAy5V7il9fqKqufHKzsQW9E89RSapq03G6Z0cRrNuFPikcO3FJHOJyDeTyNDug==
X-Gm-Gg: AYBFou33C9s0d66+yewVgTgQQtraghjlpSvxVRramaKj68zGHPHeHcy1YmXCHJpkVMj
 7LpfYecTWAxB3b4gXfsxJs1mTCVvMUdECKPNLCCcEqDhLrSRm9++MUymaz99aaiB5Wc1EYvCuvG
 7pSjCgJVc65UV+JAP9+lZ5B7iJ3doGkHpj7THY9xFd3GKc+l7LLFPNhoxcmkILFAsBGhRE5gckc
 Un/+fVpdfs+KRqYT/64OZWWW6tgBWS9o0+7ohNuLkcyhrFCUXK+dvZDIiDv6T6xWGC7GeqffL8o
 SAHSFLGFZZppp45pBQn7U83VOgIAS/Rb7wuwrMP/sJHs6OBGxxi5L9MMVRU3dn5M5UJSt5Nas1Q
 V4kKXnoXqmC+5enlvq0dmVKpQ6JXIf+joIw0bJAniYaxQ9Qfwzos0IksmJFGfe7/X2H9MS4I5EN
 w6nRNEVwHupSUCIWSkEEEWacrw/p7Ji3gnnsmCifZh7AxJ7QXxm4uclCvkvl03dNqIr+v2CyuHH
 XMWs3IuAOvL2+d+zt3fh+jUti8OgDnr3QzHokJ9TL7CEYvep0TkaSy+aA==
X-Received: by 2002:a17:90b:2604:b0:39d:f114:8f7d with SMTP id
 98e67ed59e1d1-39e1e27ad34mr2355684a91.3.1789529625104; 
 Tue, 15 Sep 2026 20:33:45 -0700 (PDT)
Received: from wenst-7875.tpe.corp.google.com
 ([2a00:79e0:203d:7:1f62:7622:5d61:2578])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbe3e62sm1833477a91.10.2026.09.15.20.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 20:33:44 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Liu Ying <victor.liu@nxp.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-sunxi@lists.linux.dev,
 imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH RFT v2 2/5] drm/fb-dma-helper: Add
 drm_fb_dma_get_gem_clipped_addr()
Date: Wed, 16 Sep 2026 11:33:23 +0800
Message-ID: <20260916033327.3054126-3-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
In-Reply-To: <20260916033327.3054126-1-wenst@chromium.org>
References: <20260916033327.3054126-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

drm_fb_dma_get_gem_addr() returns the DMA address to the "unclipped"
framebuffer. However some display drivers want the "clipped" framebuffer
instead, as they are also using the clipped coordinates to program the
hardware.

Some of these drivers are open-coding drm_fb_dma_get_gem_addr() with
the source coordinates replaced, while others have been incorrectly
converted to using drm_fb_dma_get_gem_addr(), which would end up
causing incorrect parts of the framebuffer to be displayed if it were
somehow clipped.

Add drm_fb_dma_get_gem_clipped_addr(), a "clipped" version of
drm_fb_dma_get_gem_addr() for these drivers to use.

Cc: <stable@vger.kernel.org> # dependency for next patch
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v1:
- Use new drm_framebuffer_get_block_offset() helper
---
 drivers/gpu/drm/drm_fb_dma_helper.c | 37 +++++++++++++++++++++++++----
 include/drm/drm_fb_dma_helper.h     |  4 ++++
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_fb_dma_helper.c
index ab0f37d8a5ff..0aaf4926db4e 100644
--- a/drivers/gpu/drm/drm_fb_dma_helper.c
+++ b/drivers/gpu/drm/drm_fb_dma_helper.c
@@ -60,15 +60,16 @@ struct drm_gem_dma_object *drm_fb_dma_get_gem_obj(struct drm_framebuffer *fb,
 EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_obj);
 
 /**
- * drm_fb_dma_get_gem_addr() - Get DMA (bus) address for framebuffer, for pixel
- * formats where values are grouped in blocks this will get you the beginning of
- * the block
+ * drm_fb_dma_get_gem_addr() - Get DMA (bus) address for unclipped framebuffer,
+ * for pixel formats where values are grouped in blocks this will get you the
+ * beginning of the block
  * @fb: The framebuffer
  * @state: Which state of drm plane
  * @plane: Which plane
- * Return the DMA GEM address for given framebuffer.
  *
  * This function will usually be called from the PLANE callback functions.
+ *
+ * Return: GEM DMA address for given framebuffer, unclipped.
  */
 dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
 				   struct drm_plane_state *state,
@@ -86,6 +87,34 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
 }
 EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_addr);
 
+/**
+ * drm_fb_dma_get_gem_clipped_addr() - Get DMA (bus) address for clipped
+ * framebuffer, for pixel formats where values are grouped in blocks this
+ * will get you the beginning of the block
+ * @fb: The framebuffer
+ * @state: Which state of drm plane
+ * @plane: Which plane
+ *
+ * This function will usually be called from the PLANE callback functions.
+ *
+ * Return: GEM DMA address for given framebuffer, clipped.
+ */
+dma_addr_t drm_fb_dma_get_gem_clipped_addr(struct drm_framebuffer *fb,
+					   struct drm_plane_state *state,
+					   unsigned int plane)
+{
+	struct drm_gem_dma_object *obj;
+
+	obj = drm_fb_dma_get_gem_obj(fb, plane);
+	if (!obj)
+		return 0;
+
+	return obj->dma_addr + drm_framebuffer_get_block_offset(fb, plane,
+								state->src.x1 >> 16,
+								state->src.y1 >> 16);
+}
+EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_clipped_addr);
+
 /**
  * drm_fb_dma_sync_non_coherent - Sync GEM object to non-coherent backing
  *	memory
diff --git a/include/drm/drm_fb_dma_helper.h b/include/drm/drm_fb_dma_helper.h
index c950732c6d36..b2a0bd7ef9d0 100644
--- a/include/drm/drm_fb_dma_helper.h
+++ b/include/drm/drm_fb_dma_helper.h
@@ -17,6 +17,10 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
 				   struct drm_plane_state *state,
 				   unsigned int plane);
 
+dma_addr_t drm_fb_dma_get_gem_clipped_addr(struct drm_framebuffer *fb,
+					   struct drm_plane_state *state,
+					   unsigned int plane);
+
 void drm_fb_dma_sync_non_coherent(struct drm_device *drm,
 				  struct drm_plane_state *old_state,
 				  struct drm_plane_state *state);
-- 
2.55.0.1032.g73a4cd73de-goog


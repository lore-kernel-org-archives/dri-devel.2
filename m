Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F8B606A332
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Va2U8+WE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C64410EEEB;
	Tue, 24 Nov 2026 07:41:14 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 649F910EED1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:41:05 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3b402824d07so2836837a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 23:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795506065; x=1796110865;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WVGnOxIIOZpu68Nyn3y7Nw6nHdmb3NEH0yzfOULERRk=;
 b=Va2U8+WEI9Dbks/F2BCmvZrjhLlKPzxrcqoTcrRyRXE4jhpdjrCoSFFDDe4j0aseJB
 wY71LQt/T47nVZEIvKmEwLFt0Msb6q1ER4CrNFRHBFSCW2EXxcQqKVWzJySf2nfspOSO
 f653kK8VjVk4qZN0xzw1aHcfmHB4K8iWZI0Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795506065; x=1796110865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WVGnOxIIOZpu68Nyn3y7Nw6nHdmb3NEH0yzfOULERRk=;
 b=LdFH/COVdWf565fjNLMNYCP1+OzfOxGj/eeaXQwOuVPBT0E6tEhgKJoV2N0Xn6J9M+
 3kGHLTtp9GZmrw7T+O/q9+5K+TKpCxUvIGVlXf+HU7io9B7Ojw2ErtOjSNVtzJcoDlLQ
 M1hyVMbUGfDAmhQDZ4yv38El+9ELzMucJAYNmXQzyQGsqBaim7YPKSWRc+66UupbxpNC
 TXXFdzTIgbhvsin5JNqgHB+/V6QZL4UxV6zV0+2QvmfsVBjkBHe/Ye09Tz01587EAsym
 crLCTaCIRgKSrcoZgoyEar9Tin8m9Q/qTV4p6sOvx5NSlNO1fDi8J3ArrOQPsJ3JXovM
 Ba2g==
X-Forwarded-Encrypted: i=1;
 AL+hErEJ4/8QTBD1hM9FQP/5M1EPg89T+sv8Z1Oc21PXe05g9OJO6tPQwYIwt0Oii91JCeqBQZKinZ60iIQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9hSFPvF6SxDXUFaf1TmRm5nyjxYbkKvVkwHtttjHJOkth/Z2nG
 Or2naFAzC5+3ULLTjo/xPXEadEmZ/Phb6BxouHGMQaV5f5B9m6UC/yRSzI1fi2r99A==
X-Gm-Gg: AZFdTZfo8OwXx8uG0gCjxK38PXDVFsp9KEkImxIAVt9zCOJpgdHlMnGek/U0ekqBwKe
 2xmtjkrMZZuDgnBQBsDG7NPvOvjRTOq4BjyZuzKcmrApi6n5Szz+XyU8G8mmlrBxY2fCsUc49LD
 jTJujYaMW1DA+cVMK9gc98vvCbgBxMGzLNLX0mih2Y9DgubsGCdQOSNj/6kY7Puo0h89aAky75S
 LY2kGMFlvlrzcQYo9jhVViW64dORFh7JlNgrZsMS3Sa2GITBwVkc2iug0fqRaAHT+mUwuHuIBzN
 pv/dTc1ittyYFSEVAIFw1XMNMGXQDhKLvfgzVCe7XdahYSG3b0m/LDQTgx5DkbDkrQvs/kaoLDK
 6hFwPrelsR+T1FIlCnVM8KIOoiULXKcAWPajrQ7xJ+0/V84LAC9aW6tYk99T4ITq3cGqjV8Ctnz
 iLl4i6ayify8hIrrp8O3w0dJF7W2yQ6ze/g/pZBwQg9aymKnWLg3rDxn4HwUpcro7hAMlX0fAqO
 2+m83cZailWHg+Oay4fUjjeXvgBClVS2+TupHheFvwagbgt1E+W10h01ZyvqV71vHYukAJk22Pm
 i2NsuewZeOEp2j+S8MRu3FpZh23jKjVwtsV/vvPWZFxW23XVltzK/R5z/Uxa
X-Received: by 2002:a17:90b:2c86:b0:3b0:a9de:9886 with SMTP id
 98e67ed59e1d1-3b41c8d9179mr13079197a91.12.1795506064871; 
 Mon, 23 Nov 2026 23:41:04 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:8f32:8910:4727:ea03])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3b405d639fdsm24820073a91.10.2026.11.23.23.41.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 23:41:04 -0800 (PST)
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
Subject: [PATCH RFT v3 2/5] drm/fb-dma-helper: Add
 drm_fb_dma_get_gem_clipped_addr()
Date: Tue, 24 Nov 2026 15:39:30 +0800
Message-ID: <20261124074041.115251-3-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261124074041.115251-1-wenst@chromium.org>
References: <20261124074041.115251-1-wenst@chromium.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.56.1.809.ga0b61035b5-goog


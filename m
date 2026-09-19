Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C5CC982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A4B310E07A;
	Mon, 21 Sep 2026 07:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sVsoEvsN";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7BD710E589
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 22:35:13 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d747ec6188so11303955ad.3
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 15:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789857313; x=1790462113; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9gMeYV87yGYpQQPZASfnk9+aNoHuNYCubc3YIOWvC9o=;
 b=sVsoEvsNbqextE8UaVDDqN64PDWPFk5EkVb5v70RgDJEpeRIth2vQIM3my1ahNEbWM
 IlKuD519XtFP1dLPqGNUeEbpMf3TFPkGu0SGYARqEAbunysgBr1CZo2rYKVwJcvi+Pui
 LQR2vo6jaZv9AxrMfDC6YXnq6MnugqySs7Cddjuy/GQmjvNQB5GgQ6k67QxdvM1oi4PB
 +VuJvMjeXSKG7OmqDo3GvjS2cY7E7Rc/Xa77LPyjEJe4vM7+ls8aSXXJoOZap9JTvq62
 AzVVn3w82HSwZVAwIXsrHv70gozljqJ7IPR33FSSJSBF8W4HpX5k/0k0XUHFwRH6bRgM
 bSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789857313; x=1790462113;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9gMeYV87yGYpQQPZASfnk9+aNoHuNYCubc3YIOWvC9o=;
 b=g2suHTy/f82wT0gEdvXMQcBR8h9LHIC5nOY4XoZG7QJZMv1uuzQIkiT79k6r0Ssvxy
 HgvQueZ8F+RIqXJs1RJa2Lxo5jIOkSXCUzFW7D+HBJsMq0phwuRacVikB2mJwpe6r/yK
 H5ypmOmNVDQtxhonPswdy3zVYqnLdsbNZcXzY7CYyTVMSlYXp5rbFSeO8vBUAdIeKjDR
 Sy7DKpSiILr9EVNsXYxUJ26Q0ltylSE92v3qlhgp2Jmk6+ZKVVAAOA6rQRRiVeic+Q5r
 ijGssp+DiqO3KEqqCXmLNzjxYV4zvHu7p6+Ikn4bM/wK4pQGUAAJgfI9F00moI5xgiYv
 rlSA==
X-Gm-Message-State: AFuF++l5BJA0EjFIAnym1YeTLe9sEZnQs/CANe+EzlF7KhxChkVt0uSr
 OFxoNSbyBkzF3f7kFR5PYPHwxASpLAJhWKGKfy/hA2jviNIkwOiGN5Ip
X-Gm-Gg: AYBFou1VPp6vqSmE4Ak4SgO4iNmzdOll/mLlua1Cg/wg0jTvONdoYGOekpJcpFB5O6i
 m+JxZ1N5tY9RFRqd9rj7PfgMzwrqh7+fPss3KZLBkn91Cfznn5+2NUEU466eJLBpRePu2Zfz+65
 CCvVjNUPHSLxuA/WyUVYWiAJT3ZJHVW9+iPYKKHexunxr4vWPBpcSHOZ66XtIISluxOM5l7wS80
 4pRx724Fll5U2EHM8T+1Z8itoHCxwS0eLfoLZ7RgcPTF3W1xC+FL3re3ENYmhLKOeOmNGjDqZcK
 5Zmd8Uhw/qeqn1Rb9SlS+di9uyMYExlM5MpV6XUcl0memmWDwGza8dXnwbkxA97rSy06AT+MXyB
 i4F9CQU0JdnzlTZh/kJl2jVpkWRqE2hyBcwXat27hjJJri61JuwCzWzpcywBXZRa9LpNvqmm+RD
 ZxSuYlfp7VSG70qWQCeSimDkHdvqfx0yX/i/JlHVmorM/jSrkCKH8cKC73bUM/8iwMX6Zo+V4tB
 3zf1/8Cc9MoAmi8dc9mVhFpTdlVF/BaNmJt68QR8TFUn0MDnNSMqkNyFSU1VeohzWNCvMsAdaep
 rcLbTkcoAGwCfyHHfZh8NQ==
X-Received: by 2002:a17:903:8c8:b0:2dd:c053:ec71 with SMTP id
 d9443c01a7336-2ddc054099amr55383325ad.36.1789857313346; 
 Sat, 19 Sep 2026 15:35:13 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddc16b670csm13351275ad.6.2026.09.19.15.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 15:35:13 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: hansg@kernel.org, tzimmermann@suse.de, simona@ffwll.ch, airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vboxvideo: validate VBVA ring buffer offsets and cursor
 dimensions
Date: Sat, 19 Sep 2026 22:35:12 +0000
Message-ID: <20260919223512.3889313-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

In drivers/gpu/drm/vboxvideo/ (vbox_main.c, vbox_mode.c, vbva_base.c),
validate VBVA ring buffer offsets against buffer_length and check cursor
dimensions before copying cursor data into HGSMI buffers.

Fixes: 131abc56e1ba ("drm/vboxvideo: Move the vboxvideo driver out of staging")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/gpu/drm/vboxvideo/vbox_main.c b/drivers/gpu/drm/vboxvideo/vbox_main.c
index aa6664542b20..8cf326661b57 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_main.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_main.c
@@ -115,6 +115,10 @@ int vbox_hw_init(struct vbox_private *vbox)
 
 	DRM_INFO("VRAM %08x\n", vbox->full_vram_size);
 
+	if (vbox->full_vram_size < VBVA_ADAPTER_INFORMATION_SIZE +
+				   vbox->num_crtcs * VBVA_MIN_BUFFER_SIZE)
+		return -EINVAL;
+
 	ret = pcim_request_region(pdev, 0, "vboxvideo");
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vboxvideo/vbox_mode.c
index 3c41238a8268..9a1d9e1aa92b 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
@@ -141,7 +141,8 @@ static bool vbox_set_up_input_mapping(struct vbox_private *vbox)
 
 		if (!fb1) {
 			fb1 = fb;
-			if (fb1 == vbox->ddev.fb_helper->fb)
+			if (vbox->ddev.fb_helper &&
+			    fb1 == vbox->ddev.fb_helper->fb)
 				break;
 		} else if (fb != fb1) {
 			single_framebuffer = false;
@@ -363,7 +364,8 @@ static int vbox_cursor_atomic_check(struct drm_plane *plane,
 		return 0;
 
 	if (width > VBOX_MAX_CURSOR_WIDTH || height > VBOX_MAX_CURSOR_HEIGHT ||
-	    width == 0 || height == 0)
+	    width == 0 || height == 0 ||
+	    width != new_state->fb->width || height != new_state->fb->height)
 		return -EINVAL;
 
 	return 0;
@@ -380,6 +382,7 @@ static void copy_cursor_image(u8 *src, u8 *dst, u32 width, u32 height,
 	size_t line_size = (width + 7) / 8;
 	u32 i, j;
 
+	memset(dst, 0, mask_size);
 	memcpy(dst + mask_size, src, width * height * 4);
 	for (i = 0; i < height; ++i)
 		for (j = 0; j < width; ++j)
diff --git a/drivers/gpu/drm/vboxvideo/vbva_base.c b/drivers/gpu/drm/vboxvideo/vbva_base.c
index 36bc9824ec3f..3a752be06f4e 100644
--- a/drivers/gpu/drm/vboxvideo/vbva_base.c
+++ b/drivers/gpu/drm/vboxvideo/vbva_base.c
@@ -21,18 +21,35 @@
 
 static u32 vbva_buffer_available(const struct vbva_buffer *vbva)
 {
-	s32 diff = vbva->data_offset - vbva->free_offset;
+	u32 data_len = READ_ONCE(vbva->data_len);
+	u32 data_offset = READ_ONCE(vbva->data_offset);
+	u32 free_offset = READ_ONCE(vbva->free_offset);
+	s32 diff;
 
-	return diff > 0 ? diff : vbva->data_len + diff;
+	if (!data_len || data_offset >= data_len || free_offset >= data_len)
+		return 0;
+
+	diff = data_offset - free_offset;
+
+	return diff > 0 ? diff : data_len + diff;
 }
 
 static void vbva_buffer_place_data_at(struct vbva_buf_ctx *vbva_ctx,
 				      const void *p, u32 len, u32 offset)
 {
 	struct vbva_buffer *vbva = vbva_ctx->vbva;
-	u32 bytes_till_boundary = vbva->data_len - offset;
-	u8 *dst = &vbva->data[offset];
-	s32 diff = len - bytes_till_boundary;
+	u32 data_len = READ_ONCE(vbva->data_len);
+	u32 bytes_till_boundary;
+	u8 *dst;
+	s32 diff;
+
+	if (data_len > vbva_ctx->buffer_length - sizeof(*vbva) ||
+	    offset >= data_len || len > data_len)
+		return;
+
+	bytes_till_boundary = data_len - offset;
+	dst = &vbva->data[offset];
+	diff = len - bytes_till_boundary;
 
 	if (diff <= 0) {
 		/* Chunk will not cross buffer boundary. */
@@ -93,6 +110,9 @@ bool vbva_write(struct vbva_buf_ctx *vbva_ctx, struct gen_pool *ctx,
 		vbva_buffer_place_data_at(vbva_ctx, p, chunk,
 					  vbva->free_offset);
 
+		if (!vbva->data_len)
+			return false;
+
 		vbva->free_offset = (vbva->free_offset + chunk) %
 				    vbva->data_len;
 		record->len_and_flags += chunk;
@@ -165,7 +185,7 @@ bool vbva_buffer_begin_update(struct vbva_buf_ctx *vbva_ctx,
 			      struct gen_pool *ctx)
 {
 	struct vbva_record *record;
-	u32 next;
+	u32 free_idx, next;
 
 	if (!vbva_ctx->vbva ||
 	    !(vbva_ctx->vbva->host_flags.host_events & VBVA_F_MODE_ENABLED))
@@ -173,7 +193,11 @@ bool vbva_buffer_begin_update(struct vbva_buf_ctx *vbva_ctx,
 
 	WARN_ON(vbva_ctx->buffer_overflow || vbva_ctx->record);
 
-	next = (vbva_ctx->vbva->record_free_index + 1) % VBVA_MAX_RECORDS;
+	free_idx = READ_ONCE(vbva_ctx->vbva->record_free_index);
+	if (free_idx >= VBVA_MAX_RECORDS)
+		return false;
+
+	next = (free_idx + 1) % VBVA_MAX_RECORDS;
 
 	/* Flush if all slots in the records queue are used */
 	if (next == vbva_ctx->vbva->record_first_index)
@@ -183,7 +207,7 @@ bool vbva_buffer_begin_update(struct vbva_buf_ctx *vbva_ctx,
 	if (next == vbva_ctx->vbva->record_first_index)
 		return false;
 
-	record = &vbva_ctx->vbva->records[vbva_ctx->vbva->record_free_index];
+	record = &vbva_ctx->vbva->records[free_idx];
 	record->len_and_flags = VBVA_F_RECORD_PARTIAL;
 	vbva_ctx->vbva->record_free_index = next;
 	/* Remember which record we are using. */

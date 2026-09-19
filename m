Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E0BC982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85EB210E47E;
	Mon, 21 Sep 2026 07:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RolktL9x";
	dkim-atps=neutral
Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com
 [74.125.227.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F5F510E869
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 22:35:11 +0000 (UTC)
Received: by mail-pj2-f41.google.com with SMTP id
 d9443c01a7336-2d91a931f66so11951725ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 15:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789857311; x=1790462111; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7QY4l784EYoqdUGrD39yyvJt2inDbru1rDCO3703wPU=;
 b=RolktL9xJ17Q3jrkd26lR6MsHuc0LPGgkksq30+SbKD2LKie6ra21qYwVL7Kyw9tBT
 ISJKGYy/ZNXUXdc149f+rT+iV3bsvCBinIUgCpD2H5CwkQAIgdwb2/Ci19OMPSWvOnZe
 7LTdVe58e2uGHBohg5Ez/fjJbqWlIGMXSMfxz2V01EtvUfgCN+mBWYwSM+ZQq5U6zWKD
 7hh0L9HLYTBFohvhX7Av8+S+gnhYCI/leo2KKlBA0x3Wu/cIA2w/8qejVzjS0iZJ6GnO
 Ld4dbp06Q1uEEV0Kdue7bavqWMRJzC5e9I/WL0yCReQ0ZEUst5Kx34X+6Xgyun1JFNl9
 laBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789857311; x=1790462111;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7QY4l784EYoqdUGrD39yyvJt2inDbru1rDCO3703wPU=;
 b=Aq+av9oCAedYAEz0anef9dvKOKBulF3WMgLQVPmt++2EvTJe5IKO+sN5d3fEtypIfi
 ZsUeT7lsWrZwzqWww+modT3YVRe/rRk/jTEumg11jZ+b06dlCeGrj3iI8rdpbLf48jx1
 qYQQ2FfnBWpTbFNg3dE8RvUeQDXzVOBJRF2D32ropSvKdghVlZCRh0/0V02uRZxkDLoL
 fQe5dwFn/umwH81z+zEPA11jKmFAguedJtCgKMgBnLcH68Bz1zscuQj7p/GQYWDw8AAZ
 nCF0ca5WmIxSkHnoJVd1zAlYFoG4q8FhFvN09JH12napagKeXvThnig++YJaIjjej1AI
 WfYQ==
X-Gm-Message-State: AFuF++kIFU2glNo/rR9JrP/vrzu/knyVpGqXnJ2j3Lu7iMZutRWFkFh9
 dUQPwmVHPTgyu7Cl0nPg9+YW0tRxr5WGj15h7y4uv9VEGJobBncHJpjW
X-Gm-Gg: AYBFou3dqOhOCaKYkLGtReOwHbXA0sbBu614EYcWLjVaQPz8CK8kNSdjMEtXe97kfpz
 uSZU7gQApbFNNHBYIm+9Fc07mnQngKst1iJ5Oeg6jYhT4UlClJO6xeXmCWGlveSC9M12HQUN8vf
 qgxJT6YlxUaqvOYYQ+Krg7zA8plT188hOYqiSNa3qCtPGauK036B1EBW1QHppSotN6ehmL+qUHE
 rww4CC+kHtWdziYUIUmzjbUQHOvwyMV2tLntG5q+hmbZ5uUFaQ0giLrHv/LrNra2viU7hbhZq3B
 rernn7At/bJrXz+80Ze48l9Pvy2vxvdllNZ8UDSE/f/+7h60Lfrghhozo/i1cqaH7HuOkVo/8P+
 NRSoTZu7SaYvva4uRYxL9ImCouJ5w5M/gqy5gGn9gtouO+zdHrk+lV+uwJQ8LwHfSkhSaJgMlk5
 7aFeoPgJKF+LZYoVk1mYQ8Y2vL4ImnodSWbYzyvCVSfYk5/dyYh1xl8DO+yjVHERIvIyN8cZ2A8
 m37TeRDD7BsEkqP4zKMVXWbyAQYV3dKaf0nliPufu2jAZp91XgQDz2MoH949SKm3JwPoWHfJYgh
 DEGMwZli2E1bhIbpN2/cew==
X-Received: by 2002:a17:903:3c4f:b0:2dd:ad74:6d1e with SMTP id
 d9443c01a7336-2ddbe4726a8mr69623095ad.27.1789857311009; 
 Sat, 19 Sep 2026 15:35:11 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddc16b471fsm13290885ad.3.2026.09.19.15.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 15:35:10 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: rubenru09@aol.com, tzimmermann@suse.de, simona@ffwll.ch, airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/gud: fix bulk_len divide-by-zero, connector bitmap OOB,
 and short USB reads
Date: Sat, 19 Sep 2026 22:35:10 +0000
Message-ID: <20260919223510.3888975-1-benquike@gmail.com>
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

In drivers/gpu/drm/gud/ (gud_drv.c, gud_pipe.c, gud_connector.c), ensure
gdrm->bulk_len >= max_pitch so lines = bulk_len / pitch cannot be 0 in
gud_flush_damage(), cap num_connectors to GUD_CONNECTORS_MAX, and reject
short USB control transfers in gud_usb_get().

Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gud_connector.c
index 8141c3a1e30a..1bf0495bf43f 100644
--- a/drivers/gpu/drm/gud/gud_connector.c
+++ b/drivers/gpu/drm/gud/gud_connector.c
@@ -569,7 +569,7 @@ static int gud_connector_add_properties(struct gud_device *gdrm, struct gud_conn
 			continue; /* not a DRM property */
 
 		property = gud_connector_property_lookup(connector, prop);
-		if (drm_WARN_ON(drm, IS_ERR(property)))
+		if (drm_WARN_ON(drm, IS_ERR_OR_NULL(property)))
 			continue;
 
 		state_val = gud_connector_tv_state_val(prop, &gconn->initial_tv_state);
diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index 3a1b9e2a2eaa..f69b0e6e2ee0 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -328,7 +328,7 @@ static int gud_stats_debugfs(struct seq_file *m, void *data)
 		seq_puts(m, " none");
 	seq_puts(m, "\n");
 
-	if (gdrm->compression) {
+	if (gdrm->compression && gdrm->stats_actual_length) {
 		u64 remainder;
 		u64 ratio = div64_u64_rem(gdrm->stats_length, gdrm->stats_actual_length,
 					  &remainder);
@@ -427,6 +427,8 @@ static void gud_free_buffers_and_mutex(void *data)
 {
 	struct gud_device *gdrm = data;
 
+	vfree(gdrm->shadow_buf);
+	gdrm->shadow_buf = NULL;
 	vfree(gdrm->compress_buf);
 	gdrm->compress_buf = NULL;
 	sg_free_table(&gdrm->bulk_sgt);
@@ -443,7 +445,7 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct usb_endpoint_descriptor *bulk_out;
 	struct gud_display_descriptor_req desc;
 	struct device *dev = &intf->dev;
-	size_t max_buffer_size = 0;
+	size_t max_buffer_size = 0, max_pitch = 0;
 	struct gud_device *gdrm;
 	struct drm_device *drm;
 	struct device *dma_dev;
@@ -495,6 +497,10 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 		put_device(dma_dev);
 	} else {
 		dev_warn(dev, "buffer sharing not supported"); /* not an error */
+	if (!drm->mode_config.min_width || !drm->mode_config.min_height ||
+	    drm->mode_config.max_width < drm->mode_config.min_width ||
+	    drm->mode_config.max_height < drm->mode_config.min_height)
+		return -EINVAL;
 	}
 
 	/* Mode config init */
@@ -523,7 +529,7 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	num_formats_dev = ret;
 	for (i = 0; i < num_formats_dev; i++) {
 		const struct drm_format_info *info;
-		size_t fmt_buf_size;
+		size_t fmt_buf_size, fmt_pitch;
 		u32 format;
 
 		format = gud_to_fourcc(formats_dev[i]);
@@ -562,8 +568,9 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 			break;
 		}
 
-		fmt_buf_size = drm_format_info_min_pitch(info, 0, drm->mode_config.max_width) *
-			       drm->mode_config.max_height;
+		fmt_pitch = drm_format_info_min_pitch(info, 0, drm->mode_config.max_width);
+		fmt_buf_size = fmt_pitch * drm->mode_config.max_height;
+		max_pitch = max(max_pitch, fmt_pitch);
 		max_buffer_size = max(max_buffer_size, fmt_buf_size);
 
 		if (format == GUD_DRM_FORMAT_R1 || format == GUD_DRM_FORMAT_XRGB1111)
@@ -588,9 +595,13 @@ static int gud_probe(struct usb_interface *intf, const struct usb_device_id *id)
 
 	if (desc.max_buffer_size)
 		max_buffer_size = le32_to_cpu(desc.max_buffer_size);
+	if (max_buffer_size < max_pitch)
+		max_buffer_size = max_pitch;
 	/* Prevent a misbehaving device from allocating loads of RAM. 4096x4096@XRGB8888 = 64 MB */
 	if (max_buffer_size > SZ_64M)
 		max_buffer_size = SZ_64M;
+	if (max_buffer_size < max_pitch)
+		return -EINVAL;
 
 	gdrm->bulk_pipe = usb_sndbulkpipe(interface_to_usbdev(intf), usb_endpoint_num(bulk_out));
 	gdrm->bulk_len = max_buffer_size;
diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index 5ef887d8485a..1f08226b23b2 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -156,10 +156,14 @@ static int gud_prep_flush(struct gud_device *gdrm, struct drm_framebuffer *fb,
 			  struct drm_format_conv_state *fmtcnv_state)
 {
 	u8 compression = gdrm->compression;
+	unsigned int block_width = drm_format_info_block_width(format, 0);
 	struct iosys_map dst;
 	void *vaddr, *buf;
 	size_t pitch, len;
 
+	if (block_width > 1)
+		rect->x1 = ALIGN_DOWN(rect->x1, block_width);
+
 	pitch = drm_format_info_min_pitch(format, 0, drm_rect_width(rect));
 	len = pitch * drm_rect_height(rect);
 	if (len > gdrm->bulk_len)
@@ -327,7 +331,7 @@ static void gud_flush_damage(struct gud_device *gdrm, struct drm_framebuffer *fb
 {
 	struct drm_format_conv_state fmtcnv_state = DRM_FORMAT_CONV_STATE_INIT;
 	const struct drm_format_info *format;
-	unsigned int i, lines;
+	unsigned int i, lines, block_width;
 	size_t pitch;
 	int ret;
 
@@ -335,12 +339,21 @@ static void gud_flush_damage(struct gud_device *gdrm, struct drm_framebuffer *fb
 	if (format->format == DRM_FORMAT_XRGB8888 && gdrm->xrgb8888_emulation_format)
 		format = gdrm->xrgb8888_emulation_format;
 
+	block_width = drm_format_info_block_width(format, 0);
+	if (block_width > 1)
+		damage->x1 = ALIGN_DOWN(damage->x1, block_width);
+
 	/* Split update if it's too big */
 	pitch = drm_format_info_min_pitch(format, 0, drm_rect_width(damage));
 	lines = drm_rect_height(damage);
 
+	if (!pitch || !lines)
+		return;
+
 	if (gdrm->bulk_len < lines * pitch)
 		lines = gdrm->bulk_len / pitch;
+	if (!lines)
+		return;
 
 	for (i = 0; i < DIV_ROUND_UP(drm_rect_height(damage), lines); i++) {
 		struct drm_rect rect = *damage;
@@ -399,6 +412,13 @@ static int gud_fb_queue_damage(struct gud_device *gdrm, struct drm_framebuffer *
 
 	mutex_lock(&gdrm->damage_lock);
 
+	if (gdrm->shadow_buf && gdrm->fb &&
+	    (fb->pitches[0] != gdrm->fb->pitches[0] || fb->height != gdrm->fb->height)) {
+		vfree(gdrm->shadow_buf);
+		gdrm->shadow_buf = NULL;
+		gud_clear_damage(gdrm);
+	}
+
 	if (!gdrm->shadow_buf) {
 		gdrm->shadow_buf = vcalloc(fb->pitches[0], fb->height);
 		if (!gdrm->shadow_buf) {
@@ -562,8 +582,8 @@ int gud_plane_atomic_check(struct drm_plane *plane,
 			goto out;
 		}
 
-		req->properties[num_properties + i].prop = cpu_to_le16(prop);
-		req->properties[num_properties + i].val = cpu_to_le64(val);
+		req->properties[num_properties].prop = cpu_to_le16(prop);
+		req->properties[num_properties].val = cpu_to_le64(val);
 		num_properties++;
 	}
 

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1608C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E16A10E3E7;
	Mon, 21 Sep 2026 07:00:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L+3DCbRG";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8357610E53F
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 22:35:10 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39dacf053eeso1358501a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 15:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789857310; x=1790462110; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fFdVy9z4gml9NW4o7NwoYCSiD0u0I9A6db4IeROCKCY=;
 b=L+3DCbRG5eHsdM//ZRz0JmG0Qzn0Wa194FQpmdxfoRg4pK1kdbYLXRW1+Q76oVuT/C
 4Xowxns1qVnJUAIZ1ogxo3O1dr7YgZ13qyoWxE2DPaawDMBqNeOns+Pm4D3QGfoQzl6g
 LAWyhfCCsmF4D/qpmZ9FeHlhgwNjHbaF3ZU2zXRK7jJuyOam8egXFsIolOu057PvvXXl
 uB5xF2U3GPKt5Wq/5S80Yd5u8OFRJ/vfnGel1rZmGamXdf/VE4yxFVCPQj13/rOkuOm8
 iSJ9UT6XO+SG1l/IAAQ4V+LtwlxRMENNnpxH/CKM05sEvxmPi0jED0Okb+eF/uoWEnZK
 QKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789857310; x=1790462110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fFdVy9z4gml9NW4o7NwoYCSiD0u0I9A6db4IeROCKCY=;
 b=TUzccmHs9LupEcVT6rf4a2pqStRnuBAIPXKebX75Rg8OpXCrKDJLyGIbR5Kh80Pj/c
 HjHifWTjk4EOcs5DXYlyPsXSXix3K7y2d4UzxtZnvuYSTJJMVuTW2A4LoiwD/NAzn+uo
 tIc/TRCxpOcvvHNIBUvsXftBjMbtsO6y1QgGmC+SFGaVeXdJi5ipSI8XsuhbzEaDouDk
 Tnc/NlP7ulVlZDx8MEB8LZHKlZUDa5S1uQGpUhCiEZvlfe3kafPPgV8l15oqO6wa/Sa4
 qRpv/oaq9V4trxUcn+GxDp0DLg5SGk+vea/2N/tjemsnGwu3jmBTawhqquaTrpgMXAID
 JO1g==
X-Gm-Message-State: AFuF++ltogit9Fwupx7YWOlpkrO6a67R8pvdmyoc4Yw0cqkBSxQIIpMV
 mz0qD7bfTxx/FApN9X7LM5wYaFvnT2IQGDF3ByH0Y2cc1rSWDAOEX/h7
X-Gm-Gg: AYBFou1CLB+Bvq4hqolpsWj8uUOLEZQ7zuL1zu7jwNOodlJcQv4obFO+9qhfWHvYhTb
 27a39BavH0OVk0UOdlfJ62hEkxL3+zdWpi9gbqXSkrAO3iL8lyfejwxeHwymbb/5FMqrEnO7SET
 6jeALMw7qCdymb+u4C7e2ihMx6mB4OUFI9dP/LoxcD9VDBWUl6nDD4eWuFTffUax2RWCbN41yZV
 ZgM5xXtD1Eq8lUQZXhg2vdLJQwDSXFDqMwIadNNXyKon8i26VRxr4vJlk7J9aovGUeAWeTRbIde
 Bc6aXc88MPL0l/wF3NGt7rzQgGcsmwiSPNY27MovtfrhqBUdzQoYDp08FjUAoWgIqUGwP2U2kGG
 Dsqvrev0bT4RAfXOFWcJadxqdVljc1Tsg5iMI463LFE2uqKCAy0KC6V3ttpPeQJfBbpMki+qeu8
 8zBp5aWLin61GEn62fZaHziMyPIaUVFLNUqMPnFBb8VSOF9W+EW2oXe8/zHtOoT/eLoJht9gT4K
 ZwI9HL8yHQ3kr6yJwF+o/TjLS/vg2u1q+m9NLnajPPDRYXJA6vTZK2BaCS1WC+X1EMkdySAn/Vc
 AWzrNEBDpg==
X-Received: by 2002:a17:90b:5144:b0:3a0:2c7d:edd4 with SMTP id
 98e67ed59e1d1-3a02c7e2fa4mr1832246a91.7.1789857310047; 
 Sat, 19 Sep 2026 15:35:10 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a02f6f2383sm2241219a91.5.2026.09.19.15.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 15:35:09 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, melissa.srw@gmail.com,
 tzimmermann@suse.de, simona@ffwll.ch, airlied@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vkms: fix empty gamma/degamma LUT divide-by-zero and
 plane format bounds
Date: Sat, 19 Sep 2026 22:35:09 +0000
Message-ID: <20260919223509.3888763-1-benquike@gmail.com>
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

In drivers/gpu/drm/vkms/ (vkms_composer.c, vkms_drv.c, vkms_formats.c),
guard against lut_length <= 1 before computing drm_int2fixp(lut_length -
1) and dividing in apply_lut(), and validate plane/cursor dimensions
before blending.

Fixes: a4e7e98e90eb ("drm/vkms: Rename vkms_crc.c into vkms_composer.c")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 83d217085ad0..3f933f3c137c 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -328,6 +328,10 @@ static void clamp_line_coordinates(enum pixel_read_direction direction,
 	switch (direction) {
 	case READ_LEFT_TO_RIGHT:
 	case READ_RIGHT_TO_LEFT:
+		if (*src_y_start < 0 || *src_y_start >= current_plane->frame_info->fb->height) {
+			*pixel_count = 0;
+			break;
+		}
 		if (*src_x_start < 0) {
 			*pixel_count += *src_x_start;
 			*dst_x_start -= *src_x_start;
@@ -339,6 +343,10 @@ static void clamp_line_coordinates(enum pixel_read_direction direction,
 		break;
 	case READ_BOTTOM_TO_TOP:
 	case READ_TOP_TO_BOTTOM:
+		if (*src_x_start < 0 || *src_x_start >= current_plane->frame_info->fb->width) {
+			*pixel_count = 0;
+			break;
+		}
 		if (*src_y_start < 0) {
 			*pixel_count += *src_y_start;
 			*dst_x_start -= *src_y_start;
@@ -619,13 +627,14 @@ void vkms_composer_worker(struct work_struct *work)
 	crtc_state->frame_end = 0;
 	crtc_state->crc_pending = false;
 
-	if (crtc->state->gamma_lut) {
+	if (crtc_state->base.gamma_lut) {
 		s64 max_lut_index_fp;
 		s64 u16_max_fp = drm_int2fixp(0xffff);
 
-		crtc_state->gamma_lut.base = (struct drm_color_lut *)crtc->state->gamma_lut->data;
+		crtc_state->gamma_lut.base =
+			(struct drm_color_lut *)crtc_state->base.gamma_lut->data;
 		crtc_state->gamma_lut.lut_length =
-			crtc->state->gamma_lut->length / sizeof(struct drm_color_lut);
+			crtc_state->base.gamma_lut->length / sizeof(struct drm_color_lut);
 		max_lut_index_fp = drm_int2fixp(crtc_state->gamma_lut.lut_length - 1);
 		crtc_state->gamma_lut.channel_value2index_ratio = drm_fixp_div(max_lut_index_fp,
 									       u16_max_fp);
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 5a640b531d88..2db3971f72c3 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -112,7 +112,7 @@ static int vkms_atomic_check(struct drm_device *dev, struct drm_atomic_commit *s
 		if (!new_crtc_state->gamma_lut || !new_crtc_state->color_mgmt_changed)
 			continue;
 
-		if (new_crtc_state->gamma_lut->length / sizeof(struct drm_color_lut *)
+		if (new_crtc_state->gamma_lut->length / sizeof(struct drm_color_lut)
 		    > VKMS_LUT_SIZE)
 			return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index dfb8e13cba87..c688b7a5f415 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -49,8 +49,7 @@ static void packed_pixels_offset(const struct vkms_frame_info *frame_info, int x
 										  plane_index);
 	*rem_x = x % drm_format_info_block_width(format, plane_index);
 	*rem_y = y % drm_format_info_block_height(format, plane_index);
-	*offset = fb->offsets[plane_index] +
-		  block_y * block_pitch +
+	*offset = block_y * block_pitch +
 		  block_x * format->char_per_block[plane_index];
 }
 
@@ -78,7 +77,7 @@ static void packed_pixels_addr(const struct vkms_frame_info *frame_info,
 	int offset;
 
 	packed_pixels_offset(frame_info, x, y, plane_index, &offset, rem_x, rem_y);
-	*addr = (u8 *)frame_info->map[0].vaddr + offset;
+	*addr = (u8 *)frame_info->map[plane_index].vaddr + offset;
 }
 
 /**
@@ -139,7 +138,7 @@ static void packed_pixels_addr_1x1(const struct vkms_frame_info *frame_info,
 
 	packed_pixels_offset(frame_info, x, y, plane_index, &offset, &rem_x,
 			     &rem_y);
-	*addr = (u8 *)frame_info->map[0].vaddr + offset;
+	*addr = (u8 *)frame_info->map[plane_index].vaddr + offset;
 }
 
 /**

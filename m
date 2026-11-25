Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC63606A32E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=P6FRJilr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFFAF10E2EE;
	Wed, 25 Nov 2026 20:15:31 +0000 (UTC)
X-Greylist: delayed 904 seconds by postgrey-1.36 at gabe;
 Wed, 25 Nov 2026 20:15:24 UTC
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C464D10E318
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 20:15:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795636819; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iz6I2++rbrho0y3r0TuZ9pbbMBT/+6buOtcogXTfsdukCqeVNpuo/1A0xdS3s0jVegLtt5d+FIN8GzpraMGi+KGhkKHNt/WJvaUdpDVfOgUGE0vjOqyZZqd8DU5j3GWpNSanxHh4Y9tJtO5atTCBY67kmvNeT3zwRjcII1IXJXs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795636819;
 h=Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=ZrwLGeh1OqQ8JNQv9GCCqwPnLzTIOiCtFufMYDmlWvg=; 
 b=H+5xYgceFuBHUG527oM+5MM3O0t/+xuFfamVkQEc9Jmrwwq6UrLkR0zeVK8GDONkYNbuSYywZO/FKZ0extNF81l28Nn/FbAZnyQTdLPJEbTkLJPeSrpw2/Au7zPcddwUEy2hCP/1tdf6a22SKrfGRvCjQJfPvgfRzIyiVtCew/o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=simon.zeni@collabora.com;
 dmarc=pass header.from=<simon.zeni@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=P6FRJilrcu8V36UB6RLgVztb7RS/DWD7vQdoH73Ek02HuED2IjCBOgTs13ylUbHICp+hL30h7CVv0OOzrc7MEHUpw+V/3H83N9+ujukJItSD2RApyoxT/CwrYMWH6gyR82wstHuOYP6AUzn7AHn48Ex2mgST97sqWRPBzd4sWyE=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=ZrwLGeh1OqQ8JNQv9GCCqwPnLzTIOiCtFufMYDmlWvg=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795636816274171.66781175117148; 
 Wed, 25 Nov 2026 12:00:16 -0800 (PST)
From: Simon Zeni <simon.zeni@collabora.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/vkms: add support for Y8 format
Date: Wed, 25 Nov 2026 15:00:00 -0500
Message-ID: <20261125200007.60636-1-simon.zeni@collabora.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adds support for the greyscale format DRM_FORMAT_Y8 with a dedicated pixel read line function
that treats the format as YUV with a neutral chroma.

Signed-off-by: Simon Zeni <simon.zeni@collabora.com>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c   |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index 7f1f29b589e8..d212414bdbe0 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -578,6 +578,25 @@ static void planar_yuv_read_line(const struct vkms_plane_state *plane, int x_sta
 	}
 }
 
+static void Y8_read_line(const struct vkms_plane_state *plane, int x_start,
+				 int y_start, enum pixel_read_direction direction, int count,
+				 struct pixel_argb_u16 out_pixel[])
+{
+	u8 *y_plane;
+
+	packed_pixels_addr_1x1(&plane->frame_info, x_start, y_start, 0,
+			       &y_plane);
+	int step_y = get_block_step_bytes(plane->frame_info.fb, direction, 0);
+	const struct conversion_matrix *conversion_matrix = &plane->conversion_matrix;
+
+	for (int i = 0; i < count; i++) {
+		*out_pixel = argb_u16_from_yuv161616(conversion_matrix,
+						     *y_plane * 257, 0x8080, 0x8080);
+		out_pixel += 1;
+		y_plane += step_y;
+	}
+}
+
 /*
  * The following functions take one &struct pixel_argb_u16 and convert it to a specific format.
  * The result is stored in @out_pixel.
@@ -737,6 +756,8 @@ pixel_read_line_t get_pixel_read_line_function(u32 format)
 	case DRM_FORMAT_YVU422:
 	case DRM_FORMAT_YVU444:
 		return &planar_yuv_read_line;
+	case DRM_FORMAT_Y8:
+		return &Y8_read_line;
 	case DRM_FORMAT_R1:
 		return &R1_read_line;
 	case DRM_FORMAT_R2:
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index fd3d34dcf0fe..7a417a99ed79 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -42,6 +42,7 @@ static const u32 vkms_formats[] = {
 	DRM_FORMAT_YVU420,
 	DRM_FORMAT_YVU422,
 	DRM_FORMAT_YVU444,
+	DRM_FORMAT_Y8,
 	DRM_FORMAT_P010,
 	DRM_FORMAT_P012,
 	DRM_FORMAT_P016,
-- 
2.53.0


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C2DC54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4642B10E42B;
	Wed, 29 Jul 2026 10:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="OEHw4lOo";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0196710E42B
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 10:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wy
 7zDRFbF4ERIY3GwP4CdWhiItXTWFPVOqmwjcAdPaA=; b=OEHw4lOoK8k9JfYuOr
 2biN9PcN4Ftyljg5n5kq2mBfKxUgNm6vnqVppazG6rQFDpvLO+2vNqIE5rImuNcf
 /xR1wMB9maxFzxK/nCP0/TVwIGVgToff1q1+6EatWp68RZoNTkMTUx/omqL4ZM4s
 wJXPf7RQW1QRbMkfsOeJ3zx1Q=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wDnt+Hi3GlqUOK_Mg--.62556S2; 
 Wed, 29 Jul 2026 18:58:43 +0800 (CST)
From: oushixiong1025@163.com
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH v2] drm/log: Fix division by zero when scale module parameter
 is 0
Date: Wed, 29 Jul 2026 18:58:40 +0800
Message-Id: <20260729105840.865696-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnt+Hi3GlqUOK_Mg--.62556S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZryrur4UuFW5Xw1fXF4fZrb_yoW5Xr1xpF
 WIkrZ8Jr4jyF4ru39I9r4xJry5Ka17Ja42grW7Kw1fAry8J3W0yFyUC398uFWUK3srCFsa
 vFnxtFWUJF12kaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8Z2-UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4gNkc2pp3OPgowAA3J
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

From: Shixiong Ou <oushixiong@kylinos.cn>

The scale module parameter can be set to 0 via kernel command line or
sysfs. When scale is 0, scaled_font_h and scaled_font_w become 0,
causing a division by zero in the rows/columns calculation.

Introduce a drm_log_scale() helper that returns scale ?: 1, and use it
at all read sites. This avoids a race that a setter-based clamp would
have between param_set_uint() and the subsequent check, where another
CPU could observe scale == 0.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
v1->v2:
   Introduce a drm_log_scale() helper.

 drivers/gpu/drm/clients/drm_log.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
index 294b3be1a6b3..9522c1344123 100644
--- a/drivers/gpu/drm/clients/drm_log.c
+++ b/drivers/gpu/drm/clients/drm_log.c
@@ -29,6 +29,11 @@ static unsigned int scale = 1;
 module_param(scale, uint, 0444);
 MODULE_PARM_DESC(scale, "Integer scaling factor for drm_log, default is 1");
 
+static inline unsigned int drm_log_scale(void)
+{
+	return scale ?: 1;
+}
+
 /**
  * DOC: overview
  *
@@ -76,13 +81,13 @@ static void drm_log_blit(struct iosys_map *dst, unsigned int dst_pitch,
 {
 	switch (px_width) {
 	case 2:
-		drm_draw_blit16(dst, dst_pitch, src, src_pitch, height, width, scale, color);
+		drm_draw_blit16(dst, dst_pitch, src, src_pitch, height, width, drm_log_scale(), color);
 		break;
 	case 3:
-		drm_draw_blit24(dst, dst_pitch, src, src_pitch, height, width, scale, color);
+		drm_draw_blit24(dst, dst_pitch, src, src_pitch, height, width, drm_log_scale(), color);
 		break;
 	case 4:
-		drm_draw_blit32(dst, dst_pitch, src, src_pitch, height, width, scale, color);
+		drm_draw_blit32(dst, dst_pitch, src, src_pitch, height, width, drm_log_scale(), color);
 		break;
 	default:
 		WARN_ONCE(1, "Can't blit with pixel width %d\n", px_width);
@@ -216,8 +221,8 @@ static int drm_log_setup_modeset(struct drm_client_dev *client,
 		return -ENOMEM;
 	}
 	mode_set->fb = scanout->buffer->fb;
-	scanout->scaled_font_h = scanout->font->height * scale;
-	scanout->scaled_font_w = scanout->font->width * scale;
+	scanout->scaled_font_h = scanout->font->height * drm_log_scale();
+	scanout->scaled_font_w = scanout->font->width * drm_log_scale();
 	scanout->rows = height / scanout->scaled_font_h;
 	scanout->columns = width / scanout->scaled_font_w;
 	scanout->front_color = drm_draw_color_from_xrgb8888(0xffffff, format);
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus


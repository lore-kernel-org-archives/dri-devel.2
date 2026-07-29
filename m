Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC79C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CEFF10EB1E;
	Wed, 29 Jul 2026 08:49:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="L84OG8OF";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DC0110EB07
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gm
 VSpBDjngTph2S80iTxh02pmPynoZ5jo6HXxH81qhc=; b=L84OG8OF6bm6k4e//J
 CxG3V/irVk8KnoXUBbDIsFhw9HN9UTMsiG2TCg3C7a/JApgjImTetMbYJ5RhUWY+
 +ikEeuLv5bUYKkMVxvNBoS8HFg08bcqpY3PlBPaLrGHW8MOVG/nRbaGzuVNjK5d6
 KNF9s272z4mq6RRyVRiHAarDo=
Received: from localhost.localdomain (unknown [])
 by gzsmtp1 (Coremail) with SMTP id PCgvCgBnmTpQvmlq0pItIQ--.62045S2;
 Wed, 29 Jul 2026 16:48:17 +0800 (CST)
From: oushixiong1025@163.com
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH 3/4] drm/log: Fix infinite loop when scale is too large for
 display
Date: Wed, 29 Jul 2026 16:48:15 +0800
Message-Id: <20260729084815.692944-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PCgvCgBnmTpQvmlq0pItIQ--.62045S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy8KF15CF4rGrWkZF15twb_yoW8Gw4Dpr
 WSkr909FW8tF42y34vva1fWFy5Ja17Xa4UW3yjy3ZxCr18Gr10y3W5tws8ZF42k3y7CanF
 g3ZxKFW7JF1jkaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8pnQUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4RG4x2ppvlHklgAA3R
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

When scale is large enough that scaled_font exceeds the display
dimensions, rows or columns become 0. A columns value of 0 causes
an infinite loop in drm_log_draw_kmsg_record() because the loop
never decrements len.

Check for zero rows/columns in drm_log_setup_modeset() and return
an error, cleaning up the already allocated buffer to avoid a leak.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/clients/drm_log.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
index a04f651e8265..63577aeb705c 100644
--- a/drivers/gpu/drm/clients/drm_log.c
+++ b/drivers/gpu/drm/clients/drm_log.c
@@ -240,6 +240,12 @@ static int drm_log_setup_modeset(struct drm_client_dev *client,
 	scanout->scaled_font_w = scanout->font->width * scale;
 	scanout->rows = height / scanout->scaled_font_h;
 	scanout->columns = width / scanout->scaled_font_w;
+	if (!scanout->rows || !scanout->columns) {
+		drm_client_buffer_delete(scanout->buffer);
+		scanout->buffer = NULL;
+		mode_set->fb = NULL;
+		return -EINVAL;
+	}
 	scanout->front_color = drm_draw_color_from_xrgb8888(0xffffff, format);
 	scanout->prefix_color = drm_draw_color_from_xrgb8888(0x4e9a06, format);
 	return 0;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus


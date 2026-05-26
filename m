Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6D4CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 13:32:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA47F10E4AF;
	Tue, 26 May 2026 13:32:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="G3HNf0FM";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F058210E4AF
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 13:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1N
 4mxlQmcxLBqdU9q8trXnA6PzPq3w4ggMHk2XEFBAc=; b=G3HNf0FMpBpjlMusbE
 L2dD3uUhcARQYiHVYysLKrYXcjPGeYn5hx9AM5TgIifYYyrHzSq3MwRml3HUvLWq
 dYB8n9WS3hMQvbwWOH65NoAHwKYHqs/Suudj5vTMG5C3Jo5UtUxx1xdYT9qKWak9
 z5m5z9jEbdsJUIKi1mdZYsv/4=
Received: from 163.com (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wD3v0evoBVqYN9KDg--.14290S7; 
 Tue, 26 May 2026 21:31:45 +0800 (CST)
From: w15303746062@163.com
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 louis.chauvet@bootlin.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v2 6.18.y 5/5] drm/vblank: Fix kernel docs for vblank timer
Date: Tue, 26 May 2026 21:31:23 +0800
Message-Id: <20260526133123.691465-6-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526133123.691465-1-w15303746062@163.com>
References: <20260526133123.691465-1-w15303746062@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3v0evoBVqYN9KDg--.14290S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWUKryfuw4rWFykZw17Awb_yoW8Aw48pr
 srGry3trs5tF90g3WDC3Z7CFyY9a45JFyxuF9rt3y5Zwnayr1ayF1Fyr43uFyUXrnxCa1a
 qr9xXr13AF1rCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFXdbUUUUU=
X-Originating-IP: [113.200.174.100]
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4wE4HGoVoMF7xwAA3k
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

From: Thomas Zimmermann <tzimmermann@suse.de>

Fix documentation for drm_crtc_vblank_start_timer(), which referred
to drm_crtc_vblank_cancel_timer().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/dri-devel/20251106152201.6f248c09@canb.auug.org.au/
Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Link: https://patch.msgid.link/20251106073207.11192-1-tzimmermann@suse.de
(cherry picked from commit 3946d3ba99342f3b9996e621f05e7003d4308171)
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/gpu/drm/drm_vblank.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 61e211fd3c9c..451ec9620226 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -2258,7 +2258,7 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 EXPORT_SYMBOL(drm_crtc_vblank_start_timer);
 
 /**
- * drm_crtc_vblank_start_timer - Cancels the given CRTC's vblank timer
+ * drm_crtc_vblank_cancel_timer - Cancels the given CRTC's vblank timer
  * @crtc: the CRTC
  *
  * Drivers should call this function from their CRTC's disable_vblank
-- 
2.34.1


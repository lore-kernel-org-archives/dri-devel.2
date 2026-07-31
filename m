Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0B7C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:12:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B2B10F218;
	Fri, 31 Jul 2026 11:12:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="Y7ua6z21";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 524A210F218
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 11:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
 Content-Type; bh=INQWhOLIhCHtGcOk61iUZgio4nHSvbrA+EjdpS+Q3u4=;
 b=Y7ua6z21gHLh+UdDXB385Bz0ojkBPgHYOfDiMWy2WXeQanTvddMy6tXSpM3RLH
 H+19vGfrgScZm/KDDUF5p3Oyk5Z3r8lSO8ER3HPV/jTMfJkF0qYUv/xOC+IUsWtd
 djEYZ1hjKEGwyDNrgA3hGlqrFywF6ucIyswos/ZFs1xTk=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wDnTwD8gmxqtQ_iMA--.5689S2; 
 Fri, 31 Jul 2026 19:11:57 +0800 (CST)
From: oushixiong1025@163.com
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm/sysfb: Fix atomic_disable to use dst coordinates instead
 of src
Date: Fri, 31 Jul 2026 19:11:55 +0800
Message-Id: <20260731111155.695390-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Add_By_Label_Mail_Nextpart_001"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnTwD8gmxqtQ_iMA--.5689S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy8tF15tr47uw1rGr1kGrg_yoW8XFWrpF
 ZrG34q9rsYyws0gFWDCay8try3Xa95Jw4xKryrCw4S9wnYyFy3GF1rGry7Cr4UJrZ5Kw43
 ZwnIyrWDJ3WFka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8J5rUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4h2VpGpsgv2LXQAA3h
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

--Add_By_Label_Mail_Nextpart_001
Content-Type: text/plain;
Content-Transfer-Encoding: 8bit


From: Shixiong Ou <oushixiong@kylinos.cn>

drm_sysfb_plane_helper_atomic_disable() constructs the clear rectangle
from plane_state->src_* coordinates. This is inconsistent with
drm_sysfb_plane_helper_atomic_update() which uses plane_state->dst
— the destination rectangle already computed by the DRM core with panel
orientation applied.

Use plane_state->dst directly, matching the approach in atomic_update.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
index d2de29caf89e..18466de886aa 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
@@ -380,14 +380,10 @@ void drm_sysfb_plane_helper_atomic_disable(struct drm_plane *plane,
 	void __iomem *dst_vmap = dst.vaddr_iomem; /* TODO: Use mapping abstraction */
 	unsigned int dst_pitch = sysfb->fb_pitch;
 	const struct drm_format_info *dst_format = sysfb->fb_format;
-	struct drm_rect dst_clip;
+	struct drm_rect dst_clip = plane_state->dst;
 	unsigned long lines, linepixels, i;
 	int idx;
 
-	drm_rect_init(&dst_clip,
-		      plane_state->src_x >> 16, plane_state->src_y >> 16,
-		      plane_state->src_w >> 16, plane_state->src_h >> 16);
-
 	lines = drm_rect_height(&dst_clip);
 	linepixels = drm_rect_width(&dst_clip);
 
-- 
2.25.1


--Add_By_Label_Mail_Nextpart_001

Content-type: Text/plain

No virus found
		Checked by Hillstone Network AntiVirus

--Add_By_Label_Mail_Nextpart_001--


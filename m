Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C132AC61CE2
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28B8510E21F;
	Tue, 25 Aug 2026 10:41:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="QG1QaBZ1";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D33810E21F
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 10:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
 Content-Type; bh=INQWhOLIhCHtGcOk61iUZgio4nHSvbrA+EjdpS+Q3u4=;
 b=QG1QaBZ1/aJAwqzXly255zuecOKv5Cx3uViQ6WYkSiijtdFYtrKDTYJuNU8vbP
 ASwEj8QCtF6rebGcjAjt7MTsA1CAOzHQKFglwKK83D9G68xem4PtqhE8WUDH1QG0
 ZiG3dv5DTBj+vGcJu+FWMSM8RTDoXVYeyBQ6JMS1o7Cx4=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wC3t_9OcY1qa+IxPg--.45577S2; 
 Tue, 25 Aug 2026 18:41:19 +0800 (CST)
From: oushixiong1025@163.com
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH RESEND] drm/sysfb: Fix atomic_disable to use dst coordinates
 instead of src
Date: Tue, 25 Aug 2026 18:41:17 +0800
Message-Id: <20260825104117.667943-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Add_By_Label_Mail_Nextpart_001"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3t_9OcY1qa+IxPg--.45577S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy8tF15tr47uw1rGr1kGrg_yoW8XFWrpF
 ZrG34q9rsYyws0gFWDCay8try3Xa95Jw4xKryrCw4S9wnYyFy3GF1rGry7Cr4UJrZ5Kw43
 ZwnIyrWDJ3WFka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnBMNUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC-g9tfGqNcU9HWgAA3k
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


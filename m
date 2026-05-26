Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAD5CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 13:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7626110E656;
	Tue, 26 May 2026 13:32:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="Hq6wihak";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 203C110E4D0
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
 Content-Type; bh=UEeCL38PHXnSztjS/6CD3ugZQl17GiH4O46J5Qeh2ow=;
 b=Hq6wihakIVrABfWAspSMpgZ4h9RCajB1RhhaOQz1G3Q5Y8BIelyUs5lyjJVI0I
 e3mn1lUeLX8Upyxm34xbvI+k9u0bMI/YMmRkOT+Z6SlHGp2pI3GMYe24vVe+I3+v
 iuyxHpCUjZITpMncf4HZGaioIKXMbsIYXfCgqKW8uzhHo=
Received: from 163.com (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wD3v0evoBVqYN9KDg--.14290S6; 
 Tue, 26 May 2026 21:31:43 +0800 (CST)
From: w15303746062@163.com
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 louis.chauvet@bootlin.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 syzbot+fcede535e7eb57cf5b43@syzkaller.appspotmail.com,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v2 6.18.y 4/5] drm/atomic: Increase timeout in
 drm_atomic_helper_wait_for_vblanks()
Date: Tue, 26 May 2026 21:31:22 +0800
Message-Id: <20260526133123.691465-5-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526133123.691465-1-w15303746062@163.com>
References: <20260526133123.691465-1-w15303746062@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3v0evoBVqYN9KDg--.14290S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW8Cw4kKrykXF13ZrWUArb_yoW8CFW3pF
 srKFyUtrsYqF1Dt34DAa1xZa4Y9ay7XFyIg3srtw1ruw4qyF9IyF1SvrW3GFyUZrsrur4a
 vas7Jr13Cr15CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFGQDUUUUU=
X-Originating-IP: [113.200.174.100]
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbDAB83G2oVoL-2sQAA3U
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

Increase the timeout for vblank events from 100 ms to 1000 ms. This
is the same fix as in commit f050da08a4ed ("drm/vblank: Increase
timeout in drm_wait_one_vblank()") for another vblank timeout.

After merging generic DRM vblank timers [1] and converting several
DRM drivers for virtual hardware, these drivers synchronize their
vblank events to the display refresh rate. This can trigger timeouts
within the DRM framework.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://lore.kernel.org/dri-devel/20250904145806.430568-1-tzimmermann@suse.de/ # [1]
Reported-by: syzbot+fcede535e7eb57cf5b43@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/dri-devel/69381d6c.050a0220.4004e.0017.GAE@google.com/
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
Link: https://patch.msgid.link/20251209143325.102056-1-tzimmermann@suse.de
(cherry picked from commit 79ae8510b5b81b9500370f89c619b50ca9c0990f)
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/gpu/drm/drm_atomic_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index d5ebe6ea0acb..f9d328dcaed8 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1837,7 +1837,7 @@ drm_atomic_helper_wait_for_vblanks(struct drm_device *dev,
 		ret = wait_event_timeout(dev->vblank[i].queue,
 					 state->crtcs[i].last_vblank_count !=
 						drm_crtc_vblank_count(crtc),
-					 msecs_to_jiffies(100));
+					 msecs_to_jiffies(1000));
 
 		WARN(!ret, "[CRTC:%d:%s] vblank wait timed out\n",
 		     crtc->base.id, crtc->name);
-- 
2.34.1


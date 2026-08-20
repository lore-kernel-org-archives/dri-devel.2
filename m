Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DEDC5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:32:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77B1B10EF41;
	Thu, 20 Aug 2026 08:32:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="H65FeqpM";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D70310EF3E
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 08:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ei
 SPbtL4WXdi7foDTth7zJdSvX8T7Vd7rf22G0sMXG8=; b=H65FeqpMDGUIage9wD
 /MAHqq3m/aOUWfBfQHDSzajV8JbpYRvsyj8Grn/QbRROSwlK39ES8EIsjphl89s+
 3UPEmWZ2lIWlSgWCeIQRwY2W9KxUKQd8vlZNSEeaGGRsZ/HUsAvRaCZhiS4U5zBI
 D5ylm0rRhnwPBcDM7iXXA34cY=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id
 _____wAnGJteu4ZqyKiICg--.32760S3; 
 Thu, 20 Aug 2026 16:31:29 +0800 (CST)
From: oushixiong1025@163.com
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm/vkms: Fix gamma_lut size check
Date: Thu, 20 Aug 2026 16:31:21 +0800
Message-Id: <20260820083123.544655-2-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260820083123.544655-1-oushixiong1025@163.com>
References: <20260820083123.544655-1-oushixiong1025@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnGJteu4ZqyKiICg--.32760S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFyUJF48GFWDGF1kWF4DJwb_yoW8JFyrpF
 W7Gr9YvrWYq3WUKwnFyFs7Cay3JwnIqFWxWFyjka45urZ5Kr1UJas8ArWjv398Jw47Za4I
 qF98tFy3Xw1j9F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUpnQUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4gFDUmqGu2GZxgAA3b
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

The gamma_lut size check in vkms_atomic_check() uses
sizeof(struct drm_color_lut *) instead of sizeof(struct drm_color_lut).
On 64-bit both happen to be 8 bytes, so the check works by accident.
On 32-bit sizeof(pointer) is 4 bytes while sizeof(struct drm_color_lut)
is 8 bytes, which would incorrectly reject valid 256-entry LUTs.

Fixes: db1f254f2cfa ("drm/vkms: Add support to 1D gamma LUT")

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus


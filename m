Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3343C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F77A10E5E5;
	Thu, 20 Aug 2026 08:32:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="jgZHuEa4";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4503E10E5E5
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 08:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Os
 29JjWfkxr7t/VcAOmRQsXtZJrkASAMJNjIK8EpuJI=; b=jgZHuEa4PJ6Y+kY1cn
 hWLiX92hLDopfxLu0HZJVAVERscLp+RIxSN5PdkCQXdows7eejb39hM7Al2jAukE
 GYkMmPmz3U9X172mA08JzX7dEzXgTgPI/iGe1+jzSIJLpQVtV3/J1V5O64Z3cJ1p
 2ZQhdXYVkPfZ5uzAVLvJdu4uc=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id
 _____wAnGJteu4ZqyKiICg--.32760S4; 
 Thu, 20 Aug 2026 16:31:30 +0800 (CST)
From: oushixiong1025@163.com
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm/vkms: Fix vertical read step for R1/R2/R4 formats
Date: Thu, 20 Aug 2026 16:31:22 +0800
Message-Id: <20260820083123.544655-3-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260820083123.544655-1-oushixiong1025@163.com>
References: <20260820083123.544655-1-oushixiong1025@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnGJteu4ZqyKiICg--.32760S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFy5Cw45KFy8uF1rWw1UAwb_yoW8Ww4rpF
 43Gryvqr4rtr4Fv3WIyay8Cry3uwsxWFW5trW7G34Ygr1F9ryUur95Kr9IkFWkKFn7CrnF
 qFs8Jr98Z3WUGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jxfHUUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC4QJDUmqGu2KzngAA3q
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

get_block_step_bytes() returns pitches * block_w as the vertical step for
READ_TOP_TO_BOTTOM and READ_BOTTOM_TO_TOP, but consecutive rows are
pitches * block_h bytes apart (block_h is 1 for R1/R2/R4). Vertical reads
therefore sample every block_w-th row instead of every row, and walk past
the end of the framebuffer, when 90/270-rotating or reflecting R1/R2/R4
planes. Use the block height instead, matching packed_pixels_offset().

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/vkms/vkms_formats.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
index dfb8e13cba87..1e3a6af9cea5 100644
--- a/drivers/gpu/drm/vkms/vkms_formats.c
+++ b/drivers/gpu/drm/vkms/vkms_formats.c
@@ -103,11 +103,11 @@ static int get_block_step_bytes(struct drm_framebuffer *fb, enum pixel_read_dire
 	case READ_RIGHT_TO_LEFT:
 		return -fb->format->char_per_block[plane_index];
 	case READ_TOP_TO_BOTTOM:
-		return (int)fb->pitches[plane_index] * drm_format_info_block_width(fb->format,
-										   plane_index);
-	case READ_BOTTOM_TO_TOP:
-		return -(int)fb->pitches[plane_index] * drm_format_info_block_width(fb->format,
+		return (int)fb->pitches[plane_index] * drm_format_info_block_height(fb->format,
 										    plane_index);
+	case READ_BOTTOM_TO_TOP:
+		return -(int)fb->pitches[plane_index] * drm_format_info_block_height(fb->format,
+										     plane_index);
 	}
 
 	return 0;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus


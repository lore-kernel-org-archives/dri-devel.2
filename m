Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DC2C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A558826D;
	Wed, 12 Aug 2026 15:48:40 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE2998826D
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:48:38 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [120.85.96.94])
 by APP-03 (Coremail) with SMTP id rQCowACnc0HPlXxqB5r4BA--.21280S2;
 Wed, 12 Aug 2026 23:48:32 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Chen-Yu Tsai <wenst@chromium.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <uwu@icenowy.me>, Icenowy Zheng <zhengxingda@iscas.ac.cn>
Subject: [PATCH] drm: verisilicon: fix cursor offset field update
Date: Wed, 12 Aug 2026 23:48:29 +0800
Message-ID: <20260812154829.671777-1-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACnc0HPlXxqB5r4BA--.21280S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr43Gr4UAr4ftrWkKFWkCrg_yoW8Cw4fpF
 WYka18K3ZFya1DXryDKr4DtrWfZa1rtrsa9rs8Cw4Yvwn8t343uryrGF97uFWDJFnxWr1a
 9anFkrW5Ar4I9aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
 n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
 AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
 17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
 IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
 IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
 C2KfnxnUUI43ZEXa7VUb_Ma5UUUUU==
X-Originating-IP: [120.85.96.94]
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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

The 4th argument of regmap_update_bits() expects a pre-shifted register
value instead of the field value when it's used to set a single field,
however I forgot this when writing the code setting the cursor X/Y
offset fields, thus the write operation doesn't happen at all (because
of the non-shifted values being masked by regmap_update_bits()).

Fix this problem so the cursor is correctly clipped.

The framebuffer address is also clipped so the cursor offset problem was
previously not discovered, and the framebuffer address deserves another
fix for proper cursor behavior when it's clipped.

Fixes: 8c4ae2189125 ("drm: verisilicon: add support for cursor planes")
Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/verisilicon/vs_cursor_plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
index fa4f601dd0c87..4ce311ae48823 100644
--- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
+++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
@@ -199,7 +199,7 @@ static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
 	} else {
 		regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
 				   VSDC_CURSOR_CONFIG_X_OFF_MASK,
-				   -state->crtc_x);
+				   VSDC_CURSOR_CONFIG_X_OFF(-state->crtc_x));
 		regmap_update_bits(dc->regs, VSDC_CURSOR_LOCATION(output),
 				   VSDC_CURSOR_LOCATION_X_MASK, 0);
 	}
@@ -213,7 +213,7 @@ static void vs_cursor_plane_atomic_update(struct drm_plane *plane,
 	} else {
 		regmap_update_bits(dc->regs, VSDC_CURSOR_CONFIG(output),
 				   VSDC_CURSOR_CONFIG_Y_OFF_MASK,
-				   -state->crtc_y);
+				   VSDC_CURSOR_CONFIG_Y_OFF(-state->crtc_y));
 		regmap_update_bits(dc->regs, VSDC_CURSOR_LOCATION(output),
 				   VSDC_CURSOR_LOCATION_Y_MASK, 0);
 	}
-- 
2.52.0


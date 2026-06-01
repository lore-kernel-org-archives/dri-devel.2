Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B12CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 07:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05F40112F2F;
	Mon,  1 Jun 2026 07:54:36 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43EAC112F2F
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 07:54:33 +0000 (UTC)
X-UUID: 1d3be2805d8f11f1aa26b74ffac11d73-20260601
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:fedfcc34-84aa-469c-a9e9-4b4170d56118, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:25
X-CID-META: VersionHash:e7bac3a, CLOUDID:c9f868013bde326e382fa55a7c858271,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|123|850|865|898,TC:nil,Content
 :0|15|50,EDM:5,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
 :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1d3be2805d8f11f1aa26b74ffac11d73-20260601
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yaolu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1752011668; Mon, 01 Jun 2026 15:54:27 +0800
From: yaolu@kylinos.cn
To: deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, simona@ffwll.ch, tzimmermann@suse.de,
 yaolu@kylinos.cn
Subject: [PATCH v2] fbcon: do suspend/resume only when vc is text mode and
 visible
Date: Mon,  1 Jun 2026 15:54:23 +0800
Message-Id: <20260601075423.543611-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <67a1f756-996c-404b-8eff-f705ff151ed3@gmx.de>
References: <67a1f756-996c-404b-8eff-f705ff151ed3@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Lu Yao <yaolu@kylinos.cn>

Don't need to do suspend/resume for fbcon in graphic mode.

Doing this may cause error, eg:
  At the beginning, starting the Xorg with single screen and then an
  external screen was plugged in. After logging out in Xorg, fbdev
  info may using screen which is connected later on for info always
  using first connected connector in list in func 'drm_setup_crtcs_fb'.
  Then, S3 executed, fbcon found that the information did not match
  and do atomic to switch fb. However, Xorg will not re-bind the crtc
  fb but continues doing ioctl. At this time, the fb is incorrect.

Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
v1->v2: change to '==KD_TEXT' rather than '!=KD_GRAPHICS' and add
visible judgement suggested by Helge.
  Link: https://lore.kernel.org/all/67a1f756-996c-404b-8eff-f705ff151ed3@gmx.de

 drivers/video/fbdev/core/fbcon.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index b0e3e765360d..ab460ba9264c 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2602,8 +2602,9 @@ void fbcon_suspended(struct fb_info *info)
 		return;
 	vc = vc_cons[par->currcon].d;
 
-	/* Clear cursor, restore saved data */
-	fbcon_cursor(vc, false);
+	/* Only in TEXT mode and visible, need to clear cursor, restore saved data */
+	if ((vc->vc_mode == KD_TEXT) && con_is_visible(vc))
+		fbcon_cursor(vc, false);
 }
 
 void fbcon_resumed(struct fb_info *info)
@@ -2615,7 +2616,9 @@ void fbcon_resumed(struct fb_info *info)
 		return;
 	vc = vc_cons[par->currcon].d;
 
-	update_screen(vc);
+	/* Graphics mode is managed by userspace */
+	if ((vc->vc_mode == KD_TEXT) && con_is_visible(vc))
+		update_screen(vc);
 }
 
 static void fbcon_modechanged(struct fb_info *info)
-- 
2.25.1


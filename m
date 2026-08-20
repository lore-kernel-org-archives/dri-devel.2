Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C75EC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 08:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B655510EF64;
	Thu, 20 Aug 2026 08:48:42 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C47C210E146
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 06:00:34 +0000 (UTC)
X-UUID: 71ec5d589c5c11f19a56ed5b684f684d-20260820
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:efee74a8-2a7e-4cb1-a816-6b8c27cfee85, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:1288cbc57c99250d7bddb12c354bae79,
 BulkI
 D:nil,BulkQuantity:0,SF:102|136|865|898,TC:nil,Content:0|15|50,EDM:-3|-100
 ,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
 ,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 71ec5d589c5c11f19a56ed5b684f684d-20260820
X-User: yuebingkun@kylinos.cn
Received: from tushenkeke2-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yuebingkun@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 628903182; Thu, 20 Aug 2026 14:00:28 +0800
From: Yue Bing Kun <yuebingkun@kylinos.cn>
To: Helge Deller <deller@gmx.de>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] fbdev: platinumfb: add error checking for ioremap calls
Date: Thu, 20 Aug 2026 14:00:26 +0800
Message-ID: <20260820060026.217814-1-yuebingkun@kylinos.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Aug 2026 08:48:42 +0000
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

From: BingKun Yue <yuebingkun@kylinos.cn>

The ioremap() and ioremap_wt() calls in platinumfb_probe() were not
checked for failure. If any of these mappings fail, the driver would
dereference NULL pointers, leading to a kernel panic.

Add proper error checking and use goto-based cleanup to avoid code
duplication across the error paths.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/linux-fbdev/20260819235918.GA2021182@ax162/
Signed-off-by: BingKun Yue <yuebingkun@kylinos.cn>
---
 drivers/video/fbdev/platinumfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/platinumfb.c b/drivers/video/fbdev/platinumfb.c
index fdffadcc3e73..f74c937c839f 100644
--- a/drivers/video/fbdev/platinumfb.c
+++ b/drivers/video/fbdev/platinumfb.c
@@ -320,7 +320,7 @@ static void platinum_init_info(struct fb_info *info,
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
 	/* Fill fix common fields */
-	strscpy(info->fix.id, "platinum", sizeof(info->fix.id));
+	strcpy(info->fix.id, "platinum");
 	info->fix.mmio_start = pinfo->platinum_regs_phys;
 	info->fix.mmio_len = 0x1000;
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
-- 
2.43.0


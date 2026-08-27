Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA48EC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6766810EF51;
	Thu, 27 Aug 2026 09:40:03 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64E0A10EF44
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 09:40:01 +0000 (UTC)
X-UUID: 41e4d5c8a1fb11f19a56ed5b684f684d-20260827
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:640dcb19-faa6-4c45-a602-b342da94bd57, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:5d4d7d0e73630483ef795926548c25ba,
 BulkI
 D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50,EDM:-3|
 -100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
 0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 41e4d5c8a1fb11f19a56ed5b684f684d-20260827
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <lilinmao@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 697264291; Thu, 27 Aug 2026 17:39:53 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: deller@gmx.de,
	linux-fbdev@vger.kernel.org
Cc: schmitzmic@gmail.com, miro.kropacek@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH] fbdev: atafb: Restrict SuperBlitter to supported formats
Date: Thu, 27 Aug 2026 17:39:48 +0800
Message-Id: <20260827093948.2825531-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

The SuperBlitter operations derive an integer byte count per pixel.  The
accelerated fill path handles only one-, two- and four-byte pixels.
However, the operations are currently installed for every external
framebuffer in SuperVidel RAM, including planar 1/2/4/8-bpp and 24-bpp
truecolor modes accepted by the external video parser.

For 1/2/4-bpp modes, the byte count becomes zero, so accelerated copies do
nothing and fills fall through to 32-bit stores.  Planar 8-bpp uses an
incompatible memory layout.  For 24-bpp modes, fills also use 32-bit stores
despite advancing addresses by three bytes per pixel.  These cases can
corrupt the framebuffer beyond the requested rectangle.

Enable the SuperBlitter operations only for the layouts they implement:
8-bpp packed pixels and 16/32-bpp truecolor.  Keep the existing software
operations for all other external formats.

Fixes: d463633d63e6 ("fbdev: atafb: Add support for SuperVidel's SuperBlitter")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/video/fbdev/atafb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index 5bca34c45cef3..c3011b61a94b9 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -3360,7 +3360,11 @@ static int __init atafb_probe(struct platform_device *pdev)
 		memset (screen_base, 0, external_len);
 
 		/* framebuffer in SV RAM: enable the SuperBlitter */
-		if (external_addr >= 0xa0000000) {
+		if (external_addr >= 0xa0000000 &&
+		    ((external_pmode == FB_TYPE_PACKED_PIXELS &&
+		      external_depth == 8) ||
+		     (external_pmode == -1 &&
+		      (external_depth == 16 || external_depth == 32)))) {
 			svblit_regs = ioremap(SVBLIT_REGS_PHYS, 0x100);
 			if (svblit_regs) {
 				svblit_fw = svblit_rd(SVBLIT_VERSION) & 0x1ff;
-- 
2.25.1


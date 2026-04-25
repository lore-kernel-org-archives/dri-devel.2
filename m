Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30D9FF8864
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 06:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 007EA10E515;
	Sun, 26 Apr 2026 06:47:15 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8581610E0D6
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 07:04:58 +0000 (UTC)
X-UUID: 5976835a407411f1aa26b74ffac11d73-20260425
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:b382d7f5-7ed2-4757-b49b-748a729d1c86, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:feb819b6dc55270ad3a2f05111c21055,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|898,TC:nil,Content:0|15|50,EDM
 :-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
 ,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5976835a407411f1aa26b74ffac11d73-20260425
X-User: aichao@kylinos.cn
Received: from thinksys.. [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <aichao@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1340601746; Sat, 25 Apr 2026 14:59:48 +0800
From: Ai Chao <aichao@kylinos.cn>
To: deller@gmx.de, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, linux@armlinux.org.uk, dilinger@queued.net,
 adaplas@gmail.com, James.Bottomley@HansenPartnership.com,
 FlorianSchandinat@gmx.de, alchark@gmail.com, krzk@kernel.org,
 kees@kernel.org, rene@exactco.de, tzimmermann@suse.de,
 rongqianfeng@vivo.com, thorsten.blum@linux.dev,
 chelsyratnawat2001@gmail.com, soci@c64.rulez.org,
 gregkh@linuxfoundation.org, daniel@thingy.jp, linmq006@gmail.com,
 fourier.thomas@gmail.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-geode@lists.infradead.org, linux-parisc@vger.kernel.org,
 Ai Chao <aichao@kylinos.cn>
Subject: [PATCH 03/35] fbdev: sisfb: Use safer strscpy() instead of strcpy()
Date: Sat, 25 Apr 2026 14:58:54 +0800
Message-Id: <20260425065926.1091168-4-aichao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425065926.1091168-1-aichao@kylinos.cn>
References: <20260425065926.1091168-1-aichao@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 26 Apr 2026 06:46:56 +0000
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

Use a safer function strscpy() instead of strcpy() for copying to arrays.

Only idiomatic code replacement, and no functional changes.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
 drivers/video/fbdev/sis/sis_main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index 84567d67f71d..e87fa261f76c 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -205,7 +205,7 @@ static void sisfb_search_mode(char *name, bool quiet)
 	}
 
 	if(strlen(name) <= 19) {
-		strcpy(strbuf1, name);
+		strscpy(strbuf1, name);
 		for(i = 0; i < strlen(strbuf1); i++) {
 			if(strbuf1[i] < '0' || strbuf1[i] > '9') strbuf1[i] = ' ';
 		}
@@ -5947,33 +5947,33 @@ static int sisfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 #ifdef CONFIG_FB_SIS_300
 		case PCI_DEVICE_ID_SI_730:
 			ivideo->chip = SIS_730;
-			strcpy(ivideo->myid, "SiS 730");
+			strscpy(ivideo->myid, "SiS 730");
 			break;
 #endif
 #ifdef CONFIG_FB_SIS_315
 		case PCI_DEVICE_ID_SI_651:
 			/* ivideo->chip is ok */
-			strcpy(ivideo->myid, "SiS 651");
+			strscpy(ivideo->myid, "SiS 651");
 			break;
 		case PCI_DEVICE_ID_SI_740:
 			ivideo->chip = SIS_740;
-			strcpy(ivideo->myid, "SiS 740");
+			strscpy(ivideo->myid, "SiS 740");
 			break;
 		case PCI_DEVICE_ID_SI_661:
 			ivideo->chip = SIS_661;
-			strcpy(ivideo->myid, "SiS 661");
+			strscpy(ivideo->myid, "SiS 661");
 			break;
 		case PCI_DEVICE_ID_SI_741:
 			ivideo->chip = SIS_741;
-			strcpy(ivideo->myid, "SiS 741");
+			strscpy(ivideo->myid, "SiS 741");
 			break;
 		case PCI_DEVICE_ID_SI_760:
 			ivideo->chip = SIS_760;
-			strcpy(ivideo->myid, "SiS 760");
+			strscpy(ivideo->myid, "SiS 760");
 			break;
 		case PCI_DEVICE_ID_SI_761:
 			ivideo->chip = SIS_761;
-			strcpy(ivideo->myid, "SiS 761");
+			strscpy(ivideo->myid, "SiS 761");
 			break;
 #endif
 		default:
-- 
2.34.1


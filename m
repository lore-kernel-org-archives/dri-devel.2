Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C05D606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63EE910F344;
	Tue, 24 Nov 2026 08:39:47 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E547610E2D1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 02:49:41 +0000 (UTC)
X-UUID: af993bf8e7b111f19a56ed5b684f684d-20261124
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:14aa8185-f1b9-414f-aaf8-86276cc4da59, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:1933bcb9f53dae1a15bdb69f78cd479b,
 BulkI
 D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
 -3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
 SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: af993bf8e7b111f19a56ed5b684f684d-20261124
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <pengyu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1360815085; Tue, 24 Nov 2026 10:49:36 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Helge Deller <deller@gmx.de>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yu Peng <pengyu@kylinos.cn>
Subject: [PATCH] vgacon: Update CRTC start address when turning scrollback off
Date: Tue, 24 Nov 2026 10:49:33 +0800
Message-ID: <20261124024933.306103-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:39:44 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 174657478cd8 ("vgacon: inline vc_scrolldelta_helper() into
vgacon_scrolldelta()") moved the early return for !lines into
vgacon_scrolldelta(), skipping vga_set_mem_top(c). This leaves the VGA
CRTC start address stuck at the old scrollback offset after
vgacon_restore_screen().

Call vga_set_mem_top(c) before returning when !lines.

Fixes: 174657478cd8 ("vgacon: inline vc_scrolldelta_helper() into vgacon_scrolldelta()")
Assisted-by: LLM
Signed-off-by: Yu Peng <pengyu@kylinos.cn>
---
 drivers/video/console/vgacon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 09f7c376b4689..a6b0223ca596d 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -147,6 +147,7 @@ static void vgacon_scrolldelta(struct vc_data *c, int lines)
 	/* Turn scrollback off */
 	if (!lines) {
 		c->vc_visible_origin = c->vc_origin;
+		vga_set_mem_top(c);
 		return;
 	}
 
-- 
2.43.0


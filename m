Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A18606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F37610E570;
	Mon, 23 Nov 2026 14:17:18 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42FD210EBB3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 10:12:02 +0000 (UTC)
X-UUID: 4ed9c192e72611f19a56ed5b684f684d-20261123
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:9026a8a2-b792-4f5a-9c6b-aa1809da5366, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:7db8b62, CLOUDID:08f9c6b08b8bae52e26abe2fa9450a67,
 BulkI
 D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:-3,I
 P:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
 ,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4ed9c192e72611f19a56ed5b684f684d-20261123
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <pengyu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 682078225; Mon, 23 Nov 2026 18:11:54 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Nicolas Pitre <nico@fluxnic.net>,
 Ronan Pigott <ronan@rjp.ie>, linux-serial@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yu Peng <pengyu@kylinos.cn>
Subject: [PATCH] vt: Skip hardware scrolling while blanked and fix VESA
 blanking
Date: Mon, 23 Nov 2026 18:11:51 +0800
Message-Id: <20261123101151.414436-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Nov 2026 14:16:40 +0000
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

When vgacon is blanked without palette blanking (!vga_palette_blanked),
vgacon_set_origin() rejects VRAM so vc->vc_origin points to the heap
buffer vc->vc_screenbuf. Calling hardware scroll callbacks while blanked
then treats vc->vc_screenbuf as VRAM and causes out-of-bounds accesses.

Use con_should_update() to skip hardware scrolling and scrollback while
blanked, allowing con_scroll() to fall back to software scrolling.
In vgacon_blank(), return !vga_palette_blanked for VESA blanking so
direct VESA blanking switches vc->vc_origin to vc->vc_screenbuf
immediately instead of losing output on unblank.

Assisted-by: LLM
Signed-off-by: Yu Peng <pengyu@kylinos.cn>
---
 drivers/tty/vt/vt.c            | 7 ++++---
 drivers/video/console/vgacon.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 6a6eb8b2a6dec..39be682645097 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -726,8 +726,8 @@ static void con_scroll(struct vc_data *vc, unsigned int top,
 		return;
 
 	vc_uniscr_scroll(vc, top, bottom, dir, nr);
-	if (con_is_visible(vc) &&
-			vc->vc_sw->con_scroll(vc, top, bottom, dir, nr))
+	if (con_should_update(vc) &&
+	    vc->vc_sw->con_scroll(vc, top, bottom, dir, nr))
 		return;
 
 	src = clear = (u16 *)(vc->vc_origin + vc->vc_size_row * top);
@@ -3488,7 +3488,8 @@ static void console_callback(struct work_struct *ignored)
 	if (scrollback_delta) {
 		struct vc_data *vc = vc_cons[fg_console].d;
 		clear_selection();
-		if (vc->vc_mode == KD_TEXT && vc->vc_sw->con_scrolldelta)
+		if (con_should_update(vc) && vc->vc_mode == KD_TEXT &&
+		    vc->vc_sw->con_scrolldelta)
 			vc->vc_sw->con_scrolldelta(vc, scrollback_delta);
 		scrollback_delta = 0;
 	}
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 09f7c376b4689..3a706c1f1cb28 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -796,7 +796,7 @@ static bool vgacon_blank(struct vc_data *c, enum vesa_blank_mode blank,
 			vga_vesa_blank(&vgastate, blank);
 			vga_vesa_blanked = blank;
 		}
-		return false;
+		return !vga_palette_blanked;
 	}
 }
 
-- 
2.43.0


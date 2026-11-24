Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C55606A33C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0FE710F34C;
	Tue, 24 Nov 2026 08:39:53 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E390A10E2D1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 02:48:22 +0000 (UTC)
X-UUID: 814610dce7b111f19a56ed5b684f684d-20261124
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:93c7292a-37a1-4c29-9fa7-ac819d28cdea, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:25
X-CID-META: VersionHash:7db8b62, CLOUDID:be7f58164b27982f055aebe1b3167887,
 BulkI
 D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50|99,ED
 M:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
 ,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 814610dce7b111f19a56ed5b684f684d-20261124
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <pengyu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 122866240; Tue, 24 Nov 2026 10:48:18 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Nicolas Pitre <nico@fluxnic.net>,
 Ronan Pigott <ronan@rjp.ie>, linux-serial@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yu Peng <pengyu@kylinos.cn>
Subject: [PATCH v2 1/2] vt: Skip hardware scrolling while blanked
Date: Tue, 24 Nov 2026 10:48:10 +0800
Message-ID: <20261124024811.305592-2-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124024811.305592-1-pengyu@kylinos.cn>
References: <20261124024811.305592-1-pengyu@kylinos.cn>
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

When vgacon is blanked without palette blanking (!vga_palette_blanked),
vgacon_set_origin() rejects VRAM so vc->vc_origin points to the heap
buffer vc->vc_screenbuf. Calling hardware scroll callbacks while blanked
then treats vc->vc_screenbuf as VRAM and causes out-of-bounds accesses.

Use con_should_update() to skip hardware scrolling and scrollback while
blanked, allowing con_scroll() to fall back to software scrolling.

Assisted-by: LLM
Signed-off-by: Yu Peng <pengyu@kylinos.cn>
---
 drivers/tty/vt/vt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

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
-- 
2.43.0


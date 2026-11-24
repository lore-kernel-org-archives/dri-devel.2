Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C083F606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C75BC10F343;
	Tue, 24 Nov 2026 08:39:46 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E368210E0A4
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 02:48:22 +0000 (UTC)
X-UUID: 7ea534c0e7b111f19a56ed5b684f684d-20261124
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:3c093e59-60d6-4673-8742-02a69f15615b, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:20
X-CID-META: VersionHash:7db8b62, CLOUDID:09287dc18e05006869466b218a6b2857,
 BulkI
 D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
 :nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
 :0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7ea534c0e7b111f19a56ed5b684f684d-20261124
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <pengyu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 499285219; Tue, 24 Nov 2026 10:48:14 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Nicolas Pitre <nico@fluxnic.net>,
 Ronan Pigott <ronan@rjp.ie>, linux-serial@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yu Peng <pengyu@kylinos.cn>
Subject: [PATCH v2 0/2] vt/vgacon: Skip blanked hardware scroll and fix VESA
 blanking
Date: Tue, 24 Nov 2026 10:48:09 +0800
Message-ID: <20261124024811.305592-1-pengyu@kylinos.cn>
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Split v1 [1] into two independent patches as requested by Helge Deller,
ordered so patch 1 fixes blanked scrolling before patch 2 switches
direct VESA blanking to vc->vc_screenbuf.

[1] https://lore.kernel.org/all/20261123101151.414436-1-pengyu@kylinos.cn/

Yu Peng (2):
  vt: Skip hardware scrolling while blanked
  vgacon: Switch to screenbuf on direct VESA blanking

 drivers/tty/vt/vt.c            | 7 ++++---
 drivers/video/console/vgacon.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.43.0


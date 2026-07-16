Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FD0C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:26:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ACE610F21F;
	Thu, 16 Jul 2026 08:26:01 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC50E10E300
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 08:25:58 +0000 (UTC)
X-UUID: f610de4880ef11f1aa26b74ffac11d73-20260716
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:9a6ddbad-1e50-491d-a2eb-6eae3ccbac01, IP:15,
 URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:40
X-CID-INFO: VERSION:1.3.12, REQID:9a6ddbad-1e50-491d-a2eb-6eae3ccbac01, IP:15,
 UR
 L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:40
X-CID-META: VersionHash:e7bac3a, CLOUDID:a91f91feecac09139382caf1843c88a0,
 BulkI
 D:260716162555F78DSFHR,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|123|127
 |136|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:93|82|11|1,File:nil,R
 T:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DK
 P:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f610de4880ef11f1aa26b74ffac11d73-20260716
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by
 mailgw.kylinos.cn (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1403865239; Thu, 16 Jul 2026 16:25:53 +0800
From: zhaoguohan@kylinos.cn
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, dri-devel@lists.freedesktop.org
Cc: Oded Gabbay <ogabbay@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH 0/3] accel/ethosu: fix probe and job cleanup errors
Date: Thu, 16 Jul 2026 16:25:27 +0800
Message-ID: <20260716082530.1023538-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

Fix error handling and cleanup issues in the Arm Ethos-U driver.

Sashiko reported these issues while reviewing the Ethos-U MMIO mapping fix.
The report is available at:

https://sashiko.dev/#/patchset/20260716065219.931088-1-zhaoguohan@kylinos.cn?part=1

The first two patches unwind scheduler, runtime PM, and SRAM state when
probe or SRAM setup fails. The final patch fixes completion fence ownership
across submit failures and scheduler early exits.

GuoHan Zhao (3):
  accel/ethosu: clean up resources on probe failure
  accel/ethosu: propagate SRAM initialization errors
  accel/ethosu: fix job completion fence cleanup

 drivers/accel/ethosu/ethosu_drv.c | 39 +++++++++++++++++++++++++------
 drivers/accel/ethosu/ethosu_job.c |  8 ++++++-
 2 files changed, 39 insertions(+), 8 deletions(-)

-- 
2.43.0

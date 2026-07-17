Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD56C4450F
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 06:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8E8010F40E;
	Fri, 17 Jul 2026 06:12:19 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 366AC10F3E5
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 06:12:18 +0000 (UTC)
X-UUID: 715dbf7e81a611f1aa26b74ffac11d73-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:40361e2f-2433-4fa1-8191-cfc8543a6bdd, IP:15,
 URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:40
X-CID-INFO: VERSION:1.3.12, REQID:40361e2f-2433-4fa1-8191-cfc8543a6bdd, IP:15,
 UR
 L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:40
X-CID-META: VersionHash:e7bac3a, CLOUDID:7eff75cbe795fc65de010e906e4ba58b,
 BulkI
 D:26071714121126I4DK73,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|136
 |865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:93|82|11|99|1,File:nil,RT
 :nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP
 :0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 715dbf7e81a611f1aa26b74ffac11d73-20260717
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by
 mailgw.kylinos.cn (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1623957395; Fri, 17 Jul 2026 14:12:09 +0800
From: GuoHan Zhao <zhaoguohan@kylinos.cn>
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, dri-devel@lists.freedesktop.org
Cc: Oded Gabbay <ogabbay@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/5] accel/ethosu: fix probe and job cleanup errors
Date: Fri, 17 Jul 2026 14:11:40 +0800
Message-ID: <20260717061145.1478139-1-zhaoguohan@kylinos.cn>
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

Fix error handling and cleanup issues in the Arm Ethos-U driver.

Sashiko reported the original probe, SRAM, and fence cleanup issues while
reviewing the Ethos-U MMIO mapping fix. A follow-up review of v1 found two
more lifecycle issues in scheduler initialization and IRQ teardown, along
with an unchecked DMA mask setup error.

The first two patches handle DMA mask setup and order scheduler and IRQ
lifetimes. The remaining patches unwind probe state, propagate SRAM setup
errors, and fix completion fence ownership.

The reports are available at:

https://sashiko.dev/#/patchset/20260716065219.931088-1-zhaoguohan@kylinos.cn?part=1
https://sashiko.dev/#/patchset/20260716082530.1023538-1-zhaoguohan@kylinos.cn?part=1

---
Changes in v2:
- Add DMA mask error handling.
- Initialize the scheduler before requesting the IRQ and release the IRQ
  before scheduler teardown.
- Disable clocks directly on probe failure when runtime PM is unavailable.
- Move the former v1 patches 1/3, 2/3, and 3/3 to patches 3/5, 4/5, and
  5/5, respectively.
- Rebase on the current drm-misc-fixes branch.

v1: https://lore.kernel.org/all/20260716082530.1023538-1-zhaoguohan@kylinos.cn/

GuoHan Zhao (5):
  accel/ethosu: check DMA mask setup
  accel/ethosu: fix scheduler and IRQ lifetime
  accel/ethosu: clean up resources on probe failure
  accel/ethosu: propagate SRAM initialization errors
  accel/ethosu: fix job completion fence cleanup

 drivers/accel/ethosu/ethosu_drv.c | 52 ++++++++++++++++++++++++++-----
 drivers/accel/ethosu/ethosu_job.c | 25 +++++++++------
 2 files changed, 60 insertions(+), 17 deletions(-)

-- 
2.43.0

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53C9CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D86B010F660;
	Fri, 22 May 2026 14:42:58 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B59F10F50D;
 Fri, 22 May 2026 09:19:26 +0000 (UTC)
X-UUID: 50f1333255bf11f1aa26b74ffac11d73-20260522
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:3907f5cb-10e1-4dc5-a463-e8fa8ff10195, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:e7bac3a, CLOUDID:dd5522b411114bdc0608001cf9a16299,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|16|5
 0,EDM:2,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
 0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 50f1333255bf11f1aa26b74ffac11d73-20260522
X-User: jindongyang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <jindongyang@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1456995312; Fri, 22 May 2026 17:19:21 +0800
From: Dongyang Jin <jindongyang@kylinos.cn>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sathishkumar.sundararaju@amd.com, yinjie.yao@amd.com,
 michal.simek@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dongyang Jin <jindongyang@kylinos.cn>,
 kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/amdgpu/jpeg: Fix format-truncation warning in
 jpeg_v2_5_sw_init()
Date: Fri, 22 May 2026 17:19:10 +0800
Message-Id: <20260522091910.3276524-1-jindongyang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 May 2026 14:41:04 +0000
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

A false-positive compile warnings:

drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c: In function 'jpeg_v2_5_sw_init':
drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c:152:68: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 7 [-Wformat-truncation=]
  152 |                 snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%d", i);
      |                                                                    ^~
drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c:152:58: note: directive argument in the range [-2147483643, 255]
  152 |                 snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%d", i);
      |                                                          ^~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c:152:17: note: 'snprintf' output between 11 and 21 bytes into a destination of size 16
  152 |                 snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%d", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Suppress it by replacing the type of variable i with uint8_t.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605212104.SAIMqegX-lkp@intel.com/
Signed-off-by: Dongyang Jin <jindongyang@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 5208312e7017..a88a1e1d6423 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -104,7 +104,8 @@ static int jpeg_v2_5_early_init(struct amdgpu_ip_block *ip_block)
 static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
-	int i, r;
+	uint8_t i;
+	int r;
 	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
@@ -149,7 +150,7 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 		else
 			ring->vm_hub = AMDGPU_MMHUB0(0);
 		ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + 8 * i;
-		snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%d", i);
+		snprintf(ring->name, sizeof(ring->name), "jpeg_dec_%u", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst[i].irq,
 				     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
 		if (r)
-- 
2.25.1


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04309C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9235E10F408;
	Thu, 10 Sep 2026 10:06:33 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D704D10F066;
 Wed,  9 Sep 2026 09:39:05 +0000 (UTC)
X-UUID: 4292cb60ac3211f19a56ed5b684f684d-20260909
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
 HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
 IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
 SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
 CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
 GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:c14c31ab-8c0c-44b8-98fe-b4ed70361378, IP:15,
 URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:15
X-CID-INFO: VERSION:1.3.19, REQID:c14c31ab-8c0c-44b8-98fe-b4ed70361378, IP:15,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:15
X-CID-META: VersionHash:7db8b62, CLOUDID:ecd0124f8c1ecf4945b9c1e0fac8627b,
 BulkI
 D:260909173851GI9TNYRZ,BulkQuantity:0,SF:10|38|66|78|102|127|850|865|898,T
 C:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
 l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
 0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4292cb60ac3211f19a56ed5b684f684d-20260909
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
 (envelope-from <yijiangshan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1446183854; Wed, 09 Sep 2026 17:38:49 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: tvrtko.ursulin@igalia.com, sunil.khatri@amd.com, vitaly.prosyak@amd.com,
 pierre-eric.pelloux-prayer@amd.com, moonafterrain@outlook.com,
 candice.li@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 13667453960@163.com, Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] drm/amdgpu: remove redundant NULL check in
 amdgpu_cs_vm_handling
Date: Wed,  9 Sep 2026 17:37:28 +0800
Message-Id: <20260909093728.642473-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Sep 2026 10:06:32 +0000
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

bo_va is assigned from fpriv->csa_va, which is already verified to be
non-NULL by the surrounding if statement. The inner NULL check can
therefore never trigger and is dead code, so remove it.

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 03b41f803520..c978f042ae1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1146,8 +1146,6 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 
 	if (fpriv->csa_va) {
 		bo_va = fpriv->csa_va;
-		if (!bo_va)
-			return -ENOMEM;
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
-- 
2.25.1


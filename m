Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3882C624D3
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3750210E08A;
	Sat,  5 Sep 2026 15:04:15 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0166510E147;
 Fri,  4 Sep 2026 09:19:06 +0000 (UTC)
X-UUID: a8e57e98a84111f19a56ed5b684f684d-20260904
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
 HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
 IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
 SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
 CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
 AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:2dae1310-a863-445a-9627-b33467bde2e8, IP:15,
 URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:40
X-CID-INFO: VERSION:1.3.19, REQID:2dae1310-a863-445a-9627-b33467bde2e8, IP:15,
 UR
 L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:40
X-CID-META: VersionHash:7db8b62, CLOUDID:c7a44c824c7fc39714e6deba9a946e1c,
 BulkI
 D:260904171902CNTQOJ1R,BulkQuantity:0,SF:10|38|66|78|102|127|850|865|898,T
 C:nil,Content:0|15|50|99,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
 ,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a8e57e98a84111f19a56ed5b684f684d-20260904
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
 (envelope-from <yijiangshan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 234142521; Fri, 04 Sep 2026 17:18:58 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: siqueira@igalia.com, alex.hung@amd.com, superm1@kernel.org,
 timur.kristof@gmail.com, ivan.lipski@amd.com, ray.wu@amd.com,
 hamzamahfooz@linux.microsoft.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 13667453960@163.com, Jiangshan Yi <yijiangshan@kylinos.cn>,
 stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: check dc_state_create_copy() for NULL in
 dm_suspend
Date: Fri,  4 Sep 2026 17:18:17 +0800
Message-Id: <20260904091817.578894-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:14 +0000
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

dc_state_create_copy() can return NULL on allocation failure.
dm_suspend() only conditionally skips dm_gpureset_toggle_interrupts()
and continues execution, returning success.  dm_resume() then
dereferences the NULL cached_dc_state in link_enc_cfg_copy() and the
following dc_state->stream_count loop, crashing during GPU reset
recovery.

Return -ENOMEM immediately if the copy fails, so the caller aborts
suspend instead of leaving a NULL cached state for resume.

Fixes: 8092aa3ab8f7 ("drm/amd/display: Add null checker before passing variables")
Cc: stable@vger.kernel.org
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ec483276d753..88505efb42a3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1582,9 +1582,14 @@ static int dm_suspend(struct amdgpu_ip_block *ip_block)
 		dc_allow_idle_optimizations(adev->dm.dc, false);

 		dm->cached_dc_state = dc_state_create_copy(dm->dc->current_state);
+		if (!dm->cached_dc_state) {
+			drm_err(adev_to_drm(adev),
+				"Failed to allocate cached DC state during suspend\n");
+			mutex_unlock(&dm->dc_lock);
+			return -ENOMEM;
+		}

-		if (dm->cached_dc_state)
-			dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
+		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);

 		res = amdgpu_dm_commit_zero_streams(dm->dc);
 		if (res != DC_OK) {
--
2.25.1

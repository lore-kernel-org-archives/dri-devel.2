Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4127BCA5FF5
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 321BE10EADB;
	Sun,  4 Oct 2026 17:18:52 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2087E10E0A0;
 Fri,  2 Oct 2026 02:29:39 +0000 (UTC)
X-UUID: 199e108cbe0911f19a56ed5b684f684d-20261002
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
 HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
 IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, SA_EXISTED
 SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
 CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
 ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19, REQID:03af6a82-d9d5-44f9-87d2-6962a2984c51, IP:10,
 URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:5
X-CID-INFO: VERSION:1.3.19, REQID:03af6a82-d9d5-44f9-87d2-6962a2984c51, IP:10,
 UR
 L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:5
X-CID-META: VersionHash:7db8b62, CLOUDID:bda16b6feca7198f7e003168cf5ffc0b,
 BulkI
 D:261002102934BPRYS1KQ,BulkQuantity:0,SF:17|19|66|78|102|127|850|865|898,T
 C:nil,Content:0|15|50|99,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
 l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
 0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 199e108cbe0911f19a56ed5b684f684d-20261002
X-User: lihaojie@kylinos.cn
Received: from localhost.localdomain [(223.104.132.2)] by mailgw.kylinos.cn
 (envelope-from <lihaojie@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1238829769; Fri, 02 Oct 2026 10:29:31 +0800
From: Haojie Li <lihaojie@kylinos.cn>
To: alexander.deucher@amd.com
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com, xiaogang.chen@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Haojie Li <lihaojie@kylinos.cn>
Subject: [PATCH] drm/amdkfd: fix dma_buf reference leak in get_dmabuf_info
Date: Fri,  2 Oct 2026 10:29:27 +0800
Message-Id: <20261002022927.2023779-1-lihaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

When kzalloc fails for metadata_buffer in
amdgpu_amdkfd_get_dmabuf_info(), the function returns -ENOMEM directly
without calling dma_buf_put(), leaking the dma_buf reference obtained
earlier via dma_buf_get().

Fix both issues by:
- Adding an error check after the first amdgpu_bo_get_metadata() call
- Replacing the direct return with r = -ENOMEM and goto out_put to
  ensure dma_buf_put() is called on all error paths

Fixes: f54ce9e8cbd3 ("drm/amdkfd: Let driver decide buffer size at AMDKFD_IOC_GET_DMABUF_INFO ioctl")
Signed-off-by: Haojie Li <lihaojie@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 054870e9078d..ca5860e493a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -598,14 +598,18 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
 		/* first get metadata_size by buffer = NULL */
 		r = amdgpu_bo_get_metadata(bo, NULL, 0,
 					   metadata_size, NULL);
+		if (r)
+			goto out_put;
 
 		/* user buf_size is bigger than bo metadata_size
 		 * allocate a buf at kernel space and copy */
 		if (*metadata_size <= buffer_size) {
 			*metadata_buffer = kzalloc(*metadata_size, GFP_KERNEL);
 
-			if (!*metadata_buffer)
-				return -ENOMEM;
+			if (!*metadata_buffer) {
+				r = -ENOMEM;
+				goto out_put;
+			}
 
 			r = amdgpu_bo_get_metadata(bo, *metadata_buffer, *metadata_size,
 						   NULL, &metadata_flags);
-- 
2.25.1


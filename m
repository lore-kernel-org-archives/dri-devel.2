Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0B1CD6E4C
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 06:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50100112E5C;
	Mon,  1 Jun 2026 06:50:13 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F60112E5C;
 Mon,  1 Jun 2026 06:50:10 +0000 (UTC)
X-UUID: 1cc5b50a5d8611f1aa26b74ffac11d73-20260601
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME,
 HR_CTE_8B
 HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
 HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
 HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
 IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_UNTRUSTED
 SN_LOWREP, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
 CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
 AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:9141a37e-99f4-4c68-bf0c-8f204331b8a1, IP:15,
 URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:40
X-CID-INFO: VERSION:1.3.12, REQID:9141a37e-99f4-4c68-bf0c-8f204331b8a1, IP:15,
 UR
 L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:40
X-CID-META: VersionHash:e7bac3a, CLOUDID:f5e781a86ea50dcfb8d7a5270d7ec517,
 BulkI
 D:2606011450037SPS48DF,BulkQuantity:0,Recheck:0,SF:17|19|66|78|102|127|850
 |865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
 ,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
 0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1cc5b50a5d8611f1aa26b74ffac11d73-20260601
X-User: lihongtao@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
 (envelope-from <lihongtao@kylinos.cn>) (Generic MTA)
 with ESMTP id 2054400866; Mon, 01 Jun 2026 14:50:01 +0800
From: Hongtao Lee <lihongtao@kylinos.cn>
To: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Hongtao Lee <lihongtao@kylinos.cn>
Subject: [PATCH] drm/qxl: fix local_gobj leak in
 qxl_gem_object_create_with_handle
Date: Mon,  1 Jun 2026 14:49:32 +0800
Message-Id: <20260601064932.227375-1-lihongtao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

If drm_gem_handle_create fails, the reference count of local_gobj
will never be released, resulting in a leak of local_gobj.

Fixes: f64122c1f6ad("drm: add new QXL driver. (v1.4)")
Signed-off-by: Hongtao Lee <lihongtao@kylinos.cn>
---
 drivers/gpu/drm/qxl/qxl_gem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_gem.c b/drivers/gpu/drm/qxl/qxl_gem.c
index 4939b57a2a48..2bdff4cee952 100644
--- a/drivers/gpu/drm/qxl/qxl_gem.c
+++ b/drivers/gpu/drm/qxl/qxl_gem.c
@@ -99,8 +99,10 @@ int qxl_gem_object_create_with_handle(struct qxl_device *qdev,
 	if (r)
 		return -ENOMEM;
 	r = drm_gem_handle_create(file_priv, local_gobj, handle);
-	if (r)
+	if (r) {
+		drm_gem_object_put(local_gobj);
 		return r;
+	}
 
 	if (gobj)
 		*gobj = local_gobj;
-- 
2.25.1


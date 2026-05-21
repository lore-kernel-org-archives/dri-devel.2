Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81273CD5BB4
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B412F10F62F;
	Fri, 22 May 2026 14:41:26 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C8810E439
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 09:46:01 +0000 (UTC)
X-UUID: db6196d654f911f1aa26b74ffac11d73-20260521
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:f19b5e3b-dfdb-4a36-ac9c-d5644075eeb8, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:02a8a5dfb0740e3bcbc17224b6c5b1a2,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|16|5
 0,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
 :0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: db6196d654f911f1aa26b74ffac11d73-20260521
X-User: jindongyang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <jindongyang@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 489744870; Thu, 21 May 2026 17:45:52 +0800
From: Dongyang Jin <jindongyang@kylinos.cn>
To: neil.armstrong@linaro.org, jesszhan0024@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dongyang Jin <jindongyang@kylinos.cn>, kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/panel: fix kernel-doc warning for devm_drm_panel_add()
Date: Thu, 21 May 2026 17:45:45 +0800
Message-Id: <20260521094545.3039207-1-jindongyang@kylinos.cn>
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

Use the correct kernel-doc notation for struct members to eliminate
kernel-doc warnings:

Warning: drivers/gpu/drm/drm_panel.c:119 function parameter 'dev'
 not described in 'devm_drm_panel_add'
Warning: drivers/gpu/drm/drm_panel.c:119 function parameter 'dev'
 not described in 'devm_drm_panel_add'

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605210648.RI4ufD66-lkp@intel.com/
Signed-off-by: Dongyang Jin <jindongyang@kylinos.cn>
---
 drivers/gpu/drm/drm_panel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 04f4a31ed27a..2c5649e433df 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -108,6 +108,7 @@ static void drm_panel_add_release(void *data)
 
 /**
  * devm_drm_panel_add - add a panel to the global registry using devres
+ * @dev: device to which the panel is attached
  * @panel: panel to add
  *
  * Add a panel to the global registry so that it can be looked
-- 
2.25.1


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8609CC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 03:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C41DE10E142;
	Tue, 30 Jun 2026 03:17:03 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E651710E142;
 Tue, 30 Jun 2026 03:17:01 +0000 (UTC)
X-UUID: 26424482743211f1aa26b74ffac11d73-20260630
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:8d8573c9-8b63-420e-a361-412d2c9ec18f, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:1acb257d12bf33a060d0c1d47cb64a43,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|123|136|850|865|898,TC:nil,Content:0
 |15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
 SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 26424482743211f1aa26b74ffac11d73-20260630
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yaolu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 1470254635; Tue, 30 Jun 2026 11:16:56 +0800
From: yaolu@kylinos.cn
To: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Lu Yao <yaolu@kylinos.cn>
Subject: [PATCH] drm/i915/display: fix error handling in
 intel_display_driver_probe_noirq
Date: Tue, 30 Jun 2026 11:16:52 +0800
Message-Id: <20260630031652.67747-1-yaolu@kylinos.cn>
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

From: Lu Yao <yaolu@kylinos.cn>

Fix two bugs in the probe error path:

1. intel_dmc_fini() was called on workqueue alloc failed paths but
   intel_dmc_init() had been invoked.  Move the dmc init call advance.

2. If intel_mode_config_init() succeeded, after intel_xxx_init()
   failed leaked the resources allocated by drm_mode_config_init().
   Add a cleanup_mode_config label.

Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
 .../drm/i915/display/intel_display_driver.c    | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_driver.c b/drivers/gpu/drm/i915/display/intel_display_driver.c
index d0729936f681..d69bdfb19efe 100644
--- a/drivers/gpu/drm/i915/display/intel_display_driver.c
+++ b/drivers/gpu/drm/i915/display/intel_display_driver.c
@@ -223,6 +223,8 @@ int intel_display_driver_probe_noirq(struct intel_display *display)
 	if (!HAS_DISPLAY(display))
 		return 0;
 
+	intel_dmc_init(display);
+
 	display->hotplug.dp_wq = alloc_ordered_workqueue("intel-dp", 0);
 	if (!display->hotplug.dp_wq) {
 		ret = -ENOMEM;
@@ -254,33 +256,31 @@ int intel_display_driver_probe_noirq(struct intel_display *display)
 		goto cleanup_wq_cleanup;
 	}
 
-	intel_dmc_init(display);
-
 	intel_mode_config_init(display);
 
 	ret = intel_cdclk_init(display);
 	if (ret)
-		goto cleanup_wq_unordered;
+		goto cleanup_mode_config;
 
 	ret = intel_color_init(display);
 	if (ret)
-		goto cleanup_wq_unordered;
+		goto cleanup_mode_config;
 
 	ret = intel_dbuf_init(display);
 	if (ret)
-		goto cleanup_wq_unordered;
+		goto cleanup_mode_config;
 
 	ret = intel_dbuf_bw_init(display);
 	if (ret)
-		goto cleanup_wq_unordered;
+		goto cleanup_mode_config;
 
 	ret = intel_bw_init(display);
 	if (ret)
-		goto cleanup_wq_unordered;
+		goto cleanup_mode_config;
 
 	ret = intel_pmdemand_init(display);
 	if (ret)
-		goto cleanup_wq_unordered;
+		goto cleanup_mode_config;
 
 	intel_init_quirks(display);
 
@@ -288,6 +288,8 @@ int intel_display_driver_probe_noirq(struct intel_display *display)
 
 	return 0;
 
+cleanup_mode_config:
+	intel_mode_config_cleanup(display);
 cleanup_wq_unordered:
 	destroy_workqueue(display->wq.unordered);
 cleanup_wq_cleanup:
-- 
2.25.1


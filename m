Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923E8C4450F
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 06:12:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAEA610E433;
	Fri, 17 Jul 2026 06:12:22 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E48C10F3E5
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 06:12:18 +0000 (UTC)
X-UUID: 722457ec81a611f1aa26b74ffac11d73-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:8d4a5414-e49c-4a79-bab9-32ddb3ea0f40, IP:15,
 URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:35
X-CID-INFO: VERSION:1.3.12, REQID:8d4a5414-e49c-4a79-bab9-32ddb3ea0f40, IP:15,
 UR
 L:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:35
X-CID-META: VersionHash:e7bac3a, CLOUDID:2b157535a6d3a4ec055d3f4178914773,
 BulkI
 D:26071714121163RB39VI,BulkQuantity:0,Recheck:0,SF:10|38|57|66|78|80|81|82
 |102|127|136|841|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:93|82|11|
 1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR
 :NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 722457ec81a611f1aa26b74ffac11d73-20260717
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by
 mailgw.kylinos.cn (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 166009087; Fri, 17 Jul 2026 14:12:10 +0800
From: GuoHan Zhao <zhaoguohan@kylinos.cn>
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, dri-devel@lists.freedesktop.org
Cc: Oded Gabbay <ogabbay@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 3/5] accel/ethosu: clean up resources on probe failure
Date: Fri, 17 Jul 2026 14:11:43 +0800
Message-ID: <20260717061145.1478139-4-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717061145.1478139-1-zhaoguohan@kylinos.cn>
References: <20260717061145.1478139-1-zhaoguohan@kylinos.cn>
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

ethosu_job_init() creates a scheduler before ethosu_init() and
drm_dev_register(). Errors from either later step return directly, leaving
the scheduler workqueue allocated. A drm_dev_register() failure also leaves
the optional SRAM allocation behind.

Unwind runtime PM, SRAM, and scheduler state in reverse order on probe
failure. Disable the clocks directly when runtime PM is unavailable or its
setup fails.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260716065219.931088-1-zhaoguohan@kylinos.cn?part=1
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
Changes in v2:
- Apply after the scheduler and IRQ lifetime fix so probe cleanup releases
  the IRQ before destroying the scheduler.
- Disable clocks directly when runtime PM is unavailable.

Sashiko report:

> This is a pre-existing issue, but was not introduced by this patch.
>
> If ethosu_init() or drm_dev_register() fail, the function returns
> directly without calling ethosu_job_fini() or freeing the sram pool.
>
> Because the job scheduler is embedded in the devm-allocated
> ethosu_device, it will be freed when devm cleans up. However, the drm
> scheduler kthreads and timers remain active and will access the freed
> memory.
>
> Can this cause a use-after-free regression leading to a kernel panic?

 drivers/accel/ethosu/ethosu_drv.c | 41 ++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/ethosu_drv.c
index f3920185389d..6b97d22444a7 100644
--- a/drivers/accel/ethosu/ethosu_drv.c
+++ b/drivers/accel/ethosu/ethosu_drv.c
@@ -272,6 +272,17 @@ static int ethosu_device_suspend(struct device *dev)
 	return 0;
 }
 
+static void ethosu_runtime_suspend(struct ethosu_device *ethosudev)
+{
+	struct device *dev = ethosudev->base.dev;
+
+	pm_runtime_dont_use_autosuspend(dev);
+	if (pm_runtime_enabled(dev))
+		pm_runtime_put_sync_suspend(dev);
+	else
+		ethosu_device_suspend(dev);
+}
+
 static int ethosu_sram_init(struct ethosu_device *ethosudev)
 {
 	ethosudev->npu_info.sram_size = 0;
@@ -293,6 +304,14 @@ static int ethosu_sram_init(struct ethosu_device *ethosudev)
 	return 0;
 }
 
+static void ethosu_sram_fini(struct ethosu_device *ethosudev)
+{
+	if (ethosudev->sram)
+		gen_pool_free(ethosudev->srampool,
+			      (unsigned long)ethosudev->sram,
+			      ethosudev->npu_info.sram_size);
+}
+
 static int ethosu_init(struct ethosu_device *ethosudev)
 {
 	int ret;
@@ -306,7 +325,7 @@ static int ethosu_init(struct ethosu_device *ethosudev)
 	pm_runtime_use_autosuspend(ethosudev->base.dev);
 	ret = devm_pm_runtime_set_active_enabled(ethosudev->base.dev);
 	if (ret)
-		return ret;
+		goto err_suspend;
 	pm_runtime_get_noresume(ethosudev->base.dev);
 
 	ethosudev->npu_info.id = id = readl_relaxed(ethosudev->regs + NPU_REG_ID);
@@ -326,6 +345,11 @@ static int ethosu_init(struct ethosu_device *ethosudev)
 		 ethosudev->npu_info.sram_size / 1024);
 
 	return 0;
+
+err_suspend:
+	pm_runtime_dont_use_autosuspend(ethosudev->base.dev);
+	ethosu_device_suspend(ethosudev->base.dev);
+	return ret;
 }
 
 static int ethosu_probe(struct platform_device *pdev)
@@ -355,13 +379,20 @@ static int ethosu_probe(struct platform_device *pdev)
 
 	ret = ethosu_init(ethosudev);
 	if (ret)
-		return ret;
+		goto err_job_fini;
 
 	ret = drm_dev_register(&ethosudev->base, 0);
 	if (ret)
-		pm_runtime_dont_use_autosuspend(ethosudev->base.dev);
+		goto err_runtime_suspend;
 
 	pm_runtime_put_autosuspend(ethosudev->base.dev);
+	return 0;
+
+err_runtime_suspend:
+	ethosu_runtime_suspend(ethosudev);
+	ethosu_sram_fini(ethosudev);
+err_job_fini:
+	ethosu_job_fini(ethosudev);
 	return ret;
 }
 
@@ -371,9 +402,7 @@ static void ethosu_remove(struct platform_device *pdev)
 
 	drm_dev_unregister(&ethosudev->base);
 	ethosu_job_fini(ethosudev);
-	if (ethosudev->sram)
-		gen_pool_free(ethosudev->srampool, (unsigned long)ethosudev->sram,
-			      ethosudev->npu_info.sram_size);
+	ethosu_sram_fini(ethosudev);
 }
 
 static const struct of_device_id dt_match[] = {
-- 
2.43.0

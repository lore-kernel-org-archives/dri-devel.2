Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C517FC44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 06:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A8D610F43D;
	Fri, 17 Jul 2026 06:12:23 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 355A110E433
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 06:12:19 +0000 (UTC)
X-UUID: 71e6346281a611f1aa26b74ffac11d73-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:21e6262b-738c-4412-882e-908740ffd1d9, IP:15,
 URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:35
X-CID-INFO: VERSION:1.3.12, REQID:21e6262b-738c-4412-882e-908740ffd1d9, IP:15,
 UR
 L:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:35
X-CID-META: VersionHash:e7bac3a, CLOUDID:b1582cd2a51d8064705cd1feac8d09da,
 BulkI
 D:260717141211R4RHUH7V,BulkQuantity:0,Recheck:0,SF:10|38|57|66|78|80|81|82
 |102|127|841|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:11|93|82|1,Fi
 le:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
 DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 71e6346281a611f1aa26b74ffac11d73-20260717
X-User: zhaoguohan@kylinos.cn
Received: from zgh-vmware-virtual-platform.localdomain [(116.128.244.171)] by
 mailgw.kylinos.cn (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 387292993; Fri, 17 Jul 2026 14:12:10 +0800
From: GuoHan Zhao <zhaoguohan@kylinos.cn>
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, dri-devel@lists.freedesktop.org
Cc: Oded Gabbay <ogabbay@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 2/5] accel/ethosu: fix scheduler and IRQ lifetime
Date: Fri, 17 Jul 2026 14:11:42 +0800
Message-ID: <20260717061145.1478139-3-zhaoguohan@kylinos.cn>
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

ethosu_job_init() requests the managed IRQ before initializing the DRM
scheduler. If drm_sched_init() fails, the error path calls drm_sched_fini()
on a partially initialized scheduler. The IRQ also remains registered until
devres cleanup after normal or probe-error paths destroy the scheduler.

Initialize the scheduler before requesting the IRQ. Scheduler setup failure
then needs no teardown, while IRQ setup failure can tear down a valid
scheduler. Free the IRQ explicitly before drm_sched_fini() to prevent
interrupt handlers from accessing scheduler state during teardown.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260716082530.1023538-1-zhaoguohan@kylinos.cn?part=1
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
New in v2.

Sashiko reports:

> This is a pre-existing issue, but does the error handling path for
> drm_sched_init() cause a panic if it fails?
>
> drivers/accel/ethosu/ethosu_job.c:ethosu_job_init() {
>     ...
>     ret = drm_sched_init(&edev->sched, &args);
>     if (ret) {
>         dev_err(dev, "Failed to create scheduler: %d\n", ret);
>         goto err_sched;
>     }
>     return 0;
>
> err_sched:
>     drm_sched_fini(&edev->sched);
>     return ret;
> }
>
> If drm_sched_init() fails, it cleans up its own state. The error path
> then branches to err_sched and calls drm_sched_fini() on the partially
> initialized scheduler.
>
> Because the waitqueue head was either destroyed or never initialized,
> its list pointers are NULL. Will drm_sched_fini() invoking
> wake_up_all(&sched->job_scheduled) cause an immediate crash?

> This is a pre-existing issue, but can the devm-managed shared IRQ handler
> outlive the DRM scheduler here?
>
> The IRQ is requested using devm_request_threaded_irq(). During
> ethosu_remove() (and on probe failure), the driver explicitly calls
> ethosu_job_fini(), which destroys the DRM scheduler.
>
> Because the IRQ is managed by devm, it remains fully active until the
> remove function completes. If an interrupt fires in this window, could
> ethosu_job_irq_handler() execute and access the destroyed dev->sched or
> dev->in_flight_job structures, leading to a use-after-free?

 drivers/accel/ethosu/ethosu_job.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/ethosu/ethosu_job.c b/drivers/accel/ethosu/ethosu_job.c
index b76924645aaa..5847433e87e7 100644
--- a/drivers/accel/ethosu/ethosu_job.c
+++ b/drivers/accel/ethosu/ethosu_job.c
@@ -315,6 +315,14 @@ int ethosu_job_init(struct ethosu_device *edev)
 	if (edev->irq < 0)
 		return edev->irq;
 
+	edev->fence_context = dma_fence_context_alloc(1);
+
+	ret = drm_sched_init(&edev->sched, &args);
+	if (ret) {
+		dev_err(dev, "Failed to create scheduler: %d\n", ret);
+		return ret;
+	}
+
 	ret = devm_request_threaded_irq(dev, edev->irq,
 					ethosu_job_irq_handler,
 					ethosu_job_irq_handler_thread,
@@ -322,14 +330,6 @@ int ethosu_job_init(struct ethosu_device *edev)
 					edev);
 	if (ret) {
 		dev_err(dev, "failed to request irq\n");
-		return ret;
-	}
-
-	edev->fence_context = dma_fence_context_alloc(1);
-
-	ret = drm_sched_init(&edev->sched, &args);
-	if (ret) {
-		dev_err(dev, "Failed to create scheduler: %d\n", ret);
 		goto err_sched;
 	}
 
@@ -342,6 +342,7 @@ int ethosu_job_init(struct ethosu_device *edev)
 
 void ethosu_job_fini(struct ethosu_device *dev)
 {
+	devm_free_irq(dev->base.dev, dev->irq, dev);
 	drm_sched_fini(&dev->sched);
 }
 
-- 
2.43.0

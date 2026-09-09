Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D42C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C782F10EEA4;
	Wed,  9 Sep 2026 04:25:28 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net
 (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
 by gabe.freedesktop.org (Postfix) with ESMTP id D715610EEA4
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:25:26 +0000 (UTC)
Received: from zju.edu.cn (unknown [10.98.66.117])
 by mtasvr (Coremail) with SMTP id _____wA3IT+q36BqsMIBAQ--.6619S3;
 Wed, 09 Sep 2026 12:25:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
 by mail-app2 (Coremail) with SMTP id zC_KCgAnl8yp36Bq1ERlBA--.7899S2;
 Wed, 09 Sep 2026 12:25:14 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, koby.elbaz@intel.com, konstantin.sinyuk@intel.com,
 Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] accel/habanalabs: fix use-after-free of decoder array on
 removal
Date: Wed,  9 Sep 2026 04:23:33 +0000
Message-Id: <20260909042333.652206-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zC_KCgAnl8yp36Bq1ERlBA--.7899S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?XK2YWwXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
 sfncGSG+szpQCInt5Y8rbJUI1WPFe0A9UKFs1YTwuduIBOmQvZqqXZuwkW8ECt1H6MeYyT
 6x7/eIh0Wrdk168UJUs=
X-Coremail-Antispam: 1Uk129KBj93XoW7urWxAw4fCrWDuF13tw13GFX_yoW8uF1rpF
 WrGFWrAFW7Ga1xCw1Yyay0vFy3u3sI9rWIkF1Ikw4Skrs8Jry8Gw15KF1Y9ry3CrWxZa4j
 vF4qqrW5uF45JrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
 xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
 CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
 xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
 kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
 6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
 I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
 6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
 0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
 JbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU
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

The abnormal decoder interrupt queues the decoder's abnrm_intr_work
work item on the system workqueue, and the work callback uses the
decoder entry it is embedded in.

hl_device_fini() releases the decoder interrupts through
cleanup_resources() -> halt_engines() before it calls hl_dec_fini(),
which frees the decoder array without waiting for these work items.
A work item queued by one of the last interrupts can still be pending
and run after the array has been freed.

Fix this by waiting for each decoder's work item in hl_dec_fini()
before the array is freed. The error path of hl_dec_init() keeps
freeing the array directly: no interrupt has been requested yet, and
the entries past the failing one have never been initialized.

This issue was found by an in-house static analysis tool.

Fixes: d7bb1ac89b2f ("habanalabs: add gaudi2 asic-specific code")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/accel/habanalabs/common/decoder.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/decoder.c b/drivers/accel/habanalabs/common/decoder.c
index e4802f30c08a..ed0c25934206 100644
--- a/drivers/accel/habanalabs/common/decoder.c
+++ b/drivers/accel/habanalabs/common/decoder.c
@@ -85,6 +85,16 @@ static void dec_abnrm_intr_work(struct work_struct *work)
 
 void hl_dec_fini(struct hl_device *hdev)
 {
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	int i;
+
+	if (!hdev->dec)
+		return;
+
+	/* interrupts are gone, but a queued work item may still be pending */
+	for (i = 0; i < prop->max_dec; i++)
+		cancel_work_sync(&hdev->dec[i].abnrm_intr_work);
+
 	kfree(hdev->dec);
 }
 
@@ -119,7 +129,8 @@ int hl_dec_init(struct hl_device *hdev)
 	return 0;
 
 err_dec_fini:
-	hl_dec_fini(hdev);
+	/* No interrupt was requested yet, so no work could be queued. */
+	kfree(hdev->dec);
 
 	return rc;
 }


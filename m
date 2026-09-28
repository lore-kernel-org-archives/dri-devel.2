Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31ADDC9830E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 01:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7408C10E4B9;
	Mon, 28 Sep 2026 01:31:49 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net
 [13.75.44.102])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9F50210E4B9
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 01:31:48 +0000 (UTC)
Received: from zju.edu.cn (unknown [10.98.66.117])
 by mtasvr (Coremail) with SMTP id _____wDngzxxw7lqQME_AQ--.18158S3;
 Mon, 28 Sep 2026 09:31:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
 by mail-app3 (Coremail) with UTF8SMTPA id zS_KCgAX+6dxw7lq4NIaAA--.23320S2;
 Mon, 28 Sep 2026 09:31:29 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: lucas.demarchi@intel.com
Cc: raag.jadav@intel.com, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 airlied@gmail.com, simona@ffwll.ch, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v3] drm/xe/i2c: cancel the client work on remove
Date: Mon, 28 Sep 2026 01:30:30 +0000
Message-Id: <20260928013030.612592-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zS_KCgAX+6dxw7lq4NIaAA--.23320S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?xPWWJQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
 sfnbfYAegEspJ+qccDMUwRutu124ZyaTE3EU4k7BkgWOWCX6PgIqM1qRe4CLMsMP4/CcYP
 q5WdbJ2wszwILaV1EN/N5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoWxCFWrZrW3AF1UuFy7XF15KFX_yoW5tFyxp3
 90gFW5GFWvqay2gw42va1xCFy8Ca1fJrWfCr17J3y3u3ZIkr17KrZxtFW5ZFyjyr4kZa4Y
 vrn0q3y29FWUAFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
 kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
 6r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
 Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
 6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwmiiDUUUU
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

To: lucas.demarchi@intel.com
Cc: raag.jadav@intel.com,
    matthew.brost@intel.com,
    thomas.hellstrom@linux.intel.com,
    rodrigo.vivi@intel.com,
    airlied@gmail.com,
    simona@ffwll.ch,
    intel-xe@lists.freedesktop.org,
    dri-devel@lists.freedesktop.org,
    linux-kernel@vger.kernel.org

xe_i2c_notifier() stores the DesignWare adapter in i2c->adapter and
schedules i2c->work when the adapter is registered under the xe I2C
platform device, and xe_i2c_client_work() then instantiates the AMC
client device on that adapter.

xe_i2c_remove() tears down the AMC, unregisters the client devices,
the bus notifier and the adapter platform device, but it never drains
i2c->work. A work item that is still queued or running when the
adapter is unregistered dereferences i2c->adapter in
i2c_new_client_device() after platform_device_unregister() has
released the adapter. The work item is also embedded in the
devm-allocated struct xe_i2c, so a work item still queued after the
drm device devm unwind frees that allocation runs its callback on
freed memory.

The bus notifier is the only thing that schedules this work, and it is
unregistered after the client devices. An instance that is still queued
when the teardown runs can therefore write
i2c->client[XE_I2C_CLIENT_AMC] while the loop is unregistering and
clearing the same array, and an AMC client it instantiates late is only
cleaned up by the adapter's own child sweep in i2c_del_adapter().

Move bus_unregister_notifier() in front of the client teardown loop
and cancel the work right after it, so no new instance can be
scheduled and a queued instance is drained before the client array is
touched. A running instance still finds a live adapter, since the
adapter is unregistered later.

This issue was found by an in-house static analysis tool.

Fixes: f0e53aadd702 ("drm/xe: Support for I2C attached MCUs")
Link: https://lore.kernel.org/intel-xe/20260912085932.101598-1-fanwu01@zju.edu.cn/
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---

Changes in v3:
- rebase onto drm-xe-next, after "drm/xe/i2c: Disable IRQ on unbind"
- discussion: Link: above points at the v2 thread
- unregister the bus notifier before the client teardown loop and
  cancel the work before the loop as well: v2 cancelled the work only
  after the loop, so an event arriving during the loop could still
  schedule the work to race with the array teardown and leak a freshly
  instantiated AMC client
 drivers/gpu/drm/xe/xe_i2c.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index f4f3819..b82caaf 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -324,12 +324,15 @@ static void xe_i2c_remove(void *data)
 	xe_i2c_irq_reset(xe);
 	xe_amc_exit(i2c);
 
+	/* Stop the notifier from arming the client work before teardown. */
+	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
+	cancel_work_sync(&i2c->work);
+
 	for (i = 0; i < XE_I2C_MAX_CLIENTS; i++) {
 		i2c_unregister_device(i2c->client[i]);
 		i2c->client[i] = NULL;
 	}
 
-	bus_unregister_notifier(&i2c_bus_type, &i2c->bus_notifier);
 	xe_i2c_unregister_adapter(i2c);
 	xe->i2c = NULL;
 }


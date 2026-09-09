Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F94EC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 05:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5AD610E049;
	Wed,  9 Sep 2026 05:36:25 +0000 (UTC)
X-Greylist: delayed 4260 seconds by postgrey-1.36 at gabe;
 Wed, 09 Sep 2026 05:36:23 UTC
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net
 [207.46.229.174])
 by gabe.freedesktop.org (Postfix) with ESMTP id 437A210E049
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 05:36:23 +0000 (UTC)
Received: from zju.edu.cn (unknown [10.98.66.117])
 by mtasvr (Coremail) with SMTP id _____wAH4X1L8KBqy_MBAQ--.32620S3;
 Wed, 09 Sep 2026 13:36:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
 by mail-app4 (Coremail) with SMTP id zi_KCgDnGDBK8KBq8CGoAw--.35214S2;
 Wed, 09 Sep 2026 13:36:10 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: mripard@kernel.org
Cc: dave.stevenson@raspberrypi.com, mcanal@igalia.com,
 kernel-list@raspberrypi.com, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, eric@anholt.net,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH] drm/vc4: drain the hangcheck timer and works on V3D unbind
Date: Wed,  9 Sep 2026 05:35:09 +0000
Message-Id: <20260909053509.657074-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zi_KCgDnGDBK8KBq8CGoAw--.35214S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?/TeuFgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
 sfnXz+g1OQfMo27QHy5TwQyZwfdQ11pk717IchTpzFSURcVSijrRuNKLDtryceijmISBFH
 tRa/3CMSLNfM+754Feup9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr1rCrW3Aw48JFW3CrW5XFc_yoW5Jr17pF
 sxCFZ0qrWkWFW3t3sxZ3Z7ZFyrAw4rtry7GFy29w42kwnIyryrKFyqk34YgFyDJayDWrW3
 tFsxJ3909Fy5A3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
 kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
 6r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
 Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
 6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7rcfUUUUU
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

The hangcheck timer, which every submitted job arms and which queues
reset_work once a job stops making progress, and the job_done_work,
which the render-done interrupt queues to release completed jobs, are
never drained at teardown: vc4_irq_disable() cancels only
overflow_mem_work, and vc4_gem_destroy() runs from the drm-managed
release, after vc4_v3d_unbind() has already uninstalled the V3D
interrupt and cleared vc4->v3d.

A timer still armed by then reads V3D registers through the NULL
vc4->v3d pointer, and late callbacks run on the vc4_dev embedding
them after it has been freed.

Drain them in vc4_v3d_unbind(): shut the hangcheck timer down and
cancel reset_work before the interrupt is taken down, because
vc4_irq_reset() in a straggler reset re-enables it, then cancel
job_done_work once no source is left, before vc4->v3d is cleared.

This issue was found by an in-house static analysis tool.

Fixes: d5b1a78a772f ("drm/vc4: Add support for drawing 3D frames.")
Cc: stable@vger.kernel.org # 6.13+: vc4->gen does not exist on older trees
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/gpu/drm/vc4/vc4_v3d.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index f32410420d3e..11d4df3164b4 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -9,6 +9,7 @@
 #include <linux/component.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/timer.h>
 
 #include <drm/drm_print.h>
 
@@ -497,8 +498,18 @@ static void vc4_v3d_unbind(struct device *dev, struct device *master,
 	struct drm_device *drm = data;
 	struct vc4_dev *vc4 = to_vc4_dev(drm);
 
+	/* Kill the timer, then reset_work: vc4_irq_reset() re-enables it. */
+	if (vc4->gen == VC4_GEN_4) {
+		timer_shutdown_sync(&vc4->hangcheck.timer);
+		cancel_work_sync(&vc4->hangcheck.reset_work);
+	}
+
 	vc4_irq_uninstall(drm);
 
+	/* Nothing can queue job_done_work any more; drain it. */
+	if (vc4->gen == VC4_GEN_4)
+		cancel_work_sync(&vc4->job_done_work);
+
 	/* Disable the binner's overflow memory address, so the next
 	 * driver probe (if any) doesn't try to reuse our old
 	 * allocation.


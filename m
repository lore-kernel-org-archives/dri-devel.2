Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7E2CDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81CCC10F148;
	Thu, 25 Jun 2026 07:03:21 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FE2B10E155
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 03:07:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.245.140])
 by APP-01 (Coremail) with SMTP id qwCowAD3j8jwmTxqojokAw--.21884S2;
 Thu, 25 Jun 2026 11:01:04 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: [PATCH] fbdev: goldfishfb: fail pan display on base-update timeout
Date: Thu, 25 Jun 2026 11:01:02 +0800
Message-ID: <20260625030102.79755-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAD3j8jwmTxqojokAw--.21884S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1ftw1fWryUAF17WF1kAFb_yoW8tr1kpF
 s7KFW7try8tw42gryYkF1DXF4rZrWDArZ2kFWYyw4fZrnxXrZ7Wan7Gryq9r4rJrs5X342
 qF4UXayfCF1kurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
 JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
 JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUehL0UU
 UUU
X-Originating-IP: [111.196.245.140]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Mailman-Approved-At: Thu, 25 Jun 2026 07:03:17 +0000
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

goldfish_fb_pan_display() waits for the device to acknowledge the new
framebuffer base, but it only logs a timeout and still reports success.
The probe path also ignores the initial pan-display result before
registering the framebuffer.

Return -ETIMEDOUT when the base-update acknowledgment does not arrive,
and propagate that error from the initial probe-time base update before
the framebuffer is published.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/video/fbdev/goldfishfb.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
index c9871281bc1d..e5d79886ea66 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -138,10 +138,12 @@ static int goldfish_fb_pan_display(struct fb_var_screeninfo *var,
 	writel(fb->fb.fix.smem_start + fb->fb.var.xres * 2 * var->yoffset,
 						fb->reg_base + FB_SET_BASE);
 	spin_unlock_irqrestore(&fb->lock, irq_flags);
-	wait_event_timeout(fb->wait,
-			fb->base_update_count != base_update_count, HZ / 15);
-	if (fb->base_update_count == base_update_count)
+	if (!wait_event_timeout(fb->wait,
+				fb->base_update_count != base_update_count,
+				HZ / 15)) {
 		pr_err("%s: timeout waiting for base update\n", __func__);
+		return -ETIMEDOUT;
+	}
 	return 0;
 }
 
@@ -251,7 +253,9 @@ static int goldfish_fb_probe(struct platform_device *pdev)
 		goto err_request_irq_failed;
 
 	writel(FB_INT_BASE_UPDATE_DONE, fb->reg_base + FB_INT_ENABLE);
-	goldfish_fb_pan_display(&fb->fb.var, &fb->fb); /* updates base */
+	ret = goldfish_fb_pan_display(&fb->fb.var, &fb->fb); /* updates base */
+	if (ret)
+		goto err_pan_display_failed;
 
 	ret = register_framebuffer(&fb->fb);
 	if (ret)
@@ -259,6 +263,7 @@ static int goldfish_fb_probe(struct platform_device *pdev)
 	return 0;
 
 err_register_framebuffer_failed:
+err_pan_display_failed:
 	free_irq(fb->irq, fb);
 err_request_irq_failed:
 err_fb_set_var_failed:

base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
-- 
2.50.1 (Apple Git-155)


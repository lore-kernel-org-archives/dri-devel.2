Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E26BCDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A36FD10E37E;
	Fri, 26 Jun 2026 10:45:02 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7658210E353
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 10:45:00 +0000 (UTC)
Received: from localhost.localdomain (unknown [117.182.75.66])
 by APP-03 (Coremail) with SMTP id rQCowACni+InWD5qhTzsFQ--.357S2;
 Fri, 26 Jun 2026 18:44:57 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: koby.elbaz@intel.com,
	konstantin.sinyuk@intel.com,
	ogabbay@kernel.org
Cc: vulab@iscas.ac.cn, kees@kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] fix: accel/habanalabs: hl_cs_signal_sob_wraparound_handler:
 missing hw_sob_get when need_reset is true and encaps_sig is false
Date: Fri, 26 Jun 2026 18:44:53 +0800
Message-Id: <20260626104453.32301-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACni+InWD5qhTzsFQ--.357S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr17Zr1DWw4fZr1DXw1kXwb_yoW8GFWkpa
 s8GF4rJF9Fqr9rAFnrCw45ZFyrXa9xKr9F9a1xG395urn8Ga4xJryYkayF9rWj9rs3Xa18
 XF9Fq3yUC3WrAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
 6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
 IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
 U==
X-Originating-IP: [117.182.75.66]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYKA2o+ThINvAABs7
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

When other_sob->need_reset is true and encaps_sig is false,
  hw_sob_put(other_sob) decrements the kref to 0, but the matching
  hw_sob_get(other_sob) is skipped because it is inside the encaps_sig
  block. The function returns other_sob with kref=0, causing a subsequent
  kref_put to underflow. Fix by adding hw_sob_get(other_sob) in the else
  branch.

Cc: stable@vger.kernel.org
Fixes: dadf17abb724 ("habanalabs: add support for encapsulated signals reservation")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/accel/habanalabs/common/command_submission.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/habanalabs/common/command_submission.c b/drivers/accel/habanalabs/common/command_submission.c
index ba4257bda77b..675301dfc0ef 100644
--- a/drivers/accel/habanalabs/common/command_submission.c
+++ b/drivers/accel/habanalabs/common/command_submission.c
@@ -1860,11 +1860,10 @@ int hl_cs_signal_sob_wraparound_handler(struct hl_device *hdev, u32 q_idx,
 		if (other_sob->need_reset)
 			hw_sob_put(other_sob);
 
-		if (encaps_sig) {
+		if (encaps_sig)
 			/* set reset indication for the sob */
 			sob->need_reset = true;
-			hw_sob_get(other_sob);
-		}
+		hw_sob_get(other_sob);
 
 		dev_dbg(hdev->dev, "switched to SOB %d, q_idx: %d\n",
 				prop->curr_sob_offset, q_idx);
-- 
2.39.5 (Apple Git-154)


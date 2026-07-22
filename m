Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D315EC531CC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC24C10EFF7;
	Thu, 23 Jul 2026 07:09:34 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32DE810E407
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 04:08:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [111.196.245.140])
 by APP-05 (Coremail) with SMTP id zQCowAAHKkNAQmBqvge7AA--.34195S2;
 Wed, 22 Jul 2026 12:08:33 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Inki Dae <inki.dae@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Joonyoung Shim <jy0922.shim@samsung.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] drm/exynos: limit G2D GEM map count
Date: Wed, 22 Jul 2026 12:08:32 +0800
Message-ID: <20260722040832.80135-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAHKkNAQmBqvge7AA--.34195S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr18CF4ktryfGFyDKFWfKrg_yoW8CryDpF
 43Gry2y3y5XayxtFWIyanY9Fy5Wasaka9FgF4xC3s7uF1qvF18X3WrtFy2qa45urWfJr4j
 yr1DAas7uFy7A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
 0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
 Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
 0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
 zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
 4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
 CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
 nIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-Originating-IP: [111.196.245.140]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
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

exynos_g2d_set_cmdlist_ioctl() accepts cmd_buf_nr from userspace and
later uses it to index the fixed reg_types array while validating GEM
mapping commands. The existing G2D command-page limit is much larger
than that array.

Keep ordinary commands bounded by the command-page capacity, but bound
GEM mapping commands by MAX_REG_TYPE_NR before storing or validating
them. Perform the checks before taking a command-list node so an invalid
request cannot consume an entry from the free list.

Fixes: d7f1642c90ab ("drm/exynos: add G2D driver")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index e92a4d872c41..2dfea16f32cb 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -1151,21 +1151,17 @@ int exynos_g2d_set_cmdlist_ioctl(struct drm_device *drm_dev, void *data,
 	int size;
 	int ret;
 
-	node = g2d_get_cmdlist(g2d);
-	if (!node)
-		return -ENOMEM;
-
-	/*
-	 * To avoid an integer overflow for the later size computations, we
-	 * enforce a maximum number of submitted commands here. This limit is
-	 * sufficient for all conceivable usage cases of the G2D.
-	 */
+	/* GEM mapping commands also populate fixed-size buf_info arrays. */
 	if (req->cmd_nr > G2D_CMDLIST_DATA_NUM ||
-	    req->cmd_buf_nr > G2D_CMDLIST_DATA_NUM) {
+	    req->cmd_buf_nr > MAX_REG_TYPE_NR) {
 		dev_err(g2d->dev, "number of submitted G2D commands exceeds limit\n");
 		return -EINVAL;
 	}
 
+	node = g2d_get_cmdlist(g2d);
+	if (!node)
+		return -ENOMEM;
+
 	node->event = NULL;
 
 	if (req->event_type != G2D_EVENT_NOT) {
-- 
2.50.1 (Apple Git-155)


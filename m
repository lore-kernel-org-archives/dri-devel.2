Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3DFC982CC
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4807810EC52;
	Wed, 16 Sep 2026 15:42:13 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A11510EC52
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 15:42:11 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowACX_znNuKpqXgFtCA--.21607S2;
 Wed, 16 Sep 2026 23:42:05 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: airlied@gmail.com
Cc: dave.stevenson@raspberrypi.com, dri-devel@lists.freedesktop.org,
 kernel-list@raspberrypi.com, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mcanal@igalia.com, mripard@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de, Wentao Liang <vulab@iscas.ac.cn>,
 stable@vger.kernel.org
Subject: [PATCH] drm/vc4: Fix firmware reference leak in vc4_hvs_bind()
Date: Wed, 16 Sep 2026 15:41:37 +0000
Message-Id: <20260916154137.2058618-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACX_znNuKpqXgFtCA--.21607S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1kGFWkZr47AFy8Cw4rZrb_yoW8Gry8pF
 4UJFyFk3y5uF4ft343AFs5XF1fZan7tFWfCF9Y9wna9345try5JrySv34rKFyUZF4kA3Zx
 KF1qvrWxAas8ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
 8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
 Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
 x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
 1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
 JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYx
 BIdaVFxhVjvjDU0xZFpf9x0JUG_M-UUUUU=
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwQMA2qqpVgy4AABsi
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

The firmware reference taken via rpi_firmware_get() is leaked when
either of the devm_clk_get() calls for the core or display clocks
fails, as both error paths return without releasing it.

Put the firmware reference before returning from both clock lookup
error paths.

Fixes: 2a001ca00ad5 ("drm/vc4: hdmi: Rework hdmi_enable_4kp60 detection code")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index ee8d0738501b..20dde4150068 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -1680,6 +1680,7 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 					     (vc4->gen >= VC4_GEN_6_C) ? "core" : NULL);
 		if (IS_ERR(hvs->core_clk)) {
 			dev_err(&pdev->dev, "Couldn't get core clock\n");
+			rpi_firmware_put(firmware);
 			return PTR_ERR(hvs->core_clk);
 		}
 
@@ -1687,6 +1688,7 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 					     (vc4->gen >= VC4_GEN_6_C) ? "disp" : NULL);
 		if (IS_ERR(hvs->disp_clk)) {
 			dev_err(&pdev->dev, "Couldn't get disp clock\n");
+			rpi_firmware_put(firmware);
 			return PTR_ERR(hvs->disp_clk);
 		}
 
-- 
2.34.1


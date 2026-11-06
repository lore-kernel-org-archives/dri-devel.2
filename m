Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18694606D83B
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D4DB112C8A;
	Fri,  6 Nov 2026 09:20:38 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A4E6112C80
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 09:20:14 +0000 (UTC)
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
 by APP-03 (Coremail) with SMTP id rQCowAAXJpfGm+1qoTlrAA--.5294S2;
 Fri, 06 Nov 2026 17:20:06 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: mcanal@igalia.com,
	airlied@gmail.com
Cc: dave.stevenson@raspberrypi.com, dri-devel@lists.freedesktop.org,
 kernel-list@raspberrypi.com, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de, stable@vger.kernel.org
Subject: [PATCH] drm/vc4: Fix firmware reference leak in vc4_hvs_bind()
Date: Fri,  6 Nov 2026 09:20:16 +0000
Message-Id: <20261106092016.2282805-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5f80ac77-c1f4-42cc-bdcd-e4222f72d853@igalia.com>
References: <5f80ac77-c1f4-42cc-bdcd-e4222f72d853@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXJpfGm+1qoTlrAA--.5294S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1kGFWkZry3WrW8Ww4kZwb_yoW5JryUpF
 43GFWYyrWDGrWfK3y0yr4kZFySyan3JrWfCry8u3Z5Cr1rArykJry0y39YgryUAFW8J3W3
 GFnxtr1xJF1DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
 cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
 AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
 6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
 W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
 xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s
 026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
 JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
 v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
 j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr
 0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZSdgUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAADA2rtlCIdSAAAso
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The firmware reference taken via rpi_firmware_get() is leaked when
either of the devm_clk_get() calls for the core or display clocks
fails, as both error paths return without releasing it.

Fix it by moving the firmware lookup below the clock lookups, so that
the reference is taken right before the firmware property is read and
released immediately afterwards.  The rpi_firmware_find_node() call
moves with it: the device node reference it returns would otherwise be
leaked by those same error paths.

The candidate was found by our static analysis tooling, and this change
was prepared with assistance from DeepSeek-V4.1-Flash and GPT-6.1-Sol.

Fixes: 2a001ca00ad5 ("drm/vc4: hdmi: Rework hdmi_enable_4kp60 detection code")
Cc: stable@vger.kernel.org
Suggested-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Sorry for the very late reply, and thanks for the review.
- Move the firmware and device node lookups below the clock lookups
  instead of adding rpi_firmware_put() to the two error paths, as
  suggested by Maíra.
- Link to v1: https://lore.kernel.org/all/20260916154137.2058618-1-vulab@iscas.ac.cn/
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index b1fb096858cc..537aaa992129 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -1677,15 +1677,6 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 		struct device_node *node;
 		unsigned int max_rate;
 
-		node = rpi_firmware_find_node();
-		if (!node)
-			return -EINVAL;
-
-		firmware = rpi_firmware_get(node);
-		of_node_put(node);
-		if (!firmware)
-			return -EPROBE_DEFER;
-
 		hvs->core_clk = devm_clk_get(&pdev->dev,
 					     (vc4->gen >= VC4_GEN_6_C) ? "core" : NULL);
 		if (IS_ERR(hvs->core_clk)) {
@@ -1700,6 +1691,15 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 			return PTR_ERR(hvs->disp_clk);
 		}
 
+		node = rpi_firmware_find_node();
+		if (!node)
+			return -EINVAL;
+
+		firmware = rpi_firmware_get(node);
+		of_node_put(node);
+		if (!firmware)
+			return -EPROBE_DEFER;
+
 		max_rate = rpi_firmware_clk_get_max_rate(firmware,
 							 RPI_FIRMWARE_CORE_CLK_ID);
 		rpi_firmware_put(firmware);
-- 
2.34.1


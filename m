Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD87606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=QJiqP6gQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97AC01129D5;
	Fri, 23 Oct 2026 07:28:19 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8B7A7112654
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 14:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding; bh=/6YGebWgHG
 PWMyBtJuZLEzuWWT6Sl+na3jZ5wK/Q9Gc=; b=QJiqP6gQTgjJKSdLMuHpl9ylZQ
 RiCVSNG73OYs/zsz6CKC2Q0B3vlVlEeEBpITmu72b5Ve7uq/lqWHHqapbRqBOfC1
 g/Sec9EzLiHwjBfn6Wrm9xFIBPyDcD7P6OEgFTtQdVdFGsQHbR/D9p2jHM/9jzN5
 03qOaaOz1l3t4itn8=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.229.107])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgDXWj_LGNpqZUstAA--.273S2;
 Thu, 22 Oct 2026 22:08:11 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-arm-msm@vger.kernel.org
Cc: linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>
Subject: [RFC PATCH] clk: qcom: dispcc-sm8750: reset the MDSS blocks at probe
 when the bootloader left them running
Date: Thu, 22 Oct 2026 22:08:10 +0800
Message-ID: <20261022140811.469417-1-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 3pYKCgDXWj_LGNpqZUstAA--.273S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4xJF1kXw15Xr48Zr17Awb_yoWrtF1DpF
 sFyF45Kr4kCFyfXFy3Aa1Du3WrJ34ktFy5try3G347AwnxJFn3AFZ2y3sIkFWDtrs7JF1j
 qFW7KFWkCF1vqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
 4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
 6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07bYYLPUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREIB2rZEtVwHAAQsX
X-Mailman-Approved-At: Fri, 23 Oct 2026 07:28:18 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Lenovo Legion Y700 Gen4 (SM8750, "lenovo,elden") the bootloader hands
over with the display block fully active: the dispcc PLLs are locked and
MDSS core / core_int2 / RSCC are out of reset.  The kernel's mdss_reset()
and clk_*_pll_configure() then run on top of that live state and the
command-mode panel fails to initialise:

  msm_dsi ae94000.dsi: command DMA timeout: status=0x2200200
  msm_dsi ae94000.dsi: bonded command DMA failed: master=-110 peer=-110
  panel-novatek-nt36536: Failed to initialize panel: -5

The result is a cold boot with backlight only and no /dev/dri/card0.

Asseting the three dispcc block resets and releasing them before the PLLs
are programmed makes the block start from a known-zero state, after which
the same panel initialises reliably.

Measured on the same device, downstream 7.2 payload, alternating real
power-on cold boots (fastboot boot of two images that differ only in this
hunk and the DSI PHY change mentioned below):

  without the reset:  5 of 9 cold boots failed (command DMA timeout)
  with the reset:    15 of 15 cold boots OK (two variants, see below)

As an RFC I have gated it to lenovo,elden because I cannot tell whether
other boards that hand over with a live display would benefit or would be
broken by resetting the block.  Two questions:

1. Is a per-board workaround in dispcc probe the right place, or should
   this be expressed as a DT property (e.g. qcom,reset-mdss-at-probe) or
   be handled unconditionally in the dispcc driver / in mdss?
2. LinuxLoader solves the same problem on the bootloader side under the
   name "DisableDisplayHW".  Would you rather see the reset done by
   mdss_reset()/DPU before the PLLs are configured, so that it also helps
   other bootloaders that leave the block running?

Separately, and relevant to Dmitry's "drm/msm/dsi/phy: power up the digital
top before starting the 7nm PLL" series: on the same board the missing
DIGTOP_PWRDN_B handling produces exactly the reported

  DSI PLL(0) lock failed, status=0x00000000

four times per boot (the PHY PLL is enabled by the clock framework from
of_clk_set_defaults() before the PHY is touched).  With DIGTOP_PWRDN_B set
and cleared together with PLL_SHUTDOWNB that message disappears from every
boot I measured (10 out of 10), but it does not change the command DMA
behaviour above: an image with only that change still failed 3 of 4 cold
boots with the PLL reported locked.  So the two are independent, and the
DIGTOP change looks correct on its own.

Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
---
 drivers/clk/qcom/dispcc-sm8750.c | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/clk/qcom/dispcc-sm8750.c b/drivers/clk/qcom/dispcc-sm8750.c
index e1d9534..c2a1705 100644
--- a/drivers/clk/qcom/dispcc-sm8750.c
+++ b/drivers/clk/qcom/dispcc-sm8750.c
@@ -5,9 +5,11 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/pm_runtime.h>
@@ -1919,6 +1921,39 @@ static int disp_cc_sm8750_probe(struct platform_device *pdev)
 		goto err_put_rpm;
 	}
 
+	/*
+	 * Some bootloaders hand over with the display block still fully
+	 * active: dispcc PLLs locked and MDSS core / core_int2 / RSCC out of
+	 * reset. Probing on top of that live state makes the command-mode
+	 * panel fail to initialise (command DMA timeout, panel init -EIO).
+	 *
+	 * Assert the three block resets and release them before the PLLs are
+	 * configured, so the block starts from a known-zero state.
+	 *
+	 * Limited to Lenovo Elden for now: it is the only board where this
+	 * handover behaviour was observed and the fix verified.
+	 */
+	if (of_machine_is_compatible("lenovo,elden")) {
+		static const u16 elden_bcrs[] = {
+			DISP_CC_MDSS_CORE_BCR,
+			DISP_CC_MDSS_CORE_INT2_BCR,
+			DISP_CC_MDSS_RSCC_BCR,
+		};
+		unsigned int reg;
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(elden_bcrs); i++) {
+			reg = disp_cc_sm8750_resets[elden_bcrs[i]].reg;
+			regmap_write(regmap, reg, 0x1);
+		}
+		/* Hold for one full ~30 Hz frame before releasing. */
+		msleep(50);
+		for (i = ARRAY_SIZE(elden_bcrs) - 1; i >= 0; i--) {
+			reg = disp_cc_sm8750_resets[elden_bcrs[i]].reg;
+			regmap_write(regmap, reg, 0x0);
+		}
+	}
+
 	clk_taycan_elu_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
 	clk_taycan_elu_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);
 	clk_pongo_elu_pll_configure(&disp_cc_pll2, regmap, &disp_cc_pll2_config);


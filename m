Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98B4606A882
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 05:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=oujcYxKu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 503FB10E505;
	Tue, 17 Nov 2026 05:21:04 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id CE60410E4F2;
 Tue, 17 Nov 2026 05:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding; bh=IGKqXNviSd
 nE1JEAROZtoIrf8JiCirVKpAZGPhHSSQQ=; b=oujcYxKurHufQ0N7XDuQyidmPo
 S/yxU8QC3lXbcOWrLquEY29Ue47BMLP0D96kSYqtLLkF7poILP7PfzuUmPRrY+wS
 XeVIAWyz6DxhD7wMIIwX5cRd7QvVTQRf9rEibYL0Zlm8/SDuyDB1IJCkcoILNeL8
 tekqd6tslyNDqp3Cs=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.190.181])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgB37DAw5PtqGULLAA--.217S2;
 Tue, 17 Nov 2026 13:20:48 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v2] drm/msm/dsi/phy: program PLL_SYSTEM_MUXES on the first PHY
 enable
Date: Tue, 17 Nov 2026 13:20:47 +0800
Message-ID: <20261117052047.32129-1-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 3pYKCgB37DAw5PtqGULLAA--.217S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF45Cr1DAr1rXrWxZr47urg_yoW5Kr4fpr
 W5tw1a9rWDtrWxXws7X3W5u348Cwsaqw4akFnrKas5uan8XFy8XFyxK3WagFyUCrnaqw1Y
 vFnayFyDZry5ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
 wI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4rMxAIw28IcxkI7VAKI48JMxC20s
 026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
 JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
 v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
 j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
 W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5q2MUUUUUU==
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREOB2r7WdojVwANsy
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

From: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>

dsi_7nm_phy_enable() pre-seeds pll_enable_cnt to 1 while de-asserting
DIGTOP_PWRDN_B and PLL_SHUTDOWNB, and dsi_pll_enable_pll_bias() returns
early whenever the counter is already non-zero.  On the first PHY
bring-up the bias helper therefore never reaches its
PLL_SYSTEM_MUXES = 0xc0 write, and nothing else programs that register
before the panel is powered up: PLL_SYSTEM_MUXES keeps 0x0, the locked
PLL outputs are not routed to the lanes, and a panel wired for bonded
DSI comes up with the backlight on and no image.

The combination is old.  commit cb55f39bf7b1 ("drm/msm/dsi/phy: Fix
reading zero as PLL rates when unprepared") introduced both the counter
and the pre-seed.  commit 93c97bc8d85d ("drm/msm: dsi: fix PLL init in
bonded mode") briefly dropped the pre-seed, which made the write
reachable again.  Its revert,

commit 44784327815b ("Revert "drm/msm: dsi: fix PLL init in bonded mode"")

restored both sides, so on current master the muxes are once more never
programmed during the first bring-up.

Program PLL_SYSTEM_MUXES in dsi_7nm_phy_enable() next to the CTRL_0
write that powers the PHY up, while the same lock is held.  This only
adds a register write to a path that already programs CTRL_0: no
existing write moves, and the counter, the locking and the order of the
rest of the PHY programming are untouched, so the byte-clock regression
that led to the revert cannot come back through this path.  The bias
helper keeps its own write for the paths that raise the counter from
zero.

Measured on a Lenovo Y700 Gen4 tablet (SM8750P, bonded dual-DSI CSOT
PP8807HB1-1 panel, "novatek,nt36536"): without this change
PLL_SYSTEM_MUXES reads 0x0 at panel bring-up and the panel stays dark;
with it the register reads back 0xc0, the panel initialises and the DSI
host starts receiving interrupts (41 in /proc/interrupts, 0 before).

Fixes: cb55f39bf7b1 ("drm/msm/dsi/phy: Fix reading zero as PLL rates when unprepared")
Signed-off-by: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
---

Note: an earlier copy of this mail went out a few minutes earlier with a
wrong subject prefix ([PATCH] instead of [PATCH v2]); content is identical,
ignore that one.

Changes in v2: move the explanation out of the source comment and into the
commit message, as requested; the code delta is the same single writel().
Fixes: is re-pointed at cb55f39bf7b1, which introduced both the counter and
the pre-seed, instead of at the revert that restored them.

Link: https://lore.kernel.org/all/20261019130041.305805-1-xiaqinghuan@mail.ustc.edu.cn/
Link: https://lore.kernel.org/all/e4ul4zxjta4oyo5fpjjzwkykb4gicztcn7yrgjw7aer6bqowkw@6nx2arhvmyca/
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index ce86dbf618..98df2d994a 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -1096,6 +1096,7 @@ static int dsi_7nm_phy_enable(struct msm_dsi_phy *phy,
 	data = DSI_7nm_PHY_CMN_CTRL_0_DIGTOP_PWRDN_B |
 	       DSI_7nm_PHY_CMN_CTRL_0_PLL_SHUTDOWNB;
 	writel(data, base + REG_DSI_7nm_PHY_CMN_CTRL_0);
+	writel(0xc0, pll->phy->pll_base + REG_DSI_7nm_PHY_PLL_SYSTEM_MUXES);
 	spin_unlock_irqrestore(&pll->pll_enable_lock, flags);
 
 	/* Assert PLL core reset */
-- 
2.53.0


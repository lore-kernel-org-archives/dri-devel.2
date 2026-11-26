Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FD0606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 05:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=YVFOUtdU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F2DC10E4CE;
	Thu, 26 Nov 2026 05:21:07 +0000 (UTC)
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
 by gabe.freedesktop.org (Postfix) with ESMTP id C88CA10E0FC;
 Thu, 26 Nov 2026 05:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:Content-Transfer-Encoding; bh=eu+ywC0Loi
 ybpoOGKD6TPtsSSzAfxkgin+Y/1iYsRoc=; b=YVFOUtdUuT4YXHUJ/FqoVYaiSt
 V322a/6Mr/N7gPH9zX/KbfUtKcXTSNYBo2tlX5R+Ex2xmx/k7gPxCm2t3FYYR9j9
 OnZrYR6w4CMjbuLQUVla9vqOPiZrvFDztmVIo90Xtb3If3y4J6Zth4vJT0vtlpOe
 2wbYAr49EVTEMi2EE=
Received: from xuqianhui.ustc.edu.cn (unknown [114.214.224.120])
 by mailimap2024 (Coremail) with SMTP id 3pYKCgCXI0ixwQdrYw77AA--.360S2;
 Thu, 26 Nov 2026 13:20:50 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org
Cc: freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 liujianfeng1994@gmail.com, Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
Subject: [PATCH v3] drm/msm/dsi/phy: program PLL_SYSTEM_MUXES on the first PHY
 enable
Date: Thu, 26 Nov 2026 13:20:49 +0800
Message-ID: <20261126052049.1544229-1-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 3pYKCgCXI0ixwQdrYw77AA--.360S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF45Cr1DAr1rXrWxZr47urg_yoWrGw4Upr
 W5Kw1a9rWDtrWxX397Z3W5u348Cw4Sgw4akFnrKa4ruan8X3W8ZFyxKa1YgFyUCr1fJw1F
 vFs3CFyDuF1UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
 n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GrWl42xK82IYc2Ij64vIr4
 1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
 67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
 8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
 wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
 v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYE_MDUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiARECB2sGHiAuFQA5sE
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
Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

Changes since v2: no code change; the diff --git section below is byte-for-byte
identical to v2.  This version only adds Jianfeng Liu's Tested-by (Xiaomi Pad 5
Pro) and is sent as a new thread because the 2026-11-17 v2 mail suffered thread
breakage / a missing subject on some archives; version history and links are
preserved below.

Changes in v2: move the explanation out of the source comment and into the
commit message, as requested; the code delta is the same single writel().
Fixes: is re-pointed at cb55f39bf7b1, which introduced both the counter and
the pre-seed, instead of at the revert that restored them.

Link: https://lore.kernel.org/all/20261019130041.305805-1-xiaqinghuan@mail.ustc.edu.cn/
Link: https://lore.kernel.org/all/e4ul4zxjta4oyo5fpjjzwkykb4gicztcn7yrgjw7aer6bqowkw@6nx2arhvmyca/
Link: https://lore.kernel.org/all/20261117052047.32129-1-xiaqinghuan@mail.ustc.edu.cn/
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


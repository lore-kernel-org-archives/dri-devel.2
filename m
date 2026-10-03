Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9375CA5FF0
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3AFC10EB04;
	Sun,  4 Oct 2026 17:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="QQ31iLkW";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C0CF10E765
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 08:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=If
 IDqJZfF08zWFt0Zzta+SmkT86Z+9Yztld18LGVYf8=; b=QQ31iLkWuxrMMLO7jZ
 pvmDiuBrzfRF7idvp/0Z83/yMUZTBKEqpikvkZuvX7GR8LFTFzzW+KX/MSTfYMMK
 kuMNas13fFH7FolzBOFKJI5fzD9mAn1HgWNVOAoMffV2ieCOalQU5cVyBF10f76/
 MXMoNSt8vkS/VxH/O6owU3tEg=
Received: from pc.localdomain (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wDX37c4uMBqHTY2CQ--.51768S2; 
 Sat, 03 Oct 2026 16:09:29 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] drm/exynos: fimd: handle runtime resume failure for DP clock
Date: Sat,  3 Oct 2026 16:09:26 +0800
Message-Id: <20261003080927.430719-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDX37c4uMBqHTY2CQ--.51768S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw17GFWUGF17Cry8tF4DCFg_yoW8XrWrpF
 47JFyFkrWjq3y8KFW2yF129F98Ka17GFW8XrZ3G348uw1UAr1vq3yrCF1DtFn0vrZ7AF1j
 vrs7Ja47CF1jyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piX189UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhkHQWrAuDnOcAAA3E
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:20:52 +0000
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

fimd_dp_clock_enable() ignores runtime resume failures and still writes
the DP clock register and updates dp_clk_enabled. This can access an
unavailable device, record a state that was not applied to hardware,
and later drop a runtime PM reference that was never acquired.

Return without changing the clock state when runtime resume fails.

Fixes: 5d91394f2361 ("drm/exynos: fimd: Guard display clock control with runtime PM calls")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index b6abdc4f2b0a..ea2b961f0cbc 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -1049,12 +1049,18 @@ static void fimd_dp_clock_enable(struct exynos_drm_clk *clk, bool enable)
 	struct fimd_context *ctx = container_of(clk, struct fimd_context,
 						dp_clk);
 	u32 val = enable ? DP_MIE_CLK_DP_ENABLE : DP_MIE_CLK_DISABLE;
+	int ret;
 
 	if (enable == ctx->dp_clk_enabled)
 		return;
 
-	if (enable)
-		pm_runtime_resume_and_get(ctx->dev);
+	if (enable) {
+		ret = pm_runtime_resume_and_get(ctx->dev);
+		if (ret < 0) {
+			dev_warn(ctx->dev, "failed to enable FIMD device: %d\n", ret);
+			return;
+		}
+	}
 
 	ctx->dp_clk_enabled = enable;
 	writel(val, ctx->regs + DP_MIE_CLKCON);
-- 
2.34.1


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37C5CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 00:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24A4010E1DB;
	Mon,  5 Oct 2026 00:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h49sUi7U";
	dkim-atps=neutral
Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com
 [74.125.229.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7216710E1DB
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 00:11:22 +0000 (UTC)
Received: by mail-dy2-f42.google.com with SMTP id
 5a478bee46e88-3510b42f4e3so1186037eec.2
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 17:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791159082; x=1791763882; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dpTVtuLsZCKAP9AgVyjYlCoNh2JMBgdKfaKYvWUv55Y=;
 b=h49sUi7UwGP6iONY3p3Cw3qCxU3QX47l3rnvF8J1wRQ75xgkcN8Wxwj/y+j+TDZSne
 pPudzwy9RjF6oLn3zKyFccL4Bv9T8AfXk+PGk5wcGPvRQoJgR3UZ8J216I9HHiTXldqx
 Yl2TWqdzmV+Tssiwb7bWpgCRFuZ7X2NL+C19P78mKSaRfdDq9KIGd7eQTTQ1EYrtknoJ
 oCNgweeL0+St6eLqX49lr9/rUAxoB4ofkBZ/NYRGNrT5FNfmgmhBE49cg18AH5HA90XH
 OZ7gJu/+CUU+awAhTm5tDMyXVD1Qch/SMt6/Ftii+0tZeivWPiuPm0f8WFUCICSzLoeA
 8BkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791159082; x=1791763882;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dpTVtuLsZCKAP9AgVyjYlCoNh2JMBgdKfaKYvWUv55Y=;
 b=GWbtX09coIDCi7ebFxEma3McgJSEnSFVbtdKwQv9WPat8eK+aPRN2bQHg+dqIrCOJX
 D6eA5O1Hly88leNZVaA9nwnHDmsVVotfYSPkXo7KD+i/+zgbopZ06/95vBLKcWWZAXZI
 hnby8Xz41j35k+Pc4pBHUbmO117R7/L/lTUnjjEZdGTzouczGFZDxZgQR7jqvTy5bAq1
 FyFjEDsP1udUIQhJkW6kGIi9XlcTb12pgAS5Vu5nKtHoYt9fb5H68/uQ5n5wu2GPn6rq
 CPCJDzIH150U5kMsFGvL0dN2uJRdOKUu338LjKC3qfuBENVylqUr6+asFhY8Mn87TQQ5
 l0Dw==
X-Gm-Message-State: AFuF++m3MvSDtQUl0/gFfPzZkBW3yvU9Mz+iBV0b+tqjKKyukZinjrv7
 vXo7JrRrXy7LGRKbsA0vwSdx+zB4XdaQjto1st9RJYG3GK+y1r2RojFLw/PcpC4p+uE=
X-Gm-Gg: AYBFou0RN4j77syqGni39UYpZeGYmyIrb0u4X4UJL73mNUOEd2jMXRYlMiwdYQr7I0P
 pFhulfjMGpWt4Rt9Jjnt/QMPiLqeXdRMjTK3DquF8TkSrEpgvtzk1hLJKH2oE0hMMY1UD9B3hYJ
 0q2kIiakm9ePi7RkRFfXw0L0KEjgqktzT3EtLU7yHUJigwswMHjYLG9W3z2yzAebtXvlDnMcN+p
 13OkLsbexq5ZFObbo6NMmP513Xuzysi/If4qrHq05ARRsBrPH8zR3ff48bhi+tHE0fCfZHrWIOs
 v+TRH1lEK0H0Ap83yOToUkPCY3HwcamphGc+xqut3tiojRXahBQsza1uoo4IBlRZdbnKeqEqNng
 mUBPmWMNzcqxluo9IvK3XWne0Rei7FGTMn9CSERDeXTDbuRyOIf4nIoqEO1KtzJRtxmokCTyiDZ
 47bDgXDlb69Ywskr+6SaR+L0+meSkpXFF6WPLW3yJjgXawt2e5kRiKfX4T/hFqlI8KC/Njw1GA3
 pT/x+891oQ1RST5pfjVhbCqMEzpTq9GrnARWfoKbY9gxj+YMj+Gve1yF4/Kr8wRNqxd9Bw3MKxk
 t0InCeA7GOFecJnMb/FeLejPLFvd1PiKSsSyNGZ85Lt6AC3sm5I5MoPF2CI=
X-Received: by 2002:a05:7023:a87:b0:153:3c50:ab85 with SMTP id
 a92af1059eb24-1533c50abdamr6557346c88.12.1791159081504; 
 Sun, 04 Oct 2026 17:11:21 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fa751693sm38784720c88.2.2026.10.04.17.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 17:11:20 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C,
 S5P AND EXYNOS ARM ARCHITECTURES), 
 linux-samsung-soc@vger.kernel.org (open list:ARM/SAMSUNG S3C,
 S5P AND EXYNOS ARM ARCHITECTURES), 
 linux-kernel@vger.kernel.org (open list),
 linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by
 other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH] drm/exynos: fimc: allocate formats as a flexible array member
Date: Sun,  4 Oct 2026 17:11:18 -0700
Message-ID: <20261005001118.576198-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The formats array is allocated separately with devm_kcalloc() and only
referenced through the fimc_context. Make it a flexible array member at
the end of the context and allocate both in one go with struct_size().

Annotate it with __counted_by(num_formats) so the array accesses can be
bounds checked with FORTIFY_SOURCE and UBSAN_BOUNDS.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_fimc.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimc.c b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
index 09e33a26caaf..079d24d0671c 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
@@ -99,7 +99,6 @@ struct fimc_context {
 	void		*dma_priv;
 	struct device	*dev;
 	struct exynos_drm_ipp_task	*task;
-	struct exynos_drm_ipp_formats	*formats;
 	unsigned int			num_formats;
 
 	void __iomem	*regs;
@@ -108,6 +107,7 @@ struct fimc_context {
 	struct fimc_scaler	sc;
 	int	id;
 	int	irq;
+	struct exynos_drm_ipp_formats	formats[] __counted_by(num_formats);
 };
 
 static u32 fimc_read(struct fimc_context *ctx, u32 reg)
@@ -1273,20 +1273,16 @@ static int fimc_probe(struct platform_device *pdev)
 	if (exynos_drm_check_fimc_device(dev) != 0)
 		return -ENODEV;
 
-	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	num_formats = ARRAY_SIZE(fimc_formats) + ARRAY_SIZE(fimc_tiled_formats);
+	ctx = devm_kzalloc(dev, struct_size(ctx, formats, num_formats), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
+	ctx->num_formats = num_formats;
+	formats = ctx->formats;
 	ctx->dev = dev;
 	ctx->id = of_alias_get_id(dev->of_node, "fimc");
 
-	/* construct formats/limits array */
-	num_formats = ARRAY_SIZE(fimc_formats) + ARRAY_SIZE(fimc_tiled_formats);
-	formats = devm_kcalloc(dev, num_formats, sizeof(*formats),
-			       GFP_KERNEL);
-	if (!formats)
-		return -ENOMEM;
-
 	/* linear formats */
 	if (ctx->id < 3) {
 		limits = fimc_4210_limits_v1;
@@ -1320,9 +1316,6 @@ static int fimc_probe(struct platform_device *pdev)
 		formats[j].num_limits = num_limits;
 	}
 
-	ctx->formats = formats;
-	ctx->num_formats = num_formats;
-
 	/* resource memory */
 	ctx->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ctx->regs))
-- 
2.56.0


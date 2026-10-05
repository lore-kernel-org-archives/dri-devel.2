Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F26CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 00:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 650BA10E1F3;
	Mon,  5 Oct 2026 00:11:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Om0Xgk6l";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A10DC10E1F3
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 00:11:46 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-33e46a156f4so1182616eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 17:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791159106; x=1791763906; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LFk7ga35z3NrHS6umKXq0xUG3dzK46r7JSMoXY1ndGw=;
 b=Om0Xgk6lOqrW8310b2lPaiw/57OmCwRQkk8+cb1tpaAR8dBu6DMBPZ2K8UAl1z1pXJ
 YHzj6ZZaEroR2nXOpDOk2ZC9/N0e8H2OiURNeYFXxErZQ2TS2LFLAsT1Oe6KtOkGeK1B
 Wucfza0gipXoBm4Al2P+eMzYTcGNQdLWQ31EHMNe9SXs4aqbJ3P8nengakz47WavPSRd
 EfS9OW62+nBFLZU9rgb6vqXVn2YeG1A7PxXHzPkAUbsxF36I7izuPC5VQS9oePkXgWL+
 dlzv6g+WvUQhxQDkYU4m4YFoBttwhJ6dF/uUlykSVx/KKUgsRSDbq0E78sUO887SyzeP
 dYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791159106; x=1791763906;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LFk7ga35z3NrHS6umKXq0xUG3dzK46r7JSMoXY1ndGw=;
 b=zI6oehmC6VwHvjGRsAriHnquT+WdBGe8uPvJVkrHw9dgf6xm8aQxh195to0R4hBUEB
 2H0ko93zm/H6eyHNMs97bKGNhOrGadvfiAee7o+jUUyh9n/GfItt8evkevkUSIXLMiYp
 ytewrr+zFy0smsUAL9WuGFncpmMhl7X6pG9n9droxDT95HrQiul05Sg+Tnu4oZdeWbQY
 0c4EM2LR6Efuoft9OsbYrBmn89SLakG4El2oOgOquGjC/DRGIuglecMtrWMl9eH5KB8W
 AkoqxktjOkbMnKiYFK4yLm8n10nLM02XJcoxTvH0q/x5NrW55m9XglHAXCyUdn+XrF6C
 F5qA==
X-Gm-Message-State: AFuF++m1NJuF9GR24OmfzJVgQe4mPRYUop1jYp3qzUTkTT2niXEYN+zM
 D/RWldjMpnIG+oMv/ve5wjP1NzQPSpgecLcTnibNyLzHOmYY7HVht6DBAB3uIntDZEQ=
X-Gm-Gg: AYBFou3uTqD/lGp7VwEqtz2/3ePzMlAflMBh/2wM96OlEBw3lfdknOlGSrJSYcq81Wr
 jo0heNDgaqK03Wkylw7LQZlcco54tfDFxAN1KME8NY35xeeIeyEBggI1St5uiPhhlUlKnJCTrhc
 FVgKvMxwwGI6AMdJ4Ep8BNe/hn4NlgItsPMwzYpVEqQ4AWGn6kxDtdPYZIvhE2Wlbx/3tia2zK6
 d/T8eNawg0IqxRUYdX7M+vMyq4iIXZx3lc5Da4SKC7DqSqx5OEfyvHj3kqy9d9ahgwXwPdw9OSi
 4C23IjwFedU15bKSmTU1UynMbz+w6v+RXaXMaTRHNHFIB6KFizUI9ToxlmWgen0e8/epxiUrBJv
 dspBaWiBum8CLTsQ25Wf58SM69kyhZvoz/1rZ5hi0Fg1XMjCTBJ9TmP920j1ZJQ2Rfhmk0hY1iv
 4eN0lVdm3mSBHlow72BDKRAIfyXn2Ks6cPEgvuzDj3mEtqGhaoNHF7BPfGwhfafGKUIK3aVDKT2
 U76I+Avd47FAFhcwWLNx1awLxGUR+MwKH/EG3ou39EaogPGht7QsOWaY4PlIKJTiQA6irl+I3OX
 vr+pVQbqEVvMBICabNBvj12mFjjRGBHbXhkA4Pf3iXMbvAzU
X-Received: by 2002:a05:7022:eb47:20b0:143:7001:7643 with SMTP id
 a92af1059eb24-14f5cdc92f3mr12086833c88.46.1791159105797; 
 Sun, 04 Oct 2026 17:11:45 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-151fc39a6cbsm16540732c88.5.2026.10.04.17.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 17:11:45 -0700 (PDT)
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
Subject: [PATCH] drm/exynos: gsc: allocate formats as a flexible array member
Date: Sun,  4 Oct 2026 17:11:43 -0700
Message-ID: <20261005001143.576737-1-rosenp@gmail.com>
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
referenced through the gsc_context. Make it a flexible array member at
the end of the context and allocate both in one go with struct_size().

Annotate it with __counted_by(num_formats) so the array accesses can be
bounds checked with FORTIFY_SOURCE and UBSAN_BOUNDS.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_gsc.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index d9637ddfcfc4..f1807ef664e1 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -99,7 +99,6 @@ struct gsc_context {
 	void		*dma_priv;
 	struct device	*dev;
 	struct exynos_drm_ipp_task	*task;
-	struct exynos_drm_ipp_formats	*formats;
 	unsigned int			num_formats;
 
 	void __iomem	*regs;
@@ -110,6 +109,7 @@ struct gsc_context {
 	int	id;
 	int	irq;
 	bool	rotation;
+	struct exynos_drm_ipp_formats	formats[] __counted_by(num_formats);
 };
 
 /**
@@ -1222,21 +1222,19 @@ static int gsc_probe(struct platform_device *pdev)
 	struct gsc_context *ctx;
 	int num_formats, ret, i, j;
 
-	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	num_formats = ARRAY_SIZE(gsc_formats) + ARRAY_SIZE(gsc_tiled_formats);
+	ctx = devm_kzalloc(dev, struct_size(ctx, formats, num_formats), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
 
+	ctx->num_formats = num_formats;
+	formats = ctx->formats;
+
 	driver_data = device_get_match_data(dev);
 	ctx->dev = dev;
 	ctx->num_clocks = driver_data->num_clocks;
 	ctx->clk_names = driver_data->clk_names;
 
-	/* construct formats/limits array */
-	num_formats = ARRAY_SIZE(gsc_formats) + ARRAY_SIZE(gsc_tiled_formats);
-	formats = devm_kcalloc(dev, num_formats, sizeof(*formats), GFP_KERNEL);
-	if (!formats)
-		return -ENOMEM;
-
 	/* linear formats */
 	for (i = 0; i < ARRAY_SIZE(gsc_formats); i++) {
 		formats[i].fourcc = gsc_formats[i];
@@ -1256,9 +1254,6 @@ static int gsc_probe(struct platform_device *pdev)
 		formats[j].num_limits = driver_data->num_limits;
 	}
 
-	ctx->formats = formats;
-	ctx->num_formats = num_formats;
-
 	/* clock control */
 	for (i = 0; i < ctx->num_clocks; i++) {
 		ctx->clocks[i] = devm_clk_get(dev, ctx->clk_names[i]);
-- 
2.56.0


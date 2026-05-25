Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2100CD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9032710E45F;
	Mon, 25 May 2026 06:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HF+datPj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7226D10E406
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 06:47:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AADEE60202;
 Mon, 25 May 2026 06:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A78CC2BCB3;
 Mon, 25 May 2026 06:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779691676;
 bh=8IJtxE6ig879Om2zQsEpoJwAJxcysV9GjhnS8w61yPE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=HF+datPjSxS3b5PgXXMxnBM3jF1xWKk0kHemKUPIm88QAyU9IAWOkfPI9J9R95SZj
 s3Zl5r4c81sCZSo2+5U+nW314g55ayDxkiXF3ayYbKCuC95Q+u4eVeCTxbEP7tcqGI
 Zvf2ofIZGsg15dBfZy6UG73yczAqk6eSCqj+0C9B0nxTTNJURM0NsuPNDgxHkUtKkW
 EKly34hSsZZVV7xJcJAnYyqPgsUa+K1O12dbQvZMZadaWSuNTWRbs6uHZTa33ZP2Z/
 Kn5EaXABwXKKbDRs4fI5lKnTpPqFmfiX7Em76/pRm8bisQNyEss4CFj4+ZOTVTwQZ6
 BQ2hjHDTAWFrQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 3696ACD5BBF;
 Mon, 25 May 2026 06:47:56 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 25 May 2026 01:47:44 -0500
Subject: [PATCH v2 1/2] spi: tegra210-quad: Allocate DMA memory for DMA engine
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-tegra194-qspi-iommu-v2-1-a11c53f804b2@gmail.com>
References: <20260525-tegra194-qspi-iommu-v2-0-a11c53f804b2@gmail.com>
In-Reply-To: <20260525-tegra194-qspi-iommu-v2-0-a11c53f804b2@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 devicetree@vger.kernel.org, Thierry Reding <treding@nvidia.com>, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779691675; l=4772;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=l7YzDxh5xjjzC7rsRABKlUS2hzABVlzgeHIZyzIWkrM=;
 b=1CpmXZNayhDytsA6U5Qt3+xyw/X7Eb6AGh0QR7nvO2tUVzPwtmzzzjdw398yo30DQVIpDEIyd
 bl3Q0/WH8EFCpg1Oe/n3LOBMq4SK7Mpln8fxiexCXagp6RW6EfEmPtX
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
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
Reply-To: webgeek1234@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Aaron Kling <webgeek1234@gmail.com>

When the SPI controllers are running in DMA mode, it is the DMA engine
that performs the memory accesses rather than the SPI controller. Pass
the DMA engine's struct device pointer to the DMA API to make sure the
correct DMA operations are used.

Suggested-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/spi/spi-tegra210-quad.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index db28dd556484b2..588a929a97850a 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -226,11 +226,13 @@ struct tegra_qspi {
 	struct completion			xfer_completion;
 	struct spi_transfer			*curr_xfer;
 
+	struct device				*rx_dma_dev;
 	struct dma_chan				*rx_dma_chan;
 	u32					*rx_dma_buf;
 	dma_addr_t				rx_dma_phys;
 	struct dma_async_tx_descriptor		*rx_dma_desc;
 
+	struct device				*tx_dma_dev;
 	struct dma_chan				*tx_dma_chan;
 	u32					*tx_dma_buf;
 	dma_addr_t				tx_dma_phys;
@@ -574,15 +576,15 @@ static int tegra_qspi_dma_map_xfer(struct tegra_qspi *tqspi, struct spi_transfer
 	len = DIV_ROUND_UP(tqspi->curr_dma_words * tqspi->bytes_per_word, 4) * 4;
 
 	if (t->tx_buf) {
-		t->tx_dma = dma_map_single(tqspi->dev, (void *)tx_buf, len, DMA_TO_DEVICE);
-		if (dma_mapping_error(tqspi->dev, t->tx_dma))
+		t->tx_dma = dma_map_single(tqspi->tx_dma_dev, (void *)tx_buf, len, DMA_TO_DEVICE);
+		if (dma_mapping_error(tqspi->tx_dma_dev, t->tx_dma))
 			return -ENOMEM;
 	}
 
 	if (t->rx_buf) {
-		t->rx_dma = dma_map_single(tqspi->dev, (void *)rx_buf, len, DMA_FROM_DEVICE);
-		if (dma_mapping_error(tqspi->dev, t->rx_dma)) {
-			dma_unmap_single(tqspi->dev, t->tx_dma, len, DMA_TO_DEVICE);
+		t->rx_dma = dma_map_single(tqspi->rx_dma_dev, (void *)rx_buf, len, DMA_FROM_DEVICE);
+		if (dma_mapping_error(tqspi->rx_dma_dev, t->rx_dma)) {
+			dma_unmap_single(tqspi->tx_dma_dev, t->tx_dma, len, DMA_TO_DEVICE);
 			return -ENOMEM;
 		}
 	}
@@ -597,9 +599,9 @@ static void tegra_qspi_dma_unmap_xfer(struct tegra_qspi *tqspi, struct spi_trans
 	len = DIV_ROUND_UP(tqspi->curr_dma_words * tqspi->bytes_per_word, 4) * 4;
 
 	if (t->tx_buf)
-		dma_unmap_single(tqspi->dev, t->tx_dma, len, DMA_TO_DEVICE);
+		dma_unmap_single(tqspi->tx_dma_dev, t->tx_dma, len, DMA_TO_DEVICE);
 	if (t->rx_buf)
-		dma_unmap_single(tqspi->dev, t->rx_dma, len, DMA_FROM_DEVICE);
+		dma_unmap_single(tqspi->rx_dma_dev, t->rx_dma, len, DMA_FROM_DEVICE);
 }
 
 static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct spi_transfer *t)
@@ -745,7 +747,7 @@ static int tegra_qspi_start_cpu_based_transfer(struct tegra_qspi *qspi, struct s
 static void tegra_qspi_deinit_dma(struct tegra_qspi *tqspi)
 {
 	if (tqspi->tx_dma_buf) {
-		dma_free_coherent(tqspi->dev, tqspi->dma_buf_size,
+		dma_free_coherent(tqspi->tx_dma_dev, tqspi->dma_buf_size,
 				  tqspi->tx_dma_buf, tqspi->tx_dma_phys);
 		tqspi->tx_dma_buf = NULL;
 	}
@@ -756,7 +758,7 @@ static void tegra_qspi_deinit_dma(struct tegra_qspi *tqspi)
 	}
 
 	if (tqspi->rx_dma_buf) {
-		dma_free_coherent(tqspi->dev, tqspi->dma_buf_size,
+		dma_free_coherent(tqspi->rx_dma_dev, tqspi->dma_buf_size,
 				  tqspi->rx_dma_buf, tqspi->rx_dma_phys);
 		tqspi->rx_dma_buf = NULL;
 	}
@@ -782,6 +784,7 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
 		}
 
 		tqspi->rx_dma_chan = dma_chan;
+		tqspi->rx_dma_dev = dmaengine_get_dma_device(tqspi->rx_dma_chan);
 
 		dma_chan = dma_request_chan(tqspi->dev, "tx");
 		if (IS_ERR(dma_chan)) {
@@ -790,15 +793,19 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
 		}
 
 		tqspi->tx_dma_chan = dma_chan;
+		tqspi->tx_dma_dev = dmaengine_get_dma_device(tqspi->tx_dma_chan);
 	} else {
 		if (!device_iommu_mapped(tqspi->dev)) {
 			dev_warn(tqspi->dev,
 				 "IOMMU not enabled in device-tree, falling back to PIO mode\n");
 			return 0;
 		}
+
+		tqspi->rx_dma_dev = tqspi->dev;
+		tqspi->tx_dma_dev = tqspi->dev;
 	}
 
-	dma_buf = dma_alloc_coherent(tqspi->dev, tqspi->dma_buf_size, &dma_phys, GFP_KERNEL);
+	dma_buf = dma_alloc_coherent(tqspi->rx_dma_dev, tqspi->dma_buf_size, &dma_phys, GFP_KERNEL);
 	if (!dma_buf) {
 		err = -ENOMEM;
 		goto err_out;
@@ -807,7 +814,7 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
 	tqspi->rx_dma_buf = dma_buf;
 	tqspi->rx_dma_phys = dma_phys;
 
-	dma_buf = dma_alloc_coherent(tqspi->dev, tqspi->dma_buf_size, &dma_phys, GFP_KERNEL);
+	dma_buf = dma_alloc_coherent(tqspi->tx_dma_dev, tqspi->dma_buf_size, &dma_phys, GFP_KERNEL);
 	if (!dma_buf) {
 		err = -ENOMEM;
 		goto err_out;

-- 
2.53.0



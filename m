Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5B8CD5BBF
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1953810E406;
	Mon, 25 May 2026 06:47:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RRBlGGd9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA7F110E406
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 06:47:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F9B140279;
 Mon, 25 May 2026 06:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57C58C2BCC7;
 Mon, 25 May 2026 06:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779691676;
 bh=rQtWtz9PaBC5kO/YmeSFs1AL2c5xXsa62gy6hOf0BC4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=RRBlGGd926Pbz+gVLIdJH4aGYLYZwwKI7u8T3BTGNle1QfFTLqka6n4G2dsp7L8mx
 hpZsA4p28dw687ygsK42fuR/qdNpFMO44tD9Uiyp4+hk0JDUcK7tToDVkEYlXo1H1Z
 RXrruj6o07PvEGWpLeCuJsK4MDUubpcIXQttrQsjcl6+nUSq+YHtM/U4lcXv2sfBax
 GLhYtvvvhMTdPL2PuB2fpVDgnohZ1FXbVuP12iuHwSbhLyWXJDSKprrxH7yYfY7RVr
 VMRNo9ZtBAdFejzhKSoSUPKTe4GZ1HUM4aO5aD3PSnKS+G9/LTAbgXt1A3ZFerT5LV
 nOJ6iNGfTNQ9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 44221CD5BCE;
 Mon, 25 May 2026 06:47:56 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 25 May 2026 01:47:45 -0500
Subject: [PATCH v2 2/2] arm64: tegra: Enable DMA Support on Tegra194 QSPI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-tegra194-qspi-iommu-v2-2-a11c53f804b2@gmail.com>
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
 devicetree@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779691675; l=1118;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=KjSbPkVlCYH0lmqUb9TdWBRiwbc5n5A4wUaKdi0Q4ak=;
 b=PBjXCsxlPIs64wXAC3rv9Jl/iDRaXY0pG7TZaawi+0P9HpR2fOtGfRnlvlgqjKFs1D5MLuduh
 dV+Gq/kPkXYA63Uajrq8p3bL7jiD7BePTNcpBzrltxNxMjBOVFAbTfp
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

Without dma enabled pio mode is used and flash storage such as the one
on the p3668 module times out and cannot complete any transfers. In some
cases, these timeouts cause hangs and cbb faults.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 1d659454a6f9fe..e2ddbc6715d5e8 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -923,6 +923,8 @@ spi@3270000 {
 				 <&bpmp TEGRA194_CLK_QSPI0_PM>;
 			clock-names = "qspi", "qspi_out";
 			resets = <&bpmp TEGRA194_RESET_QSPI0>;
+			dmas = <&gpcdma 5>, <&gpcdma 5>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -1013,6 +1015,8 @@ spi@3300000 {
 				 <&bpmp TEGRA194_CLK_QSPI1_PM>;
 			clock-names = "qspi", "qspi_out";
 			resets = <&bpmp TEGRA194_RESET_QSPI1>;
+			dmas = <&gpcdma 6>, <&gpcdma 6>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 

-- 
2.53.0



Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B049CC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC05F10E906;
	Tue, 13 Oct 2026 14:52:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ECCA10E8AB;
 Tue, 13 Oct 2026 14:52:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BFB2C438DC;
 Tue, 13 Oct 2026 14:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC6D1F00899;
 Tue, 13 Oct 2026 14:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791903137;
 bh=kzhwRl3T1k1AdPv6B7bJL6B4cN4Kgv+yi+7DS1nteLA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=n1nHBZ0HSExzZ1ujuDc3pCPJMRgU2xATqpvt1ZSQPgAazeG0fwk7zadKRVqHZs9a3
 86Z9HehjzB9g/CJzIwUA0dZ2uEkc4R47jfK/1bbKfg4zJo7s//p3uMSIS1qOlVlaAz
 1DyUPJ8WlSqtZv8QXWHqUH4uL4dAlbADX6gwVhHiBTuJyu2T4X0wuaGzsQxP3IZJ6H
 MzIjh0n+h3QsUGQhptXFNdf0rsKB9pGAZW++N97dl5Ymy0izgovfSEeJGnHU1LCySM
 dwQYDaV1p0ROUFH0vIvdxd2eKYWwH7Df0gVkkTJ+9AonjUP5n4DNdhqNBBhgBZOdsR
 LZfZGBVR9YGGQ==
From: Sasha Levin <sashal@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Aaron Kling <webgeek1234@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3/3] drm/nouveau/tegra: Keep the fuse clock enabled while the
 GPU is powered
Date: Tue, 13 Oct 2026 10:52:10 -0400
Message-ID: <20261013145210.103565-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013145210.103565-1-sashal@kernel.org>
References: <20261013145210.103565-1-sashal@kernel.org>
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

Since the GPU on the Jetson TX1 was enabled in commit d1b725476104
("arm64: tegra: p2180: Explicitly enable GPU"), nouveau often fails to
bring up the GM20B. Either BOOT_0 reads back garbage ("unknown chipset
(5ffefa47)"), or PRI reads of the GPC PLL time out ("MMIO read of
00000000 FAULT at 137000 [ TIMEOUT ]"), or the first register reads in
nvkm_device_ctor() stall until an asynchronous SError. How often depends
on the board; one board fails on every boot.

nouveau powers the GPU up with the fuse clock gated: since commit
24a15252ff04 ("soc/tegra: fuse: Add runtime PM support"), the Tegra fuse
driver only enables that clock around its own fuse reads. NVIDIA's
downstream nvgpu driver enables the fuse clock along with the other GPU
clocks whenever the GPU is powered. Do the same: take an optional "fuse"
clock and keep it enabled from before the GPU rail is turned on until
after it is turned off.

Tested on eight Jetson TX1 devkits, on mainline and on v6.18. Without
this patch, the GPU failed to come up in 27 of 109 boots; with it, in 11
of 291, none of them with a garbage BOOT_0. On the board that failed on
every boot, 38 of 40 boots now succeed. The remaining failures are
mostly a register read that stalls until an SError; wherever the console
shows when, nouveau had already finished probing. Such stalls also occur
without this patch and are a separate problem. The Jetson Nano, which
shares the Tegra210 GPU node, still works (24 of 24 boots).

Fixes: d1b725476104 ("arm64: tegra: p2180: Explicitly enable GPU")
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/include/nvkm/core/tegra.h  |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/core/tegra.h b/drivers/gpu/drm/nouveau/include/nvkm/core/tegra.h
index 6aaa30ef167f..0189043382d0 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/core/tegra.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/core/tegra.h
@@ -15,6 +15,7 @@ struct nvkm_device_tegra {
 	struct clk *clk;
 	struct clk *clk_ref;
 	struct clk *clk_pwr;
+	struct clk *clk_fuse;
 
 	struct regulator *vdd;
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
index 3c8d0878891a..31f8eaa9d650 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
@@ -32,6 +32,10 @@ nvkm_device_tegra_power_up(struct nvkm_device_tegra *tdev)
 {
 	int ret;
 
+	ret = clk_prepare_enable(tdev->clk_fuse);
+	if (ret)
+		return ret;
+
 	if (tdev->vdd) {
 		ret = regulator_enable(tdev->vdd);
 		if (ret)
@@ -76,6 +80,7 @@ nvkm_device_tegra_power_up(struct nvkm_device_tegra *tdev)
 	if (tdev->vdd)
 		regulator_disable(tdev->vdd);
 err_power:
+	clk_disable_unprepare(tdev->clk_fuse);
 	return ret;
 }
 
@@ -95,6 +100,8 @@ nvkm_device_tegra_power_down(struct nvkm_device_tegra *tdev)
 			return ret;
 	}
 
+	clk_disable_unprepare(tdev->clk_fuse);
+
 	return 0;
 }
 
@@ -308,6 +315,12 @@ nvkm_device_tegra_new(const struct nvkm_device_tegra_func *func,
 		goto free;
 	}
 
+	tdev->clk_fuse = devm_clk_get_optional(&pdev->dev, "fuse");
+	if (IS_ERR(tdev->clk_fuse)) {
+		ret = PTR_ERR(tdev->clk_fuse);
+		goto free;
+	}
+
 	tdev->pmc = devm_tegra_pmc_get(&pdev->dev);
 	if (IS_ERR(tdev->pmc)) {
 		ret = PTR_ERR(tdev->pmc);
-- 
2.43.0


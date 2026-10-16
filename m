Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C20CCA490
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33A7B112901;
	Fri, 16 Oct 2026 16:07:27 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FC7C11291F;
 Fri, 16 Oct 2026 16:07:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D1BD06020F;
 Fri, 16 Oct 2026 16:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216DC1F000C4;
 Fri, 16 Oct 2026 16:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792166838;
 bh=g0Lje6TXki26fVUnlaQHkMtbrNZrfbHvxBcQLPWLmSo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=o02l1/1AfRehMaiRM9H3RwrO3H7Om7ESvoMj3xdRz9JgsEQI+q3N12lp4BXvcpuZ+
 k/xLOYuhviCCBPSCM/yrB3NOn87lMFgKdkNtZ+y1eESVMFGg8cuqbXL1pcH+YhxFwC
 lz21pmOa2vYXKukeU7tZddy2sldgXgMSVSZ8AB9JTY+3BptYvI8m2RVTENDP0DMJxq
 NwNq8CpOeovapYN5D/a0O2C/7g1T+1lL4kml/u3LgQaqCYCJlib3ANzUfRppk25Xg5
 Fo9wAZICKWyj/B1ctF6CcvD6no6uB7Zgx3UvklT4m5YTSlSEKSbX8TmUhCR8p0+ZsI
 voCiXSDGylqOg==
From: Sasha Levin <sashal@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Aaron Kling <webgeek1234@gmail.com>, Diogo Ivo <diogo.ivo@bootlin.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] drm/nouveau/tegra: Keep the fuse clock enabled while
 the GPU is powered
Date: Fri, 16 Oct 2026 12:06:59 -0400
Message-ID: <20261016160700.3831336-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016160700.3831336-1-sashal@kernel.org>
References: <20261016160700.3831336-1-sashal@kernel.org>
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
after it is turned off. The clock is optional so that device trees that
lack it keep working as before.

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
 .../gpu/drm/nouveau/include/nvkm/core/tegra.h |  1 +
 .../drm/nouveau/nvkm/engine/device/tegra.c    | 22 ++++++++++++++-----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/core/tegra.h b/drivers/gpu/drm/nouveau/include/nvkm/core/tegra.h
index 6aaa30ef167f6..0189043382d02 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/core/tegra.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/core/tegra.h
@@ -15,6 +15,7 @@ struct nvkm_device_tegra {
 	struct clk *clk;
 	struct clk *clk_ref;
 	struct clk *clk_pwr;
+	struct clk *clk_fuse;
 
 	struct regulator *vdd;
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c
index 3c8d0878891ad..74b292659ee9a 100644
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
@@ -76,26 +80,26 @@ nvkm_device_tegra_power_up(struct nvkm_device_tegra *tdev)
 	if (tdev->vdd)
 		regulator_disable(tdev->vdd);
 err_power:
+	clk_disable_unprepare(tdev->clk_fuse);
 	return ret;
 }
 
 static int
 nvkm_device_tegra_power_down(struct nvkm_device_tegra *tdev)
 {
-	int ret;
+	int ret = 0;
 
 	clk_disable_unprepare(tdev->clk_pwr);
 	clk_disable_unprepare(tdev->clk_ref);
 	clk_disable_unprepare(tdev->clk);
 	udelay(10);
 
-	if (tdev->vdd) {
+	if (tdev->vdd)
 		ret = regulator_disable(tdev->vdd);
-		if (ret)
-			return ret;
-	}
 
-	return 0;
+	clk_disable_unprepare(tdev->clk_fuse);
+
+	return ret;
 }
 
 static void
@@ -308,6 +312,12 @@ nvkm_device_tegra_new(const struct nvkm_device_tegra_func *func,
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
2.53.0


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23223CA5FF5
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C8410EAB7;
	Sun,  4 Oct 2026 17:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=nozomi.space header.i=@nozomi.space header.b="wIkzRjuc";
	dkim-atps=neutral
X-Greylist: delayed 411 seconds by postgrey-1.36 at gabe;
 Sat, 03 Oct 2026 19:55:16 UTC
Received: from mail.nozomi.space (mail.nozomi.space [139.162.184.125])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3FE010E0AD
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 19:55:16 +0000 (UTC)
From: =?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozomi.space;
 s=mail; t=1791056902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HraEEpEdGVBYWTLlBqG2kmzgWAR+SK/1EVJ+uvOgSpY=;
 b=wIkzRjucwI/Q3t/e3cn/+zZMST/g8VusHITpgQ4TDb6Qx+SCPp4DHd/VX6q+C30NwCmeBy
 pu8FtUKJOlVzOFvbmRxkdrpljIbB8L0MrGWLU9UAAGeegd7slaJErJHW/S+y/I9fsKJn/M
 tcJ5NAlY/yL3lZHwthVJKL79UuVmzbcPzw/T+eAnhiNE342kJRhjmi0zvXryK4M4bN04sN
 8QY/Ziw8twCYLxyrETSh3+BG5vkGSCJqGV+/FYhLirEe0FgzddpRMDO3BrEQuvSSLmSUWD
 bQ11j2/aFoJQNIbPdHuEpuQrNL5vgiTYZGiucEdijMryMVCZh89rC+6M+40bLw==
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Rob Herring <robh@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
Subject: [PATCH] drm/panfrost: Unprepare clocks on system suspend
Date: Sat,  3 Oct 2026 21:48:20 +0200
Message-ID: <20261003194820.840641-1-michal@nozomi.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

With GPU_PM_CLK_DIS, system suspend only disables the GPU clocks, which
leaves them prepared. Some providers power a clock down only in
unprepare: MediaTek PLLs are switched off in mtk_pll_unprepare(). On
MT8188 this keeps MFGPLL running through suspend, and TF-A refuses the
26 MHz-off state because of it:

  suspend: bus26m total blocked = 0x40040000

The SoC then only reaches a shallower sleep state, never signals sleep
to the EC, and the EC reports a sleep hang and wakes the system.

Use clk_disable_unprepare() on suspend and clk_prepare_enable() on
resume. Both run in process context, so preparing is allowed.

Fixes: 56e76c017918 ("drm/panfrost: Implement ability to turn on/off GPU clocks in suspend")
Signed-off-by: Michał Kopeć <michal@nozomi.space>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 485349faf2511..3f1a8109a79a4 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -507,12 +507,12 @@ static int panfrost_device_resume(struct device *dev)
 	}
 
 	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
-		ret = clk_enable(pfdev->clock);
+		ret = clk_prepare_enable(pfdev->clock);
 		if (ret)
 			goto err_clk;
 
 		if (pfdev->bus_clock) {
-			ret = clk_enable(pfdev->bus_clock);
+			ret = clk_prepare_enable(pfdev->bus_clock);
 			if (ret)
 				goto err_bus_clk;
 		}
@@ -526,10 +526,10 @@ static int panfrost_device_resume(struct device *dev)
 
 err_resume:
 	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS) && pfdev->bus_clock)
-		clk_disable(pfdev->bus_clock);
+		clk_disable_unprepare(pfdev->bus_clock);
 err_bus_clk:
 	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
-		clk_disable(pfdev->clock);
+		clk_disable_unprepare(pfdev->clock);
 err_clk:
 	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
 		dev_pm_opp_set_opp(dev, NULL);
@@ -545,11 +545,15 @@ static int panfrost_device_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Unprepare as well: some clock providers, e.g. MediaTek PLLs, only
+	 * power down in unprepare, and a running GPU PLL blocks system sleep.
+	 */
 	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
 		if (pfdev->bus_clock)
-			clk_disable(pfdev->bus_clock);
+			clk_disable_unprepare(pfdev->bus_clock);
 
-		clk_disable(pfdev->clock);
+		clk_disable_unprepare(pfdev->clock);
 	}
 
 	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))

base-commit: 70456f05d4b6396b22048c4b8cd3cb98ecf9f9e3
-- 
2.55.0


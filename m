Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7659C624DE
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 22:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7874110F372;
	Wed,  2 Sep 2026 22:54:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Xe0KX0YW";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30DE010E532
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 22:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788389653;
 bh=zhWpF/UU05YTXxYJbSUFS3lUsjEwItB+y5/lTPeSYxA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Xe0KX0YWlXuD2ovdBKm7AxKZ6y0Wc31ASO3pd1r7Ij7RVjj+efbvZmdcmN7mYVxvm
 7t9Ou8ILBdDHu27BqQkIOxBAilO4hWqLKig5S2GoErMWG5YxTs39hXNELq2UG4BJ8p
 gAdYEfdV1yghjoQVMfjuNtQwAx/j/bC4vMXtf1HAEW9Hd8re+N5b+itUVXTpElamPB
 SCSuKX1F7rZrF0mQ0varuR84fMU36yOdXGVMecIims+4s8pta06jSjCYGx5NKAU1rR
 6pHz1hSmGXQGg43JR/swyAsO/qcVxnibEc9UsXbt7UyxdFp+4o1FDWy+/zsf+n7opg
 y/uI3DUMs7Zrg==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2B4F517E0DC3;
 Thu, 03 Sep 2026 00:54:13 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 03 Sep 2026 01:54:09 +0300
Subject: [PATCH v4 02/14] drm/rockchip: vop2: Fix resource leak on
 vop2_enable() error path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-dw-hdmi-qp-yuv-v4-2-fb45bf4147eb@collabora.com>
References: <20260903-dw-hdmi-qp-yuv-v4-0-fb45bf4147eb@collabora.com>
In-Reply-To: <20260903-dw-hdmi-qp-yuv-v4-0-fb45bf4147eb@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Daniel Stone <daniels@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: kernel@collabora.com, Andy Yan <andyshrk@163.com>, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Igor Paunovic <royalnet026@gmail.com>
X-Mailer: b4 0.15.2
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

vop2_enable() returns void, so callers cannot tell whether powering up
the VOP2 succeeded.

Additionally, if rockchip_drm_dma_attach_device() fails, vop2_enable()
returns without disabling the core clocks or dropping the runtime PM
reference taken earlier, leaking both.

Make vop2_enable() return int and unwind all resources on every failure
path.  As disabling the core clocks is also needed in vop2_disable(),
factor it out into a local helper used by both.

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260623202043.8BFE21F000E9@smtp.kernel.org/
Link: https://lore.kernel.org/all/20260623202043.8BFE21F000E9@smtp.kernel.org/
Tested-by: Igor Paunovic <royalnet026@gmail.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 39 +++++++++++++++++++---------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index b2f3a579bbe5..819ea3400bcd 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -860,6 +860,13 @@ static int vop2_core_clks_prepare_enable(struct vop2 *vop2)
 	return ret;
 }
 
+static void vop2_core_clks_disable_unprepare(struct vop2 *vop2)
+{
+	clk_disable_unprepare(vop2->pclk);
+	clk_disable_unprepare(vop2->aclk);
+	clk_disable_unprepare(vop2->hclk);
+}
+
 static void rk3588_vop2_power_domain_enable_all(struct vop2 *vop2)
 {
 	u32 pd;
@@ -871,7 +878,7 @@ static void rk3588_vop2_power_domain_enable_all(struct vop2 *vop2)
 	vop2_writel(vop2, RK3588_SYS_PD_CTRL, pd);
 }
 
-static void vop2_enable(struct vop2 *vop2)
+static int vop2_enable(struct vop2 *vop2)
 {
 	int ret;
 	u32 version;
@@ -879,25 +886,24 @@ static void vop2_enable(struct vop2 *vop2)
 	ret = pm_runtime_resume_and_get(vop2->dev);
 	if (ret < 0) {
 		drm_err(vop2->drm, "failed to get pm runtime: %d\n", ret);
-		return;
+		return ret;
 	}
 
 	ret = vop2_core_clks_prepare_enable(vop2);
-	if (ret) {
-		pm_runtime_put_sync(vop2->dev);
-		return;
-	}
+	if (ret)
+		goto err_put_pm;
 
 	ret = rockchip_drm_dma_attach_device(vop2->drm, vop2->dev);
 	if (ret) {
-		drm_err(vop2->drm, "failed to attach dma mapping, %d\n", ret);
-		return;
+		drm_err(vop2->drm, "failed to attach dma mapping: %d\n", ret);
+		goto err_disable_clks;
 	}
 
 	version = vop2_readl(vop2, RK3568_VERSION_INFO);
 	if (version != vop2->version) {
 		drm_err(vop2->drm, "Hardware version(0x%08x) mismatch\n", version);
-		return;
+		ret = -EINVAL;
+		goto err_detach_dma;
 	}
 
 	/*
@@ -932,6 +938,17 @@ static void vop2_enable(struct vop2 *vop2)
 		    VOP2_INT_BUS_ERRPR << 16 | VOP2_INT_BUS_ERRPR);
 	vop2_writel(vop2, RK3568_SYS1_INT_EN,
 		    VOP2_INT_BUS_ERRPR << 16 | VOP2_INT_BUS_ERRPR);
+
+	return 0;
+
+err_detach_dma:
+	rockchip_drm_dma_detach_device(vop2->drm, vop2->dev);
+err_disable_clks:
+	vop2_core_clks_disable_unprepare(vop2);
+err_put_pm:
+	pm_runtime_put_sync(vop2->dev);
+
+	return ret;
 }
 
 static void vop2_disable(struct vop2 *vop2)
@@ -942,9 +959,7 @@ static void vop2_disable(struct vop2 *vop2)
 
 	regcache_drop_region(vop2->map, 0, vop2_regmap_config.max_register);
 
-	clk_disable_unprepare(vop2->pclk);
-	clk_disable_unprepare(vop2->aclk);
-	clk_disable_unprepare(vop2->hclk);
+	vop2_core_clks_disable_unprepare(vop2);
 }
 
 static bool vop2_vp_dsp_lut_is_enabled(struct vop2_video_port *vp)

-- 
2.55.0


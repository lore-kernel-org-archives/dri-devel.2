Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5326082BFF
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=hRjvfwyU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD73B10E3F6;
	Thu,  5 Nov 2026 01:01:15 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5501910E3F2
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 01:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793840467;
 bh=yymjG31JJ8kOjRl1351lsr7olGfy6eylum5Lxqg7q60=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=hRjvfwyUbLrW2/ZfhRdkq7GHO52ZCtSK4NsReeaO9XxGz7qjtqQWU3LrljiVWpVdP
 OkjumEiharb2y8xmoVuyLTwdsEWcNVWV27hDIM2h/tRrxursFhwjOc5hRGJUvZUMnt
 5QScjVVmIVOM1ldltR7e6GRXAVaFpK+JluK+0InSGDA+Gaqbnzv46sH+7Lvoa6xHmc
 mnXu+Hw5x8p3D2RfopAAk2N9MXMRkk/v7ZMpvQGDS1rFf6W6J7n7kp6/vH39alFOHp
 qq9P15ZduoWj2uwB2XIriBIcPIqSnZsNpKUY44w2875NvK85LxF9417PWOROfQ4Ai3
 wWXB7rk+Eu/xg==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 72DA117E0CF7;
 Thu, 05 Nov 2026 02:01:07 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 05 Nov 2026 03:00:36 +0200
Subject: [PATCH v6 02/15] drm/rockchip: vop2: Fix resource leak on
 vop2_enable() error path
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-dw-hdmi-qp-yuv-v6-2-1bb63ef5766e@collabora.com>
References: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
In-Reply-To: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Daniel Stone <daniels@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniel@fooishbar.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, Igor Paunovic <royalnet026@gmail.com>
X-Mailer: b4 0.15.2
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
Reviewed-by: Daniel Stone <daniels@collabora.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 39 +++++++++++++++++++---------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index bfb384142568..e0caea93a896 100644
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


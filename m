Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19A7CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 11:30:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC84910F01E;
	Thu,  7 May 2026 11:30:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OA82KaYH";
	dkim-atps=neutral
Received: from mail-m1973179.qiye.163.com (mail-m1973179.qiye.163.com
 [220.197.31.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D17C10F01C
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 11:30:17 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3d7b63a84;
 Thu, 7 May 2026 19:30:12 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, nicolas.frattaroli@collabora.com,
 cristian.ciocaltea@collabora.com, sebastian.reichel@collabora.com,
 dmitry.baryshkov@oss.qualcomm.com, luca.ceresoli@bootlin.com,
 dianders@chromium.org, m.szyprowski@samsung.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v3 10/10] drm/rockchip: analogix_dp: Add support for RK3576
Date: Thu,  7 May 2026 19:29:48 +0800
Message-Id: <20260507112948.1115003-11-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507112948.1115003-1-damon.ding@rock-chips.com>
References: <20260507112948.1115003-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e0233d67a03a3kunm4d1cbcd72742
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHxhPVh5IS0xCGB1CTR9KTVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=OA82KaYHjMb7gMfrthk4mC9R/T7KFhGa5jRiZA7GYE5vmt/OsgzTLRm6b9iSpTxF9mSog+aR+SjBEanTq7X+B06xHTnAth8M6lPvXsDNbJ3sDKzSWMt/8n3Fc6M+4bARh+mMCHcxsLraH1yoTFSjdBskCiU9QBSZaxmj+H/HH94=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=sO+oTKqw2ne9EcS/rAtbJzqhHraiHwvETBiNmNIcMKw=;
 h=date:mime-version:subject:message-id:from;
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

RK3576 integrates the Analogix eDP 1.3 TX controller IP and the HDMI/eDP
TX Combo PHY based on a Samsung IP block - both of which are the same as
those on RK3588.

The patch currently adds only the basic support, specifically RGB output
up to 4K@60Hz, without the tests for audio, PSR and other eDP 1.3 specific
features.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
Reviewed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v2:
- Split out a separate patch to enable the "hclk" clock.
- Add Reviewed-by tag.

Changes in v3:
- Add Reviewed-by tag.
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index a864bcf8200e..75706a2fdba8 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -522,6 +522,14 @@ static const struct rockchip_dp_chip_data rk3288_dp[] = {
 	{ /* sentinel */ }
 };
 
+static const struct rockchip_dp_chip_data rk3576_edp[] = {
+	{
+		.chip_type = RK3576_EDP,
+		.reg = 0x27dc0000,
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_dp_chip_data rk3588_edp[] = {
 	{
 		.edp_mode = GRF_REG_FIELD(0x0000, 0, 0),
@@ -539,6 +547,7 @@ static const struct rockchip_dp_chip_data rk3588_edp[] = {
 static const struct of_device_id rockchip_dp_dt_ids[] = {
 	{.compatible = "rockchip,rk3288-dp", .data = &rk3288_dp },
 	{.compatible = "rockchip,rk3399-edp", .data = &rk3399_edp },
+	{.compatible = "rockchip,rk3576-edp", .data = &rk3576_edp },
 	{.compatible = "rockchip,rk3588-edp", .data = &rk3588_edp },
 	{}
 };
-- 
2.34.1


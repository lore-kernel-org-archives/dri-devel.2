Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4062CD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 18:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FE6410E38F;
	Sun, 10 May 2026 18:33:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="rVeg3W4y";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65CF110E38F
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 18:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1778437952; bh=3Bb2d7ztUbMfwQrlOvAngrNnijawNk2qKWlgV+cKiBU=;
 b=rVeg3W4yxXyz6aQ5x2qJVPnUMQXnSCsEnvDsKkhM2gd4Eyh0SO6Smx6YjrVcWmFHSECKVQtUu
 RFcpHxS7/D3otDATi8gPkCHnBsZWYdQS0m6hPXgcFeNvo0Dkgh478gTBgQ9yBMca4kpauppsetE
 5tjbIghxBJYMN09g5a4o+n+pIWDmUET0rRyt/r9mQOQppD6llxiyByCCGD6zRk7Xw7qB3rIeKoK
 8F12qUVPpDtl1Gjyxehf+bp5bRDptyUbIfsiR8EDr4ZUFwnnV4+KiQN9ZPkRpNgCniEgsLjr3bU
 Yf1KzfGfG3lZcwqb6Xy125tCgzAdDdTDHvqg/1LfycGA==
X-Forward-Email-ID: 6a00cf1761db3ab145b0f2e3
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.8.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 08/10] drm/rockchip: dw_hdmi: Set output_port for RK3568/RK3566
Date: Sun, 10 May 2026 18:31:09 +0000
Message-ID: <20260510183114.1248840-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510183114.1248840-1-jonas@kwiboo.se>
References: <20260510183114.1248840-1-jonas@kwiboo.se>
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

All in-tree RK3568/RK3566 device trees using HDMI also include the
required hdmi-connector node at port@1 since their introduction.

Define the output_port for RK3568 so that dw-hdmi bridge driver can pick
up the display-connector bridge once the dw-hdmi connector is replaced
with a bridge connector in a future change.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index a55a89040590..9d3bb6cd5670 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -459,6 +459,7 @@ static const struct dw_hdmi_plat_data rk3568_hdmi_drv_data = {
 	.phy_config = rockchip_phy_config,
 	.phy_data = &rk3568_chip_data,
 	.use_drm_infoframe = true,
+	.output_port = 1,
 };
 
 static const struct of_device_id dw_hdmi_rockchip_dt_ids[] = {
-- 
2.54.0


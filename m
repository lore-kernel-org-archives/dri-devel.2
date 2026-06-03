Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B696CCD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E898A10F809;
	Wed,  3 Jun 2026 03:36:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="kOpvqKA6";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83C0210F809
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 03:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1780457755;
 bh=Nmbv8Af+wn8GxgsI5KbsX623W9if0KYAzDG7qaBuvy8=;
 h=From:To:Subject:Date:Message-Id;
 b=kOpvqKA61qczRSzYwA9rdVHuSVhhxZmGIagndkjnk4fifqxBx572+3z1qwasqLbMS
 8oyI7eUWTmi+yEwInCO6SbWJT0xHC3L7vsFzYmMBEpsj9z4SxUMxyjwtSCx6eWMeCn
 EPhR8ISMdrflLjkaLyG3G30h+gcPsQH1z+/0LSU0=
X-QQ-mid: zesmtpsz3t1780457753tfeae0ad2
X-QQ-Originating-IP: v8CFSfe18ydj3/X7gTk4nHozbWXSsyBpdug+YL4Sers=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 03 Jun 2026 11:35:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2467474542315204252
From: Chaoyi Chen <kernel@airkyi.com>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Guochun Huang <hero.huang@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH v2 3/3] drm/rockchip: dsi: Relax the lane rate margin
 requirements
Date: Wed,  3 Jun 2026 11:35:32 +0800
Message-Id: <20260603033532.164-4-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260603033532.164-1-kernel@airkyi.com>
References: <20260603033532.164-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MPAlP4yRn0xgAbGtHWBUNA1oQ9EzpGQsWa0kNjys9WUXphk02q2kpgmn
 lHsQNenkcAPtlrDVGxURgna1xlWDhQoaKnW831b3Yl/UrqzZeODArm7F45WlgGj1ALLaGy/
 cJ49hWSsdfnaP9mazYRTcxnvdAK8x+a02RJSoakZ8foEoS2W7dUIUPYy7Lfrfm4526qRRda
 F2mgvgCYmtWuVg6di4uL7gGTs9uG+wI7Tbaz1RFjx0shQdkqlh8M47tajTP3gonyz1K69er
 q9AWg/RYMmnJ1ZjM6v89WJiyHai+hwCmPU2Mx7crHkk1NMv5rocffRRa5qcdlp5mQoHkELK
 TZLOtFC9Pe/gvppB9+T+bVtzbml/KiVdGhClbOF1VrIZJPNEMyN6donopoErHKgwmnwlTDs
 FoWQ+AAqRUBpBgtD2D6k0Ads07ck5YGgitGulgYv5ivbeGBAT8EOImefDSV97mwvSu1Ds1Q
 9FMnqlk8J+NmYkVdajRIqvsMMuH22vO0BSbq6cKMVdo5ZaaKXDEvK6ADkwKLcDLuDK+3wJ8
 l12EkQvjvaLjIPsOkVae3lmZfHn/xVaU6jFzWiD33ZpqofX4XIgxQXpfAwZ3uWfIhiHS2VU
 VxQuuEkxgi2M+kXmiW8FM+RNcl27L4bGwUVuhLfI/zBPdEzZvZshbhr4ZeWuwPqDIgX5qwq
 aTaDoBzQzViPLV2kDB+0iWhw80xsfHSjylaZlUIjFcge2n+/gpFE/mrwg9HvXizT5abCvru
 dmEMInmQx5YsH4uPSCzQf5+ItJcKXwzhShsvtEFu1Qwx2+meFYafHOoosF3d6fNC0RaAfdt
 toR/LjdijHvsEzMbu2v2UcQVDVv3nVx5ykDziqR5ss9t416YPn/Zjq8DgOHOYd3MNKaDYpA
 /4D6Vp2RK8f+bhbuYpc0fk+fshYgdE0MCiK4EF+TNel+L09hgU8csn7OjYjy3sgIQQ2UNpx
 YzooYIiWUMG1GhDuj8Q/qnlttIIgLMdcDLWVanLQiA3hHUpGjrXItHuF2yrPJYba75/zVH2
 DmPv/EgGsWkFfB4EMM99CjFbAoXZMdU8tdrcSlSzAUjSPMhwAc
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
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

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

The lane rate is calculated as follows:

	Lane_Rate = Pixel_Clk * BPP / lanes * Overhead

The overhead factor is set to 1/0.8, equivalent to a 25% overhead.

Now let's consider the case of RGB888 (BPP24) with a pclk of 148.5MHz.
The lane rate equals 148.5M * 24 / 4 * 1.25 = 1113.75 Mbps.

However, this is beyond the capability of certain platforms limited to a
1Gbps lane rate. On the other hand, we have observed that some DSI panel
actually perform worse with higher overhead.

So we are considering relaxing the bandwidth margin requirements.
According to the downstream test results, adopting 1/0.9 seems to
be a sound approach, corresponding to an overhead of about 11%.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index e64dfc327891..8af9d6934d27 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -590,8 +590,8 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
 
 	mpclk = DIV_ROUND_UP(mode->clock, MSEC_PER_SEC);
 	if (mpclk) {
-		/* take 1 / 0.8, since mbps must big than bandwidth of RGB */
-		tmp = mpclk * (bpp / lanes) * 10 / 8;
+		/* take 1 / 0.9, since mbps must big than bandwidth of RGB */
+		tmp = mpclk * (bpp / lanes) * 10 / 9;
 		if (tmp < max_mbps)
 			target_mbps = tmp;
 		else
@@ -601,7 +601,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
 
 	/* for external phy only a the mipi_dphy_config is necessary */
 	if (dsi->phy) {
-		phy_mipi_dphy_get_default_config(mode->clock * 1000 * 10 / 8,
+		phy_mipi_dphy_get_default_config(mode->clock * 1000 * 10 / 9,
 						 bpp, lanes,
 						 &dsi->phy_opts.mipi_dphy);
 		dsi->lane_mbps = target_mbps;
-- 
2.53.0


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2631FC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E0F710EE96;
	Wed, 12 Aug 2026 07:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="OdjaFTX0";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.155.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F82F10EE96
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 07:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1786519876;
 bh=xwkwTG7s53pnZe6rR+ByPjuw32Fjs/KmR4y/OSRwSjI=;
 h=From:To:Subject:Date:Message-Id;
 b=OdjaFTX0RregN4Pcswk3h3kDPfYMXCf3rO99dQJY+I4l2RsjysLqn9tzb+uKrJK5O
 ykz7seRzFDpJABU86YkFuBOrdIYgh252euy5mL4KsK9tBtK5dQPfJ8lTb9YpHYS3Eg
 rdUOqgcElQ4drPmH3gCpLYNOxd/HMh86DvnLt/I8=
X-QQ-mid: esmtpsz11t1786519874t58231220
X-QQ-Originating-IP: DecthGFCCJIjKGuRx0srYCYndBPraDw/pqHun5spefk=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 12 Aug 2026 15:30:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17205722276426766371
From: Chaoyi Chen <kernel@airkyi.com>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH v4 3/3] drm/rockchip: dsi: Relax the lane rate margin
 requirements
Date: Wed, 12 Aug 2026 15:30:02 +0800
Message-Id: <20260812073002.328-4-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260812073002.328-1-kernel@airkyi.com>
References: <20260812073002.328-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Msjb2/dpc05VYijSOcDfHJFcvCbckJp0PwFkAiXi4rhw5lzr5TyGvfxh
 0xKgBDk4rlo2u3b1xbr+RfGK/bl+gE9ehpHbxqh3983bRyPRKKHAulOgj5JyCGIHT454J0N
 mRNJilqR0nuT8lVc6qv7C/dIf3NhzIqgf9dWzv1uLMGvNhxEiqCihQk24r4pP51Muuikfre
 8lEjeYf09e6oeqTuSQD9StbaQRXJfhoeGwNwyLVHTZjxxlRWTpcdOwp9cvW6ahd4/iDg88w
 Vz8j8aVk42DYRdnlQWsqxXfydjWaYZ6fkt8bZwCm6kHO29kyrK5uTDtqG5BhoCQXcmA53lo
 XsHcBuiJsgsGDwrBXsfrAgU4e6Bo9q+2QydPMcarjilQkzz390BLwQlYuvbdKJI9CoGdS28
 XdmENrnmZw3SFpOJovlIGjJUqVxe/Cw7rgdq88Ahz+CW5OWhPBmd0nG3VXP5QSEuIGh7Mjo
 nAXf/mFBjMXoPP3+n7Xt2Ve1iRiZHSoXgjScDd0b3fCZFZk6tMzVcFFqO17PnZ59ejDpFAV
 1ut1fGbIUASHr4L8gFip/6p7j8ESHHbNeo7KdQHGVEAFGwiH2RYElcPL4Jw+GJaZvYKv1WW
 enrKHPRjbnbZGmCElLZEBu+2UrP8FFc4dG4Igu0/eK2pHtQepk8YWzOicz5ocX4JYCOJzky
 OCXBLeLEBqFdt1qG2MaS5YebtQB6CiYtS24c1YYBqwYZdS3ihNAvOuKNG2asDkxpMGSv+hc
 t/BeUCbUQvF6HldIiHd1+Du5of/EmxLuvme0JBQ3PH6WAa1ip6hxi4B2yaAHKXoY0vk9zoi
 VbawNLFOAU03CG5zwz8+DRFsW4mkRnu8jD+PRma3V7hNtmZzUEPOCM2I6WFADeEWEOL2MQ7
 a1lt+/T09Z48DIWgS0wbh6L80OHxGRtgLqDDoBvuPsL6B8RDY2N6WoQD4U6WmsKk6/0KZxl
 TJhhO2res9oBnwX/1noXOEpkSLoQwjXGd9oU7SJ5CQVZ8YWdK9taRd62BKobHt5RHnoy93P
 0Ith4h8PjTDNSGcjXJ311LddjKQ+EzuwJslHAmrInVPQv6PaWP
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

	Lane_Rate = Pixel_Clk * (BPP / lanes) * Overhead

The overhead factor is set to 1/0.8, equivalent to a 25% overhead.

Now let's consider the case of RGB888 (BPP24) with a pclk of 148.5MHz.
The lane rate equals 148.5M * (24 / 4) * 1.25 = 1113.75 Mbps.

However, this is beyond the capability of certain platforms limited to a
1Gbps lane rate. On the other hand, we have observed that some DSI panel
actually perform worse with higher overhead.

So we are considering relaxing the bandwidth margin requirements.
According to the downstream test results, adopting 1/0.9 seems to
be a sound approach, corresponding to an overhead of about 11%.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
Changes in v4:
- Fix potential overflow and underflow issues in bandwidth
  calculation(sashiko).

Changes in v3:
- Rebase to Linux v7.2

---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index d183c82ef9bc..77f9c5883987 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -590,8 +590,8 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
 
 	mpclk = DIV_ROUND_UP(mode->clock, MSEC_PER_SEC);
 	if (mpclk) {
-		/* take 1 / 0.8, since mbps must big than bandwidth of RGB */
-		tmp = mpclk * (bpp / lanes) * 10 / 8;
+		/* take 1 / 0.9, since mbps must big than bandwidth of RGB */
+		tmp = DIV_ROUND_UP(mpclk * bpp * 10, lanes * 9);
 		if (tmp < max_mbps)
 			target_mbps = tmp;
 		else
@@ -601,7 +601,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
 
 	/* for external phy only a the mipi_dphy_config is necessary */
 	if (dsi->phy) {
-		phy_mipi_dphy_get_default_config(mode->clock * 1000 * 10 / 8,
+		phy_mipi_dphy_get_default_config((u32)mode->clock * 1000 * 10 / 9,
 						 bpp, lanes,
 						 &dsi->phy_opts.mipi_dphy);
 		dsi->lane_mbps = target_mbps;
-- 
2.53.0


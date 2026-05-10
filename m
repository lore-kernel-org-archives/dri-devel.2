Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7610FCD37B2
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 18:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B74810E39A;
	Sun, 10 May 2026 18:33:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ke28cI8f";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65D5110E39A
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 18:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1778437952; bh=dNPaQCnAPaiK+mPtt3ofIMa62zudp1cWsYh8OqqpZUE=;
 b=ke28cI8fgrpE83apZHbF44ngwmhRPYHcIKxXLgjY0ZgLkiStHDM/UG5TAut/XIJMl+kXMvwS/
 MjurU/CUcG4KW/cGx1Kpdu/FvtnUKEopH7PmmXiaZa9XJmJKfsPCMPQ2cqVQdjTo4fZRjqPryHG
 o1xTcKilb+L7sj8FbjZW8A0j1zRgRZIKCP1zJaylP1xAnrkhGPplDXuSS6FItMVqSYazWFk9QQw
 IQHenei4vekC8XTXGKopBvkb+mZ7lzMnJ6pxgylUeGfo5hetlQNvz6+E7jjnJB4vH/MWnuXKsUO
 W6ePuojMNgZ/XzPwieTByVsd67HNfzJybnxLjn/iElkw==
X-Forward-Email-ID: 6a00cf1361db3ab145b0f2c8
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
Subject: [PATCH 07/10] drm/rockchip: dw_hdmi: Clean up whitespace
Date: Sun, 10 May 2026 18:31:08 +0000
Message-ID: <20260510183114.1248840-8-jonas@kwiboo.se>
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

Move the blank line before the RK3328 definitions for readability and
make the phy_config table spacing consistent with other tables.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 6aefdba0f1f9..a55a89040590 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -31,8 +31,8 @@
 
 #define RK3288_GRF_SOC_CON6		0x025C
 #define RK3288_HDMI_LCDC_SEL		BIT(4)
-#define RK3328_GRF_SOC_CON2		0x0408
 
+#define RK3328_GRF_SOC_CON2		0x0408
 #define RK3328_HDMI_SDAIN_MSK		BIT(11)
 #define RK3328_HDMI_SCLIN_MSK		BIT(10)
 #define RK3328_HDMI_HPD_IOE		BIT(2)
@@ -190,11 +190,11 @@ static const struct dw_hdmi_curr_ctrl rockchip_cur_ctr[] = {
 
 static const struct dw_hdmi_phy_config rockchip_phy_config[] = {
 	/*pixelclk   symbol   term   vlev*/
-	{ 74250000,  0x8009, 0x0004, 0x0272},
-	{ 165000000, 0x802b, 0x0004, 0x0209},
-	{ 297000000, 0x8039, 0x0005, 0x028d},
-	{ 594000000, 0x8039, 0x0000, 0x019d},
-	{ ~0UL,	     0x0000, 0x0000, 0x0000}
+	{ 74250000,  0x8009, 0x0004, 0x0272 },
+	{ 165000000, 0x802b, 0x0004, 0x0209 },
+	{ 297000000, 0x8039, 0x0005, 0x028d },
+	{ 594000000, 0x8039, 0x0000, 0x019d },
+	{ ~0UL,	     0x0000, 0x0000, 0x0000 },
 };
 
 static enum drm_mode_status
-- 
2.54.0


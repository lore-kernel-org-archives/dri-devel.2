Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3650C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 03:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0DAB10E5EC;
	Mon, 10 Aug 2026 03:42:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="i7a45yaU";
	dkim-atps=neutral
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 443FA10E5EC
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 03:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1786333321;
 bh=zZPHKAb4cQrm49yOWXVCco4Ik7cW5gVTYE6ZncjdyGU=;
 h=From:To:Subject:Date:Message-Id;
 b=i7a45yaUOw+8mK15w0QhWF24XhWCJQEFm4lTj6qWKBBRIx7IDIaZBIN685CxAIFuh
 MgwlDQ9G7YmId/CMzwmTuM3i+y0cSogKThnBut5HQmVAJUW0KYUL0KMAy7vwOBoYxz
 y/7ZU0V2IgS++pJljjst1EDqKmCuh3RwhOUsrVtk=
X-QQ-mid: esmtpgz11t1786333319ta5004747
X-QQ-Originating-IP: FzKXUfXcJRl+i5lpm+GZGGkz2W35HG/bWGSZUC3Gv2k=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 10 Aug 2026 11:41:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5057061470933120758
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
Subject: [PATCH v3 3/3] drm/rockchip: dsi: Relax the lane rate margin
 requirements
Date: Mon, 10 Aug 2026 11:41:39 +0800
Message-Id: <20260810034139.148-4-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260810034139.148-1-kernel@airkyi.com>
References: <20260810034139.148-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Me7Lc1PqlyGBLxyGTN4KUFCwVev0JeWu4sgyCqkdibQ16buVKkZ3zU2r
 x0eWcf5v3QBd+S5YFM9JJvnhRpLOCVvpvAVkNsfGrzteGL//ubqHAT9TpZUNSJUALnuJUl/
 r8LaNGGzuHqYzJB3D+GsXTb34cRNbVJcUyWbEACUpUwN1fBNvyr/0XIb0bTEzdRY3+dZlPV
 LupqY8fqt2AsnzwO5iVxECGg8j8TKAJ3dYCZnJ/H9Rm7oJF9xNgi6fK0cqad9NIE0rf/Un2
 xl5W5yUZLx/u+jzQjOU/NbRGPUmrYh1QORxQf1cXyYrEORvonKi0CDZHeMWLxpXvo+9Q7Y4
 aiJms3aS8tqIHXb9NkEliOKCg5vZXnu6o6FV/htpgRqr2nWjWbhPym6enDdlbb3IBhNvXsH
 Mg0oem8tGvG1x50HPZSPwrrhYRx20n9k+285XrHPQXeFJEd+Bdlpea76WYKcnjRTLzIi4bB
 i8Hv1nwdXH5ICiEQax94rB2a3pdRWEVrpv/cQ13dy+v+DR5ACiPdVrwEO/dJOdtsCALRETE
 K3CHuyIAoefxwJY+Jh4TZDEJUNRD+EE6ICpuE1koszJkw1NVIfUBMe9rMQaGJeSMkmPBIaN
 8sIRt9VEF3W6zEa4WkNDSgqqVBMTvf5O/8WujUC+BhxIqCN8HHtdYc9XYjpqFgpBRfcUaFs
 PsqimdcTQvoMciItq6x0qXGNp3z7xsDsiX5tjKjfvV2xbMU2/VYZ6YtYyPU5F21lc6mdIR/
 hBKHo3aLSFiLYEiLVVWPOmUEj8/O56kZGiiN4e/VRG9ZEWWVmxnrMPTwGerqezSqGNlyz8L
 ytgNy4+e6CKNlbU9w1ru94XC6XWO1a+hklKg/8eyyxIs8p40S6smLD+4I3dyw4Wu+hQlQXX
 vSkXDBY+YJJycDmQ0GYesSrwMlaaMihNOMNrF5CYK86vX9aBt/Sy8a/LHaEO5Li5AOY8bWr
 BDUgUGBptg2cp0kXfyeUDPzD+su5hTqSWZ9eWdMFX40ovtjm5Lp1lDCn6Bw+H/E1EM990qB
 eZJn8wAa1jB5IDmk5lb8lpc2S4FlE=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
Changes in v3:
- Rebase to Linux v7.2

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


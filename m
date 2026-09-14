Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9A0C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 01:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CD4210EAC4;
	Mon, 14 Sep 2026 01:34:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="HyemzXWh";
	dkim-atps=neutral
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 440A210EAC8
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 01:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1789349641;
 bh=89G/jVXBHYq95wHmsk/YMSS2ZgjD1A+zfs9MI2Z6US4=;
 h=From:To:Subject:Date:Message-Id;
 b=HyemzXWh/cATIJzcp1v3LaP2mKhswVVuCFt2XyNphIPRdK+yE+2ynxk6YK2jHr+mP
 kz3l3VEkFbEul1jsOgBuPyDqyA0JVbYoY4pJyXbvoPEjtoLBoPOGOvKh/AzwSDHSEL
 fhMOfTItv0+I8iVMh8UTnBCtNkzt3kgnYuixAiUU=
X-QQ-mid: esmtpsz11t1789349639t02dd2c0a
X-QQ-Originating-IP: Ms0+P2o6VKkDSoj777ATB5OiGA9xJm/wRP1HplqoNm4=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 14 Sep 2026 09:33:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8457655560534522098
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
Subject: [PATCH v5 3/3] drm/rockchip: dsi: Relax the lane rate margin
 requirements
Date: Mon, 14 Sep 2026 09:33:31 +0800
Message-Id: <20260914013331.108-4-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260914013331.108-1-kernel@airkyi.com>
References: <20260914013331.108-1-kernel@airkyi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OE3tIrIEWSq4VEpIizUkLPVL2WHUpRdC3KvBS4D96fdYJVckIEfDqang
 FM6W1+/q4yPZUgpoQ7g+ME2RGHK25hCAqSk2vil+jkoW3zjOBd7F877ykY2vI57vglX2KZ2
 H0xcQsBgarz7tgQ7jBJETh9IkFTnl4r/lqyAmthXJ/vPz0dXHwzLIiXCkphMz31DV7sLvF9
 59y5+uwkGjCvY02UIHZywz0l3Fuh3PmYNe6M0JEjx7V8ykYlTklDtx6bN9ol7LjwacOsoTU
 QSjRkBu8OqXeauMbtaASKmOthRu5YrK4eMsTWr95AKM4pF7lmH8jVjyLAyOMAGM75uec1An
 KvTSbIhS7NE3iZPmRMyANmgTcYmzqGouaevMu7qEKlXl7Y6m3k1A3J5bY6wrjpWcJFdGwPh
 +/ylWl0RrebTmegVv/vG8f8KijL9jWEQXB0nTbxAn54gvwr2hFfRqs8q+Hoj3iEA3yoEJC4
 80/iFyua0NgpjxrRsWxXw90g9JlwcZDV0GDKh5nphpZbSRdKaLdKYL+Sxnen8QMSpW2YO/+
 CgFTxm+yARZJB3DwHI67jp+ofr0E+df9fmNJ9FVaEnFAN5MmFHqY+uuOnO+UFfWP2qsHX4Z
 GSrPDSeVMAuI9klUZbpmv1/5vZadnHOz4Q4+mH6pkCY7RfCQGx2ImWgZ02rkXCGu2vvY/ux
 ruwrW8rmHVp2no7cjYTVPz/wXgEo5xaONlCNNeovCNb9klzLtIijJH9qYjMM1agV+pF5RZe
 WncwirR9rQ54qmjgrfYq+GBNaIxY+Fj+QrdBr0lCffH1vxHVESSxW7rFbU5FH4BwN7Wuq78
 6/vK6BMKwRDRV/cxom/4NClNAvjkdai8MolEpDTiVpggvyd5mIQcukO1dCcJ4v+PRJh74oi
 4R5vvdLNfW9hxsHOs+XZ8dNttl2yZVbok3B4PXXl7BBxVF8WkYjIfix7E+DkvqD8vB+uy3T
 afmCVuMetw7MSm093i8RBi/+XDSPRgdlQRz5APXFNlX33SYpGJHlri1G2kyksqJz170Vlo9
 3YfDMVS+K8Zl19qPvU
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
(no changes since v5)

Changes in v4:
- Fix potential overflow and underflow issues in bandwidth
  calculation(sashiko).

Changes in v3:
- Rebase to Linux v7.2
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index feb484f7c03e..03019b99abdc 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -590,8 +590,8 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
 
 	mpclk = DIV_ROUND_UP(mode->clock, MSEC_PER_SEC);
 	if (mpclk) {
-		/* take 1 / 0.8, since mbps must big than bandwidth of RGB */
-		tmp = mpclk * (bpp / lanes) * 10 / 8;
+		/* take 1 / 0.9, since mbps must big than bandwidth of RGB */
+		tmp = DIV_ROUND_UP(mpclk * bpp * 10, lanes * 9);
 		if (tmp <= max_mbps)
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


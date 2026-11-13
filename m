Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D25606A8AA
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=i5qfWhFk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A0710FF6E;
	Fri, 13 Nov 2026 08:23:27 +0000 (UTC)
Received: from mail-m25475.xmail.ntesmail.com (mail-m25475.xmail.ntesmail.com
 [103.129.254.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9AEE10FD50
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:23:20 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 54921bdfd;
 Fri, 13 Nov 2026 16:23:17 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jingoo Han <jingoohan1@gmail.com>,
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Heiko Stuebner <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andyshrk@163.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v6 01/18] drm/bridge: Select VIDEOMODE_HELPERS for
 DRM_OF_DISPLAY_MODE_BRIDGE
Date: Fri, 13 Nov 2026 16:22:48 +0800
Message-Id: <20261113082305.541652-2-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113082305.541652-1-damon.ding@rock-chips.com>
References: <20261113082305.541652-1-damon.ding@rock-chips.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1d400fe4c03a8kunm073aab0481a12
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaT0kZVk5PTR9JSh9DGRoeHlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=i5qfWhFksLq8cnd1a+lBOnDN1h5a2ZwsvD7/onmO4MfEkfobPPxPg9mJPrqpi+9x3m2tFKD9Q2YZYTv41w1aSncg4yZNbwsalcQRLiAnFM4B1CvMITH/JMKNoLNF3fCZDxkk4V0/iRdSM+0HWPrOfTZDqAg7Y4K+BKKzEa56PIg=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=XNuY/Vo6Av48O204IEijKEDS+EVPpGFz9/aSQiiHflQ=;
 h=date:mime-version:subject:message-id:from;
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

The of-display-mode-bridge driver calls of_get_drm_display_mode(),
which is provided when VIDEOMODE_HELPERS is selected.  So far the
dependency has been satisfied by the users selecting
VIDEOMODE_HELPERS themselves (e.g. the Exynos and i.MX DRM drivers),
which breaks as soon as a user does not, resulting in undefined
references to of_get_drm_display_mode() at link time.

Select VIDEOMODE_HELPERS from DRM_OF_DISPLAY_MODE_BRIDGE, so that the
dependency is always satisfied.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 drivers/gpu/drm/bridge/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index c7da6b02d7b6..f717523014e8 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -266,6 +266,7 @@ config DRM_NXP_PTN3460
 config DRM_OF_DISPLAY_MODE_BRIDGE
 	tristate
 	depends on DRM_BRIDGE && OF
+	select VIDEOMODE_HELPERS
 	help
 	  This is a DRM bridge implementation that uses of_get_drm_display_mode
 	  to acquire display mode.
-- 
2.34.1


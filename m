Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DB7606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=R4ec0tIw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7831B10FB70;
	Wed, 25 Nov 2026 11:22:40 +0000 (UTC)
Received: from mail-m6052.netease.com (mail-m6052.netease.com [210.79.60.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12DA710FB6E
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:22:03 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 55f816034;
 Wed, 25 Nov 2026 19:22:00 +0800 (GMT+08:00)
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
Subject: [PATCH v7 05/20] drm/bridge: analogix_dp: Take a runtime PM reference
 in bridge detect
Date: Wed, 25 Nov 2026 19:21:26 +0800
Message-Id: <20261125112141.1434903-6-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125112141.1434903-1-damon.ding@rock-chips.com>
References: <20261125112141.1434903-1-damon.ding@rock-chips.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa21270ef0a03a8kunm17c23050775874
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTkhOVkNITE5ISEtNSxkfHlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=R4ec0tIwlRkqHxRkqfOX5au00NmjTlwsoP2PRcpm7JNc3ZKGSuog77dhoHoJJq1Vbtt0ldyOzwgca1eicGhEXJMdIoE8ur04j77AXIUx26XflG7vx5cjtmfQh1g0xJ/WJOaGaIqzxhg1ELXuLzC5Ey6beo+HdsOoSFWyK61uVWU=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=Z53XmwzIfWNDI57WVKpOPzyROVqB2sBaHiSyG5zofnk=;
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

The analogix_dp_bridge_detect() calls analogix_dp_detect_hpd(), which
reads the controller registers and may write them for the force HPD
fallback. The connector is polled and can be queried by userspace at
any time, so this runs while the device is runtime suspended when the
display is disabled.

Take a runtime PM reference around the HPD check, and report the
connector status as unknown when the device cannot be resumed.

Fixes: 2b77a2918c5d ("drm: bridge: analogix/dp: move hpd detect to connector detect function")
CC: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v7:
- Add this patch to take a runtime PM reference in
  analogix_dp_bridge_detect(), as the register accesses behind it may
  run while the device is runtime suspended.
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 46d4dd9d7cd7..b9f4e5757fc5 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -908,9 +908,14 @@ analogix_dp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *conne
 	if (dp->force_connected_mode)
 		return connector_status_connected;
 
+	if (pm_runtime_resume_and_get(dp->dev) < 0)
+		return connector_status_unknown;
+
 	if (!analogix_dp_detect_hpd(dp))
 		status = connector_status_connected;
 
+	pm_runtime_put_autosuspend(dp->dev);
+
 	return status;
 }
 
-- 
2.34.1


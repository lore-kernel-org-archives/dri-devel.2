Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A052606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=OBSYSz/C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3AC210E4BF;
	Thu, 19 Nov 2026 08:49:38 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C85410E4BF
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:49:32 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261119084930euoutp02e0ec6d518b337d3067c9d9a8302ccdb5~pZhXQPwME0282202822euoutp028
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:49:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261119084930euoutp02e0ec6d518b337d3067c9d9a8302ccdb5~pZhXQPwME0282202822euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1795078170;
 bh=wyN3WQJDvJ3eu28smzP2OeR6FzPlvPnryfJGFkh+zQ0=;
 h=From:To:Cc:Subject:Date:References:From;
 b=OBSYSz/CQBZdiWgVn6QVKerViisDjfJVn+DA9SpEGS4Yi4PyY23z8DZI9S2YRZJTa
 T4f8BekR5d2hQpdILYlOleFfkuvkwQVdAH8bK2mcjCzIB9vslFx7WDhtJcWki88XEP
 Wytx6sx/yHV+5SIlBRNr78/yMjwJg1Dl+/4xsQSA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261119084929eucas1p26166723765c9707e2e2b81f8ded99da6~pZhWxUrnl1227112271eucas1p2C;
 Thu, 19 Nov 2026 08:49:29 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261119084928eusmtip1da0d6e3b9b83a1e17347e9e3d9b40229~pZhV_3GOw1906719067eusmtip1U;
 Thu, 19 Nov 2026 08:49:28 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Damon Ding
 <damon.ding@rock-chips.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Heiko Stuebner <heiko@sntech.de>,
 Douglas Anderson <dianders@chromium.org>, Brian Norris
 <briannorris@chromium.org>
Subject: [PATCH] drm/bridge: analogix_dp: Power down synchronously on bridge
 disable
Date: Thu, 19 Nov 2026 09:49:21 +0100
Message-ID: <20261119084923.1156243-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261119084929eucas1p26166723765c9707e2e2b81f8ded99da6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119084929eucas1p26166723765c9707e2e2b81f8ded99da6
X-EPHeader: CA
X-CMS-RootMailID: 20261119084929eucas1p26166723765c9707e2e2b81f8ded99da6
References: <CGME20261119084929eucas1p26166723765c9707e2e2b81f8ded99da6@eucas1p2.samsung.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The pipe (FIMD -> DP video) clock on Exynos is switched from the
analogix_dp runtime PM callbacks via plat_data->power_on()/power_off(),
which require the encoder to be still attached to a CRTC. The driver
relies on pm_runtime_put_sync() in analogix_dp_bridge_disable() to run
the runtime suspend callback immediately, while the encoder->crtc link
is still valid.

The device uses autosuspend, so whether put_sync() suspends the device
right away depends on the last_busy timestamp. Since commit f2b556e3dad6
("PM: runtime: Update last_busy before calling rpm_suspend() in
rpm_idle()") last_busy is refreshed in rpm_idle(), so
pm_runtime_put_sync() now only schedules an autosuspend 100ms later.
During system suspend this means that the device is runtime suspended
only by pm_runtime_force_suspend(), when encoder->crtc is already NULL,
so the FIMD DP clock is never disabled and its cached state gets out of
sync with the hardware after FIMD loses power. On resume the clock is
not re-enabled and enabling the bridge fails on Exynos5250 Snow:

  exynos-dp 145b0000.dp-controller: Timeout of slave video streamclk ok
  exynos-dp 145b0000.dp-controller: unable to config video
  [drm:analogix_dp_bridge_atomic_enable [analogix_dp]] *ERROR* dp commit error, ret = -110
  exynos-dp 145b0000.dp-controller: failed to set bridge, retry: 0
  ...
  exynos-dp 145b0000.dp-controller: too many times retry set bridge, give it up

Use pm_runtime_put_sync_suspend() in the bridge disable path and in the
analogix_dp_set_bridge() error path, so the hardware is powered down
immediately when the display is turned off, regardless of the
autosuspend delay used for the AUX channel transfers.

Fixes: f28dd5075675 ("drm/bridge: analogix_dp: Enable autosuspend")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This patch has been developed with LLM assistance and have been tested
on the real Exynos5250-based Snow Chromebook device.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 8bb4c48aa3b4..022acb962b7c 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1021,7 +1021,7 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
 	return 0;
 
 out_dp_init:
-	pm_runtime_put_sync(dp->dev);
+	pm_runtime_put_sync_suspend(dp->dev);
 
 	return ret;
 }
@@ -1163,7 +1163,7 @@ static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
 
 	analogix_dp_set_analog_power_down(dp, POWER_ALL, 1);
 
-	pm_runtime_put_sync(dp->dev);
+	pm_runtime_put_sync_suspend(dp->dev);
 
 	dp->fast_train_enable = false;
 	dp->psr_supported = false;
-- 
2.43.0


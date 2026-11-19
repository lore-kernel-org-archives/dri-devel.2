Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE480606A332
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=CsbEXcU/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 388CF1121F9;
	Thu, 19 Nov 2026 09:34:01 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3CDA1121FF
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:33:54 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261119093353euoutp026c1285035f295a7e38563c3785e90491~paIH3Pw5T2304223042euoutp02m
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:33:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261119093353euoutp026c1285035f295a7e38563c3785e90491~paIH3Pw5T2304223042euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1795080833;
 bh=DPdsn3eYgJyHtqo10lb5JBrwmlC7BES8TYWHxCyvJMc=;
 h=From:To:Cc:Subject:Date:References:From;
 b=CsbEXcU/EY4eZvwuN3xT+cheBbWcKC19RVXp0B/vRx5fC/FGBEruWyh/BrpSEdLii
 g1iZm87NutdUQnVZQcztl/4XerqciYjHAzZhNfao1EpNJg+3ZDHRUTNdNNOG2jVorK
 9EVg5rdhG3v+qiwMgA2v2uVxglzh2hKGKNUyFTyI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261119093353eucas1p1de9688c7e1847ae8266690934b09f925~paIHh7e-60431104311eucas1p1K;
 Thu, 19 Nov 2026 09:33:53 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20261119093352eusmtip2cbb47a8f137971d895fdc8aa96010b64~paIGtLIAq2569625696eusmtip2B;
 Thu, 19 Nov 2026 09:33:52 +0000 (GMT)
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
Subject: [PATCH] drm/bridge: analogix_dp: Fix runtime PM reference leak in
 set_bridge
Date: Thu, 19 Nov 2026 10:33:46 +0100
Message-ID: <20261119093347.1159198-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261119093353eucas1p1de9688c7e1847ae8266690934b09f925
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261119093353eucas1p1de9688c7e1847ae8266690934b09f925
X-EPHeader: CA
X-CMS-RootMailID: 20261119093353eucas1p1de9688c7e1847ae8266690934b09f925
References: <CGME20261119093353eucas1p1de9688c7e1847ae8266690934b09f925@eucas1p1.samsung.com>
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

analogix_dp_set_bridge() takes a runtime PM reference at the beginning,
but returns directly without dropping it when
analogix_dp_init_analog_func() fails. Jump to the common error path
instead, which drops the reference.

Fixes: 3efe2ace7f5b ("drm/bridge: analogix_dp: move basic controller init into runtime PM")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 022acb962b7c..84951413012b 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -998,7 +998,7 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
 
 	ret = analogix_dp_init_analog_func(dp);
 	if (ret)
-		return ret;
+		goto out_dp_init;
 
 	/*
 	 * According to DP spec v1.3 chap 3.5.1.2 Link Training,
-- 
2.43.0


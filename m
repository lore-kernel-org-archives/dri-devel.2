Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDB6C98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06AE010E547;
	Thu, 24 Sep 2026 21:42:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PE3kqFyt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9513510E547
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:42:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DD517601FE;
 Thu, 24 Sep 2026 21:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF311F000FF;
 Thu, 24 Sep 2026 21:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790286128;
 bh=Ug3ScdpomRG8LtDGbnmPFJyb8UrlDiWfAF9PQCYpaoM=;
 h=From:To:Cc:Subject:Date;
 b=PE3kqFyt/AkRfVMEle9sWlY3GPFZe3QWQbQ6JStoVI2rLVdhLqYI5YRJmZmDjm2Or
 DlyslEyWVolMLMsirB8N2Mgiuzk0aVAzKKnjdh88+Ol0EzDD+Stu1hrj/w0oDY4+EY
 xdBdYs7pZBe+NDGg0yaiBlq5ijHnbjukY4X/PUnA8Rl1NgghN9JhukRP9A0suTu+Gp
 0xF6dQp+A942VNVC4gHxJl9QLsbmb+mqcHFv6HTDQzQswti/XwA2ITETI+9K66YJpz
 mE+VZ144slgpS9TDqOSMHaP7gGkgw+WTHtPWvg7BRVg/fbc5z3iNuWj2iagTxUmNVx
 slFyN/eWgDh5Q==
From: Thorsten Blum <blum@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Thorsten Blum <blum@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: analogix_dp: Use str_supported_unsupported()
 helper
Date: Thu, 24 Sep 2026 23:41:35 +0200
Message-ID: <20260924214136.137531-3-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1266; i=blum@kernel.org;
 h=from:subject; bh=5OFBOpX56t/OqLwV1/ojP078ggg3tH36DZ2K6YbDqyw=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlbZwrErNN8XGp9yOvXib3Tj16tnnz71ZmYnolPNLx2L
 zHavV6iqaOUhUGMi0FWTJHlwawfM3xLayo3mUTshJnDygQyhIGLUwAmkpDCyLBEx+MX+wLZFodF
 R05UvtZ5p5Z7UH7z3+yKmHD3tjsrekoZ/tdNvD/9Y+vbvcaf2FbaMqzsSCyUdQjQ7MxesvDw5Rs
 i/DwA
X-Developer-Key: i=blum@kernel.org; a=openpgp;
 fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
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

Replace hard-coded strings with the str_supported_unsupported() helper.
This unifies the output and helps the linker with deduplication, which
can result in a smaller binary.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 30c0c0b41d5a..ff4d2dd0a749 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/string_choices.h>
 
 #include <drm/bridge/analogix_dp.h>
 #include <drm/display/drm_dp_aux_bus.h>
@@ -746,7 +747,7 @@ static int analogix_dp_fast_link_train_detection(struct analogix_dp_device *dp)
 	}
 	dp->fast_train_enable = !!(spread & DP_NO_AUX_HANDSHAKE_LINK_TRAINING);
 	dev_dbg(dp->dev, "fast link training %s\n",
-		dp->fast_train_enable ? "supported" : "unsupported");
+		str_supported_unsupported(dp->fast_train_enable));
 	return 0;
 }
 

base-commit: 5383cf280ef4f00b15f1d9e2a2886d0d02c0118b

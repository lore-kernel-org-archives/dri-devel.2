Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B947C606A881
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jNnud/yw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C3AA10FC42;
	Wed, 11 Nov 2026 16:43:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 198B810FC42
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:43:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E74464392F;
 Wed, 11 Nov 2026 16:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7252E1F00A06;
 Wed, 11 Nov 2026 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794415382;
 bh=XfL1LkLV6PZp/sIgqFTspEab58+KJnpcSZkBxVzkdRw=;
 h=From:To:Cc:Subject:Date;
 b=jNnud/yw5Gdx9dHj8hc00zIESj/FRZkNQkZzz/XHMES4+CJ0RrTbyZnZV1h91kKyD
 SwFz6v6MYXL8qbLLgIm5q2Rq929flsQLg80l56tQRfELv1b2rOYydPU0PCNPf0wk3w
 kMM0rEGq0XzHW1GrSlitBghDG3cZ4bqOxlzDOHC9GgT1ckkwVwMgr4YsFBcSdgXdFO
 ht5xbhRFQbxnix2zUpvIHS8KMZv/x8Y1vN/nuaFkeJG0RmG/ZGuvVzOQwgY4bgwDgB
 OCmP3w6gYXM5hYyBntMurlsBgkJNGVeYqw6R2Yw/hLoBNPxyu9F9XabCsnkLQ15u1P
 h1Q4VmFMPwPKg==
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
Subject: [PATCH RESEND] drm/bridge: analogix_dp: Use
 str_supported_unsupported() helper
Date: Wed, 11 Nov 2026 17:42:41 +0100
Message-ID: <20261111164243.77775-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1209; i=blum@kernel.org;
 h=from:subject; bh=7Wa0OVeoMbTi4Rsw1ZGgLgGEh6+ZD0fkqEJ0pQ0kuzo=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlfZjPvMLVfu+PgiWl3feNKBa8psEs2l33i0+94z+vD/
 0/9Zll1RykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAExEToaR4XXZneNJngVfpyqG
 ztHJVj/BYnptM+tGtYn3uJpdK5bI+jD8r32S3dr6L2bjo/rVeiXNZ+v0Z8uvjC383Kwwa8vdSff
 +sQAA
X-Developer-Key: i=blum@kernel.org; a=openpgp;
 fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
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

Replace hard-coded strings with the str_supported_unsupported() helper.
This unifies the output and helps the linker with deduplication, which
can result in a smaller binary.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 6df6963740d2..59d3ff9bcde4 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/string_choices.h>
 
 #include <drm/bridge/analogix_dp.h>
 #include <drm/display/drm_dp_aux_bus.h>
@@ -745,7 +746,7 @@ static int analogix_dp_fast_link_train_detection(struct analogix_dp_device *dp)
 	}
 	dp->fast_train_enable = !!(spread & DP_NO_AUX_HANDSHAKE_LINK_TRAINING);
 	dev_dbg(dp->dev, "fast link training %s\n",
-		dp->fast_train_enable ? "supported" : "unsupported");
+		str_supported_unsupported(dp->fast_train_enable));
 	return 0;
 }
 

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A227C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 579B910E068;
	Fri, 24 Jul 2026 18:03:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="kIeu7AxL";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9022110E068
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 18:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784916209;
 bh=GBB+Lg8R2SnT+UdP5XDerp6qRWg/p9sK7PZSNKuO9xQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=kIeu7AxLBHHoztESwR0GOhVOqtMqigvPVR//wws4csDnXk2KAO2spKmF0AU7QLzU/
 vYtqIb4lHqHRfXUZMCCJhutp1pNQIn8CQRXl0dnZV0nbGao0dmgUC+tQNIBWv4lVjQ
 ZlPQ02fVjb2GMskc7oT5meDFenkCbH74lIhnUqBXLL6rZjieBecYET5aQ6az2vp9fC
 NR0z3ugmpLKnbF0FxEOpnnbKS3+LpTKjf935rkQRcM93mq4TwGwE+EoQrf38hleS//
 jD3N4p1OmC05EwgzqqfhRAZwEUi4kC6ddzw5XjcX3zKVLhwRf5lt8IKxqSEZFyjV0N
 cSD031f6CFpfw==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 34DBF17E023C;
 Fri, 24 Jul 2026 20:03:29 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id E09C0480030; Fri, 24 Jul 2026 20:03:28 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 24 Jul 2026 20:03:26 +0200
Subject: [PATCH v6 04/16] drm/bridge: synopsys: dw-dp: Add missing
 reinit_completion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-synopsys-dw-dp-improvements-v6-4-041d99a19c4e@collabora.com>
References: <20260724-synopsys-dw-dp-improvements-v6-0-041d99a19c4e@collabora.com>
In-Reply-To: <20260724-synopsys-dw-dp-improvements-v6-0-041d99a19c4e@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Damon Ding <damon.ding@rock-chips.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 linux-arm-kernel@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=GBB+Lg8R2SnT+UdP5XDerp6qRWg/p9sK7PZSNKuO9xQ=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpjqPCVx7dzGMvZV6H76jbyaGQIx26k+zHTi
 APYYT4iPdlkOYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqY6jwAAoJENju1/PI
 O/qaxl4QAKQdLUWsfAwNqjJiyESFy/nTlsH4BGWR3z1BU0EKwkSQu9XF1lvEzSySoSsiKdznyVk
 D1buzhAti9vbSEOI3YNzbrSrwvo3B5wbIjeAdVdo19r/Cdu/K607o2kBKcVbHVJ84EdO1ivxm8M
 +barG0gNo14jQCxeAcngFZcq7PegI7cCVFy1De/3jZOm/B5SvhGMwRtXigxpjd7bDpGgKHPJM7L
 /sK4fIGSDThz/mZ9A923xzjPYLEVc8SC/Xz3QFm2IbwlCaGxqFxD0dzEKEHqgorBvVLyivmhnOG
 ejQ4OFbTxQXRiIhWGE3un8WuRmGL+tg7J+TWQGXXn/3xY/wUXUi7TmEOlxnnmLccWe36ydq9KVH
 AS1slcvk9pa6a5JliQosIhEuVXlPvXkodEiKH3J2v9L9yMQFEQXpkgn6KhgUT7dT8V5vd9NgZQ3
 pHNFZkdAuflcnmhy7QTMc4WNzUEpwRcNrkT0N9fh5NpkMstkVe1zJFV5gx67gcN5HFzylZNXL1f
 dql7VHEpGWesfUrqhIFyrZUzMUuuWWmh7rdEkL8QgJlXHRGeI2FQrrkmP1WmXp3kUaGk7wrl0qo
 j5GMKXJeA58mCDwybkZhQha2L35hjyZQozUiBdY1VNc1WQyYy7A45ct51LFZXTk/x5xtdMESNoT
 46/BGhGPBRo4idDqgoogyGA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A
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

The DP AUX transfer method uses a completion triggered by an interrupt,
which can timeout. If the function runs into the timeout and the
interrupt fires afterwards, the following DP aux transfer completion
would trigger immediately without waiting for the interrupt. This in
turn means the next one would also be broken and so on.

Fix this potential issue by re-initializing the completion before
sending the AUX command.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index b28040d69fab..2f0ee7ab7feb 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1465,6 +1465,8 @@ static ssize_t dw_dp_aux_transfer(struct drm_dp_aux *aux,
 	if (WARN_ON(msg->size > 16))
 		return -E2BIG;
 
+	reinit_completion(&dp->complete);
+
 	switch (msg->request & ~DP_AUX_I2C_MOT) {
 	case DP_AUX_NATIVE_WRITE:
 	case DP_AUX_I2C_WRITE:

-- 
2.53.0


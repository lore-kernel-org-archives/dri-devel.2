Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D60FC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA34810E058;
	Fri, 24 Jul 2026 18:03:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="hX15Hf/9";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2528810E058
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 18:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784916209;
 bh=K1Za5bWNUcnyTglAfKgP5KR/CLG+7GCG0v3x3t2iK7c=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=hX15Hf/9X+CVUa51M+H4hMh87dr+fBVbdDaU47SwjNZgs3Z+btzcSB9nPn0eIkHtw
 h8YuOeiyGtHfxoMH3YGTPYUyXeIM8+8ppLxxsQzgM3k14tuj0qSgZ8YVbptAKcPFxV
 HRdLxLD80ItpSMWTzAqKR3O8urZnoA0YbUmL5XAw0CW9NUzvoF6gVmiid+nDqFM7sG
 RFIDDHArANCMIw+0fp0MIkEt0C6tIZ+5cH0weX8fcC1KwYwWYmHWCOZhV3/aySp5rO
 O/1TQXxumtIuXGJGQSp3yqev+NcDzUJ+1e67Ykix1N6526n/sNpaUGlzXocPBiRPDL
 j8eXMKxm6dwcg==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3240517E0203;
 Fri, 24 Jul 2026 20:03:29 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id DEBCE48002F; Fri, 24 Jul 2026 20:03:28 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 24 Jul 2026 20:03:25 +0200
Subject: [PATCH v6 03/16] drm/bridge: synopsys: dw-dp: Add missing mutex
 cleanups on module removal
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-synopsys-dw-dp-improvements-v6-3-041d99a19c4e@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=K1Za5bWNUcnyTglAfKgP5KR/CLG+7GCG0v3x3t2iK7c=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpjqPDGJdnZhc59GK1KDLRjF9Jl7LYQ91BvS
 bRWTpG6CuDCD4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqY6jwAAoJENju1/PI
 O/qa+9cP/ix24EjhRs9MFdFHjZ82uXi6N6SVX5BFk9ZCHGqhbdwr/XovPynmESWgj4k/gkzOCXv
 W/8kMdEQRAnqpJIj5noQRpCq6akOcdQ6Twl5k67poAjtH7BMMYlvoJAMkYr5nx/dxOIrIp3rcLy
 gV1Hoig4MJE/IFQr9RFb2iR/pqTo4XntvkqNM/cq27jo+hy4mNlCCkXbyzHRntJIIIcwCQGKUPA
 wc1vsJbx/g5aEJ3MF/YmPvMciDkOP5g7MvYtNAntuwIm1NuH7hdOKEkQlFIWRzLmHy0DFKRQV/F
 6e0ZjmjIo2nOawjb2I5Vkcq+k4IVc1nSDPzEg0psT5D0dxaZJb7HpjmO7FeJGulTGgXD7AnImRZ
 Yd2mN15thHUTyVRG9J8WFzHnUPsy7/iFV9JIf0xGUs46XGNi78TTRrmo0chkuk+aETXZMKMMXgk
 zef9bByN+xjIJApPKmCawS0M5r0GsNXyk1bzoGEunR9IRuuzltmLfbebVHO8Rfrf4adtF/QHMfd
 2j0jyIdw0POkFYrBBzS8NsyTbLgVg9RGLw25OdwFd+Jd1feaHCsNQNhUxfo3xISwJVJjOEPWdzS
 SjTeeI9c7zLY456ydEUCZZJRMjZHnPtRTopwhp3q6A8hXYTfheMYFfYaNXNDVmtVn6r0dCR7Byt
 rJMNa5DSX4g8ZayQrltknZQ==
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

The driver is currently missing to fully clean up after itself. Ensure
that the mutex is cleaned up.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 21bd08571dcf..b28040d69fab 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -2031,10 +2031,13 @@ struct dw_dp *dw_dp_probe(struct platform_device *pdev, const struct dw_dp_plat_
 	dp->pixel_mode = plat_data->pixel_mode;
 	dp->plat_data.max_link_rate = plat_data->max_link_rate;
 
-	mutex_init(&dp->irq_lock);
 	INIT_WORK(&dp->hpd_work, dw_dp_hpd_work);
 	init_completion(&dp->complete);
 
+	ret = devm_mutex_init(dev, &dp->irq_lock);
+	if (ret)
+		return ERR_PTR(ret);
+
 	res = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(res))
 		return ERR_CAST(res);

-- 
2.53.0


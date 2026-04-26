Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DC6FF885C
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 00:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2CCA10E4E8;
	Sun, 26 Apr 2026 00:20:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="O/hY7psG";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9222010E4D2
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 00:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777162832;
 bh=daaKlUmCUDpudTuzdFYTPS5rQ4uiycPChJHZcwEmrbY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=O/hY7psGbQMYNKGnTUjMNHs6BwdIDA/iuhpIGG/nCM4BdjK/CF4YnuH4tA3ELBRh0
 GHBRdTswQPbZlKBvFoGs4AwTdlBGgv9tmLE5H8TCrX1L3l2dxfoLmlOgj1lWCBj03j
 jvNuDV0Mk6NvOr32FDijUJpvwwTwU8GOU0/ZAEH2yyImEICxstEU0l+r47q1sHD8tg
 ufs/zhDU5v2bJja1qo98Sdzo1b/XS03+FP8/Gz0bE7eH0V+hsqExCUOSKWjGxhPXF/
 +mRAFWtkk6mqiBMwM2532lHUrMBTkzU48GoxnN5xk/P6dcoaroCIw0XVkd3RYTKm5T
 0RO3HnGOO1+Lg==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D8EF817E151B;
 Sun, 26 Apr 2026 02:20:31 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sun, 26 Apr 2026 03:20:18 +0300
Subject: [PATCH v5 06/10] drm/bridge: dw-hdmi-qp: Rate limit i2c read error
 messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260426-dw-hdmi-qp-scramb-v5-6-d778e70c317b@collabora.com>
References: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
In-Reply-To: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.1
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

During EDID reads, repeated i2c errors can flood the kernel log:

[   25.361716] dwhdmiqp-rockchip fde80000.hdmi: i2c read error
[   25.363376] dwhdmiqp-rockchip fde80000.hdmi: i2c read error
...
[   25.368671] dwhdmiqp-rockchip fde80000.hdmi: i2c read error
[   25.369440] dwhdmiqp-rockchip fde80000.hdmi: failed to get edid

Switch to dev_err_ratelimited() in dw_hdmi_qp_i2c_read() to reduce log
spam while still reporting the condition.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index c482a8e7da25..36fbd3831bc4 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -573,7 +573,7 @@ static int dw_hdmi_qp_i2c_read(struct dw_hdmi_qp *hdmi,
 				dev_dbg_ratelimited(hdmi->dev,
 						    "i2c read timed out\n");
 			else
-				dev_err(hdmi->dev, "i2c read timed out\n");
+				dev_err_ratelimited(hdmi->dev, "i2c read timed out\n");
 			dw_hdmi_qp_write(hdmi, 0x01, I2CM_CONTROL0);
 			return -EAGAIN;
 		}
@@ -584,7 +584,7 @@ static int dw_hdmi_qp_i2c_read(struct dw_hdmi_qp *hdmi,
 				dev_dbg_ratelimited(hdmi->dev,
 						    "i2c read error\n");
 			else
-				dev_err(hdmi->dev, "i2c read error\n");
+				dev_err_ratelimited(hdmi->dev, "i2c read error\n");
 			dw_hdmi_qp_write(hdmi, 0x01, I2CM_CONTROL0);
 			return -EIO;
 		}

-- 
2.53.0


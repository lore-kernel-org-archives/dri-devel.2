Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44930C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71C1610F350;
	Fri, 31 Jul 2026 16:24:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Q8uVcg8G";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D73D10F2F9
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785514772;
 bh=Np7wpAYZLHRt1c9crOqakHGhI+KoSOWphtz4jQaYs5Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Q8uVcg8Gc5mgbp/ldddahcqc2rvbMiA+kjtISS0W172/7czwRf71jj8olFmjRCt6t
 ol8XjeJtLyfvHkcVOjo+k3IBUH39XYKhHKs9Sd4Qzh9ZUHjgKgYJRL8OBy7b10IqND
 LQxLjRMPhFnX3rVPM70LQe2Xpvd6fLHDDwIJyaB+hVYCeOtShZ6oqc6ycbJaUbglay
 VUi7oqXCdt2Y/cWL0semkrTIS0UEfA8RwkJHm1Mxt9yYBe1CIoEwd6HzhxUmOCgsyh
 Amr4fPgnGTkjly3im4T118u1Jh3G7YaXkNdHH3Lv5HX/nYUo+37rgVOl3PcPmsBfFI
 9+eejfuZrrgzg==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1145E17E0952;
 Fri, 31 Jul 2026 18:19:32 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 31 Jul 2026 19:19:31 +0300
Subject: [PATCH v10 24/69] drm/bridge: dw-hdmi-qp: Rate limit i2c read
 error messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dw-hdmi-qp-scramb-v10-24-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 Maud Spierings <maud_spierings@hotmail.com>, 
 Diederik de Haas <diederik@cknow-tech.com>
X-Mailer: b4 0.15.2
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

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Maud Spierings <maud_spierings@hotmail.com>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index cfd1b18c06e6..7475b6b71836 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -561,7 +561,7 @@ static int dw_hdmi_qp_i2c_read(struct dw_hdmi_qp *hdmi,
 				dev_dbg_ratelimited(hdmi->dev,
 						    "i2c read timed out\n");
 			else
-				dev_err(hdmi->dev, "i2c read timed out\n");
+				dev_err_ratelimited(hdmi->dev, "i2c read timed out\n");
 			dw_hdmi_qp_write(hdmi, 0x01, I2CM_CONTROL0);
 			return -EAGAIN;
 		}
@@ -572,7 +572,7 @@ static int dw_hdmi_qp_i2c_read(struct dw_hdmi_qp *hdmi,
 				dev_dbg_ratelimited(hdmi->dev,
 						    "i2c read error\n");
 			else
-				dev_err(hdmi->dev, "i2c read error\n");
+				dev_err_ratelimited(hdmi->dev, "i2c read error\n");
 			dw_hdmi_qp_write(hdmi, 0x01, I2CM_CONTROL0);
 			return -EIO;
 		}

-- 
2.55.0


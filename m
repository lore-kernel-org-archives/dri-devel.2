Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AA2C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 22:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A753310F354;
	Wed,  2 Sep 2026 22:54:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ePgpzf2R";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 940A210E062
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 22:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788389656;
 bh=yGk5jk8Urhney6oh/zlkmOGaa5u47O/aDw/Cbtvm90w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ePgpzf2RholNgIAqEY4ZOmy1gcyeKiftxRjey8IF2jruiKkmOBpbmYoQ52n6eVx07
 bJfVoa9KCifjVSu2DNiNDHeBaDYCnJgPEHTiXh85qymFj1t4h5AZrI8vOd1dD7L9Vf
 3ry5+NdkEMF1dG/OWG5EyE4aH24nSg3df4zJCYVk8XD8w5jRNMEvoidbiMaKquicAa
 JFlIqmxg9wq1YJgmBIYLnJ+B+JID3Bci+vGgbhLmUDLJyVebPl35qAhJhAzrLmaLLc
 bC2ZvgjkUbWWEtS+dgWQ/q/ik+JXjiaSg2S94MFbHAwjzNEPwl1+3zTSs4y5l1+O1C
 m5qKRjTtKfa4w==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id F09C617E1298;
 Thu, 03 Sep 2026 00:54:15 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 03 Sep 2026 01:54:13 +0300
Subject: [PATCH v4 06/14] drm/rockchip: vop2: Fix VOP2_MAX_DCLK_RATE
 overflow on 32-bit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-dw-hdmi-qp-yuv-v4-6-fb45bf4147eb@collabora.com>
References: <20260903-dw-hdmi-qp-yuv-v4-0-fb45bf4147eb@collabora.com>
In-Reply-To: <20260903-dw-hdmi-qp-yuv-v4-0-fb45bf4147eb@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Daniel Stone <daniels@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: kernel@collabora.com, Andy Yan <andyshrk@163.com>, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 Igor Paunovic <royalnet026@gmail.com>
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

VOP2_MAX_DCLK_RATE is defined as an unsigned long and is used scaled by
the color-depth ratio when computing the maximum DCLK the HDMI PHY PLL
can source.

On architectures where unsigned long is 32-bit, VOP2_MAX_DCLK_RATE * 8
is evaluated in 32-bit arithmetic and overflows: 4800000000 wraps to
505032704 before it is promoted to the 64-bit argument of
DIV_ROUND_CLOSEST_ULL().  At 8 bpc this collapses max_dclk from the
intended 600 MHz down to roughly 63 MHz.

As a result, low-resolution modes (e.g. 640x480 or 720x480, whose pixel
clocks are well under 30 MHz) still pass the clock <= max_dclk check and
are reparented to the HDMI PHY PLL as expected, but higher-resolution
modes such as 1280x720 (~74 MHz), 1920x1080 (~148 MHz) and above are
wrongly rejected and fall back to the system CRU as the DCLK source.

Define the constant as unsigned long long so that every expression using
it is evaluated in 64-bit arithmetic, independent of the width of
unsigned long.  This future-proofs any additional users of the macro as
well.

Fixes: b0362c45c401 ("drm/rockchip: vop2: Check bpc before switching DCLK source")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260623203310.9F8C81F000E9@smtp.kernel.org/
Link: https://lore.kernel.org/all/20260623203310.9F8C81F000E9@smtp.kernel.org/
Tested-by: Igor Paunovic <royalnet026@gmail.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 12a6341e3c98..c3f72cac6369 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -102,7 +102,7 @@ enum vop2_afbc_format {
 	VOP2_AFBC_FMT_INVALID = -1,
 };
 
-#define VOP2_MAX_DCLK_RATE		600000000UL
+#define VOP2_MAX_DCLK_RATE		600000000ULL
 
 /*
  * bus-format types.

-- 
2.55.0


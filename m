Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E9ACD5BAB
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 18:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8943E10F133;
	Wed, 20 May 2026 18:39:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="UMF/5/w2";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1020E10F119
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 18:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779302324;
 bh=/GXMxiVPMFLDQraehtjCiHmR576DEWNcKvvfOLlYRVQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=UMF/5/w2Zj6v105rT61hV4o/R6HIQ2nF7z/RSjZ2uede/+iYx7zg/AYlw2DLkhaQI
 qGTE4COzDqP2dh+gSnfdveUdI2VFVHnusbHNXCO5QIHnX0pR12nS6afa2Pyy/k1vwE
 GDcSF16iELyqwZqhS+gvQu11B3mchyDp/e7dsV6QcojSRrMNmZlgkmIR0+vMTjxLES
 9EztAaonx0E9prktFxZwCNtExG0NL0WD6DeoOpBP7JoUVhwP8oIr3+ccLVtw+jebdv
 lQSazE5EI0uvmGtlqOqII9Rsdz6vbtjTZQTECzm3E9Hvt2lixkMAHOeW3oovFX5h92
 6JTXLcrwGJOog==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A9D9817E1574;
 Wed, 20 May 2026 20:38:44 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 20 May 2026 21:38:29 +0300
Subject: [PATCH v6 18/22] drm/rockchip: dw_hdmi_qp: Defer HPD IRQ enable
 until after connector setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-dw-hdmi-qp-scramb-v6-18-24b74603b782@collabora.com>
References: <20260520-dw-hdmi-qp-scramb-v6-0-24b74603b782@collabora.com>
In-Reply-To: <20260520-dw-hdmi-qp-scramb-v6-0-24b74603b782@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniels@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

Request the HPD IRQ early in bind() with IRQF_NO_AUTOEN, keeping it
disabled until all DRM resources are fully initialized, at which point
enable_irq() arms it.  This prevents premature interrupt delivery
without forcing devm_request_threaded_irq() to the very end of the
initialization sequence, which would complicate error unwinding.

Note that IRQF_NO_AUTOEN is incompatible with IRQF_SHARED; the latter is
dropped as this IRQ has no other users.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index 8d64b76a1aa5..27342094958c 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -579,7 +579,7 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 	ret = devm_request_threaded_irq(dev, irq,
 					cfg->ctrl_ops->hardirq_callback,
 					cfg->ctrl_ops->irq_callback,
-					IRQF_SHARED, "dw-hdmi-qp-hpd",
+					IRQF_NO_AUTOEN, "dw-hdmi-qp-hpd",
 					hdmi);
 	if (ret)
 		return ret;
@@ -601,6 +601,8 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 		return dev_err_probe(dev, PTR_ERR(connector),
 				     "Failed to init bridge connector\n");
 
+	enable_irq(irq);
+
 	return 0;
 }
 

-- 
2.53.0


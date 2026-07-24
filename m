Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3767C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 18:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E94AB10F452;
	Fri, 24 Jul 2026 18:03:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="k8E+4P9g";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5053F10E069
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 18:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784916209;
 bh=MgTdUT23fOeo4lJpFf5pU2z6Cd/OH2vC6NoaMbjXKuM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=k8E+4P9gWtCyBsGC+fNRJpAXy+NmeEwgUwwtJgiL6nlITKMBDUIiw5vKM0HjOkuoi
 8qT/mv0IcFebqm85MM5FNoJVzf2C2Adx8SchRdtMj61iZnL1pX5ZZkZX4fXZty/DmR
 +UTgBjYFztj2aTAz2V6/WvOr/2MOU11+7QSjHWVXXTISJf25fceekzx00GwgHeXvFP
 uK5+n16UbBZgOW7VvVOdZodkWf/lQvErHPvDB3eiZ2Qm4Vxcy8Ega61Ifj+RdM+sp9
 nPcOamuz0SM9rjrtPNj+TnjeoHWA0HVhWiXozXjLlfwJk0ud/glmxTZUQ3WuyBiRkB
 VqHxEsesTDzpg==
Received: from jupiter.universe (unknown [100.64.1.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 310E817E01FF;
 Fri, 24 Jul 2026 20:03:29 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id DD2BB48002C; Fri, 24 Jul 2026 20:03:28 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 24 Jul 2026 20:03:24 +0200
Subject: [PATCH v6 02/16] drm/bridge: synopsys: dw-dp: Cancel pending HPD
 work on unbind
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-synopsys-dw-dp-improvements-v6-2-041d99a19c4e@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=MgTdUT23fOeo4lJpFf5pU2z6Cd/OH2vC6NoaMbjXKuM=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGpjqPCsRTRL+xEFbExnTin0ycKqtU7zs8hX4
 M/+R+uQZi72nIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqY6jwAAoJENju1/PI
 O/qaMioP/RnwbfK4SHGm0lJrJjaw6Ld0ZL0QwP6M9ywqYvju/3p4uxJ4plofkcdBIetNZqlZemu
 4q2u5pyCz+K/TqGf//cRYt6mzSfyDR5Xf68fIQgmS2XWMkuSZoPcZLd1ifAFWEuKlh3KI2UoEc8
 nacBfLReXeWGs6cOgmQuYRuSK/e7+XIL8V9sSOMniZi42JO47gM68rtR792Iut+8JeO+jqulJPc
 2YOYYAakvCywWqd+szBQlAP7YVq48IyqaJsx2X1OWf2RqoTNC+ZlTA1/WFVE3L9zltqjWf2AAlu
 NzIx2l7fXdtXKGac8OZT1cd/VJBNrJexVD7Eq4cKRAE/Z/nMkXKU0waOGWsO/D6gKEM1Wehk3ik
 6x5c/PbCJ/3mEO21dHXIfztJdY5px0kCD8FXowdLZPewthLaSKnWM5Oz0Cs8mZmI39DGpCodRXe
 08GYybFAUiNZILYozTYUa3J1uf/XBn/0yd84aMQ9Evwn114vq1nG+Hy4st42AycklhCKN/3HBDy
 ODpdR48ISroBj6Um197i4EhNe+6cJmqXfmMY0SlWjXU7VWdZZ2ofYEtDJZ9j+UFb+bhP6BNyKGT
 HOLdFNFA3dpSycfJVo1jX/XzXPpch2295BjmkYn31rOeWKH3+na6zCfFu3SzGp2BI6SQBJ7UQ0G
 2t8Fh7kzURUsVe4blvZ495Q==
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

There is a race condition during device unbind: If the HPD interrupt
started an HPD worker exactly when the unbind happens, the worker
thread might access invalid resources. Avoid this by stopping any
pending work immediately after disabling the interrupt.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 368e1f85e625..21bd08571dcf 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -2009,6 +2009,7 @@ EXPORT_SYMBOL_GPL(dw_dp_bind);
 void dw_dp_unbind(struct dw_dp *dp)
 {
 	disable_irq(dp->irq);
+	cancel_work_sync(&dp->hpd_work);
 	phy_exit(dp->phy);
 	drm_dp_aux_unregister(&dp->aux);
 	drm_bridge_remove(&dp->bridge);

-- 
2.53.0


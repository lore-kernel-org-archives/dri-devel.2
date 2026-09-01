Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B73C624D6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:51:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16CD510EE3D;
	Tue,  1 Sep 2026 18:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="RVeepdB0";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFD8410EE38
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 18:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788288642;
 bh=eu1KlSlWXqhbiSpgzVzFIDL33AEwWbq34A898vzWv2U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=RVeepdB0Bcueu2yR6HxUoRZoMXRJ6Wle8Ow5IFxiJnxIwLz75sII6M0a0TUCrYZ7b
 bOR8K5WmFYV6wb0TIAmyZhGrTEDaKVpDjYCK5VaaNpwaFqEHhgts7SetkZ5cZb0hjA
 WFZzDxQkpoE+8BIxH+Guem+EVr6+aO8dfmUWfcyM7Wj62odW40iFHqCYdkStdsK4Wq
 hXCgWTAoNK8OgoeHtZusz0Ns4lAvfKf12e6WXy5tKTyDGRAh5BPk1t5oORQ0G0h1eZ
 T/l9T8qtD9uRUJs5oskv5BSW/3NNrJvMhls8bVNzmnRGpBttx9M9i8dIWUfILO6nGt
 rT+hRBkU4rmrA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 92CA817E0934;
 Tue, 01 Sep 2026 20:50:42 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:50:26 +0300
Subject: [PATCH v11 02/74] drm/connector: hdmi: Handle reset() state
 allocation failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-2-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>, Helge Deller <deller@gmx.de>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 linux-fbdev@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
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

In drmm_connector_hdmi_init(), if the reset callback fails to allocate
memory, e.g. inside drm_atomic_helper_connector_reset(),
connector->state will remain NULL.  This is unconditionally passed to
drm_connector_attach_max_bpc_property(), leading to a NULL pointer
dereference.

Bail out with -ENOMEM if the reset callback leaves connector->state
unset.

Fixes: aadb3e16b8f3 ("drm/connector: hdmi: Add output BPC to the connector state")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260723015306.C94241F000E9@smtp.kernel.org/
Link: https://lore.kernel.org/all/20260723015306.C94241F000E9@smtp.kernel.org/
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/drm_connector.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 8b4baed060f3..0e39431e85b2 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -628,6 +628,8 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 		connector->state = state;
 	} else if (connector->funcs->reset) {
 		connector->funcs->reset(connector);
+		if (!connector->state)
+			return -ENOMEM;
 	}
 
 	drm_connector_attach_max_bpc_property(connector, 8, max_bpc);

-- 
2.55.0


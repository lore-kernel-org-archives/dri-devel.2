Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6034C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA5510E772;
	Mon, 29 Jun 2026 08:18:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JCP/ncnj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FB1810E76B
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:18:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E8506600E7;
 Mon, 29 Jun 2026 08:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260171F000E9;
 Mon, 29 Jun 2026 08:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782721104;
 bh=KOLAEYhWQJJjSKVBhB8PMcomVGiukU9kuCNuoHTNlGA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JCP/ncnjaNocuuHZRxrTfvIsx9N6AkJ8Q/Wn8vtNBS6/dUUvq5d6A98w/FqsncIZ8
 D0jJUDm419K8GRpqqSXk7DaCOMvjc+b+z3yh3N2Dya1oG/87COdkDnrj6llZ/dqstU
 XVmZxnyrg2eW1AfhyqN9NzKThOU6/rXnA5foa4tJ2bRX7Tf8HnuWTlssAqR5FnLhgj
 DbTUTqkNpCmMwSJhX4eFnVI/qMuAHGmv/5XBQ+/ZaFaInAeqQxG5CxZZV+8ejkdTFC
 Ikx1VwmKueAar3xrc6JbRK2cd35W7qIZC/DoUpu5jlxUGoSkxSXdNPazPkbiRnx8ZF
 VN1iucHe3TAsg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 29 Jun 2026 10:17:25 +0200
Subject: [PATCH v4 27/30] drm/tidss: Switch to
 drm_mode_config_create_initial_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-drm-state-readout-v4-27-5966657980ed@kernel.org>
References: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
In-Reply-To: <20260629-drm-state-readout-v4-0-5966657980ed@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 lidrm_printf_indentnux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009; i=mripard@kernel.org;
 h=from:subject:message-id; bh=qozUUf1AFqeMjnP70GJi9v3pouWkBGxz0M1HZ1nk+wY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlOWjz3NdP3pDdPnxCgXVBTtFf504c/faoFIbyiF5Qn6
 t7407y2YyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEwkX4+xYbeJ+pmeoPfnBO89
 yKs/8YP73M7GyTumHphUyD9fWPLSpMx3z/e4brlVZ/6IQa915741vxkbOpKETjrONmyR4ji0a6/
 t/5lT/iXyrM/55O+x1XjljhqllHKtiDVNy5PLrnEdm9KfuCIWAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

Now that drm_mode_config_create_initial_state() exists to create the
initial state, use it instead of drm_mode_config_reset() during
driver probe.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index 1c8cc18bc53c..f5099d5d6e32 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -169,11 +169,15 @@ static int tidss_probe(struct platform_device *pdev)
 		goto err_runtime_suspend;
 	}
 
 	drm_kms_helper_poll_init(ddev);
 
-	drm_mode_config_reset(ddev);
+	ret = drm_mode_config_create_initial_state(ddev);
+	if (ret) {
+		dev_err(dev, "failed to create initial state: %d\n", ret);
+		goto err_irq_uninstall;
+	}
 
 	ret = drm_dev_register(ddev, 0);
 	if (ret) {
 		dev_err(dev, "failed to register DRM device\n");
 		goto err_irq_uninstall;

-- 
2.54.0


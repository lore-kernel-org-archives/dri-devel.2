Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECFBC79F85
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8D7110F8AF;
	Fri,  4 Sep 2026 07:19:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="Ephg0Tut";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D31EC10F3A4
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 01:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=si
 s/+DaxI4itjWYTHAoL7wDYbkKPw8C5NmpJsIhRf68=; b=Ephg0TuthCeEzf9OuE
 j0dBa0T8SUgUvacN6HLQfo7fCKrM6esp50I6uqvI5NdeZKA1jdDQVsvkxuRcDR5t
 6FL9iVJsxS0w0YRYjDAmo5IlAzj8uK3tF5wNW3OXouYAffGaa0qenfrjPW8DbNJn
 MevMwnizK2rMxRXUYYLrDDfH4=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wD3l+rKI5pqcI4tAg--.20344S2; 
 Fri, 04 Sep 2026 09:50:04 +0800 (CST)
From: "Li Youhong" <dayou5941@163.com>
To: inki.dae@samsung.com, jagan@amarulasolutions.com, m.szyprowski@samsung.com
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Li Youhong <liyouhong@kylinos.cn>
Subject: [PATCH v2] drm/bridge: samsung-dsim: fix TE GPIO lifetime for host
 attach
Date: Fri,  4 Sep 2026 09:49:58 +0800
Message-Id: <20260904014958.1572918-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3l+rKI5pqcI4tAg--.20344S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFy7Gr48AF45CFW3Aw13Arb_yoW8AFyUpa
 1Ygay5Cr98WryI9F4xXF48AF1fA3Zxtr4rGrn2gw4akr4DJFy0vrykK343Z3s7CryxAFs0
 vF4UJr4fCF4rZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjuWLUUUUU=
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC3Qw962qaI8ySpAAA3u
X-Mailman-Approved-At: Fri, 04 Sep 2026 07:19:31 +0000
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

From: Li Youhong <liyouhong@kylinos.cn>

When the Exynos DSI driver was generalized into samsung-dsim, the TE
GPIO acquisition was switched from gpiod_get_optional() to
devm_gpiod_get_optional() while keeping the matching gpiod_put() calls.
That combination is wrong for a managed descriptor.

However, dropping the puts and keeping the managed get is also wrong:
samsung_dsim_register_te_irq() runs from the DSI host attach callback,
and host detach/reattach can happen without destroying the device that
owns the managed action. A second attach would then request the GPIO
again without having released it.

Switch back to a non-managed gpiod_get_optional() and keep the explicit
gpiod_put() on the request_irq() error path and in
samsung_dsim_unregister_te_irq().

Fixes: e7447128ca4a ("drm: bridge: Generalize Exynos-DSI driver into a Samsung DSIM bridge")
Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
---
v2:
- Prefer non-devm gpiod_get_optional() and keep gpiod_put(), because TE
  GPIO is acquired in host attach and must be released on host detach

 drivers/gpu/drm/bridge/samsung-dsim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1862,7 +1862,8 @@ static int samsung_dsim_register_te_irq(struct samsung_dsim *dsi, struct device
 	int te_gpio_irq;
 	int ret;
 
-	dsi->te_gpio = devm_gpiod_get_optional(dev, "te", GPIOD_IN);
+	/* Released on host detach; do not use the managed get. */
+	dsi->te_gpio = gpiod_get_optional(dev, "te", GPIOD_IN);
 	if (!dsi->te_gpio)
 		return 0;
 	else if (IS_ERR(dsi->te_gpio))
-- 
2.25.1


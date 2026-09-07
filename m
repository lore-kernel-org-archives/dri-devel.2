Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932BFC79F9F
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B23A10E7A8;
	Mon,  7 Sep 2026 11:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gvDol1jy";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CE6E10E78C
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:28:33 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id AD00415D2;
 Mon,  7 Sep 2026 13:26:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788780417;
 bh=dqSlFylxany87x//euHzcbSDmd7Vo7iZMPlqL/qDISc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=gvDol1jyYFCKhMTSMBQNmHZeR+JqcUKemZQ+Km+5zxjxmnyXlC26m/4nPk1gCuXsI
 57nVW9Aj81vkL5tRRqNOsskKY72lgQPDzb3WliyzJZOPRoM1sT9HgGpbJGFj440dCu
 41VjJDbDD4nuWSIBcHx4SZSsPqlUaXp6JOSJ8cLs=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 07 Sep 2026 14:28:04 +0300
Subject: [PATCH v4 09/13] drm/bridge: tc358762: Fix sync polarities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-tc358762-fixes-v4-9-e3fc3ab5cd83@ideasonboard.com>
References: <20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com>
In-Reply-To: <20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=944;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=dqSlFylxany87x//euHzcbSDmd7Vo7iZMPlqL/qDISc=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqnp/UKX1xHlaMz60iTh9vxL5HCzPRfkAFhRrGE
 65xCGPXmieJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCap6f1AAKCRD6PaqMvJYe
 9T51EACjEYB5j3tCyRjgpdUcJLjt2yQoGUU+9ofoDcYU0ExMfCqwq7K+VQg2jpVYHLfJrmS1Lt6
 WuxKhJty2/KrDkugL+K/RNt+pRar8Xc9fhsxpwjfdnLdtCkWlVTALSz27VTSkFUbGTCgj3luvza
 1e7KBqgaqepi5pIvlz1wlaSzfODfC0aQCQ3tdVQ44htR9XHdOah5+JVuoQRkGe0c4ZAALtoyTYo
 ryHoqYjwhhG1VB29K0CBQV6d/Ltoy88RNY6P2RdWTQl6HMSvMQ0gQ2XTMQp8YU16NkJG3agYk41
 eBBWqRFyFdT56/Woh9Sh19svyE2fSGjydgLp3TOAE1Bi0njl+IYrJ7ePsVQtagOo5/yvtGASA46
 mgvcrP7CsCTcErlBKSUuzPJeZYRHTEeXm+JN5JZDyKL3i0VNMfREtoMwtVnWzo/DK22oHWrRqYm
 y+VNKuanIgKxBJsUxEgQal7zCWiQ2OcLOWTJxvWaGLqLImGwL6S4KxTPIV6WReNK0U340Eh21ZB
 sWsU8aKkSlRF+hrz+Ik2whX+GyFzsmnUT7QVnupGDifpC9CwYdUCQOHWY1Oq4E1+ghb5aBZoNJD
 Whnv0C3hiER5XADWf2JUdj2Rw9tkYEaK1SQpTjDjttEjy0lMNIlYePBsAreQiZkJgfoOEeknrZD
 ary8trEf3fw3ePQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

Setting LCDCTRL_HSYNC_POL and LCDCTRL_VSYNC_POL will make the respective
sync signal active high. The driver does this in inverse. Fix it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 797866265b41..3a2e6a97feb8 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -190,10 +190,10 @@ static int tc358762_init(struct tc358762 *ctx)
 
 	lcdctrl |= LCDCTRL_DCLK_POL;
 
-	if (ctx->mode.flags & DRM_MODE_FLAG_NHSYNC)
+	if (ctx->mode.flags & DRM_MODE_FLAG_PHSYNC)
 		lcdctrl |= LCDCTRL_HSYNC_POL;
 
-	if (ctx->mode.flags & DRM_MODE_FLAG_NVSYNC)
+	if (ctx->mode.flags & DRM_MODE_FLAG_PVSYNC)
 		lcdctrl |= LCDCTRL_VSYNC_POL;
 
 	tc358762_write(ctx, LCDCTRL, lcdctrl);

-- 
2.43.0


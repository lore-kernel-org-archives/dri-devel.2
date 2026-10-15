Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EDFCC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3AE91122D6;
	Thu, 15 Oct 2026 11:16:48 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD5AF1122FD
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:16:34 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 408521552;
 Thu, 15 Oct 2026 13:14:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1792062870;
 bh=Ce/IUl8m0EIXqaAmMjx6Mj55YSBD7+khbCWc5Mp8TZY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=X6sLe+jV6y++wZL5uy+GSJPLMRY9MawpYnGuLuBaZwWvgwqZNsvUdu9W1a2zMnU+t
 zg+rqS7Vd55zzPTYSNgMzJyolbfiULkT79/pSXAiiilRrHjPkToBJVAFGxZXj1O+xc
 2MmATU2lbNSfD01xXW6yOh/+jbKqxVOuW1cF8whU=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 15 Oct 2026 14:15:57 +0300
Subject: [PATCH v5 06/13] drm/bridge: tc358762: Improve DPI enable handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-tc358762-fixes-v5-6-7cd721a6451b@ideasonboard.com>
References: <20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com>
In-Reply-To: <20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=Ce/IUl8m0EIXqaAmMjx6Mj55YSBD7+khbCWc5Mp8TZY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq0LYGbzQc28JrSZFi0DhYt8mcNpjIK+Km61l+j
 j+uoGPD4eGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCatC2BgAKCRD6PaqMvJYe
 9QSLD/4nZNbNw4NeanW0sJhDejFKjKRqRxNb4seo8652MzisVSsHHGjbdJYmmVWcj5nu2UHV89d
 cyEPx3CTwI5uObmkeVVSZZDSBKO/c+4XenqzMfcit51CL9KtcFQRIPESKfoLzvgpNkUw67y1zHU
 0cHHQvG+Fz44xBi59lexhHoatexsX4iodQh6SRx3QLdNJoNgGnDhO9m+jv/tkwE+lb7u0MGQaay
 AZNAKuIAjxaNCogNPEbJtiSNUnsxURg4t+FvHxdJguL0oJBmFnKFslWmnmhfxRxy/KzDyidXOeb
 Q7ufTLj78ms4g1ITpF6ZCrIQngjnVKZFbpPmvbT0qiyrDV3tdMLgUvlRg8+I+fKsgOz9jxaqf5v
 6TBhkBFK7J9malgIEdLbxByOu9thLEZm1OTfGfRf7yMfKEuj6MEqMoMAVas4zBPvS430g7RoVzp
 GNeLkEQL+cE39adGjibdmrSUkW8Bj+hf6IRbv7Zz3wlpK1gGngzcMkrLvC3xMUbme6LbpuwEOF6
 LMVhuKZq1vu9+esKJA82cz7Bodce4qNDgHb/SM+VqQhLykaaQUUBCloq+bYHSGojfrPkoDB11UO
 /MNlFUQprpBmyhzvWZoWmk3GzHNKQhEnfMGT83jZOi9lBKxEjDmuInrqI5YlzN5boUtjAWCv+w5
 sfROr1cNezS7HKw==
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

The HW reset defaults has DPIENABLE bit as set. In the current driver we
configure and enable various things while DPIENABLE is set. This results
in a temporary DPI output with wrong timings, which may cause artifacts
on the panel.

Fix this by clearing DPIEANBLE as the first thing when we start to
enable the display. DPIENABLE is set later with the rest of the LCDCTRL
configuration, and at that time we have done all the other
configurations.

Also, for symmetry and possibly improving the DPI output at disable
time, explicitly disable DPIENABLE when disabling the bridge.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 91bc79d36a74..19f328b6e798 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -134,6 +134,12 @@ static int tc358762_init(struct tc358762 *ctx)
 {
 	u32 lcdctrl;
 
+	/*
+	 * DPIENABLE has reset default of 1. Make sure we don't output on
+	 * DPI until we have finished the coniguration.
+	 */
+	tc358762_write(ctx, LCDCTRL, 0);
+
 	tc358762_write(ctx, SYSCTRL,
 		       FIELD_PREP(SYSCTRL_DPIDATA_IO_MASK, SYSCTRL_DPIDATA_IO_4MA) |
 		       FIELD_PREP(SYSCTRL_DPISTB_IO_MASK, SYSCTRL_DPISTB_IO_4MA) |
@@ -185,6 +191,9 @@ static void tc358762_post_disable(struct drm_bridge *bridge,
 
 	ctx->pre_enabled = false;
 
+	/* Turn off the DPI output */
+	tc358762_write(ctx, LCDCTRL, 0);
+
 	if (ctx->reset_gpio)
 		gpiod_set_value_cansleep(ctx->reset_gpio, 0);
 

-- 
2.43.0


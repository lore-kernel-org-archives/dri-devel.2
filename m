Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6279ACC6B3C
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:17:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1CD5112305;
	Thu, 15 Oct 2026 11:16:55 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF85D1122EF
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:16:36 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 48ADF2F8;
 Thu, 15 Oct 2026 13:14:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1792062873;
 bh=YvPKvR3k8goQxkf8tDWUsDTJ1X7cwwMqAe7zy8YJqmM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ZRbWpj4yXRt1q0Nej4RrT73tJwRwKei/4mFS4+cWFJMa3uBhhFcF0dpLfT30ycZ8u
 OFmPZZu3tBDsEVY88s3lGOuik9E2gw3XVJMoI3SsBDPHFbXBUW6c63Uwu7oqf1m+D8
 NvLv1LrfdmAg6kF6U9+uLzEPFxab/mYuPYFBLywI=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 15 Oct 2026 14:16:00 +0300
Subject: [PATCH v5 09/13] drm/bridge: tc358762: Fix sync polarities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-tc358762-fixes-v5-9-7cd721a6451b@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=944;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=YvPKvR3k8goQxkf8tDWUsDTJ1X7cwwMqAe7zy8YJqmM=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq0LYHMIxIwLJncouR4zT7ki6jZn1uKfsD531IE
 pAEHjUQyQeJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCatC2BwAKCRD6PaqMvJYe
 9dyCEACAiD7z3zj1Ru1PevHY7ohFpcM85fmnK3NhTy9BO1JbBy7FnYYOONVRVxkZpp12gOhEWDj
 BVbUE3z4YAGIClZQ59neOHUBlcJ/c+P2DqjuL3cv2JBA5RQz/2Q31APADs2b3u6aFW6PlOP9nnd
 GNlv3xqlRhs81rqC17VZ+5tnb4UCsVA3HHS37owJJi/7hyIAidmCx5GxfEeto5sQlM6XOLgZfDw
 gKbB2AqB6HbmqZNtT+LdRtSM6WOUkvInMdyQ5pzw0b4JBnswOOhYNVzyEjqY4Bd9HCWp6EzOEp1
 AKF67o8PuJmld/FsWns4xc/33lxU65a+5DSEw/18q6jE+PaFvgOcCLOWVfiJzy+V3Xqna/eG/0E
 uqaAZ1CGCZcOpKV5Sw3QEwGYEuvmTkLdwEa4W7upzSehLIDsYh31AdbwhUnZxjh5O1ppTHA2B5X
 eP8EXzLJh624qLcb+FofxmMgV1m+Kibuzl8Xr580o5RFgGXBLBJoZXSB3JY4XB+ObXu2xWwIAbL
 aJxJ4DSoDYBO6ChGCnKrrd6tPjkEGkpapOC65fIfY7oubuCAzqtxMbNQ/g5sBeC0Sg1iwo9bHCk
 nHGWJgIof+0vjaUr3zCh1vG0wLohFx1iv5P9vKeY6FjEN2x2eCyIceFX7wdVLRgBsyHvK3ai1bY
 l5TY2DYGGiN+J3w==
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
index 1fb5626a35ab..2baacef685a5 100644
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


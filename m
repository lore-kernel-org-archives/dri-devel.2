Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65315CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5CC610EE66;
	Wed, 13 May 2026 13:10:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NuA/t4cA";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB4A10EE5F
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:10:50 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 80254275F;
 Wed, 13 May 2026 15:10:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778677841;
 bh=a2/ARADRK44LFvXqNDNMF/1cP4gAyjDHG5Oh12L4fAE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=NuA/t4cAJt0m4K4RmMEDnfLnnr0HU+PzgBUaViFxhTgEY7KmOcqQ4Cx/iJsFmZ+ow
 hNHIkgHekdUFJJuwG+vswpyEIUnVIpemaiOX5pZ/fV6X5xcEcImepBvH3JH7pK+tHu
 7w0mPrF3tzuUQ8goN0DybpLGv5rSGOD/amzH15O4=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 13 May 2026 16:10:18 +0300
Subject: [PATCH v3 09/13] drm/bridge: tc358762: Fix sync polarities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-tc358762-fixes-v3-9-6698b55008b9@ideasonboard.com>
References: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
In-Reply-To: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
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
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=944;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=a2/ARADRK44LFvXqNDNMF/1cP4gAyjDHG5Oh12L4fAE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBHhNTWGM+I4pyt5qEuQLLnmAtwUkLC5IpJSl3
 UQTiEAOjMqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagR4TQAKCRD6PaqMvJYe
 9fhuD/4+sxWqsNTLEK7NLHyFWqrkUh9mFnyWiY5AhIXalscdZWm+nJX4J3UzbbYvxT5s7b/TOQ5
 TA/DwLiRIMiC4jRszEqQXEAmG0vxq2Kmtr0rFY64umOX9ISKj92cdnBiHtJnL5D8HMP9+vYvNAS
 HrHFO6YRlr8ZOibWNV/+eR631vM5dzdvonDZxMLj1n+PYxUAwstZmt6YLyIIK3Cf9Q2A2+mzKGx
 YhgCrSWdnJ36XtVbmRyrz/s8h1kXgDwXP7Y7XZdVXS4rRW5FmPsjSh4hskq+sRvU9OpuSoNr9gz
 2JNbGmRsyzV1q9byiM030BJlx3AZMYp8t3kAqncF/CzDFnEzVon4z1/fT0Q22NJ2WbZvcG4cMPg
 tm+B58cABehTUT658BaI+DMHCMSo/pJLbEEGdBp6JCyQ/PTPtDeoWBx2OJbEepU3gmUZEem0Nhz
 QB+RgwLYRvc/fAK6JHL1X1AUXnIImxBJ3476bTNkzAqon3tVmAlLZkkjUSVFpZta4sBO76BCOla
 0aPqwrlEMEXhM6SYKLz6puJld6TgfdmSwF2FhkwkqQ10YHGkflGqG/tZ++r8lrO5aOvOCwOAI7g
 la6BCbzRLCmyDOoNdt4yvBC6xOWFqydKUSYq1yFROwfbMQuTNup4mX/RO5vGARPJd0U18zoVe6h
 usategP1NlMYhSw==
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
index 2d9491e8e582..5d6092e1d190 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -191,10 +191,10 @@ static int tc358762_init(struct tc358762 *ctx)
 
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


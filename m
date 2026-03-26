Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EEC10A62CA
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DB6910E964;
	Thu, 26 Mar 2026 13:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BWzjjEov";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 379AC10E213
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 13:12:39 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id ECAC013BE;
 Thu, 26 Mar 2026 14:11:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774530679;
 bh=kFnbSJwDmqy+xWISydA91OjEdmhsMcyE+vmToOTjfuc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=BWzjjEovoZE9PUe3vRt0Ew9bOkiBSNuqUp2IJ1LfhVI6qpOdq+c8S0XlwJo8YJeji
 39glNxDrLAmaFX8bBGTBtttnNQEvMFgrf5LP6eF4G80stMRjtwadB1Rkwd30SzhW1u
 ahwqOlQa2/PpI6El/hUg99axzCHJhF6OpBTk2imY=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 26 Mar 2026 15:12:15 +0200
Subject: [PATCH 5/8] drm/bridge: tc358762: Drop SPICMR write
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-tc358762-fixes-v1-5-65f479227af5@ideasonboard.com>
References: <20260326-tc358762-fixes-v1-0-65f479227af5@ideasonboard.com>
In-Reply-To: <20260326-tc358762-fixes-v1-0-65f479227af5@ideasonboard.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=808;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=kFnbSJwDmqy+xWISydA91OjEdmhsMcyE+vmToOTjfuc=;
 b=kA0DAAgB+j2qjLyWHvUByyZiAGnFML/Ie9ZIFvGvvJ4SL0vk+3L15CrZWsm30/zENx6IN8zni
 YkCMwQAAQgAHRYhBMQ4DD6WXv2BB5/zp/o9qoy8lh71BQJpxTC/AAoJEPo9qoy8lh71F2oP/RgL
 Qvf3Jw09BtFPYySgkku4YQXyTkxG1vdg7qMUlTXXxzM1Nuf9oH+xafVLGl4oSkOWbbhRpMHUd3N
 vgDUoO/6palF/L8+GBv4/CIL3b+BzdUj1uKDZ159OuQTqlZUJFmPL+LgEdmoPuImTMPIO+/DYEa
 ccwMDEVviYtCWxvDoCkZ+GCPR3YqIjP9PrxHAlQotXFkTl1RE649iM7WG6EkYohSURMGPJbHpyJ
 UzDaPBVAXqfpOwddL+7pi0p6tRb1YAIkG9EZx5eU8Ic1YPSf3tpSiGDN19dEWZzfmvRO9lj/fJ/
 6Gk/CK6KQnOCZuk/21Fa4M8//u/EQ56ZGz7Ht6euFp9P2t4076RqYCI6nluAP+NzticB8c9T/2p
 W88B7cFwLfkavQDLqK/9TFArXvf7s4OKj0Z5mPt5rZCTVtPRkeTAKhErUDAs4mrBaOHx+qkNItA
 0zuPGJxDC375N4lBzqAGj3l37O3+l0pU71pHdKFFUJU6KMpaEGBMrssWbAiGg6hM8yMr8ql3Nv6
 jBhRZaW/XEqKI1SwUqRIkhJXp0SY5HJKQonFcjYh4ZItuzfhEHnnEjl0r7hRFccALOMq26ortr+
 zvXvBJXEQHWvCqdeNnHz0dZe8DR7PIhMDPfbawdN8G3c/DqJsPk7DLIuKV3sTwb4yplGVnxuRxg
 RghEg
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

Drop write to SPICMR. It's unclear why the write is there, and it's
mostly just writing zeroes to already zero fields (reset defaults).

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 053579591dba..52e2f3a73721 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -149,8 +149,6 @@ static int tc358762_init(struct tc358762 *ctx)
 	tc358762_write(ctx, PPI_D1S_ATMR, 0);
 	tc358762_write(ctx, PPI_LPTXTIMECNT, LPX_PERIOD);
 
-	tc358762_write(ctx, SPICMR, 0x00);
-
 	lcdctrl = FIELD_PREP(LCDCTRL_PXLFORM, LCDCTRL_PXLFORM_RGB888) |
 		  LCDCTRL_DPI_EN;
 

-- 
2.43.0


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802F6CC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFE381122D9;
	Thu, 15 Oct 2026 11:16:54 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 164E11122D9
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:16:41 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 677C21D12;
 Thu, 15 Oct 2026 13:14:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1792062877;
 bh=fw6HWt4qWZk1Je5fhTr7Rh66OKoDT2cP4tY+lFPvw1k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=IAKAZ04oU9Cj45/XYdJq2WgcKmUagAlI6Qo/W2mZcTnIlQSYNes1hRAgqT2V1fWLt
 x15Iq018Kfhi0421pnVzMpfUZBZlQqWq/+bzmkRVsF+otS1AKJt2jwU7I/hgfg4sCg
 zlVScb2t4qpZOA6bo3hFpR12oHid9YJB4V5QAEqc=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 15 Oct 2026 14:16:04 +0300
Subject: [PATCH v5 13/13] drm/panel-simple: Fix powertip,ph800480t013-idf02
 timings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-tc358762-fixes-v5-13-7cd721a6451b@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2487;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=fw6HWt4qWZk1Je5fhTr7Rh66OKoDT2cP4tY+lFPvw1k=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq0LYJeY5qBXBVVYD3iUA8UgrkzdfZ3PZisDw3t
 o1904SKUzOJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCatC2CQAKCRD6PaqMvJYe
 9XdDD/9qK1ytb75oiW/t5TnfgzdOhN8/UAMzVq/j87Gwthv2RhGjEnOHisf2M9U3cFXvmomnF3h
 DnYA+sJ+/hjdLx8lxZqdrvUrrbRwLdZoIJGKTaDQDoQgDxyiyNJoB6cU9/SNCjvaU9he73C2IcH
 lFyeJZJvdyYvc77SI6st01RonGmshtYyP3m/1+TikFa+LyDTYh/bPIXKG0Zi1RDV9HXI1OBNCFt
 6xXxT9/vL8h0rKoQb9E6zaobfavDWv/Drxq8KMoL7lW0oEaZ6Paq9VGRQuh/E9bQjSLLpu+pHNW
 D9ApslFVP2UvADmABiRWMGTIhB6J7wAvbpWfp9meSqwlf5GOxyJ+tGhPg+wY6hNQOQ2UVaeBRBF
 BTmAet9xNEeBreUGunB3qieD2roaHFs7cU0YStlPMu94jxfZiNgVJoqqVOcyk2XTUXd7Ny9B3pS
 aPY2HzbYfpX5HdxBYk756Q+3I2PsfrnSxQIi154UAsnDJNTmGmt21PW1hN6uGFW+qkKwP1Y258J
 K9a10T6xLaOru5CHD6FHZqZrlruEAE5BcOqHO/aLIl5q7Iq6DTiEkub1aEjVHizZ6BsWfHkWDFc
 DmBWtwKXJrTtLfqY0SsT341X1ajb/9xk8o83a4TZnL2PTaUYF0zMVeefUUeZAogcdoJccFuQkAY
 /4YIHs0BUM4BybA==
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

The powertip,ph800480t013-idf02 panel was added to panel-simple, and
with the tc358762 driver, enabled the use of RaspberryPi 7" DSI display.

I have been testing the RaspberryPi 7" DSI display module with TI's
BeagleY-AI, and I can't get a good image with the current panel timings.

It's been quite difficult to figure out exactly what are the issues.
Possibly RPi DSI TX and TI DSI TX have their own quirks which affect
this also. However, now that the tc358762 driver has been fixed wrt. the
signal timings it sends, this patch makes the panel work fine on
BeagleY-AI.

Fix the timings according to the datasheet:

- hsw + hbp must equal to 46. This was correct in the timings, but the
  hsw was very tight, and at least Cadence DSI has trouble with such
  short hsync. Increase hsw to the middle of the hsw range from the
  datasheet, and decrease hbp accordingly.
- vsw + vbp must equal to 23. This was 24, resulting in slight shift in
  the image.
- The upstream timings seemed to aim for 50 fps, but this is a normal 60
  fps panel, so adjust the timings to get 60 fps. As there's no strict
  rule what numbers to pick here, I used the "typical" values from panel
  datasheet for pclk, hfp and vfp. However, vfp of 23 instead of the
  datasheet's 22 give us a closer match to 60 fps, so I used that.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index c95964ba25a9..2e84a8ea518f 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4191,15 +4191,15 @@ static const struct panel_desc powertip_ph128800t006_zhc01 = {
 };
 
 static const struct drm_display_mode powertip_ph800480t013_idf02_mode = {
-	.clock = 24750,
+	.clock = 33333,
 	.hdisplay = 800,
-	.hsync_start = 800 + 54,
-	.hsync_end = 800 + 54 + 2,
-	.htotal = 800 + 54 + 2 + 44,
+	.hsync_start = 800 + 210,
+	.hsync_end = 800 + 210 + 20,
+	.htotal = 800 + 210 + 20 + 26,
 	.vdisplay = 480,
-	.vsync_start = 480 + 49,
-	.vsync_end = 480 + 49 + 2,
-	.vtotal = 480 + 49 + 2 + 22,
+	.vsync_start = 480 + 23,
+	.vsync_end = 480 + 23 + 2,
+	.vtotal = 480 + 23 + 2 + 21,
 	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
 };
 

-- 
2.43.0


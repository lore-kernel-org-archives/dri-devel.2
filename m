Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D2610ED656
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E22A610E3A3;
	Fri, 27 Mar 2026 10:22:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZkOzRoRq";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A48C10E3A3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:22:33 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1F11D3040;
 Fri, 27 Mar 2026 11:21:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774606872;
 bh=HpBlPdT7ErlnfelebW226T9UOnx+13QabRZ1MxOAU+w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ZkOzRoRqp3lRrkfmRFC/2ViRAWZUNPdakT3m8yrdpshQxA/xc2I+EgYxqGjNyR97H
 HnSNNVBWt9Z9uEI5FGAJCZmbxNFl/No6VE0Bdhr2TwIIn8k36S4d6650aCDSyjyQz7
 GlZTRRz8nDADyJmrYZkSk9vMX0+4nuxvBEkmiInw=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 27 Mar 2026 12:21:57 +0200
Subject: [PATCH v2 09/12] drm/bridge: tc358762: Fix sync polarities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-tc358762-fixes-v2-9-3589d3c45f4a@ideasonboard.com>
References: <20260327-tc358762-fixes-v2-0-3589d3c45f4a@ideasonboard.com>
In-Reply-To: <20260327-tc358762-fixes-v2-0-3589d3c45f4a@ideasonboard.com>
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
 bh=HpBlPdT7ErlnfelebW226T9UOnx+13QabRZ1MxOAU+w=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxlpc1o+8+U9swqei2XEhTbcGIn3Y4wTtUKaDt
 SurfryBIoaJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacZaXAAKCRD6PaqMvJYe
 9WDWEACAR5Qm2mpb0PCUHiDO8DJplXRUF+wQ3GSP88KyIEJySodtYEAGJhiUwUX/mkTfdAXQOQL
 Znu8jY3PeVzcrcelHgnm55j68EzjKh+U3VB/Wb1Om1iLAA547bZLmCOQBWl6wAJ6lIU1Y8Ckddc
 s5kc5daxOdaoFADKhCmkHs8+H0pcbnoMstM7R7J3BtcF/Bni4mbKUZoUyBwCziAt5qUyZoPbd0K
 4r5yBMU8Vt0/EQqtjm5wwCvWKU7AjHDq/ws+RvTJaaCYff3SW0PpSF9SGrwbz0/iBI8opY38KJO
 z2cBt/uhIg+h+k6GMAGpQ/g+Yhn2T07QsOy/4VUPFUiAvj5ekwVeLAUf7SEItdpcdphDNKpLZyy
 OtVR6UvZz5M2G1N8HazOc0+IlnoE7F+7ktBiyQnia/BRancBolJNIhbkKwfjy3QYsU5fFRdTRy5
 iUydb142XERtcQTufpP3jdQEtSkqx0Je463LL433fWyLNtfLUhSvOnf5C1FFq4yRCUCF6TmG/18
 ng/iRVIm+clxPQIQBRiWyMFb0LBgo3ZAa4kasIedYtmwy1j63O+3lnKIXdCuvF4oo+Xi5DzHG2g
 +8bMK0f3vhWKlELwqFdI1oMAL9/vkt+BkrQPVBLpZWTijUOubjTEQFnkuHQKqJXMTKbWCK0OcxI
 ubLsqshUrUAZSRw==
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
index d3bcdf8af804..26999b97edae 100644
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


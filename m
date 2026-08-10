Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B745C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 09:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4107A10E794;
	Mon, 10 Aug 2026 09:55:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BdlyOso0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2349110E788
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 09:55:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E6FB743D2C;
 Mon, 10 Aug 2026 09:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF665C2BCFA;
 Mon, 10 Aug 2026 09:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786355742;
 bh=Bowpf5/pvv+5XsQhGmAgRnTtq9swcIDJArfdD0iEFUE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=BdlyOso0B4McvQe/cnE6EKBioXOJ9NbJmPHbvkJD+1ErZcu+JO+Mm6kGykBocjG5H
 Uohucq5kVHxSkeYwcGKq1VdoJuClgf9Kk57Q889MB/IbXmnyBjinPu6aC9Hwc1CrLS
 530K4I8ffS4Ab6tiO993d3DfYLZrqG//vv7pKjV0g3ixH1kEW4LceDa05jEKndUaHU
 fAITzLm6hAjo8lgYQvCbrsRUgWYvFLnMnC78x97KO7xSpeR2AVcvrGDETHmpnwkTGS
 j9Sn129ZYPgZcJWkByS9kHurJJ3BtNf8jD22fD7HDTiF2XRltfSM6Z6kTMibu3yFEe
 d/WD16sV3P9eQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9F34DC5AC82;
 Mon, 10 Aug 2026 09:55:42 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 10 Aug 2026 11:55:38 +0200
Subject: [PATCH v2 2/2] drm/panel: lg-sw43408: use the full DCS brightness
 range
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-fix-blueline-panel-v2-2-9344dfdbc3f9@ixit.cz>
References: <20260810-fix-blueline-panel-v2-0-9344dfdbc3f9@ixit.cz>
In-Reply-To: <20260810-fix-blueline-panel-v2-0-9344dfdbc3f9@ixit.cz>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Vinod Koul <vkoul@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1395; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=scglJ6aSldaji48JvrBM5A5u97auNkDSvGSlJqKRe5k=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqeaAc3VgRZEOaTM54OKlXYIzYbhoEhA65NKcDg
 1Hc3lGC9UaJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCanmgHAAKCRBgAj/E00kg
 cg7OD/40s8ISIFOnNA0G1UHYJYr6xaE0We5PGFZzosOsifznr43Ec3S+ss3FAnXBQ69OX8RTwVs
 kJb+U1thvNoo9EDrtBgyvaBZrGGSYyjxo9VmtLgytOxVi482WD3RG4LuZkgaWu81GUDwZ9zYSVy
 NO4/xXC3HARtYloGwunPGDZHOhOiz3iC+qScKC6ccLtUKa3jApxVtzMspF4rrIQQxJ2d+e6NNGV
 gokA/gVp71z/tNSNCv1vftLCqn/nji/w/Iq7iJEi+7QdMhQyMdN94H9Jz5/Pf7gdl07F/tz8GCz
 MJdsjurpIJbesWJhUNuy7nhnjGQw3g7YSOsHSrFPwuJSRSfzh4EIVzy9G168FdLV6WVuChMhLx5
 bp0kQHbgrafoO1jtErlieC6lncLujZQt4MqORy2SD346WkN0cgWiFMREJPGBoBWcPgJxBjEXKaa
 mVTlnbJJThZ6SM81TKPVBjwouCw6auCzBwKpFmGr3do+kg7a+AICrGrcbKijzQTi2XYC58kVkV8
 gK5XqCPRd5Cf8XA2GCSk4eZvVzomoul2uVz0F+ReyHpOdZelZI84QLXtHMS9yOOe6OhIsTKn4PF
 cXaXsNGbwJVrGhDCEBHxjx87SEKxH2BIGrrFgHM5QHH7A86C2Bokwea9FARk28AgNI2q9NF/T4/
 ilWGZFgvrZMA/7Q==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: David Heidelberg <david@ixit.cz>

The vendor firmware panel configuration (XBL DisplayDxe panel XML)
declares DCSMaxBrightness 0x332 with a two-byte brightness command,
and the driver already sends two bytes via
mipi_dsi_dcs_set_display_brightness_large().

Capping max_brightness at 255 therefore limits the panel to ~31% of
its real brightness range. Use the firmware maximum.

Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 0bf8e08f10b9c..be132b65b0c13 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -203,17 +203,17 @@ static const struct backlight_ops sw43408_backlight_ops = {
 };
 
 static int sw43408_backlight_init(struct sw43408_panel *ctx)
 {
 	struct device *dev = &ctx->link->dev;
 	const struct backlight_properties props = {
 		.type = BACKLIGHT_PLATFORM,
 		.brightness = 255,
-		.max_brightness = 255,
+		.max_brightness = 818,
 	};
 
 	ctx->base.backlight = devm_backlight_device_register(dev, dev_name(dev), dev,
 							     ctx->link,
 							     &sw43408_backlight_ops,
 							     &props);
 
 	if (IS_ERR(ctx->base.backlight))

-- 
2.55.0



Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F37FCD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7841410EE51;
	Wed, 13 May 2026 13:10:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="HC4D6ZsU";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAB4E10EE58
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:10:46 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9133C1356;
 Wed, 13 May 2026 15:10:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778677837;
 bh=6zcLMRl7/3+FLXDobuB5DdCoAuM7Hiugvtoz8PSqVtg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=HC4D6ZsUeDD5QMTPh1EI9txIa+OBD8/ryH+SaZgjs52XZsmM1g+PRxk10Rpp4fG1E
 2iJ91TCV2DdJVq2Km+2vqywu4OmnyHW8GSpuyZTkm5UxQ/g1yj/CBFHqn3uSM9Np04
 l16ScwaCTNr2G8vmqAy+RGxZs/3B2KN8o3XakXUA=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 13 May 2026 16:10:14 +0300
Subject: [PATCH v3 05/13] drm/bridge: tc358762: Drop SPICMR write
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-tc358762-fixes-v3-5-6698b55008b9@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=906;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=6zcLMRl7/3+FLXDobuB5DdCoAuM7Hiugvtoz8PSqVtg=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBHhM8sb22ZiEp6eDQYF1b3CIE0EuvCKnqVTw1
 3ounV02eYKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagR4TAAKCRD6PaqMvJYe
 9feJD/4qD97oX2BygeKEdsf1qV6uXvFq4vLYfQJUSPOwH/3jKqQ5lf9tsWWmg9e/4C4m3iQrLS0
 xI96L3QgV3SzAAbNof91qCIGp2H/fUPk5CilUdXhm1MD07U14DI3dW8pWWZVOiEb8Sg7ZN++Cmc
 0Vt+B2PTWU1HD4YOhFFDliPp6cf0KvcX1J8W1euinzzPf2guNboQ12X172NDotL9GIoHheCNkil
 Q1tldesMc+ri3nsQ6BbbWMlABiB7yp+q2pNDO21XjkDxZXbtHq8CqVEMkygQy5Mz1Ie272W+mqb
 C9dRsX/LH67bdmaE3OHYj9aLELG4dFJJ/cI5KE+Wpjq3zzJnx6iWN2qmqPJ4BdWqkbSeKTAwSC+
 sf3nmrGn4ec1K550+UVmJV3MpPiEXgm5uw/M4mnAsfyC6W3QD8tX5jE/eH/WXxpzEdOoY50Da9L
 u3Q+WF+oI0DocqsfDA1OLktuyiJ300Peepii/F2/YgPcOc3LFFqIEH8bQ/rLTQ1Vt5tvobjfpT4
 BGtZBvIE6znafbOSMo6kmU1OH1hXI2MZlmzxIDnHp6StiDK0ecryfkchY8F/kgXo1mirsCmirxb
 dM7AM4h2C6v3M38FD+vNtRGBo9se9wZD8/vOzqkfKYQ62MyNQJP7+++bN7jafiEDCNbg5G/vdJj
 1Voc7mC01djAb0g==
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

Drop write to SPICMR. It's unclear why the write is there, as SPI is not
supported in the driver, and it's mostly just writing zeroes to already
zero fields (reset defaults). None of the zero bits written disable
anything wrt. SPI.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index d119e399f7a2..a9c30acf1b14 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -150,8 +150,6 @@ static int tc358762_init(struct tc358762 *ctx)
 	tc358762_write(ctx, PPI_D1S_ATMR, 0);
 	tc358762_write(ctx, PPI_LPTXTIMECNT, LPX_PERIOD);
 
-	tc358762_write(ctx, SPICMR, 0x00);
-
 	lcdctrl = FIELD_PREP(LCDCTRL_PXLFORM, LCDCTRL_PXLFORM_RGB888) |
 		  LCDCTRL_DPI_EN;
 

-- 
2.43.0


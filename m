Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B304910ED659
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03FA510EC55;
	Fri, 27 Mar 2026 10:22:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UDRoLs0P";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34E9910E3A3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:22:29 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3B3F821CD;
 Fri, 27 Mar 2026 11:21:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774606869;
 bh=PGVyxsaF8j/G00K+MUsdNAV/oy/866N9DYBXfv3q49g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=UDRoLs0PqFiEzWuuYFrs38mUFWXWqKY0sIr1bp73/tOJTET1YkgYFUferNt9nEIb0
 bhJMKabiAZwi/LdaZOTqOWs/eeMOVahyDLqgh32B8Juxqw5jnpQn8EE3Ct5XPkUSU3
 jkIXwjdbn0t09fzbolrhYLFrO441QsJ3HclyQn1w=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 27 Mar 2026 12:21:53 +0200
Subject: [PATCH v2 05/12] drm/bridge: tc358762: Drop SPICMR write
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-tc358762-fixes-v2-5-3589d3c45f4a@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=906;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=PGVyxsaF8j/G00K+MUsdNAV/oy/866N9DYBXfv3q49g=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxlpbger4INgg8PPp5MWYU3j9NUmOVrlF35BD8
 KYoF+lIgNGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacZaWwAKCRD6PaqMvJYe
 9XxjD/wLI1KV1av43WpV+cMny4LbP+0qHOAm9X2zOitFHiQBBz1gLCork/X5Y8Y/Slp/JuWfy7o
 JkEsR9gERdw67h4ZBqIgpkxDb3TB/0N6PRoGrilO1tu42q/K4tFuXoi3UQ4JUyCSdBJgpQn/t1b
 dNvzrNuNt8Gd3i/oHEWGi0jVTwIh71B+Yj5GhdvEbDHyq771PvdvyQKTPH/vbqnuYC0uhJPvCuO
 vAUZ+UStbJziV9XDGflXGL3XlN09OqXVAA5x/cBzowZ4rcEDfrzvPMAtZ6c7/PlkFjy0+u/BeQ8
 N4JmcKdsgxN4WJ8Z1KNlxQTFh4eUMi7Wjg9Klc4Wl4dMJIv3n+bGHn+D3T0sLb8wjHLBh47jw6H
 2keKweW7/cYk7jPYYKyPYOeV37rHBU9Jq2SEgAJTO7hv58bnM8TcjC4HPT+ul/tcvMYp5kAoJGi
 7A/jmTf9jQQ+FOiADVDbQhgVUWGZNJmp6hvHHDxDSafHLXL2oLQmZP3HYlCVGxpTqaHLotw+RAQ
 ApRVbQ+HfSiLeBe046ZGFPK+ETB/uz9cARVA8AsXSYlHTd6q1e0F/kKYnOIj0ctPDhK2tvb8hpI
 tpfHI4zAI39G5LFgvcfMIC5TetXGyxriGQ5Ng5pOjoVN8DLh9TU8kPpPRfpcbSl/Zh/fXTwKRG3
 B3XEwyJCnfN5I/g==
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


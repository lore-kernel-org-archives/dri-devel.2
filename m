Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E487DCC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 099291122FD;
	Thu, 15 Oct 2026 11:16:43 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B18421122D6
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:16:34 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2DB14DAB;
 Thu, 15 Oct 2026 13:14:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1792062869;
 bh=ltZBsbuuLUgLruugJggBgV13oqzFIQW+pA1XxlBJnRI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=EagSKtLYPtAvVP4O4GEKXVH3RxxG+j97JjHFVwf59ap3sDps3aDLERHPuGAcRz2PM
 Bgfsx4A7OA0GdTK94ndTO3PROZ09DsGzuwn6uRWtzmiirCy4bbPgvX41GdxbPCOgTf
 5yGsXlkhUjiI5mbp+4ouGy5wdIt134FRa3slA/1U=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 15 Oct 2026 14:15:56 +0300
Subject: [PATCH v5 05/13] drm/bridge: tc358762: Drop SPICMR write
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-tc358762-fixes-v5-5-7cd721a6451b@ideasonboard.com>
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
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=959;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=ltZBsbuuLUgLruugJggBgV13oqzFIQW+pA1XxlBJnRI=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq0LYGFTGAa79oCM0BxNXwNtu1oSVQ8r60xgpfE
 lG3jfO/hBaJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCatC2BgAKCRD6PaqMvJYe
 9aISD/4w9KaNM3oP9zMnNEl+/Xa1awPJhZ/l04SbOCN8TmBLe60Sknvpa1gGh1P1NardwgJ6xjD
 2/8xPm4+O4H9KxCmWdnLiTrYz4YLIxWBP2VdtHD4pA0KMI6wgX9+O1JfTIRYNhHbhbiaix6zSsd
 ZHGRhitRgTWmMrN4hDchqc8Qo4tPhSs1MPeId/mMlikSr3weT2+47RLj6OMtYV7x/YQ2bYrQaW9
 MmA4pCof7nAUVxJK93OQfjXSK2s2S/Nv1hPNxZKvfaraDjKFkAA5vKAh6T5T857us8DAB36yM11
 R5FcxVtaA/Rrx2Kl6x9MWsoyYIcC6hWS1d1oq0ylCG+XyooO5ndtcipbUjCoVUqFWRQ4CMrSrU/
 D7E2f3YslxNgpZD9Jm3hcMGfLCE3qd0SbymXhbD0JRxyiQGmWhqS+QV3P/7etZwHcyDZmByDulQ
 EbV5hQw8hU9oaY9mHcUoUKELBDmqbWDAoERty6vjaJNQ4SR+SKbeEMZ6Blu6FE07EjHR0mjvYJ2
 9gl1eI1IK392aEJlj8ZfUnGgYV3zU9jHJ3pgISh/zTaBm81S054xLu9LNcQtKMUSXFhrJaMDkUW
 PsSUbXHm2nvtpGzcAR3dtX0+pfgOo6EtF1FWfvglwaSaouneZy+09xKP6zYxuhspxENf/IGBcPW
 PDn94QC/F/5u3aQ==
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

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index f5ee781275fc..91bc79d36a74 100644
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


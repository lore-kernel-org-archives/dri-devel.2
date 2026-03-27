Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7A110ED659
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF9DD10ED90;
	Fri, 27 Mar 2026 10:52:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="g7aDzDWF";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55EFE10ED90
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:52:02 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3AF1A1F37;
 Fri, 27 Mar 2026 11:50:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774608642;
 bh=bKZuec5kYGgBPV+Eh+CxWe/iaRbrdjA8eFHR2UuGxk4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=g7aDzDWFbk2AtREqPJ8oMFcdqUYdx8Wdeu3BNXWCIlnK+JSDY1uRzTbE0JR3eSx8A
 +DjlwOHe3IIKJQxYaUnACIy/joshebhrx2cQF0+ODFNwGRa4tbOTMoJdcgvnLol/gv
 2daXLsVwVrXK8H/3Al6IHZyP0A2NYfxLQc94PY3A=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 27 Mar 2026 12:51:40 +0200
Subject: [PATCH 2/3] drm/bridge: cdns-dsi: Fix stop-state at enable time
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-cdns-dsi-fixes-v1-2-088edd40e97f@ideasonboard.com>
References: <20260327-cdns-dsi-fixes-v1-0-088edd40e97f@ideasonboard.com>
In-Reply-To: <20260327-cdns-dsi-fixes-v1-0-088edd40e97f@ideasonboard.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2254;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=bKZuec5kYGgBPV+Eh+CxWe/iaRbrdjA8eFHR2UuGxk4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxmFNCvSO/8Auwg+O0UhqcvIgANZ16TH9W3MrW
 xEkp/i5qPaJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacZhTQAKCRD6PaqMvJYe
 9WSfEACHRL1MiwMBI3PMoRS75MOgE0blxjA4VjxoSz/nhjq/TyoF+Fv2+8i4caYH9DaodniVtWq
 URca+n+IQGdcX6gLagBS2qheSKFLzqWIsAoVfY+TUeIgE/qjbVxMQ5gSPtHGoQDcTDSzF4CFr8o
 EnIaLRgyKgViGOacs/X63zTUWF9UG6Apfeta06JFaqekOIU0L4m0j+UJdpeQ3FeAHnIEdiPWQnZ
 I9EpLL1PirFrlIw34gxCBejuzXHghw+wObY7j44OU7nXG+U3AvROofvC5GMlnag49/J6P1Ert/n
 xqk5OhTBP2cKVcS7fav1AUGgF5cM3QYFIL+e5nRxWt0J0KzZAhRKmLzmd9D7g6cNaVtDhWEeLKE
 8UMFozlGaRLjM7mp2GTB68jIfHydUwo67n+soJ6u88RiLTszmzNNWWWFFCmDWXQydQJBQK/4cjS
 58UsAhPfhz9tyPlnKPhF9+U+GoDbQlhFAZDrqf+NKfrwokuBwq0t5tR48ZXkbieJv0MWjPRrvrw
 gnShGiWAxReUMcTmv7ZWaz3xAGIlzkCCDAnJALD4OsAW7L4haI4S5cyZIEAlHHEP1UJTSr5eEmK
 VRLfW5uqcKpHqzetYCDllNaAd3nsVBIAh2cjwqjuXDDbeC2e7yAt3xnIYPCY/NsJV1FXzqzaQ5R
 kocQt8zLNex+nSg==
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

When using continuous clock, the cdns dsi doesn't keep the clock lanes in
LP-11 long enough to signal a stop state, although the data lanes are
kept high long enough. The data lanes most likely stay in LP-11 until
there is data to send, so the LP-11 duration is not defined.

While some DSI peripherals seem to work fine without correct stop-state
on the clock lane, at least Xilinx D-PHY RX fails to initialize if it
does not observe correct stop-state.

Add explicit stop-state handling to the driver. This is not described in
the documentation, but observing the clk and data lanes with an
oscilloscope, the solution in this patch seems to work:

Set the FORCE_STOP flags for clock and data lanes before starting the
D-PHY power up and init sequence, and drop the FORCE_STOP flags after
the init has been done, and 100 us has passed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 2c86bf346fea..439d56c69be9 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -635,9 +635,16 @@ static void cdns_dsi_hs_init(struct cdns_dsi *dsi)
 {
 	struct cdns_dsi_output *output = &dsi->output;
 	u32 status;
+	u32 val;
 
 	if (dsi->phy_initialized)
 		return;
+
+	/* Set force stop state on all lanes */
+	val = readl(dsi->regs + MCTL_MAIN_EN);
+	val |= DATA_FORCE_STOP | CLK_FORCE_STOP;
+	writel(val, dsi->regs + MCTL_MAIN_EN);
+
 	/*
 	 * Power all internal DPHY blocks down and maintain their reset line
 	 * asserted before changing the DPHY config.
@@ -661,6 +668,13 @@ static void cdns_dsi_hs_init(struct cdns_dsi *dsi)
 	writel(DPHY_CMN_PSO | DPHY_ALL_D_PDN | DPHY_C_PDN | DPHY_CMN_PDN |
 	       DPHY_D_RSTB(output->dev->lanes) | DPHY_C_RSTB,
 	       dsi->regs + MCTL_DPHY_CFG0);
+
+	/* Keep stop state for at least 100 us */
+	usleep_range(100, 200);
+
+	val &= ~(DATA_FORCE_STOP | CLK_FORCE_STOP);
+	writel(val, dsi->regs + MCTL_MAIN_EN);
+
 	dsi->phy_initialized = true;
 }
 

-- 
2.43.0


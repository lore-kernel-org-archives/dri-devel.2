Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA74A10ED656
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A9F010ED94;
	Fri, 27 Mar 2026 10:52:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YkbTOdsM";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E93410ED90
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:52:03 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2D554201C;
 Fri, 27 Mar 2026 11:50:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774608642;
 bh=wM6wcfZG2Hp3NqdH/3MzNxHNKi1PZKPeYKr8ycK+xX4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=YkbTOdsM4Yn3Ccl/zdQIi8qj/62sD5J7rOVv/nFgFCmfYWjz3qQ7lcRhgted3MA4c
 xvGlAzeRSY2qTU2lmr2H6yA65vQGnACGPq2xqE4ONQIg5ImomId0eDmIN2PmUmvbC/
 khMZgjGGISuiot19C8oFDXOZGmUE5wTeYx+hNtc0=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 27 Mar 2026 12:51:41 +0200
Subject: [PATCH 3/3] drm/bridge: cdns-dsi: Fix mode and bus flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-cdns-dsi-fixes-v1-3-088edd40e97f@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=wM6wcfZG2Hp3NqdH/3MzNxHNKi1PZKPeYKr8ycK+xX4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxmFNOdl1QHrBIbEK17SqSI9kTYbd47kW3xaTF
 RENgZU86beJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacZhTQAKCRD6PaqMvJYe
 9bxuD/0YSjl2TrOuCxS3KqXl96CShf05T1COvDWZ240nSYA/NLdQfH4sUXyuwCI1BxK20uRiLzr
 gL8O08bVVOj7YdojLwBEDVDdZ2wcnRcZine4b2oSL6DglEEooGH1KaucpDz5fMxxw3Rz+ksDMWx
 kDLcBvCpTsqrXsjSBcbqUONnNznzNuWr7NW9mhU203gIZbQYlUNBBVXDOwC5zzj60Lbl8LLpdES
 PZ2PHFjHdaYSUSzgvs+byZBOBvuTAAUglo4i6RUr6VpxSVQNFx1+xlGBwxJDN8yZAMoZAtV5nwD
 3Iviyd8eJBCsls+3wOj4JTlUZE3JgtgzoD1hi32AjJd0YBJg04rpJP6e9Xqnj+jBOe0w+7dzgMp
 iZKGGBSZme57HAUR7YryDfqvxcWuUmwh6BygDpNtIG3CNfJu/2x5+IF8bNyLessXfIvnRNA0Cqb
 cCcdXnrDB2073zV+sJWEv+/GS3+0xj4TquU1AYjnprirHQv6b6jhCnGORMIMiqTyjob4K1Vpqce
 f9aRjRmf0Al/A4PXZLoFWv/w7bcTDXHPRWnKyNmIWaWnT1/921Hezg5PlcTe2/Ns/VL5BB6U+Cb
 wKVMIpTn1PRm3NuBKpOAjLs2UfRvvXiaMeBtzMsnqiG1Sz7HsiC6SbGdbCT90Iw0jwG3boygbGx
 uCjn7Gld8XdJNYw==
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

The driver adjusts the flags in adjusted_mode to force the source to
send negative syncs. However, cdns-dsi also requires DE high, which is
not handled at all.

Add the correct DE high, along with explicit drive flags, via
bridge_state->input_bus_cfg.flags.

Also make the mode flags more robust: instead of passing the flags
forward with corrected h/v syncs, just set the full flags variable, as
there's no reason to pass any flags from the connector side to the
source.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 439d56c69be9..ca95e7a6f61a 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -967,9 +967,11 @@ static int cdns_dsi_bridge_atomic_check(struct drm_bridge *bridge,
 	struct videomode vm;
 	long pclk;
 
-	/* cdns-dsi requires negative syncs */
-	adjusted_mode->flags &= ~(DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
-	adjusted_mode->flags |= DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC;
+	/* cdns-dsi requires negative syncs, and DE high */
+	adjusted_mode->flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC;
+	bridge_state->input_bus_cfg.flags = DRM_BUS_FLAG_DE_HIGH |
+					    DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE |
+					    DRM_BUS_FLAG_SYNC_DRIVE_POSEDGE;
 
 	/*
 	 * The DPHY PLL has quite a coarsely grained clock rate options. See

-- 
2.43.0


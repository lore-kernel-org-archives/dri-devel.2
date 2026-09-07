Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4A1C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E961310E487;
	Mon,  7 Sep 2026 11:14:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tBgg0r/p";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 062F610E487
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:14:01 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id AEE0FE4E;
 Mon,  7 Sep 2026 13:12:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788779545;
 bh=IF7/QZzY98Mk0jkHdGau1HOZBoUPWAMSA8NOOznq/JI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=tBgg0r/p7iZoGEU+OoAAFUXIWfQQscO8i7bpzohiKfRQxglP+DTuqEvAbG9hfgL+F
 hwPmX0JUJWYJK0lIoFkI+bihIBx/mwIhiJpRZRIi04Q9KG700A9Llywz62Qf1r8Qk6
 JwqjMCcKdDhV1kgJU8ZC2AjJdead+TEXrn86fNtU=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 07 Sep 2026 14:13:37 +0300
Subject: [PATCH v2 3/3] drm/bridge: cdns-dsi: Fix mode and bus flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-cdns-dsi-fixes-v2-3-96d9b116e9bc@ideasonboard.com>
References: <20260907-cdns-dsi-fixes-v2-0-96d9b116e9bc@ideasonboard.com>
In-Reply-To: <20260907-cdns-dsi-fixes-v2-0-96d9b116e9bc@ideasonboard.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=IF7/QZzY98Mk0jkHdGau1HOZBoUPWAMSA8NOOznq/JI=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqnpxz0kjdAEYiV5zem79KE/MRmCXQ9oUH5KLY/
 lOJSRpJRKWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCap6ccwAKCRD6PaqMvJYe
 9SqID/9oNHPq/E69+5+TkSmXFCeOY58yPDphrYtLDBWH4L+9qOUvjFA3Z18/ErmKqcZNW/PQhPh
 d0HlLa57oQCV5HPtIzbZ20WmDg9C9cU6Zh1wQjDFq+ikjgAzX2CzxvxidYGMwWmw7G2eN1gTBI8
 KS8jpDjJEa2wXUY2RQqaxzY8X/DWDEExP9GMi+PYLJ203Lw1viGXMofkgWvK+KzsEkXpFMblx75
 MbrFkyy4Sj4vpOxLuonEBTNz65AFlG5+jOY9M79BR56gd/Iv8ouixgJLkLLGiouVwxB4cVObf31
 BGgFUDqRDTxgYE+nJiC/RPqiz2x5e9PFIuO5IYU6HU4o1CwUH85ZOabCQKPnW5ktcLc3WGod+HR
 b44cePb50Dp9v5hHV32yO3FCpSuGq4y4lvGdToVU19VelczfWxf70bcR54Bdg7bTBVC/P4CKUoV
 TBQOCaYH79ZS/rSRis+V8AEv94DYpWI+qs82UorcczXCT4GqPFUpJyBJYo8A/tEt668zeqi1uyd
 QOVFDrcJneDZ+X3neN0CkNI6fBIxDwSUr4eEJ9y4SzaYYGE0skQ/XfB5aA7/XwoOmks9AR1Y9lx
 v3TxkD7SDl6K/1ehkTHMeL+rSA9qfrmp7x9v1dVbA0L7Uns9XNFGQqKBygzrpDhCBvgCyz/eEeH
 4SsQmPrXE7MGetA==
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

Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index b9c87f13177a..ebaa060025a9 100644
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


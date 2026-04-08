Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F771073C93
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 12:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22B6010E63B;
	Wed,  8 Apr 2026 12:42:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ROEfoJDw";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7376D10E63B
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 12:42:08 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 1DF8E236;
 Wed,  8 Apr 2026 14:40:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1775652039;
 bh=sfyYf39sm08Vy2f5kjydzUWGnUXTWqP0LYw7KB55p2k=;
 h=From:To:Cc:Subject:Date:From;
 b=ROEfoJDwBVVhhCl7bFfmOcrtNI/M92yazwzrYSn0tjZjc52P/9wy/NWqtnsG6h65q
 gbkLXoSRAJSgogx8n0gf50AeSJa3H0Xof+y/7O+y9XOkjNPuOjSxJBvwhqHy/CCs4n
 r4NQduGP7DlUwRwbAXaIS1P7BvdDqcoEED5n0BLU=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm: rcar-du: Fix crash when no CMM is available
Date: Wed,  8 Apr 2026 15:42:05 +0300
Message-ID: <20260408124205.1962448-1-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Commit 3bce3fdd1ff2 ("drm: rcar-du: Don't leak device_link to CMM")
refactored CMM handling, and introduced an incorrect test for CMM
availability. When no CMM is present, the rcrtc->cmm field is NULL,
testing rcrtc->cmm->dev causes a NULL pointer dereference. This slipped
through testing as all tests were run with the CMM present.

Fix this issue by correctly testing for rcrtc->cmm.

Fixes: 3bce3fdd1ff2 ("drm: rcar-du: Don't leak device_link to CMM")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/dri-devel/CAMuHMdXomz9GFDqkBjGX9Sda_GLccPcrihvFbOz0GAitDVNTbw@mail.gmail.com
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
index 7c36c30a75b6..1a246ebbfc61 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
@@ -513,7 +513,7 @@ static void rcar_du_cmm_setup(struct drm_crtc *crtc)
 	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
 	struct rcar_cmm_config cmm_config = {};
 
-	if (!rcrtc->cmm->dev)
+	if (!rcrtc->cmm)
 		return;
 
 	if (drm_lut)
@@ -667,7 +667,7 @@ static void rcar_du_crtc_stop(struct rcar_du_crtc *rcrtc)
 	if (rcar_du_has(rcrtc->dev, RCAR_DU_FEATURE_VSP1_SOURCE))
 		rcar_du_vsp_disable(rcrtc);
 
-	if (rcrtc->cmm->dev)
+	if (rcrtc->cmm)
 		rcar_cmm_disable(rcrtc->cmm->dev);
 
 	/*
@@ -726,7 +726,7 @@ static void rcar_du_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct rcar_du_crtc_state *rstate = to_rcar_crtc_state(crtc->state);
 	struct rcar_du_device *rcdu = rcrtc->dev;
 
-	if (rcrtc->cmm->dev)
+	if (rcrtc->cmm)
 		rcar_cmm_enable(rcrtc->cmm->dev);
 	rcar_du_crtc_get(rcrtc);
 

base-commit: dc2d30e7db8321a6696d266838f7af7e9d1c7155
-- 
Regards,

Laurent Pinchart


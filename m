Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609DA10FC466
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 02:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8653C10E0EB;
	Thu,  9 Apr 2026 02:49:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="fbd4W5wC";
	dkim-atps=neutral
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23FC610E0EB
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 02:49:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9084D11276A; Thu,  9 Apr 2026 04:49:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1775702977; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=Y/Vs+lajGNLuHVTZi9YuxQObAJW7yBV0C3O93uFX/q8=;
 b=fbd4W5wCyZNMs4RQdmQV/nWZ2NrK4FZ9nr5hlDhgtMMdsQCYm4IE3dhIv+WqKy056IZ+3m
 XRfHE9ZwPjNhSG9Kd9BNJ5kkzrqMulsMJ5Sb+pSFKp4xbG6YHzeRnwJgzY1/DuqNUTLVXD
 0JmR4dqn3ZyP+R0Cg4nlY+SC4t7k5CUVa8LVvKNWVaKslG9Vn05rwD8QhH87FnVXv1H2s2
 i2Aa5GoPBPOqJPHPVSbIkDe1nWA0+jQwLox3uKzdpFRMoBNqcydS3SSrScQ4dGuV7k1vrt
 IFCNbBEYNo/orIfYT0YIpIYSVmzkcU+MboZdVnhpjVM9AsCwH8KOFs/nqg0VoQ==
From: Marek Vasut <marex@nabladev.com>
To: dri-devel@lists.freedesktop.org
Cc: Marek Vasut <marex@nabladev.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Maxime Ripard <mripard@kernel.org>,
 Philippe Cornu <philippe.cornu@foss.st.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] drm/bridge: stm_lvds: Do not fail atomic_check on disabled
 connector
Date: Thu,  9 Apr 2026 04:48:41 +0200
Message-ID: <20260409024928.344010-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

If the connector is disabled, the new connector state has .crtc field
set to NULL and there is nothing more to validate after that point.
The .crtc field being NULL is not an error. Test for .crtc being NULL,
and if it is NULL, exit early with return 0.

This fixes a failure in suspend/resume path, where the connector is
already disabled, but .atomic_check is called, fails, returns -EINVAL
and blocks the suspend entry.

Fixes: aca1cbc1c986 ("drm/stm: lvds: add new STM32 LVDS Display Interface Transmitter driver")
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Philippe Cornu <philippe.cornu@foss.st.com>
Cc: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
---
 drivers/gpu/drm/stm/lvds.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/stm/lvds.c b/drivers/gpu/drm/stm/lvds.c
index fe38c0984b2b5..25e2ba98f36ae 100644
--- a/drivers/gpu/drm/stm/lvds.c
+++ b/drivers/gpu/drm/stm/lvds.c
@@ -897,14 +897,14 @@ static int lvds_connector_atomic_check(struct drm_connector *connector,
 	if (!conn_state)
 		return -EINVAL;
 
+	if (!conn_state->crtc)
+		return 0;
+
 	if (list_empty(&connector->modes)) {
 		drm_dbg(connector->dev, "connector: empty modes list\n");
 		return -EINVAL;
 	}
 
-	if (!conn_state->crtc)
-		return -EINVAL;
-
 	panel_mode = list_first_entry(&connector->modes,
 				      struct drm_display_mode, head);
 
-- 
2.53.0


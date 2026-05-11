Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407F6CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 23:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B3D910E92C;
	Mon, 11 May 2026 23:56:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Mgi4p/WZ";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B8B110E91E
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 23:56:45 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id EDA1E517;
 Tue, 12 May 2026 01:56:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778543797;
 bh=WaI1CaivcO3SBvuzDR8Tm5rPyhH7QKHE2rsCMfNJz3Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Mgi4p/WZyPmGHd0YNfh9VUTXVfuWSZ3AdR1J/ggW+HFooYMTpX5hMLNLy2FZBcFkk
 bepjqaG9OPoXxcnz9AdKBEpAU2O8h+i2mlN4HbkytazWE03YajMwpum4tC/RaUWyhf
 OxB7e/wosnHbGYqpvGLOcM/mCmBnjLeAXDcXqw7k=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 04/11] drm: renesas: rz-du: Switch to new VSP API
Date: Tue, 12 May 2026 02:56:28 +0300
Message-ID: <20260511235637.3468558-5-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511235637.3468558-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20260511235637.3468558-1-laurent.pinchart+renesas@ideasonboard.com>
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

The vsp1_du_setup_lif() function is deprecated. Use the new
vsp1_du_enable() and vsp1_du_disable() functions instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
Biju, I would like to merge this for v7.2 through the media tree instead
of the DRM tree. Would that be OK with you, or do you expect conflicting
changes to the rz-du driver for v7.2 ?
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
index bd486377f037..d5a1d36db2c1 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c
@@ -55,12 +55,12 @@ void rzg2l_du_vsp_enable(struct rzg2l_du_crtc *crtc)
 		.callback_data = crtc,
 	};
 
-	vsp1_du_setup_lif(crtc->vsp->vsp, crtc->vsp_pipe, &cfg);
+	vsp1_du_enable(crtc->vsp->vsp, crtc->vsp_pipe, &cfg);
 }
 
 void rzg2l_du_vsp_disable(struct rzg2l_du_crtc *crtc)
 {
-	vsp1_du_setup_lif(crtc->vsp->vsp, crtc->vsp_pipe, NULL);
+	vsp1_du_disable(crtc->vsp->vsp, crtc->vsp_pipe);
 }
 
 void rzg2l_du_vsp_atomic_flush(struct rzg2l_du_crtc *crtc)
-- 
Regards,

Laurent Pinchart


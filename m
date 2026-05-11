Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986B0CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 23:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA38A10E93B;
	Mon, 11 May 2026 23:56:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UmkiP5lu";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90CA510E93B
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 23:56:54 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 287C226A5;
 Tue, 12 May 2026 01:56:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778543806;
 bh=NQToRHIqPx06qUtETyThQlKir++AJDt5NL4TiKH+2wE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UmkiP5luI1e8ir/M979ff50FuJkRQnWeJMrcaMy0EkTHFTSYsO1Q1aOi8WSOD4XKL
 4vQXnk0R9K86V+C5oYgmyG5FhRo2RAwQWtwXFspOqDbRF2hWdYcjof3/tBDSpFIp9G
 sz9YKe+vsmE5ZM0IBB/UBa1LjjW06/rgeZliut1Q=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 11/11] media: renesas: vsp1: Drop deprecated
 vsp1_du_setup_lif() function
Date: Tue, 12 May 2026 02:56:35 +0300
Message-ID: <20260511235637.3468558-12-laurent.pinchart+renesas@ideasonboard.com>
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

The vsp1_du_setup_lif() is deprecated and its last users are gone. Drop
it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 include/media/vsp1.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/media/vsp1.h b/include/media/vsp1.h
index d2085cdb7fcb..98089e0a4385 100644
--- a/include/media/vsp1.h
+++ b/include/media/vsp1.h
@@ -48,15 +48,6 @@ int vsp1_du_enable(struct device *dev, unsigned int pipe_index,
 		   const struct vsp1_du_lif_config *cfg);
 int vsp1_du_disable(struct device *dev, unsigned int pipe_index);
 
-static inline int vsp1_du_setup_lif(struct device *dev, unsigned int pipe_index,
-				    const struct vsp1_du_lif_config *cfg)
-{
-	if (cfg)
-		return vsp1_du_enable(dev, pipe_index, cfg);
-	else
-		return vsp1_du_disable(dev, pipe_index);
-}
-
 /**
  * struct vsp1_du_atomic_config - VSP atomic configuration parameters
  * @pixelformat: plane pixel format (V4L2 4CC)
-- 
Regards,

Laurent Pinchart


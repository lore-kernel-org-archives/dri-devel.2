Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CF4CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 23:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1206D10E922;
	Mon, 11 May 2026 23:56:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ns9NbCWk";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BE3910E22A
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 23:56:41 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id D9EC5C59;
 Tue, 12 May 2026 01:56:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778543793;
 bh=MXqD0tcQNcnHW2tzHff801ywnDMdRZcA6m0SJoIXlzY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ns9NbCWkgxBfo5kzvZbBX8cohVnX5osvAWr0rsi/dF9g+tC8e0YnD9LGK7xoj3rke
 ATXTuT4UuaWqy7MiddnpzG8OuanVPc6u0NRB+88qxx3Zk0XskVb9UufxZZnqQ7oRlY
 sF5ZiSt0R7jHLo6jEGcpN/K9zwPFj5RLYELNxrOI=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 01/11] media: renesas: vsp1: Avoid forward function declaration
Date: Tue, 12 May 2026 02:56:25 +0300
Message-ID: <20260511235637.3468558-2-laurent.pinchart+renesas@ideasonboard.com>
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

Reorder functions to avoid the forward declaration of the
vsp1_du_pipeline_configure(). No functional change intended.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../media/platform/renesas/vsp1/vsp1_drm.c    | 90 +++++++++----------
 1 file changed, 44 insertions(+), 46 deletions(-)

diff --git a/drivers/media/platform/renesas/vsp1/vsp1_drm.c b/drivers/media/platform/renesas/vsp1/vsp1_drm.c
index 15d266439564..79b85968b061 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_drm.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_drm.c
@@ -57,6 +57,50 @@ static void vsp1_du_pipeline_frame_end(struct vsp1_pipeline *pipe,
  * Pipeline Configuration
  */
 
+/* Configure all entities in the pipeline. */
+static void vsp1_du_pipeline_configure(struct vsp1_pipeline *pipe)
+{
+	struct vsp1_drm_pipeline *drm_pipe = to_vsp1_drm_pipeline(pipe);
+	struct vsp1_entity *entity;
+	struct vsp1_entity *next;
+	struct vsp1_dl_list *dl;
+	struct vsp1_dl_body *dlb;
+	unsigned int dl_flags = 0;
+
+	vsp1_pipeline_calculate_partition(pipe, &pipe->part_table[0],
+					  drm_pipe->width, 0);
+
+	if (drm_pipe->force_brx_release)
+		dl_flags |= VSP1_DL_FRAME_END_INTERNAL;
+	if (pipe->output->writeback)
+		dl_flags |= VSP1_DL_FRAME_END_WRITEBACK;
+
+	dl = vsp1_dl_list_get(pipe->output->dlm);
+	dlb = vsp1_dl_list_get_body0(dl);
+
+	list_for_each_entry_safe(entity, next, &pipe->entities, list_pipe) {
+		/* Disconnect unused entities from the pipeline. */
+		if (!entity->pipe) {
+			vsp1_dl_body_write(dlb, entity->route->reg,
+					   VI6_DPR_NODE_UNUSED);
+
+			entity->sink = NULL;
+			list_del(&entity->list_pipe);
+
+			continue;
+		}
+
+		vsp1_entity_route_setup(entity, pipe, dlb);
+		vsp1_entity_configure_stream(entity, entity->state, pipe,
+					     dl, dlb);
+		vsp1_entity_configure_frame(entity, pipe, dl, dlb);
+		vsp1_entity_configure_partition(entity, pipe,
+						&pipe->part_table[0], dl, dlb);
+	}
+
+	vsp1_dl_list_commit(dl, dl_flags);
+}
+
 /*
  * Insert the UIF in the pipeline between the prev and next entities. If no UIF
  * is available connect the two entities directly.
@@ -224,8 +268,6 @@ static int vsp1_du_pipeline_setup_rpf(struct vsp1_device *vsp1,
 /* Setup the BRx source pad. */
 static int vsp1_du_pipeline_setup_inputs(struct vsp1_device *vsp1,
 					 struct vsp1_pipeline *pipe);
-static void vsp1_du_pipeline_configure(struct vsp1_pipeline *pipe);
-
 static int vsp1_du_pipeline_setup_brx(struct vsp1_device *vsp1,
 				      struct vsp1_pipeline *pipe)
 {
@@ -541,50 +583,6 @@ static int vsp1_du_pipeline_setup_output(struct vsp1_device *vsp1,
 	return 0;
 }
 
-/* Configure all entities in the pipeline. */
-static void vsp1_du_pipeline_configure(struct vsp1_pipeline *pipe)
-{
-	struct vsp1_drm_pipeline *drm_pipe = to_vsp1_drm_pipeline(pipe);
-	struct vsp1_entity *entity;
-	struct vsp1_entity *next;
-	struct vsp1_dl_list *dl;
-	struct vsp1_dl_body *dlb;
-	unsigned int dl_flags = 0;
-
-	vsp1_pipeline_calculate_partition(pipe, &pipe->part_table[0],
-					  drm_pipe->width, 0);
-
-	if (drm_pipe->force_brx_release)
-		dl_flags |= VSP1_DL_FRAME_END_INTERNAL;
-	if (pipe->output->writeback)
-		dl_flags |= VSP1_DL_FRAME_END_WRITEBACK;
-
-	dl = vsp1_dl_list_get(pipe->output->dlm);
-	dlb = vsp1_dl_list_get_body0(dl);
-
-	list_for_each_entry_safe(entity, next, &pipe->entities, list_pipe) {
-		/* Disconnect unused entities from the pipeline. */
-		if (!entity->pipe) {
-			vsp1_dl_body_write(dlb, entity->route->reg,
-					   VI6_DPR_NODE_UNUSED);
-
-			entity->sink = NULL;
-			list_del(&entity->list_pipe);
-
-			continue;
-		}
-
-		vsp1_entity_route_setup(entity, pipe, dlb);
-		vsp1_entity_configure_stream(entity, entity->state, pipe,
-					     dl, dlb);
-		vsp1_entity_configure_frame(entity, pipe, dl, dlb);
-		vsp1_entity_configure_partition(entity, pipe,
-						&pipe->part_table[0], dl, dlb);
-	}
-
-	vsp1_dl_list_commit(dl, dl_flags);
-}
-
 static int vsp1_du_pipeline_set_rwpf_format(struct vsp1_device *vsp1,
 					    struct vsp1_rwpf *rwpf,
 					    u32 pixelformat, unsigned int pitch)
-- 
Regards,

Laurent Pinchart


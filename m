Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF2BCD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 23:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABEB610E934;
	Mon, 11 May 2026 23:56:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KpV1LJQX";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B73D10E92F
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 23:56:50 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 36F05103F;
 Tue, 12 May 2026 01:56:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778543802;
 bh=fdGEU2xJ030H8+wu+YvJhR5yZlhmdZSpUjGXDBQyNTw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KpV1LJQXf8P75+s3r6a3ohHoCynf5if4EG6XBDO5WOJCMe6H51NGPqRuCF5sJZGy7
 bCwxuojCsoaIBopyfsXZuqq8oUxPLlYuZOnowVVLAWZgxkTwNXayethnofJCHXZO2g
 iZsmVa9O3glrhVoLxnVHPQBSFgihhNzSD7o3oqQ4=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 08/11] media: renesas: vsp1: Use spinlock scoped guards
Date: Tue, 12 May 2026 02:56:32 +0300
Message-ID: <20260511235637.3468558-9-laurent.pinchart+renesas@ideasonboard.com>
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

Replace remaining manual spinlock locking and unlocking with scoped
guards. This simplifies error paths and reduces the amount of code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../media/platform/renesas/vsp1/vsp1_clu.c    | 15 +++--
 drivers/media/platform/renesas/vsp1/vsp1_dl.c | 14 ++---
 .../media/platform/renesas/vsp1/vsp1_drm.c    |  7 +--
 .../media/platform/renesas/vsp1/vsp1_lut.c    | 15 +++--
 .../media/platform/renesas/vsp1/vsp1_pipe.c   | 15 +++--
 .../media/platform/renesas/vsp1/vsp1_video.c  | 59 ++++++++-----------
 .../media/platform/renesas/vsp1/vsp1_wpf.c    |  9 ++-
 7 files changed, 59 insertions(+), 75 deletions(-)

diff --git a/drivers/media/platform/renesas/vsp1/vsp1_clu.c b/drivers/media/platform/renesas/vsp1/vsp1_clu.c
index 04c466c4da81..a6e4bcab5101 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_clu.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_clu.c
@@ -53,9 +53,9 @@ static int clu_set_table(struct vsp1_clu *clu, struct v4l2_ctrl *ctrl)
 	for (i = 0; i < CLU_SIZE; ++i)
 		vsp1_dl_body_write(dlb, VI6_CLU_DATA, ctrl->p_new.p_u32[i]);
 
-	spin_lock_irq(&clu->lock);
-	swap(clu->clu, dlb);
-	spin_unlock_irq(&clu->lock);
+	scoped_guard(spinlock_irq, &clu->lock) {
+		swap(clu->clu, dlb);
+	}
 
 	vsp1_dl_body_put(dlb);
 	return 0;
@@ -162,7 +162,6 @@ static void clu_configure_frame(struct vsp1_entity *entity,
 {
 	struct vsp1_clu *clu = to_clu(&entity->subdev);
 	struct vsp1_dl_body *clu_dlb;
-	unsigned long flags;
 	u32 ctrl = VI6_CLU_CTRL_AAI | VI6_CLU_CTRL_MVS | VI6_CLU_CTRL_EN;
 
 	/* 2D mode can only be used with the YCbCr pixel encoding. */
@@ -173,10 +172,10 @@ static void clu_configure_frame(struct vsp1_entity *entity,
 
 	vsp1_clu_write(clu, dlb, VI6_CLU_CTRL, ctrl);
 
-	spin_lock_irqsave(&clu->lock, flags);
-	clu_dlb = clu->clu;
-	clu->clu = NULL;
-	spin_unlock_irqrestore(&clu->lock, flags);
+	scoped_guard(spinlock_irqsave, &clu->lock) {
+		clu_dlb = clu->clu;
+		clu->clu = NULL;
+	}
 
 	if (clu_dlb) {
 		vsp1_dl_list_add_body(dl, clu_dlb);
diff --git a/drivers/media/platform/renesas/vsp1/vsp1_dl.c b/drivers/media/platform/renesas/vsp1/vsp1_dl.c
index 4a19ff1437b0..3dc74fed91dc 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_dl.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_dl.c
@@ -1064,17 +1064,15 @@ void vsp1_dlm_setup(struct vsp1_device *vsp1)
 
 void vsp1_dlm_reset(struct vsp1_dl_manager *dlm)
 {
-	unsigned long flags;
 	size_t list_count;
 
-	spin_lock_irqsave(&dlm->lock, flags);
+	scoped_guard(spinlock_irqsave, &dlm->lock) {
+		__vsp1_dl_list_put(dlm->active);
+		__vsp1_dl_list_put(dlm->queued);
+		__vsp1_dl_list_put(dlm->pending);
 
-	__vsp1_dl_list_put(dlm->active);
-	__vsp1_dl_list_put(dlm->queued);
-	__vsp1_dl_list_put(dlm->pending);
-
-	list_count = list_count_nodes(&dlm->free);
-	spin_unlock_irqrestore(&dlm->lock, flags);
+		list_count = list_count_nodes(&dlm->free);
+	}
 
 	WARN_ON_ONCE(list_count != dlm->list_count);
 
diff --git a/drivers/media/platform/renesas/vsp1/vsp1_drm.c b/drivers/media/platform/renesas/vsp1/vsp1_drm.c
index 2b64d9b5a81c..f6fbd3475329 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_drm.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_drm.c
@@ -655,7 +655,6 @@ int vsp1_du_enable(struct device *dev, unsigned int pipe_index,
 	struct vsp1_device *vsp1 = dev_get_drvdata(dev);
 	struct vsp1_drm_pipeline *drm_pipe;
 	struct vsp1_pipeline *pipe;
-	unsigned long flags;
 	int ret;
 
 	if (pipe_index >= vsp1->info->lif_count)
@@ -708,9 +707,9 @@ int vsp1_du_enable(struct device *dev, unsigned int pipe_index,
 	}
 
 	/* Start the pipeline. */
-	spin_lock_irqsave(&pipe->irqlock, flags);
-	vsp1_pipeline_run(pipe);
-	spin_unlock_irqrestore(&pipe->irqlock, flags);
+	scoped_guard(spinlock_irqsave, &pipe->irqlock) {
+		vsp1_pipeline_run(pipe);
+	}
 
 	dev_dbg(vsp1->dev, "%s: pipeline enabled\n", __func__);
 
diff --git a/drivers/media/platform/renesas/vsp1/vsp1_lut.c b/drivers/media/platform/renesas/vsp1/vsp1_lut.c
index 94bdedcc5c92..a22c31e17cb7 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_lut.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_lut.c
@@ -50,9 +50,9 @@ static int lut_set_table(struct vsp1_lut *lut, struct v4l2_ctrl *ctrl)
 		vsp1_dl_body_write(dlb, VI6_LUT_TABLE + 4 * i,
 				       ctrl->p_new.p_u32[i]);
 
-	spin_lock_irq(&lut->lock);
-	swap(lut->lut, dlb);
-	spin_unlock_irq(&lut->lock);
+	scoped_guard(spinlock_irq, &lut->lock) {
+		swap(lut->lut, dlb);
+	}
 
 	vsp1_dl_body_put(dlb);
 	return 0;
@@ -132,12 +132,11 @@ static void lut_configure_frame(struct vsp1_entity *entity,
 {
 	struct vsp1_lut *lut = to_lut(&entity->subdev);
 	struct vsp1_dl_body *lut_dlb;
-	unsigned long flags;
 
-	spin_lock_irqsave(&lut->lock, flags);
-	lut_dlb = lut->lut;
-	lut->lut = NULL;
-	spin_unlock_irqrestore(&lut->lock, flags);
+	scoped_guard(spinlock_irqsave, &lut->lock) {
+		lut_dlb = lut->lut;
+		lut->lut = NULL;
+	}
 
 	if (lut_dlb) {
 		vsp1_dl_list_add_body(dl, lut_dlb);
diff --git a/drivers/media/platform/renesas/vsp1/vsp1_pipe.c b/drivers/media/platform/renesas/vsp1/vsp1_pipe.c
index 924e87f91903..f9c7c75a7ad0 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_pipe.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_pipe.c
@@ -496,7 +496,6 @@ int vsp1_pipeline_stop(struct vsp1_pipeline *pipe)
 {
 	struct vsp1_device *vsp1 = pipe->output->entity.vsp1;
 	struct vsp1_entity *entity;
-	unsigned long flags;
 	int ret;
 
 	if (pipe->lif) {
@@ -510,16 +509,16 @@ int vsp1_pipeline_stop(struct vsp1_pipeline *pipe)
 
 		ret = vsp1_reset_wpf(vsp1, pipe->output->entity.index);
 		if (ret == 0) {
-			spin_lock_irqsave(&pipe->irqlock, flags);
-			pipe->state = VSP1_PIPELINE_STOPPED;
-			spin_unlock_irqrestore(&pipe->irqlock, flags);
+			scoped_guard(spinlock_irqsave, &pipe->irqlock) {
+				pipe->state = VSP1_PIPELINE_STOPPED;
+			}
 		}
 	} else {
 		/* Otherwise just request a stop and wait. */
-		spin_lock_irqsave(&pipe->irqlock, flags);
-		if (pipe->state == VSP1_PIPELINE_RUNNING)
-			pipe->state = VSP1_PIPELINE_STOPPING;
-		spin_unlock_irqrestore(&pipe->irqlock, flags);
+		scoped_guard(spinlock_irqsave, &pipe->irqlock) {
+			if (pipe->state == VSP1_PIPELINE_RUNNING)
+				pipe->state = VSP1_PIPELINE_STOPPING;
+		}
 
 		ret = wait_event_timeout(pipe->wq, vsp1_pipeline_stopped(pipe),
 					 msecs_to_jiffies(500));
diff --git a/drivers/media/platform/renesas/vsp1/vsp1_video.c b/drivers/media/platform/renesas/vsp1/vsp1_video.c
index 1e5d9e42cea0..b0eae54273a0 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_video.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_video.c
@@ -209,26 +209,21 @@ vsp1_video_complete_buffer(struct vsp1_video *video)
 	struct vsp1_pipeline *pipe = video->rwpf->entity.pipe;
 	struct vsp1_vb2_buffer *next = NULL;
 	struct vsp1_vb2_buffer *done;
-	unsigned long flags;
 	unsigned int i;
 
-	spin_lock_irqsave(&video->irqlock, flags);
+	scoped_guard(spinlock_irqsave, &video->irqlock) {
+		if (list_empty(&video->irqqueue))
+			return NULL;
 
-	if (list_empty(&video->irqqueue)) {
-		spin_unlock_irqrestore(&video->irqlock, flags);
-		return NULL;
-	}
-
-	done = list_first_entry(&video->irqqueue,
-				struct vsp1_vb2_buffer, queue);
-
-	list_del(&done->queue);
-
-	if (!list_empty(&video->irqqueue))
-		next = list_first_entry(&video->irqqueue,
+		done = list_first_entry(&video->irqqueue,
 					struct vsp1_vb2_buffer, queue);
 
-	spin_unlock_irqrestore(&video->irqlock, flags);
+		list_del(&done->queue);
+
+		if (!list_empty(&video->irqqueue))
+			next = list_first_entry(&video->irqqueue,
+						struct vsp1_vb2_buffer, queue);
+	}
 
 	done->buf.sequence = pipe->sequence;
 	done->buf.vb2_buf.timestamp = ktime_get_ns();
@@ -656,13 +651,12 @@ static void vsp1_video_buffer_queue(struct vb2_buffer *vb)
 	struct vsp1_video *video = vb2_get_drv_priv(vb->vb2_queue);
 	struct vsp1_pipeline *pipe = video->rwpf->entity.pipe;
 	struct vsp1_vb2_buffer *buf = to_vsp1_vb2_buffer(vbuf);
-	unsigned long flags;
 	bool empty;
 
-	spin_lock_irqsave(&video->irqlock, flags);
-	empty = list_empty(&video->irqqueue);
-	list_add_tail(&buf->queue, &video->irqqueue);
-	spin_unlock_irqrestore(&video->irqlock, flags);
+	scoped_guard(spinlock_irqsave, &video->irqlock) {
+		empty = list_empty(&video->irqqueue);
+		list_add_tail(&buf->queue, &video->irqqueue);
+	}
 
 	if (!empty)
 		return;
@@ -843,16 +837,15 @@ static void vsp1_video_stop_streaming(struct vb2_queue *vq)
 {
 	struct vsp1_video *video = vb2_get_drv_priv(vq);
 	struct vsp1_pipeline *pipe = video->rwpf->entity.pipe;
-	unsigned long flags;
 	int ret;
 
 	/*
 	 * Clear the buffers ready flag to make sure the device won't be started
 	 * by a QBUF on the video node on the other side of the pipeline.
 	 */
-	spin_lock_irqsave(&video->irqlock, flags);
-	pipe->buffers_ready &= ~(1 << video->pipe_index);
-	spin_unlock_irqrestore(&video->irqlock, flags);
+	scoped_guard(spinlock_irqsave, &video->irqlock) {
+		pipe->buffers_ready &= ~(1 << video->pipe_index);
+	}
 
 	scoped_guard(mutex, &pipe->lock) {
 		if (--pipe->stream_count == pipe->num_inputs) {
@@ -1118,7 +1111,6 @@ static const struct media_entity_operations vsp1_video_media_ops = {
 
 void vsp1_video_suspend(struct vsp1_device *vsp1)
 {
-	unsigned long flags;
 	unsigned int i;
 	int ret;
 
@@ -1138,10 +1130,10 @@ void vsp1_video_suspend(struct vsp1_device *vsp1)
 		if (pipe == NULL)
 			continue;
 
-		spin_lock_irqsave(&pipe->irqlock, flags);
-		if (pipe->state == VSP1_PIPELINE_RUNNING)
-			pipe->state = VSP1_PIPELINE_STOPPING;
-		spin_unlock_irqrestore(&pipe->irqlock, flags);
+		scoped_guard(spinlock_irqsave, &pipe->irqlock) {
+			if (pipe->state == VSP1_PIPELINE_RUNNING)
+				pipe->state = VSP1_PIPELINE_STOPPING;
+		}
 	}
 
 	for (i = 0; i < vsp1->info->wpf_count; ++i) {
@@ -1165,7 +1157,6 @@ void vsp1_video_suspend(struct vsp1_device *vsp1)
 
 void vsp1_video_resume(struct vsp1_device *vsp1)
 {
-	unsigned long flags;
 	unsigned int i;
 
 	/* Resume all running pipelines. */
@@ -1186,10 +1177,10 @@ void vsp1_video_resume(struct vsp1_device *vsp1)
 		 */
 		pipe->configured = false;
 
-		spin_lock_irqsave(&pipe->irqlock, flags);
-		if (vsp1_pipeline_ready(pipe))
-			vsp1_video_pipeline_run(pipe);
-		spin_unlock_irqrestore(&pipe->irqlock, flags);
+		scoped_guard(spinlock_irqsave, &pipe->irqlock) {
+			if (vsp1_pipeline_ready(pipe))
+				vsp1_video_pipeline_run(pipe);
+		}
 	}
 }
 
diff --git a/drivers/media/platform/renesas/vsp1/vsp1_wpf.c b/drivers/media/platform/renesas/vsp1/vsp1_wpf.c
index 327c7457126f..0ec707d2913f 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_wpf.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_wpf.c
@@ -366,13 +366,12 @@ static void wpf_configure_frame(struct vsp1_entity *entity,
 	const unsigned int mask = BIT(WPF_CTRL_VFLIP)
 				| BIT(WPF_CTRL_HFLIP);
 	struct vsp1_rwpf *wpf = to_rwpf(&entity->subdev);
-	unsigned long flags;
 	u32 outfmt;
 
-	spin_lock_irqsave(&wpf->flip.lock, flags);
-	wpf->flip.active = (wpf->flip.active & ~mask)
-			 | (wpf->flip.pending & mask);
-	spin_unlock_irqrestore(&wpf->flip.lock, flags);
+	scoped_guard(spinlock_irqsave, &wpf->flip.lock) {
+		wpf->flip.active = (wpf->flip.active & ~mask)
+				 | (wpf->flip.pending & mask);
+	}
 
 	outfmt = (wpf->alpha << VI6_WPF_OUTFMT_PDV_SHIFT) | wpf->outfmt;
 
-- 
Regards,

Laurent Pinchart


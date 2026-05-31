Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423F3CD6E52
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 20:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E01A10E53C;
	Sun, 31 May 2026 20:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XqJWAJr8";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD15E10E53C
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 20:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7MCAvQp0Lmq6y+f6Jti83WxbuI8aSD6ctUaY7gC/PIs=; b=XqJWAJr8wmtmPqRM2tg+IPczpr
 Sl1FAqhTXTj04fuCdao8xbVtQhR+K0Gu+3s1x089rFOPeksOHRDcCKzCu7kYFqX9GOL+pbfxCUu1X
 Ts0dAzcSzOpMJHdMiam9sRGkJ+/EJHipDwxsOuDTTRswtrzRztPKhuBwzn+ab5rW6qstHXeFp6iz2
 YaqgFJ4WU9R4rDA49YnEX/Ob5FHKWOVl7KgWOVkZCR/mdgqhMh038YeCn6LxvHfMNAUUlqSqPlxsl
 5PWlFIZ8WWBZQcrBQAAh531JNpNq+ZFVJnYZJwNXWcYRcpMzNl0gqSdWjkSMyASQbrJ82h0Sgfrd9
 5o9uBxgQ==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wTmd4-00Agcp-Oo; Sun, 31 May 2026 22:19:27 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 31 May 2026 17:18:58 -0300
Subject: [PATCH v2 4/4] drm/v3d: Drop the queue argument from
 v3d_job_add_syncobjs()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260531-v3d-perfmon-lifetime-v2-4-60ed4485a203@igalia.com>
References: <20260531-v3d-perfmon-lifetime-v2-0-60ed4485a203@igalia.com>
In-Reply-To: <20260531-v3d-perfmon-lifetime-v2-0-60ed4485a203@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2829; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=OrImHJ5bRLHISUr16khFJZzEOfQxpgA1jC0duYEC47M=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqHJe9Ss/bNVxa3QGyHS4kzzBZECs+iKEnZe6Zw
 PhV7tyHXKyJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCahyXvQAKCRA/8w6Kdoj6
 qugaCACXQxjcGtVwclLJz0Blx6GaG0waUU+u9s3rZqmhK7MXXpNQ5XkwiF1WjSi+cFqo52K/wrh
 oFPbj6gMdNx+hOfyebdOFWsLKJhbQGTeoAi8Keh9KpTSWZNuYcRM80DyOukcXdhp20WUHrFSe4T
 bD0R1gasZdcK37OUGqF2Y2FkdMdJ572hkW0HrsvmLFjVqREHGJy8XCMQ7TTtcPiLmaVOJabfIVB
 7fDb46/x2Y2f2L0knoDpSEsEcCRtwEOUKzjSByXYyvq2g8XsoeKRTMO8lFJm2+UcPnoxCHoWH2y
 1a1iieRbJx0saploiNIK+xfTePbu51eXhH8tmdZg922NBHtX
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

The struct v3d_job now carries its submission queue. The explicit queue
parameter passed alongside the job is therefore redundant, as it can be
read through job->queue directly.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 46fc88bacc95..bfd99935c2ef 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -179,7 +179,7 @@ void v3d_job_put(struct v3d_job *job)
 
 static int
 v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
-		     u32 in_sync, struct v3d_submit_ext *se, enum v3d_queue queue)
+		     u32 in_sync, struct v3d_submit_ext *se)
 {
 	bool has_multisync = se && (se->flags & DRM_V3D_EXT_ID_MULTI_SYNC);
 	struct v3d_dev *v3d = job->v3d;
@@ -193,7 +193,7 @@ v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
 		return ret;
 	}
 
-	if (se->in_sync_count && se->wait_stage == queue) {
+	if (se->in_sync_count && se->wait_stage == job->queue) {
 		struct drm_v3d_sem __user *handle = u64_to_user_ptr(se->in_syncs);
 
 		for (int i = 0; i < se->in_sync_count; i++) {
@@ -481,8 +481,7 @@ v3d_setup_csd_jobs_and_bos(struct v3d_submit *submit,
 	if (ret)
 		return ret;
 
-	ret = v3d_job_add_syncobjs(&job->base, submit->file_priv, args->in_sync,
-				   se, V3D_CSD);
+	ret = v3d_job_add_syncobjs(&job->base, submit->file_priv, args->in_sync, se);
 	if (ret)
 		return ret;
 
@@ -1112,7 +1111,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 		bin->qts = args->qts;
 
 		ret = v3d_job_add_syncobjs(&bin->base, file_priv,
-					   args->in_sync_bcl, &se, V3D_BIN);
+					   args->in_sync_bcl, &se);
 		if (ret)
 			goto fail;
 	}
@@ -1129,8 +1128,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 	if (bin)
 		bin->render = render;
 
-	ret = v3d_job_add_syncobjs(&render->base, file_priv, args->in_sync_rcl,
-				   &se, V3D_RENDER);
+	ret = v3d_job_add_syncobjs(&render->base, file_priv, args->in_sync_rcl, &se);
 	if (ret)
 		goto fail;
 
@@ -1221,7 +1219,7 @@ v3d_submit_tfu_ioctl(struct drm_device *dev, void *data,
 	if (ret)
 		goto fail;
 
-	ret = v3d_job_add_syncobjs(&job->base, file_priv, args->in_sync, &se, V3D_TFU);
+	ret = v3d_job_add_syncobjs(&job->base, file_priv, args->in_sync, &se);
 	if (ret)
 		goto fail;
 
@@ -1413,7 +1411,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 
 	trace_v3d_submit_cpu_ioctl(dev, cpu_job->job_type);
 
-	ret = v3d_job_add_syncobjs(&cpu_job->base, file_priv, 0, &se, V3D_CPU);
+	ret = v3d_job_add_syncobjs(&cpu_job->base, file_priv, 0, &se);
 	if (ret)
 		goto fail;
 

-- 
2.54.0


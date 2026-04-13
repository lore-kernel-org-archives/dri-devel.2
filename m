Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9432CF34C5C
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1F9110E4BD;
	Mon, 13 Apr 2026 15:05:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OAu/JgrH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E4B810E4BD
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b0wfxwG35dOdmhckBBl8Z17z8FsW77hNiY1vmHKZxAQ=; b=OAu/JgrHJ3ahj7EiQm+hJYjDkF
 irT0lCK97lFITajvl62RYB+jXiI8qrRJkVufKWGYg4Ktcnvj6gmNiNnetgtaAhxf+bGefQgiCCuc2
 TFcnL41WbvM0S/dBtEJLHjMYB0cabDFX05pPtjpBwrWA3vRH9PMoeybB3MLGNdi7QU2YawoUelpe7
 SBRf301KNLdr30jgo2EXxxRjP79klS7SCmmbMINYZJGFIa0CEXiwr+yHcSUtfn6OfY/ZAlfnoFi8k
 0faE8ovGVi1qjqZTaBTalVLDvq2++LjRZgcsNYeQFEoudKZ9MIJmBFHwMWB6wK1QXAPhcApxvdCqk
 6/eZLFwQ==;
Received: from [189.7.87.169] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wCIrF-00FSq1-VZ; Mon, 13 Apr 2026 17:05:50 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Mon, 13 Apr 2026 12:03:21 -0300
Subject: [PATCH 06/10] drm/v3d: Reject invalid syncobj handles in submit ioctls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260413-v3d-sched-misc-fixes-v1-6-bac63a8ceb6c@igalia.com>
References: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
In-Reply-To: <20260413-v3d-sched-misc-fixes-v1-0-bac63a8ceb6c@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2056; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=Q5g3xNg0X6Lzi1PrK7gAzsw5X2ljPs2Mw0WB8YkjucM=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBp3QYtenCHSM07DhzjvZnjcipKLvXabaCFIbFCe
 x4yOlasfLiJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCad0GLQAKCRA/8w6Kdoj6
 qt5fB/4n+jgl3mGAR5UxPS7D3+PGYBAABWEqYUuTnf4kMPjwXPmTFAGZWORjzsbXMYlJLxgxQG6
 IX/iW2cl6ShFPA8Sp8wCdWwHqk03G8fs07oUzZ6UzGKhr0WhOZfxqixeaLMUEw8YLkh842Khshd
 ne0RZHZbVBQ3SG19nl4aVPa3JAr+S92+5kcQInnA+wvYR5ZjpKl4R/hAHktsoAgn/jnCU1XwSqg
 v+uFnpuUvEQZA6q87wdAT0WdqLA16Eo6MsLdwMR/q7IsXrkYsENFrA9ZQsUarXZUA6dloRFv/XV
 NKfqBn6Z12wjWQiMnAMsFoXb32/CgxiIMvjy57AekVer9DlH
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

drm_sched_job_add_syncobj_dependency() returns -ENOENT both when the
handle is zero and when the handle is non-zero but does not find a
corresponding existing syncobj (userspace bug). The driver previously
ignored -ENOENT in both cases, silently accepting broken handles.

Distinguish the two: skip the call entirely when the handle is zero, as
there is no dependency, and let -ENOENT propagate for non-zero handles
that don't resolve, turning the error into a proper return to userspace.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 054367ba533d..fe8b5757c3e8 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -171,12 +171,11 @@ v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
 	int ret = 0;
 
 	if (!has_multisync) {
-		ret = drm_sched_job_add_syncobj_dependency(&job->base, file_priv,
-							   in_sync, 0);
-		// TODO: Investigate why this was filtered out for the IOCTL.
-		if (ret && ret != -ENOENT)
-			return ret;
-		return 0;
+		/* Ignore syncobj if its handle is NULL */
+		if (in_sync)
+			ret = drm_sched_job_add_syncobj_dependency(&job->base, file_priv,
+								   in_sync, 0);
+		return ret;
 	}
 
 	if (se->in_sync_count && se->wait_stage == queue) {
@@ -190,11 +189,13 @@ v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
 				return -EFAULT;
 			}
 
-			ret = drm_sched_job_add_syncobj_dependency(&job->base,
-								   file_priv, in.handle, 0);
-			// TODO: Investigate why this was filtered out for the IOCTL.
-			if (ret && ret != -ENOENT)
-				return ret;
+			/* Ignore syncobj if its handle is NULL */
+			if (in.handle) {
+				ret = drm_sched_job_add_syncobj_dependency(&job->base,
+									   file_priv, in.handle, 0);
+				if (ret)
+					return ret;
+			}
 		}
 	}
 

-- 
2.53.0


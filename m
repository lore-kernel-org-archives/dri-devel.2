Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FFDCD3427
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 22:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E85F010E438;
	Sun, 10 May 2026 22:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ESPlGZK4";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9B5610E438
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 22:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3mDsBNW80R2/USGxd/u/JvTV7jpWeWkKWdNdCPr2q4I=; b=ESPlGZK4xoYOoPL9otHhAkatdw
 KHPJ6/wu1bHU/ya68VR8qlgX+H/OiY2V1Kjntc/pO2dgn0VxixQzJaGAm2PzWVmmBMtBWEPudsgLy
 ydQJ8atUcb8kIeIIJTqolD0mtDOnLYApCju8nMxBOdR7ZEcpVmCQtJUltHEpRVCoJky7zYpBDHj8p
 ihwRR5s0xhQa3533ZLKO2Kz9KMpNwfs74Q7CPRUHt17ib7chaqHfDiNX498AvF2yUqb+6ZgLxUppH
 D7ZgZ2RtznXp3WwXXr4f6NAS4Qvnp6G+buYQkmlS+/Twr6Fg9Tjp6kfZ/DYaCLxUXyBUT38oNMalO
 Sbxzwn4A==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wMCO5-008k1J-Kt; Mon, 11 May 2026 00:12:37 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Sun, 10 May 2026 19:12:03 -0300
Subject: [PATCH v2 06/14] drm/v3d: Reject invalid syncobj handles in submit
 ioctls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-v3d-sched-misc-fixes-v2-6-ca4aba343ef6@igalia.com>
References: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
In-Reply-To: <20260510-v3d-sched-misc-fixes-v2-0-ca4aba343ef6@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2113; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=iJQJWiI+ZoCfuKP9R9h+bHavV2FUBb2KtuU9fWEnyQ8=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqAQK0H7gUM9mdbRq6sSyzUZ9F4y5Qm+H6jFUjX
 pfSeEWjiLOJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCagECtAAKCRA/8w6Kdoj6
 qu37B/9wsjeGB1WV9KKXunA8oPhUsftj6MmGHz0V2QImX+v48K9wpHlh/xWQhOPQOdAMw26z8MD
 5QmC8IWVpw5wahV/0wfinnWRUgEFEBfF7afsDmG3S8TFRjzCGT35mu9+/bzuTCYGBMY7757mjFV
 39gCIYSP3w+2sN66RhxKjEEmIeKNrsd1Xq+D01nm+2Oojb/Kk5ktxapzjjOLR6I+6sWqRwoJsYL
 N4N8OKvH0/+Ysdne4h/YPB9j7nf1B3C7wrtI1O4FDUNx/lo/kaomKIMCLXzpfOGye/qBrRa+/SV
 HAvnYzuo32i09qC5BfGNsCSRdcvBkDaORrNSzpsrn0+UxgAk
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

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_submit.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index f9231a87b963..30cb94ee1a2a 100644
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
+		/* Ignore syncobj if its handle is zero */
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
+			/* Ignore syncobj if its handle is zero */
+			if (in.handle) {
+				ret = drm_sched_job_add_syncobj_dependency(&job->base,
+									   file_priv, in.handle, 0);
+				if (ret)
+					return ret;
+			}
 		}
 	}
 

-- 
2.54.0


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F02FCD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ABAF10F0F1;
	Thu,  4 Jun 2026 20:32:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="p1IUapUp";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B74CE10F5F1
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qcQUIxX6ZtEy0WCmgTaSfUU3QyWQKukC4R5mX2hwZEk=; b=p1IUapUpeMxEbeNzhkhZ5UdFCQ
 VbGg9JWgUGLppihUx4FIt6OmbbGGuV93HrqdhATKq5XUmznou2bJsd5TOAx6483k8uQcgXrEsQ6b8
 5i2YAaTT2CxcWIwLwYqTSu3Czmvve0nWP3xy7WogMeG5UYzAnqI5/8cbv3y7TslNPG2Kl7cSyLiHQ
 eIqM/yEIwMb7/hLA2FcmXHeGp/Wujj/0tLpBZ7ZhNJVXFqZIXNsle4EY+wTiLoXbcl/LPQUvcbnv4
 ChhaCxDmoJIbuTivkvhsFbVTxaZ+1uVodztIcVctZ5kv8KlYIrGu7ty+vMT+cah0mIHVCqKr2hBPm
 /HVL8HGw==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wVEk5-00CoGD-Ql; Thu, 04 Jun 2026 22:32:42 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 04 Jun 2026 17:32:17 -0300
Subject: [PATCH v4 04/12] drm/v3d: Reject invalid syncobj handles in submit
 ioctls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-v3d-sched-misc-fixes-v4-4-c068f5bf5ccf@igalia.com>
References: <20260604-v3d-sched-misc-fixes-v4-0-c068f5bf5ccf@igalia.com>
In-Reply-To: <20260604-v3d-sched-misc-fixes-v4-0-c068f5bf5ccf@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2118; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=+O6zw37A+kcU9RvDQULKkI2FLOaesnu5zrxdEXtgwyE=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqIeDTmArVYBTuj5riUDBPy9PVZU7Q0Q3SN7QXA
 rlTJADIjBKJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaiHg0wAKCRA/8w6Kdoj6
 qpa0CADNapH9AuBr2S/43FCdtDZ7tlSYjkUKBFc1FYzvUHm0A12Rre89KLvOdYW46g6nno0UyIj
 KGcIMAkrNuG/VY+3tn3XFhiLFIAKD3UeCaFdfq0n09ymfglNm0/42m+a/cuRp04cK/Htmyb6X45
 4+QamZxhBNKZ3On0fzSeeSnBC7GQ5dTE7xe3YjZEjW9mqw/9fDjcd+Yej8WQHpv+lHXD0Sadr+g
 IeV+2daELNMzwLB3tVi+n6EoE4mRdaQveEu5gVjBbPCPkAYMDHcWlDICGfqBldzoMS0RLLqH7m0
 sIWcG7Ldi9Y9pg9KZQvW5MW9UMZo8t9gCoaNYrb7Eo3ibAZw
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
index 8250376d104c..0babe2e67266 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -189,12 +189,11 @@ v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
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
 
 	if (se->in_sync_count && se->wait_stage == job->queue) {
@@ -208,11 +207,13 @@ v3d_job_add_syncobjs(struct v3d_job *job, struct drm_file *file_priv,
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


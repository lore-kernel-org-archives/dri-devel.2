Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69A2CD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 11:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3207210F566;
	Fri, 22 May 2026 11:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="A6U3D/R/";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9B1710F567
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 11:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bZBTG3MHKF7zlWCHPa7bVpA5DRo981sz/qIq4gzxUqU=; b=A6U3D/R/duMY5taBzS2+rFZ7e+
 GINMLSKhSfQTuKSZVju5B2sC/YvhY2SHvHL7zgJXgRCf5a5YySJv5uZrrU47SaU7+hxWHszp36vQa
 r/EXoO97G59RWrguRmJiMrVRobA6cweh1Bk6EN1D7+Rj/uifk9Ye4eI0eTnuJhNDBGVZTXCkDz3vz
 l3Ca3TfqBSlVIqTgIwPQ9tqmi9VUs8XbwU31jYQl+iBxuK9haQdGvOAfJaV14DOsmSL08mvl/yfla
 GrG1SO+EdU+bvI5Ya1hdc4UBsLTPSq330USHK/lpOjHPXAEiRUWCB6W7X4H1Ga1cal7O2Sb4LDeBB
 M3iQ1hwg==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wQOD1-004ppV-74; Fri, 22 May 2026 13:38:31 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Steven Price <steven.price@arm.com>
Subject: [RFC 1/2] drm/panthor: Remove redundant drm_sched_job_cleanup() from
 the .free_job callback
Date: Fri, 22 May 2026 12:38:16 +0100
Message-ID: <20260522113817.11745-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522113817.11745-1-tvrtko.ursulin@igalia.com>
References: <20260522113817.11745-1-tvrtko.ursulin@igalia.com>
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

After calling drm_sched_job_cleanup(), the free job callback releases it's
reference to the job, where the act of dropping the last reference will
also call the drm_sched_job_cleanup() helper.

We can therefore remove the redundant call from the .free_job callback.

But we have to leave the "if (job->base.s_fence)" guard in job_release(),
since that one not only handles the above described double cleanup, but
also deals with all job cleanup paths which happen before the point the
job was armed.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 5b34032deff8..2bee1c92fb9e 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3434,7 +3434,6 @@ queue_timedout_job(struct drm_sched_job *sched_job)
 
 static void queue_free_job(struct drm_sched_job *sched_job)
 {
-	drm_sched_job_cleanup(sched_job);
 	panthor_job_put(sched_job);
 }
 
-- 
2.54.0


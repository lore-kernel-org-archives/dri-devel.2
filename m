Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE02C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BA7110F38B;
	Thu,  2 Jul 2026 14:38:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qjOyq15q";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DCC410E4F6
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bZBTG3MHKF7zlWCHPa7bVpA5DRo981sz/qIq4gzxUqU=; b=qjOyq15qQuZOgT3KFqb1JtLzL3
 fQ2dss9QPDiE2qUYXNuNkjErH5vKuS2B6Iic/hx/Ie4dMhLP6DJYnrhHXnErszLuZwEPk1W6D7D+0
 08bRDBZ67kykVsh2jK4oHCaA9BYDYy9mVOHNIY4zNJG/lqhpeii51B8htJGrU9EkerMBdJL2kFolc
 hjJPICjBEdfeIna6QSpenCYUBuyVk9FJH3qYuo5d95GpzQeeaU2iieCALKtw1QAWUeoEKrDIK0Skj
 Kd7tmZ4VXkX6rvQiHkXTyv+ZSsu0vI/o6BYUKgxoYWPM921Zjfp2XrVNavjdjH47UNkDBMr93y/0b
 UJkEjUeA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wfIYA-0084XI-EW; Thu, 02 Jul 2026 16:37:58 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 1/8] drm/panthor: Remove redundant drm_sched_job_cleanup() from
 the .free_job callback
Date: Thu,  2 Jul 2026 15:37:38 +0100
Message-ID: <20260702143745.79293-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
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


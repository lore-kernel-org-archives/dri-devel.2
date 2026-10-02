Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B76CA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D06C10E5BF;
	Fri,  2 Oct 2026 12:47:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="UeuJwzKK";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C5D10E5BF
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 12:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=xTeyFYFVFGBsdf9ZKEyyD6jw1lugRlBD9/SP1gkIgPY=; b=UeuJwzKK1yEv6JHjPqmCmqOZnh
 4vdvpsGkRX2btE7Q8vLf1Rjyp0F6tm/Y25XEHpcmUIyZ8rTe5UjgrtOwM8fV9x6XmqJoUWBq7Xbjd
 TeW26EVvDTkwuBtEvgY090Dy6mgoH7RehH16uzilRlJGzFP7qL19XnraabhrDZVA3baBvSRmbQVbd
 T62b/pBsiyLFheNcHb8NN9litVouKXXfN/JKaqwWJFcwLWm8bXAMbwIjJgTYg8k6EJwXQBQsA5tkN
 jdpCtvDI32i1YLcubm1tx7cnsCbr2HiVMJhcVWNwGKxjOt8acL2Y7ELeaZOjVHDC/GflyvDa3TjbT
 IZhq21ZQ==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xCcfB-00AbSf-Db; Fri, 02 Oct 2026 14:46:57 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH] drm/sched: Document entity->stopped is protect by entity->lock
Date: Fri,  2 Oct 2026 13:46:55 +0100
Message-ID: <20261002124655.74716-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Commit
0e118b936dc5 ("drm/sched: Lock drm_sched_entity_is_idle()")
has removed the last unlocked entity->stopped access so lets officially
document it in kerneldoc as locked with the entity lock.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 include/drm/gpu_scheduler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 563d7fb88a6d..3b0978fa8cf0 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -101,7 +101,7 @@ struct drm_sched_entity {
 	 *
 	 * Lock protecting the run-queue (@rq) to which this entity belongs,
 	 * @priority, @last_scheduled and the list of schedulers (@sched_list,
-	 * @num_sched_list) and @rr_ts.
+	 * @num_sched_list), @rr_ts and @stopped.
 	 */
 	spinlock_t			lock;
 
-- 
2.55.0


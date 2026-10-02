Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AD1CA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A082210F900;
	Fri,  2 Oct 2026 15:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Z0teHrSV";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 631DD10E655;
 Fri,  2 Oct 2026 15:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=xTeyFYFVFGBsdf9ZKEyyD6jw1lugRlBD9/SP1gkIgPY=; b=Z0teHrSVnURj0jj+VxVCv91/RK
 d/6oQtkmoHoD4ef+OvxWB6Xby0mkTCNVfqHc4lwinvI1QP1gNCC0mMJP9+GU/SgVFEBkfp9cddar7
 YU+CyNdhVWc2zCVJU7e0Uju4HEo8vMJqQ8Zz4hrTZyJvBYY3N/LwHpsAEkSDnZlGk5Oym63C+699V
 VFdntifZLIFWyZKGlvyU+NtofC9sIFf7ocntkatWN164K8NfqGzw1hL3tRVwn9GrhHMJ47cmdbHRf
 ePu1SCBzyQUnRKJ5by5OHWbIzBApk3Pn9KS/ePlGkkqq6WejZFZAS+ELyANKJMUk/VKcHjHEshmhn
 q3ZukF3g==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xCfTh-00AflP-9h; Fri, 02 Oct 2026 17:47:17 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 2/9] drm/sched: Document entity->stopped is protect by
 entity->lock
Date: Fri,  2 Oct 2026 16:47:06 +0100
Message-ID: <20261002154713.77591-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002154713.77591-1-tvrtko.ursulin@igalia.com>
References: <20261002154713.77591-1-tvrtko.ursulin@igalia.com>
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


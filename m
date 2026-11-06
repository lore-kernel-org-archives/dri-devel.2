Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D593C606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=Qh22rgR7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2913F10EA52;
	Fri,  6 Nov 2026 14:57:13 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD04A10F3C2;
 Fri,  6 Nov 2026 14:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=F84IxpUeK7jTTiYCdMhF27+1AnByzsWW3zJNMTB9BfU=; t=1793977026; x=2109337026; 
 b=Qh22rgR7SCVDe/ZRzTg9ElFf4hTQ9/uw4xdQEn4BFmCy0Hc9Qmcg6ELfhqnoqsI1jS65m6uaJWr
 WkQnFgW+yRGKolz8qDbMH0gIUA342afW1B6/3kf5jSi0Vg+3pmXsyofHjWPq+39yLvqejFoHQQBle
 zb3COTmEnU6jmyVGqojF2RDFWEugnJfY4Oi6w/AcbgBhGTKlTN0CNdxoQb/sDI2PotHHiN3wAzLUB
 2iBsaIpsxM/htqKW5xySgzdFlm9tMwAR4a595QjThGO+Gk3o11PAhl3w/upHRbu4tfBBlyV3dGVF8
 z5uxY3E/sYaJGazzS+7O6AgKsPtTLL0gpNVA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xPLNI-004VmO-3M; Fri, 06 Nov 2026 15:57:04 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 0/7] drm/sched: Replace SPSC queue with a list and spinlock
Date: Fri,  6 Nov 2026 14:56:55 +0000
Message-ID: <20261106145702.61640-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[First four patches are just my queue to avoid conflicts. I am still hoping I
can bring them in a state where all is good since all these together simplify
things.]

So as requested by Philipp and as the title says - replacing the SPSC queue with
a list and a spinlock. A first cut which passes unit tests and smoke testing on
AMD.

But it wasn't easy, since we can't really get away from some of the deeply
ingrained scheduler design points.

Patches 5 and 6 are where the action is at so please focus there first. Please
have a look and see what you think.

Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>

Tvrtko Ursulin (7):
  drm/sched: Disallow initializing entities with un-initialized
    schedulers
  drm/sched: Ignore stopped entity attempt to change its run-queue
  drm/sched: Replace completion with a flush
  drm/sched: Remove the single scheduler special case
  drm/amdgpu: Rework the amdgpu_job_stop_all_jobs_on_sched() hack
  drm/sched: Replace the SPSC queue with a list and a spinlock
  drm/sched: Address the fence_seq fixme

 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       | 110 ++++++++++---
 .../gpu/drm/scheduler/gpu_scheduler_trace.h   |   2 +-
 drivers/gpu/drm/scheduler/sched_entity.c      | 153 +++++++++++-------
 drivers/gpu/drm/scheduler/sched_fence.c       |   6 +-
 drivers/gpu/drm/scheduler/sched_internal.h    |  70 ++++----
 drivers/gpu/drm/scheduler/sched_main.c        |  56 ++-----
 drivers/gpu/drm/scheduler/sched_rq.c          |  77 +++++++--
 .../gpu/drm/scheduler/tests/tests_scheduler.c |   2 +-
 include/drm/gpu_scheduler.h                   |  85 +++++-----
 include/drm/spsc_queue.h                      | 124 --------------
 10 files changed, 349 insertions(+), 336 deletions(-)
 delete mode 100644 include/drm/spsc_queue.h

-- 
2.56.0


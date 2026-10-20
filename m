Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9073660A2603
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=JMLO7Q9S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F409910F6C6;
	Tue, 20 Oct 2026 15:41:34 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77FE610EA03;
 Tue, 20 Oct 2026 15:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=l7QEyEN4KK6nuIOsp9BxvBqEfa1cSjmHrbMcQhFnJYQ=; b=JMLO7Q9SsPXDAil2g6gn5fFU/u
 kkt7y0PC0Z5shYDJ6WMTD8dQLzdkuwyUPyAaYKrbwDdS6ctaVkpoLrOgKO8aKrlYU9AOwWosZJ1c8
 smom+McbiFaDlqNncKhHYpWEMm10hQzCt+qV2YFmJgo3ACkLiNDUja/nn0Cm7CeKQfPcZuDNXXGgh
 37MNHLY2GvF0s5sJHQ2ZF/hLRm2/olatDiV0N4X6DGCIWJ6ZBmcyRan07TQBtLuhzJoQeJ6Edfxoj
 8pIjEC7nS34Ca9aC6T1IQK8K0uPF6t9ALCz48RFC8yk5zXPy0VDjqDoGzcnQ/DICIKSvkvEvKSHdP
 Ob6xI6Bw==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJBxt-004idX-Me; Tue, 20 Oct 2026 17:41:25 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH v2 0/8] DRM scheduler assorted cleanups
Date: Tue, 20 Oct 2026 16:41:15 +0100
Message-ID: <20261020154123.33631-1-tvrtko.ursulin@igalia.com>
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
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A little bit of a dump of my patch queue leading towards the SPSC queue removal
(which is still WIP). Primarily because Philipp asked me to rebase and re-post
"drm/sched: Replace completion with a flush".

Then I realised we agreed to split out one part of that in a separate patch.
Specifically "drm/sched: Ignore stopped entity attempt to change its run-queue".
And I also realized that one is easier to argue for if we also try to tighten
the rules around entity initialization. Which is "drm/sched: Disallow
initializing entities with un-initialized schedulers".

Then there are some trivial cleanups in the same area which should be easy
reviews.

The first patch of the series feel free to ignore. I have sent it separately
already but need to include it so the series actually applies, both for CI, and
should someone want to apply the series.

Last patch in the series is something I would like to get accepted as well since
I think the current list ownership rules are quite bad. As the patch touches the
same functions as the SPSC removal it would be good to get it in first.

Immediate questions are whether patches 2 & 3 are the simplifications which can
indeed be made without any drivers crying foul.

And of course what our AI overlord will have to say on it all.

v2:
 * One patch less in the series - we merged it.
 * "drm/sched: Untangle the scheduler list mess" rewritten a bit because it had
   gotten a bit stale since I first wrote it. It required some tweaks for:
      1) I've changed amdgpu since to use xarray for context management.
      2) Sashiko found I added bugs when added the internal storage for the
         single scheduler list common case.

Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>

Tvrtko Ursulin (8):
  drm/sched: Fix out of bounds entity priority check
  drm/sched: Disallow initializing entities with un-initialized
    schedulers
  drm/sched: Reject double scheduler initialization
  drm/sched: Remove log message of questionable use
  drm/sched: Remove useless log message on memory exhaustion
  drm/sched: Ignore stopped entity attempt to change its run-queue
  drm/sched: Replace completion with a flush
  drm/sched: Untangle the scheduler list mess

 drivers/accel/rocket/rocket_drv.h          |   2 +-
 drivers/accel/rocket/rocket_job.c          |  20 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  15 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |   4 +-
 drivers/gpu/drm/scheduler/sched_entity.c   | 113 ++++++++++++---------
 drivers/gpu/drm/scheduler/sched_internal.h |  14 ++-
 drivers/gpu/drm/scheduler/sched_main.c     |  24 ++---
 drivers/gpu/drm/scheduler/sched_rq.c       |  19 ++--
 include/drm/gpu_scheduler.h                | 100 +++++++++++++-----
 13 files changed, 201 insertions(+), 124 deletions(-)

-- 
2.56.0


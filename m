Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99210CA5FE5
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1370F10F8EC;
	Fri,  2 Oct 2026 15:47:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="a705SXJy";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 689F210E407;
 Fri,  2 Oct 2026 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=e9+utY2ehXSEtyqUcVzSHJCFVSbeHOhIFyCaoh8xylM=; b=a705SXJyRHIDlN4i5EkpjPQoIi
 kHv1oGOqb4vV0BSIdzhZcP54w9fIKgbeeGoLUWIGOOfy3nFmdcqpiu9kx/z+PQ9tz2KcIi1HBm8Ki
 r94l73GuDEDAeSzNKIBwAnZccpVheeYOxWINX8N3yvpobBBUKsHNuTUwgNCFhWri8FZ1bl19ZUTSk
 O+a6Hw/eX+6T/CJZSJmr++N1F8BZ2kmf5+BLYde84LcjxGiX6FG0ksoIVXMpaET7kuDKVH/vt9Yos
 lCWGHUa8Txl2gVwn2Tnz3uFY0yZne2D3E2kBf8lA7TIwVvsGohz5cPsyZxfZiLdHO6oSI8efhoeAq
 FR/RsuBg==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xCfTf-00AflH-QC; Fri, 02 Oct 2026 17:47:15 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 0/9] DRM scheduler assorted cleanups
Date: Fri,  2 Oct 2026 16:47:04 +0100
Message-ID: <20261002154713.77591-1-tvrtko.ursulin@igalia.com>
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

The first two patches of the series feel free to ignore. I have sent those
separately already but need to include them so the series actually applies, both
for CI, and should someone want to apply the series.

Last patch in the series is something I would like to get accepted as well since
I think the current list ownership rules are quite bad. As the patch touches the
same functions as the SPSC removal it would be good to get it in first.

Immediate questions are whether patches 3 & 4 are the simplifications which can
indeed be made without any drivers crying foul.

And of course what our AI overlord will have to say on it all.

Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>

Tvrtko Ursulin (9):
  drm/sched: Fix out of bounds entity priority check
  drm/sched: Document entity->stopped is protect by entity->lock
  drm/sched: Disallow initializing entities with un-initialized
    schedulers
  drm/sched: Reject double scheduler initialization
  drm/sched: Remove log message of questionable use
  drm/sched: Remove useless log message on memory exhaustion
  drm/sched: Ignore stopped entity attempt to change its run-queue
  drm/sched: Replace completion with a flush
  drm/sched: Untangle the scheduler list mess

 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    |  31 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c  |  13 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c      |   3 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c      |   3 +-
 drivers/gpu/drm/scheduler/sched_entity.c   | 138 +++++++++++++--------
 drivers/gpu/drm/scheduler/sched_internal.h |  14 ++-
 drivers/gpu/drm/scheduler/sched_main.c     |  24 +---
 drivers/gpu/drm/scheduler/sched_rq.c       |  19 ++-
 include/drm/gpu_scheduler.h                |  59 +++++----
 10 files changed, 179 insertions(+), 127 deletions(-)

-- 
2.55.0


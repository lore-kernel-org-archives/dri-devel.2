Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37D4CA5FD4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F065810E0E3;
	Thu,  1 Oct 2026 16:07:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="THB8jZEM";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E42DF10E0E3
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 16:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=4QYuRb0X2uumu8sbs5NGQdFMLJDRqhTsgX0DNJA+t0I=; b=
 THB8jZEMkXL/77YtDKbnqzPfPtieQFbtAZnllGSsuH/6wl6StoRNPvohQZWKy+CpiseouZNEs3buK
 sPpYDh/7FW2l8nQpecFn0ZBbM3DEovTyF1/evbmb82jFYN+uvxVTEIWBSPh+h4I+X3yC7PPhidVhH
 Wzd+4C8s52j8tGQPNdltntNw3/tth1TVUwwlUdOcqNsawJct1Lio/ZNDRdBmJSDNR9N28AVWdxHB5
 fEnW5/oFgO4JxbiSSCzjjsLbh8iR4/KFRr4yin3lSSdfR8isShAawUXgXR5tLhRk8xhswfDQT0f/U
 6Gqe5qkjg0VCZZjvpQwdNJTTAv+L9enF9Q==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xCJJT-00ABvn-Lg; Thu, 01 Oct 2026 18:07:15 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Chia-I Wu <olv@google.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Tejun Heo <tj@kernel.org>
Subject: [RFC v6 0/3] Realtime workqueues and panthor realtime submission
Date: Thu,  1 Oct 2026 17:07:08 +0100
Message-ID: <20261001160711.59888-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.55.0
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

This is a continuation of the previous discussion which was here:
https://lore.kernel.org/dri-devel/20260702143745.79293-1-tvrtko.ursulin@igalia.com/

Work is now converted to a much simpler approach by adding real-time scheduling
workqueues based on Tejun's feedback

To re-cap, when an userspace thread submits GPU work, due how the DRM scheduler
uses workqueues to feed the GPU, and regardless of the GPU rendering context
priority, or the CPU scheduling priority of the userspace thread itself, the
use of workqueues can add significant latency to the submit path.

When CPU is busy with enough backround load this translates to severe latency
spikes measured as time between userspace submitting work and GPU actually being
given that work to execute.

With the panthor workqueue upgraded to use WQ_HIGHPRI and varying the CPU
priority of the submit thread, the test program from
https://gitlab.freedesktop.org/panfrost/linux/-/work_items/49 reproduces these
kind of latencies:

         .    N    RT
    M   27   28    32
  95%  163  246   809
  98%  924  991  1882

Legend:

   M = Median submit latency in us
 95% = Percentile latency in us

   . = Userspace submit thread SCHED_OTHER
   N = -||= nice -1
  RT = -||- FIFO 1

Upgrading the panthor workqueues so that the realtime GPU priority queue uses
WQ_RT, submit latency becomes completely controlled with the median of 14us and
95 and 98-th percentiles at 23us and 25us respectively.

Important to note is that VK_QUEUE_GLOBAL_PRIORITY_REALTIME already required
the userspace to have CAP_SYS_NICE, meaning access to real-time workqueues is
effectively also guared behind this capability. 

v2:
 * See patch 1 changelog.

v3:
 * See patch 1 changelog + apologies for v3 following so quickly after v2.
   I have found a race condition as I expanded the testing to a second platform.

v4:
 * See patch 1 changelog.

v5:
 * Rebased on top of tj/for-7.4 branch.
 * New patch in series simplifies unbound sysfs attribute handling.
 * WQ_RTPRI reworked to fold RT marker into attr->nice.

v6:
 * Fixed accidental sysfs attribute rename (patch 1).
 * Various review feedback as per patch 2 changelog.

Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Chia-I Wu <olv@google.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Tejun Heo <tj@kernel.org>

Tvrtko Ursulin (3):
  workqueue: Simplify unbound sysfs attribute registration
  workqueue: Add support for real-time workers
  drm/panthor: Create per queue priority workqueues

 Documentation/core-api/workqueue.rst    |   8 +
 drivers/gpu/drm/panthor/panthor_sched.c |  37 ++++-
 include/linux/workqueue.h               |   5 +-
 kernel/workqueue.c                      | 199 +++++++++++++++---------
 tools/workqueue/wq_dump.py              |   9 +-
 5 files changed, 175 insertions(+), 83 deletions(-)

-- 
2.55.0


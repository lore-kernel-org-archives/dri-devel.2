Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768D5C44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 09:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2E0610E451;
	Fri, 17 Jul 2026 09:02:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="VeCeHrRG";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0BF610F454
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 09:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=DYlPrnKi0sDIL3GeMzXnsfDizLG1u+Q1VI1Qhp75mAQ=; b=
 VeCeHrRGx93QECFAk4ok9s6q80wc24E5AaUmmabqSor3ek9T3LGMRQNTB1Y08P4Q84bx0zuaciufy
 iAFg52RgAvQyVb6V4bNs49y0vBXh/skNZM7JDOgQHPnkw7ikGc8j0ga/pFjMNZiQJnfJj5Nh/Ww8X
 pb3hXA9/RS67iOkoX5/8tnuDscWhkuf2IVLrJBLA2fHAkwbMm5GTj7NaPQkFsYH9GDk6iS8Ksyrpq
 b1mt2NPlaUT77c+lWCti2z+k7cQrpQObYHMswCCfVjXg+GYc9ou7G8S4L55plGPt3OJGszTsm6lWN
 SKaglsnkrNp4+tMq6/vihDZPIr12F/oI+g==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wkeSR-00GJcQ-Ov; Fri, 17 Jul 2026 11:02:11 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC v3 0/2] Realtime workqueues and panthor realtime submission
Date: Fri, 17 Jul 2026 10:02:07 +0100
Message-ID: <20260717090209.26931-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
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
use of workqueues adds (a lot of) latency to the submit path.

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
WQ_RTPRI, submit latency becomes completely controlled with the median of 14us
and 95 and 98-th percentiles at 23us and 25us respectively.

Important to note is that VK_QUEUE_GLOBAL_PRIORITY_REALTIME already required
the userspace to have CAP_SYS_NICE, meaning access to real-time workqueues is
effectively also guared behind this capability. The implementation of WQ_RTPRI
itself also adds some limites on the maximum number of worker threads in order
to prevent scheduling starvation.

v2:
 * See patch 1 changelog.

v3:
 * See patch 1 changelog + apologies for v3 following so quickly after v2.
   I have found a race condition as I expanded the testing to a second platform.

Tvrtko Ursulin (2):
  workqueue: Add support for real-time workers
  drm/panthor: Create per queue priority workqueues

 drivers/gpu/drm/panthor/panthor_sched.c |  38 +++++-
 include/linux/workqueue.h               |  23 +++-
 kernel/workqueue.c                      | 152 ++++++++++++++++++------
 3 files changed, 168 insertions(+), 45 deletions(-)

-- 
2.54.0


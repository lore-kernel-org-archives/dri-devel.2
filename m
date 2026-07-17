Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4515C44517
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 07:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0548210F47A;
	Fri, 17 Jul 2026 07:29:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="S4d6bSVY";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E5AB10F477
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 07:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=xSsOV9ELGlFEkjL8SIaZB75YzEavqeAgKboWv3oTa4c=; b=
 S4d6bSVYU3QgxKmnZb5xyptPTZ7xRjCexN6ztgT/baBY0Yjj60YoCgCWjO+fnKuLX2+9yfNXJi2uJ
 atDkav5TLkHDP1DtgJETc0KtTlJaQmWVMGIX8aERlZlgTIv5PFW+5TM+XxygRJZDB9dJUmxFQICsQ
 0MrmaFXChUTlEqm7rT67RXVX174XlynXrVprsehsNQuGoPC7JLheywW3TqdtUdgc/YlFgpquceOsc
 zMvORUB6IEqs30HfyknPg+4Jp9+w/hJ5Qeib5nDZejMgA56QmEaOdPXZVVwnfL4pH75VEdDbkWh19
 IkTl98oYWlQtXcXjwuPA+x6rrlqKaskimw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wkd07-00GHmC-5x; Fri, 17 Jul 2026 09:28:51 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Chia-I Wu <olv@google.com>,
 Tejun Heo <tj@kernel.org>
Subject: [RFC v2 0/2] Realtime workqueues and panthor realtime submission
Date: Fri, 17 Jul 2026 08:28:44 +0100
Message-ID: <20260717072846.19954-1-tvrtko.ursulin@igalia.com>
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

Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Chia-I Wu <olv@google.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Tejun Heo <tj@kernel.org>

Tvrtko Ursulin (2):
  workqueue: Add support for real-time workers
  drm/panthor: Create per queue priority workqueues

 drivers/gpu/drm/panthor/panthor_sched.c |  38 +++++-
 include/linux/workqueue.h               |  23 +++-
 kernel/workqueue.c                      | 149 ++++++++++++++++++------
 3 files changed, 166 insertions(+), 44 deletions(-)

-- 
2.54.0


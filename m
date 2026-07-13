Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27264C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 14:14:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 799AF10E5C7;
	Mon, 13 Jul 2026 14:14:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Ybz3oC5v";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E94510E5C7
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 14:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dkVFtsI20k0pSynKZ9Bjvpl4aj8VvE2fIouM19dZKx4=; b=Ybz3oC5vB42HEZAQml4EpyerTG
 7khw7FA5PDFdJw9Tyg8MQg28wmLW9KhyVcKQw4Etuv+jRlntncXg+jHTW7wQy+MPmVTbpppGvLjIp
 KiZgJTHWoT8JHqe0T352V/P06fGnfhZYmTGAfAwySEb6mwnvX9hZ0AaOlt1WEvSk51O7KN5m29NX9
 mBnbZWcgg6ASXoTJaB2n7ZKlJt7KFxIUPpl6gl26h6J16wxpaZG5iaDld5TLtg4vcg2zsitPohqWF
 D/RK/MX9EnKBjumMRwZSKzgykJEZvr92GkuaxpAxPiqPROxh2p9yk4SxYp1An2Uge4Y43NrFgzh4f
 23Bj/aPw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wjHQd-00EXHC-J5; Mon, 13 Jul 2026 16:14:39 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, Chia-I Wu <olv@google.com>,
 Tejun Heo <tj@kernel.org>
Subject: [RFC 0/2] Realtime workqueues and panthor realtime submission
Date: Mon, 13 Jul 2026 15:14:34 +0100
Message-ID: <20260713141436.21547-1-tvrtko.ursulin@igalia.com>
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
 include/linux/workqueue.h               |  22 +++-
 kernel/workqueue.c                      | 154 ++++++++++++++++++------
 3 files changed, 164 insertions(+), 50 deletions(-)

-- 
2.54.0


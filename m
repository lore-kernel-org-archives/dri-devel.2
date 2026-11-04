Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A58B606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=WNFpsnOu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD72B10EB7E;
	Wed,  4 Nov 2026 09:52:40 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5194310EB7E
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=SEpR6HAHtiDuojNUaGx9ACZETHwn0dP0e3561ou6MhM=;
 t=1793785955; x=2109145955; b=WNFpsnOuqyIG6vodq/Gkj7aV8YLKtxU9adc2GKag3aqlSZH
 wJS8DkiiKbSip3Sp0saWgBzmXLNyUorragz7L8ihXgrCMJIWrfPZQij4k4OysdNL3iuHXNDN41yA2
 p/3z0HJVKUcqQ8GV3HGH1emUTYOpwktXUNYxfQikZegrLorTisCabcyMhJxMYLQo1GeT7AS8IrULt
 Yqd/eXGxvOeDFxDE4VjaqSufunzIN9ZXlkc9onGpa4F+ChJdWRJunylb/+7RHQhMSid3shGObNqAR
 DqtzU4kMqqTFrUgNHlVfJVdqycR2BMd27v58C90VxjB1eHrF4AJiDt8aTP0Z/b7Q==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xOXfU-00284p-3E; Wed, 04 Nov 2026 10:52:32 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Chia-I Wu <olv@google.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v8 0/6] Realtime workqueues and panthor realtime submission
Date: Wed,  4 Nov 2026 09:52:19 +0000
Message-ID: <20261104095225.32654-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

[And updated latency measurements from v8:]

        us      7.3.0   WQ_RT   +strict_affinity

       median     30     21           11
        min        2      3            2
        max     1038    941          108
       95pct    2384     49           28
       98pct    2922     63           51

[/]

Important to note is that VK_QUEUE_GLOBAL_PRIORITY_REALTIME already requires
that userspace either has CAP_SYS_NICE, or the DRM master capability. The latter
can be had by a single DRM client per GPU, usually the compositor since DRM
master is required to drive the display hardware. It is not possible to have two
DRM master clients simultaneously.

On the overall this limits the number of userspace threads which can access the
RT queue - it either has to be a compositor, or a rendering client which was
explicitly granted CAP_SYS_NICE.

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

v7:
 * Describe DRM master in the cover letter.
 * New patch in series to separate attribute sanitizing steps.
 * WQ_RT updated per the respective change log.

v8:
 * Split out the WQ_RT patch into nice to prio conversion and strict CPU
   affinity as follow up.
 * Added more latency measurements.
 * Dropped bouncing Bradley Morgan's email from cc.
 * Other tweaks as per individual patch change logs.

Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Chia-I Wu <olv@google.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Tejun Heo <tj@kernel.org>

Tvrtko Ursulin (6):
  workqueue: Simplify unbound sysfs attribute registration
  workqueue: Separate sysfs mutable vs immutable wq attribute sanitizing
  workqueue: Convert nice value tracking to priority based
  workqueue: Add support for real-time workers
  workqueue: Imply strict CPU affinity for WQ_RT
  drm/panthor: Create per queue priority workqueues

 Documentation/core-api/workqueue.rst    |   8 +
 drivers/gpu/drm/panthor/panthor_sched.c |  37 +++-
 include/linux/workqueue.h               |   5 +-
 kernel/workqueue.c                      | 238 +++++++++++++++---------
 tools/workqueue/wq_dump.py              |  34 +++-
 5 files changed, 220 insertions(+), 102 deletions(-)

-- 
2.56.0


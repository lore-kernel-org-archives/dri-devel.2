Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADEFCD6E4A
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 18:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCABA10F4FD;
	Thu, 28 May 2026 18:02:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="nCbEw506";
	dkim-atps=neutral
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Thu, 28 May 2026 17:24:49 UTC
Received: from mail-m60224.netease.com (mail-m60224.netease.com
 [210.79.60.224])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB25210F29C;
 Thu, 28 May 2026 17:24:49 +0000 (UTC)
Received: from PC-202605011814.localdomain (unknown
 [IPV6:2409:8924:2013:1a6b:50af:214a:ea2b:7da2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4036887fb;
 Fri, 29 May 2026 01:19:40 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com
Cc: airlied@gmail.com, simona@ffwll.ch, matthew.brost@intel.com,
 niranjana.vishwanathapura@intel.com, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 runyu.xiao@seu.edu.cn, jianhao.xu@seu.edu.cn, stable@vger.kernel.org
Subject: [PATCH] drm/xe/guc_submit: use READ_ONCE/WRITE_ONCE for
 suspend_pending
Date: Fri, 29 May 2026 01:19:30 +0800
Message-Id: <20260528171930.623349-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e6f99548903a1kunm6e76f1936c74e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDH0wdVhhKHh4eSRlIS0JOS1YeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJT0tCQUNCSU9BSUtKSEFKGk0ZQU5LGh1BSUpPGkEeGkkZQU
 wfGklZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=nCbEw506UJYzD67aLWJo3J9KfJ7f5n7W3RuJitYlmy3jzzgRNUkyCgOqG7PBI8hQQqoSd1uJxjf1DsaPOcrjUcMjNQIQP8jQTgzSMtJetk324NNsufjdxZ38sLOit//yEexmNrd+ICitogTYKH8gEvUEx/6aq/DMlz8T4EQeYMo=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=grI5+WkDPw1Kkq8OqNs6nxRmvCl6kGjPTMtYyzg5qYY=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Thu, 28 May 2026 18:02:26 +0000
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

xe_guc_submit.c mixes plain loads and stores of q->guc->suspend_pending
with READ_ONCE()/WRITE_ONCE() accesses in the suspend fence wait/signal
paths.

On a running system this is reachable when one thread queues or waits
for exec queue suspend while another CPU concurrently processes suspend
completion or queue teardown. The shared suspend_pending flag can then
be set in guc_exec_queue_suspend(), sampled in __suspend_fence_signal(),
__guc_exec_queue_process_msg_suspend(), guc_exec_queue_stop(), and
handle_sched_done(), and waited on in guc_exec_queue_suspend_wait().

That leaves a data race on the suspend_pending completion flag and
breaks the local ONCE-access contract for the same shared state.

The issue was found on Linux v6.18.21 by our static analysis tool while
scanning XE shared status flags that mixed plain and ONCE accesses, and
then manually reviewed in xe_guc_submit.c.

It was then confirmed with a reproducible no-device QEMU KCSAN selftest
built into xe.ko that preserved the same access pattern as this code:

  1. a setter thread performs a plain suspend_pending = true;
  2. a signaler thread does a plain if (suspend_pending) check, then
     WRITE_ONCE(suspend_pending, false) and wake_up();
  3. a waiter thread blocks on !READ_ONCE(suspend_pending).

That selftest produced repeated target KCSAN reports between the setter
and signaler threads.

Convert the remaining file-local suspend_pending sites in
xe_guc_submit.c to READ_ONCE()/WRITE_ONCE(). This keeps all set, check,
and clear uses on the same access family and matches the existing
waiter path, which already uses READ_ONCE().

Build-tested with:
  make olddefconfig
  make -j"$(nproc)" drivers/gpu/drm/xe/xe_guc_submit.o

Runtime-tested with:
  reproducible QEMU no-device KCSAN selftest built into xe.ko

No Intel XE hardware was available for runtime testing of the real
driver path. This QEMU run is a no-device KCSAN validation harness, not
a hardware-backed suspend test.

Fixes: 627c961d672d ("drm/xe: Add timeout to preempt fences")
Cc: stable@vger.kernel.org

Representative repeated KCSAN report from the no-device XE selftest:
  xe suspend_pending selftest: starting no-device mixed-ONCE validation
  xe suspend_pending selftest: actor contract = plain set(true), plain
  check, READ_ONCE waiter, WRITE_ONCE clear + wake_up
  ==================================================================
  BUG: KCSAN: data-race in xe_suspend_pending_setter_thread [xe] /
  xe_suspend_pending_signaler_thread [xe]

  write to 0xffff9a87425e0b20 of 1 bytes by task 99 on cpu 1:
   xe_suspend_pending_setter_thread+0x1a/0x60 [xe]
   kthread+0x1c2/0x340
   ret_from_fork+0x166/0x180
   ret_from_fork_asm+0x1a/0x30

  read to 0xffff9a87425e0b20 of 1 bytes by task 100 on cpu 0:
   xe_suspend_pending_signaler_thread+0x48/0x90 [xe]
   kthread+0x1c2/0x340
   ret_from_fork+0x166/0x180
   ret_from_fork_asm+0x1a/0x30

  value changed: 0x00 -> 0x01

  Reported by Kernel Concurrency Sanitizer on:
  CPU: 0 UID: 0 PID: 100 Comm: xe1153_signaler Not tainted
  6.18.21-dirty #23 PREEMPT(voluntary)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
  1.15.0-1 04/01/2014
  ==================================================================
  xe suspend_pending selftest: completed set_iters=22395630
  signal_iters=8319270 wait_iters=9847185 wait_timeouts=3048
  final_pending=0

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index ecee50d82710..1d036ccaacc9 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -1542,7 +1542,7 @@ static void __guc_exec_queue_process_msg_set_sched_props(struct xe_sched_msg *ms
 
 static void __suspend_fence_signal(struct xe_exec_queue *q)
 {
-	if (!q->guc->suspend_pending)
+	if (!READ_ONCE(q->guc->suspend_pending))
 		return;
 
 	WRITE_ONCE(q->guc->suspend_pending, false);
@@ -1555,7 +1555,7 @@ static void suspend_fence_signal(struct xe_exec_queue *q)
 
 	xe_gt_assert(guc_to_gt(guc), exec_queue_suspended(q) || exec_queue_killed(q) ||
 		     xe_guc_read_stopped(guc));
-	xe_gt_assert(guc_to_gt(guc), q->guc->suspend_pending);
+	xe_gt_assert(guc_to_gt(guc), READ_ONCE(q->guc->suspend_pending));
 
 	__suspend_fence_signal(q);
 }
@@ -1583,7 +1583,7 @@ static void __guc_exec_queue_process_msg_suspend(struct xe_sched_msg *msg)
 			set_exec_queue_suspended(q);
 			disable_scheduling(q, false);
 		}
-	} else if (q->guc->suspend_pending) {
+	} else if (READ_ONCE(q->guc->suspend_pending)) {
 		set_exec_queue_suspended(q);
 		suspend_fence_signal(q);
 	}
@@ -1831,7 +1831,7 @@ static int guc_exec_queue_suspend(struct xe_exec_queue *q)
 
 	xe_sched_msg_lock(sched);
 	if (guc_exec_queue_try_add_msg(q, msg, SUSPEND))
-		q->guc->suspend_pending = true;
+		WRITE_ONCE(q->guc->suspend_pending, true);
 	xe_sched_msg_unlock(sched);
 
 	return 0;
@@ -1870,7 +1870,7 @@ static void guc_exec_queue_resume(struct xe_exec_queue *q)
 	struct xe_sched_msg *msg = q->guc->static_msgs + STATIC_MSG_RESUME;
 	struct xe_guc *guc = exec_queue_to_guc(q);
 
-	xe_gt_assert(guc_to_gt(guc), !q->guc->suspend_pending);
+	xe_gt_assert(guc_to_gt(guc), !READ_ONCE(q->guc->suspend_pending));
 
 	xe_sched_msg_lock(sched);
 	guc_exec_queue_try_add_msg(q, msg, RESUME);
@@ -1916,7 +1916,7 @@ static void guc_exec_queue_stop(struct xe_guc *guc, struct xe_exec_queue *q)
 		else if (exec_queue_destroyed(q))
 			__guc_exec_queue_destroy(guc, q);
 	}
-	if (q->guc->suspend_pending) {
+	if (READ_ONCE(q->guc->suspend_pending)) {
 		set_exec_queue_suspended(q);
 		suspend_fence_signal(q);
 	}
@@ -2178,7 +2178,7 @@ static void handle_sched_done(struct xe_guc *guc, struct xe_exec_queue *q,
 		xe_gt_assert(guc_to_gt(guc), runnable_state == 0);
 		xe_gt_assert(guc_to_gt(guc), exec_queue_pending_disable(q));
 
-		if (q->guc->suspend_pending) {
+		if (READ_ONCE(q->guc->suspend_pending)) {
 			suspend_fence_signal(q);
 			clear_exec_queue_pending_disable(q);
 		} else {
-- 
2.34.1

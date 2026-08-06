Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C7FC5AC9F
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29E1310F39F;
	Fri,  7 Aug 2026 06:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="p+fIOCdo";
	dkim-atps=neutral
X-Greylist: delayed 909 seconds by postgrey-1.36 at gabe;
 Thu, 06 Aug 2026 20:30:22 UTC
Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8ED610F2CF;
 Thu,  6 Aug 2026 20:30:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786047310; cv=none; d=zohomail.eu; s=zohoarc; 
 b=gZn0pF+H8ivks4cR7iFfzlUf7nZm/uheQ0XNQI/cItIRLF3KWI49mRjjVXfzXKg7pmrj+lVhN9+15ovMnvUzTvaX4TvrE4AyqGjNc6z63Ty7hEv0KYUGL5hxUvLvWQnwW5bDYGVMaJfNfpQg1aPqatI110DTNx0zzQjXm7t/Ha0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu;
 s=zohoarc; t=1786047310;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=EmIfLahE7z9+SYmHNT0tJ+OI261bLsPigY0gvofbqGA=; 
 b=WQzoktWjWIJZMoSGuG4BOVjcCx/EV41R0YF44UFmRbV7MtmwbsD1bhm9U1yfpb9IvmQ3yIHWtnNULq5/7zcJP+KfDlpDkPfscggEvHHv4ig+KdAIdiZovpKyPFHFTBMm7QPauCkM0+4RYKMgZ0jgzon8Ly5wY1wMXBZMtbLGzkY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
 dkim=pass  header.i=iusegentoo.com;
 spf=pass  smtp.mailfrom=ali@iusegentoo.com;
 dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786047310; 
 s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=EmIfLahE7z9+SYmHNT0tJ+OI261bLsPigY0gvofbqGA=;
 b=p+fIOCdowSJw4jHk/hWl4Xvsilldqi3jbgpvRwsnoWiF29sUze9r1CqC2sLyeC3T
 24VBGRRZEbosAFeOwmWsaJ/15CpxpO5RsBs9xJULyaRuXb0k8keRj9vhfA/YHwAIP9t
 FRmcbgc71kgb8BqMCuFb6zVBgOwaAHU7zlG9W92I=
Received: by mx.zoho.eu with SMTPS id 1786047307857787.9619546403114;
 Thu, 6 Aug 2026 22:15:07 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Matthew Brost <matthew.brost@intel.com>,
 "Thomas Hellstrom" <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] drm/xe: kill the secondary bind queues on multi-GT teardown
Date: Thu,  6 Aug 2026 20:14:55 +0000
Message-ID: <20260806201455.340244-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Mailman-Approved-At: Fri, 07 Aug 2026 06:47:17 +0000
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

xe_exec_queue_kill() walks the multi-GT list with its own cursor as the
list head:

	struct xe_exec_queue *eq = q, *next;

	list_for_each_entry_safe(eq, next, &eq->multi_gt_list,
				 multi_gt_link) {

The head expression is re-evaluated on every loop condition, and by then
eq is the cursor rather than q. multi_gt_list and multi_gt_link are two
names for the same member:

	union {
		struct list_head multi_gt_list;
		struct list_head multi_gt_link;
	};

so list_entry_is_head() compares &eq->multi_gt_link with
&eq->multi_gt_list, which is the same address, and the loop stops before
its first iteration. Modelling the layout and the list macros in a small
program shows it plainly:

	head = &eq->multi_gt_list : 0 secondary queue(s) visited
	head = &q->multi_gt_list  : 2 secondary queue(s) visited

For a VM bind queue on a multi-tile device, xe_exec_queue_create_ioctl()
creates one queue per tile and links the others behind the first, so the
loop is what is meant to stop them. Nothing else does: the two calls
after the loop only cover the primary. The secondaries are still freed,
because __xe_exec_queue_free() walks the same list with &q->multi_gt_list
and drops their references, so they go away without q->ops->kill() ever
running and without being removed from the VM with
xe_vm_remove_compute_exec_queue().

Use the primary as the head, the way the other two walks of this list in
the driver already do, in __xe_exec_queue_free() and in
xe_sync_entry_add_deps().

Single tile devices are unaffected, the list is empty there.

I have no multi-tile device, so this is from reading the code and the
program above rather than measured on hardware.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
The program the commit message refers to, in case it is useful. It uses
the same union layout and the list macros from include/linux/list.h:

  struct xe_exec_queue {
	int id;
	union {
		struct list_head multi_gt_list;
		struct list_head multi_gt_link;
	};
  };

  eq = &prim;
  list_for_each_entry_safe(eq, next, &eq->multi_gt_list, multi_gt_link)
	n++;			/* n == 0 */

  list_for_each_entry_safe(eq, next, &prim.multi_gt_list, multi_gt_link)
	n++;			/* n == 2 */

Compile tested only, I have no Xe device.
---
 drivers/gpu/drm/xe/xe_exec_queue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index 1b5ca3ce578a..85a167857159 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -1571,9 +1571,9 @@ void xe_exec_queue_update_run_ticks(struct xe_exec_queue *q)
  */
 void xe_exec_queue_kill(struct xe_exec_queue *q)
 {
-	struct xe_exec_queue *eq = q, *next;
+	struct xe_exec_queue *eq, *next;
 
-	list_for_each_entry_safe(eq, next, &eq->multi_gt_list,
+	list_for_each_entry_safe(eq, next, &q->multi_gt_list,
 				 multi_gt_link) {
 		q->ops->kill(eq);
 		xe_vm_remove_compute_exec_queue(q->vm, eq);

base-commit: 0d839570765118029aa8bf4a95444c6a11aacf85
-- 
2.55.0


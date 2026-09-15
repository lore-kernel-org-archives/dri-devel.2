Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99701C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C435F10FBB2;
	Tue, 15 Sep 2026 11:33:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ahFaO1Ef";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C945F10FBB2
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:33:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4CC03600D1;
 Tue, 15 Sep 2026 11:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C925A1F000FF;
 Tue, 15 Sep 2026 11:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789471996;
 bh=kxC9gcnyDcUdFgs3BFwtpBJTgH6vRdY/SXD7WnErgiA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ahFaO1Ef44833cAg/ipYrlljR/L9kqnoccr/DtSi2ZpktkAECstbBuUB4GsshEh2o
 37/q8m87cD/I7tX9ntbegeSKXsEeXv4Fw9pAQ1PmC8L6I9T3UsC/XkGoMHM498NGhQ
 FxRqxgdQFODLQ/81upkVsZx/cPJJi/WMcnG+dRajxR0jt8M9VdkFbun0aNVMyEwUQ5
 XtHO0iVATJ50fn1gpeGdm9Z7iWnBGgBM5hv58to7WQYb3XmbmM+8rmfsCFxIh4aLfu
 N9c2Ol8XHEuDPz5itF2eetj1K0aBSEdfHdO3T/ovrf08suZa/vYreTr9DEievxGy1D
 i2Yzc/LALmn9Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:01 +0200
Subject: [PATCH RFC POC 15/50] sh: commit fds on syscall exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-15-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, 
 Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, 
 io-uring@vger.kernel.org, netdev@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 bpf@vger.kernel.org, David Airlie <airlied@redhat.com>, 
 virtualization@lists.linux.dev, kvm@vger.kernel.org, 
 kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3805; i=brauner@kernel.org;
 h=from:subject:message-id; bh=D2omDG7mr0KTxlJ4GQ7QAZA4OxsIde5l5dfPMzqmPuo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KnNWsrlUHjqoaue3sF7yYL+Gfs/u112TbkevtDom
 Y/vkpZJHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZeo2R4c+KV9OZba12svrO
 2S4zjzHAJMO9lPWUn8uRKZu3i0VMOM3I8DSgLigic8O6rYs7ON2+9ysf4gu88um/5/1vyUeDwxn
 92QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

Add TIF_FD_SLOTS to the syscall work mask. syscall_exit rereads the
flags after the system call and goes to syscall_exit_work for any bit
in the all-work mask, but hands over a copy shifted right by eight
when the bit was in the upper byte. Reload the flags there and test
the full mask, so that the bit reaches do_syscall_trace_leave().

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/sh/include/asm/thread_info.h | 10 +++++++---
 arch/sh/kernel/entry-common.S     |  8 ++++++--
 arch/sh/kernel/ptrace_32.c        |  4 ++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/sh/include/asm/thread_info.h b/arch/sh/include/asm/thread_info.h
index 471db5173036..d976cf21f346 100644
--- a/arch/sh/include/asm/thread_info.h
+++ b/arch/sh/include/asm/thread_info.h
@@ -106,6 +106,7 @@ extern void init_thread_xstate(void);
 #define TIF_SECCOMP		6	/* secure computing */
 #define TIF_NOTIFY_RESUME	7	/* callback before returning to user */
 #define TIF_SYSCALL_TRACEPOINT	8	/* for ftrace syscall instrumentation */
+#define TIF_FD_SLOTS		9	/* syscall prepared descriptors */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 
@@ -118,22 +119,25 @@ extern void init_thread_xstate(void);
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
+#define _TIF_FD_SLOTS		(1 << TIF_FD_SLOTS)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 
 /* work to do in syscall trace */
 #define _TIF_WORK_SYSCALL_MASK	(_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP | \
 				 _TIF_SYSCALL_AUDIT | _TIF_SECCOMP    | \
-				 _TIF_SYSCALL_TRACEPOINT)
+				 _TIF_SYSCALL_TRACEPOINT | _TIF_FD_SLOTS)
 
 /* work to do on any return to u-space */
 #define _TIF_ALLWORK_MASK	(_TIF_SYSCALL_TRACE | _TIF_SIGPENDING      | \
 				 _TIF_NEED_RESCHED  | _TIF_SYSCALL_AUDIT   | \
 				 _TIF_SINGLESTEP    | _TIF_NOTIFY_RESUME   | \
-				 _TIF_SYSCALL_TRACEPOINT | _TIF_NOTIFY_SIGNAL)
+				 _TIF_SYSCALL_TRACEPOINT | _TIF_NOTIFY_SIGNAL | \
+				 _TIF_FD_SLOTS)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK		(_TIF_ALLWORK_MASK & ~(_TIF_SYSCALL_TRACE | \
-				 _TIF_SYSCALL_AUDIT | _TIF_SINGLESTEP))
+				 _TIF_SYSCALL_AUDIT | _TIF_SINGLESTEP | \
+				 _TIF_FD_SLOTS))
 
 /*
  * Thread-synchronous status.
diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
index 91ab2607a1ff..593a482e85f5 100644
--- a/arch/sh/kernel/entry-common.S
+++ b/arch/sh/kernel/entry-common.S
@@ -164,9 +164,13 @@ work_resched:
 
 	.align	2
 syscall_exit_work:
-	! r0: current_thread_info->flags
 	! r8: current_thread_info
-	tst	#(_TIF_WORK_SYSCALL_MASK & 0xff), r0
+	mov.l	@(TI_FLAGS,r8), r0		! current_thread_info->flags
+	mov	#(_TIF_WORK_SYSCALL_MASK & 0xff), r1
+	mov	#(_TIF_WORK_SYSCALL_MASK >> 8), r2
+	shll8	r2
+	or	r2, r1
+	tst	r1, r0
 	bt/s	work_pending
 	 tst	#_TIF_NEED_RESCHED, r0
 	TRACE_IRQS_ON
diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index 8794081483fb..3deadd71f464 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -8,6 +8,7 @@
  * Audit support by Yuichi Nakamura <ynakam@hitachisoft.jp>
  */
 #include <linux/kernel.h>
+#include <linux/file.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/mm.h>
@@ -476,6 +477,9 @@ asmlinkage void do_syscall_trace_leave(struct pt_regs *regs)
 {
 	int step;
 
+	if (test_thread_flag(TIF_FD_SLOTS))
+		fd_slots_commit(regs);
+
 	audit_syscall_exit(regs);
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))

-- 
2.53.0


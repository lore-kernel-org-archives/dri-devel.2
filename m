Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0BBC88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0E4510F43A;
	Tue, 15 Sep 2026 11:32:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SOdqCs6F";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0642C10F435
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:32:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D114043CB1;
 Tue, 15 Sep 2026 11:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726AF1F00898;
 Tue, 15 Sep 2026 11:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789471957;
 bh=tg5h99+rXwPUOCpAK+cpKxSGhPsqw2qIAApb6RMTrZY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SOdqCs6FFc+m85zKG65RFoiI3OX0TKhMSKuOGs5mjQ4eozA6DlIsvYCrD/FPZMCya
 K5qpA/W9zCpRVyaXCWr3ds/VJdxhjZpyZLD3Mkij4zr7pNA3EzYnKrukqu7tQxRSqi
 awcZPh3/KgPK/8y13mc/r6QIcT0xahYOLE6UWC72R99aPngllw7ccPTc2jgUwYcOi7
 U74GTjJbNoQ41gpF7hzYmntvuz0kqC5olR/d01x9OdjbXM1vPyPMxQK1LCxZgEa3FG
 WTQ0xmcaX8BwZ3dvqAm6+xxz2psYUrOreD8islOMqgvBbrNJc0rwt/o9saf69osrsb
 1/GNM2HBy3hbw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:30:56 +0200
Subject: [PATCH RFC POC 10/50] microblaze: commit fds on syscall exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-10-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2340; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nXh3DWWigUzaDKpK2QrpbR3RoNJlzLOS8WiJE98yT14=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KnZ7yrddCzxyY2/Tpa2vz6x/Nq//Y/DVseZ581KJ
 U5sMTtwtaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiZXcYGfaG5Cl1dp6Z4vGN
 heGfRKcz571g7fAA9V1NlYVnC00jGBkZbjv+T3n9aZpP9I+Lez8pxBz2mPT/3UPhvvRP08XYkut
 MuAA=
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

Add TIF_FD_SLOTS to the syscall work mask. The return path rereads
the flags after the system call and calls do_syscall_trace_leave()
for any of them which commits the reservations before audit and the
ptrace exit stop.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/microblaze/include/asm/thread_info.h | 5 ++++-
 arch/microblaze/kernel/ptrace.c           | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/microblaze/include/asm/thread_info.h b/arch/microblaze/include/asm/thread_info.h
index 0153f7c2717c..ee2f76589696 100644
--- a/arch/microblaze/include/asm/thread_info.h
+++ b/arch/microblaze/include/asm/thread_info.h
@@ -103,6 +103,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SINGLESTEP		4
 #define TIF_NOTIFY_SIGNAL	5	/* signal notifications exist */
 #define TIF_MEMDIE		6	/* is terminating due to OOM killer */
+#define TIF_FD_SLOTS		7	/* syscall prepared descriptors */
 #define TIF_SYSCALL_AUDIT	9       /* syscall auditing active */
 #define TIF_SECCOMP		10      /* secure computing */
 
@@ -118,10 +119,12 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
+#define _TIF_FD_SLOTS		(1 << TIF_FD_SLOTS)
 
 /* work to do in syscall trace */
 #define _TIF_WORK_SYSCALL_MASK  (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP | \
-				 _TIF_SYSCALL_AUDIT | _TIF_SECCOMP)
+				 _TIF_SYSCALL_AUDIT | _TIF_SECCOMP | \
+				 _TIF_FD_SLOTS)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK		0x0000FFFE
diff --git a/arch/microblaze/kernel/ptrace.c b/arch/microblaze/kernel/ptrace.c
index 236264e932d6..e6951fea8593 100644
--- a/arch/microblaze/kernel/ptrace.c
+++ b/arch/microblaze/kernel/ptrace.c
@@ -25,6 +25,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/file.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
@@ -156,6 +157,9 @@ asmlinkage void do_syscall_trace_leave(struct pt_regs *regs)
 {
 	int step;
 
+	if (test_thread_flag(TIF_FD_SLOTS))
+		fd_slots_commit(regs);
+
 	audit_syscall_exit(regs);
 
 	step = test_thread_flag(TIF_SINGLESTEP);

-- 
2.53.0


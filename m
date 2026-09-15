Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B75C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E27610FBA6;
	Tue, 15 Sep 2026 11:32:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QMTfLeTY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B044410FBB6
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:32:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 32F56600D1;
 Tue, 15 Sep 2026 11:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE001F00893;
 Tue, 15 Sep 2026 11:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789471972;
 bh=o3Xn0Mlg9bYlNfr1tPx70kIWOKOkVzvKHpeJ1YxZNRQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=QMTfLeTYDVR+WQ8hqqaurH77Q8HR0/bGnyAWtgaX4cUnejbUKWLppk13HgBi3Ihb2
 kPmiHpO3rRdjRdgFadsL7sJc/DJxI741nrJT3qwJoOB8nOvZFJR2SADGysKabk6JuM
 +Y12LDqq0mzE7YbHwx9mql9DcjNt8nQ+Qa29un0t3I+ZOs7w3oYnaj7NIhtfD7oEQT
 msU0tD696FtyT0wnuNKm/bu8l4L+UeODuBuHPDS4FE16FLJNZPa3orOY3/myRLQWiZ
 tTW/UkhDAAaCJ74geD4ZPXSRk/hzP4l1fq1WFCmBvRegAKyGOdjJF20sUD1q1zgGGW
 6g8/IXE0N6uQw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:30:58 +0200
Subject: [PATCH RFC POC 12/50] nios2: commit fds on syscall exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-12-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2707; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2xplL1NyM3O4K4L6DfydYO0Aia7T1qYz/CjAzhj5Eew=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KlVmMDBeUTxyxptzYxU+5fHZnpauZQ2vi++wMb75
 MCxSf+ndZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkuybDP6te7od7g1bqHMtY
 dzzj4ZTFk3lluoP6jtXu1/pwK+HTg9WMDD/8g02vzP+as0ShzGk9q8/0pPLva21Sv4v4uacI9y0
 z5QEA
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

Add TIF_FD_SLOTS and test it once the untraced system call has had
its return code translated into the r2 and r7 pair userspace sees.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 arch/nios2/include/asm/thread_info.h | 2 ++
 arch/nios2/kernel/entry.S            | 5 +++++
 arch/nios2/kernel/ptrace.c           | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/arch/nios2/include/asm/thread_info.h b/arch/nios2/include/asm/thread_info.h
index 83df79286d62..7f5816e1b3d6 100644
--- a/arch/nios2/include/asm/thread_info.h
+++ b/arch/nios2/include/asm/thread_info.h
@@ -78,6 +78,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SECCOMP		5	/* secure computing */
 #define TIF_SYSCALL_AUDIT	6	/* syscall auditing active */
 #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
+#define TIF_FD_SLOTS		8	/* syscall prepared descriptors */
 #define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal() */
 
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling
@@ -90,6 +91,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
+#define _TIF_FD_SLOTS		(1 << TIF_FD_SLOTS)
 #define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 
diff --git a/arch/nios2/kernel/entry.S b/arch/nios2/kernel/entry.S
index dd40dfd908e5..b3a99a6db379 100644
--- a/arch/nios2/kernel/entry.S
+++ b/arch/nios2/kernel/entry.S
@@ -222,6 +222,11 @@ translate_rc_and_ret:
 	stw	r2, PT_R2(sp)
 	stw	r1, PT_R7(sp)
 end_translate_rc_and_ret:
+	/* Descriptors reserved by the syscall are committed in
+	 * do_syscall_trace_exit, take the traced exit path for them. */
+	GET_THREAD_INFO r11
+	ldw	r11, TI_FLAGS(r11)
+	BTBNZ	r11, r11, TIF_FD_SLOTS, end_translate_rc_and_ret2
 
 ret_from_exception:
 	ldw	r1, PT_ESTATUS(sp)
diff --git a/arch/nios2/kernel/ptrace.c b/arch/nios2/kernel/ptrace.c
index 2cd7e1ecbd74..5cee1b717662 100644
--- a/arch/nios2/kernel/ptrace.c
+++ b/arch/nios2/kernel/ptrace.c
@@ -9,6 +9,7 @@
 
 #include <linux/elf.h>
 #include <linux/errno.h>
+#include <linux/file.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/ptrace.h>
@@ -140,6 +141,8 @@ asmlinkage int do_syscall_trace_enter(void)
 
 asmlinkage void do_syscall_trace_exit(void)
 {
+	if (test_thread_flag(TIF_FD_SLOTS))
+		fd_slots_commit(task_pt_regs(current));
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		ptrace_report_syscall_exit(task_pt_regs(current), 0);
 }

-- 
2.53.0


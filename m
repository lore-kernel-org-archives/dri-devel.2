Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0A8C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A1E810FBB6;
	Tue, 15 Sep 2026 11:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HDJzJEmZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C144310FBB6
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 11:34:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AA20F4107A;
 Tue, 15 Sep 2026 11:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EE21F00893;
 Tue, 15 Sep 2026 11:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789472041;
 bh=BlmLF2ZRuO4m6DET1Els3sWhQ4ZO5mVaz+8mBj4sJho=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HDJzJEmZuDBgwF9IoA1Gz5NMYoTn4k/FP/na2RbYBjlg+3haxijrVwaRwE0Fk3p/9
 dduNx9tHaAq4bWftWkcBXXJDENOHlSBITqm85+0ggCH0eKZJQhv+2GyhMpTAh1HcUR
 IL/u5wuIBV0Fmym48qvS4CzG79Z/i2ze2wETt3aTQHxG8Pc4zYvnCFHSol5RylYeL5
 DeDCULcNPO4YRlsI5/YH4QJacsVnzDFRpn5P7cN7AYDgGAvw47wCQNw4EF+oXq9GE2
 w8PkFwpysAj7eqpZOt80WGtmVyxOR6Gc7F8TSGsm/1z0bKOSwas/7HiHKc9gSYqyRW
 lGTIAw/PIljeg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 15 Sep 2026 13:31:07 +0200
Subject: [PATCH RFC POC 21/50] io_uring: commit fds per request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-work-fd-reserve-unify-folded-v1-21-4d5217d6b246@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3015; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NBYSDOnHnxDSrh96OHkyXsU+HJM0P1Ng/z5/cryhZ/8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt1KltzMxmiIv1c7m3TjNg8QPLz5dX3E/8KWd5+/mTi
 Ij+kFazjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn8LmZkWGmezx6orRi24Mvy
 //nTSwst3kwr9/rdzhrL4arHrG0lxvDPsq5m2fGL6znYz2+zqF2Vtq5LpSio+++Ecq9zHIpvP/E
 xAgA=
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

io_uring requests don't complete on syscall exit of the task that
submitted them. They complete:

- inline from io_uring_enter()
- from task_work on any return to userspace
- from io-wq workers and from the SQPOLL thread

The CQEs are visible to other threads before any syscall returns. So
commit the reserved descriptors before the completion is posted. Commit
them after ->issue() based on the request's result and before every CQE
they post.

Nothing reachable from io_uring reserves yet. Once SCM_RIGHTS is
converted this keeps IORING_OP_RECVMSG working from io-wq workers and
the SQPOLL thread.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 io_uring/io_uring.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 61053421d809..001c3683bf00 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -870,6 +870,10 @@ bool io_req_post_cqe(struct io_kiocb *req, s32 res, u32 cflags)
 	lockdep_assert(!io_wq_current_is_worker());
 	lockdep_assert_held(&ctx->uring_lock);
 
+	/* Descriptors this CQE reports must be installed before it is visible. */
+	if (unlikely(current->fd_slots.nr))
+		__fd_slots_commit(res);
+
 	if (!(ctx->int_flags & IO_RING_F_LOCKLESS_CQ)) {
 		spin_lock(&ctx->completion_lock);
 		posted = io_fill_cqe_aux(ctx, req->cqe.user_data, res, cflags);
@@ -895,6 +899,8 @@ bool io_req_post_cqe32(struct io_kiocb *req, struct io_uring_cqe cqe[2])
 	lockdep_assert_held(&ctx->uring_lock);
 
 	cqe[0].user_data = req->cqe.user_data;
+	if (unlikely(current->fd_slots.nr))
+		__fd_slots_commit(cqe[0].res);
 	if (!(ctx->int_flags & IO_RING_F_LOCKLESS_CQ)) {
 		spin_lock(&ctx->completion_lock);
 		posted = io_fill_cqe_aux32(ctx, cqe);
@@ -1365,6 +1371,24 @@ static bool io_assign_file(struct io_kiocb *req, const struct io_issue_def *def,
 
 #define REQ_ISSUE_SLOW_FLAGS	(REQ_F_CREDS | REQ_F_ARM_LTIMEOUT)
 
+/*
+ * Requests complete from io_uring_enter(), task_work, io-wq workers and the
+ * SQPOLL thread, and their CQEs are visible before any syscall returns. So
+ * the descriptors a request reserved are committed per request, before its
+ * completion is posted.
+ */
+static void io_req_fd_reservations(struct io_kiocb *req, int ret)
+{
+	long res = ret;
+
+	/* A request holding reservations must not go async or be reissued. */
+	WARN_ON_ONCE(ret == IOU_ISSUE_SKIP_COMPLETE || ret == IOU_RETRY ||
+		     ret == IOU_REQUEUE);
+	if (ret == IOU_COMPLETE)
+		res = req->cqe.res;
+	__fd_slots_commit(res);
+}
+
 static inline int __io_issue_sqe(struct io_kiocb *req,
 				 unsigned int issue_flags,
 				 const struct io_issue_def *def)
@@ -1385,6 +1409,9 @@ static inline int __io_issue_sqe(struct io_kiocb *req,
 
 	ret = def->issue(req, issue_flags);
 
+	if (unlikely(current->fd_slots.nr))
+		io_req_fd_reservations(req, ret);
+
 	if (!def->audit_skip)
 		audit_uring_exit(!ret, ret);
 

-- 
2.53.0


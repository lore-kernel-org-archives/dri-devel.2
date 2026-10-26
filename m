Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70DE606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XOwOZ94p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C54C10F03C;
	Mon, 26 Oct 2026 16:41:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01DE210F03A
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 16:41:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3FF2D6021D;
 Mon, 26 Oct 2026 16:41:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793032873;
 b=AZ6pj6yzqPZoYlCabPtgMuR9hHq8PVrrRP92PKNnWeh/0CddjAPeNiOGAtuhAnj9B8ji
 lQ2fXoL9Gft/VQYnVqfUdUMzUWZ/Du/+74KIi1Io92ThGRB3cDPXYuaNv//QXJ2riXt9T
 svLl9Kwc5XzBhUCDUhY7vpYG9okR5kdl/BgQ9DkkWRqrY9r2Opn6m59NEZyG0zTbScv3B
 wLPzhgh7nBu0DEt9GROOdeleWrCeVx3eDKTSRg1YXgMtwVVDEOgLCYnHonxejp90wrl5Y
 0Q1mfHqhaQit12ul1T0B6HRmnBLMzu0YpDmTfyoqZqN/U1mrycPx8IDY0VEh1hIzOfQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032873;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=jKnS8OcReTjLaHrdFjGjVJmk8r0TI5DsvNMEnm3UFOw=;
 b=rX57m7GBS7qVBoCMdc9XBAzgD7N5njDC8mOjVom54xJq8yfNYqBzBARQVStc8uf9iwgX
 S8JFsQTwewV016V7hD2LBlCa49z7umpPyUzRSE0rvg1ZLOHSimm088E7VLKWYaabHv711
 hAynFHqmYs4QNsQ7koljC1ayyhV27DicgX5RhWoylgO7k+SAz/n/g5sMcatFxaLEISnRD
 9NhqzmfssCFFxRx+qp42jrnJ7s8SA6ofF6ptqhQsNzALC/DAmmSKdeC2nI/R9N5o5HOmt
 cp/w7DnKs4rzwsY4GWxkaBlJcSuuLJw+BIVH2/iXkHf5mbw2jxF5v+feHhEV6BqTrCg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id CF5E81F01828;
 Mon, 26 Oct 2026 16:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793032873;
 bh=jKnS8OcReTjLaHrdFjGjVJmk8r0TI5DsvNMEnm3UFOw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=XOwOZ94p3hqqwbbEMBwsKIVaRn6u10aeoRkV2zsg7+SGVaOFaR6/Sigj8nlY8+dTm
 J9WX3Q/Ex4m5Ud5/8mu1gVnijfwj3Rh5bsM2kEcEIqurJ9rMn2MRVJXvb2tKD74H48
 rInzElIcGgqxdcZvD2rUbS1HqR/0AzKTKsnzmKdrJbb5qJ2b2QxtRwfbgpESjphO9p
 sI66sYhobgHpUR8uiK9K0petqWVJ+hf8xuxTN3wrr8ZV/pEiP4VhBREAM4d7JbBq4v
 bTavMsrlmiuu4KLe9UPFV9MCQWWjjvOhvWCKVVJD07sz4vqjXk7s7LQuxoCR8J670Z
 C/BDaiWb0TbvA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 5709D44DC9;
 Mon, 26 Oct 2026 16:41:12 +0000 (UTC)
From: Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org>
Date: Tue, 27 Oct 2026 00:40:55 +0800
Subject: [PATCH v5 02/11] rust: task: add task_size()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-tyr-ioctls-v5-2-59dfe98cb003@kylinos.cn>
References: <20261027-tyr-ioctls-v5-0-59dfe98cb003@kylinos.cn>
In-Reply-To: <20261027-tyr-ioctls-v5-0-59dfe98cb003@kylinos.cn>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev, 
 Ke Sun <sunke@kylinos.cn>, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793032870; l=2517;
 i=sunke@kylinos.cn; s=20260317; h=from:subject:message-id;
 bh=SVTHAw+MuGYh/fZMg5wDC3wPSM8rseGtAWNOgWBu2T4=;
 b=3nn7okpFbPdhHXxttuKyB0Km40JaGCKzmRceOClh+jDnb/88sWg7q6AXsMGBUBq+egZW8SeTn
 vMs/n+Fsgf4DiI1Vrs2EHX6dcZqnmz/+dqb6s6hSPM76dX8spYsRdoS
X-Developer-Key: i=sunke@kylinos.cn; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for sunke@kylinos.cn/20260317 with auth_id=950
X-Original-From: Ke Sun <sunke@kylinos.cn>
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
Reply-To: sunke@kylinos.cn
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sami Tolvanen <samitolvanen@google.com>

A DRM driver that lets userspace pick GPU virtual addresses needs the
address space size of the calling task, so it can offer a GPU range
that the CPU can map at the same addresses. TASK_SIZE_OF() is a macro,
so reading it from Rust needs a helper.

Add CurrentTask::task_size(). It is bound to the current task because
TASK_SIZE_OF() falls back to TASK_SIZE on architectures that do not
define it, and TASK_SIZE describes current.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
[ Add the <linux/mm.h> include, needed where TASK_SIZE is defined in
  <asm/pgtable.h> (e.g. riscv). - Alvin ]
Co-developed-by: Alvin Sun <alvin.sun@linux.dev>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/helpers/task.c |  6 ++++++
 rust/kernel/task.rs | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/rust/helpers/task.c b/rust/helpers/task.c
index b46b1433a67e8..b49bd40027154 100644
--- a/rust/helpers/task.c
+++ b/rust/helpers/task.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/kernel.h>
+#include <linux/mm.h>
 #include <linux/sched/task.h>
 
 __rust_helper void rust_helper_might_resched(void)
@@ -13,6 +14,11 @@ __rust_helper struct task_struct *rust_helper_get_current(void)
 	return current;
 }
 
+__rust_helper unsigned long rust_helper_current_task_size(void)
+{
+	return TASK_SIZE_OF(current);
+}
+
 __rust_helper void rust_helper_get_task_struct(struct task_struct *t)
 {
 	get_task_struct(t);
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index eaa0031416a98..e60a0f0727889 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -314,6 +314,18 @@ pub fn mm(&self) -> Option<&MmWithUser> {
         Some(unsafe { MmWithUser::from_raw(mm) })
     }
 
+    /// Returns the size of the userspace address space of the current task.
+    ///
+    /// This is the first address above the userspace range, so it is smaller
+    /// for a task running in compat mode than for a native one. See
+    /// `TASK_SIZE_OF()` in [`include/linux/sched.h`](srctree/include/linux/sched.h).
+    #[doc(alias = "TASK_SIZE_OF")]
+    #[inline]
+    pub fn task_size(&self) -> usize {
+        // SAFETY: FFI call without preconditions, valid in any context.
+        unsafe { bindings::current_task_size() as usize }
+    }
+
     /// Access the pid namespace of the current task.
     ///
     /// This function does not touch the refcount of the namespace or use RCU protection.

-- 
2.43.0



Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20403606A323
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vn5LzQXz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 065D910E1C5;
	Mon,  9 Nov 2026 00:37:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D314910E1BD
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 00:37:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B490343CD4;
 Mon,  9 Nov 2026 00:37:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794184623;
 b=AnvmFPwl2ZYhkE1Z7dt8bWWXpkIwD0acPlM5eTvdwgE4Tu7w/YLDrecg9J4httdZcbXy
 gE0NlBGmtkWSa1nraJZdSBhm3EYCd/ZLlF+DWRKrsDMeZC130OPwSAlY7AQA5Mzg7jDmG
 B+kFZZEvDkPijQE55GyrWgrh9LA2GHdlbk7JMNNgMaEbp7nykvxb1lQ5uF5nucmyGvvt/
 Plnen5vggplxQAF2qgiZDUQ5QUnbmm/6wMEsY2SWJ5K/He5rGAwJvEAJ2LemnqERJvN1b
 oX1Kl2w8Kr8VlBF42A3V8C/K1XSd3jE4tTMJHRtiQemibasPJ56hMV0JxYyFlFNEduQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794184623;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=F3F/5DJsUYhqEjGjiDZ8FHYCTJv5xhZDMG4cisCHJuY=;
 b=RZijGw2ZDry43uKiipa7Q3oGps0KacQf1jZ2aguKL4RorBxPgQ0OEhOx7IXlPMO/zJ/V
 nkzyfBAMBS39Kaks8eetkLskZyhoRLk1x+lmrsC5GkEVMmTkLeIOyc0kufvug2DFWDHfZ
 XEaoYtmkPkx0T0H6Rov6H1lVBBmyZt3OtPVHNgcOjiEQwbDBU0PI8ilRI0IweY/EMpoiU
 gyz7XwemAS7FCRLr3jEE88zp6T0l8qM7cUJqev/hcTNQZ2kiQPx0oB96iJjreE1z3Js8E
 NFSA+zPngXYs0pQycAiDLGO+ctTnEz4ojclHgtVeNmVys5QtnGfQHGZEut4cCE9j5Fg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 9F2961F0089F;
 Mon,  9 Nov 2026 00:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794184623;
 bh=F3F/5DJsUYhqEjGjiDZ8FHYCTJv5xhZDMG4cisCHJuY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Vn5LzQXzt9RZYCjunV9eN8vgbJ8Bt5XGxOg9ZBPPNpgH9uaqR8sQF2PX8S/L49wWn
 LbjQK3xEFk/TDZyB/CaX5HiGY3Ai0VtDxZ/BXMHTjV6uFUgfucpbgXDJl2kypwKzT/
 L+rjCTP18+DWDK29EODJYSarlL1/gd0mmAb/+YvJdcVj0Iqg5r6CLs6JPPff2zd+51
 rq46x70In9bVS2I/qkuB3BsaFzurLHssqq2vp014Q98N56a6fnCQedL4JfLiYiuC7x
 7wBJtAri5/Vm6XUoPQJEYSaBVfV2oHV8nQ255r/lRxkrdPbY5AcY28YRKHvSO8m6ss
 LnJbDlxDllIPw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 22ACE481A9;
 Mon,  9 Nov 2026 00:37:02 +0000 (UTC)
From: Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org>
Date: Mon, 09 Nov 2026 08:36:45 +0800
Subject: [PATCH v6 02/10] rust: task: add task_size()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-tyr-ioctls-v6-2-b2896bf2b3c9@kylinos.cn>
References: <20261109-tyr-ioctls-v6-0-b2896bf2b3c9@kylinos.cn>
In-Reply-To: <20261109-tyr-ioctls-v6-0-b2896bf2b3c9@kylinos.cn>
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
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev, 
 Ke Sun <sunke@kylinos.cn>, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184620; l=2517;
 i=sunke@kylinos.cn; s=20260317; h=from:subject:message-id;
 bh=ltCybRExPQSKXsCnz8UljjoTEH8sGi6OL1QQ7zSPhcQ=;
 b=YtpA5HJWz3k3wKZmCwxpyuSt0g5cLhED5kJLICPXz2cUfwBb0+M9fLN0gDPJ/QrQb/thsHul5
 WmWlK/l3bJeDNuNL7MOY5VdlcqfaVKukmKoTzv5ijJLSOGXAht1KPRc
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index a733816fd5dd4..1978f54fe5897 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -317,6 +317,18 @@ pub fn mm(&self) -> Option<&MmWithUser> {
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



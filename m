Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B20606A319
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbDSA3Xw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 351FE10E337;
	Mon, 19 Oct 2026 21:26:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E441E10E1E3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:25:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 97E75407E1;
 Mon, 19 Oct 2026 21:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78451F000CA;
 Mon, 19 Oct 2026 21:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792445153;
 bh=3EPJ65XgNPrOG7sAkVJwG+uP63GkCytZ6lRPFSywc0c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AbDSA3XwHn3PwpuK4S75JFEOxAdMEcm5jLpvhx8W8zrsBUxc0b0kZypz03jIVC4dD
 tLVluYSwv52MmaAllHnEdgUCPwmnLXRAa0HOYFA3HMEpar+BwtswaCoiulv9mPszTO
 WKMk9MGc34Qxid/68CSBgL9apQKI6QIvKSbwkTU/3qElUwyZFSygZ79r2BAVMipRCa
 O4RponAGi5JRuebDU9KtqKFupnVsBKGVSjlYPiqRzo+JMo8MCFjD3OabiamMuusfH0
 yoqldsdH6PxzLV5+LA/mPa0NglRo9+jkaSongvpMgLuHAN/a5ZyK6G44b08fWq/swE
 iti999qyfvZKA==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, daniel.almeida@collabora.com, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev, jhubbard@nvidia.com,
 apopple@nvidia.com, ecourtney@nvidia.com, lyude@redhat.com,
 kherbst@redhat.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH 2/3] rust: add kernel taint abstraction
Date: Mon, 19 Oct 2026 23:24:46 +0200
Message-ID: <20261019212535.88390-3-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019212535.88390-1-dakr@kernel.org>
References: <20261019212535.88390-1-dakr@kernel.org>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allow Rust code to taint the kernel to record conditions that may be
relevant when diagnosing subsequent kernel failures.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  1 +
 rust/kernel/panic.rs            | 50 +++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 rust/kernel/panic.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 930e63290cdd..bc248918c99b 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -74,6 +74,7 @@
 #include <linux/mm.h>
 #include <linux/miscdevice.h>
 #include <linux/of_device.h>
+#include <linux/panic.h>
 #include <linux/pci.h>
 #include <linux/phy.h>
 #include <linux/pid_namespace.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index f9ef36217bb5..fd8fe9373401 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -112,6 +112,7 @@
 #[cfg(CONFIG_PM_OPP)]
 pub mod opp;
 pub mod page;
+pub mod panic;
 #[cfg(CONFIG_PCI)]
 pub mod pci;
 pub mod pid_namespace;
diff --git a/rust/kernel/panic.rs b/rust/kernel/panic.rs
new file mode 100644
index 000000000000..8a78591dfb8a
--- /dev/null
+++ b/rust/kernel/panic.rs
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Kernel taint tracking.
+//!
+//! C header: [`include/linux/panic.h`](srctree/include/linux/panic.h)
+//!
+//! See the [tainted-kernels documentation] for the meaning of each taint.
+//!
+//! [tainted-kernels documentation]: srctree/Documentation/admin-guide/tainted-kernels.rst
+
+/// A reason for tainting the kernel.
+#[derive(Clone, Copy, Debug, Eq, PartialEq)]
+#[repr(u32)]
+pub enum Taint {
+    /// Tainting was explicitly requested by the user.
+    User = bindings::TAINT_USER,
+}
+
+impl Taint {
+    #[inline]
+    const fn as_raw(self) -> u32 {
+        self as u32
+    }
+}
+
+/// Whether lock debugging remains reliable after a tainting event.
+#[derive(Clone, Copy, Debug, Eq, PartialEq)]
+#[repr(u32)]
+pub enum Lockdep {
+    /// Keep lock debugging enabled.
+    StillOk = bindings::lockdep_ok_LOCKDEP_STILL_OK,
+}
+
+impl Lockdep {
+    #[inline]
+    const fn as_raw(self) -> bindings::lockdep_ok {
+        self as u32
+    }
+}
+
+/// Adds a kernel taint flag.
+///
+/// Taint flags persist until reboot, even if the module that set them is unloaded.
+/// Use [`Lockdep::StillOk`] when the tainting event does not compromise lock debugging.
+/// This may panic if the kernel's `panic_on_taint` setting matches a set taint flag.
+#[inline]
+pub fn add_taint(flag: Taint, lockdep: Lockdep) {
+    // SAFETY: `Taint` and `Lockdep` restrict both arguments to valid C API values.
+    unsafe { bindings::add_taint(flag.as_raw(), lockdep.as_raw()) };
+}
-- 
2.56.0


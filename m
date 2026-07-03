Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80ACDC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBDF610F6A0;
	Fri,  3 Jul 2026 07:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Us+fRwVn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C538010F6A0
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 07:32:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4825E6001A;
 Fri,  3 Jul 2026 07:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CE11F00A3A;
 Fri,  3 Jul 2026 07:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783063938;
 bh=1zoIAZtdXOviXMtnoJ37cYn19oGrY7Vb57AI0Lnpx5s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Us+fRwVn+sSB0I9T5c05P0bkcpFrtgiBb8eXoRKEY5KXCdBCp01+FB+mn9SWA44fR
 dLCAn6wbvXF0K7KR4IEdh2rhm6Vgg04RnmLRECxznWQf40BV5dFuoZHPjMml4TBIjO
 ObTEoG8hvDSGnnBK8jXXoPKE6CXuWFnfprCF+kOriQHi3dGzBZzcKA/PqwzCeT6Egk
 cSjQA/1qyQGe4ACpdhzvmBqPc2Ox14Hp5nA56uErYGEua9brLBHOBK5D5gsSA5+rIM
 +prf2rnq+LsGNvVJzSoj0zocq65PJtyzMWeqUyP/dnjTPXycg6BrLdGYRqzFCbbwA/
 W/zkEgTP/mpLQ==
From: Philipp Stanner <phasta@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Asahi Lina <lina+kernel@asahilina.net>, Burak Emir <bqe@google.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>,
 Tamir Duberstein <tamird@kernel.org>, Mirko Adzic <adzicmirko97@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Shankari Anand <shankari.ak0208@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH v5 3/5] rust: sync: Add abstraction for rcu_barrier()
Date: Fri,  3 Jul 2026 09:31:39 +0200
Message-ID: <20260703073141.3962604-5-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703073141.3962604-2-phasta@kernel.org>
References: <20260703073141.3962604-2-phasta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

rcu_barrier() is a frequently used C function which is always safe to be
called.

Add a safe abstraction for rcu_barrier().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/sync/rcu.rs | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
index a32bef6e490b..7031ca5d2473 100644
--- a/rust/kernel/sync/rcu.rs
+++ b/rust/kernel/sync/rcu.rs
@@ -50,3 +50,23 @@ fn drop(&mut self) {
 pub fn read_lock() -> Guard {
     Guard::new()
 }
+
+/// Wait until all in-flight call_rcu() callbacks complete.
+///
+/// Note that this primitive does not necessarily wait for an RCU grace period
+/// to complete.  For example, if there are no RCU callbacks queued anywhere
+/// in the system, then rcu_barrier() is within its rights to return
+/// immediately, without waiting for anything, much less an RCU grace period.
+/// In fact, rcu_barrier() will normally not result in any RCU grace periods
+/// beyond those that were already destined to be executed.
+///
+/// In kernels built with CONFIG_RCU_LAZY=y, this function also hurries all
+/// pending lazy RCU callbacks.
+///
+/// Note that this is one of the RCU primitives which must not be called in
+/// atomic context.
+#[inline]
+pub fn rcu_barrier() {
+    // SAFETY: `rcu_barrier()` is always safe to be called. It just might wait for a grace period.
+    unsafe { bindings::rcu_barrier() };
+}
-- 
2.54.0


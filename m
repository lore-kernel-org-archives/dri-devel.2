Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA670CD98C5
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 00:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0171A10E57E;
	Thu, 11 Jun 2026 00:04:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="QkchJo/i";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEC7810E57E
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 00:04:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781136275; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hPqJDgC0pfM4wqY9wmjTC6HoTbkgO+Wq3ZWfvjIUyUhhCHJfMMVlDhN6eNxgoQcNisnER8/n4ldZOb1KX+tWw9FoPzukoZ3qpIxOTnxK+ZlNhMJGerzKzAlWHkjicyNAnrHENfpMk8RcS7eVlIekUlWbdLiOVyxpMp2jEoM0uw4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781136275;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=08qklnwrYy3ybfK0Fq9VgJW7y6VO7BnPIkyUQ1yUUXc=; 
 b=OhLmMo947erInw/VjdnGRXCj37bKbi9SyTY3pUHF7vHUDGK75wU7NPEWgBDU9UolIX/hZOO7F+XeOfqPuejtSvap9oaKzzTapcc50ovGM1BeBV7j1a6R7+GMKCzzQevqBh29ykdF7xcE4/4HIToGvhUBRrqmFG68l6mgtr1zizA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781136274; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=08qklnwrYy3ybfK0Fq9VgJW7y6VO7BnPIkyUQ1yUUXc=;
 b=QkchJo/iF9jsHcMoYIHuvDf+RYMygrK2jqhXvyYaw8YIgyOSE6Vv9VEq3S6XRFuc
 dY+mWLO+3fzaR61gDu1vOfWd2XmWxrwt0CgQj+4560/0dA2ziCiFtdZQn8lOHbzwVMF
 o4CdRbaGKddjb6MYm7G7XLv5CKNkemzFwDhHoDaA=
Received: by mx.zohomail.com with SMTPS id 1781136272832700.1664977279125;
 Wed, 10 Jun 2026 17:04:32 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Wed, 10 Jun 2026 17:04:31 -0700
Subject: [PATCH] rust: drm: gpuvm: add SmContext lifetime bound
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-gpuvm_smcontext_lifetime_bound_v1-v1-1-531e7d2ee7b4@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3N0QqEIBBA0V+JeU4YhY3qVyKk1bEdWDXUJIj+f
 WUfz8u9N2RKTBnm7oZElTPH0CD7DsxnCzsJts2gUA04SBT7cVavszcxFLqK/rKjwp70O57B6iq
 FG9Vk8GVHNBO0zpHI8fV/LOvz/ABK1ZvvcwAAAA==
X-Change-ID: 20260610-gpuvm_smcontext_lifetime_bound_v1-f829c05d80c9
To: Danilo Krummrich <dakr@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, laura.nao@collabora.com, 
 samitolvanen@google.com, boris.brezillon@collabora.com, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2343;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=jHJAQB/EOHX4fGMtGmvkXai9pbOgWNCI48HlzZompPU=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFmavyds/HHif3pBa8W7Bc4/Qh9yH1bcdCjgg4nFB+bVu
 Rsvimk/7ihlYRDjYpAVU2Q5a2/UI1713kh3/v9mmDmsTCBDGLg4BWAiv0UYGb7kyJUeuV4d/K02
 L/jA1v6MaW3i0heMj+TOa7X1e3JtrSkjw1nhiEar5ic7iu89LP47P2rexbN1T7nad5bpfpp+jzG
 ElxMA
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

From: Boris Brezillon <boris.brezillon@collabora.com>

If a DriverGpuVm implementation is lifetime-parameterized, its
SmContext<'ctx> type may depend on lifetimes carried by that driver
implementation. In this case, SmContext<'ctx> is only valid if the
driver implementation outlives 'ctx.

Add a Self: 'ctx bound to DriverGpuVm::SmContext<'ctx> to express that
requirement. Then propagate the corresponding T: 'ctx bound to the GPUVM
state machine helper types that store T::SmContext<'ctx>.

This allows drivers to provide lifetime-parameterized implementations of
DriverGpuVm.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 rust/kernel/drm/gpuvm/mod.rs    | 4 +++-
 rust/kernel/drm/gpuvm/sm_ops.rs | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/gpuvm/mod.rs b/rust/kernel/drm/gpuvm/mod.rs
index ae58f6f667c1..1ec649fa50ea 100644
--- a/rust/kernel/drm/gpuvm/mod.rs
+++ b/rust/kernel/drm/gpuvm/mod.rs
@@ -264,7 +264,9 @@ pub trait DriverGpuVm: Sized + Send {
     type VmBoData;
 
     /// The private data passed to callbacks.
-    type SmContext<'ctx>;
+    type SmContext<'ctx>
+    where
+        Self: 'ctx;
 
     /// Indicates that a new mapping should be created.
     fn sm_step_map<'op, 'ctx>(
diff --git a/rust/kernel/drm/gpuvm/sm_ops.rs b/rust/kernel/drm/gpuvm/sm_ops.rs
index 69a8e5ab2821..742c151b2540 100644
--- a/rust/kernel/drm/gpuvm/sm_ops.rs
+++ b/rust/kernel/drm/gpuvm/sm_ops.rs
@@ -3,7 +3,7 @@
 use super::*;
 
 /// The actual data that gets threaded through the callbacks.
-struct SmData<'a, 'ctx, T: DriverGpuVm> {
+struct SmData<'a, 'ctx, T: DriverGpuVm + 'ctx> {
     gpuvm: &'a mut UniqueRefGpuVm<T>,
     user_context: &'a mut T::SmContext<'ctx>,
 }
@@ -20,7 +20,7 @@ struct SmMapData<'a, 'ctx, T: DriverGpuVm> {
 }
 
 /// The argument for [`UniqueRefGpuVm::sm_map`].
-pub struct OpMapRequest<'a, 'ctx, T: DriverGpuVm> {
+pub struct OpMapRequest<'a, 'ctx, T: DriverGpuVm + 'ctx> {
     /// Address in GPU virtual address space.
     pub addr: u64,
     /// Length of mapping to create.

---
base-commit: 550dc7536644db2d67c6f8cf525bba682fba08d9
change-id: 20260610-gpuvm_smcontext_lifetime_bound_v1-f829c05d80c9

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>


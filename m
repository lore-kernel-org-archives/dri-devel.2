Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32FE1099B5F
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74B6D10E9F6;
	Thu, 26 Mar 2026 06:56:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="muupA6xp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 111C910E9FA
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 06:55:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4367C60138;
 Thu, 26 Mar 2026 06:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAB90C19423;
 Thu, 26 Mar 2026 06:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
 t=1774508152; bh=cVzToFCe33VrJM/WwjDX3rjnBkbQL/Y1ZuE5gIYqw6c=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=muupA6xpwmVSbpL3UZDzPtHpwOPY0ijfu/iexw+KjRshXbahF40VZ7O+IaiavN3AS
 EV2zr/xJr86FVaOpAVf7M0lfS8eu/KUEC0Sm/KZgm/80/3LNs4Ct3QpkhBN5LaclQT
 2fkKLvRqs5H2CQN9MoV9GO3EH0B35undDg79b/Vs=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id CFCDF109E55C;
 Thu, 26 Mar 2026 06:55:52 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 26 Mar 2026 14:52:59 +0800
Subject: [PATCH 06/13] rust: revocable: make LazyRevocable use HazPtrRevocable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-b4-tyr-debugfs-v1-6-074badd18716@linux.dev>
References: <20260326-b4-tyr-debugfs-v1-0-074badd18716@linux.dev>
In-Reply-To: <20260326-b4-tyr-debugfs-v1-0-074badd18716@linux.dev>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774508149; l=2008;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=cVzToFCe33VrJM/WwjDX3rjnBkbQL/Y1ZuE5gIYqw6c=;
 b=XUnWhjubL8fAm1EhdhBfzPB0BgpmYzDqVT9Ggv0zPFi67X/+spX3TYsl45ghINL+qxdYwIqhB
 J7TcDDtcpAHBfguI4PE+LMu2O+n0DYVVZgq5ndgkAA7SYS/+cW9Q9Q8
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684
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

Change LazyRevocable to use the existing HazPtrRevocable backend instead
of the RCU-based Revocable. init() now returns HazPtrRevokeHandle and
try_access(ctx) forwards to the hazptr-based implementation.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/revocable.rs | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
index eabb76ce92c43..e974c75a90ec0 100644
--- a/rust/kernel/revocable.rs
+++ b/rust/kernel/revocable.rs
@@ -421,7 +421,7 @@ fn deref(&self) -> &Self::Target {
 #[pin_data]
 pub struct LazyRevocable<T> {
     #[pin]
-    once: SetOnce<Revocable<T>>,
+    once: SetOnce<HazPtrRevocable<T>>,
 }
 
 impl<T> LazyRevocable<T> {
@@ -440,18 +440,22 @@ pub const fn new() -> Self {
     pub fn init<E: Into<Error>>(
         self: Pin<&Self>,
         init: impl PinInit<T, E>,
-    ) -> Result<RevokeHandle<'_, T>> {
+    ) -> Result<HazPtrRevokeHandle<'_, T>> {
         // SAFETY: `once` is structurally pinned.
         let once = unsafe { self.map_unchecked(|x| &x.once) };
-        let revocable = once.pin_init(Revocable::new(init))?;
-        Ok(RevokeHandle::new(revocable))
+        let revocable = once.pin_init(HazPtrRevocable::new(init))?;
+        Ok(HazPtrRevokeHandle::new(revocable))
     }
 
     /// Tries to access the revocable wrapped object.
     ///
-    /// Returns `None` if the object has not been initialized, or it has been revoked and is therefore no longer accessible.
-    pub fn try_access(&self) -> Option<RevocableGuard<'_, T>> {
-        self.once.as_ref()?.try_access()
+    /// Returns `None` if the object has not been initialized, or it has been revoked and is
+    /// therefore no longer accessible.
+    pub fn try_access<'a>(
+        &self,
+        ctx: Pin<&'a mut HazptrCtx>,
+    ) -> Option<HazPtrRevocableGuard<'a, T>> {
+        self.once.as_ref()?.try_access(ctx)
     }
 }
 

-- 
2.43.0



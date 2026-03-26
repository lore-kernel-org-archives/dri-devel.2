Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A132109E55D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ED4710E9FC;
	Thu, 26 Mar 2026 06:56:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="AgTOddqb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FEF010E9F5
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 06:55:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DAC694457A;
 Thu, 26 Mar 2026 06:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB172C2BCB8;
 Thu, 26 Mar 2026 06:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
 t=1774508152; bh=tUYRpEsjcJwgFiDLyfqu8+WsQSC+51o7zeiWV2WwdXg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=AgTOddqbBydf5h4/gS+J512wveQMIqtr99jPcBcey8NSL2ftuhTpfMiOZ5604ibZE
 IruIZbVz87zKSLRl190HMW8ehDDJlK3hcTeI3jU9DIEj404i5XD+4My9YNlPgPcdGs
 cgIpO9X+USOcgZF+ft/sFVCEi6lqBy64rCaQPCp8=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC67103A9A0;
 Thu, 26 Mar 2026 06:55:52 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 26 Mar 2026 14:52:56 +0800
Subject: [PATCH 03/13] rust: sync: set_once: Rename InitError variants to
 fix clippy warning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-b4-tyr-debugfs-v1-3-074badd18716@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774508149; l=1849;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=tUYRpEsjcJwgFiDLyfqu8+WsQSC+51o7zeiWV2WwdXg=;
 b=LejMass/PgiXRGEVCIMUZhQoqRvFp8dZ+rFdyHpwf6Fsnq4qYQsRzZHZilPaqI0LL/f9CBaJ0
 H+g0I5DQj3MAWlxgNapRhv0mnILfZyGSs/JRHNM6EezDqVAUdxlF/lC
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

Fixes clippy warning:
warning: all variants have the same postfix: `Init`
  --> rust/kernel/sync/set_once.rs:68:1

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/sync/set_once.rs | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/sync/set_once.rs b/rust/kernel/sync/set_once.rs
index db9c5423fade3..3af5538aae1d4 100644
--- a/rust/kernel/sync/set_once.rs
+++ b/rust/kernel/sync/set_once.rs
@@ -67,17 +67,17 @@ fn default() -> Self {
 #[derive(Debug)]
 pub enum InitError<E> {
     /// The `Once` has already been initialized.
-    AlreadyInit,
+    Already,
     /// The `Once` is being raced to initialize by another thread.
-    RacedInit,
+    Raced,
     /// Error occurs during initialization.
-    DuringInit(E),
+    Inner(E),
 }
 
 impl<E> From<E> for InitError<E> {
     #[inline]
     fn from(err: E) -> Self {
-        InitError::DuringInit(err)
+        InitError::Inner(err)
     }
 }
 
@@ -85,9 +85,9 @@ impl<E: Into<Error>> From<InitError<E>> for Error {
     #[inline]
     fn from(this: InitError<E>) -> Self {
         match this {
-            InitError::AlreadyInit => EEXIST,
-            InitError::RacedInit => EBUSY,
-            InitError::DuringInit(e) => e.into(),
+            InitError::Already => EEXIST,
+            InitError::Raced => EBUSY,
+            InitError::Inner(e) => e.into(),
         }
     }
 }
@@ -155,8 +155,8 @@ pub fn init<E>(&self, init: impl Init<T, E>) -> Result<&T, InitError<E>> {
                     }
                 }
             }
-            Err(1) => Err(InitError::RacedInit),
-            Err(_) => Err(InitError::AlreadyInit),
+            Err(1) => Err(InitError::Raced),
+            Err(_) => Err(InitError::Already),
         }
     }
 

-- 
2.43.0



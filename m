Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B57CD4F58
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 06:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 354AE10EA99;
	Tue, 19 May 2026 06:26:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="pqFk2zvo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F28D010EA89
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:26:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DDBAA445E9;
 Tue, 19 May 2026 06:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66C95C4AF48;
 Tue, 19 May 2026 06:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
 t=1779171977; bh=w1EoH2KiN5QmfxawPU8PJaSlqVT8J3DiMsT2xzxxCS8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=pqFk2zvot/fGkAa2B95CruvT+F/m81RwHSe5EFDIyzYIQvyOEqVbEJlOVZidiGESB
 vzU6SsE1rDpeMtDRYXXBQYMDkHBWWc3PxtyOyf4C3nQLXUx4SOn996Ls4qBm5ECLmw
 z+p7x59zc2QfRifwq1u0QGQTVt1UcL9yY44xKpWQ=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6ACCD4F5E;
 Tue, 19 May 2026 06:26:17 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Tue, 19 May 2026 14:26:19 +0800
Subject: [PATCH 7/8] rust: miscdevice: add `ThisModule` associated type to
 `MiscDevice` trait
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-fops-owner-v1-7-2ded9830da14@linux.dev>
References: <20260519-fix-fops-owner-v1-0-2ded9830da14@linux.dev>
In-Reply-To: <20260519-fix-fops-owner-v1-0-2ded9830da14@linux.dev>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
 Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779171975; l=1248;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=w1EoH2KiN5QmfxawPU8PJaSlqVT8J3DiMsT2xzxxCS8=;
 b=2boe+1XQRLD4hO3skU1aJJQcbDXlgDARy7PBUJ88luhYe/WLmSsDSDrEExQl2YbOWZ2Tl8h0e
 pmNkBMmnQSyAdamOhFMpfzrTeCuM7HWH36VOSdl/5OJbzmR7hEcHgBQ
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

Add a `ThisModule` associated type bound by `ModuleMetadata` to the
`MiscDevice` trait, and use it to set the miscdevice fops owner field
instead of defaulting to null.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/miscdevice.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 05a6b6b9770f2..007caaae62697 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -38,6 +38,7 @@
         ForeignOwnable,
         Opaque, //
     },
+    ModuleMetadata, //
 };
 use core::{
     marker::PhantomData,
@@ -137,6 +138,9 @@ pub trait MiscDevice: Sized {
     /// What kind of pointer should `Self` be wrapped in.
     type Ptr: ForeignOwnable + Send + Sync;
 
+    /// The module implementing this driver.
+    type ThisModule: ModuleMetadata;
+
     /// Called when the misc device is opened.
     ///
     /// The returned pointer will be stored as the private data for the file.
@@ -441,6 +445,7 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         } else {
             None
         },
+        owner: <T::ThisModule as ModuleMetadata>::MODULE_PTR,
         ..pin_init::zeroed()
     };
 

-- 
2.43.0



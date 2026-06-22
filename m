Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE33CD98F0
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 02:45:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 692FF10E439;
	Mon, 22 Jun 2026 02:45:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="ZM4NpmKd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E16B410E435
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 02:45:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CA84644525;
 Mon, 22 Jun 2026 02:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63EB8C4AF12;
 Mon, 22 Jun 2026 02:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
 t=1782096302; bh=aexpDAuFU6mvFkRE4PMFgeTzsZDIZpwH5Q0CvXo0fTs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ZM4NpmKdiTkVv6JZ9rZ9O7mj4YkGbRZlwjU+EVtTamcp3itZr7rPv+74UfEA38TX6
 dBsF3VRdgVR585hilTjHWPKG51r2Hd+2yzhCoDaWye+osvKH9Jir0Tgmbnn3/uA/4y
 UOeE11zANl7E2PaHnKCLbJ4sALHYrSzvJOPx7yVg=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 58372CDB471;
 Mon, 22 Jun 2026 02:45:02 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Mon, 22 Jun 2026 10:45:00 +0800
Subject: [PATCH v3 6/6] rust: configfs: use `LocalModule` for `THIS_MODULE`
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-fix-fops-owner-v3-6-49d45cb37032@linux.dev>
References: <20260622-fix-fops-owner-v3-0-49d45cb37032@linux.dev>
In-Reply-To: <20260622-fix-fops-owner-v3-0-49d45cb37032@linux.dev>
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
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782096299; l=2487;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=aexpDAuFU6mvFkRE4PMFgeTzsZDIZpwH5Q0CvXo0fTs=;
 b=1mv5R7oe2FcSalIxzlKq12ldjlbNMDdqc+3bcdjQ6b25dCBZqGK89H/M1CjNynmGV6elrhMzd
 Nc/ahs/0mGxAIJgEcYsgn9TO2Tt/xWkfUDirPkbU1Io6YA8H61wCKZv
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

Replace the `THIS_MODULE` static reference in the `configfs_attrs!`
macro with `this_module::<LocalModule>()`, and update
rnull to import `LocalModule` instead of `THIS_MODULE`, consistent
with the move of `THIS_MODULE` into the `ModuleMetadata` trait.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 drivers/block/rnull/configfs.rs | 6 ++----
 rust/kernel/configfs.rs         | 8 +++++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/block/rnull/configfs.rs b/drivers/block/rnull/configfs.rs
index c10a55fc58948..b2547ad1e5ddd 100644
--- a/drivers/block/rnull/configfs.rs
+++ b/drivers/block/rnull/configfs.rs
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use super::{
-    NullBlkDevice,
-    THIS_MODULE, //
-};
+use super::NullBlkDevice;
+use crate::LocalModule;
 use kernel::{
     block::mq::gen_disk::{
         GenDisk,
diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 2339c6467325d..8bd32627386e0 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -875,7 +875,7 @@ fn as_ptr(&self) -> *const bindings::config_item_type {
 ///                 configfs::Subsystem<Configuration>,
 ///                 Configuration
 ///                 >::new_with_child_ctor::<N,Child>(
-///             &THIS_MODULE,
+///             ::kernel::this_module::<LocalModule>(),
 ///             &CONFIGURATION_ATTRS
 ///         );
 ///
@@ -1021,7 +1021,8 @@ macro_rules! configfs_attrs {
 
                     static [< $data:upper _TPE >] : $crate::configfs::ItemType<$container, $data>  =
                         $crate::configfs::ItemType::<$container, $data>::new::<N>(
-                            &THIS_MODULE, &[<$ data:upper _ATTRS >]
+                            $crate::this_module::<LocalModule>(),
+                            &[<$ data:upper _ATTRS >]
                         );
                 )?
 
@@ -1030,7 +1031,8 @@ macro_rules! configfs_attrs {
                         $crate::configfs::ItemType<$container, $data>  =
                             $crate::configfs::ItemType::<$container, $data>::
                             new_with_child_ctor::<N, $child>(
-                                &THIS_MODULE, &[<$ data:upper _ATTRS >]
+                                $crate::this_module::<LocalModule>(),
+                                &[<$ data:upper _ATTRS >]
                             );
                 )?
 

-- 
2.43.0



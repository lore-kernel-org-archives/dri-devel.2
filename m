Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92956CD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 06:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E970510EA97;
	Tue, 19 May 2026 06:26:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="P8rM12T0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E34210EA92
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 06:26:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9936644569;
 Tue, 19 May 2026 06:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A978C2BCC6;
 Tue, 19 May 2026 06:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
 t=1779171977; bh=vfc7PEfuAeEjqo+PGe1GnSXUHGllBagvhexmLDwXXe8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=P8rM12T04+ZuBv6GHundGYtIAaOiFQVmUSH7xably5MuOZQ8r7iLOc9QKjSDnaqHj
 ffhhMsqcDAfQUTpMlh75x4ZMxFrqOtbIE6ktVNGwnd8YqYIC9l66CN/lrR07iXbABi
 n7Q3gj5LIToe4RvmN8BIkAX2EuqEmobGxso5P/M8=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 095DCCD4851;
 Tue, 19 May 2026 06:26:17 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Tue, 19 May 2026 14:26:14 +0800
Subject: [PATCH 2/8] rust: driver: make `DriverModule` struct pub(crate) in
 `module_driver!`
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-fix-fops-owner-v1-2-2ded9830da14@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779171975; l=796;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=vfc7PEfuAeEjqo+PGe1GnSXUHGllBagvhexmLDwXXe8=;
 b=iHl0SVhJNpVhuwZ7fh48egK9TuW+0iU+YW7qNL4AsNI9HBq33i2CD/EuLLetzk/gmObncqGZY
 c1YeH3GB4bhDdkz58UDUJs4GIxBetIU7CQNTcDd16LTUVxnj/j/Y7aw
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

Expose the generated `DriverModule` struct as `pub(crate)` so that
driver implementations can reference it via `super::DriverModule`
for the `ThisModule` associated type.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/driver.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 36de8098754d0..9c7c69c4d2af0 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -253,7 +253,7 @@ macro_rules! module_driver {
         type Ops<$gen_type> = $driver_ops;
 
         #[$crate::prelude::pin_data]
-        struct DriverModule {
+        pub(crate) struct DriverModule {
             #[pin]
             _driver: $crate::driver::Registration<Ops<$type>>,
         }

-- 
2.43.0



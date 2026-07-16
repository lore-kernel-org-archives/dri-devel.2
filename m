Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5E3C44516
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:18:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B5110E397;
	Thu, 16 Jul 2026 17:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.b="Z/kDlRFh";
	dkim-atps=neutral
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E70DA10E397;
 Thu, 16 Jul 2026 17:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
 s=mail; t=1784221779;
 bh=dBHoPeFN74z8PL2Y8uyMGTiScXZKXOQLXSJUZCoOZ4k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Z/kDlRFhDRFgYQgSzQoKmtwdpeG1w4EntJToLPpWO31pBQFdwbqjvfcEyOm85ByYY
 kCg+CNUGmed4lMAcg69Wsrl0WUNMP9Zvkva2ooQJOdhW9AVbd+cbVmhggZklVF+V66
 fu/7Cxz71Oje6RypHiqZnGnxw6whBn6dRpXX2Sj8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 16 Jul 2026 19:09:26 +0200
Subject: [PATCH 1/6] rust: configfs: remove mutability from some field
 initializers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260716-configfs-const-base-v1-1-c545a4053cb5@weissschuh.net>
References: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
In-Reply-To: <20260716-configfs-const-base-v1-0-c545a4053cb5@weissschuh.net>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dan Williams <djbw@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-coco@lists.linux.dev, linux-acpi@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784221778; l=1897;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=dBHoPeFN74z8PL2Y8uyMGTiScXZKXOQLXSJUZCoOZ4k=;
 b=aVZbs/uCZXHVODH1ABH4MgJRQ4jtEG5Zi7lWJCam5sEMkaRjBjYob9SC7itElVohbe8A6rYQA
 yn0fmFmJirVDAxMfzaB4EKaDCo0xfVyJDcuL2BzPBWSP+x+Cf8lizUa
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
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

These fields do not require mutable pointers.

Use regular immutable ones.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 rust/kernel/configfs.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/configfs.rs b/rust/kernel/configfs.rs
index 2339c6467325..b33fb2e9adf1 100644
--- a/rust/kernel/configfs.rs
+++ b/rust/kernel/configfs.rs
@@ -754,8 +754,8 @@ pub const fn new_with_child_ctor<const N: usize, Child>(
                 Self {
                     item_type: Opaque::new(bindings::config_item_type {
                         ct_owner: owner.as_ptr(),
-                        ct_group_ops: GroupOperationsVTable::<Data, Child>::vtable_ptr().cast_mut(),
-                        ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr().cast_mut(),
+                        ct_group_ops: GroupOperationsVTable::<Data, Child>::vtable_ptr(),
+                        ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr(),
                         ct_attrs: core::ptr::from_ref(attributes).cast_mut().cast(),
                         ct_bin_attrs: core::ptr::null_mut(),
                     }),
@@ -771,8 +771,8 @@ pub const fn new<const N: usize>(
                 Self {
                     item_type: Opaque::new(bindings::config_item_type {
                         ct_owner: owner.as_ptr(),
-                        ct_group_ops: core::ptr::null_mut(),
-                        ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr().cast_mut(),
+                        ct_group_ops: core::ptr::null(),
+                        ct_item_ops: ItemOperationsVTable::<$tpe, Data>::vtable_ptr(),
                         ct_attrs: core::ptr::from_ref(attributes).cast_mut().cast(),
                         ct_bin_attrs: core::ptr::null_mut(),
                     }),

-- 
2.55.0


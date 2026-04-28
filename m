Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CF7FF8878
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 19:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CEDC10EB30;
	Tue, 28 Apr 2026 19:20:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="Hjkf5Tvh";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27DB310E364
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 19:19:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777403983; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IbIPdgBkg3eE0bdD/OL77s9hC6ViO2kSQMbPLChOsmql44qnS13K7TU0udpzzeuzkQQSjScgc3FnBVvmPVz5WtVQDAOtFvizZCrsprlcmYHUzOdXKOlQjxYGiJ5CsJxMk5vDFeu3eI1bod2HZ/samTjm0FUEd/Q4iIEW/BKBN0U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777403983;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wLGSvc2M7EuyDUwLLZMuCL0UwqmYT4uqmf47d+D6rF8=; 
 b=drOG1TuZ+G4mbMvSQq1ldHA5tpjx9/ZYDrQOMImoqC47KBQ3mkZQvkzCkPcBnk+BFro1XxkSvMNfjCWMnqvNXjtXyJ6DZb0lAC93ArkY5WJfeWeNQ3f0vPs2j/9hByhMgrxT0FyC+949de8FybE+dOZGSzqum4dVH1fYeNW16Gg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777403983; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=wLGSvc2M7EuyDUwLLZMuCL0UwqmYT4uqmf47d+D6rF8=;
 b=Hjkf5Tvht5izMS2gVQfxNb1zIKFE9ziv4xsqzu0XCFj/dwjWLls85MqK+ZeQNc7G
 Clez9mGeTdCbHQy7TDwhbsqQtyJLCNaeBJ5BqjctzofYISYkPHBae9l89ocP0gCdbgA
 eevQKVkaa3SKfwnWag05oliNJMnSy8MwubOg5Ggo=
Received: by mx.zohomail.com with SMTPS id 1777403981907227.00808545959512;
 Tue, 28 Apr 2026 12:19:41 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Tue, 28 Apr 2026 12:19:32 -0700
Subject: [PATCH 5/5] drm/tyr: add shmem backing for GEM objects
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-fw-boot-prerequisites-v1-5-c69af9abe1af@collabora.com>
References: <20260428-fw-boot-prerequisites-v1-0-c69af9abe1af@collabora.com>
In-Reply-To: <20260428-fw-boot-prerequisites-v1-0-c69af9abe1af@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, work@onurozkan.dev, alvin.sun@linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1796;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=W29CcEg4G/bR/nBkZsGLw9Q//UYR0bu9cBHhR83fmzU=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJkfOdyXPVv4VrSWY6K71LkZhS+KNzRNOdSRG2Ydlv3+L
 9OHG7LZHaUsDGJcDLJiiixn7Y16xKveG+nO/98MM4eVCWQIAxenAEzkgQ7D/yyWi1crpTdW7nxh
 duby5euGFwMDFk2zazvwcK+decUs2TWMDM9CO5xnKk235PEwUNHWU4iYKXqJPf51S8TmhDjt7ZG
 z+QE=
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

Add support for GEM buffer objects backed by shared memory.

This introduces the BoCreateArgs structure for passing creation parameters
including flags, and adds a flags field to BoData.

Co-developed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/gem.rs | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index 66c427a16c31..1640a161754b 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -1,4 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
+//! GEM buffer object management for the Tyr driver.
+//!
+//! This module provides buffer object (BO) management functionality using
+//! DRM's GEM subsystem with shmem backing.
 
 use kernel::{
     drm::gem,
@@ -10,15 +14,23 @@
     TyrDrmDriver, //
 };
 
-/// GEM Object inner driver data
+/// Tyr's DriverObject type for GEM objects.
 #[pin_data]
-pub(crate) struct BoData {}
+pub(crate) struct BoData {
+    flags: u32,
+}
+
+/// Provides a way to pass arguments when creating BoData
+/// as required by the gem::DriverObject trait.
+pub(crate) struct BoCreateArgs {
+    flags: u32,
+}
 
 impl gem::DriverObject for BoData {
     type Driver = TyrDrmDriver;
-    type Args = ();
+    type Args = BoCreateArgs;
 
-    fn new(_dev: &TyrDrmDevice, _size: usize, _args: ()) -> impl PinInit<Self, Error> {
-        try_pin_init!(BoData {})
+    fn new(_dev: &TyrDrmDevice, _size: usize, args: BoCreateArgs) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self { flags: args.flags })
     }
 }

-- 
2.53.0


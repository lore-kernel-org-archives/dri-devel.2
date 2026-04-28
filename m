Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFEFFF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 19:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9BA610E364;
	Tue, 28 Apr 2026 19:19:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="KD8ghX6j";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 109CB10E09B
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 19:19:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777403979; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IhBd5cv2TICv7QKXtl+zRO44E4ZT/031M34auIYkdNQzPP49YB00067q379dbDxg1ntH6dbIl75Z5Xo0m9fEgRL34SUMGvS8P8DJ2uh2+9tsZ9I/L2zZ5LGh6tA6aGeLviJav0DFgn6lZXEwhnp+4i4FWq1Wu/IJBHuZw1PilvA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777403979;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=h4eSSE+crWKJ+xxOqPk2xaRfCGDjT2wgRkoeTYNuCVY=; 
 b=NP02jj/r97BHSyjKcO5M4GhyHT9srCq08zbrHDdy2rBEH/Mu58Wj9uFnGrdVnLcMwhdTNOTq/rwiFpAz/wE2qNUV+PRSJzA1aDKc815S0fTWAw1NfCOjspBlQXQhmIlY3ix6pn89qJU4tho5dK8dgJTxMsqIf6GpdCcLFiFQhnk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777403979; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=h4eSSE+crWKJ+xxOqPk2xaRfCGDjT2wgRkoeTYNuCVY=;
 b=KD8ghX6jfTAxq1OiRpjLTCpbMfx+qqjpO4sZ6/Xz1jAlOyVNIeIgPYbXYkzOZ1jm
 Q4EGEU1Y0IliDEmzs+1xtm06zSYbPF6vBKWv3WeXGNnTuu2rvHXSTqbQ0ll5y1kCufB
 rD4JLy8KsMMn7FP3kWbYqKo3MNZ4VjRXvyUqM934=
Received: by mx.zohomail.com with SMTPS id 1777403977599511.38951537089713;
 Tue, 28 Apr 2026 12:19:37 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Tue, 28 Apr 2026 12:19:28 -0700
Subject: [PATCH 1/5] drm/tyr: move clock cleanup into Clocks Drop impl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-fw-boot-prerequisites-v1-1-c69af9abe1af@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2613;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=QLq4uxoh+IxsP7bOvtSOL1OvtImj3hqhtpDGgDrWfVE=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJkfOdyLVCKWzL0k6/HSc98O155LNgmGsaU5dktat5+wc
 7y4hMuro5SFQYyLQVZMkeWsvVGPeNV7I935/5th5rAygQxh4OIUgImUHGD4n3zIxXc2l0Hg0euv
 pi09M38Ga2ytztONQQeiU3/r6n94vpWR4Zt0QpKBwFb19fK+V0wiYzP2SEuXvfix8oft4sLDvda
 uDAA=
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

Currently Tyr disables its clocks from TyrDrmDeviceData::drop(), which
causes them to be shut down before any other fields in TyrDrmDeviceData
are dropped. This prevents us from using the clocks when dropping the
other fields in TyrDrmDeviceData.

In order to better control when the clocks are dropped, move this cleanup
logic into a Drop implementation on the Clocks struct itself.

Since it serves no further purpose, remove the PinnedDrop implementation
for TyrDrmDeviceData.

Also, while here, remove the #[pin_data] annotation from both the struct
Clocks and struct Regulators since neither of these structs need this
macro to create structurally pinned fields.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index e8acd2d69468..bb56a9b996a0 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -52,7 +52,7 @@ pub(crate) struct TyrPlatformDriverData {
     _device: ARef<TyrDrmDevice>,
 }
 
-#[pin_data(PinnedDrop)]
+#[pin_data]
 pub(crate) struct TyrDrmDeviceData {
     pub(crate) pdev: ARef<platform::Device>,
 
@@ -157,17 +157,6 @@ impl PinnedDrop for TyrPlatformDriverData {
     fn drop(self: Pin<&mut Self>) {}
 }
 
-#[pinned_drop]
-impl PinnedDrop for TyrDrmDeviceData {
-    fn drop(self: Pin<&mut Self>) {
-        // TODO: the type-state pattern for Clks will fix this.
-        let clks = self.clks.lock();
-        clks.core.disable_unprepare();
-        clks.stacks.disable_unprepare();
-        clks.coregroup.disable_unprepare();
-    }
-}
-
 // We need to retain the name "panthor" to achieve drop-in compatibility with
 // the C driver in the userspace stack.
 const INFO: drm::DriverInfo = drm::DriverInfo {
@@ -191,14 +180,20 @@ impl drm::Driver for TyrDrmDriver {
     }
 }
 
-#[pin_data]
 struct Clocks {
     core: Clk,
     stacks: OptionalClk,
     coregroup: OptionalClk,
 }
 
-#[pin_data]
+impl Drop for Clocks {
+    fn drop(&mut self) {
+        self.core.disable_unprepare();
+        self.stacks.disable_unprepare();
+        self.coregroup.disable_unprepare();
+    }
+}
+
 struct Regulators {
     _mali: Regulator<regulator::Enabled>,
     _sram: Regulator<regulator::Enabled>,

-- 
2.53.0


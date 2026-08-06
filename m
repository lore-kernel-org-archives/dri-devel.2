Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7D2C56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:10:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DBC410EB6D;
	Thu,  6 Aug 2026 17:09:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="i2bIAWzZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 129DA10EB6D
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 17:09:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B5B0044061;
 Thu,  6 Aug 2026 17:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CEBAC2BCFA;
 Thu,  6 Aug 2026 17:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
 t=1786036195; bh=0SevxM4QseTr6vo1UBUryrO8o+ks3okCtZz/y52EsJY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=i2bIAWzZgpUXscjw333pAnU1FQNPuqMwNv6O8K77TvUTFrAOe+aFCppMOLY6LNUW9
 ZEIl7jP0SkEvZkL0Q6R0wwc+JcvSI/NdUM6pkp3ECvHVtju1wXRRu5NrLIfngVK+Uj
 9xecXu19YwsAW0vwd6nS4CzBeGamKNnEjnOMYFO4=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 77B1AC56208;
 Thu,  6 Aug 2026 17:09:55 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Fri, 07 Aug 2026 01:07:28 +0800
Subject: [PATCH v3 6/8] rust: drm: gpuvm: add dump_gpuva_info to UniqueRefGpuVm
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-tyr-debugfs-v2-v3-6-ff5595ac66ae@linux.dev>
References: <20260807-tyr-debugfs-v2-v3-0-ff5595ac66ae@linux.dev>
In-Reply-To: <20260807-tyr-debugfs-v2-v3-0-ff5595ac66ae@linux.dev>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Greg Kroah-Hartman <gregkh@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786036192; l=1591;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=0SevxM4QseTr6vo1UBUryrO8o+ks3okCtZz/y52EsJY=;
 b=iQQbLPYqcK2qdOzUHwdC80CHg75KN+Z/RKSJaI4MvvRPMI1fCfbiWcsk1Ev5nNdhkboKAwdV9
 xbvlNvVyrgiC9ixL6YQ6Q9rWqSyBL9DoXrEDRUG250lfoT/Ei99JAGC
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

Add method wrapping drm_debugfs_gpuva_info to dump GPU VA space
mappings into a seq_file. Needed by the Tyr gpuvas debugfs file.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/bindings/bindings_helper.h | 1 +
 rust/kernel/drm/gpuvm/mod.rs    | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 1124785e210b3..c3b2a86528934 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -30,6 +30,7 @@
 
 #include <linux/acpi.h>
 #include <linux/gpu_buddy.h>
+#include <drm/drm_debugfs.h>
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
diff --git a/rust/kernel/drm/gpuvm/mod.rs b/rust/kernel/drm/gpuvm/mod.rs
index 20a08b3defeb8..9348b1c3064ec 100644
--- a/rust/kernel/drm/gpuvm/mod.rs
+++ b/rust/kernel/drm/gpuvm/mod.rs
@@ -312,6 +312,15 @@ pub fn data_ref(&self) -> &T {
         unsafe { &*self.0.data.get() }
     }
 
+    /// Dumps GPU VA space info into a seq_file.
+    ///
+    /// Wraps the C `drm_debugfs_gpuva_info` function.
+    #[inline]
+    pub fn dump_gpuva_info(&self, m: &crate::seq_file::SeqFile) -> Result {
+        // SAFETY: `m.as_raw()` and `self.as_raw()` are valid by the type invariants.
+        to_result(unsafe { bindings::drm_debugfs_gpuva_info(m.as_raw(), self.as_raw()) })
+    }
+
     /// Access the data owned by this `UniqueRefGpuVm` mutably.
     #[inline]
     pub fn data(&mut self) -> &mut T {

-- 
2.43.0



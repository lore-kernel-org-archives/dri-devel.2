Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F62606A7C5
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aeykyGtg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9ADB10E642;
	Wed, 18 Nov 2026 16:32:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D533810E5B2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:32:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BBD1F401D0;
 Wed, 18 Nov 2026 16:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C308F1F000C4;
 Wed, 18 Nov 2026 16:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795019541;
 bh=OOna5QYnDXiX/mKSFI3oMp+tVKpJtzeZSErziwfKJyI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aeykyGtg3mkwJ5pIl3nfB6Vu1U7+AbYMuB1OWwtlqiihoayGzq06A5aLEokFDrGql
 zE2FcUC+HUhYoou6jz90IB3SxyL5/ioi5Z3hLBaSkGiQ/4+8kcpG9tSkexckNob5W7
 F5nEiSCAbaWi8ngFfiT2Y1XN3Tyj0fKMOeegsgEne/kCBIiTArKPYTvYzV+rTEjykv
 KZmMlU+9Yw1z2+ecok1QNj1ByXcebs9xmPPXucgTCyj1tvQ3NNRICu98/GT9ovLA9p
 pBl9t8eqZYInDntRC6Ka9FcCb8v9cDZ9jTt5DUZAgSiJjolrveny8oM8Ny/EM0cWtX
 4uNEm78M0AvZg==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, acourbot@nvidia.com,
 daniel.almeida@collabora.com, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org,
 work@onurozkan.dev, brauner@kernel.org, lyude@redhat.com, j@jananu.net,
 alvin.sun@linux.dev, deborah.brouwer@collabora.com,
 laura.nao@collabora.com, beata.michalska@arm.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] rust: drm: gem: gate open/close callbacks with
 RegistrationGuard
Date: Wed, 18 Nov 2026 17:29:43 +0100
Message-ID: <20261118163203.2483856-3-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118163203.2483856-1-dakr@kernel.org>
References: <20261118163203.2483856-1-dakr@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Wrap the GEM object open and close callbacks with a RegistrationGuard
(drm_dev_enter / drm_dev_exit) to ensure the driver callbacks only run
while the parent bus device is bound.

If the device has been unbound, open returns -ENODEV and close silently
returns. This prevents driver code from accessing device resources after
unbind and is a prerequisite for making drm::Driver::File
lifetime-parameterized, since GEM callbacks receive a &drm::File that
could otherwise be used to access invalidated file private data.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/gem/mod.rs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 85657a39e146..94355081edab 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -128,6 +128,14 @@ extern "C" fn open_callback<T: DriverObject>(
     raw_obj: *mut bindings::drm_gem_object,
     raw_file: *mut bindings::drm_file,
 ) -> core::ffi::c_int {
+    // SAFETY: `raw_obj` is a valid pointer to a `struct drm_gem_object` with a valid `dev`.
+    let dev: &drm::Device<T::Driver, drm::Userspace> =
+        unsafe { drm::Device::from_raw((*raw_obj).dev) };
+
+    let Some(_guard) = dev.registration_guard() else {
+        return ENODEV.to_errno();
+    };
+
     // SAFETY: `open_callback` is only ever called with a valid pointer to a `struct drm_file`.
     let file = unsafe { DriverFile::<T>::from_raw(raw_file) };
 
@@ -148,6 +156,14 @@ extern "C" fn close_callback<T: DriverObject>(
     raw_obj: *mut bindings::drm_gem_object,
     raw_file: *mut bindings::drm_file,
 ) {
+    // SAFETY: `raw_obj` is a valid pointer to a `struct drm_gem_object` with a valid `dev`.
+    let dev: &drm::Device<T::Driver, drm::Userspace> =
+        unsafe { drm::Device::from_raw((*raw_obj).dev) };
+
+    let Some(_guard) = dev.registration_guard() else {
+        return;
+    };
+
     // SAFETY: `open_callback` is only ever called with a valid pointer to a `struct drm_file`.
     let file = unsafe { DriverFile::<T>::from_raw(raw_file) };
 
-- 
2.56.1


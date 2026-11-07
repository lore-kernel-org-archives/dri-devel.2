Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593F5606A335
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 02:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZG1LcMF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B925F10E50C;
	Sat,  7 Nov 2026 02:20:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3C7810E505
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 02:20:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8AEFF43627;
 Sat,  7 Nov 2026 02:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4DD1F008A3;
 Sat,  7 Nov 2026 02:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794018029;
 bh=GQNExV2IBW/VIXiP+QKPq05xQXuih8H7xGZygNB42ds=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VZG1LcMFLK+j+r6SEp67HSNoHe81odWNIkDi9DME3e9tBooSE5IWxcPaslSi8HqUH
 C84gS9G+hliw3eWpKdf25eor+MavBp1HQsBs38+02DpLYRyIDiszJSRMJcS5sFB+oq
 7frnYU+TUngxm6yrZeRftEYxlfd17zIKUH2fO1U5EeEn3xQ6YddOC4s/6ruoddjOz/
 QcDCSJczb1iUmHrKi95X1Pn3Kd4s4KkkXJO2V1hUkG4jHskRhrOGJTatlFUtNTpTMH
 iJv2SfkEsVXTSMr9TcfVoYEOLslAzIafhFltAhfZ2O4oAaSsvTmr014KeFh+Dp3ii+
 m8M39LkGSGnnA==
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
Subject: [PATCH v2 2/7] rust: drm: gem: gate open/close callbacks with
 RegistrationGuard
Date: Sat,  7 Nov 2026 03:03:20 +0100
Message-ID: <20261107021427.2105374-3-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107021427.2105374-1-dakr@kernel.org>
References: <20261107021427.2105374-1-dakr@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
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
2.56.0


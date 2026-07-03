Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D49C44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:02:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D371D10F618;
	Fri,  3 Jul 2026 03:02:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="v81EYZdi";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AB8510F618
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:02:57 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4763b0c1dcdso106827f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047775; x=1783652575;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oQMv+8Yv3skvZ5J2JNSXd3jpYzo7yPHl1/YCrTLKXiA=;
 b=v81EYZdiU8nsDEaMRchGIm2iMSVAjK1TRzsRMjQPoSZkQfQ2SJ95oExNILseT+6REP
 SzQV2ObfOImQ+mQx/gPZYuQ3adKmdVztLNQLnYOkJgxOXTkaBphtVfieH2Xz8DyL66IJ
 siasNxNCgwXJHtDDZz7WY6urroTgbOKzym0LB9fUrHBZum7X/seFxkT4j39CtHYeNQ5+
 /z2b05aTvxw6NUYMvUmX0VNsXpT0BnUA2lqGy7mSxywXs4VvxBb/0341mb+CSNU7GerO
 T6RN7THabyB+TWqPFYHsCeEsOBg+C32kvlE7T5EARGgYOhJBBzIRP4CocgjFDkIYbTR0
 0rvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047775; x=1783652575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oQMv+8Yv3skvZ5J2JNSXd3jpYzo7yPHl1/YCrTLKXiA=;
 b=AKaswmI6m4DiX/MJFFuwH5Zi6iqXTmWIeE4uyZknHFnR4Ut6fS37SNz5DUoTiGu59/
 p6wSbrLMRyOmku2PK+jA2GFTl/E4hrYpDw60MtAsVoPu/5e1qy7nap53+/cjBVAZfO9C
 ja4qMD8AD7PQ+Sko8PwFvm8CZTVU5sMVEJpYv1Otq5vKTG8Qx5e6t60Gf2bgwu1XCvBz
 ezO3IRzLG0YwLLP8KaPayNo6WyXg9cd3+Z/6tjjfSzEMXq7zUaA/EdpQX61hsYcwQz9y
 hP8dv9pKP6drAFcL4gRgpObhVJUQgvwKe0VJs7GliPsuY0Su/RNibnW8RKNjg8QoU9Wt
 X8Jw==
X-Gm-Message-State: AOJu0Ywtnystur5oF/A+O4+3faEiqen4jF4K+JbcK1nzVpOdq6R381lg
 Q6+HeD+OyK3bnENR0uk3yWac9Dw+QI3nzs2A+Pv892NT68Me3J0KoGUxqIJDaUhVXw==
X-Gm-Gg: AfdE7clOzXAyRx0WqAiwD6d8/RqM0ngr0HLIAMNPOsBmGlMvAmYP7rNRZIrisDBIdLv
 7NrnTndYEb6icwnR8ZMH/5S17kA61Og0AHfK6CWthwwi0RtAFAQOi6VwB0rD2TQ642usFKfXmq+
 rQ7S5eY649lu6RhMVq0DpVnn2sSwFxJBpTTGGlNsxC2wfpGxkJxpYH3/PJtwMAMrGI1hNxhJ3Rl
 KyHDEqXgIgV1hi/lRt1FJW75LMVIq5Q1uLZsFN2GaTUD1vrgwHROA9GGM+RkETNz0I2g9VT8RsI
 Yzs24h2pSeANTokEy7Z4ikPnbw/PkdDBwTxXVj7/6kJge6JHq9XnpmP/l+Jy5L9n9m3ONNmmFGI
 xIPXnZDC3LEsb0/W8S4lKwJBqNZhSEZAbvQLqMZ+Wtd5C4+rEqNP9ECtS+ArMXEb7IvUnedP7Jb
 lQ64YVAkpMI05uMfbk/dgySOgYleljCsykX+fSHDlOUkWSEH577394SOZk
X-Received: by 2002:a05:6000:25e7:b0:476:7036:f854 with SMTP id
 ffacd0b85a97d-477b39847a2mr10583187f8f.21.1783047775312; 
 Thu, 02 Jul 2026 20:02:55 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dde1a4fdsm15198199f8f.26.2026.07.02.20.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:02:54 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: rust-for-linux@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 linux-kernel@vger.kernel.org, Mike Lothian <mike@fireburn.co.uk>
Subject: [RFC PATCH 1/2] drm/kms: rust: fixes for a virtual KMS consumer
Date: Fri,  3 Jul 2026 04:02:46 +0100
Message-ID: <20260703030249.2949-2-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703030249.2949-1-mike@fireburn.co.uk>
References: <20260703030249.2949-1-mike@fireburn.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Three fixes to the safe Rust KMS layer, shaken out while bringing up the
out-of-tree evdi virtual-display driver (they are equally correct for any
KmsDriver, including vino):

  * kms: store MODE_CONFIG_OPS as a 'static reference. probe_kms() installed
    mode_config.funcs / .helper_private from a by-value ModeConfigOps local,
    leaving those pointers dangling once probe_kms() returned. The DRM core
    later read a garbage mode_valid slot out of the reused stack and jumped to
    it (RIP=0x9). Promoting the vtable to a const-promoted &'static keeps it
    alive for the device's lifetime.

  * framebuffer: bracket the vmap in drm_gem_fb_begin/end_cpu_access. Reads
    through the CPU mapping could otherwise return stale cached pixels (an
    earlier compositor frame) while new frames were rendered elsewhere -- the
    scanout appeared frozen. end_cpu_access is balanced in the vmap guard's
    Drop.

  * driver: call drm_atomic_helper_shutdown() from Registration::drop() before
    drm_dev_unplug(), replacing the commented-out TODO. Without it the last
    committed atomic state kept framebuffers -- and the connectors they
    reference -- pinned, surfacing as drm_mode_config_cleanup() "leaked"
    warnings at teardown.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 rust/kernel/drm/driver.rs          | 24 ++++++++++++------------
 rust/kernel/drm/kms.rs             | 12 +++++++++---
 rust/kernel/drm/kms/framebuffer.rs | 24 ++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index b7e80df6289e..1d9309bc41c2 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -287,6 +287,18 @@ unsafe impl<T: Driver> Send for Registration<T> where
 
 impl<T: Driver> Drop for Registration<T> {
     fn drop(&mut self) {
+        // Disable the display pipeline before unregistering. KMS drivers must shut the active
+        // configuration down at teardown; otherwise the committed atomic state keeps the
+        // framebuffers -- and the mode objects it references, such as the still-attached
+        // connectors -- alive, which surfaces later as `drm_mode_config_cleanup()` "leaked"
+        // warnings once the last userspace fd closes. This must run while the device is still
+        // registered (i.e. before `drm_dev_unplug()`).
+        if drm::Device::<T>::has_kms() {
+            // SAFETY: KMS is set up for this device (checked above) and it is still registered, so
+            // committing the "everything off" state is valid.
+            unsafe { bindings::drm_atomic_helper_shutdown(self.drm.as_raw()) };
+        }
+
         // Use `drm_dev_unplug` rather than `drm_dev_unregister` to ensure that existing
         // `drm_dev_enter()` critical sections complete before unregistration proceeds. This
         // is required for the safety of `UnbindGuard`, which relies on the SRCU barrier in
@@ -299,17 +311,5 @@ fn drop(&mut self) {
         // After drm_dev_unplug(), the SRCU barrier guarantees that all UnbindGuard critical
         // sections have completed, so no one holds a reference to reg_data anymore.
         // reg_data is dropped here automatically.
-
-        /* TODO: We need to figure out what to do about this, and whether or not we should just call
-         * this before dev unplug
-         */
-        /*
-        if drm::device::Device::<T>::has_kms() {
-            // SAFETY: We just checked above that KMS was setup for this device, so this is safe to
-            // call
-            unsafe { bindings::drm_atomic_helper_shutdown(self.0.as_raw()) }
-        }
-        */
-        //build_error!("You forgot to update the cleanup methods")
     }
 }
diff --git a/rust/kernel/drm/kms.rs b/rust/kernel/drm/kms.rs
index 874a2ebc7887..f1472e913952 100644
--- a/rust/kernel/drm/kms.rs
+++ b/rust/kernel/drm/kms.rs
@@ -59,7 +59,13 @@ pub trait KmsImpl {
         type Driver: Driver;
 
         /// The optional KMS callback operations for this driver.
-        const MODE_CONFIG_OPS: Option<ModeConfigOps>;
+        ///
+        /// This is a `'static` reference so that the `drm_mode_config_funcs` and
+        /// `drm_mode_config_helper_funcs` pointers installed into `drm_device.mode_config` in
+        /// [`probe_kms`] outlive `probe_kms`'s stack frame. Storing `&ops.kms_vtable` from a
+        /// by-value local left `mode_config.funcs` dangling once `probe_kms` returned; the DRM core
+        /// then read a garbage `mode_valid` slot out of the reused stack and called it (RIP=0x9).
+        const MODE_CONFIG_OPS: Option<&'static ModeConfigOps>;
 
         /// The callback for using a Driver's callbacks to probe the KMS capabilities and object
         /// topology.
@@ -189,7 +195,7 @@ fn atomic_commit_tail<'a>(
 impl<T: KmsDriver> private::KmsImpl for T {
     type Driver = Self;
 
-    const MODE_CONFIG_OPS: Option<ModeConfigOps> = Some(ModeConfigOps {
+    const MODE_CONFIG_OPS: Option<&'static ModeConfigOps> = Some(&ModeConfigOps {
         kms_vtable: bindings::drm_mode_config_funcs {
             atomic_check: Some(bindings::drm_atomic_helper_check),
             fb_create: Some(bindings::drm_gem_fb_create),
@@ -269,7 +275,7 @@ impl<T: KmsDriver> KmsImpl for T {}
 impl<T: Driver> private::KmsImpl for PhantomData<T> {
     type Driver = T;
 
-    const MODE_CONFIG_OPS: Option<ModeConfigOps> = None;
+    const MODE_CONFIG_OPS: Option<&'static ModeConfigOps> = None;
 }
 
 impl<T: Driver> KmsImpl for PhantomData<T> {}
diff --git a/rust/kernel/drm/kms/framebuffer.rs b/rust/kernel/drm/kms/framebuffer.rs
index e12fa7a24e15..00696b733c7a 100644
--- a/rust/kernel/drm/kms/framebuffer.rs
+++ b/rust/kernel/drm/kms/framebuffer.rs
@@ -171,6 +171,21 @@ pub fn vmap(&self) -> Result<FramebufferVmap<'_, T>> {
             unsafe { bindings::drm_gem_fb_vunmap(self.as_raw(), map.as_mut_ptr()) };
             return Err(EINVAL);
         }
+        // Synchronise the CPU's view with any GPU (or dma-buf importer) writes before the caller
+        // reads the pixels. Without this, reads through the vmap can return stale *cached* data --
+        // e.g. a compositor's earlier frame -- so the scanout appears frozen while the GPU keeps
+        // rendering new frames elsewhere. `end_cpu_access` in `Drop` balances it.
+        // SAFETY: `self.as_raw()` is the valid GEM-backed framebuffer just vmapped above.
+        if let Err(e) = to_result(unsafe {
+            bindings::drm_gem_fb_begin_cpu_access(
+                self.as_raw(),
+                bindings::dma_data_direction_DMA_FROM_DEVICE,
+            )
+        }) {
+            // SAFETY: balances the vmap just done, with the same `map`.
+            unsafe { bindings::drm_gem_fb_vunmap(self.as_raw(), map.as_mut_ptr()) };
+            return Err(e);
+        }
         Ok(FramebufferVmap { fb: self, map, _p: PhantomData })
     }
 }
@@ -209,6 +224,15 @@ pub fn as_bytes(&self) -> &[u8] {
 
 impl<'a, T: KmsDriver> Drop for FramebufferVmap<'a, T> {
     fn drop(&mut self) {
+        // Balance the `begin_cpu_access` from `vmap` before unmapping.
+        // SAFETY: `self.fb.as_raw()` is the framebuffer passed to `drm_gem_fb_begin_cpu_access`
+        // in `vmap`, with the same direction.
+        unsafe {
+            bindings::drm_gem_fb_end_cpu_access(
+                self.fb.as_raw(),
+                bindings::dma_data_direction_DMA_FROM_DEVICE,
+            )
+        };
         // SAFETY: `self.fb.as_raw()`/`self.map` are exactly the pair passed to
         // `drm_gem_fb_vmap` in `Framebuffer::vmap`, and the mapping has not been released
         // since.
-- 
2.55.0


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAD3CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E22D10F000;
	Wed, 17 Jun 2026 15:02:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="tsoQSdIx";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A90C10EA4C
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 15:02:41 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49222fb062bso49387865e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1781708560; x=1782313360;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qmpePbxtzwGXfx66Hl40vv7cxeZbUjsiMgIwVm4k9pY=;
 b=tsoQSdIxGt/syESgMcMaz88WVUOxQWBwmBrpXFiFJM+b5mG9E+sKCrSjdDnwBSmxxH
 rfc2sXdVTLyVQM36cQzjz4QCEdQ6s2jIDHhnOPUvjRS3+qUXeSfYyk41qVZ6X5dAQhoq
 Sml5rvkKHqzz1OQWhuTQMLD/ckDlJcG5Sbz3srUHXt3m9hg5crOBkcZV2Hn98MbfUqu0
 FIu12jCHOlTWBhA7zB1Svxzd9RFDO5T2Uq2wqncnn09qK93P7gOef8e0brF8wFOQHvPQ
 mZ6093cjdbLhIxffS3qZbER8uufzzNHeaJjMQJoabau8S7+3FEHfZBWmG/dqMizYFkeY
 AggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781708560; x=1782313360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qmpePbxtzwGXfx66Hl40vv7cxeZbUjsiMgIwVm4k9pY=;
 b=eih1b8tKZMi8OY6IG2bfMiL9q6zS9DHE+xEh2bD87CjakMeEx57ktqCVOSdkGin8NF
 wpRCMJOAlV98O1CvC5nwI0ZkRr9U4bks/Ukv0wqfNXFrE/XbbvRmDIODtV/Ga4uOrXR6
 4IgA8bOkIhO2Uu4TUmRnnvTBgGGZZbSWKnRhtYIURKzyb101jtV0rpcGL+gnJ6YjmZRj
 lAtdooSmw1rmSdaJyZq8vEwt1DCn6E39s+K6jUhFrW8FVMLKKl9GzPLacC2wfeCDyyHD
 oeJQcsK2PFTVX6m1kDcfqm3DvedhGAVvODxF78bWvWvE4CJZnT/C2DgeP4/3sdizCPhT
 xUOA==
X-Gm-Message-State: AOJu0Yz2zPzMSs1GtaZriGeBANmifnSRx3CaAG7Wsk/aqbG35PLuMys4
 djpSOEC+H2jyt4nAkWCxKlBg6a4GJ2xt6jOZPjQNKHf9LhDPwMqbIEXq+Eqpf58W+AqMj2hwAv8
 0kMBKJnBO
X-Gm-Gg: Acq92OFLXP4fLrMmU34LioknrClhmCiccWYr86OJvAkP4W3LMIbx2LkqcKAcSRWIe+7
 KF0WY9Av+rshASwEDCzG5/KEnKnOe+wHjmTkjYKmj12ljxRqcspsM6nCGcqEFyKe6EBMWCG8Q9j
 XQn6mbFaDFXeN8ZDZRZKe0DqHrH4Ok9SmQJPuVS717uWQjJ2vNWbDHOGwb9J4x4gPqeon6dR9W6
 2C3wGQ7VJ5N4i2U5pJgJNzEG4zNm+/QEGW+vn7hUWBl/1pQm8XI9hWErQ/H0W+OVP5KiAybz8Xz
 zGGyOS0QDLKc0t0OfxtesxfUl5ufd6urQQGUcxUQkdvJst+NOEeDiGwDbHVLMbsth8PBqI0yW1a
 aFIQS6QAZTbTVZ+lyADEUt5X0nWKmRlJazrTsNMXjMs/tIwYBIrNsSnH/VORCZaLVh9vPfkBKux
 j+uLsSSe913Ux/up2wALg+wP6rA1MgdcvXCF/qsjvly32DRh3ttp9572Tz
X-Received: by 2002:a05:600c:4e02:b0:490:c2a3:1781 with SMTP id
 5b1f17b1804b1-492333f7765mr76370435e9.34.1781708559486; 
 Wed, 17 Jun 2026 08:02:39 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f1cdsm57264311f8f.11.2026.06.17.08.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 08:02:38 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Asahi Lina <lina+kernel@asahilina.net>, Lorenzo Stoakes <ljs@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/4] rust: drm: add minimal KMS bindings for
 simple-display-pipe drivers
Date: Wed, 17 Jun 2026 16:02:23 +0100
Message-ID: <20260617150232.2210-2-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617150232.2210-1-mike@fireburn.co.uk>
References: <20260617150232.2210-1-mike@fireburn.co.uk>
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

The Rust DRM abstractions currently cover GEM and the device/driver
registration boilerplate, but expose nothing of the KMS (mode-setting)
API, so a Rust driver cannot bring up a display pipeline without
dropping to C. Add the minimum needed to drive an atomic mode-setting
pipeline built on the drm_simple_display_pipe helper (one CRTC + a
primary plane + encoder), the same path simpledrm/gud/udl use.

Two pieces:

 - bindings_helper.h: pull in the KMS headers (drm_atomic_helper,
   drm_connector, drm_gem_atomic_helper, drm_gem_framebuffer_helper,
   drm_managed, drm_modes, drm_modeset_helper_vtables,
   drm_probe_helper, drm_simple_kms_helper) so bindgen emits the
   drm_simple_display_pipe, drm_connector, drm_display_mode and helper
   bindings a KMS driver calls (drm_simple_display_pipe_init,
   drm_connector_init, drm_helper_probe_single_connector_modes,
   drm_gem_fb_create, drm_cvt_mode and the drm_atomic_helper_* family).

 - drm::driver: add FEAT_MODESET / FEAT_ATOMIC and the matching
   Driver::FEAT_MODESET / Driver::FEAT_ATOMIC associated consts, folded
   into compute_features() exactly like the existing FEAT_RENDER. They
   default to false, so GEM-only drivers are unaffected.

No safe CRTC/plane/connector wrappers are added here; this is the raw
binding surface a driver needs to call the C helpers itself, and is
meant to be superseded by the in-progress safe KMS layer. The raw
drm_device pointer those helpers need is exposed by a separate follow-up
patch ("expose drm::Device::as_raw()") so the escape hatch can be
reviewed on its own.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 rust/bindings/bindings_helper.h |  9 +++++++++
 rust/kernel/drm/device.rs       |  8 ++++++++
 rust/kernel/drm/driver.rs       | 17 +++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 14671e1825bb..877f82b927a0 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -32,13 +32,22 @@
 
 #include <linux/acpi.h>
 #include <linux/gpu_buddy.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
 #include <drm/drm_gem.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_gpuvm.h>
 #include <drm/drm_ioctl.h>
+#include <drm/drm_managed.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_simple_kms_helper.h>
 #include <kunit/test.h>
 #include <linux/auxiliary_bus.h>
 #include <linux/bitmap.h>
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 477cf771fb10..1d3319b713e2 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -165,6 +165,14 @@ const fn compute_features() -> u32 {
             features |= drm::driver::FEAT_RENDER;
         }
 
+        if T::FEAT_MODESET {
+            features |= drm::driver::FEAT_MODESET;
+        }
+
+        if T::FEAT_ATOMIC {
+            features |= drm::driver::FEAT_ATOMIC;
+        }
+
         features
     }
 
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index 25f7e233884d..6a79594510fd 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -22,6 +22,10 @@
 pub(crate) const FEAT_GEM: u32 = bindings::drm_driver_feature_DRIVER_GEM;
 /// Driver supports render nodes, i.e.: /dev/dri/renderDXX devices.
 pub(crate) const FEAT_RENDER: u32 = bindings::drm_driver_feature_DRIVER_RENDER;
+/// Driver supports mode setting (KMS).
+pub(crate) const FEAT_MODESET: u32 = bindings::drm_driver_feature_DRIVER_MODESET;
+/// Driver supports atomic mode setting.
+pub(crate) const FEAT_ATOMIC: u32 = bindings::drm_driver_feature_DRIVER_ATOMIC;
 
 /// Information data for a DRM Driver.
 pub struct DriverInfo {
@@ -131,6 +135,19 @@ pub trait Driver {
     /// usable from the render node (i.e. marked DRM_RENDER_ALLOW), whereas
     /// userspace processes using the master node can invoke any ioctl.
     const FEAT_RENDER: bool = false;
+
+    /// Sets the `DRIVER_MODESET` feature for this driver.
+    ///
+    /// When enabled, the driver advertises kernel mode-setting (KMS): it owns a
+    /// `drm_mode_config` and drives CRTCs, planes, encoders and connectors. Leave
+    /// `false` for a render-only (GEM) driver.
+    const FEAT_MODESET: bool = false;
+
+    /// Sets the `DRIVER_ATOMIC` feature for this driver.
+    ///
+    /// When enabled, the driver advertises the atomic mode-setting uAPI. It only
+    /// has an effect together with [`Driver::FEAT_MODESET`].
+    const FEAT_ATOMIC: bool = false;
 }
 
 /// The registration type of a `drm::Device`.
-- 
2.54.0


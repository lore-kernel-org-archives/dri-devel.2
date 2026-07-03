Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BE2C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:02:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56E0510F5FD;
	Fri,  3 Jul 2026 03:02:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="DS8c/d2W";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEDB610F5FD
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:02:00 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso110549f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047719; x=1783652519;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWYaWvLBgitKBD1DvypUSuQXP5THaJX3kX34tELc4Xg=;
 b=DS8c/d2WvFeeIJ3VS1cAqnF4xiGvSabGMaT8IUuKXj4cuTStIkNu6kTa3ycvxzN8l4
 wUs3y8YCSGeM7AVmAU2qFm8aZKnCDbFFuiKn+qo/R8njIk/1QetREcxClDuWT2z8Nau2
 L73mHIT7mC9KlsC5JnhQ37Gz5lhWxLwRD1rWYoy/4sVABaHwi3lxYP8FfGLSLuBHPpct
 5bB4gog2B9oiOFErUWQmuqKyCQ0I3S8GmzdN1Z+ETdhFh8ewm9we9K1l9eY/qCYE24UY
 8PeWfgbIOOkURssuSVJ2OIxGSzlCLPLQAI6JUiAhyCyXUgdr0Q9vr/8ZtHm1qOgj3+Vo
 YvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047719; x=1783652519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gWYaWvLBgitKBD1DvypUSuQXP5THaJX3kX34tELc4Xg=;
 b=ku7WKJMZHdaXQhDQngauuAml6e5wax7dIAqmemIwWJRWsUOzRn46TuNluO83xktIbM
 CqzVXbMJk0D5R7w8//vP28gaZSiizQp+2ftdztwttMXKgp1xskqKZXWek6M2vkNZ/LSX
 HSVA9jyph9a51GDmwkoLoSuGN8nzgNgbJs68jKBm7HR0YMpTcyrhg62FbGW5szjrYn8u
 iLyK2cRf6/laE0uq+CcRIMWZnllDSwu/xdBz4irDv4tH6cdcSkRaXqGX04fS0i+7aeCa
 ZwGjSoY6Y3yE/qxS9ORiPACS0tUYivHb9wFQhg9d6CfPN0wYYnlP1d0QSwrADjiy0qk9
 2M7g==
X-Gm-Message-State: AOJu0Ywx4KXJpJv8kdsSaMx5kKjP13E9W9X6Zwlc7maWv9eG1yIOA1sI
 N3/Q5tPjWtj8hGJ9HMqzqFLz5sh1xKnNtqJAxKFG9RnnWUMeZDh4hG6KxD84iUpgnw==
X-Gm-Gg: AfdE7cnHDAe5qPi5YHUOqj/UlIigOP5GsfIMITngVUKIiwaQTWAxgf0Vz+UuHmm/VDu
 2cK0JtoMtkFOg72P63VdX3Cdu25RZ3mhguoEtwomWUqsVy6Bz7aidGwW+SKA8evJ44XQhQFnXeR
 1unuHqqvd9oFIVoLUbRzqE02R2DMtNsuOqN/nZ0FI59U3IvWk6KgW45/KRSWFIjr8EW9DOKqjxD
 P0Wv9MeRzUd4p75KYPJFtUVQelxvQfqFV2rk+bZOI3p95dqlQsLgSThOoJqGBsbqYE4TB2lO4CE
 b2KztScokqz9+EtMNl9Ro5cVCj0TtQQLcPjowkg3/vcBD5dMdyyx8u6hv0Xfxfq2uoGRfFI/9Rg
 1kxnWTIwuc2AfUEhbSSFq0ESrml8489AsJtg5jUG+mxEqrQz/AuARK1xlK8/lnURqFciUs6ZDyp
 rDT/Vp88hFUyJueu+8rmXSkuz6pdinB/8dDbcDSDD2t9nhrcyRkBEZZnk0
X-Received: by 2002:a05:6000:2407:b0:475:f0c2:75a3 with SMTP id
 ffacd0b85a97d-4775ac9f53dmr13275064f8f.52.1783047719231; 
 Thu, 02 Jul 2026 20:01:59 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbacbsm14466500f8f.4.2026.07.02.20.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:01:57 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: rust-for-linux@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, Mike Lothian <mike@fireburn.co.uk>
Subject: [RFC PATCH v2 11/18] rust: platform: add runtime platform device
 creation
Date: Fri,  3 Jul 2026 04:00:58 +0100
Message-ID: <20260703030123.2814-12-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703030123.2814-1-mike@fireburn.co.uk>
References: <20260617150232.2210-1-mike@fireburn.co.uk>
 <20260703030123.2814-1-mike@fireburn.co.uk>
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

The platform abstraction can register a driver (platform::Driver) but not create
a device for it to bind to. Virtual drivers that spawn their own devices -- for
instance DisplayLink's evdi, which creates one platform device per virtual
display card from a sysfs attribute or at module load -- need the provider side.

Add platform::RegisteredDevice, a thin owner around
platform_device_register_full() whose Drop calls platform_device_unregister()
(which unbinds any bound driver first), plus DEVID_AUTO/DEVID_NONE constants and
a name/id/parent/dma_mask constructor. The non-generic methods are #[inline] so
out-of-tree modules can use them without an exported symbol.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 rust/kernel/platform.rs | 77 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 9b362e0495d3..4c2ded2e264f 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -571,3 +571,80 @@ unsafe impl Sync for Device {}
 // SAFETY: Same as `Device<Normal>` -- the underlying `struct platform_device` is the same;
 // `Bound` is a zero-sized type-state marker that does not affect thread safety.
 unsafe impl Sync for Device<device::Bound> {}
+
+/// Auto-assign a platform device instance id (`PLATFORM_DEVID_AUTO`).
+pub const DEVID_AUTO: i32 = bindings::PLATFORM_DEVID_AUTO;
+/// Create a platform device with no instance id (`PLATFORM_DEVID_NONE`).
+pub const DEVID_NONE: i32 = bindings::PLATFORM_DEVID_NONE;
+
+/// An owned platform device created and registered at runtime.
+///
+/// This is the *provider* side of the platform bus: whereas [`Driver`] binds to devices the bus
+/// hands it, [`RegisteredDevice`] *creates* a `struct platform_device` and adds it to the bus,
+/// which then binds any matching [`Driver`] (calling its `probe`). Virtual drivers such as
+/// DisplayLink's `evdi` use this to spawn their DRM card devices on demand (from a sysfs `add`
+/// attribute or at module init).
+///
+/// [`RegisteredDevice::new`] wraps `platform_device_register_full()`; dropping the handle calls
+/// `platform_device_unregister()`, which unbinds the bound driver and releases the device.
+pub struct RegisteredDevice {
+    pdev: NonNull<bindings::platform_device>,
+}
+
+// SAFETY: `platform_device_register_full()`/`platform_device_unregister()` are internally
+// synchronized by the driver core and safe to call from any thread; the handle only unregisters.
+unsafe impl Send for RegisteredDevice {}
+// SAFETY: See `Send`; `&RegisteredDevice` exposes only the thread-safe `Device<Normal>`.
+unsafe impl Sync for RegisteredDevice {}
+
+impl RegisteredDevice {
+    /// Create and register a new platform device.
+    ///
+    /// `name` is the platform device name, which the platform bus also uses to match a [`Driver`].
+    /// `id` is the instance id: [`DEVID_AUTO`] to auto-assign a unique one, [`DEVID_NONE`] for an
+    /// unnumbered device, or a fixed non-negative value. If `parent` is given, the new device is
+    /// created as its child. `dma_mask` requests a coherent DMA mask of that many bits (pass `0`
+    /// to leave the platform default).
+    #[inline]
+    pub fn new(
+        name: &CStr,
+        id: i32,
+        parent: Option<&device::Device>,
+        dma_mask: u64,
+    ) -> Result<Self> {
+        let info = bindings::platform_device_info {
+            parent: parent.map_or(core::ptr::null_mut(), |p| p.as_raw()),
+            name: name.as_char_ptr(),
+            id,
+            dma_mask,
+            ..Default::default()
+        };
+
+        // SAFETY: `info` is fully initialized (all remaining fields zeroed) and only borrowed for
+        // the duration of the call, which copies out the fields it needs.
+        let pdev = unsafe { bindings::platform_device_register_full(&info) };
+        let pdev = crate::error::from_err_ptr(pdev)?;
+
+        Ok(Self {
+            // A successful `platform_device_register_full()` returns a valid, non-null pointer.
+            pdev: NonNull::new(pdev).ok_or(ENOMEM)?,
+        })
+    }
+
+    /// Return a reference to the created platform [`Device`].
+    #[inline]
+    pub fn device(&self) -> &Device {
+        // SAFETY: `self.pdev` points to a valid, registered `struct platform_device` owned by
+        // `self`; `Device` is a transparent wrapper over `struct platform_device`.
+        unsafe { &*self.pdev.as_ptr().cast::<Device>() }
+    }
+}
+
+impl Drop for RegisteredDevice {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: `self.pdev` was returned by `platform_device_register_full()` and has not been
+        // unregistered yet; this consumes that registration exactly once.
+        unsafe { bindings::platform_device_unregister(self.pdev.as_ptr()) };
+    }
+}
-- 
2.55.0


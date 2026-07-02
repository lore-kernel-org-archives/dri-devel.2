Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC92C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51BD010F25B;
	Thu,  2 Jul 2026 09:32:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="N6gxHG4I";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="h6aft0XD";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D00F010F25B
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 09:32:43 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4grWrT691Yz8v1m;
 Thu, 02 Jul 2026 11:32:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782984761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7WfiE+s2SeFtrvoI9W5dFWeRHJeYSPRvC61ln8/YJkw=;
 b=N6gxHG4Ibu3Kwf+GC6iRb5iG4g7Grp79KHjyx032PRnXj2kmA2EvPZicVoXSvVWqjTAwI1
 f9+Tb48u1gmMeq+YqFYXUcY56/STl4v10H09w3yhUJ4/WeHlaujKZG5eJw4qhLZzGJC6Y2
 ZmBGfFYNJjqSOtR1IMm14UEcJB+w6LKAaM3YlwGZqaE+2B0hES24+3znWkVZP9k46/q0nH
 q0OoJTiNUPPcNR2R883Jzm6yoCeg7H3oxALJkWpG68JbMfkuH3PJJXvuj9qW6d/ouTLw5k
 csZzyUbtU29qIZToVtxUv99OC9NlgLkPxljbZK93+XnSvGYXYf7U6zvmzNmBaA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=h6aft0XD;
 spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782984759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7WfiE+s2SeFtrvoI9W5dFWeRHJeYSPRvC61ln8/YJkw=;
 b=h6aft0XDzkcsGgpru5LYT1t1N7T9WTEIB61jVC2qH42PnEdf1j+H7Trqc+SjLWHUY3bAum
 Jfv3orGYhlNqCqB0oha6LIxYCm0OFUmvuhV5jolxmIe2Qynzp02myn8NrDCWqrWIljU0th
 tnZ9fY4CrYBvF6u03mv8ziAYbl88MGCOx2v4mmooFnWEW/7rnqtFl/T/mO/+uSO19Ma/KN
 AGMwYep2BWK9LMUBfOC4aGJrfqMOREg/chDZISoUCc4lUUzplmxgdPWfeJYXjNuEjrLDmG
 U7w2MS9gqBDlnp/0FjfebnLUNXQA6aDpbQ9N3gkPAEYisT5I5MqDcJQeS8+E7g==
Date: Thu, 02 Jul 2026 11:32:27 +0200
Subject: [PATCH] rust: pci: rework device enabling API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-rust-pci-enable-device-managed-v1-1-75bc4ff2935c@mailbox.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQqEMBAEvyJzdiBGorJfWTzEpNUBNyuJiiD+3
 eCxDlV1UUIUJPoUF0UckuQfMlRlQW62YQKLz0xa6Ua1SnPc08arE0awwwL2WXLgnw12gufKGAz
 Go2tUTTmyRoxyvoNvf98PTCRLBXAAAAA=
X-Change-ID: 20260702-rust-pci-enable-device-managed-155eb5de8603
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782984751; l=4837;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=e/KR3pjg8xMYjHFY5YReM2UoqngO3ghQki9OUFn+GLU=;
 b=L4D2Uch8jcxc6wBza26Cc7mWCSkWEjGOkGFaqzPwjHOVQag7JY9G7O9l0MWlN6WtfCdo6AHiZ
 qnLBzBmb5mvCfJVwOC1+c5myvNVk2MJlE6NW2uLLbH1AVO80yxMmX5t
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-ID: 2b212682885282a8313
X-MBO-RS-META: agoaqz13tinhriczj5a1doagmd63so6b
X-Rspamd-Queue-Id: 4grWrT691Yz8v1m
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

`enable_device_mem()` wraps the unmanaged `pci_enable_device_mem()` and has
no disable counterpart, so the enable count is leaked on driver unbind.

Replace it with:

- `enable_device_managed()`, wrapping `pcim_enable_device()`, which
  registers a `pci_disable_device()` cleanup that runs on unbind; this
  is what drivers should normally call in `probe()`.

- an unmanaged `enable_device()`/`disable_device()` pair, wrapping
  `pci_enable_device()`/`pci_disable_device()`, e.g. for runtime PM
  paths.

Unlike `pci_enable_device_mem()`, both variants enable I/O and memory
resources.

Convert nova-core and the rust_driver_pci sample, the only users of
`enable_device_mem()`, to `enable_device_managed()`; besides gaining the
automatic cleanup they now also enables I/O resources.

This is a prerequisite for the EDU PCI sample driver series [1], as
requested by Danilo in its review [2]; that series will be rebased on
top of this patch.

Link: https://lore.kernel.org/r/20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org [1]
Link: https://lore.kernel.org/rust-for-linux/DJEPMYC7J6ZG.D0ODUD4YGFCT@kernel.org/ [2]
Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
Replace pci::Device::enable_device_mem() with a managed
enable_device_managed() plus an unmanaged enable_device()/
disable_device() pair, and convert the two users (nova-core and the
rust_driver_pci sample).

Requested by Danilo [2] while reviewing the EDU PCI sample driver
series [1]; that series will be rebased on top of this one.

[1] https://lore.kernel.org/r/20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org
[2] https://lore.kernel.org/rust-for-linux/DJEPMYC7J6ZG.D0ODUD4YGFCT@kernel.org
---
 drivers/gpu/nova-core/driver.rs |  2 +-
 rust/kernel/pci.rs              | 26 +++++++++++++++++++++++---
 samples/rust/rust_driver_pci.rs |  2 +-
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 5738d4ac521b..b0711d98033b 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -75,7 +75,7 @@ fn probe<'bound>(
         pin_init::pin_init_scope(move || {
             dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
 
-            pdev.enable_device_mem()?;
+            pdev.enable_device_managed()?;
             pdev.set_master();
 
             Ok(try_pin_init!(NovaCore {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 5071cae6543f..a408b3412077 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -453,10 +453,30 @@ pub fn pci_class(&self) -> Class {
 }
 
 impl<'a> Device<device::Core<'a>> {
-    /// Enable memory resources for this device.
-    pub fn enable_device_mem(&self) -> Result {
+    /// Enable I/O and memory resources for this device.
+    ///
+    /// This function is unmanaged and does not perform any cleanup when the device is unbound.
+    /// For a managed function take a look at [`Device::enable_device_managed`].
+    #[inline]
+    pub fn enable_device(&self) -> Result {
+        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
+        to_result(unsafe { bindings::pci_enable_device(self.as_raw()) })
+    }
+
+    /// Disable I/O and memory resources for this device.
+    ///
+    /// This function is the counterpart to [`Device::enable_device`].
+    #[inline]
+    pub fn disable_device(&self) {
+        // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
+        unsafe { bindings::pci_disable_device(self.as_raw()) }
+    }
+
+    /// Enable I/O and memory resources for this device, with automatic cleanup.
+    #[inline]
+    pub fn enable_device_managed(&self) -> Result {
         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
-        to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()) })
+        to_result(unsafe { bindings::pcim_enable_device(self.as_raw()) })
     }
 
     /// Enable bus-mastering for this device.
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 1aa8197d8698..213ef14386ca 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -154,7 +154,7 @@ fn probe<'bound>(
             pdev.device_id()
         );
 
-        pdev.enable_device_mem()?;
+        pdev.enable_device_managed()?;
         pdev.set_master();
 
         let bar = pdev.iomap_region_sized::<{ regs::END }>(0, c"rust_driver_pci")?;

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260702-rust-pci-enable-device-managed-155eb5de8603

Best regards,
-- 
Maurice Hieronymus <mhi@mailbox.org>


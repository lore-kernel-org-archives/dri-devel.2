Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8E7C561E6
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F6410F013;
	Wed,  5 Aug 2026 21:55:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vmamja+D";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AiUAnXHo";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69FA410F010
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 21:55:07 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hFkjQ0Dqtz8v33;
 Wed, 05 Aug 2026 23:55:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1785966906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bezt+Zsz+6o7rpt8SOOEgp0ND8Yn/JD38WcjGDxzRL4=;
 b=vmamja+DdIEECiONfwcQwwmGAqdESGQvdJJEyXcVuNJIWH39Iy4PiuFAjVq3nyEwQS2zER
 qD4tplYjakFBa1So/bGmfi6QaBXnXrCXa42WgzNkI7JBYa1enwjZZ/nuBvZqLwjBstsk9A
 /sg+/TfnoY++svgUTxHT9+IJwPhfu1Yz2AusJyVEDFHpYR0AtFvCdHdzjxqA8w+664FGuN
 0OpYIby89693ly/CgqIqoKUyYJQX5kEvxQ6tUFXaRwjdW+C6hKaorSKowb4o0MR+ED2lzk
 ZVfG5bEFrdgIy1CVhzr2TxACAcxidL/4xGlZTI81yHJ6L13Mees3W3VhqJ7JLg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=AiUAnXHo;
 spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1785966904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bezt+Zsz+6o7rpt8SOOEgp0ND8Yn/JD38WcjGDxzRL4=;
 b=AiUAnXHoT70uU+hHU9Jew+KvkY+Bg1LMftCr/Uuvy5shqaLHOE2SFxrGMlK4w/H63vwhAf
 LXhSiS8HlC+Jb9Da6NvVk0+nvQQqhwMFWUU9P2mNxPu5s/DtyV17y8eOiTV66UZLdWZ+8g
 UrKkzzIvbdGXmEv6lbd40pHGP1THwG/5emlNfMzyJWjlImmYqcHGd7HqEzFZsUWxztwyf4
 +I1LicAlDH5RY+4vezCTKtUPxkeAWsnLa8F1UHn4MD1CX4UdhdMsoEWELc4Go2+iYjpvwQ
 +LezW7QL4o9pBYE9btvcdBOGf+z8UhgVzAxZkhoDjn5yyGYHzy7LX0jyVWLAEw==
Date: Wed, 05 Aug 2026 23:54:43 +0200
Subject: [PATCH 3/3] gpu: nova-core: gsp: map the WPR meta for streaming
 DMA
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-dma-streaming-v1-3-03974c86b141@mailbox.org>
References: <20260805-dma-streaming-v1-0-03974c86b141@mailbox.org>
In-Reply-To: <20260805-dma-streaming-v1-0-03974c86b141@mailbox.org>
To: Danilo Krummrich <dakr@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Maurice Hieronymus <mhi@mailbox.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785966885; l=6274;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=ThOABvvFsour3ijRiEVxhr05cModfN4gyoRRJwxQlzA=;
 b=YCrrpuj6GlMj5rQmtZsCgCUvG2BV9HN9tuj8qLzbCj/GsTtpyV/FqSzoZ9WK1FKYzRj6MTnll
 zLFjHi80ZDTBvjIL4EftCQnjieHerAFcPXWVdIyZilWpVio2I0/aD72
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: jyegkrsu9kunrco4ypfdr8s61uhas51p
X-MBO-RS-ID: 4c71b2105cb0efc4092
X-Rspamd-Queue-Id: 4hFkjQ0Dqtz8v33
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

`GspFwWprMeta` is filled in once during boot, read out of system memory
by the booter, and dropped when `Gsp::boot()` returns. That is a
streaming transfer, so a coherent allocation buys nothing.

Map a `KBox<GspFwWprMeta>` instead. The mapping is submitted right
after initialization, which makes the contents unreachable for the
duration of the chipset-specific boot sequence and lets `dma_handle()`
be read through a shared reference.

`complete()` is called as soon as `hal.boot()` succeeds, the earliest
point the device is provably done with the metadata: on Tu102 the
Booter-load falcon has halted, on GH100 GSP-FMC has released the
lockdown. If `hal.boot()` fails instead, no such proof exists --
`Gsp::unload()` deliberately carries on past failed steps, so the
falcon may still be reading the buffer -- and `wpr_meta` drops in
flight, trading a one-off leak for a device-side use-after-free.

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 drivers/gpu/nova-core/firmware/booter.rs | 11 +++++++----
 drivers/gpu/nova-core/gsp/boot.rs        | 20 ++++++++++++++++++--
 drivers/gpu/nova-core/gsp/hal.rs         |  4 ++--
 drivers/gpu/nova-core/gsp/hal/gh100.rs   |  4 ++--
 drivers/gpu/nova-core/gsp/hal/tu102.rs   |  4 ++--
 5 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index d9313ac361af..780c7702a777 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -9,9 +9,12 @@
 
 use kernel::{
     device,
-    dma::Coherent,
+    dma::StreamingInFlight,
     prelude::*,
-    transmute::FromBytes, //
+    transmute::{
+        AsBytes,
+        FromBytes, //
+    },
 };
 
 use crate::{
@@ -402,12 +405,12 @@ pub(crate) fn new(
     ///
     /// Resets SEC2, loads this firmware image, then boots with the WPR metadata
     /// address passed via the SEC2 mailboxes.
-    pub(crate) fn run<T>(
+    pub(crate) fn run<T: FromBytes + AsBytes>(
         &self,
         dev: &device::Device<device::Bound>,
         bar: Bar0<'_>,
         sec2_falcon: &Falcon<Sec2>,
-        wpr_meta: &Coherent<T>,
+        wpr_meta: &StreamingInFlight<'_, KBox<T>>,
     ) -> Result {
         sec2_falcon.reset(bar)?;
         sec2_falcon.load(dev, bar, self)?;
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 8afb62d689cb..300ebf4e843d 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -4,7 +4,10 @@
 use kernel::{
     bits,
     device,
-    dma::Coherent,
+    dma::{
+        DataDirection,
+        Streaming, //
+    },
     io::poll::read_poll_timeout,
     pci,
     prelude::*,
@@ -117,7 +120,12 @@ pub(crate) fn boot(
         let fb_layout = FbLayout::new(chipset, bar, &gsp_fw)?;
         dev_dbg!(dev, "{:#x?}\n", fb_layout);
 
-        let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
+        let wpr_meta = Streaming::new(
+            dev,
+            KBox::init(GspFwWprMeta::new(&gsp_fw, &fb_layout), GFP_KERNEL)?,
+            DataDirection::ToDevice,
+        )?
+        .submit();
 
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
         let unload_guard = hal.boot(
@@ -131,6 +139,14 @@ pub(crate) fn boot(
             sec2_falcon,
         )?;
 
+        // The chipset-specific boot sequence only succeeds once the device is done reading the
+        // WPR metadata: on Tu102 the Booter-load falcon has halted, on GH100 GSP-FMC has released
+        // the lockdown. If it fails instead, `wpr_meta` drops in flight and leaks, as the falcon
+        // may still be reading the buffer.
+        //
+        // SAFETY: Per the above, the device has finished accessing the buffer.
+        let _ = unsafe { wpr_meta.complete() };
+
         gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version);
 
         // Poll for RISC-V to become active before continuing.
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 04f004856c60..09a523e3a180 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -8,7 +8,7 @@
 
 use kernel::{
     device,
-    dma::Coherent, //
+    dma::StreamingInFlight, //
 };
 
 use crate::{
@@ -61,7 +61,7 @@ fn boot<'a>(
         bar: Bar0<'a>,
         chipset: Chipset,
         fb_layout: &FbLayout,
-        wpr_meta: &Coherent<GspFwWprMeta>,
+        wpr_meta: &StreamingInFlight<'_, KBox<GspFwWprMeta>>,
         gsp_falcon: &'a Falcon<GspEngine>,
         sec2_falcon: &'a Falcon<Sec2>,
     ) -> Result<BootUnloadGuard<'a>>;
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 98f5ce197d13..67a79c54a739 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -5,7 +5,7 @@
 
 use kernel::{
     device,
-    dma::Coherent,
+    dma::StreamingInFlight,
     io::poll::read_poll_timeout,
     time::Delta, //
 };
@@ -156,7 +156,7 @@ fn boot<'a>(
         bar: Bar0<'a>,
         chipset: Chipset,
         fb_layout: &FbLayout,
-        wpr_meta: &Coherent<GspFwWprMeta>,
+        wpr_meta: &StreamingInFlight<'_, KBox<GspFwWprMeta>>,
         gsp_falcon: &'a Falcon<GspEngine>,
         sec2_falcon: &'a Falcon<Sec2>,
     ) -> Result<BootUnloadGuard<'a>> {
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 2f6301af7113..7d906de6d8bf 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -5,7 +5,7 @@
 
 use kernel::{
     device,
-    dma::Coherent,
+    dma::StreamingInFlight,
     io::Io, //
 };
 
@@ -262,7 +262,7 @@ fn boot<'a>(
         bar: Bar0<'a>,
         chipset: Chipset,
         fb_layout: &FbLayout,
-        wpr_meta: &Coherent<GspFwWprMeta>,
+        wpr_meta: &StreamingInFlight<'_, KBox<GspFwWprMeta>>,
         gsp_falcon: &'a Falcon<GspEngine>,
         sec2_falcon: &'a Falcon<Sec2>,
     ) -> Result<BootUnloadGuard<'a>> {

-- 
2.54.0


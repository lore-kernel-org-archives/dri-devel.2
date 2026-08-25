Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD47C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBC6610EA13;
	Tue, 25 Aug 2026 12:17:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qnm7Q0nR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C4E510EA13;
 Tue, 25 Aug 2026 12:17:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E2D28601E0;
 Tue, 25 Aug 2026 12:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B623D1F00A3A;
 Tue, 25 Aug 2026 12:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787660261;
 bh=RARPBtXKlRhD2dwL1m4/EiYIfM32ewUOhewSWJ8w+6A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Qnm7Q0nRC3xLH9lV5zIvgU2/Lyv2U+mQSah5/VMhfL56pSqRPr53wA3Nt+9l0hB5W
 xJNMT0rt5HPc7Zl6YWSy65smUNPa/Xq3PdVTWmPsIRgtaDWyC7+utEI4/Q1b2JvFSW
 hWVfpunGcEhD3sjfJl09+xwQsv+4mEUiSEtSRCxyyqAgITuHmQgskQVLeHKL/1Tdvq
 rvr0rhwAcbim/G9PYUxzGekZ29liBtbgdYF7AgFyZotTzGEo4HbgECiCN7doGn7tWO
 diYr5SKCmLD8DYmDmWahtuYs7S55sjSz8nMppAe2ppddX7TtgSD2VoJLSczXOcEzaC
 LuRUZZb6UKhrw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 25 Aug 2026 14:16:37 +0200
Subject: [PATCH 6/6] rust: hrtimer: Make HrTimer repr(transparent)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-expires-v2-v1-6-90411c6217c7@kernel.org>
References: <20260825-expires-v2-v1-0-90411c6217c7@kernel.org>
In-Reply-To: <20260825-expires-v2-v1-0-90411c6217c7@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Lyude Paul <lyude@redhat.com>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4527; i=a.hindborg@kernel.org; 
 h=from:subject:message-id;
 bh=/iy3QEv+yni9xSC0vTlYo4Ugs5+KpBCniu0Y3vtHoTI=; 
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqjYe9jYcpSe+wLRNW1oo1i5eGvlcLVUNuFP10s
 7UfK8WinBmJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCao2HvQAKCRD6UCkIqsW9
 0ORwD/0Sj64xfPV2r0QoO7IP/x9b7PTDTkSWlGndu6kamNrLfrho65qr1qKVZqNL0+XxsVDgSLY
 b9Vi+jTQUbTRRv/D/i3lJoFD0g8ef+HKPzW3GOO239iqEHrqs58s9FCv4fBsZZfBL0fJQcRPnV5
 9c/FffUV3YYP2k0hMPCvNfIT1OQYcEQ/hVEPWT0liDrmKNG0pt29l3zfUWzUZApA6WVxtP2foD4
 hgyR4o3of65x/GF3AAUY200j1PwpltBUupEbUrTtAng1NSIeHdRC6Dwg2Av6/gDUWlWpLKPR/6C
 1SlV7Y0JFLRJuervz/twMDsy1k8kcFQMtXzMsDVLV/i/2FKNL1rcqr5vU/C4YtcUM5gTowrXNs3
 rzBq6ZQBhB34t1zS+0/2rC+agYCP7lFR9WgUxh75O9VnY/GCsV/+Y1wHRA56sUqkjj7aOJ1mBiM
 Q2lVn1FSloMNSBWPjvFgqUh04xgg1LYACzeUGzvf54aluRaD1Fh0ygEJsz7e70aR93OCfTeo54i
 t6kRahOIePxc9lGF7Wdqc4AABYV1roT7/5lqMhS0abMloW8nY0yCw9Cxq4wSq1nvp+ZXKv4A+Ye
 aKfpZabwBcjK72VoZ1DU2UtXoG96tNXasHYq6tZOD1stFo+CO+qT3xyPFuYjsf8qgGuj8nWESfU
 tWZ5xRGFDWPmHJQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
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

From: FUJITA Tomonori <fujita.tomonori@gmail.com>

HrTimerCallbackContext acquires a &HrTimer<T> from a
NonNull<HrTimer<T>> while a &mut HrTimer<T> can exist at the same
time. This is sound only because HrTimer's sole field is
Opaque<bindings::hrtimer>, which puts every byte behind an UnsafeCell.
Adding a field to HrTimer that is not Opaque would make acquiring that
shared reference unsound.

Make HrTimer repr(transparent), which prevents multiple fields, so that
such a refactor fails to compile instead of silently introducing
unsoundness. This does not guarantee the remaining field stays behind
Opaque, but it rules out the likely way of getting there.

repr(transparent) cannot be combined with repr(C), so drop the latter.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Link: https://msgid.link/20260813134834.1562995-5-tomo@flapping.org
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs         | 6 +++++-
 rust/kernel/time/hrtimer/arc.rs     | 2 +-
 rust/kernel/time/hrtimer/pin.rs     | 2 +-
 rust/kernel/time/hrtimer/pin_mut.rs | 2 +-
 rust/kernel/time/hrtimer/tbox.rs    | 2 +-
 5 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 2a9abc9f5d8c..ab7c568b8855 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -427,8 +427,12 @@
 /// # Invariants
 ///
 /// * `self.timer` is initialized by `bindings::hrtimer_setup_ext`.
+// `repr(transparent)` is not merely about layout. `HrTimerCallbackContext` acquires a
+// `&HrTimer<T>` while a `&mut HrTimer<T>` may exist, which is sound only because every byte of
+// this type sits inside `Opaque`. Being transparent rejects a second field at compile time,
+// but it does not enforce that the remaining field stays `Opaque`.
 #[pin_data]
-#[repr(C)]
+#[repr(transparent)]
 pub struct HrTimer<T> {
     #[pin]
     timer: Opaque<bindings::hrtimer>,
diff --git a/rust/kernel/time/hrtimer/arc.rs b/rust/kernel/time/hrtimer/arc.rs
index 8a9fcb5c69e6..46ccff9e0024 100644
--- a/rust/kernel/time/hrtimer/arc.rs
+++ b/rust/kernel/time/hrtimer/arc.rs
@@ -84,7 +84,7 @@ impl<T> RawHrTimerCallback for Arc<T>
         expires: bindings::ktime_t,
         fwd: *mut bindings::hrtimer_forward_args,
     ) -> bindings::hrtimer_restart {
-        // `HrTimer` is `repr(C)`
+        // `HrTimer` is `repr(transparent)`
         let timer_ptr = ptr.cast::<super::HrTimer<T>>();
 
         // SAFETY: By C API contract `ptr` is the pointer we passed when
diff --git a/rust/kernel/time/hrtimer/pin.rs b/rust/kernel/time/hrtimer/pin.rs
index d1143f278f31..5fd374fdc480 100644
--- a/rust/kernel/time/hrtimer/pin.rs
+++ b/rust/kernel/time/hrtimer/pin.rs
@@ -87,7 +87,7 @@ impl<'a, T> RawHrTimerCallback for Pin<&'a T>
         expires: bindings::ktime_t,
         fwd: *mut bindings::hrtimer_forward_args,
     ) -> bindings::hrtimer_restart {
-        // `HrTimer` is `repr(C)`
+        // `HrTimer` is `repr(transparent)`
         let timer_ptr = ptr.cast::<HrTimer<T>>();
 
         // SAFETY: By the safety requirement of this function, `timer_ptr`
diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtimer/pin_mut.rs
index 04f9d8cbddcd..2bba3c41d6e9 100644
--- a/rust/kernel/time/hrtimer/pin_mut.rs
+++ b/rust/kernel/time/hrtimer/pin_mut.rs
@@ -91,7 +91,7 @@ impl<'a, T> RawHrTimerCallback for Pin<&'a mut T>
         expires: bindings::ktime_t,
         fwd: *mut bindings::hrtimer_forward_args,
     ) -> bindings::hrtimer_restart {
-        // `HrTimer` is `repr(C)`
+        // `HrTimer` is `repr(transparent)`
         let timer_ptr = ptr.cast::<HrTimer<T>>();
 
         // SAFETY: By the safety requirement of this function, `timer_ptr`
diff --git a/rust/kernel/time/hrtimer/tbox.rs b/rust/kernel/time/hrtimer/tbox.rs
index c7f86909e21b..399ad7677043 100644
--- a/rust/kernel/time/hrtimer/tbox.rs
+++ b/rust/kernel/time/hrtimer/tbox.rs
@@ -107,7 +107,7 @@ impl<T, A> RawHrTimerCallback for Pin<Box<T, A>>
         expires: bindings::ktime_t,
         fwd: *mut bindings::hrtimer_forward_args,
     ) -> bindings::hrtimer_restart {
-        // `HrTimer` is `repr(C)`
+        // `HrTimer` is `repr(transparent)`
         let timer_ptr = ptr.cast::<super::HrTimer<T>>();
 
         // SAFETY: By C API contract `ptr` is the pointer we passed when

-- 
2.51.2



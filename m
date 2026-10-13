Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE37CC6B19
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 17:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB44A10E711;
	Tue, 13 Oct 2026 17:09:04 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3F7210E917
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 17:08:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791911336; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eUQKrPEHz7FVW5XKuZf+FmKXwAjC+qbxjPTipOZ1+PaA/YVSdKnTgWXvSs0pPyoxRmCe2+DayYnHdK/z/QLZ2+S60Bd9w1ULEQ/KJ1iJa5ldT9crLtvTYOL21T9MeHYJWNe/cvNbYV8mfBRw1h4xXShSRpicMvZxz8cNfNp8b84=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791911336;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=t+fFi4Z+g+CM3RT5lBnnZp0EFC7w1pH0hvCHVGOD4MQ=; 
 b=StToA35WVHXP+LI0Y8PyTWoJErUxJ5suMGXwu2UMI240FhGuDTnumG+oc6EeoEE4uXDYBhOvd94hQqOxSwbYxB0M5l9VOiWh3jUwsykVUR7wRw3BvXxmJ0NskCVAFIBal7GaeNLL4pZlA90QMBl5EOv1zgrIqVKBKRVd6jDW/Co=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791911336; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=t+fFi4Z+g+CM3RT5lBnnZp0EFC7w1pH0hvCHVGOD4MQ=;
 b=iE2yTB3q90LCPzk71JQ5i+JQDUr2IOTaCIR9uNVqTX3MYYa8ZSzT+ONL9QQVZ7Rb
 lOIlBjL3G22Gzh+u1uFkokwYUKXMIVx5S1AkrzFaWZu9cTNz0i0Qd4Yiwbe4OYN8D9u
 L/bIxm9DADXwW+rHwLZeLXgYqmdZcQU2z6areasg=
Received: by smtp.zohomail.com with SMTPS id 1791911333686124.99074798625816; 
 Tue, 13 Oct 2026 10:08:53 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Tue, 13 Oct 2026 14:07:45 -0300
Subject: [PATCH v6 6/7] rust: clk: add `ExclusiveClk`
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-clk-type-state-v6-6-a5e9977b3509@collabora.com>
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
In-Reply-To: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 linux-pwm@vger.kernel.org, linux-clk@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Maurice Hieronymus <mhi@mailbox.org>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External
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

Some drivers derive their configuration from a clock rate and cannot
tolerate the rate changing underneath them. In C, they claim rate
exclusivity with clk_rate_exclusive_get(), after which the clock
framework refuses rate changes from other consumers until
clk_rate_exclusive_put() is called.

Add ExclusiveClk<T>, which takes a Clk<T> in any state and holds rate
exclusivity until it is dropped. ExclusiveClk::new() calls
clk_rate_exclusive_get(), and dropping the ExclusiveClk or calling
ExclusiveClk::into_inner() calls clk_rate_exclusive_put().
ExclusiveClk dereferences to the Clk<T>, so the rate can still be read
and changed through it. Since a Clk cannot be cloned, the ExclusiveClk
is the only handle to the consumer that holds the exclusivity.

pwm-th1520 is the first user, in the next patch.

Co-developed-by: Maurice Hieronymus <mhi@mailbox.org>
Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/clk.rs | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/rust/kernel/clk.rs b/rust/kernel/clk.rs
index e2587c613182..8d7ba0fae459 100644
--- a/rust/kernel/clk.rs
+++ b/rust/kernel/clk.rs
@@ -846,6 +846,106 @@ fn drop(&mut self) {
             unsafe { bindings::clk_disable_unprepare(self.clk.as_raw()) };
         }
     }
+
+    /// A [`Clk`] with exclusive control over its rate.
+    ///
+    /// While an [`ExclusiveClk`] exists, no other consumer of the same clock
+    /// may change its rate. The rate can still be changed through the
+    /// [`ExclusiveClk`] itself, which dereferences to the [`Clk`] in its
+    /// current state.
+    ///
+    /// The [`Clk`] is moved into the [`ExclusiveClk`], and a [`Clk`] cannot be
+    /// cloned, so only the [`ExclusiveClk`] refers to the consumer handle that
+    /// holds the exclusivity.
+    ///
+    /// # Invariants
+    ///
+    /// `clk_rate_exclusive_get()` has been called on the wrapped [`Clk`], and
+    /// the matching `clk_rate_exclusive_put()` has not been called yet.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::clk::{
+    ///     Clk,
+    ///     Enabled,
+    ///     ExclusiveClk,
+    ///     Hertz,
+    /// };
+    /// use kernel::device::{
+    ///     Bound,
+    ///     Device,
+    /// };
+    ///
+    /// fn lock_rate(dev: &Device<Bound>) -> Result<ExclusiveClk<Enabled>> {
+    ///     let clk = Clk::<Enabled>::get(dev, None)?;
+    ///     clk.set_rate(Hertz::from_mhz(24))?;
+    ///
+    ///     ExclusiveClk::new(clk)
+    /// }
+    /// ```
+    pub struct ExclusiveClk<T: ClkState>(Clk<T>);
+
+    impl<T: ClkState> ExclusiveClk<T> {
+        /// Takes exclusive control over the rate of `clk`.
+        ///
+        /// No other consumer of the clock may change its rate until the
+        /// returned [`ExclusiveClk`] is dropped or [`ExclusiveClk::into_inner`]
+        /// is called. This may sleep.
+        ///
+        /// Equivalent to the kernel's [`clk_rate_exclusive_get`] API.
+        ///
+        /// [`clk_rate_exclusive_get`]:
+        /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_rate_exclusive_get
+        #[inline]
+        pub fn new(clk: Clk<T>) -> Result<Self> {
+            // SAFETY: By the type invariants of `Clk`, `clk.as_raw()` is a valid
+            // argument for `clk_rate_exclusive_get()`.
+            to_result(unsafe { bindings::clk_rate_exclusive_get(clk.as_raw()) })?;
+
+            // INVARIANT: `clk_rate_exclusive_get()` succeeded, and the matching
+            // `clk_rate_exclusive_put()` is called when the `ExclusiveClk` is
+            // dropped or consumed by `into_inner()`.
+            Ok(Self(clk))
+        }
+
+        /// Releases the exclusive control over the rate and returns the [`Clk`].
+        ///
+        /// Equivalent to the kernel's [`clk_rate_exclusive_put`] API.
+        ///
+        /// [`clk_rate_exclusive_put`]:
+        /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_rate_exclusive_put
+        #[inline]
+        pub fn into_inner(self) -> Clk<T> {
+            let this = ManuallyDrop::new(self);
+
+            // SAFETY: By the type invariants, `clk_rate_exclusive_get()` was
+            // called on `this.0` and not yet balanced, so this balances it.
+            unsafe { bindings::clk_rate_exclusive_put(this.0.as_raw()) };
+
+            // SAFETY: `this` is wrapped in `ManuallyDrop`, so the `Clk` is moved
+            // out exactly once and the `Drop` of `ExclusiveClk` does not run.
+            unsafe { ptr::read(&this.0) }
+        }
+    }
+
+    impl<T: ClkState> Deref for ExclusiveClk<T> {
+        type Target = Clk<T>;
+
+        #[inline]
+        fn deref(&self) -> &Clk<T> {
+            &self.0
+        }
+    }
+
+    impl<T: ClkState> Drop for ExclusiveClk<T> {
+        #[inline]
+        fn drop(&mut self) {
+            // SAFETY: By the type invariants, `clk_rate_exclusive_get()` was
+            // called on `self.0` and not yet balanced, so this balances it.
+            unsafe { bindings::clk_rate_exclusive_put(self.0.as_raw()) };
+        }
+    }
 }
 
 #[cfg(CONFIG_COMMON_CLK)]

-- 
2.56.0


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C71FF8850
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 23:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A16D10F704;
	Fri, 24 Apr 2026 23:39:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="BilPlTqx";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5466410F700
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 23:39:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777073979; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bTWFR9b1Maajyig2bnrJDLyy1SRT1hr4JhYM9HFH2mSIoRf/uQspZXkJKWwGm8JL188H0M9Yb9u0Mh248EYkSg9xWh43LZP7KiJ6+qZMpBsQZYEmRC41n0R58OkYwdPqDCr8F2K1fTlFECDvsOEqXgDzzhg8jkt49rRRNgEFWTY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777073979;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5104ZL/UD84fKWl1xO0y4+gtbwMaxDVZNsIrKYAj+HM=; 
 b=eDLDJyARmsBy7sYYuQTOcHVlwCMrLhDMtDA4yNaWNMoWN5mkRSYpuCoV4jExTQ+Sfbmy2t3WYRy+AhHARzidn0QgEH2QRq+jZLPAIF8w2jjJNcvtoC+W1dVPmReev0WjcoCTA48jBm4JtBqaTdFgQ7Nn4ajPpJccgGNLkH/Etw0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777073979; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=5104ZL/UD84fKWl1xO0y4+gtbwMaxDVZNsIrKYAj+HM=;
 b=BilPlTqxbM03rm4/ozAsqLwQtegkdFnDpIJPMJIVXri15ZGCdaCdU+SFriwpBaiN
 SzmkISTO7wGadThcGQgaHS5PVfHn8cj6wfKbPdfN0r7Wwi/8civHFNQmmxsDnoqYa3E
 GUKiZuZJzQmlryK8Jt2uUtdGqyFgIItLQt1i36eM=
Received: by mx.zohomail.com with SMTPS id 17770739782601018.8985429837189;
 Fri, 24 Apr 2026 16:39:38 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Fri, 24 Apr 2026 16:39:13 -0700
Subject: [PATCH v4 19/20] rust: time: add arch_timer_get_rate wrapper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-b4-fw-boot-v4-v4-19-a5d91050789d@collabora.com>
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
In-Reply-To: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com, 
 work@onurozkan.dev, alvin.sun@linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1840;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=Us2KrnXBRXPkm3Gy46S9wxzhbXrZpWEq7QojHZ2oB04=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJmv/ysUKf/2uyjym6PaT0Rzgdp5v9gfbuWz/adfeDxXL
 CUu0lW2o5SFQYyLQVZMkeWsvVGPeNV7I935/5th5rAygQxh4OIUgIlcVGdkeHHf0FZgTmlO/alY
 NYfkd36Pp4ttc/kQ4KK43kB8bkirLSPD7Qebbtk1ZnWePrpM+eksJvGELi8+JlvxUi+tXvbPe17
 wAwA=
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

Provide a safe Rust wrapper for arch_timer_get_rate().

The underlying C helper returns 0 when the ARM architectural timer
is not available or not yet initialized. Map this to Option<u32> to
make the absence of a valid rate explicit to Rust callers.

This allows Rust drivers to query the system timer frequency and
select appropriate time sources when programming hardware timeouts.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 rust/kernel/time.rs | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 6ea98dfcd027..03ce96450fc8 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -359,6 +359,35 @@ fn div(self, rhs: Self) -> Self::Output {
     }
 }
 
+/// Returns the ARM architecture timer frequency in Hz, if available.
+///
+/// This function queries the system-wide ARM architecture timer frequency.
+/// The architecture timer provides a consistent time source across all CPU cores.
+///
+/// Returns `None` if:
+/// - The ARM architecture timer is not available (`CONFIG_ARM_ARCH_TIMER` not enabled)
+/// - The timer rate is zero (not initialized)
+///
+/// # Examples
+///
+/// ```
+/// use kernel::time::arch_timer_get_rate;
+///
+/// if let Some(rate) = arch_timer_get_rate() {
+///     // Use `rate`.
+/// }
+/// ```
+pub fn arch_timer_get_rate() -> Option<u32> {
+    // SAFETY: The C API is available in all configs; when CONFIG_ARM_ARCH_TIMER
+    // is disabled, the header provides a stub returning 0.
+    let rate = unsafe { bindings::arch_timer_get_rate() };
+    if rate == 0 {
+        None
+    } else {
+        Some(rate)
+    }
+}
+
 impl Delta {
     /// A span of time equal to zero.
     pub const ZERO: Self = Self { nanos: 0 };

-- 
2.53.0


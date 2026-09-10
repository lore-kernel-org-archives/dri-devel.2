Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8177DC79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFBA410F392;
	Thu, 10 Sep 2026 09:01:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IJ+XqesX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3239D10F3A2
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:01:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 80051601F0;
 Thu, 10 Sep 2026 09:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEF11F00898;
 Thu, 10 Sep 2026 09:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789030872;
 bh=s7S7XXrE3nWzY3ONCdrsA6SEjg/y++hz7JJ/gIuPEcM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=IJ+XqesXeR3rwnE8YiSGAMy74CDSFRf2vn9CkYC94FFki3qkJju9gP347J8asQYy1
 Ba4hgpuYSs1N56xySaWeWTdoWQLbFuJf3QU0GE2gD//1hacXnchFL+XZyvbRWckVud
 43sG/uMibp+/HuD70PSFtTf+xbxQVPfiBghz7yXppW+a0mFJck0q0ErSG4AKF4+lvF
 0vsVu83SO6vFPFQOsm+r2wtgEisrUEHNUgPza4UklC7aewEaRRYDHU/lX2LBcIS0EH
 tg9wd9zfGWKo6QLeDt2BSO+Vm3gjyr81Onnwto6R/eTQNwDvJtKQklRZ987kcoS4It
 w4akeFg8drFyw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 10 Sep 2026 11:00:12 +0200
Subject: [PATCH v21 8/9] rust: page: add `from_raw()`
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260910-unique-ref-v21-8-e83257373062@kernel.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, Ira Weiny <iweiny@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Ira Weiny <iweiny@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-usb@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=a.hindborg@kernel.org; 
 h=from:subject:message-id;
 bh=qsvOsH5eJ/6SOy/kG5D1q9n3SKwDVeax/chnlBoc3Xo=; 
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqonGoab6vY8s20eqgiCSmL4uGzV7sGy2smNjbZ
 wuNFu6zRxGJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaqJxqAAKCRD6UCkIqsW9
 0P2ED/4y0eQDwdjf1HYThRZR1AGuMa3kPD5Z55q5tNW5zGzFQWEjGOPwoKokVlha/nFjzxaddX+
 REzqMGWyTOcbuX/SXoeDCy0OhknY/kwnhAsS+xJxaARcFVrwakURX9JQs91mLwqDYGSNHC20cFy
 U+YgPREcQJVQzzJAGyOK/2PCUqC0bDxTjUWVdtTIV6RMUE7U89ulN79TUItTzt4bjrw4IpFCY6U
 sTBgSAf3wfNHkKD5JazKA3TyWPREJUNfqTAdSIz+f/hTa1qbLHcRQlL93CFB+9FmUxVCcCiaD4s
 q1z82eE61CdMs6UWpHhYDll19pW6abxVa5iNqq+WNxz2QYfYhOCzc4es7H+PiT+CbxrSaFTImWk
 x+XNqAwXFQ10L2uHjklUOUIcJ6KAmrBeXazqL/6UgXMRe8ISncWYSC9nAnITCrtOOr/puGiEF1E
 m5zLFhTnvBu7N0872U1cJqrESNiReM4HckNcw5GEOH9xOHRcoM2tI7B+gnogw7atqjMmWVEneMv
 6v/v0CDDBmwj1/jjMupa8FRmoz9xr3zMIOZMZVYMz7AtueK6DiKX5Rbg8srWyL7FalAf4ifRHJG
 i1JpqOo/KpwQCCRSzIlJYJw/LSWKs6dcfoLoD09ol2jQkAsfpqkEERGE/JQO8mlhgHR6VNnOdL6
 gKJ8ZCKmAm5v1mg==
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

From: Andreas Hindborg <a.hindborg@samsung.com>

Add a method to `Page` that allows construction of an instance from `struct
page` pointer.

Assisted-by: LLM
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/page.rs | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index a2610774c749..cd394b0656c0 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -146,6 +146,20 @@ pub fn nid(&self) -> i32 {
         unsafe { bindings::page_to_nid(self.as_ptr()) }
     }
 
+    /// Create a `&Page` from a raw `struct page` pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be convertible to a shared reference with a lifetime of `'a`.
+    #[inline]
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::page) -> &'a Self {
+        // INVARIANT: By the function safety requirements, `ptr` refers to a valid `struct page`, so
+        // the returned reference upholds the type invariant of `Page`.
+        // SAFETY: By function safety requirements, `ptr` is not null and is convertible to a shared
+        // reference.
+        unsafe { &*ptr.cast() }
+    }
+
     /// Runs a piece of code with this page mapped to an address.
     ///
     /// The page is unmapped when this call returns.

-- 
2.51.2



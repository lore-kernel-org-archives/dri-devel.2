Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82324CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0EAA10F22A;
	Thu, 25 Jun 2026 10:17:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DguMuLTX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8F5C10F229
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:17:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4699E600C3;
 Thu, 25 Jun 2026 10:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BFA1F000E9;
 Thu, 25 Jun 2026 10:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782382631;
 bh=9MHwt/piGbHaBX1U0Ciw0A9tLdy3GnbZtG5V2/pNbH0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=DguMuLTX6L0L9KuizfWkxAATMIlyA8bPMmMhC8BLL5WNrKQrhn2s69icAqPZlU8CB
 MZViieMuMIAOD3zQ+7RUEHnP9UOboSusmrhpgnnPDi7JR+O6QfvIZQ57gIQiHb62jE
 Nwk3bgsrKfVAp+6+11oFIJmaMdmzmis/5ta5bpAqI/DbYoZDFXZ9Dqm9mhKkgTkPe6
 MweoEk+qHsmyJmKiQfT0OybItJ7gYGadhXss5p8tUZ5GPGxlo0ZR1dNWPVSTIWuKWr
 18PnqnWvF5WkYUecXh0qp7EC2AdHh6YlabpOUSeBf+LIZPfQiG9f2uQoRYWqcdfbif
 uOGhTKvuG6bjw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 25 Jun 2026 12:15:03 +0200
Subject: [PATCH v18 1/8] rust: alloc: add `KBox::into_non_null`
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-unique-ref-v18-1-4e06b5896d47@kernel.org>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
In-Reply-To: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
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
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Igor Korotin <igor.korotin@linux.dev>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1170; i=a.hindborg@kernel.org; 
 h=from:subject:message-id;
 bh=L57zDm7ALp0lZWMW+Cln/Gg2DuJozYQVYKA2SZ2s83c=; 
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqPP++uGgipwDjCmHpaSqUlxoMDKEvVyu3KGUE8
 sF7dvt/kIeJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCajz/vgAKCRD6UCkIqsW9
 0OiUEAC23l5hDLZ2AuUND5t/t+H3AC8vmplyBqcaI+ow/2SaKVzdc1lyzdq4J7C6GMb0Y8e27gN
 9/CIBdb7+/iggRB4jlvgyNKw0MeOj5mQe4qelvVp/Igl1sZDKylK2dLNoET94fZhA7VGjj/MlaK
 C+FiEPIwA9f/hmhnwQLzRqFo+G+tVnlh2g9pFi22EjIm3Vj6msOoRII5IO7/cz1Af/c5gNDY5A4
 tcLI3I5QgittUsRXPFMXz8G6Tpbw2HhBBoHVwtgK6GfMW1p9QCdkV0Wp8EV9Juw5vTWWDcPBXk0
 dLoL0TbzDLu5j7iFZGYd9HsalVbC/9+5PGtFQ1F/LkkEFYG6LM1+Gi1x0gKDtaFXbrNUBOrAjTe
 RWKW27ov//tZM27MrU9+9t0QhGN/Toy36zkfg8FL2idqfWXVFAHmsiTPtjyz4hwXkxLsHR99l1G
 0vp6LOc6K5vKriRm7OK0jD1sJVoATw87WQ13c6UOEq1Lp0NiH+GWVLf24rMrFuWjJCbA8m2cpnA
 rVZVBJ8Cb71JxcAyqLY5RKGmdg+o2khQ9dg8qcu2ikmrnqrhggwhHT7TQOZytz3qmg66SQMyQr/
 wySTYLpOuuXwx3AdiXxYAOyCy77nmGLgOTMyjyNVdCnlQlEaCLkiQQqRT+UiOoC0EijnKjc9QnO
 Z5+1TTt3znsVIIw==
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

Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
is a convenience wrapper around `Self::into_raw` for callers that need
a `NonNull` pointer rather than a raw pointer.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/alloc/kbox.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 35d1e015848dd..d534e8adcf7b3 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -211,6 +211,15 @@ pub fn leak<'a>(b: Self) -> &'a mut T {
         // which points to an initialized instance of `T`.
         unsafe { &mut *Box::into_raw(b) }
     }
+
+    /// Consumes the `Box<T,A>` and returns a `NonNull<T>`.
+    ///
+    /// Like [`Self::into_raw`], but returns a `NonNull`.
+    #[inline]
+    pub fn into_non_null(b: Self) -> NonNull<T> {
+        // SAFETY: `KBox::into_raw` returns a valid pointer.
+        unsafe { NonNull::new_unchecked(Self::into_raw(b)) }
+    }
 }
 
 impl<T, A> Box<MaybeUninit<T>, A>

-- 
2.51.2



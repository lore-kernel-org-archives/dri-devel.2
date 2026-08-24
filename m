Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE462C61CE2
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B8A10E72F;
	Mon, 24 Aug 2026 11:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cvBIFLRA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6E8B10E72F
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:19:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F47D42ADB;
 Mon, 24 Aug 2026 11:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12E71F00A3D;
 Mon, 24 Aug 2026 11:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787570389;
 bh=vL9knM2sUgbCQ85ffU5z6/s6VECuwJ6C1a0TUUfpb00=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=cvBIFLRAcda2SZw/JlrD6tOLwNfKcnVd5E0WZoutY+y8hwmHZ/O/6Ev8gSNNOk796
 R9vzEKuzdU0JQlwzbt/QCuq/vSRRoGFOgPbM7S8qMbmJ31pomA9Bx0DwWWtdXzPlcJ
 bjqOkSYxUEiNaBuOeH/wCMIyUw00fVSUWBMUKNuSXr6xs7IYK90q3cYemRq+iSN3Lp
 5axDKiwZnhzf+2oCzUZiWtQn6Kack0hljwkugFf8B+PubZOZIRefgqHcsw1k1iK5TA
 pDNaW/raJJsv5Pm3utpa3a0gclsIoz8iz81EkexgcN3hfv/tI6cRuS9m/tkdjkhWCO
 XETF1EOKtNWPw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 24 Aug 2026 13:17:58 +0200
Subject: [PATCH v20 6/8] rust: Add missing SAFETY documentation for `ARef`
 example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-unique-ref-v20-6-490735672187@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
In-Reply-To: <20260824-unique-ref-v20-0-490735672187@kernel.org>
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
 Ira Weiny <iweiny@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-usb@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1545; i=a.hindborg@kernel.org; 
 h=from:subject:message-id;
 bh=Ze2x5FAumXdrYYXBmcLdm4zoQ8i0F4uXb1KFrUnACjQ=; 
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqjCiF6dh93QL76FsS3p7E0fXhPzyq7P6N7DBZg
 tiDSEuYy0eJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaowohQAKCRD6UCkIqsW9
 0EkxD/0XM2c5th1h+pGWV6+q9sYgp81vNSAgToV6NWXab5X9Q41O3etvl4v1UKRuRknTeiCNln7
 bdnWb7sf1ddcFR8ctDx7tKS1lyYDHeUT/VJzXWcKqQXtyaCjA+VBSZB++jWxz4eN3rfSR7GGLa/
 PYUcrMQb3iNL7Fevrhvf4Tyj3IpFO95jaD1CNRpzQhqi5LFH+Dytg5TPMQLqIumEu4c8+b4t4UN
 eaR+Mvh/nBqPnjt/+0gfZGf9l1GN2VaOKj0BS0ubxibuJizarHIvv+PrZp3iwViSVF+h/SDC7rD
 1ENtCS0a3zosJOc6hENkAzE5dI5c0eOBNs/pTaL+DicoOuNfO+FfTdMUCcuU/hKQ4XUEYrtPAcQ
 2favBhHsZtH/gFr3Yjp19Vim0e/AiN3wVfmUHOHyinDd6vKgAoQEoZSvoDS20gDM58r1hMtN7Nc
 nbYGLRNRRz35IroNM4ReUJZ1u9Jg0MbwAhOQufvDKBPYsqUOoEwdLJyCZnnIZ29b2UQnr/Vzh8Z
 7YPxMftrFJ5plKtEN0l9k4/KUzmhXfm+Le1zc1Lu74+OJHSl69zrN8kJFSPgCIqgPm5T5BL3/8n
 hsRCDyVeRiNXPfeq/4NxDWzlzJzTQbtE7XvlK3N9hl98xNr/tfa9Qfk8IyEcKJwFzzffLjXpFIR
 X6nSbfz4HsnxrIA==
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

From: Oliver Mangold <oliver.mangold@pm.me>

SAFETY comment in rustdoc example was just 'TODO'. Fixed.

Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/sync/aref.rs | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index ea5a16b8163a6..f26ca39b84d0d 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -142,7 +142,9 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// struct Empty {}
     ///
-    /// # // SAFETY: TODO.
+    /// // SAFETY: The `RefCounted` implementation for `Empty` does not count references and never
+    /// // frees the underlying object. Thus we can act as owning an increment on the refcount for
+    /// // the object that we pass to the newly created `ARef`.
     /// unsafe impl RefCounted for Empty {
     ///     fn inc_ref(&self) {}
     ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
@@ -150,7 +152,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// let mut data = Empty {};
     /// let ptr = NonNull::<Empty>::new(&mut data).unwrap();
-    /// # // SAFETY: TODO.
+    /// // SAFETY: We keep `data` around longer than the `ARef`.
     /// let data_ref: ARef<Empty> = unsafe { ARef::from_raw(ptr) };
     /// let raw_ptr: NonNull<Empty> = ARef::into_raw(data_ref);
     ///

-- 
2.51.2



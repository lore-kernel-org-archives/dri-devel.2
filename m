Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DB3C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F1A810F39F;
	Thu, 10 Sep 2026 09:02:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OLZ5B3fu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AEAA10F39F
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:01:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 38F49409E3;
 Thu, 10 Sep 2026 09:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0B21F000FF;
 Thu, 10 Sep 2026 09:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789030919;
 bh=yt5UAGueNm32iTeFR6jcKBb+FhJxYmboaOihvjd/LlU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=OLZ5B3fuSqJeJziVml2J7+SuEmvWItkOgOQyjncwSG2DimnGwv4KyDQJlXLXW5sxM
 nvCLV+4THEj2dC4voriGeaOEl5QiGheN3Z2q+ABMVBOmnvBJ8FuiomSDYgcAkjYXpC
 WmtKW9WFO9JI1P3g0nUTzXvMxX7Fg2E2spCP2GDThib+uN4W2ZmGUi3s7tMBahhhib
 nssJ+bxC5fSWQ5nIEawiqdv8AluaXKDpA29tlDrzi1jNgnhNaksN5SQ2CgBz20IqKC
 z8oV75B01Z2KKl9IwRK3SOYnF1oqFwMJIWTDbyu/FS6hpLcCRVklw5rhUr6Y6iWJ7g
 7BtR/7T+ldmkw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 10 Sep 2026 11:00:09 +0200
Subject: [PATCH v21 5/9] rust: Add missing SAFETY documentation for `ARef`
 example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-unique-ref-v21-5-e83257373062@kernel.org>
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
 linux-usb@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1957; i=a.hindborg@kernel.org; 
 h=from:subject:message-id;
 bh=BNWtmHgpjNUhrCkbsOHEBA7MTI0LVX3SSpIhyT98+Ow=; 
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqonGlMsJOOFdosQ0jUhYoghNsqo0y4sSrnWOtC
 1TQjvbumFuJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaqJxpQAKCRD6UCkIqsW9
 0Cd+D/9nAUfqKWaGoqKv7nfm0hhF9sliL+paN7BmyiCqXpgYuTMfax03XP7wuBLX+p1hrdviAhE
 H1PrBfVWfd3V3zHdCH/GokxiWtF4Uwki/PnMnl8bXFvJby5yN9P2wz1Bzr+ZoeZXdPlcAVwaUYf
 lAZgSE0szcxSq5yZYh5NZ5e1derfpNSOMIS6F/k3KTRFoPA6OpW6thdkVIXZOTacMnm6Gc0ZZW3
 cEKyHvTgntPVD4mYH2VewLR6LRt/3un9vJT2T5oj7/dHNQAaLmguQFggWup1xYA6a65I2dHc7Ol
 9mPIKE0Rc+s8IJMPX7bLzDvoNu/uBR4+qJTEQbtS5fzpYL/VubrnZpOqDkG+WdgWDbHYS29hpv1
 hOaNVXWUzxLlqPWyXJb0Kxq7nMnROnusibYCYRrnu6y588044SLI8D4h+WprDXV5ikecb+C3oVT
 uZbiWr2DcD406Wq9a1ctobdItGN7JO8tuPmepticFVhV3cd9xwr10q29wJ3DNgWY7Z00GxtadFk
 CxEV8zx8CkgTamGEaSpsZns8tdzXSdPz3lC5bnjzKC33CPk8iUrRGERISKT/xET9BJxqZjEAuHU
 tjAeZT75VZmxlGKiT22VwccqR12Y9eQ580MdcvGQVWbtb5BDrxCo6ka0p9YA+acEkL89XEl3Ljw
 4AK7zgNZG4eUFqg==
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

Link: https://github.com/Rust-for-Linux/linux/issues/351
Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Assisted-by: LLM
Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/sync/aref.rs | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index 215e7eb139fa..ae76bd9b6c1c 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -147,7 +147,10 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// struct Empty {}
     ///
-    /// # // SAFETY: TODO.
+    /// // SAFETY: The `RefCounted` implementation for `Empty` does not count references, and
+    /// // `dec_ref` never frees the underlying object, so a decrement cannot invalidate it. The
+    /// // object instead lives as long as the `Empty` value itself, so creators of `ARef<Empty>`
+    /// // must guarantee that the value outlives every `ARef` derived from it (as done below).
     /// unsafe impl RefCounted for Empty {
     ///     fn inc_ref(&self) {}
     ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
@@ -155,7 +158,9 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// let mut data = Empty {};
     /// let ptr = NonNull::<Empty>::new(&mut data).unwrap();
-    /// # // SAFETY: TODO.
+    /// // SAFETY: As the refcount operations of `Empty` are no-ops, we can treat `ptr` as owning
+    /// // an increment on the refcount. `data` outlives the created `ARef`, upholding the
+    /// // liveness guarantee required by the `RefCounted` implementation above.
     /// let data_ref: ARef<Empty> = unsafe { ARef::from_raw(ptr) };
     /// let raw_ptr: NonNull<Empty> = ARef::into_raw(data_ref);
     ///

-- 
2.51.2



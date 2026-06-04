Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52822CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:13:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAB53112994;
	Thu,  4 Jun 2026 20:13:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VkUM5l+n";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CB59112994
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:13:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F247F60103;
 Thu,  4 Jun 2026 20:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4AD1F00898;
 Thu,  4 Jun 2026 20:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780604024;
 bh=ae09fXAF8LItvvmTTJY28TqpTPDPI0l185oWGkC0Czc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VkUM5l+n76eAck1/5L8AuHjDCJQ3zxzdGbIdQNsGNkp9tgvla8OKmviv9XxvDfYxh
 T5CXiuhoOdul1geAz+UtttAtacasQmLMt+dkZ5upH0R+SLnVIpNgsESP8vA5lskv2e
 2eBuAPxWq7RvriIrOBlOS/tkItqOMwkcqthsWouvOY3aTbe8W7fmY79L/SQfGO5PvH
 x3TwFW7uWZC5lmZvv9zPCkT/Jz+dklERyIEaoUevYb6HL61n9X++xzKiYJ6N7oOvaW
 SnNqXruCFaiUzzbufT/a7XLIAx71EwVG4L6EJ5BrJMPgAbd3pWQowvHnrQlrVyNZaf
 aaQMqqE8DhqCw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 04 Jun 2026 22:11:19 +0200
Subject: [PATCH v17 07/10] rust: Add missing SAFETY documentation for
 `ARef` example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-unique-ref-v17-7-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
In-Reply-To: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, 
 Igor Korotin <igor.korotin@linux.dev>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Boqun Feng <boqun@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>, driver-core@lists.linux.dev, 
 Oliver Mangold <oliver.mangold@pm.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1543; i=a.hindborg@kernel.org; 
 h=from:subject:message-id;
 bh=5/8RAK1i9EEm+Mr/ISUqH0yYzAzf/u+vK09Vq8P7sDc=; 
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqIdvsYbmmhUSA1BFXpd4LxLHnLV9ib9fde7UdH
 17um7HAPqGJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaiHb7AAKCRD6UCkIqsW9
 0Nt5EACgOkQIjNes+0YwsSd6rxBD9/YOWxQW20hXwPtAoLhwpn9RDoSA+h4PnOESKPOVrLhGp0Q
 6nSJOo2SKyh4+tb4v+lBXt6nuxEXrO7wpnde2auyMfZz635i27etmDlT/litVdyj0fSGXksN3NU
 oiyshGS1QUb8aHjU+kneBTLgmTBDnsJpS0ZlmB1Z4WUSNySQyXwFBfwMKfd9RBFG2M3Hny10mYK
 J6tGLqG2IivsvXrJ0IAvzvy9hKmvFdeSr/joWbzooS1g7zHZQ0mRDaZBZecMAicHVmk9w7D7/ZU
 cYZ1rVnvZ57bH0MzQrNsigGiRaBVDDoxi2TCGz9xjcIBueLMvIB/LcVTuxc123pQr2cZS8FBsQw
 kDHh1pYRSgAz/5VjCSdNSYCUj4u/isGJptd5igW2nIB62BWy2GG5bCJ3rFJW5srwVKjnG4LA99E
 YnqqS+eO4npLOjXAJPhZDAIJsXWRFKFOktzb8KVF2raNweS5bB13ZZqG6zk8tKJQ4nr99xNBt+x
 4LXjcKQLat/vBvT0r+sOGoTSqyYVlFU+fkky0pdmtCXHib7JSaML7g2b5cGgB6nKrIGZPJcsM17
 fG8VC8R/HCyJwRk/mISYKNh/sCTlIPi6mIi6d+TAC4q1mH4JQR93mRCahJTE/AG72ip4nEwjfHy
 MQA6YfVG5t59F1A==
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
index 2d656f672b97..7491382bcf29 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -137,7 +137,9 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
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
@@ -145,7 +147,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
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



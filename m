Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB49F606A33F
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6YGkIo6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0925610E3BC;
	Mon, 16 Nov 2026 14:22:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEEB910E3BC
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 14:22:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B749243EC0;
 Mon, 16 Nov 2026 14:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35181F000C6;
 Mon, 16 Nov 2026 14:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794838924;
 bh=9998Op+ciK4KzNkfg/cHkmiaE6KVNwv+CiIQ7yuk35I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=U6YGkIo6jSIx0cKZbIhjwuEgIIlJTCZggyc7Z8QV1XUlyRujA+fOfTj05QIdFvjmc
 1GPlHh0WYwXiceAt5e+EOb4TWlJ+ekRtWUEIYD37Ry4cG1eM3BBsusAQmgNbH/nwwg
 J/pDQnGW6254ZHslJYec2SF27t3v0Zu3mhyEkgA/Fj+QnlisuY9EZqeFnEhdKqqEUD
 0HdO6MGaCIEyx7ukZYHcJ7spKtuVXByl9n84BG0R98l2e8HuWNmtkQ+Vl4IgfLdUWQ
 YGpwfzqTqS6+oPT6wB/Kg6uws6N87/tmxHVLz/vMiKNzHHdYnFIi9Pgs3kQ6f2gjXt
 Ez1w8IoBWY5ng==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 16 Nov 2026 15:20:58 +0100
Subject: [PATCH v22 1/5] rust: alloc: add `KBox::into_non_null`
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-unique-ref-v22-1-12029383206d@kernel.org>
References: <20261116-unique-ref-v22-0-12029383206d@kernel.org>
In-Reply-To: <20261116-unique-ref-v22-0-12029383206d@kernel.org>
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
 Christian Brauner <brauner@kernel.org>, 
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
 Johan Hovold <johan@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Dave Jiang <dave.jiang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Saeed Mahameed <saeedm@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Markus Probst <markus.probst@posteo.de>, Ira Weiny <iweiny@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-serial@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=a.hindborg@kernel.org; 
 h=from:subject:message-id;
 bh=nnq/EApvqpnDipb7ZMMGHyUc30IDlzBw/XCY2d2nR2I=; 
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBq+xFRqMYICGBG+ejnnQrHCo2Qiew0xJ4tKwFW5
 FAStlInHLGJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCavsRUQAKCRD6UCkIqsW9
 0MiMD/9Q8HebKQyWtVT3j+58+5Dz3Y1m3kT35wm3KPbPB7t0UAJ7ogziU0L97LGVruRRB34TcTu
 1CXyHSibnht9sqUnd3frpfwAILOszsx3O5g92cMyi6dAOnpfwgYfsJrgS76YDxIMSs6hzhbW0b0
 ZdTb2ogrtqwYoTSFPq9Yq8Y6Aae/klTsQZ+5zhYq9x/i6eeksYBRrAAthMHU38+eNUbptna92Fg
 EzSDCS1x4Lh0+8XysAAabbtvDCcs0rppOnCBCF99huGij8Uru81TKzD5FSbmYo2OinEXo6ctGxq
 +E7p7ZXvkQgf86OcwY6ZIgpDBHrtcE9x0rFxcIptzBzj0JJOEzWA8iRUoQrzBgdNXbE2PeEe9Vi
 ZpClcdgUNxB23pKbt8fj1tC/ohlfz563sEfVMmOBFp9z+4GLRtI1e3iQur4L+mDabf6kJPtfUHb
 EHJvSgpc+mdZAv0AXN0TE6romZIfZzrcJNDWVgOrEBEXYh20BpHI1Vyr6KM+eDa/u7fWNkhfKAF
 2X+DzyfE/T9n55HpdJUdtE7HxKbJ6oMkeTRrviQjc6Qfd02CAM+g/mAybG5yMMJrCGm4hCC1AGr
 gWM3HjZl5l241jl1zkJkDbw2N1pUvs2AavWjD34YQP7A+Bw2GSakJGIeQgVdVGd4rK9bU3AeBbU
 hfprB7+xbLZOC0A==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
is a convenience wrapper around `Self::into_raw` for callers that need
a `NonNull` pointer rather than a raw pointer.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Acked-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc/kbox.rs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 2c929eb1c3d6..7e8ce3b36673 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -211,6 +211,15 @@ pub fn leak<'a>(b: Self) -> &'a mut T {
         // which points to an initialized instance of `T`.
         unsafe { &mut *Box::into_raw(b) }
     }
+
+    /// Consumes the `Box<T, A>` and returns a `NonNull<T>`.
+    ///
+    /// Like [`Self::into_raw`], but returns a `NonNull`.
+    #[inline]
+    pub fn into_non_null(b: Self) -> NonNull<T> {
+        // SAFETY: `Box::into_raw` returns a valid pointer.
+        unsafe { NonNull::new_unchecked(Self::into_raw(b)) }
+    }
 }
 
 impl<T, A> Box<MaybeUninit<T>, A>

-- 
2.54.0



Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF3EC531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93A0E10F08B;
	Thu, 23 Jul 2026 10:31:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="pT1dmZqm";
	dkim-atps=neutral
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD2B510F08B
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:31:04 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4955d314945so3777505e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 03:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1784802663; x=1785407463;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Mqgqzxkhdx1tnyQjzJPVNW/eINwechdkO4hcnTDq4+o=;
 b=pT1dmZqmM/A+kAOgbqXKON9t8iDGfyeTAwMrd7cH6+y55zZQVACFQg6QZioy+kHJh7
 KZ3/fmIvjgt9e1v4RIJheo1tmaEjK7BGUND67Gf5XYgAXZJ6F/duljz7QfM7RctPmCrB
 EpDmXMa9yFTUJtIEIsh5NcFLaHH3MukOn9O01HRC3ZNkE8yhpdQjJReLybrLi9R2SfsI
 LcEpXTUdkSsXPeEjYc8BMY6wYMqIrNrsKj0rsjcOHMPWTstJBpFiRqrANjKVih/uNnzg
 PwGHD8uzC+/IByrziO5ovvSe9mAQyU+szqt/8YgfKjCv56WWgb2D0uaQcLVER6oEQVhL
 cWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784802663; x=1785407463;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mqgqzxkhdx1tnyQjzJPVNW/eINwechdkO4hcnTDq4+o=;
 b=e0kvPkbdp5H5ew9YLEfWY5doSbApJR3TPXXjzIiLXxEgPIbTufK+JkdtH7lth4zJ5p
 nZvriVkpvx6Snnuz6zt+fIF/7Y0gq+aL8xpTdmn/w6Bg2SgdURygMeu9CS2V+cuiv0fm
 OGTdhuREWPg5NMP5KhNfOIHI8Vo+68QlWVdZFVJRaldV82KrXdh/5KgOWo2/jyejShkk
 098Bo8wdAYhHb5xwVXXbP6VzMqp4UFzjPNN6e+icsgs2ok41om9Gii3cB6XcqKGVN0b9
 Mzp7ueoNRnraLSLyGpx9q/eNhpAReGBh8Y8a/+ncz7iFk0YOYAGGb0TuR1UMhUnUGU+P
 KkOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmK61vpe+infpRMI7rftMODd+3+GR23tDOE2J4Py1XmvkahXRlqCRDqeMN6M6JCArBdWLx/7ZDkq0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwiNPHNRuNg/ipnT5UeyM093pEuaX+BdIx7Xwqv27PMG4/cqORr
 fMu3evoU7fCoVroeOoSV9B4lDp8horxuB+59lZX80Qnd41rKJJddIO6z0tS3VvUuedOA+foTWuw
 oU+EZ6kYdIzfYy3xDXw==
X-Received: from wmbjj16.prod.google.com
 ([2002:a05:600c:6a10:b0:495:5422:15f2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e89:b0:495:63e4:7f78 with SMTP id
 5b1f17b1804b1-49573ccd115mr30916405e9.10.1784802662821; 
 Thu, 23 Jul 2026 03:31:02 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:31:01 +0000
In-Reply-To: <20260723-chid-v2-2-c35e5e9fb3d9@nvidia.com>
Mime-Version: 1.0
References: <20260723-chid-v2-0-c35e5e9fb3d9@nvidia.com>
 <20260723-chid-v2-2-c35e5e9fb3d9@nvidia.com>
Message-ID: <amHtZeAl3VFsibE1@google.com>
Subject: Re: [PATCH v2 2/4] rust: bitmap: add contiguous area operations
From: Alice Ryhl <aliceryhl@google.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Burak Emir <burak.emir@gmail.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
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

On Thu, Jul 23, 2026 at 05:59:11PM +0900, Eliot Courtney wrote:
> Add bindings for area operations on bitmaps. Each one is
> made safe by adding some extra checks compared to the underlying C code
> (for example, checking bounds) and with additional checks to catch
> likely erroneous usage if `CONFIG_RUST_BITMAP_HARDENED` is on.
> 
> The C code uses signed integers for some parameters, for example the
> length for `__bitmap_set`, so bounds check against i32::MAX. We can't
> rely on `BitmapVec::MAX_LEN` because `Bitmap` may not necessarily be
> backed by `BitmapVec`. There's also a few cases where an `align_mask`
> can cause an infinite loop in the C code: masks that are not a power
> of two minus one, and masks where `self.len() + align_mask` overflows
> the alignment step, so check for those.
> 
> Add tests demonstrating the edge cases.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  rust/kernel/bitmap.rs | 217 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 217 insertions(+)
> 
> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index a43bfe0ec3dc..1395bbe99cbb 100644
> --- a/rust/kernel/bitmap.rs
> +++ b/rust/kernel/bitmap.rs
> @@ -497,6 +497,127 @@ pub fn next_zero_bit(&self, start: usize) -> Option<usize> {
>              Some(index)
>          }
>      }
> +
> +    /// Finds a contiguous area of `nbits` zero bits at or after `start`, aligned per `align_mask`.
> +    ///
> +    /// Returns the bit index of the start of the area, or [`None`] if no such area fitting in
> +    /// the bitmap exists or the `align_mask` is invalid.
> +    ///
> +    /// `align_mask` should be `0` (no alignment) or one less than a power of two, in which case the
> +    /// returned index is a multiple of that power of two. Masks such that `self.len() + align_mask`
> +    /// overflows are checked and considered invalid, as they can hang the underlying C code.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `start` is out of bounds or
> +    /// `align_mask` is invalid.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
> +    /// use kernel::bitmap::BitmapVec;
> +    ///
> +    /// let mut b = BitmapVec::new(64, GFP_KERNEL)?;
> +    ///
> +    /// assert_eq!(Some(0), b.next_zero_area(0, 8, 0));
> +    /// b.set(0, 5);
> +    /// assert_eq!(Some(5), b.next_zero_area(0, 8, 0));
> +    /// assert_eq!(Some(8), b.next_zero_area(0, 8, 7));
> +    /// assert_eq!(None, b.next_zero_area(0, 65, 0));
> +    /// # Ok::<(), AllocError>(())
> +    /// ```
> +    #[inline]
> +    pub fn next_zero_area(&self, start: usize, nbits: usize, align_mask: usize) -> Option<usize> {

Instead of using a `usize` argument, it'd be ideal to use the Alignment
type defined in rust/kernel/ptr.rs, since it is guaranteed that the
contained value is a power of two, so you can omit all those checks.

(Since you need a mask, you'll need to subtract one from the provided
Alignment, but that should be fine.)

Alice

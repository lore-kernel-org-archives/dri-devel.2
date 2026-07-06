Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33F6C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 17:22:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37FD410EA03;
	Mon,  6 Jul 2026 17:22:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Z88SwoGs";
	dkim-atps=neutral
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com
 [209.85.221.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E617910EA03
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 17:22:01 +0000 (UTC)
Received: by mail-wr1-f74.google.com with SMTP id
 ffacd0b85a97d-475eba52438so2504783f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783358520; x=1783963320;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ltyx4avvqap+Z6tBDQrFmfqB8UZWvDnSqPOqoXvmQP8=;
 b=Z88SwoGsY+B/+DCdG7+7N5vcddaZFyXXOVvC+RVO0FEudSpvBubl6fDvdcbIQviH+Z
 8UYyuPWTwIexWZWJzAnHLzwlAEV/VndzlCsaDUsP0wJ3eUS9PQsAFJgZ0darHPmkyBqM
 knOkK541ewkMKOkobY+YFUKD0CEr5x+eOJqOL9t9N0nPGu3iUGQZ1p31sby2Ub86pBRx
 SMgTn1jtyfG2FEXuCB5ie1sozVB0eJSv/VMsPQC7AOA2E8qKKYiUezc7HIXrJ6hivtYA
 IcnQLGQJt/qAaBXtyKWeaUpZPSOMMEpBAEAV6aZUNao+aHZMWeMxsyFffggqIwMX0tiO
 D3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783358520; x=1783963320;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ltyx4avvqap+Z6tBDQrFmfqB8UZWvDnSqPOqoXvmQP8=;
 b=Lop84u+EUjfc+NSz5sG9auDQpp48j/vWckXcaHVkLjdcjyuhFFs0/qge2MFLHrVVuQ
 88LQvNnM4MbrRrL83FzW7UkK7wOv9AZ4JYy/7S4Z86omJvG67k99H4LKKzREDwidO6Qd
 WZj4iwVcrIL2Z0ZYtZ0/Nn3tqaugzNJG6WQwkwUQO3UIDnYJJWsIvlUCvehcNiuyAZIN
 q2mvT4ZLLHMw8OQRO+YztoNSO3uR9dmjVSsyVcMQpAN3CEUURBWp93Q6JIgc7H7OZALT
 sTuORX3gb3Eyy45VT7goErntJmCa6uwHoQ69AYzsH57ha0PGKoyIKmTf3JaEoN11AaOA
 klHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYPFy0sr3X9J8o6HhS7lqslafR/cBmGmr4Uy2ZVxvAVwcDnBp3i/rLj/gIdQyg8I6OLwRNqLN6g2Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgsS8bTuH37BLkt7v/K2bGLj/oyujfUxP2UfEYmOfvLU/I/XLr
 5lvzjsB+awemVh0mElGHc7cydBWiWZtSXespQvraCOuhrcGWLnmLg7grASRmYxPZ6yP7mQOHk8I
 w1Cmznm1PlZ/55/YRzg==
X-Received: from wmri23-n2.prod.google.com
 ([2002:a05:600c:8a17:20b0:493:d884:f722])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6692:b0:493:ca3a:d738 with SMTP id
 5b1f17b1804b1-493df055a84mr19308675e9.7.1783358519892; 
 Mon, 06 Jul 2026 10:21:59 -0700 (PDT)
Date: Mon, 6 Jul 2026 17:21:58 +0000
In-Reply-To: <akvXzPd169ahMuCi@yury>
Mime-Version: 1.0
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
 <20260703-chid-v1-2-84fe8259e46e@nvidia.com>
 <akvXzPd169ahMuCi@yury>
Message-ID: <akvkNuh2bHhFwmQM@google.com>
Subject: Re: [PATCH 2/4] rust: bitmap: add contiguous area operations
From: Alice Ryhl <aliceryhl@google.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Eliot Courtney <ecourtney@nvidia.com>, Burak Emir <bqe@google.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
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

On Mon, Jul 06, 2026 at 12:29:00PM -0400, Yury Norov wrote:
> On Fri, Jul 03, 2026 at 07:16:05PM +0900, Eliot Courtney wrote:
> > Add bindings and helpers for area operations on bitmaps. Each one is
> > made safe by adding some extra checks compared to the underlying C code
> > (for example, checking bounds) and with additional checks to catch
> > likely erroneous usage if `CONFIG_RUST_BITMAP_HARDENED` is on.
> > 
> > The C code uses signed integers for some parameters, for example the
> > length for `__bitmap_set`, so bounds check against i32::MAX. We can't
> > rely on `BitmapVec::MAX_LEN` because `Bitmap` may not necessarily be
> > backed by `BitmapVec`. There's also a few cases where a non power of two
> > minus one `align_mask` can cause an infinite loop in the C code (can
> > happen on overflow), so check for that.
> > 
> > Add tests demonstrating the edge cases.
> > 
> > Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> > ---
> >  rust/helpers/bitmap.c |  22 +++++
> >  rust/kernel/bitmap.rs | 219 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 241 insertions(+)
> > 
> > diff --git a/rust/helpers/bitmap.c b/rust/helpers/bitmap.c
> > index e4e9f4361270..dac5c03f2448 100644
> > --- a/rust/helpers/bitmap.c
> > +++ b/rust/helpers/bitmap.c
> > @@ -8,3 +8,25 @@ void rust_helper_bitmap_copy_and_extend(unsigned long *to, const unsigned long *
> >  {
> >  	bitmap_copy_and_extend(to, from, count, size);
> >  }
> > +
> > +__rust_helper
> > +unsigned long rust_helper_bitmap_find_next_zero_area(unsigned long *map,
> > +						     unsigned long size,
> > +						     unsigned long start,
> > +						     unsigned int nr,
> > +						     unsigned long align_mask)
> > +{
> > +	return bitmap_find_next_zero_area(map, size, start, nr, align_mask);
> > +}
> > +
> > +__rust_helper
> > +void rust_helper_bitmap_set(unsigned long *map, unsigned int start, unsigned int nbits)
> > +{
> > +	bitmap_set(map, start, nbits);
> > +}
> > +
> > +__rust_helper
> > +void rust_helper_bitmap_clear(unsigned long *map, unsigned int start, unsigned int nbits)
> > +{
> > +	bitmap_clear(map, start, nbits);
> > +}
> 
> All three are the wrappers around the regular outline functions:
> bitmap_find_next_zero_area_off(), __bitmap_set() and __bitmap_clear().
> 
> The inlined version in headers is optimized for small bitmaps. But the
> optimization is all based on inlining in the C code. It doesn't work
> if you wrap it with a rust helper.
> 
> There was a discussion about the similar find_next_bit(). The function
> itself is an inliner, but it's a wrapper around the true outlined
> _find_next_bit(). So we decided to minimize the binder size for that
> type of functions.
> 
> Please, keep the binder minimal unless necessary.

If we can just call __bitmap_clear() without any downsides, then I agree
we should do that, but we actually do support inlining the helpers now.
See CONFIG_RUST_INLINE_HELPERS.

Alice

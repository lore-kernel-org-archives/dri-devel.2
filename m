Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E785EC44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 21:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 449EB10F082;
	Wed,  8 Jul 2026 21:08:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="jQX90RgZ";
	dkim-atps=neutral
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com
 [209.85.208.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A0F10F2B5
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 21:08:16 +0000 (UTC)
Received: by mail-ed1-f73.google.com with SMTP id
 4fb4d7f45d1cf-69848bef5c7so962691a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 14:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783544895; x=1784149695;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gsxGWakqJeFwM90VS2bi5xlkNUrqBNf1v+hlTXOW8K0=;
 b=jQX90RgZE0TCjUMEhF1G/iqmUbc4fKgxsViYuHRveoFzOfLOMxBXy9ZA3PFQ+5h5YX
 y265kvJCf4f4x/OZFdMjlxaAZHpGBO9Spd2GWXjX41t5aiavqotAly09QcuBS8Z1ilr5
 U63aYqIPGF4xckw5t751uwIiMKfkHfAfs02L2/0485LLOHgcYBh+/qggDOdzIQKa/oij
 qRY8NteApXUyn1XpVmcG32Wje712LvDJYvjH93b9Rj2Zp+ZNddAmYt8xPSR+QRjoFH73
 eFz2qgZsaW4acU3mztHbq49K5JdkLLrFeI36llJj5kKmE6ZG5uIJE7vCPs6VwoNE0TzD
 p8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783544895; x=1784149695;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gsxGWakqJeFwM90VS2bi5xlkNUrqBNf1v+hlTXOW8K0=;
 b=k7mnvfrwy1i9cTq2oeAbD5oO9viDb8lxhyWMT1+nwBxJcZgy/qN1SiB92pWAl6VPWC
 bAHK/2inPRCraEVBHlzbUW7RrueiRXETXoftXMWwZ3mGVP6n4dNJLEryUg4b6SjNK2xa
 dsJ95/9cdJlxeX/WZHouQ9l4AmfdanWLhpPvbdUtUQjTFu4JKDwZYuXx1qVGqzAp1YuF
 GtFsEgONWLFe1BxRCqVSVECiBCshD9/NoVfVPzBlrKz4YtFEzfdYwgpNvMhX5Xtsbp9a
 f4xCfCFDWCdo1lrdHhYmOPtdCeCvSzxuos0N5d429VLoyqVOPL/WN4QdptPJSBPWO3KH
 +Pfg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHsjkm1l2TGQIk3+m6VU9YK7SG+ST9RC3hBNIQM+G2HBV5TLnRt4SNPbVoYmEzPHMkWx6ysilzOGQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yytuwh1Sv6OkZfXsQJzkDlTWSh4KUmycJaiClcSqasGpSpfrAk8
 Q5DE1lY/oXobYkEMGaD3OpyXpZxjblgmY8GHAo7elWAefO6FlIHDmarJZsxs3Vwe5eB2pIsiMQ7
 L0njiImuQ939tE30arw==
X-Received: from edaa23.prod.google.com ([2002:a05:6402:24d7:b0:698:c1e2:568b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5114:b0:698:5f89:9a51 with SMTP id
 4fb4d7f45d1cf-69ab4453a86mr1833185a12.5.1783544894902; 
 Wed, 08 Jul 2026 14:08:14 -0700 (PDT)
Date: Wed, 8 Jul 2026 21:08:14 +0000
In-Reply-To: <ak61Embrj0qH1vas@yury>
Mime-Version: 1.0
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
 <20260703-chid-v1-3-84fe8259e46e@nvidia.com>
 <2026070334-dollar-hexagram-e49c@gregkh>
 <DJSDFHOADWYL.V4WC2TI9UWYF@nvidia.com>
 <2026070745-unwired-maybe-769e@gregkh> <ak0pzDc69nAmnviD@yury>
 <2026070839-quadrant-gentleman-2334@gregkh> <ak61Embrj0qH1vas@yury>
Message-ID: <ak68PmjY97BHOZOd@google.com>
Subject: Re: [PATCH 3/4] rust: id_pool: add contiguous area allocation
From: Alice Ryhl <aliceryhl@google.com>
To: Yury Norov <ynorov@nvidia.com>, burak.emir@gmail.com
Cc: Greg KH <gregkh@linuxfoundation.org>, Eliot Courtney <ecourtney@nvidia.com>,
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
 dri-devel@lists.freedesktop.org, 
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
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

On Wed, Jul 08, 2026 at 04:37:38PM -0400, Yury Norov wrote:
> On Wed, Jul 08, 2026 at 07:33:16AM +0200, Greg KH wrote:
> 
> ...
> 
> > > I asked exactly the same question when Alice and Burak added wrappers
> > > for bitmaps to implement their ID pool. This is the answer:
> > > 
> > >   An alternative route of vendoring an existing Rust bitmap package was
> > >   considered but suboptimal overall. Reusing the C implementation is
> > >   preferable for a basic data structure like bitmaps. It enables Rust
> > >   code to be a lot more similar and predictable with respect to C code
> > >   that uses the same data structures and enables the use of code that
> > >   has been tried-and-tested in the kernel, with the same performance
> > >   characteristics whenever possible.
> > > 
> > > And now it's in a commit message: 11eca92a2caeb
> > > 
> > > They measured the affect of their wrapper on performance, and it appears
> > > to be ~5%. See lib/find_bit_benchmark_rust.rs.
> > 
> > You are comparing the C vs. Rust data structures here, which is not what
> > I am proposing.
> > 
> > Also, is this code being used on a "hot path" like the binder stuff is?
> > 
> > > I didn't see any side-to-side comparison between any native Rust API vs
> > > imported C bitmaps. I'm sure, I asked for that, and I still believe
> > > it's the important piece of data to avoid this back-and-forth type of
> > > discussions. So, Alice, Burak or anybody...
> > 
> > Again, I'm not talking about Rust API vs. imported C bitmaps, I'm asking
> > to use the C structures like maple-tree and idr instead of open-coding
> > logic around the bitmap code.
> 
> I understand your point. I asked both questions: are they sure that bitmap
> is the most optimal data structure for the ID pool, and if so, why not use
> the built-in Rust bitmaps? The answer was: yes, it's the most optimal, and
> using built-in bitmaps is suboptimal overall.

The Rust standard library doesn't really have a bitmap abstraction to
begin with, so if we want to use bitmap then it's either handrolled
bit-manipulation or the C bitmap api.

cc'ing Burak's new email

> > > > > > Why isn't the built-in idr library being used here instead of rolling
> > > > > > your own data structure?
> > > 
> > > Now having more context, the ID pool's primary goal is to allocate
> > > individual IDs, which naturally lays on find_bit() API in C. The
> > > native Rust alternative is considered and found 'suboptimal overall'.
> > 
> > Allocating IDs is a probe() thing, which can be as slow as it wants,
> > right?  Or is this some other hot-path where performance matters?  The
> > patch was not very specific as to the tradeoffs needed.
> 
> I am a bitmaps maintainer, and I want them in Rust to perform equally well.
> The ID pool case was just the first user. Even if bitmap performance is
> not a critical path for ID pool, my role is to make sure that bitmap in
> Rust is implemented well, including the performance part.
> 
> Said that, I recall that bitmaps performance was important for the ID
> pool, and Alice and Burak spent some time optimizing the ID allocation
> path. Particularly, added a logic to avoid allocation of small bitmaps.

Yeah the Binder use-case is not the same as probe(). It's a per-fd data
structure used to give names to kernel objects that userspace is
manipulating, and the mapping is per-process.

Alice

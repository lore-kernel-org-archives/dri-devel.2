Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B80C44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 05:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8228210E557;
	Wed,  8 Jul 2026 05:33:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ickX3Tog";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F76110E557;
 Wed,  8 Jul 2026 05:33:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9EAF843F48;
 Wed,  8 Jul 2026 05:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093331F00A3E;
 Wed,  8 Jul 2026 05:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1783488799;
 bh=mMaPgHn6LKK741pznqikoYQd8ZVAb02xm7w612bJCcw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ickX3TogilGPdFLnxstj6n81B//8drCBx+ZPJgKRzk+nEcAiTcVVFHaRRJClHuBLn
 cnkT1TYylN5X9JmWxc64DGrpvzc1gHEd+PyNn11u7k9L2fcd9S8guDy2GdbAZAS4yW
 cFGl4g0cs7uLsWUAx3RjN+e9ctAc8WYwuUutz1vs=
Date: Wed, 8 Jul 2026 07:33:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: Eliot Courtney <ecourtney@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>, Burak Emir <bqe@google.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 3/4] rust: id_pool: add contiguous area allocation
Message-ID: <2026070839-quadrant-gentleman-2334@gregkh>
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
 <20260703-chid-v1-3-84fe8259e46e@nvidia.com>
 <2026070334-dollar-hexagram-e49c@gregkh>
 <DJSDFHOADWYL.V4WC2TI9UWYF@nvidia.com>
 <2026070745-unwired-maybe-769e@gregkh> <ak0pzDc69nAmnviD@yury>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak0pzDc69nAmnviD@yury>
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

On Tue, Jul 07, 2026 at 12:31:08PM -0400, Yury Norov wrote:
> On Tue, Jul 07, 2026 at 04:13:30PM +0200, Greg KH wrote:
> > On Tue, Jul 07, 2026 at 10:25:27PM +0900, Eliot Courtney wrote:
> > > On Fri Jul 3, 2026 at 7:31 PM JST, Greg KH wrote:
> > > > On Fri, Jul 03, 2026 at 07:16:06PM +0900, Eliot Courtney wrote:
> > > >> Add support for contiguous area allocation. Add a new type,
> > > >> `UnusedArea`, following the same pattern as `UnusedId`.
> > > >> 
> > > >> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> > > >
> > > > Why isn't the built-in idr library being used here instead of rolling
> > > > your own data structure?
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > > 
> > > For nova-core in this series, we need allocation of a contiguous
> > > sequence of IDs with a specific length and sometimes a specific
> > > alignment. IIUC, IDA/xarray do not support that (I checked
> > > ida_alloc_range and it only allocates a single ID in a range, not a
> > > contiguous sequence).
> > > 
> > > For IdPool before this series, I think it could have used IDA/xarray.
> > > See [1] where Alice has posted some more context.
> > > 
> > > w.r.t. the structure choice, the IDs we need to allocate are channel
> > > IDs, and the total range is limited to 2048 of them, so IMO bitmaps are
> > > a better fit than e.g. maple tree.
> > 
> > But again, you are having to "roll your own" logic here, please reuse
> > the data structures we already have in the kernel for this type of
> > thing.  If a maple tree works, please use it.
> 
> I asked exactly the same question when Alice and Burak added wrappers
> for bitmaps to implement their ID pool. This is the answer:
> 
>   An alternative route of vendoring an existing Rust bitmap package was
>   considered but suboptimal overall. Reusing the C implementation is
>   preferable for a basic data structure like bitmaps. It enables Rust
>   code to be a lot more similar and predictable with respect to C code
>   that uses the same data structures and enables the use of code that
>   has been tried-and-tested in the kernel, with the same performance
>   characteristics whenever possible.
> 
> And now it's in a commit message: 11eca92a2caeb
> 
> They measured the affect of their wrapper on performance, and it appears
> to be ~5%. See lib/find_bit_benchmark_rust.rs.

You are comparing the C vs. Rust data structures here, which is not what
I am proposing.

Also, is this code being used on a "hot path" like the binder stuff is?

> I didn't see any side-to-side comparison between any native Rust API vs
> imported C bitmaps. I'm sure, I asked for that, and I still believe
> it's the important piece of data to avoid this back-and-forth type of
> discussions. So, Alice, Burak or anybody...

Again, I'm not talking about Rust API vs. imported C bitmaps, I'm asking
to use the C structures like maple-tree and idr instead of open-coding
logic around the bitmap code.

> > > > Why isn't the built-in idr library being used here instead of rolling
> > > > your own data structure?
> 
> Now having more context, the ID pool's primary goal is to allocate
> individual IDs, which naturally lays on find_bit() API in C. The
> native Rust alternative is considered and found 'suboptimal overall'.

Allocating IDs is a probe() thing, which can be as slow as it wants,
right?  Or is this some other hot-path where performance matters?  The
patch was not very specific as to the tradeoffs needed.

thanks,

greg k-h

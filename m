Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C966EC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 135C010E1C0;
	Fri, 10 Jul 2026 14:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="EtxtGoRk";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07C0D10E1C0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:23:36 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4703bc0a99aso587586f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 07:23:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783693414; cv=none;
 d=google.com; s=arc-20260327;
 b=qzqxDdLg2nR3TyFZC69GDjAtGZDVuouxaf+N3Mp+O563mFElp9D+sOMiaWo74paEme
 MLTzSKxQ5rVwWj1MIbKU7b57fqyJydlSsXFRal0CmFiftbeNJlhIZoxlFvBtjGss++uF
 cUViiVrLkeZif4EbskHOzt1UkeEKjoL/3upKDQ4ItUOjIfsskiJuARVapdDPtj+s14ir
 pMexUxdrzZ8XJnyA5V/UXl0mqwxLa5IauekBUDqbdYP+4/58mMSHiMB9zBRIxAmktDOi
 9cpHQC9uWPkBoNqAAc2JxuJwBoucxKA6MbGyGzIUe136COLHhV6XCnU0ThY6fWHiwVzx
 2QZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZdEXK77UFhy/cOL68bwMcQ0ItCStn1PAee3xYDI8PJ0=;
 fh=3AnteMlphpUyzke0LimFWTPYwojgL95kchTd+FuPIDs=;
 b=oiwkGCT3Leet+hBxLmdgjPAjwUK8+hQJ1eVatBf+vMChYBPgzNRwLPO+O2HgMBs66O
 m6L9AMXvV5S0EynQf3kMEb5NQUtpBRl8iUKlbxE2bkGH6Ufpsbb6Q5VQebPzv9LCoq0V
 EWjoOAmqB3lSXsmnfq6gGmcfGzSF+cYlWlCaW3E8HDFsg/Tv4v9aa8OVkGo+IdhXsPql
 O4mSm8RnjUs2B1rGqFt3I5yNzSgj2fMLOd0z74X0uXAQ4qWjQBm1PPBY9n7Ygdz9LNKO
 hsRlzBDNHiWbLnh51sTEe4KNyLtYeyLOu7sa+2zHC/yGI5hZWTJUrBzXBOq+OYcxko+E
 rOVA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783693414; x=1784298214;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZdEXK77UFhy/cOL68bwMcQ0ItCStn1PAee3xYDI8PJ0=;
 b=EtxtGoRkLTACLrSu7SUEDdyIX1HJ6JddSA/VNnQHynZ1Q8K2sloG/4pYQrzzx8wHwf
 R3goD0djZTT7r7fD9gS8Lgeyio+UwnC2XT2dRPlg3KORsj3ZZ1u9n7bkzBhWjYdf/vU3
 gMeIRXx8PyEA2OMBmsGosX79WeEYzqOuAhUddBQOrjjcxmgt19s0Vozv974sxIOhRxZn
 Kbu8phpr9oPEQYRwR/dltqSgAtzmSDwOlLjBHmM0b3Ei1JBby+H3ky703r4SayOjJvsr
 JqxyiSpxDZgt93poSN9nV/3WbQDPLu17zkSP+8oZGNNY8KoUpH3hNPnfE0sIswTcyYXx
 h4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783693414; x=1784298214;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZdEXK77UFhy/cOL68bwMcQ0ItCStn1PAee3xYDI8PJ0=;
 b=akme71Wjf2UylZBd7bdy4+WrQrRaN7LcdQM/h5rRLqIvoKab+WAEzP2ibrEYU2+lb5
 i0Zoeb9KpbE0mNn71C4i50lV/IiRtgJsamlOecn7S+wJ/hfpaA1xiE0VhODJBvyM2JnR
 uWD5NUbw5NCmOLt11XIBlp9bN0z+l2ZYqogbje/2cA1fzKAdfTBd75Ix562i0Gc5QP0U
 grkjGWyJrYhymzreVLAApIRbJ2Voh4fKU9ui6wPZK/dGa3qJy+CSuK1pm/iaRh1LYSZj
 49YD4vStKO1qIpEdNgW2By6prBJfSCGf+1ghcw1NZy4Ua0K7dG4ejXJIKQv+dWi+vrh9
 wr3Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoF5I5EMCIAe6ARIrkqpyIwoFZ4kVIgp+IAD+FVz/1pGLUjeYFcUZqvq4VrSUZXtZ2LTQxC5N741i0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxArnMhzSxjGqEMh1y7XlMnTJW65AZArkCIydcoghQNkvTlQYW/
 zDuMPrBwkW+wpsDKZmgxgwse+Fnra71KoN17Iru2TrM7JzFoHRH/RlVKU0BYtELdNJU/60TtBhj
 h7u7PC5iDdo/G7oRWOkQKorOtr3rORbIOIHBNFxMQ
X-Gm-Gg: AfdE7cnaJSZs/4+PhnIxbNSkziklwHz61JhNgcOQfgkhMKF8M7bjYwmKxDcvK63w8tE
 t7a+4qMgqzzp+Z7dY+o0+wNbcUefKuXQUpQFHt7P1RvglcvzA1PkzEcEWwtFUl3aEFWflKNZ/Lk
 pjXh59572mbe3twqjO6KXd5WkBUITVD7i1zt7ERc1cUmqZDbfBZOtNNoFhO5uS6HcL3fANtS5Px
 /4u/4H9/NpLVqMoe3tbaleGLKmExiLP4crSHDBK0sTYbyyaQCnzspOPGJqpkNYUoYtVW5bRCuDb
 WS/OdikxpeDjqjVKRdFfIlxE9GzTVeL5pWEqz3QdfABjKCb6lhvUw5OOguY=
X-Received: by 2002:a05:6000:2482:b0:477:6874:5415 with SMTP id
 ffacd0b85a97d-47df074605amr12898798f8f.26.1783693413737; Fri, 10 Jul 2026
 07:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
 <20260703-chid-v1-3-84fe8259e46e@nvidia.com>
 <2026070334-dollar-hexagram-e49c@gregkh>
 <DJSDFHOADWYL.V4WC2TI9UWYF@nvidia.com>
 <2026070745-unwired-maybe-769e@gregkh> <ak0pzDc69nAmnviD@yury>
 <2026070839-quadrant-gentleman-2334@gregkh>
 <DJUYI5EL9MCS.F6LWYD6821YM@nvidia.com>
In-Reply-To: <DJUYI5EL9MCS.F6LWYD6821YM@nvidia.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 10 Jul 2026 16:23:20 +0200
X-Gm-Features: AUfX_mxGtzRTvhuK561wSbk819Xm8Or_NDy_i70dNzRqnXHoPTSZcfN6JkQkc_c
Message-ID: <CAH5fLgi3tndgpVc_qNMCxk4PCB57EZLf9X7OwpEr=mg8FwGf7Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] rust: id_pool: add contiguous area allocation
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Yury Norov <ynorov@nvidia.com>, 
 Burak Emir <bqe@google.com>, Yury Norov <yury.norov@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jul 10, 2026 at 4:21=E2=80=AFPM Eliot Courtney <ecourtney@nvidia.co=
m> wrote:
>
> On Wed Jul 8, 2026 at 2:33 PM JST, Greg KH wrote:
> > On Tue, Jul 07, 2026 at 12:31:08PM -0400, Yury Norov wrote:
> >> On Tue, Jul 07, 2026 at 04:13:30PM +0200, Greg KH wrote:
> >> > On Tue, Jul 07, 2026 at 10:25:27PM +0900, Eliot Courtney wrote:
> >> > > On Fri Jul 3, 2026 at 7:31 PM JST, Greg KH wrote:
> >> > > > On Fri, Jul 03, 2026 at 07:16:06PM +0900, Eliot Courtney wrote:
> >> > > >> Add support for contiguous area allocation. Add a new type,
> >> > > >> `UnusedArea`, following the same pattern as `UnusedId`.
> >> > > >>
> >> > > >> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> >> > > >
> >> > > > Why isn't the built-in idr library being used here instead of ro=
lling
> >> > > > your own data structure?
> >> > > >
> >> > > > thanks,
> >> > > >
> >> > > > greg k-h
> >> > >
> >> > > For nova-core in this series, we need allocation of a contiguous
> >> > > sequence of IDs with a specific length and sometimes a specific
> >> > > alignment. IIUC, IDA/xarray do not support that (I checked
> >> > > ida_alloc_range and it only allocates a single ID in a range, not =
a
> >> > > contiguous sequence).
> >> > >
> >> > > For IdPool before this series, I think it could have used IDA/xarr=
ay.
> >> > > See [1] where Alice has posted some more context.
> >> > >
> >> > > w.r.t. the structure choice, the IDs we need to allocate are chann=
el
> >> > > IDs, and the total range is limited to 2048 of them, so IMO bitmap=
s are
> >> > > a better fit than e.g. maple tree.
> >> >
> >> > But again, you are having to "roll your own" logic here, please reus=
e
> >> > the data structures we already have in the kernel for this type of
> >> > thing.  If a maple tree works, please use it.
> >>
> >> I asked exactly the same question when Alice and Burak added wrappers
> >> for bitmaps to implement their ID pool. This is the answer:
> >>
> >>   An alternative route of vendoring an existing Rust bitmap package wa=
s
> >>   considered but suboptimal overall. Reusing the C implementation is
> >>   preferable for a basic data structure like bitmaps. It enables Rust
> >>   code to be a lot more similar and predictable with respect to C code
> >>   that uses the same data structures and enables the use of code that
> >>   has been tried-and-tested in the kernel, with the same performance
> >>   characteristics whenever possible.
> >>
> >> And now it's in a commit message: 11eca92a2caeb
> >>
> >> They measured the affect of their wrapper on performance, and it appea=
rs
> >> to be ~5%. See lib/find_bit_benchmark_rust.rs.
> >
> > You are comparing the C vs. Rust data structures here, which is not wha=
t
> > I am proposing.
> >
> > Also, is this code being used on a "hot path" like the binder stuff is?
> >
> >> I didn't see any side-to-side comparison between any native Rust API v=
s
> >> imported C bitmaps. I'm sure, I asked for that, and I still believe
> >> it's the important piece of data to avoid this back-and-forth type of
> >> discussions. So, Alice, Burak or anybody...
> >
> > Again, I'm not talking about Rust API vs. imported C bitmaps, I'm askin=
g
> > to use the C structures like maple-tree and idr instead of open-coding
> > logic around the bitmap code.
>
> Yeah, I agree that using maple tree avoids piling on more ID allocation
> implementations.
>
> Channel ID allocation isn't on a hot path (absolute peak ~100 per
> second, on average < 1 per second, AFAICT).
>
> I prototyped the implementation using maple tree [1]. It has some
> awkward points:
> - Allocating aligned IDs needs a loop on top of
>   MapleTreeAlloc::alloc_range + erase, which essentially replicates the
>   logic in `bitmap_find_next_zero_area`
> - Since aligned allocation may take multiple tries we still need
>   exclusive access in `ChannelIdPool::alloc_area` to ensure an allocated
>   but about to be erased non-aligned alloc doesn't make it look like we
>   ran out of IDs. Alternatively, can do a try+restart kind of loop
>   instead (needs adding bindings for mas_empty_area). [1] is using the
>   extra Mutex.
> - The alloc_area and Drop path of `ChannelIdPool` now allocates memory.
>   I *think* this is okay but it is a consideration.
>
> These tradeoffs weren't obvious to readers because I didn't include
> enough context in the patch series (and was going to add actual usage of
> the aligned alloc later).
>
> Anyway, maple tree does work for this, so if you prefer I'm happy to go
> with it.
>
> Thanks~
>
> [1]: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nv=
idia.com/

If you need to make multiple allocation attemps to handle the
alignment requirement, then I don't think maple tree is a good fit for
your needs.

Alice

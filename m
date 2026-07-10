Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1238C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25C0E10E577;
	Mon, 13 Jul 2026 07:10:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sk0DvTfy";
	dkim-atps=neutral
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CE5D10E1EA
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 15:09:32 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-5bdff8c02b2so464534e0c.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 08:09:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783696171; cv=none;
 d=google.com; s=arc-20260327;
 b=mBowme3fnuOqDFNJyfaU619gKfj2qnl5vcAUtOROzcnqA/XKu8OJENWC5H3exjmcBZ
 fxmby2VEPsO3GVUuE6e1Aa1xM4PFs4KtK6vnXY0yfB+w6I3s8RvnZYvbIC/675EJWROl
 FQO+a0UVYVpNAV36ghIfRUGw6N04RePzIvTo7OijlLeeDVDiptFgciIlhtA6OHQ+69nw
 BBPk8gMTJgx/GCJPGEbYS6o0DDW7u5Q+dbE2pydDOgvkVcwJkgYK5Heq895yTj9OULaj
 ITUTrGcgxeZi3OKZmIc0qPWG+u31dR42hvzf8urYOEJVmRNmyjrJcuHL/embnO+n1/zw
 +gFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xXUgud4G/O9l9flAkvY3taGec20Vgh1cA8EQbaLr8+g=;
 fh=WIWGuoAmoSvfw4sxY03CJCwbUOvLYeE/XEy1rzlE5OU=;
 b=orLviR+ASjw/R/XPq6IZviD7APlV0S9YdfXPX+EEyVLfAcRDqrXcushvE6mau6y3fa
 flw4P9nGW8kA8ZmQUsE4CFMDTFTw4Pc+NEXu692JuvQb1+q+yxCZrHfWIIAmV/LdAUne
 QJJALF1wWOptK2YNptesExLTfFuUSro/ywWs/Yyc3uI8d2OaoXnrAuz4Gg+20BASs9mh
 rjG2XCH2thFJ25VvumxS2/CrhHR23u7VhHaQC9kvWI+bCvkjC6N0jBIownf1Qa1IXscw
 JHdLel/YAYOIzeb4Z1Q9Ae2x2XU5Ojpwq5d2zYdYOvYo/xuToIDjK38/PnmaODOz7Ox8
 t+Aw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783696171; x=1784300971; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xXUgud4G/O9l9flAkvY3taGec20Vgh1cA8EQbaLr8+g=;
 b=Sk0DvTfycjVAyXhiz5+8zOqwQoNUK/L7VOXMOPtSfGqhAV/wzoIdtsYW4xmuxI81dN
 S9CB23imjese0jU6jPfIJkFwFudY4sCjSuOtwQ6RArnlsn3QM6cJPIodXBLxBiYWsnb7
 cK0ZvX4d9oa6gzUFOkG7N0v9yYJqgIj9RdBeIikcalpkvd/i7wtMrwjWqwsyriJ1yIOL
 ukqPQR7dC1bt/gd0D1I0rhMrNi1HOE7EIAKtWxaXwNMo9J8SCFKwHb+QFnf3LjTZW+Wh
 oLyncHdIlT2mfGy8+uUCy3aOLW9/+O0rY+8bu0ohfrZ6uzgWPCHGJt/LxtxrSpKLbhQ5
 c/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783696171; x=1784300971;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xXUgud4G/O9l9flAkvY3taGec20Vgh1cA8EQbaLr8+g=;
 b=fBSCIfoY0HcteKuv/MagIJbMWhqa3ssloE95k+RJhW1RKEbuSx05gokmJwzWBnt/qX
 3gz2rrlvlnmKYfb4ZjZ3lFB+2Lv8XPRHmqjdFiWy4HIcbotf4jPgLnWVlYQow2WiKEhg
 HCZo3kz+0itiAXwmWNuJLbajY81sJ1aeKBfCz4v6xrijm28k+CNFAiOfvEQGeMCQujA5
 8ak5idEbV74Dd+Tu0+c9VoE4pHB+ZG9tm82kD06MRbBhEMG7OqelZyrSx4ll1/l1pEl0
 OOXiZCxcAAmmb95ggJDitu6sn3f9HemFsR4BsGuFscUbNUi+ZqW/FAJS+BWXNlxh0JC/
 mN2A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9KLsE2PRsyPjH2lftl0NiTk3caXYJ3IJ6drc3nJSmNvfs2kWF67gb9UYQzWzZq8wtatBE5rbnA/g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5WrySpZIyv3pBcxDCvczR+gZg84ZIwq4ENJs1usmKzuJJjZiM
 jMpy4GBZ8PIIcShWnt0YMh/GkXn3vQqwUB9r7nzliTd3/Ebq5vKheJhTNZIca/TCRV1xixzVJu2
 ++Jytr/Fh8YnXwIL+7CcXSX+elINXs5s=
X-Gm-Gg: AfdE7cl5oGLoeLhamADHs3fdFFxHtBlzZuN5KwwFZOVd++4f0Lf+q7xfrUOBtwEZUAe
 SY8c9TCGRfucl71+5rx9S0lUVECRCrBTnX4pMPBmPaNJnBPvYTzCuGiANXJL/EVEa3lJO48u+j4
 2WH4dzHx3gCPDWyNbuNJaapMsf16wVyMZnRxzf3u07rsV1/3aQbmCXFcy7TAPl8cSe4yYTDbtJ2
 1eCycNFXeSyRNGCLi7J6heAJKIdogo9M9ycc6oQ7duvRI5Y5/xjVkUtnzGJou8nQ6e88c6Gr/lW
 1uXOJ+ySPNCSpGnFFyPD450e5xmkwo6hCR77AQ==
X-Received: by 2002:a05:6122:2883:b0:5bd:81fc:ebe9 with SMTP id
 71dfb90a1353d-5bf75a9fa9cmr6210645e0c.0.1783696170828; Fri, 10 Jul 2026
 08:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
 <20260703-chid-v1-3-84fe8259e46e@nvidia.com>
 <2026070334-dollar-hexagram-e49c@gregkh>
 <DJSDFHOADWYL.V4WC2TI9UWYF@nvidia.com>
 <2026070745-unwired-maybe-769e@gregkh> <ak0pzDc69nAmnviD@yury>
 <2026070839-quadrant-gentleman-2334@gregkh> <ak61Embrj0qH1vas@yury>
 <ak68PmjY97BHOZOd@google.com>
In-Reply-To: <ak68PmjY97BHOZOd@google.com>
From: Burak Emir <burak.emir@gmail.com>
Date: Fri, 10 Jul 2026 17:09:16 +0200
X-Gm-Features: AUfX_mz71O6wKNiBjknUzlHPuRHRfhmrp1Ke1wablmRwTKjPL09QiGzeg2wSZG8
Message-ID: <CABwQupO-vow5+SqHUpyXZouP=rjNL3cuV=yWkK6v=xLt0MKEAA@mail.gmail.com>
Subject: Re: [PATCH 3/4] rust: id_pool: add contiguous area allocation
To: Alice Ryhl <aliceryhl@google.com>
Cc: Yury Norov <ynorov@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>, 
 Eliot Courtney <ecourtney@nvidia.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
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
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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

On Wed, Jul 8, 2026 at 11:08=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Wed, Jul 08, 2026 at 04:37:38PM -0400, Yury Norov wrote:
> > On Wed, Jul 08, 2026 at 07:33:16AM +0200, Greg KH wrote:
> >
> > ...
> >
> > > > I asked exactly the same question when Alice and Burak added wrappe=
rs
> > > > for bitmaps to implement their ID pool. This is the answer:
> > > >
> > > >   An alternative route of vendoring an existing Rust bitmap package=
 was
> > > >   considered but suboptimal overall. Reusing the C implementation i=
s
> > > >   preferable for a basic data structure like bitmaps. It enables Ru=
st
> > > >   code to be a lot more similar and predictable with respect to C c=
ode
> > > >   that uses the same data structures and enables the use of code th=
at
> > > >   has been tried-and-tested in the kernel, with the same performanc=
e
> > > >   characteristics whenever possible.
> > > >
> > > > And now it's in a commit message: 11eca92a2caeb
> > > >
> > > > They measured the affect of their wrapper on performance, and it ap=
pears
> > > > to be ~5%. See lib/find_bit_benchmark_rust.rs.
> > >
> > > You are comparing the C vs. Rust data structures here, which is not w=
hat
> > > I am proposing.
> > >
> > > Also, is this code being used on a "hot path" like the binder stuff i=
s?
> > >
> > > > I didn't see any side-to-side comparison between any native Rust AP=
I vs
> > > > imported C bitmaps. I'm sure, I asked for that, and I still believe
> > > > it's the important piece of data to avoid this back-and-forth type =
of
> > > > discussions. So, Alice, Burak or anybody...
> > >
> > > Again, I'm not talking about Rust API vs. imported C bitmaps, I'm ask=
ing
> > > to use the C structures like maple-tree and idr instead of open-codin=
g
> > > logic around the bitmap code.
> >
> > I understand your point. I asked both questions: are they sure that bit=
map
> > is the most optimal data structure for the ID pool, and if so, why not =
use
> > the built-in Rust bitmaps? The answer was: yes, it's the most optimal, =
and
> > using built-in bitmaps is suboptimal overall.
>
> The Rust standard library doesn't really have a bitmap abstraction to
> begin with, so if we want to use bitmap then it's either handrolled
> bit-manipulation or the C bitmap api.
>
> cc'ing Burak's new email
>

(Thanks, I will update my email in the MAINTAINERS file.)

Binder needs to acquire bits *while holding a spinlock*. This is the
biggest constraint.

My understanding is that the IDA API call might need to allocate
memory (and sleep) when getting a new ID, as a side-effect.
So for the binder use case, it was not an option.

@Yury, about the alternative of vendoring Rust bitmap crates: that
would have duplicated the kernel's C bitmap functionality.
There does not seem much point in duplicating that, and opening the
door to have Rust and C code differently named API functions and such.
So beside performance, maintenance and coherence are also a factor.

The Rust ID pool code is merely a port of some existing
bitmap-specific binder C code (that can hopefully be deleted one day)
that deals with spinlock allocation fun. If the constraints match, I
think it is good to see it generalized and used elsewhere. That is a
conditional statement, I am not familiar with the nova use case's
performance/allocation/sleep constraints.

-- Burak

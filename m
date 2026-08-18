Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEBAC5DF74
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BCCD10EB88;
	Tue, 18 Aug 2026 13:56:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L+5lhMZ4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9635110E3D1;
 Tue, 18 Aug 2026 13:56:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3920143833;
 Tue, 18 Aug 2026 13:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CA61F00A3A;
 Tue, 18 Aug 2026 13:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787061364;
 bh=QpLyRpy5rWo5XajGCr9gqfn/kpepaDD3b47Uy3fNXp8=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=L+5lhMZ4gQesexdCe7BakwiLRPBDp9GrrucHh6nHTk2bu8MJAH19U0jY+CDlsMym2
 lsx91HODEwGFEjFvErwIfTGmwhjyHkaRxPqv6Bxx+B9NM2o3hc8MdCCcvo+4W2p4QW
 ounX79n7cUKIZWfPWFXX3f/Rg6bK2kFC0T06uae9Q4+BaqHE82/uUKU+1UKfknWD9W
 b2gwObC1o/9p5KULLzqhd/WynhDHev1/aNo7YoNYrLvaGp3/7nmc2E8Wo9DixQX3XL
 3cSBzpCLKfbiF2cQQ5ldEg3zpVc0SVbrbKSMNF7w+iBwuX0cEYnf+nqoRrx+qFmi0f
 F7c0woAwGIO0g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Aug 2026 15:55:57 +0200
Message-Id: <DKS4DQA11LHT.22S0ACLYB9XAJ@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
Cc: "Gary Guo" <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>,
 "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
To: "Yury Norov" <ynorov@nvidia.com>
References: <DKOECWHEEAK1.3N3JXH9MH7Q58@nvidia.com> <an7bG2bEd28AbNRr@yury>
 <an8r4VECQ8iFP8ze@yury> <DKR0ZNGYW9IT.37N7TEN97GG3N@nvidia.com>
 <DKR5W5DGAWAJ.38LHLLNPO9R4W@garyguo.net>
 <DKR6EB8OWPXG.2QYAY81UG1RF3@kernel.org>
 <DKR724N9V3Z8.1HJP6NJC5A4ZK@nvidia.com>
 <DKR7N2LLIQZH.25F7VF4CET6PO@kernel.org>
 <DKR8MCRB76L2.1TV4D7261PVTH@garyguo.net>
 <DKRA0IU4WVW1.3AOKCY38VHTKZ@kernel.org> <aoON0FepAUw1b003@yury>
In-Reply-To: <aoON0FepAUw1b003@yury>
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

On Tue Aug 18, 2026 at 12:40 AM CEST, Yury Norov wrote:
> Again, any kernel API trusts it's caller. It holds for assembler,
> for C, and I don't see any reason why it shouldn't hold for Rust.

This argument is misleading in this context, because it is conflating "trus=
ting
the caller" with "trusting the value".

The kernel's APIs generally do trust the caller (and even that does not alw=
ays
hold), but they do not necessarily trust the arguments passed by a caller; =
this
entirely depends on the API contract.

And this makes a lot of sense; sometimes values originate from untrusted
sources, such as userspace.

But even if there is a clearly expressed API contract for the bounds of a v=
alue,
kernel APIs regularly do still check their validity.

For instance, do_mmap() does return -EINVAL if !len, despite the documentat=
ion
(*1) even saying:

	@len: The length of the mapping. Will be page-aligned and must be at
	      least 1 page in size.

In this case one reason is layering, the len argument *may* originate from
userspace, but it does not always originate from userspace (i.e. an untrust=
ed
source).

So, if we'd write do_mmap() in Rust, it would be a perfect candidate for le=
n
being NonZero.

This way there's only a single do_mmap() function, that doesn't need to bot=
her
with a runtime check for len, because the argument already holds that invar=
iant.

The way the invariant is obtained depends on the call site. If the value co=
mes
from userspace, you do a fallible check

	let len =3D NonZero::new(len).ok_or(EINVAL)?;

If the value is known at compile time you can instead call

	let len =3D nz!(PAGE_SIZE);

which is checked at compile time.

Maybe you also already got a NonZero value from a different API that alread=
y
obtained the non-zero invariant that you just pass through.

It nicely separates the code that validates the value from the user of the
value, where the user of the value is only interested in the required invar=
iant,
but not how the invariant is obtained.

IOW, do_mmap() does not care (and should not care) how the caller ensures t=
hat
len !=3D 0.

> And undef isn't the case for alloc(0) - instead of making non-zero 'size'=
 a
> part of API contract, we must make the function behavior well defined for=
 this
> case.

We should only do this if the return value does not depend on an argument's
invariant, in which case no invariant is needed in the first place.

> kmalloc(0), for example, returns ZERO_SIZE_PTR. The pool.alloc_area(0) ma=
y
> return None, and probably trigger some warning.

That's because ZERO_SIZE_PTR *is* a useful return value that adds real valu=
e
(even more useful in Rust with ZST). It does for instance allow you to writ=
e:

	items =3D kmalloc_array(n, sizeof(*items), GFP_KERNEL);
	if (!items)
	    return -ENOMEM;

	for (i =3D 0; i < n; i++)
	    process(items[i]);

	kfree(items);

However, reserve_ids() is not like kmalloc(), a ChannelIdArea with a zero r=
ange
isn't useful at all.

And returning Result<Option<ChannelIdArea>> is not useful either, as it wou=
ld
move the validation through NonZero (which you want to avoid) back to the u=
ser
now having to validate the Option instead, which, for obvious reasons, is w=
orse
given that it is actually an error condition: there's nothing optional here=
,
it's just that the input argument was wrong, so Ok(None) is even misleading=
.

(*1) do_mmap()

I think the documentation is slighly misleading, since it says "must be at =
least
1 page in size", but the actual requirement is non-zero. It's just that any=
thing
that is not page aligned is rounded up, so any 0 < len < PAGE_SIZE ends up =
at
PAGE_SIZE too.

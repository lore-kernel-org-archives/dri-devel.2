Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A44C624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1FE810F07C;
	Wed,  2 Sep 2026 09:40:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DED+23z+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDBF610F07C
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 09:40:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6EF9043D50;
 Wed,  2 Sep 2026 09:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13E51F000E9;
 Wed,  2 Sep 2026 09:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788342034;
 bh=3GNjgBRh/TFQ2DZiDm6LF+khm9qd2fU5wa+rGb+xvxM=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=DED+23z+XYywGNcM2fNTocTVV1ntAinSMt2TMOlTiAblp8ZOfN8lnF5moH8M376zB
 X7EJjwBmr4B3vM1hMtLuSgkMTW0eX9FnR/OhtnlVeCY14VqypbQGlyUt1H8yqNRY8Z
 jXSxn8SyzTzDKkLi++l5fnDjTnYHQJpmeqjCQV18mbHtJv9PJWYBxp8Y8OzH9I0vlb
 8pryI0/p+0SfprHYQb6ET80mDc9NXrfcm0WxcxGt01j6neAX8oBZHckICHh1t5PjWf
 Rq6FtkmjxseBHGCvCAnT2lO0X/5YptRUQJAKH0PRXrRys7pJVZ9WqNYyYFPF+UCfkc
 JvdcWPH0JRaCA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 11:40:30 +0200
Message-Id: <DL4QCAZXM8EU.2K8MLAM00VNTX@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
Cc: "nova-gpu" <nova-gpu@lists.linux.dev>, "M Henning"
 <mhenning@darkrefraction.com>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL3WXUPD5JKE.2GZ1CNJH539ID@kernel.org>
 <DL453EFS03T6.2VGI5TJEQ52QO@kernel.org>
 <apdvTgAp5eGezO5t@nvdebian.thelocal>
In-Reply-To: <apdvTgAp5eGezO5t@nvdebian.thelocal>
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

On Wed Sep 2, 2026 at 4:38 AM CEST, Alistair Popple wrote:
> So I'm ok with providing either a decoded architecture and implementation
> xor an opaque chip-id. Or alternatively maybe architecture includes the
> implementation (ie. we rename the opaque chip_id to architecture). But tr=
eating
> the implementation and architecture values differently and only providing=
 one
> directly doesn't make much sense IMHO.

I think this is you still thinking about this in terms of register encoding=
.

Look at nova-core, there we are caring about two things chipid and architec=
ture,
but never about the implementation bits.

You won't see any

	if (arch =3D=3D X && impl =3D=3D Y)

checks anywhere, because it would be unnecessarily complicated and error pr=
one.
You will instead find checks for the architecture or the chipid directly, s=
uch
as in:

	/// Returns the HAL corresponding to `chipset`.
	pub(super) fn fb_hal(chipset: Chipset) -> &'static dyn FbHal {
	    match chipset.arch() {
	        Architecture::Turing =3D> tu102::TU102_HAL,
	        Architecture::Ampere if chipset =3D=3D Chipset::GA100 =3D> ga100::=
GA100_HAL,
	        Architecture::Ampere | Architecture::Ada =3D> ga102::GA102_HAL,
	        Architecture::Hopper =3D> gh100::GH100_HAL,
	        Architecture::BlackwellGB10x =3D> gb100::GB100_HAL,
	        Architecture::BlackwellGB20x =3D> gb202::GB202_HAL,
	    }
	}

See? We never care about the implementation part, as it is just an
implementation detail of the encoding of the chipid that no one should ever
bother with.

Yes, the check in fb_hal() could technically be

	arch =3D=3D Architecture::Ampere && impl =3D=3D 0

but that's arguably worse than what fb_hal() does today for many reasons.

To name just one of them: We'd entirely lose the guarantee that the combina=
tion
of arch and impl even exists in the first place. Even with a new type this
wouldn't go away, since not every Implementation would be valid for any
Architecture.

Also, look at the code that you had to write to even expose the implementat=
ion
bits in the first place.

	pub(crate) const fn implementation(self) -> u32 {
	    self as u32 & 0xf
	}=20

Notice the tension it creates? You have to reimplement what the lower layer=
 of
the register encoding already does and intentionally hides in favor of prov=
iding
a chipset() accessor.

Also note that with this you get a raw integer that is kinda ugly, because =
you
can't even make up a useful new type:

For Architecture the variants are obvious and meaningful (Turing, Ampere, e=
tc.),
for Chipset the variants are obvious and meaningful too (TU102, AD107, etc.=
).
But what would the variants for Implementation look like? "Zero", "Two", et=
c.?

> Except the architecture/implementation tuple is exaclty what user-space n=
eeds to
> eg. figure out what SM to compile for.

It doesn't need an architecture/implementation tuple, it needs a chipid for=
 this
lookup. (Although it might be questionable whether userspace should have th=
is
lookup table in the first place; see below.)

Both the KMD and the UMD only ever care about the architecture or the chipi=
d.
The fact that the chipid is defined by an architecture/implementation tuple=
 is
an irrelevant implementation detail not even the kernel cares about.

> And to be clear we don't care about the specific encodings in this exampl=
e. The
> point is the SM version can't be looked up from architecture alone, it ne=
eds the
> implementation as well and if the only way to get that is from opaque chi=
p-id
> that's all user-space will look at. Eg:

Again, it doesn't need the implementation, it needs the chipid. Which also =
your
code below correctly considers.

That said, if we know that userspace will never need to do an architecture =
based
check, but always a chipid specific check, it is obviously pointless to exp=
ose
it in the first place. But otherwise it should just be chipid and architect=
ure.

> static uint8_t
> sm_for_chipset(enum chip_id chip)
> {
> 	switch (chip) {
> 		case NOVA_GPU_CHIP_GA100:
> 			return 80;
> 		case NOVA_GPU_CHIP_GA101:
> 			return 86;
> 		case NOVA_GPU_CHIP_GA102:
> 			return 86;
> 		case NOVA_GPU_CHIP_GA10B:
> 			return 87;
> 		...
> 	}
> }

That looks reasonable and much better than what mesa has, but if we'd ever =
care
about the SM value in the kernel, then the kernel should be the single sour=
ce of
truth for this value and expose it to userspace.

Now, in this case I don't think the kernel really needs the value, but I th=
ink
the value is provided by GSP through GR_INFO_INDEX_SM_VERSION?

Given that, the kernel should query it and provide it via its GPU info stru=
cture
rather than having userspace invent another lookup table?

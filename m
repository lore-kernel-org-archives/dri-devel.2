Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B066C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D88910FAF9;
	Fri,  4 Sep 2026 12:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qlqbe0Sb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF85610FAF9
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 12:08:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B966841ADF;
 Fri,  4 Sep 2026 12:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FACF1F00A3D;
 Fri,  4 Sep 2026 12:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788523703;
 bh=BwqAVmTr8KXY7ZWClt2GtVrlFHVmSKcB9c6H5LMm1z4=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=Qlqbe0SbaU5fZwKxMYP3qPzbZIgKBjC7zNm40PQyLIy4NPBhN/wofr2FlS+/YpvYD
 lZgLx6ufLNHf6/f+iv2QPYLFq+OQFTWrY36tUOZVfgryPGciVJdbbvR1dtwruSAPm0
 ZobU84HZfhmu9SKW/DrNSMwYKtIswDa4NH/wT77nb2fmbnNGShIgfvt7MRnD21n1Gn
 W4k+Oo4RPRzmobQhiCUTP6d8WRocFLW/GGa6izM290snHUYonFMIGB+M3D70MYMheE
 GB/9KcNLhzXyABtGTEJ/Bqs1DpO5P6wJ0iugn+/T6kKT67fDSDF7gusFmM5r3Hh2lL
 SGhKnRXXeBexw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 14:08:19 +0200
Message-Id: <DL6IQKQDXY7P.1F6PSERSJ64PN@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
Cc: "Alistair Popple" <apopple@nvidia.com>, "nova-gpu"
 <nova-gpu@lists.linux.dev>, "M Henning" <mhenning@darkrefraction.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Benno Lossin"
 <lossin@kernel.org>, "Eliot Courtney" <ecourtney@nvidia.com>, "John
 Hubbard" <jhubbard@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL3WXUPD5JKE.2GZ1CNJH539ID@kernel.org>
 <DL453EFS03T6.2VGI5TJEQ52QO@kernel.org>
 <apdvTgAp5eGezO5t@nvdebian.thelocal>
 <DL4QCAZXM8EU.2K8MLAM00VNTX@kernel.org>
 <apioGUDamrCur_oR@nvdebian.thelocal>
 <DL5MA26KZEF9.3KHKQXZ4JD2G6@kernel.org>
 <DL6HKYRXHNFK.1D9HYNEPH4GCR@garyguo.net>
In-Reply-To: <DL6HKYRXHNFK.1D9HYNEPH4GCR@garyguo.net>
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

On Fri Sep 4, 2026 at 1:13 PM CEST, Gary Guo wrote:
> You mentioned in an earlier email about the typing, but we could still ha=
ve
> meaningful impl IDs fully typed like this:
>
>     pub enum Arch {
>         Turing(impl_id),
>         Ampere(impl_id),
>         ...
>     }
>
> and some langauges can do better, e.g. TypeScript allow you to write
>
>     enumn ArchId {
>         Turing,
>         Ampere,
>         ...
>     }
>
>     enum TuringImplId { ... }
>     enum AmpereImplId { ... }
>
>     type Id =3D
>         { arch: ArchId.Turing, impl: TuringImplId } |
>         { arch: ArchId.Ampere, impl: AmpereImplId };
>
> So I think it's a reasonable design to have it.

Of course we could encode this implementation detail, but I think there's n=
o
reason to do so.

For instance currently we refer to GA100 as

	Chipset::GA100

but with the above we'd refer to GA100 as

	Arch::Ampere(AmpereImpl::GA100)

which is not buying us anything, is it?

It also would be confusing because both the architecture and the specific c=
hip
would now be both represented by a type called Arch.

> True, but I think the chip ID is as bad as impl ID. Feature detections sh=
ould
> use dedicated featuire detection mechanism, not looking up IDs directly. =
I.e. we
> should have userspace not having to use either chip ID or impl ID as much=
 as we
> can.

This I agree with, which is also why I mentioned we should export SM if GSP
already provides it to us.

> That said, I do think looking up tables are unavoidable, for getting name=
s or
> applying some quirk fixes. And I agree with Alistair that if we include i=
t,
> including impl ID is better than the chip ID, as we should rather not hav=
ing
> user space relying on an arbitrary encoded chip ID.

No, the only thing userspace ever uses to distinguish between things is eit=
her
by architecture or by chip. If we instead provide architecture and some ID
userspace will just go

	if (arch =3D=3D Ampere && id =3D=3D 0)
		chip =3D GA100;
	else if (arch =3D=3D Ampere && id =3D=3D 2)
		chip =3D GA102;
	[...]

and after that never care about the ID again. Whereas with giving userspace=
 the
chip and architecture as separate fields userspace is done.

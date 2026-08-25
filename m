Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72D3C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 20:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C5210E23B;
	Tue, 25 Aug 2026 20:53:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nXaYK2Tr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A26810E23C
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 20:53:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ED69160053;
 Tue, 25 Aug 2026 20:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C46B1F00A3D;
 Tue, 25 Aug 2026 20:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787691228;
 bh=J3FBcNomJsC6iQ8hkt89oifaLPJ7myl11ydY5Aq/7/I=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=nXaYK2TrQ2xiFdD/XqShzYH/MjTG0tXLEcjLGw8AOCD8EUwvw9cO49wxKlYTs1M1n
 2IymgtIBUYUtARPGNz8KOw9d2JjlNIMbB8WfB3F14D23HrQyBZzhcBpQjOEnVjsxO9
 IzdjObiFxczdWtASEfEFtOkMoGAgmWrgOOL0XxzJ6Cnh2kq+1EQOpm9A9RpdsgVZkk
 OwNXiQzY7OW0mYo1OqfCraMxY5O+LXk1vE1uIbg11ZXg1ebVIu/b8uhYOfjfT3ViZ+
 aCIEcQRO2fVlGQD+zpp8XTOvmjyS26mmoDRRY3eP9rWyQ6elgh7E9Zlte9V0LuZnPk
 ztxCM6da6QXFw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 22:53:44 +0200
Message-Id: <DKYBNF427ALE.1OFETHRT4KNHK@kernel.org>
Cc: "M Henning" <mhenning@darkrefraction.com>, "nova-gpu"
 <nova-gpu@lists.linux.dev>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v4 3/7] drm: nova: Add chipid enum to nova-drm UAPI
References: <20260811050657.646799-1-apopple@nvidia.com>
 <20260811050657.646799-4-apopple@nvidia.com>
 <CAAgWFh0VvY4D=-Se+bVO1YonRNFEa28nc7+ZbxEbv6en7oPaDw@mail.gmail.com>
 <DKXF49DF656E.XB24SXGL3RLE@kernel.org> <ao062w9fdaQEEYHy@nvdebian.thelocal>
In-Reply-To: <ao062w9fdaQEEYHy@nvdebian.thelocal>
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

On Tue Aug 25, 2026 at 9:13 AM CEST, Alistair Popple wrote:
> I'm not particularly wedded to either approach but I think the approach i=
s
> either:
>
> 1) Keep the chip_id opaque, user-space looks up arch/implementation/etc. =
from a
>    lookup table as required.

Why? The kernel already has the information, so we don't need a lookup tabl=
e?

> 2) Keep the current scheme of just exposing the chip_id and letting user-=
space
>    decode it assuming the register layout won't change.
>
> In either case user-space needs to figure out arch/implementation/etc.
>
> For (1) the kernel should not be responsible for decoding arch because if=
 you're
> assuming the register layout can change arbitrarily then the it can't rel=
iably
> figure out the arch anyway.

If the kernel can't figure out the architecture of a card, it means that th=
e
chip isn't known by the kernel. Without that, how can it boot the firmware,
etc.?

> For example if someone plugs a shiny new card with a different chip_id
> register layout into a machine running an older kernel they could get an
> incorrect arch which would be confusing. Users would get upset if for exa=
mple
> ShinyNewCard got reported as being Turing say.

If the kernel can't deal with a chip it should never succeed probing and ne=
ver
expose any information to userspace in the first place.

nova-core does enforce this already; if a chipid can't be matched against a=
n
architecture it won't compile, and if the chipid is not known by nova-core =
it
will fail to probe.

Note that nova-core binds by vendor + class, not specific PCI device IDs, s=
o the
chipset check is our only gate against unknown hardware.

If we'd hypothetically remove that gate and just allow trying to probe unkn=
own
hardware with the boot sequence of just assuming some default with the late=
st
supported architecture, it would potentially be an even worse user experien=
ce,
where instead of a clear rejection of the hardware a user might experience
security/stability issues.

> So I think it makes sense to keep this decoding in user-space regardless =
of
> whether that's exposed via documented opaque chip IDs and lookup tables f=
or
> arch/implementation or by a commitment to keep the chip ID register layou=
t the
> same.

I still don't see much value in letting userspace decode this again, nor do=
 I
think lookup tables are necessary.

If the driver succeeds to probe for a device we already did decode things, =
so
there's no need for userspace to do it again or know about this.

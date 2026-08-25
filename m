Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E92C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 20:53:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 101BD10E0F7;
	Tue, 25 Aug 2026 20:53:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I/CNsTzJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85A4F10E0F7
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 20:53:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8E0BD601E9;
 Tue, 25 Aug 2026 20:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C761F000E9;
 Tue, 25 Aug 2026 20:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787691226;
 bh=Px83rT8Kti/M0gKeu2hRIclgFO0h7OSpSA2HNIO3oB8=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=I/CNsTzJMIDlPbngb0R6oIqJIJ4tFU87EXWW2slp54p+l2LhPyaSESsUerHBtva5F
 qN1+mKP8iE/47xcyVOb5LqwBtAR4cZvcMBml6O0v/9jQUQFJoVqNMWxIVnDZRi+Bvc
 FizX0pz/2XWTey01n3goV/dhV6SddOnuaN68rxKObhv751EwYlcVXuXWNT6f/FVJhU
 Yejoxjt/O/c5KiUXH5melYCsiczpF95jTdujDALriwc5q+iT32Wxxo6T/694QgF//Z
 SYkKmHbP3Da8siOpVUBX/Lg+2els1rHFxul67grtKPdgSA9eP0pQ5ZSOM35DWB+CQl
 kumaw2bzkacMw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 22:53:42 +0200
Message-Id: <DKYBNDXB14FY.3JX6GHMFIERO8@kernel.org>
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
 <ao1_ngqj2a2XB3h9@nvdebian.thelocal>
In-Reply-To: <ao1_ngqj2a2XB3h9@nvdebian.thelocal>
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

On Tue Aug 25, 2026 at 2:03 PM CEST, Alistair Popple wrote:
> On the other hand we don't need to ignore the lessons of Nouveau either a=
nd try
> and refactor everything - I agree there are plenty of UAPI choices that s=
hould
> and will be different and we shouldn't limit ourselves - but if an interf=
ace has
> been working well for 30 years and hasn't been causing anyone any issues =
then
> perhaps we should just stick with it for Nova as well?

IMO this answers the wrong question; I think the questions should be:

  - Why should we expose an encoded register value to userspace now that we=
 have
    the chance to not do so and hide that implementation detail?

  - What happens if it ever breaks?

As for the first one, I don't really see how it is a benefit to let userspa=
ce
decode it independently. It's better to have a single source of truth.

Besides that, we may also need to expose the chip major/minor revision at s=
ome
point, which can't be decoded from the chipid value. For this we'd need to
expose the full BOOT_42 register. Which is where we already have a preceden=
t
where things changed from BOOT_0 in the past.

More in general, passing encoded values from registers to userspace isn't t=
he
best practice.

Of course, userspace has to know about how the hardware works - I mean, tha=
t's
why we expose chipid, arch, etc. in the first place - but it doesn't (and
shouldn't) need to know how the parts work the kernel is responsible for.

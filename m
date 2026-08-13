Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F36C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 20:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4145710E039;
	Thu, 13 Aug 2026 20:48:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RH/a7UJm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC53F10E039;
 Thu, 13 Aug 2026 20:48:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 77CCB40C58;
 Thu, 13 Aug 2026 20:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0F71F000E9;
 Thu, 13 Aug 2026 20:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786654137;
 bh=inevz7SIRbVG4IXfL6V1r1oNP1vnMS/mRNmTfnek6qg=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=RH/a7UJm4VWemaEysMGU5HdNy/On4/owKmgOcnjAsU08Acqurq8ErEFIvN6X5cqD6
 XHZ+7d16pWFM2Qn744kJ3Y9gWUUt45Lniiz/PfN28HGaG7J9nCf6gWPZwbl+PI3VPF
 t7gBezYUCBWjWEiCxMvmuIanuUisvJzJl+44DOLcIEw9WTFhs+TJ/36xpHWPh9gIPK
 x17MFzYi8+FruURcAhV4CeFU7h8BToIGsdpRh7kqI5Q3Q7ShVlAvkEHoiQJDu8R9Jx
 IcFV4J/T52Ab60NVLcHxJQAhue+vtA1JdlHtN/Tnx7NFavz3O8T4SWyzzX44K4+ZXY
 vOjC958Zzuj/g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 22:48:50 +0200
Message-Id: <DKO414SNC0B2.248FUBGJGSPLU@kernel.org>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
To: "Yury Norov" <ynorov@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com> <anzxKO0X1OrNRD32@yury>
 <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com> <an4NvQBt3389jP6E@yury>
In-Reply-To: <an4NvQBt3389jP6E@yury>
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

On Thu Aug 13, 2026 at 8:32 PM CEST, Yury Norov wrote:
>   pub(crate) fn alloc_area(
>       &self,
>       count: usize,
>       align: usize,
>   ) -> Result<ChannelIdArea<'_>> {
>       let count =3D NonZero::new(count).ok_or(EINVAL)?;
>       let align =3D Alignment::new_checked(align).ok_or(EINVAL)?;
>
>       let mut ids =3D self.inner.lock();
>       let area =3D ids.find_unused_area(0, count, align).ok_or(ENOSPC)?;
>
>       // If the pool is small, the backing bitmap may be rounded up to a =
larger size.
>       if area.range().end > self.num_chids {
>           return Err(ENOSPC);
>       }
>
>       Ok(ChannelIdArea {
>           pool: self,
>           range: area.acquire(),
>       })
>   }
>  =20
>   let area =3D pool.alloc_area(8, 4)?;
>
> See the difference? You still check the parameters, but don't make it
> the part of interface.

Miguel already replied to this, so just briefly adding to this.

We usually want the arguments to already carry the invariants we require. I=
f we
make the arguments unconstrained, we may end up in situations where we alre=
ady
have types that provide certain guarantees about value constraints and yet =
we
have to give up on them because the API takes unconstrained arguments and
revalidates.

The code from Eliot does actually already takes advantage of this. In

	pool.alloc_area(nz::<8>(), Alignment::new::<8>())?;

both arguments are already validated at compile time, whereas with unconstr=
ained
arguments we're left with a runtime check.

Yes, nz() does not actually validate it statically, but it easily could (an=
d
probably should).

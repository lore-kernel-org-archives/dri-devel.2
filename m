Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D702C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1257910E7F4;
	Mon, 17 Aug 2026 14:08:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jtv/Vobn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0622B10E7F4;
 Mon, 17 Aug 2026 14:08:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 756B042E61;
 Mon, 17 Aug 2026 14:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264B91F00A3D;
 Mon, 17 Aug 2026 14:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786975696;
 bh=xxy0gHLKhdxtuUAFYQ8rWUWihf1KnUG6LllOzkRyE90=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=Jtv/Vobnmlg6DM04eaz2kLJKTht4m5jYkvnTMmQB+vxstfx4e1GVnc0h6yNLA3BKa
 s4JGuQrDe8RlhzVvoNU5J7pqSwVDMrOowrZHRp5YCh+07v4QnMW+vczzROYAXLS9mQ
 5Eca6vSJ244zkNpfgGJKiUWRm1xC0mJmXDDmMoAhSBMcp/Yn0O24JSlMDY9NxVvCRY
 hW0Rn/iXpQKWJFrFWcmt/N6kDpcDYln5ZB03/t/OnSxaKMzbk3oorl1gA13vm5/qGm
 qoj4q5EX+ggSCBPU4PK/xrd1RE8vR2vAoWaO0yTe4q5xfNdt9/z+UyNyWK/SMk+0UD
 vaFH80nhpFfqA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 16:08:09 +0200
Message-Id: <DKRA0IU4WVW1.3AOKCY38VHTKZ@kernel.org>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Yury Norov"
 <ynorov@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
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
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com> <anzxKO0X1OrNRD32@yury>
 <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com> <an4NvQBt3389jP6E@yury>
 <DKO414SNC0B2.248FUBGJGSPLU@kernel.org> <an4xDp29VX8Am0uR@yury>
 <DKOAY7J1IFTP.DMKSXK625EW5@nvidia.com>
 <DKOECWHEEAK1.3N3JXH9MH7Q58@nvidia.com> <an7bG2bEd28AbNRr@yury>
 <an8r4VECQ8iFP8ze@yury> <DKR0ZNGYW9IT.37N7TEN97GG3N@nvidia.com>
 <DKR5W5DGAWAJ.38LHLLNPO9R4W@garyguo.net>
 <DKR6EB8OWPXG.2QYAY81UG1RF3@kernel.org>
 <DKR724N9V3Z8.1HJP6NJC5A4ZK@nvidia.com>
 <DKR7N2LLIQZH.25F7VF4CET6PO@kernel.org>
 <DKR8MCRB76L2.1TV4D7261PVTH@garyguo.net>
In-Reply-To: <DKR8MCRB76L2.1TV4D7261PVTH@garyguo.net>
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

On Mon Aug 17, 2026 at 3:02 PM CEST, Gary Guo wrote:
> Now, with `NonZero` or `Bounded`, we are doing none of that. The only thi=
ng here
> is that there is a range restriction. Other than the value restriction
> themselves, they carry no other semantic meanings. How you interpret thes=
e types
> still fully depend on the API that accepts them. Therefore, it is very co=
mmon
> that you'd be using these with literals, and it becomes an ergnomic pain.

I agree that NonZero and Bounded are on the weaker end of the argument. But
there's still the flexibility argument.

The API itself, i.e. alloc_area(), does not need to bother with how the val=
ue is
checked. I.e. is it a runtime check, compile or build time check, or is it =
even
unchecked (or panicking) because we can derive the invariant from another t=
ype.

> Personally I value ergnomics higher than possibility of misuse if latter =
can
> be easily mitigated otherwise (in this case, by WARN_ON or just support
> zero-sized alloc).

Both is not a mitigation IMO.

WARN_ON() is does not prevent misuse of the API in the first place and in c=
ase
the value comes from userspace even introduces a vulnerability.

Making zero a valid argument simply ignores the problem or just moves it
elsewhere, e.g. where the caller has to validate the returned type instead,=
 i.e.
the ChannelIdArea. IOW, we'd remove the invariant ChannelIdArea carries.

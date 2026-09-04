Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25D6C79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E040610F9E2;
	Fri,  4 Sep 2026 09:34:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kN5DHcmG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D18010F9E2
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 09:34:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2C64C438E9;
 Fri,  4 Sep 2026 09:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849901F00A3D;
 Fri,  4 Sep 2026 09:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788514466;
 bh=2o3MAE9TEIfsI2+thUBP/ROdEH+0Aq360CQQYfrLbNo=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=kN5DHcmGy9L0eNOlukwl6ePb0zhcms1YOmBCsrB/3BwV6mfcWSqEWqnJMjLfpT0wh
 iD6QSnH2kIDh73AnxEQEAmPIw2px81jqjxAh1ITJpEVN0v+adrUI6DwnbhFNl30bZE
 fwzUBX5zEQvHYOn/Gd3/WzvBdS7C1ajoPJ0Es2d+/GtIYl8ltYIxDtPilP1dqMucpR
 AM8uHUVJxYh1qMN0Ql4I5XPxl0a9baUAzEw4VzxR/uFDTHxHa6HRAg6emTiBTjNG5W
 +iaTpvaW7OQ+5Eh0Tbakw7/uy/cdAwT8jIacT6NK/FDDb6THoZSkC/1fO683KA6K94
 ksuqGQ0/2tWmg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 11:34:22 +0200
Message-Id: <DL6FGP49MMWG.32RPN38WO2PXU@kernel.org>
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
Cc: "nova-gpu" <nova-gpu@lists.linux.dev>, "M Henning"
 <mhenning@darkrefraction.com>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL3WXUPD5JKE.2GZ1CNJH539ID@kernel.org>
 <DL453EFS03T6.2VGI5TJEQ52QO@kernel.org>
 <apdvTgAp5eGezO5t@nvdebian.thelocal>
 <DL4QCAZXM8EU.2K8MLAM00VNTX@kernel.org>
 <apioGUDamrCur_oR@nvdebian.thelocal>
 <DL5MA26KZEF9.3KHKQXZ4JD2G6@kernel.org>
 <appc5-0MRW1XwsMh@nvdebian.thelocal>
In-Reply-To: <appc5-0MRW1XwsMh@nvdebian.thelocal>
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

On Fri Sep 4, 2026 at 9:49 AM CEST, Alistair Popple wrote:
> On 2026-09-03 at 20:42 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
>> I think there never was a "rather than". The point was that if userspace=
 has
>> conditionals based on the architecture it shouldn't have to figure it ou=
t based
>> on the chipid, as this has been done by the kernel already.
>
> I see. Maybe that was a bad assumption on my behalf, because I assumed th=
at if
> you make a precise hardware description available (chip-id) there'd be no=
 point
> making an imprecise subset of that description (arch) available as it isn=
't
> particularly useful if you can't use it in isolation for any generic purp=
ose.

Except that it is used in isolation for a generic purpose e.g. in NAK.

>> Then in NAK (src/nouveau/compiler/nak/ir.rs), there's this code.
>>=20
>> 	fn is_turing(&self) -> bool {
>> 	    self.sm() >=3D 73 && self.sm() < 80
>> 	}
>> =09
>> 	fn is_ampere(&self) -> bool {
>> 	    self.sm() >=3D 80 && self.sm() < 89
>> 	}
>> =09
>> 	fn is_ada(&self) -> bool {
>> 	    self.sm() =3D=3D 89
>> 	}
>> =09
>> 	#[allow(dead_code)]
>> 	fn is_hopper(&self) -> bool {
>> 	    self.sm() >=3D 90 && self.sm() < 100
>> 	}
>> =09
>> 	fn is_blackwell_a(&self) -> bool {
>> 	    self.sm() >=3D 100 && self.sm() < 110
>> 	}
>> =09
>> 	fn is_blackwell_b(&self) -> bool {
>> 	    self.sm() >=3D 120 && self.sm() < 130
>> 	}
>> =09
>> 	fn is_blackwell(&self) -> bool {
>> 	    self.is_blackwell_a() || self.is_blackwell_b()
>> 	}
>>=20
>> That's two unnecessary indirections for something the kernel already has
>> available.
>
> Again though is what the kernel provides in the form of an arch actually =
useful
> to user-space? Obviously the code above makes it look nice and simple lik=
e that,
> but as I have been saying more complete implementations can't just rely o=
n arch
> alone and so are still going to have lookup tables both for SM and for ot=
her
> info the kernel can't provide.

Are you saying that NAK oversimplifies things and hence gets away with per
architecture checks in src/nouveau/compiler/nak/sm70.rs? And that a "more
complete implementation" would be specialized to a point where it becomes
impossible to have any common code per architecture and in general?

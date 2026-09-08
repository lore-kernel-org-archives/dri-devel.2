Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D011C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B7FE10E13F;
	Tue,  8 Sep 2026 16:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MvRO6m7r";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8CD710E13F
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 16:57:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B5DBB42E67;
 Tue,  8 Sep 2026 16:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BE61F00A3A;
 Tue,  8 Sep 2026 16:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788886628;
 bh=VahQdN/0quUKghzDbd/rki/TpvW1Urg3Top+EN3xW/g=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=MvRO6m7rhVNT2KDjCad20J+tc+cViMc/grSglxqeOAunacaiFSwIlzP/VnhqX4/oP
 fLiCpUDe2Y3Up8XjAmf/E/j0BrE0eCRsvHGOnMdADqCJ97w6l6mVjWgYgDQxwiSumJ
 GEFbx7pzhhJkG8MLSj7H6dCMehMuJUW2xSOOTakgmj6o6dRxck6LHrYzXa2HHfCmmO
 S8QhXyZrbv7MNMO3nltEs3TXjeEVPQbD7ggfJN954CBAdgVnHwic8WM0HA0xqRzS4e
 t6QAadsyObN6tNTvCP07CnBBMfmpfUcLubRs5IlLZEChaam7UePgKRbZx1degxTW29
 eBPyEamldJ6pA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Sep 2026 18:57:04 +0200
Message-Id: <DLA3DUADGEQX.1Z2G7Z4TYFK1@kernel.org>
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
Cc: "Alistair Popple" <apopple@nvidia.com>, "nova-gpu"
 <nova-gpu@lists.linux.dev>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "M Henning" <mhenning@darkrefraction.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL3WXUPD5JKE.2GZ1CNJH539ID@kernel.org>
 <DL453EFS03T6.2VGI5TJEQ52QO@kernel.org>
 <apdvTgAp5eGezO5t@nvdebian.thelocal>
 <DL4QCAZXM8EU.2K8MLAM00VNTX@kernel.org>
 <apioGUDamrCur_oR@nvdebian.thelocal>
 <DL5MA26KZEF9.3KHKQXZ4JD2G6@kernel.org>
 <CAAgWFh2iPJzQ5PJfFpPBTdgZ=GFjy7Eoz5C0e1WwFMuOuyJSTQ@mail.gmail.com>
In-Reply-To: <CAAgWFh2iPJzQ5PJfFpPBTdgZ=GFjy7Eoz5C0e1WwFMuOuyJSTQ@mail.gmail.com>
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

On Tue Sep 8, 2026 at 4:48 PM CEST, M Henning wrote:
> On Thu, Sep 3, 2026 at 6:42=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>> Because userspace otherwise has to figure out the architecture itself ba=
sed on
>> the chipid, while the kernel already did derive this information.
>>
>> There's many ways userspace could do this, and I don't want to incentivi=
se any
>> of them.
>>
>> For instance, you previously showed how userspace derives the SM value f=
rom the
>> chipid with sm_for_chipset() in mesa with its own lookup table.
>>
>> Then in NAK (src/nouveau/compiler/nak/ir.rs), there's this code.
>>
>>         fn is_turing(&self) -> bool {
>>             self.sm() >=3D 73 && self.sm() < 80
>>         }
>>
>>         fn is_ampere(&self) -> bool {
>>             self.sm() >=3D 80 && self.sm() < 89
>>         }
>>
>>         fn is_ada(&self) -> bool {
>>             self.sm() =3D=3D 89
>>         }
>>
>>         #[allow(dead_code)]
>>         fn is_hopper(&self) -> bool {
>>             self.sm() >=3D 90 && self.sm() < 100
>>         }
>>
>>         fn is_blackwell_a(&self) -> bool {
>>             self.sm() >=3D 100 && self.sm() < 110
>>         }
>>
>>         fn is_blackwell_b(&self) -> bool {
>>             self.sm() >=3D 120 && self.sm() < 130
>>         }
>>
>>         fn is_blackwell(&self) -> bool {
>>             self.is_blackwell_a() || self.is_blackwell_b()
>>         }
>>
>> That's two unnecessary indirections for something the kernel already has
>> available.
>
> Userspace mostly uses sm id and engine id for feature checks, and I'd
> like to keep it that way.

Please note that I did not ask to change any of that in the context of
chipset/architecture enums.

What I said is that I don't want to incentivise userspace to derive the
architecture of a chip on its own, given that the kernel already does this.=
 (If
it is never needed, that's fine too, then we don't need to export it. :)

Of course, architecture and engine class id can't be used interchangeably. =
The
engine class id is more fine grained. For instance, the engine class id is
different for GA100 compared to all other Ampere chips.

At a quick glance the code above looked to me as if it doesn't care about t=
he
engine class id, because the granularity is architecture granularity and no=
t
engine class id granularity. But at a second glance, I think you are actual=
ly
deriving the engine class id and it just happens that the code does not nee=
d to
consider e.g. AMPERE_A vs. AMPERE_B, which is why you don't have an
is_ampere_{a,b}() accessor I suppose.

That said, nova can easily export the engine class id information instead o=
f the
architecture; the kernel will likely need the engine class id anyway. (Alth=
ough
it depends a bit on the GSP-RM API, I think technically it could get away
without the driver passing it in.)

>> Yeah, although if SM is correctly reported by the GSP, I'd rather have i=
t
>> exported in an info structure than have userspace create its own lookup =
table.
>
> As others have stated, the sm ids reported by firmware don't always
> match the sm ids documented in cuda-related materials. and nvk follows
> the cuda conventions here.

Yes, Alistair confirmed this too:

	Yes, I did look into this. Unfortunately the SM version GSP currently
	reports is different from the SM userspace code generation tools need (I
	have no idea why, there appear to be way too many SM versions).

However, I don't think we have to just give up on all this. We have NVIDIA
people working on the project and firmware changes are made specifically fo=
r the
project already. So, ultimately I think it would be great to understand why=
 that
is and possibly provide the correct information.

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541FDC624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:42:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8971B10F500;
	Thu,  3 Sep 2026 10:42:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hchOmgCG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23A2910F500
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 10:42:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6B55A600D4;
 Thu,  3 Sep 2026 10:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2531F000E9;
 Thu,  3 Sep 2026 10:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788432134;
 bh=0lWKLgh9eROD9CpNagoMw/8kDXcGbqx0WiEENGbiO/0=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=hchOmgCGObpETYFPP/wLKvhpGZiFBT2bB/hOOF5JYGlS9ZOv973UwtuYstyBn/COB
 IGViO6+tgsHZANNtumAnQoCNeb6eTV7tD+aTtlrADeX/qSTHvTy8KR8FlmzGAJrQcx
 TPYZc5OdkeCvldGfF167u9GLS3iAsSkfnAJSqphgq6X2CTjuMMszIV0Q8wLozXMZhC
 rzY0wUwL3oymmarSxqH2R3ca/++bL9Z9sTAl2qOMAfZLHPoK4d7OgcTYIFPw1FKiwh
 i3dkbmC1i56sS96tMeNdvYuxjJhuFTh/gs1mHHsuPXUsAmIQ4ygBGSgNXQoRq0xl8J
 /+dlNcHeC10TA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 12:42:09 +0200
Message-Id: <DL5MA26KZEF9.3KHKQXZ4JD2G6@kernel.org>
Cc: "nova-gpu" <nova-gpu@lists.linux.dev>, "M Henning"
 <mhenning@darkrefraction.com>, "Alice Ryhl" <aliceryhl@google.com>, "David
 Airlie" <airlied@gmail.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
 <DL3WXUPD5JKE.2GZ1CNJH539ID@kernel.org>
 <DL453EFS03T6.2VGI5TJEQ52QO@kernel.org>
 <apdvTgAp5eGezO5t@nvdebian.thelocal>
 <DL4QCAZXM8EU.2K8MLAM00VNTX@kernel.org>
 <apioGUDamrCur_oR@nvdebian.thelocal>
In-Reply-To: <apioGUDamrCur_oR@nvdebian.thelocal>
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

On Thu Sep 3, 2026 at 3:12 AM CEST, Alistair Popple wrote:
> Originally I thought the point of providing the decoded arch rather than
> chip-id

I think there never was a "rather than". The point was that if userspace ha=
s
conditionals based on the architecture it shouldn't have to figure it out b=
ased
on the chipid, as this has been done by the kernel already.

> because as you rightfully point out the kernel doesn't (currently at leas=
t)
> care much about the implementation

I still don't see how that value will ever be meaningful, there is no such =
thing
as "all GPUs of a certain implementation regardless of architecture" have
something in common, is it?

But since you say "currently at least", are there any plans to give this va=
lue
some meaning beyond being a unique counter for chips within a certain
architecture?

If so, I think that'd be a horrible way to encode some chip commonality.

> But we agreed that wasn't desirable, so now I'm still left figuring out w=
hy we
> need to provide an arch value? The chip-id already entirely encapsulates =
the
> concept, so what can/should user-space use the arch value for?

Because userspace otherwise has to figure out the architecture itself based=
 on
the chipid, while the kernel already did derive this information.

There's many ways userspace could do this, and I don't want to incentivise =
any
of them.

For instance, you previously showed how userspace derives the SM value from=
 the
chipid with sm_for_chipset() in mesa with its own lookup table.

Then in NAK (src/nouveau/compiler/nak/ir.rs), there's this code.

	fn is_turing(&self) -> bool {
	    self.sm() >=3D 73 && self.sm() < 80
	}
=09
	fn is_ampere(&self) -> bool {
	    self.sm() >=3D 80 && self.sm() < 89
	}
=09
	fn is_ada(&self) -> bool {
	    self.sm() =3D=3D 89
	}
=09
	#[allow(dead_code)]
	fn is_hopper(&self) -> bool {
	    self.sm() >=3D 90 && self.sm() < 100
	}
=09
	fn is_blackwell_a(&self) -> bool {
	    self.sm() >=3D 100 && self.sm() < 110
	}
=09
	fn is_blackwell_b(&self) -> bool {
	    self.sm() >=3D 120 && self.sm() < 130
	}
=09
	fn is_blackwell(&self) -> bool {
	    self.is_blackwell_a() || self.is_blackwell_b()
	}

That's two unnecessary indirections for something the kernel already has
available.

> It really boils down to how much static config info we want to encode int=
o
> kernel lookup tables vs. user-space lookup tables. I don't this we should=
 be
> filling the kernel with a bunch of static struct lookups just to ship tho=
se
> struct definitions to user-space. It seems more reasonable to put that in
> user-space, unless of course the kernel needs it.
>
> So I think your "does the kernel need this" is a reasonable benchmark for
> deciding this.
>
> As I think you're hinting at it would be ideal if GSP or some other firmw=
are
> table could just provide everything in some nice static config table, but=
 I
> don't think that's currently possible and looking at other user-space dri=
vers
> we're certainly not alone there.

Yeah, although if SM is correctly reported by the GSP, I'd rather have it
exported in an info structure than have userspace create its own lookup tab=
le.

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762B5FF8873
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 13:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 807AB10E5AF;
	Thu, 30 Apr 2026 13:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fGoPJO7X";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F246210E5AF
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 13:36:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CA52841811;
 Thu, 30 Apr 2026 13:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9CFC2BCB3;
 Thu, 30 Apr 2026 13:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777556178;
 bh=yY9NYXCtY5JDgSBUBfNy8huUBY+6EKtf7LJCZ9GZzQk=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=fGoPJO7XTCigvOtBssq5CuKro5zjXHaSAu2tlgV8d2dFBKv9/1bRfnaqayqKiyWKA
 U/Draq/tJjr7hA4oxqU0OrrzZE5kvGJJcVikG5KuXIEBrjie34C8e5wnxwvV5dVLQt
 rADxS3J3rGUEU2M3QK+Vv2wr9a62TqF5a52Y4prW9YLt+juStiKtQgNRxwT2jEZ/vS
 Dvyr50gw13sSY7M+NoJI5VP9G5fSCByL1j+NXSBXkzbI+l35hZhjcCRmU00QzZ63fj
 T5yIJohCC410Vnx5l4x3kDQi8kLfbQ8XjUs5thZfTRAAvPvIVZ7Y9zjP82YtuzQFIb
 cIdBPz/DTo5NA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 15:36:11 +0200
Message-Id: <DI6J2O3THBON.30TCZ9GDGHJO1@kernel.org>
Subject: Re: [PATCH 00/24] rust: device: Higher-Ranked Lifetime Types for
 device drivers
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260427221155.2144848-1-dakr@kernel.org>
 <afMdfs0segrRBx34@google.com>
In-Reply-To: <afMdfs0segrRBx34@google.com>
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

On Thu Apr 30, 2026 at 11:14 AM CEST, Alice Ryhl wrote:
> Super cool to see this!
>
> On Tue, Apr 28, 2026 at 12:10:58AM +0200, Danilo Krummrich wrote:
>> Before:
>>=20
>> 	struct MyDriver {
>> 	    pdev: ARef<pci::Device>,
>> 	    bar: Devres<pci::Bar<BAR_SIZE>>,
>> 	}
>>=20
>> 	let io =3D self.bar.access(dev)?;
>> 	io.read32(OFFSET);
>>=20
>> After:
>>=20
>> 	struct MyDriver<'a> {
>> 	    pdev: &'a pci::Device,
>> 	    bar: pci::Bar<'a, BAR_SIZE>,
>> 	}
>>=20
>> 	self.bar.read32(OFFSET);
>
> I think we should establish a convention for how to name the lifetime
> early. Using just the generic name 'a is probably not ideal.
>
> How about using 'dev for lifetimes that correspond to the lifetime of
> the device being bound?

I'd rather not go for 'dev, as it could be confused with the lifetime of th=
e
struct device itself, which is reference counted and independent from the d=
evice
/ driver binding lifecycle.

People already confuse this all the time, so I'd rather go for 'bound, whic=
h is
more precise, but could be a bit long on the other hand.

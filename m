Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77556FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 23:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 824CE10E1C3;
	Tue,  5 May 2026 23:12:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nLeKvUQ4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 841AA10E1C3
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 23:12:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A3BAA60123;
 Tue,  5 May 2026 23:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA06C2BCB4;
 Tue,  5 May 2026 23:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778022732;
 bh=KphMG9jiVB2OJLAMUTdfTkFkyrHOjO80/tesl+RVVT4=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
 b=nLeKvUQ4j8NIWpLtl1VhRpd7s/lcvYTFSFEoiUp9vRAz62tcyYHXsUPNFhXmV8TDe
 G7q956NMUdSYHXKkOdo7is74GUwJULIsEK+a275FEgVuiTLveWpR+rkehdw8gnQCkA
 fdv/djTHNVNdosNV21qzbhndSyB70D+tz8zTT/pBV5zxlP0v+2Oy8DEiMMlMfrROKZ
 euUccuMQeFMdz5SfhBooRT+NpOTI5VCf0IgX/95pYP6Niz6/2x/GK0pgJ8uKzEsJlo
 8u0Ic+b5QLdBuIkGDKm1GJqzejs8qnbsZZdSel9xT3nYWTsum3Xmk2jWyIWL+nm0BW
 gJlAK9RKF9MMQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 May 2026 01:12:05 +0200
Message-Id: <DIB4GBS45L86.LTUCNRDL24Y3@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH REF 24/24] gpu: drm: tyr: use HRT lifetime for IoMem
References: <20260427221155.2144848-1-dakr@kernel.org>
 <20260427221155.2144848-25-dakr@kernel.org> <afp1rLvvdh_mo_g7@um790>
In-Reply-To: <afp1rLvvdh_mo_g7@um790>
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

On Wed May 6, 2026 at 12:56 AM CEST, Deborah Brouwer wrote:
> Is the intended model that DRM drivers keep lifetime-bound resources such=
 as
> IoMem<'bound> only in platform drvdata and access them via Device::drvdat=
a_borrow()?

No, this method is unsafe and intended for busses only, drivers should neve=
r use
it directly.

> Or is the expectation that drm::Driver should also have a lifetime-parame=
terized
> Data associated type?

Exactly, the plan is to have lifetime-parameterized private data on the
drm::Registration, which is available in IOCTLs. The cover letter mentions =
that
briefly:

    A follow-up series extends this to class device registrations, starting=
 with
    DRM, so that class device callbacks (IOCTLs, etc.) can safely access de=
vice
    resources through the separate registration data bound to the registrat=
ion's
    lifetime without Devres indirection.

This becomes possible as I also have patches that protect DRM IOCTLs throug=
h the
drm::UnbindGuard (which is just drm_dev_enter() and drm_dev_exit()). Togeth=
er
with drm_dev_unplug() being called when the drm::Registration is dropped al=
l
IOCTLs are guaranteed to provide a bound scope of the underlying bus device=
 and
hence the device resources in the DRM registration data availble through th=
e
IOCTLs.

I have all those patches ready and I plan to send them this week.

> The reason I ask is that Tyr currently stores an MMIO handle in several a=
reas,
> (firmware, MMU/address-space management, and IRQ handling)  and it does r=
egister
> accesses directly. See what we're trying to do:
> https://lore.kernel.org/rust-for-linux/20260424-b4-fw-boot-v4-v4-0-a5d910=
50789d@collabora.com/

Note that you are not blocked by this, you can always move IoMem<'_> into a
Devres through IoMem::into_devres() and use it without lifetime bounds. But=
 of
course the goal is to make this unnecessary.

> Moving IoMem<'bound> only into platform drvdata would require a big refac=
tor
> to thread &IoMem<'_> through those paths or fetch it from drvdata at each=
 hardware
> access site. So, I wanted to clarify the plan first before I start this w=
ork.

No worries, that'd be the exact opposite of what we want to achieve. :)

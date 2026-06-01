Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1104CD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 09:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E95B0113151;
	Mon,  1 Jun 2026 09:54:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CuaEjX0R";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DB0E113144
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 09:54:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A6BBE60098;
 Mon,  1 Jun 2026 09:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA8E1F00893;
 Mon,  1 Jun 2026 09:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780307690;
 bh=GlXiKKGGXoAPCiK24bzKUEBDD83IrCG0X1CTDeGYU48=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=CuaEjX0RmkhGPphKmnkOXYLrNkY0aJdGGnFU0JOy4SXkhs627PCUffF27UNl01nDi
 aGARn+rdJTUXJ2DI5R3HOXS232JhWqcs07JEm3BFRjidwMgVPDVT/qMeYGhctCCc/u
 Vw+PxenEmwA6mc+3XJz4AahOXqe+QtQ4qVOyvr4H71gic6Zp2dfb20BpR/OQyGdMD4
 6CUOu9iUBcFXNaFVkE8xQZ26ReH1524zenk2zztBMbRt6nSLb25erZb2hDK7m9EiZU
 j7xKoow14PjesufnCVG0/H7eKbeonu6mGZMUxrpf9XbjUjKEAl8E5aXItOrL9mq0zV
 5wVqwpp+vKwWw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 11:54:47 +0200
Message-Id: <DIXMEKSYML5D.1JUXO9CW10RY8@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/2] drm/tyr: use IoMem directly instead of Devres
Cc: <daniel.almeida@collabora.com>, <boris.brezillon@collabora.com>,
 <deborah.brouwer@collabora.com>, <gary@garyguo.net>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>
References: <20260529000106.2257996-1-dakr@kernel.org>
 <20260529000106.2257996-3-dakr@kernel.org> <ah1SSN8_dCEA4Osz@google.com>
In-Reply-To: <ah1SSN8_dCEA4Osz@google.com>
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

On Mon Jun 1, 2026 at 11:35 AM CEST, Alice Ryhl wrote:
> On Fri, May 29, 2026 at 02:00:54AM +0200, Danilo Krummrich wrote:
>> Now that IoMem is lifetime-parameterized, use it directly in probe
>> rather than wrapping it in Devres and Arc. The I/O memory mapping is
>> only used during probe and not stored in driver data, so device-managed
>> revocation is unnecessary.
>>=20
>> This removes the Devres access(dev) pattern from issue_soft_reset(),
>> GpuInfo::new(), and l2_power_on(), simplifying register access.
>>=20
>> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
>> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>
>> -pub(crate) type IoMem =3D kernel::io::mem::IoMem<'static, SZ_2M>;
>> +pub(crate) type IoMem<'a> =3D kernel::io::mem::IoMem<'a, SZ_2M>;
>
> It'd make more sense for me to put 'b or 'bound here.

You can name it 'b of course, but the semantics for 'bound has been agreed =
to
describe the lifetime of something actually being in place for the entire
duration of a device being bound to a driver, which isn't the case here.

>>          let sram_regulator =3D Regulator::<regulator::Enabled>::get(pde=
v.as_ref(), c"sram")?;
>> =20
>>          let request =3D pdev.io_request_by_index(0).ok_or(ENODEV)?;
>> -        let iomem =3D Arc::new(request.iomap_sized::<SZ_2M>()?.into_dev=
res()?, GFP_KERNEL)?;
>> +        let iomem =3D request.iomap_sized::<SZ_2M>()?;
>> =20
>>          issue_soft_reset(pdev.as_ref(), &iomem)?;
>>          gpu::l2_power_on(pdev.as_ref(), &iomem)?;
>> =20
>> -        let gpu_info =3D GpuInfo::new(pdev.as_ref(), &iomem)?;
>> +        let gpu_info =3D GpuInfo::new(&iomem);
>
>
> While this change is fine, I notice that we don't actually keep the
> iomem alive past the probe method. I assume we're going to need that,
> which leads to the question of whether we can store the iomem in the
> places we need it.
>
> As far as I can tell, we can store it in TyrPlatformDriverData but not
> in TyrDrmDeviceData, is that right?

TyrDrmDeviceData will eventually become the drm::Registration data, so it w=
ill
be a ForLt type as well and IoMem<'a> can directly be stored in there.

The DRM device private data being tied to the lifetime of the DRM device it=
self
doesn't seem to be useful anymore after IOCTLs won't potentially reach into=
 the
driver after device unbind anymore.

In the meantime (or even after this change, although I wouldn't recommend t=
hat),
you can call into_devres() before storing it in TyrDrmDeviceData.

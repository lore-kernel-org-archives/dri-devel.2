Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780A9C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 18:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D705C10E3BB;
	Thu, 16 Jul 2026 18:54:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mPUqM0XL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04B3F10E3BA
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 18:54:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 646D660A5E;
 Thu, 16 Jul 2026 18:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881011F000E9;
 Thu, 16 Jul 2026 18:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784228045;
 bh=CpjCml4qMFL3yTbWaJPv1RUPrR/EKtPy2332MSze4KA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mPUqM0XLRSnNsEPX3W3UuSs2ww0bygwsRDRQVojfchHUX2ebJL0Xuykczn+8tzajU
 FQTBtAFgZUXWHnYK0GpWBhCPPQ36yj9UCEsQw1XhAabAKyD9qkbUKoqoZqWUmZQgWf
 Yc4cMcLHmYfD1wmqSywCpywCmg2hbZ6SCu5NrROQDxsu1oo7ESyJyMwTvGunKlA3d7
 l8sYz5np3KaoJhGu0RO3T4HfwmcYZMCvvMSrGHwu4ywwZgxa0TnAwzm5gi9dydFVRc
 lGuzVVl8Kl0VUqrfipbc0xj36x7FhOjtlfic5qRY3DVfHLwZi3KCfhaNKM1ZxWWsOx
 QShMn0WzgSkhA==
Date: Thu, 16 Jul 2026 20:54:02 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-tegra@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, Santosh BS <santoshb@nvidia.com>
Subject: Re: [PATCH v2 0/7] Host1x/VIC support on Tegra264
Message-ID: <alkooiOtlIF-OZy4@orome>
References: <20260622-t264-host1x-v2-0-ff7364d9ff7b@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="o5jrspissrvotivf"
Content-Disposition: inline
In-Reply-To: <20260622-t264-host1x-v2-0-ff7364d9ff7b@nvidia.com>
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


--o5jrspissrvotivf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/7] Host1x/VIC support on Tegra264
MIME-Version: 1.0

On Mon, Jun 22, 2026 at 03:57:37PM +0900, Mikko Perttunen wrote:
> Hello everyone,
>=20
> this series adds support for Host1x and VIC on Tegra264 SoCs.
> The Host1x side is not very interesting, just adding the usual register
> definitions and other information. One thing of note is that multimedia
> engines apart from VIC have moved away from Host1x on this generation.
>=20
> On the VIC side, there is a bit more of a change, as the VIC Falcon is
> now RISC-V based. Unlike NVDEC, VIC is still "externally booted", so
> the boot sequence is very similar to before.
>=20
> host1x uapi-test[1] has been updated for Tegra264. Necessary headers for=
=20
> constructing VIC jobs have been added to open-gpu-doc[2].
>=20
> Patches 1 and 2 add new compatible strings to Host1x and VIC device tree
> bindings.
>=20
> Patch 3 fixes the context device device tree parsing code to handle
> iommu-map entries with length more than 1.
>=20
> Patch 4 adds Tegra264 support to the Host1x driver.
>=20
> Patches 5 and 6 add Tegra264 support to the VIC driver.
>=20
> Patch 7 adds Host1x and VIC nodes to the Tegra264 device tree.
>=20
> Thank you,
> Mikko
>=20
> [1] https://github.com/cyndis/uapi-test
> [2] https://github.com/NVIDIA/open-gpu-doc/blob/master/classes/video/clce=
b6.h
>     https://github.com/NVIDIA/open-gpu-doc/blob/master/classes/video/vic_=
ceb6_types.h
>=20
> ---
> Changes in v2:
> - Updated dt-bindings changes to be chip-specific
> - Link to v1: https://patch.msgid.link/20260612-t264-host1x-v1-0-8d934987=
de67@nvidia.com
>=20
> ---
> Mikko Perttunen (6):
>       dt-bindings: display: tegra: Changes to support Tegra264
>       dt-bindings: display: tegra: Add Tegra264 compatible for VIC
>       gpu: host1x: Correctly parse linear ranges of context devices
>       drm/tegra: falcon: Add support for RISC-V external boot
>       drm/tegra: vic: Add Tegra264 support
>       arm64: tegra: Add Host1x and VIC on Tegra264
>=20
> Santosh BS (1):
>       gpu: host1x: Add Tegra264 support
>=20
>  .../display/tegra/nvidia,tegra124-vic.yaml         |   1 +
>  .../display/tegra/nvidia,tegra20-host1x.yaml       |  20 ++-
>  arch/arm64/boot/dts/nvidia/tegra264.dtsi           |  63 +++++++
>  drivers/gpu/drm/tegra/drm.c                        |   1 +
>  drivers/gpu/drm/tegra/falcon.c                     |  66 ++++++--
>  drivers/gpu/drm/tegra/falcon.h                     |  23 +++
>  drivers/gpu/drm/tegra/vic.c                        |  95 ++++++++---
>  drivers/gpu/drm/tegra/vic.h                        |   9 +-
>  drivers/gpu/host1x/Makefile                        |   3 +-
>  drivers/gpu/host1x/context.c                       |  13 +-
>  drivers/gpu/host1x/dev.c                           |  41 +++++
>  drivers/gpu/host1x/hw/cdma_hw.c                    |  12 +-
>  drivers/gpu/host1x/hw/host1x10.c                   |  33 ++++
>  drivers/gpu/host1x/hw/host1x10.h                   |  15 ++
>  drivers/gpu/host1x/hw/host1x10_hardware.h          |  21 +++
>  drivers/gpu/host1x/hw/hw_host1x10_common.h         |   6 +
>  drivers/gpu/host1x/hw/hw_host1x10_hypervisor.h     |  10 ++
>  drivers/gpu/host1x/hw/hw_host1x10_uclass.h         | 181 +++++++++++++++=
++++++
>  drivers/gpu/host1x/hw/hw_host1x10_vm.h             |  36 ++++
>  19 files changed, 601 insertions(+), 48 deletions(-)
> ---
> base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
> change-id: 20260313-t264-host1x-c97171fdde77

Patches 1-6 applied to drm-misc-next. I'll pick up patch 7 into the
Tegra tree because it looks like there will be a conflict.

Thanks,
Thierry

--o5jrspissrvotivf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpZKMoACgkQ3SOs138+
s6G4KQ//ebtuNr5aOo89zzDeWrMvvJTVayssLnFhT9bMtVMUD0ZPgVMU8xjo+8ty
j5U696bYojLN85rUr21HAtVyvOM+TvwZmPBULZKn0dGxr3r6JsVmt2oC86CUumCl
xD25XFItD4ZDNVW+MT9koP+9qfDTjZAH4moKWzkZ6+RH4Dw9VZUl41BqKGxZqwQV
o/a29mu+F8U5yxe9hNuLy15mtuWNhGSV7PxWAk3qXI8y0mEp+sAcB2ZexnKo99dd
Arxi9pTN/t9wSPvA9aMwR0jAaXIW7s1LTHPo/k+zgLRfLSx9ZvgEweTzfEKkTD+I
1DnL5oIg7xrwPXSfjZvC2Hlh60G9YMAuHwT/raMDVZWLfRXs1rdBCYESip4FAaGk
tKzW/10IC6xlHyTv/KP9C0wnNHWY9NxajQJ3rptnHXFZeOITgDwMls5SKUg+VIR8
iqssz9qeFOyQapal65F/K/Q2COlRDvunfg7MiTjmoDw2VOf3wnWdUf21UAx7+khr
CbxM+x52BT3l+vcByu7TLxyJfBQXrTX58FqxBY900Om8AqRwe0bJkFUGqlwGmWOU
qu4ZwHgHbKVJXXf4+jqE7lC8zwK0BinkfpziTPTSGXY+eZxMDjZVnexFbbho7MiA
g3y+aYTGWKsOGfP9zBqSK2OqiVCh1s1bgguKyJybaAnvUCEPTNg=
=o0iL
-----END PGP SIGNATURE-----

--o5jrspissrvotivf--

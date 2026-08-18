Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9304BC5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E635210EC93;
	Tue, 18 Aug 2026 20:28:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="D8vfE1nh";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FA7110EC93
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 20:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787084904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0ffqp7Xz/ZYVnnLDx+BG01wtPPh+Wbb40o+e3kNBjk=;
 b=D8vfE1nhQeqn1JMKMXs4UPmTMp/APhnatmr4n/Z8GlHNzbbGm567YFS7npc0wtcUIjIESn
 /SodxHBB90H7Pw5IJUDWjKmuto4CN/5uBoVmeywGwKzQ0FBUO/l3xHkMHn90ReY6vH9n0s
 2kffTVbkwAVngJX05CvoPQZnuNwbkVE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-HvEPgICXPoWzAi8fWjknKA-1; Tue, 18 Aug 2026 16:28:21 -0400
X-MC-Unique: HvEPgICXPoWzAi8fWjknKA-1
X-Mimecast-MFC-AGG-ID: HvEPgICXPoWzAi8fWjknKA_1787084901
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5174a236220so2877031cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 13:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787084901; x=1787689701;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g7sv2BOM2TPac5OT6sZnf4rDXBLeaI6F0QDOj1pWNlY=;
 b=kL3HHjqxEeWay9A2TnQiqbghU7UEfct0kTRaZ0jZhhdNwE3LGsTCiXvk4qr5gtMsKk
 vs1YcFMuu238pQUAlsJp8CaqGBKJvIc9SZn/4wp4o9vX6HsmoELjgcrFXFEsu8KqJBKM
 ivkM/vCyNCiV429Y6THmdggBQs8O5pC2PArx5VpMBQi5gpI/2MS46EUMS+HLgiNATDfz
 TBcZCZBenHVcmTXytaxUxiX4Tued6CG1m/jUPpBo6qeUPnkU9njAYqFVCkoNQUZScCRh
 +brNvoSJ/s0OCHMa7sStDsqXJdlVAtMhvZSkYb/qXJvrhBn3gRIGw2gcBcTzF28R79ia
 5u5w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGISXA+IaqPaX0fr7GZEUpGF9X1dbB0HepVRn8gScpJNtGyb+mREO8INMrsRFunMAJu90yhhtDgZY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzEtWpMgTDjH/aglS3h7IKaxqBH+rp+Ykg6KqKyOHkVdVHjuIpR
 NouXymMoulfuLypHHmfzVvVwk2ZtGH7JW6oZvym6l8mY80uS+C8zMMYsAJTTwJ8fok8Ds1kE3zE
 npqxIwMAcaacBCaZHGpVE7eN/8qBa699vb44/UJeTjQcKWjH1KgILOjTc0kpRHCo3XF0Tvw==
X-Gm-Gg: AR+sD10U0LyfsZ+FPHDTqVtEWVGZRaRGI/0bd/WnXjh6Jt1ZPbQH3Yxizta/f6eTkUw
 gTdkMR1mwZXgLDj8pI7HA3T2X1DbiPReiFeaGWkKLcsrSB4rXXRibREWyalbj1o0EAIWW1i2PK2
 2A431URtquTSy60CdxBixE1GHdP6hfcZaZJX+ZeMNqeXNtIfu/x9nQvEovI6GEae6Nwjz7FjN96
 KZaxv6HgyyPHikoqjJrEFid10qkdcfVsGTCIZunbFvbROOSDECtvlrpNmq4/qMVnYXjYivL/Z7Q
 JzgqSnpZyX868u4t7I/W2TuJ0kI6QIOv/kDJ9mwcg/tPefA9zNfi1HF5BHtlIuI8FGJnPkF5
X-Received: by 2002:a05:622a:1a99:b0:51b:fe30:b8da with SMTP id
 d75a77b69052e-52dd32cc365mr7489611cf.33.1787084900601; 
 Tue, 18 Aug 2026 13:28:20 -0700 (PDT)
X-Received: by 2002:a05:622a:1a99:b0:51b:fe30:b8da with SMTP id
 d75a77b69052e-52dd32cc365mr7488991cf.33.1787084900104; 
 Tue, 18 Aug 2026 13:28:20 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52db60eb025sm47437921cf.5.2026.08.18.13.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 13:28:19 -0700 (PDT)
Message-ID: <70ff3bb7914899d845e884eea00b47621d295e3a.camel@redhat.com>
Subject: Re: [PATCH v4 1/2] drm/nouveau/pci: use config-space MSI rearm on
 MCP79/MCP7A (NVAC)
From: lyude@redhat.com
To: Marek Czernohous <mczernohous@gmail.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Date: Tue, 18 Aug 2026 16:28:19 -0400
In-Reply-To: <178688574401.522643.12812428444459119913@gmail.com>
References: <178688574400.522643.6695278742335367229@gmail.com>
 <178688574401.522643.12812428444459119913@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iEezos89KUsNuFvW6wFEnoJvrjtOugiAKCNnC3A1hn0_1787084901
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Sun, 2026-08-16 at 15:09 +0200, Marek Czernohous wrote:
> From: Marek Czernohous <marek@czernohous.de>
>=20
> NVAC (MCP79/MCP7A) uses g94_pci_func, whose .msi_rearm is
> nv40_pci_msi_rearm(): a re-arm write through the MMIO mirror of PCI
> config space.=C2=A0 On this IGP that path is unreliable; when a re-arm is
> missed the interrupt line stays dead, command submission times out
> and
> the GPU appears hung until reboot.=C2=A0 On an Apple Mac mini (early 2009=
,
> MCP79, boot0 0x0ac080b1) this showed as sporadic fifo timeouts and
> GPU
> hangs under load unless MSI was disabled via config=3DNvMSI=3D0.
>=20
> Give NVAC its own pci func that re-arms through real PCI config space
> (nv46_pci_msi_rearm) instead.=C2=A0 This follows existing precedent:
> nv46.c
> documents the MMIO-mirror re-arm as broken on several related parts,
> and commit 5112abc6a433 ("drm/nouveau/pci/g92: Fix rearm") fixed g92
> the same way while moving the remaining chipsets, NVAC included, into
> the newly added shared g94 table, where NVAC stayed on the MMIO path.
> This change completes that fix for NVAC.=C2=A0 The sibling IGP NVAA
> (MCP77/MCP78) has MSI disabled entirely as "reported broken" in
> nvkm_pci_new_(); NVAC works correctly once the re-arm goes through
> config space, so disabling MSI is not necessary.
>=20
> Only NVAC is switched: that is the hardware this has been validated
> on.=C2=A0 The other users of g94_pci_func (G94/G96/G98/GT2xx and the
> MCP77/MCP89 IGPs) keep their current behavior; MCP77 and MCP89
> plausibly want the same treatment but were not tested.
>=20
> Tested on the Mac mini as a daily driver for two months with MSI
> enabled and zero fifo timeouts.=C2=A0 Independently confirmed stable on a=
n
> iMac9,1 (MCP79) running 6.12.90 with the v1 form of this change (the
> same one-line functional switch, applied to that kernel's g94
> implementation).
>=20
> Fixes: 5112abc6a433 ("drm/nouveau/pci/g92: Fix rearm")
> Cc: <stable@vger.kernel.org> # v6.16+
> Tested-by: Fab Stz <fabstz-it@yahoo.fr>
> Assisted-by: Claude:claude-opus-4-7
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Marek Czernohous <marek@czernohous.de>
> ---
> =C2=A0.../gpu/drm/nouveau/include/nvkm/subdev/pci.h |=C2=A0 1 +
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/device/base.c |=C2=A0 2 +-
> =C2=A0.../gpu/drm/nouveau/nvkm/subdev/pci/Kbuild=C2=A0=C2=A0=C2=A0 |=C2=
=A0 1 +
> =C2=A0.../gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c=C2=A0=C2=A0 | 35
> +++++++++++++++++++
> =C2=A04 files changed, 38 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c
>=20
> diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
> b/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
> index 112b674ed9c8..0172e0d200f8 100644
> --- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
> +++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
> @@ -46,6 +46,7 @@ int nv4c_pci_new(struct nvkm_device *, enum
> nvkm_subdev_type, int inst, struct n
> =C2=A0int g84_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int
> inst, struct nvkm_pci **);
> =C2=A0int g92_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int
> inst, struct nvkm_pci **);
> =C2=A0int g94_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int
> inst, struct nvkm_pci **);
> +int mcp79_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int
> inst, struct nvkm_pci **);
> =C2=A0int gf100_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int
> inst, struct nvkm_pci **);
> =C2=A0int gf106_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int
> inst, struct nvkm_pci **);
> =C2=A0int gk104_pci_new(struct nvkm_device *, enum nvkm_subdev_type, int
> inst, struct nvkm_pci **);
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
> index ea62dc97f118..f7e02a16e5bc 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
> @@ -1237,7 +1237,7 @@ nvac_chipset =3D {
> =C2=A0=09.mc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, g98_mc=
_new },
> =C2=A0=09.mmu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, mcp77_mmu_n=
ew },
> =C2=A0=09.mxm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, nv50_mxm_ne=
w },
> -=09.pci=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, g94_pci_new },
> +=09.pci=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, mcp79_pci_new },
> =C2=A0=09.therm=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, g84_therm_new },
> =C2=A0=09.timer=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, nv41_timer_new },
> =C2=A0=09.volt=C2=A0=C2=A0=C2=A0=C2=A0 =3D { 0x00000001, nv40_volt_new },
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild
> b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild
> index a14ea0f7b1c8..90f03baeb22a 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/Kbuild
> @@ -9,6 +9,7 @@ nvkm-y +=3D nvkm/subdev/pci/nv4c.o
> =C2=A0nvkm-y +=3D nvkm/subdev/pci/g84.o
> =C2=A0nvkm-y +=3D nvkm/subdev/pci/g92.o
> =C2=A0nvkm-y +=3D nvkm/subdev/pci/g94.o
> +nvkm-y +=3D nvkm/subdev/pci/mcp79.o
> =C2=A0nvkm-y +=3D nvkm/subdev/pci/gf100.o
> =C2=A0nvkm-y +=3D nvkm/subdev/pci/gf106.o
> =C2=A0nvkm-y +=3D nvkm/subdev/pci/gk104.o
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c
> new file mode 100644
> index 000000000000..e2ae242f1aa7
> --- /dev/null
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2026 Marek Czernohous
> + *
> + * MCP79/MCP7A (NVAC): like g94, but MSI re-arm goes through real
> PCI
> + * config space.=C2=A0 The MMIO-mirror re-arm is unreliable on this IGP
> and a
> + * missed re-arm kills the interrupt line (see the nv46 comment; g92
> + * already re-arms through config space for the same reason).
> + */
> +#include "priv.h"
> +
> +static const struct nvkm_pci_func
> +mcp79_pci_func =3D {
> +=09.cfg =3D { .addr =3D 0x088000, .size =3D 0x1000 },
> +
> +=09.init =3D g84_pci_init,
> +=09.msi_rearm =3D nv46_pci_msi_rearm,
> +
> +=09.pcie.init =3D g84_pcie_init,
> +=09.pcie.set_link =3D g84_pcie_set_link,
> +
> +=09.pcie.max_speed =3D g84_pcie_max_speed,
> +=09.pcie.cur_speed =3D g84_pcie_cur_speed,
> +
> +=09.pcie.set_version =3D g84_pcie_set_version,
> +=09.pcie.version =3D g84_pcie_version,
> +=09.pcie.version_supported =3D g92_pcie_version_supported,
> +};
> +
> +int
> +mcp79_pci_new(struct nvkm_device *device, enum nvkm_subdev_type
> type, int inst,
> +=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nvkm_pci **ppci)
> +{
> +=09return nvkm_pci_new_(&mcp79_pci_func, device, type, inst,
> ppci);
> +}


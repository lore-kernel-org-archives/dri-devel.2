Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7A4C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 04:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEC0F10E204;
	Wed, 29 Jul 2026 04:30:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WsXeH2rp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C16B10E204
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 04:30:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 223AE60A5F;
 Wed, 29 Jul 2026 04:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A327F1F000E9;
 Wed, 29 Jul 2026 04:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785299398;
 bh=hvGlLWnB+EYIimTBLlCfoWhL6F0aTTz0C3ddqBDJxB8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WsXeH2rpiRzA8riFLXf/ckvru9vaM0doqUmzpn6NCB5K1MCyCU9yP2qEwbgU7Z0xX
 vNP+gYtPUfzRcoAlc7Ptcdkj3yuqxiOHBoiXxXh05ALBDMMFtxrU/Rj7uh5yETFnnQ
 BosYo9RtxaWTdhzT+5lZmfZaGsaZ9j6lsdTwn3zZbie1HZ3xltbdcPGGECC5HIeOmn
 ywqMiLRvuvx6NhM/3noSjOeOsONJm1Bs5vCDi3QirgzZMYoIjVR0yPb8/a7mO1Yfme
 aG8xa/PIoZOoLKFSw/dFVfeq3EjH4y72TvRP8Ah6+bWWhSBht5iUv71CfMmX9W4DQ4
 56yHOrhKhDLLw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] nouveau/gsp: add some more fields to r570 system info
To: "Dave Airlie" <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729041653.3985549-6-airlied@gmail.com>
References: <20260729041653.3985549-1-airlied@gmail.com>
 <20260729041653.3985549-6-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 04:29:58 +0000
Message-Id: <20260729042958.A327F1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The BAR index calculation for NVKM_BAR3_IO lacks bounds checking=
, leading to PCI ROM resource aliasing if all preceding BARs are 64-bit.
--

--- Patch [5]: [PATCH 5/6] nouveau/gsp: add some more fields to r570 system=
 info ---
commit 18c8db5e682be4972a386c192c00409e01054607
Author: Dave Airlie <airlied@redhat.com>

nouveau/gsp: add some more fields to r570 system info

This commit adds the pci io bar, link cap and os page size to the r570
system info.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c b/drivers/g=
pu/drm/nouveau/nvkm/engine/device/pci.c
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/pci.c
[ ... ]
> @@ -1576,6 +1576,10 @@ nvkm_device_pci_resource_idx(struct nvkm_device_pc=
i *pdev, enum nvkm_bar_id bar)
>  	if (bar =3D=3D NVKM_BAR2_INST)
>  		return idx;
> =20
> +	idx +=3D (pci_resource_flags(pdev->pdev, idx) & IORESOURCE_MEM_64) ? 2 =
: 1;
> +	if (bar =3D=3D NVKM_BAR3_IO)
> +		return idx;

[Severity: Medium]
Does this calculation lack a bounds check against PCI_STD_NUM_BARS?

If a GPU is configured with three 64-bit BARs (BAR0, BAR1, and BAR2), the
calculation idx +=3D 2 will occur three times. This results in idx becoming=
 6.

Since index 6 corresponds to PCI_ROM_RESOURCE, could this cause the IO BAR
lookup to accidentally alias with the PCI Expansion ROM resource?

> +
>  	WARN_ON(1);
>  	return -1;
>  }
[ ... ]
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c b/driv=
ers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
[ ... ]
> @@ -165,6 +165,7 @@ r570_gsp_set_system_info(struct nvkm_gsp *gsp)
>  	info->gpuPhysAddr =3D device->func->resource_addr(device, NVKM_BAR0_PRI=
);
>  	info->gpuPhysFbAddr =3D device->func->resource_addr(device, NVKM_BAR1_F=
B);
>  	info->gpuPhysInstAddr =3D device->func->resource_addr(device, NVKM_BAR2=
_INST);
> +	info->gpuPhysIoAddr =3D device->func->resource_addr(device, NVKM_BAR3_I=
O);

[Severity: Medium]
If the above index calculation results in 6 due to having three 64-bit BARs,
this assignment will populate info->gpuPhysIoAddr with the physical address
of the PCI Expansion ROM instead of a non-existent IO BAR.

Could exposing this incorrect hardware layout cause undefined firmware
behavior or hardware faults if the GSP firmware attempts to access the
ROM address assuming it is an IO space?

>  	info->nvDomainBusDeviceFunc =3D pci_dev_id(pdev);
>  	info->maxUserVa =3D TASK_SIZE;
>  	info->pciConfigMirrorBase =3D device->pci->func->cfg.addr;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729041653.3985=
549-1-airlied@gmail.com?part=3D5

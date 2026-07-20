Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE343C4452B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11BF810E11F;
	Mon, 20 Jul 2026 12:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XcBFQJSg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0488F10E11F
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:03:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 26A2F60A6A;
 Mon, 20 Jul 2026 12:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47061F00A3E;
 Mon, 20 Jul 2026 12:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784548997;
 bh=c47JGbkJ9uNuY4YLwhBCSuk3Djn77kjsuXEzQJm9LnI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XcBFQJSgIE6pLOtG0ILx3GMj2AOwigQwPqTAnf3eoRTCVp1M+tIPcsC+LcFoIdoOd
 11gmT3C8mCTNHpnVyhX+j5pmU9cPAFfEmb0Lw/ZIlExT65GqF2eSZwL/tyc4ua5j/h
 hZlEyQ+GuxhVeiyru7XoOH6mIbok/ZlGfYRYeyhv90dwDc3wihqGwlGl8caOOowqL3
 XU8QeekF3AvUwbx7zWqPyVFu8eUaZCC+qtp6cAAZE6kf6CXmq4+AWjVjmf8uFetlx5
 CJ1e2D7LMZCuyXCWAiFdbUpPHoQNryCbdYcUDvcAX/WPELfSaF97L1X6KjMXqbQiW3
 mSY0QOobNyykA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panthor: validate firmware interface structure sizes
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720114918.15973-1-osama.abdelkader@gmail.com>
References: <20260720114918.15973-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 12:03:17 +0000
Message-Id: <20260720120317.A47061F00A3E@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Time-of-Check to Time-of-Use (TOCTOU) vulnerability in firmwar=
e interface initialization allows kernel memory corruption.
- [High] Integer overflow and incorrect structure size in firmware bounds c=
hecks on 32-bit architectures.
- [High] NULL pointer dereference when firmware provides a 0-sized shared s=
ection.
--

--- Patch [1]: [PATCH] drm/panthor: validate firmware interface structure s=
izes ---
commit a126d5ded05975c89ebf69bcb6a208082b1f032d
Author: Osama Abdelkader <osama.abdelkader@gmail.com>

drm/panthor: validate firmware interface structure sizes

iface_fw_to_cpu_addr() only checks that the firmware-provided MCU virtual
address points inside the shared section. The returned pointer is later
used as a full firmware interface structure, so accepting an address near
the end of the shared section can still lead to out-of-bounds accesses.

Pass the expected object size to iface_fw_to_cpu_addr() and reject ranges
that do not fit entirely in the shared section.

> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index 90f59d782a809..1697305c7b0e9 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c

[ ... ]

> @@ -890,8 +896,10 @@ static int panthor_init_cs_iface(struct panthor_devi=
ce *ptdev,
> =20
>  	spin_lock_init(&cs_iface->lock);

[Severity: High]
This is a pre-existing issue, but could the bounds check earlier in
panthor_init_cs_iface() be vulnerable to a 32-bit integer overflow?

panthor_fw.c:panthor_init_cs_iface() {
    ...
    if (iface_offset + sizeof(*cs_iface) >=3D shared_section_sz)
        return -EINVAL;
    ...
}

If a malicious firmware provides crafted strides, could iface_offset wrap
around near U32_MAX on 32-bit architectures, allowing it to bypass this
check while still extending beyond shared_section_sz?

Also, does this check incorrectly use the size of the host wrapper struct
sizeof(*cs_iface) instead of the actual firmware struct size, allowing
an invalid iface_offset to pass the check if the host struct is smaller?

>  	cs_iface->control =3D ptdev->fw->shared_section->mem->kmap + iface_offs=
et;
> -	cs_iface->input =3D iface_fw_to_cpu_addr(ptdev, cs_iface->control->inpu=
t_va);
> -	cs_iface->output =3D iface_fw_to_cpu_addr(ptdev, cs_iface->control->out=
put_va);
> +	cs_iface->input =3D iface_fw_to_cpu_addr(ptdev, cs_iface->control->inpu=
t_va,
> +					       sizeof(*cs_iface->input));
> +	cs_iface->output =3D iface_fw_to_cpu_addr(ptdev, cs_iface->control->out=
put_va,
> +						sizeof(*cs_iface->output));

[ ... ]

> @@ -941,8 +949,10 @@ static int panthor_init_csg_iface(struct panthor_dev=
ice *ptdev,
> =20
>  	spin_lock_init(&csg_iface->lock);
>  	csg_iface->control =3D ptdev->fw->shared_section->mem->kmap + iface_off=
set;
> -	csg_iface->input =3D iface_fw_to_cpu_addr(ptdev, csg_iface->control->in=
put_va);
> -	csg_iface->output =3D iface_fw_to_cpu_addr(ptdev, csg_iface->control->o=
utput_va);
> +	csg_iface->input =3D iface_fw_to_cpu_addr(ptdev, csg_iface->control->in=
put_va,
> +						sizeof(*csg_iface->input));
> +	csg_iface->output =3D iface_fw_to_cpu_addr(ptdev, csg_iface->control->o=
utput_va,
> +						 sizeof(*csg_iface->output));
> =20
>  	if (csg_iface->control->stream_num < MIN_CS_PER_CSG ||
>  	    csg_iface->control->stream_num > MAX_CS_PER_CSG)

[Severity: Critical]
This is a pre-existing issue, but is there a Time-of-Check to Time-of-Use
(TOCTOU) vulnerability here and in panthor_fw_init_ifaces()?

Since panthor_fw_start() starts the GPU MCU before panthor_fw_init_ifaces()
is called, could compromised GPU firmware mutate stream_num (or group_num)
directly in shared memory after this bounds check?

If the compiler reloads the limit from memory on each iteration of the
subsequent loop:

    for (i =3D 0; i < csg_iface->control->stream_num; i++) {
        int ret =3D panthor_init_cs_iface(ptdev, csg_idx, i);
        ...
    }

could the loop overrun and index out of bounds, overwriting adjacent kernel
structures?

[ ... ]

> @@ -999,8 +1009,10 @@ static int panthor_fw_init_ifaces(struct panthor_de=
vice *ptdev)
>  		return -EINVAL;
>  	}
> =20
> -	glb_iface->input =3D iface_fw_to_cpu_addr(ptdev, glb_iface->control->in=
put_va);
> -	glb_iface->output =3D iface_fw_to_cpu_addr(ptdev, glb_iface->control->o=
utput_va);

[Severity: High]
This isn't a bug introduced by this patch, but earlier in this function
could we dereference a NULL pointer if the firmware provides a 0-sized
shared section?

In panthor_fw_load_section_entry(), if the firmware provides a
CSF_MCU_SHARED_REGION_START section header where hdr.va.end =3D=3D hdr.va.s=
tart,
the memory allocation is skipped:

panthor_fw.c:panthor_fw_load_section_entry() {
    ...
    section_size =3D hdr.va.end - hdr.va.start;
    if (section_size) {
        ...
    }
    ptdev->fw->shared_section =3D section;
    ...
}

This leaves section->mem as NULL.  When panthor_fw_init_ifaces() runs,
it checks:

    if (!ptdev->fw->shared_section->mem->kmap)

Will this unconditionally dereference mem when it is NULL, causing a
kernel panic during device probe?

> +	glb_iface->input =3D iface_fw_to_cpu_addr(ptdev, glb_iface->control->in=
put_va,
> +						sizeof(*glb_iface->input));
> +	glb_iface->output =3D iface_fw_to_cpu_addr(ptdev, glb_iface->control->o=
utput_va,
> +						 sizeof(*glb_iface->output));
>  	if (!glb_iface->input || !glb_iface->output) {
>  		drm_err(&ptdev->base, "Invalid global control interface input/output V=
A");
>  		return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720114918.1597=
3-1-osama.abdelkader@gmail.com?part=3D1

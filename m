Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B27DC4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7EB510E956;
	Mon, 20 Jul 2026 13:57:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hZLucn7X";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E655110E956
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 13:57:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 627B54009B;
 Mon, 20 Jul 2026 13:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7E21F000E9;
 Mon, 20 Jul 2026 13:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784555844;
 bh=A7YDZa2p4Y6qHWeEpXPkcQYd09nHEexWGzba97SGf70=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hZLucn7XFyjHXGvU6qW9XC/xbmjAX92JcBxz+P5XvxT6O+xXEwLkt0kDFEVrhXSuI
 k4uz3FwwymffgjSeW+MFcqJjgAwevxRnrjn3oRUoqD86Y0oBwUxJtbRnj9DwCL8RQm
 Ld+2PHZPFlZRdTrMpNB8m3HKfUPFrOR52UHbIXV9AbbzJDqDhUoHU83oOrf/6Q96Yx
 /Xu+fzNAlhBPrcPeur5u/kIvwilBgzNANNrA910+JWvOUg3TFzbZAijtIB//oYyU6g
 PRRY+E2vgkUDt1HvKyoiyNR9OSZBUG/OK00Hoy231hOioo6d2k5Xve0GbK/Vmb2xnr
 JQuTGvh8qkicA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panthor: fix firmware control interface bounds checks
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720134435.13377-1-osama.abdelkader@gmail.com>
References: <20260720134435.13377-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 13:57:23 +0000
Message-Id: <20260720135724.1B7E21F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing size validation when converting firmware input/output virt=
ual addresses to CPU pointers allows out-of-bounds memory access.
--

--- Patch [1]: [PATCH] drm/panthor: fix firmware control interface bounds c=
hecks ---
commit e72a8d4004139e04a7daa2f7b2eeb68178eeaccf
Author: Osama Abdelkader <osama.abdelkader@gmail.com>

drm/panthor: fix firmware control interface bounds checks

This commit fixes firmware control interface bounds checks by using 64-bit
arithmetic for computed offsets. It also correctly validates against the
actual firmware control interface structure sizes.

> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index 90f59d782a809..f9da7e4ab7368 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
[ ... ]
> @@ -878,14 +878,15 @@ static int panthor_init_cs_iface(struct panthor_dev=
ice *ptdev,
>  	struct panthor_fw_csg_iface *csg_iface =3D panthor_fw_get_csg_iface(ptd=
ev, csg_idx);
>  	struct panthor_fw_cs_iface *cs_iface =3D &ptdev->fw->iface.streams[csg_=
idx][cs_idx];
>  	u64 shared_section_sz =3D panthor_kernel_bo_size(ptdev->fw->shared_sect=
ion->mem);
> -	u32 iface_offset =3D CSF_GROUP_CONTROL_OFFSET +
> -			   (csg_idx * glb_iface->control->group_stride) +
> +	u64 iface_offset =3D CSF_GROUP_CONTROL_OFFSET +
> +			   ((u64)csg_idx * glb_iface->control->group_stride) +
>  			   CSF_STREAM_CONTROL_OFFSET +
> -			   (cs_idx * csg_iface->control->stream_stride);
> +			   ((u64)cs_idx * csg_iface->control->stream_stride);
>  	struct panthor_fw_cs_iface *first_cs_iface =3D
>  		panthor_fw_get_cs_iface(ptdev, 0, 0);
> =20
> -	if (iface_offset + sizeof(*cs_iface) >=3D shared_section_sz)
> +	if (iface_offset > shared_section_sz ||
> +	    sizeof(*cs_iface->control) > shared_section_sz - iface_offset)
>  		return -EINVAL;
> =20
>  	spin_lock_init(&cs_iface->lock);

[Severity: High]
This is a pre-existing issue, but while you are adding bounds checking for
the control structures, does this code also need size validation for the
input and output structures?

Looking at panthor_init_cs_iface() right below this bounds check:

	cs_iface->input =3D iface_fw_to_cpu_addr(ptdev, cs_iface->control->input_v=
a);
	cs_iface->output =3D iface_fw_to_cpu_addr(ptdev, cs_iface->control->output=
_va);

The iface_fw_to_cpu_addr() function only verifies that the starting virtual
address is within the shared_section bounds:

	if (mcu_va < shared_mem_start || mcu_va >=3D shared_mem_end)
		return NULL;

If a malformed firmware provides an input_va or output_va near the very end
of the shared section (for example, shared_mem_end - 1), wouldn't the driver
read or write past the mapped memory boundary since the structure sizes
aren't validated to fit within the remaining space?

This same pattern appears to exist for the group input/output pointers in
panthor_init_csg_iface() and the global input/output pointers in
panthor_fw_init_ifaces().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720134435.1337=
7-1-osama.abdelkader@gmail.com?part=3D1

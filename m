Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4921C44508
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 16:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1692C10E065;
	Tue, 14 Jul 2026 16:46:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HkMYkB2x";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 982B910E065
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 16:46:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B65416111A;
 Tue, 14 Jul 2026 16:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5581F000E9;
 Tue, 14 Jul 2026 16:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784047564;
 bh=QGV3I7BYXo/LvgALZLtfVdDan4X3Ou17yXHENZRty8U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HkMYkB2xyNBlhYWoD4xOHmm+M6lgmhEX838zgFsmv7+g9xo2tuQCDEAn4tcmAzhYU
 2KQGdl+H5KyW+ELUWV8LNxnQkKXlDu/uAYEq0kyQQ2psFg2PwDLeFBpVXY5AV9jZi/
 JASkjAftG9GuoKqzuJ8sO32Uqv086DYWWjFsChGcukmlhYwWkNFCcL1sWpxyiTdVJs
 LAr7T4KsiWcOadotxLs5JPa05ADCX3i3vvNSQbKqGyt7SqiScDTQxObdQUUaX2mmpk
 wOQRFFiPh7km44adqjTuQHTl+/b8PK5gZxrZ95oI47F2s9xdPznCKTOpJA0iSmAvPz
 rWVO7MQzLtzpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panthor: return error on truncated firmware
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260714163056.22329-1-osama.abdelkader@gmail.com>
References: <20260714163056.22329-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 16:46:03 +0000
Message-Id: <20260714164604.4A5581F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing length validation between firmware section data size a=
nd virtual address size causes a heap buffer overflow.
- [High] panthor_fw_read_build_info() suffers from integer overflows and in=
sufficient bounds checks, enabling out-of-bounds memory reads via a malform=
ed firmware file.
- [High] Empty firmware sections bypass allocation but are added to the sec=
tion list, causing NULL pointer dereferences during initialization and rese=
ts.
- [High] Missing structure size validation when converting firmware MCU vir=
tual addresses allows out-of-bounds kernel reads and writes.
--

--- Patch [1]: [PATCH] drm/panthor: return error on truncated firmware ---
commit e5c6b49a119e7aa698d6e5f3a9176615e1f26472
Author: Osama Abdelkader <osama.abdelkader@gmail.com>

drm/panthor: return error on truncated firmware

panthor_fw_load() detects truncated firmware images, but jumps to the
common cleanup path without setting ret. Set ret to -EINVAL before
leaving the truncated-image path.

Cc: stable@vger.kernel.org

> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index de8e6689a869a..90f59d782a809 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -829,6 +829,7 @@ static int panthor_fw_load(struct panthor_device *ptd=
ev)
>  	}
> =20
>  	if (hdr.size > iter.size) {
> +		ret =3D -EINVAL;
>  		drm_err(&ptdev->base, "Firmware image is truncated\n");
>  		goto out;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the firmware
loading code, I noticed a potential integer overflow in
panthor_fw_read_build_info() when parsing firmware headers:

    if (hdr.meta_start > fw->size ||
        hdr.meta_start + hdr.meta_size > fw->size) {

Could this bounds check be bypassed if a malformed firmware provides values
for hdr.meta_start and hdr.meta_size such that their 32-bit sum wraps to 0?

If the check is bypassed, could the memcmp call read out-of-bounds?

    if (memcmp(git_sha_header, fw->data + hdr.meta_start, header_len)) {

And could this array access evaluate to an extremely large index (0xFFFFFFF=
F)
if the sum evaluates to 0?

    if (fw->data[hdr.meta_start + hdr.meta_size - 1] !=3D '\0') {

[Severity: High]
This is a pre-existing issue, but does the driver mishandle zero-sized
firmware sections?

In panthor_fw_load_section_entry(), if hdr.va.end =3D=3D hdr.va.start, the =
size
evaluates to 0:

    section_size =3D hdr.va.end - hdr.va.start;
    if (section_size) {

Zero-sized sections skip section->mem allocation but are still added to the
FW sections list.

Later, panthor_reload_fw_sections() iterates through all sections and calls
panthor_fw_init_section_mem():

    panthor_fw_init_section_mem(ptdev, section);

Would this cause a NULL pointer dereference when panthor_fw_init_section_me=
m()
unconditionally dereferences section->mem?

    bool was_mapped =3D !!section->mem->kmap;

[Severity: Critical]
This is a pre-existing issue, but is there a missing bounds check between t=
he
section data size and the allocated section size?

In panthor_fw_load_section_entry(), the data size to copy is calculated
without validating it against the allocated section_size:

    section->data.size =3D hdr.data.end - hdr.data.start;

If a crafted firmware sets data.size larger than the allocated memory,
would this cause a heap buffer overflow in panthor_fw_init_section_mem()?

    memcpy(section->mem->kmap, section->data.buf, section->data.size);

Additionally, if the section->data.size exceeds the BO size, could this
memset underflow the size calculation, leading to a massive out-of-bounds
zeroing of kernel memory?

    memset(section->mem->kmap + section->data.size, 0,
           panthor_kernel_bo_size(section->mem) - section->data.size);

[Severity: High]
This isn't a bug introduced by this patch, but does the firmware MCU virtual
address conversion miss a structure size validation?

In iface_fw_to_cpu_addr(), it validates that the start address falls within
the shared memory region:

    if (mcu_va < shared_mem_start || mcu_va >=3D shared_mem_end)
        return NULL;

However, in panthor_init_cs_iface(), this pointer is cast to an interface
structure without verifying there is enough space left in the region:

    cs_iface->input =3D iface_fw_to_cpu_addr(ptdev, cs_iface->control->inpu=
t_va);

If a malformed firmware provides an offset pointing to the very end of the
shared memory region, could subsequent reads or writes to the structure's
fields access unallocated or unrelated kernel memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714163056.2232=
9-1-osama.abdelkader@gmail.com?part=3D1

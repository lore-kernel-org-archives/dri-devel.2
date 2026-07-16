Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CC9C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 900FB10E35A;
	Thu, 16 Jul 2026 14:55:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hAxUFVbV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C66A10E351
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 14:55:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6601060A5A;
 Thu, 16 Jul 2026 14:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA7A1F000E9;
 Thu, 16 Jul 2026 14:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784213721;
 bh=o6La/87xey88OF1O7ZILJn5dznG8A3wglZyx7caTkkU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hAxUFVbVqL3ZifqASiNRQTEf9Y8zfOTQYv78rpoYWR0++T7QAf/d6dRFPSbxNNFcs
 SuBVvSrkfyXupwPkSQBs5jgeqHqh6kuxHwvm0wGtp+uBTbgnNCSSk1QOsjPfMVb/Y2
 dQcuYcLyNszz4e6LltbQW4tQ6WDmXGjmhaUsEMC+KmAO/NnrdUye6zvQj3f0mLjl04
 NSFO7GNzB/pb8YydX3v/Qqukf5A48BFfpsjNZzqeaX1JzBB+57OzkjNJd6X5lm61do
 3I8o1HBylk94eERRNpVlP3isqvwiWfdK589Xq1g6rM5AESFXapFyO8b/P7YAc2pqxp
 EMMPdmS7uiEiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panthor: reject firmware sections with oversized data
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716143939.21903-1-osama.abdelkader@gmail.com>
References: <20260716143939.21903-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 14:55:20 +0000
Message-Id: <20260716145520.EEA7A1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Zero-sized firmware sections result in a NULL `section->mem` point=
er which is subsequently dereferenced unconditionally.
- [High] Missing bounds checks and an integer overflow in `panthor_fw_read_=
build_info()` allow out-of-bounds kernel memory reads when parsing metadata.
--

--- Patch [1]: [PATCH] drm/panthor: reject firmware sections with oversized=
 data ---
commit d0d7589e74bd6422c8113d23148f0b37d9037277
Author: Osama Abdelkader <osama.abdelkader@gmail.com>

drm/panthor: reject firmware sections with oversized data
   =20
In panthor_fw_load_section_entry(), the data size to copy is calculated
without validating it against the allocated section_size:
   =20
    section->data.size =3D hdr.data.end - hdr.data.start;
   =20
If a crafted firmware sets data.size larger than the allocated memory,
this could cause a heap buffer overflow in panthor_fw_init_section_mem()
   =20
    memcpy(section->mem->kmap, section->data.buf, section->data.size);
   =20
Additionally, if the section->data.size exceeds the BO size, could this
memset underflow the size calculation, leading to a massive out-of-bounds
zeroing of kernel memory?
   =20
    memset(section->mem->kmap + section->data.size, 0,
           panthor_kernel_bo_size(section->mem) - section->data.size);
   =20
Reject section entries whose initial data is larger than the section size.
   =20
Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index de8e6689a869a..b73cf054d33ad 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
[ ... ]
> @@ -595,6 +596,13 @@ static int panthor_fw_load_section_entry(struct pant=
hor_device *ptdev,
>  		return -EINVAL;
>  	}
> =20
> +	section_size =3D hdr.va.end - hdr.va.start;
> +	data_size =3D hdr.data.end - hdr.data.start;
> +	if (data_size > section_size) {
> +		drm_err(&ptdev->base, "Firmware corrupted, section data exceeds sectio=
n size\n");
> +		return -EINVAL;
> +	}
> +

[Severity: High]
This is a pre-existing issue, but if a crafted firmware file provides a sec=
tion
entry where hdr.va.end =3D=3D hdr.va.start, section_size evaluates to 0.

Since this patch ensures data_size is not greater than section_size, data_s=
ize
would also be 0, allowing the check to pass.

Later in panthor_fw_load_section_entry(), BO creation is skipped when
section_size is 0, leaving section->mem as NULL:

	if (section_size) {
		...
		section->mem =3D panthor_kernel_bo_create(...);
		...
	}

Since the section was already added to the ptdev->fw->sections list, could
iterating over this list later in panthor_reload_fw_sections() trigger a NU=
LL
pointer dereference when calling panthor_fw_init_section_mem()?

static void panthor_fw_init_section_mem(...)
{
	bool was_mapped =3D !!section->mem->kmap; // Unconditional dereference

[ ... ]

Also in drivers/gpu/drm/panthor/panthor_fw.c, looking at the
panthor_fw_read_build_info() function:

drivers/gpu/drm/panthor/panthor_fw.c:panthor_fw_read_build_info() {
    ...
	if (hdr.meta_start > fw->size ||
	    hdr.meta_start + hdr.meta_size > fw->size) {
		drm_err(&ptdev->base, "Firmware build info corrupt\n");
		/* We don't need the build info, so continue */
		return 0;
	}

[Severity: High]
This isn't a bug introduced by this patch, but does the 32-bit addition of
hdr.meta_start and hdr.meta_size allow an integer overflow to bypass this
bounds check?

If bypassed, a crafted firmware could trigger an out-of-bounds read on the
subsequent memcmp(), which reads header_len (9) bytes without verifying that
the remaining firmware size is at least 9 bytes:

	if (memcmp(git_sha_header, fw->data + hdr.meta_start, header_len)) {
		/* Not the expected header, this isn't metadata we understand */
		return 0;
	}

Additionally, if hdr.meta_size is 0, could the check for the NULL terminator
evaluate to an out-of-bounds index (hdr.meta_start - 1)?

	/* Check that the git SHA is NULL terminated as expected */
	if (fw->data[hdr.meta_start + hdr.meta_size - 1] !=3D '\0') {
		drm_warn(&ptdev->base, "Firmware's git sha is not NULL terminated\n");
		/* Don't treat as fatal */
		return 0;
	}
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716143939.2190=
3-1-osama.abdelkader@gmail.com?part=3D1

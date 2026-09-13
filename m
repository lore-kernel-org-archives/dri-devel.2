Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7673C88E63
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 21:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CDAA10EA2C;
	Sun, 13 Sep 2026 21:09:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JqI2kfyj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BF5810EA2A
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:09:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7359660FD2;
 Sun, 13 Sep 2026 21:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38EE1F000FF;
 Sun, 13 Sep 2026 21:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789333788;
 bh=8qYiVfsRp4hJMU/sRznQV8TuYi4XCyyb0gsALo8CDPY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JqI2kfyjsu52N9MAos3qL1F+rTfHEsP8dB8loZMPHhKAgj+sLxkCXMWFSc01A0tXa
 CRHTKjrhMw8hbKW0FSWKaWS0GJdwaL5iBpPH2VwB/mNJmdfMe7v2eJ/szJmxmb0MDQ
 tl4RAHEdRGRVQotUk4w1IFAmCECrIk6nZ5nIuZQEqXCoLQ+yR5RidDQ/OAYzFTYZrb
 NU9eiX3ALZ0Df5rF3wKrSq9dH2v0IeweFStBQiE2QsL4ntcEMEjK31wdTFpADPyfeG
 wt1ZOAjuGJudadaXJc5J1HngSDzpXoUX+W8PvtKuJt7TQpSg229w5FQTqAuIe/T//7
 bDR0djqJ2DPVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/qxl: validate relocation dst_offset against the
 destination BO
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260912025009.1991197-1-qwe.aldo@gmail.com>
References: <20260912025009.1991197-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 21:09:47 +0000
Message-Id: <20260913210947.F38EE1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] The newly added bounds check against `dst_bo->tbo.base.size` i=
s susceptible to a 32-bit integer overflow, allowing out-of-bounds writes.
- [High] The bounds check for `dst_handle =3D=3D 0` relocations only valida=
tes the starting offset and fails to account for the width of the write.

Pre-existing issues:
- [Critical] Missing `RELEASE_SIZE` limit check allows userspace to copy ar=
bitrarily large command payloads into a fixed 256-byte release slot.
- [High] Relocations with unaligned offsets that cross a page boundary will=
 overflow the single-page fixmap mapping in `apply_reloc` and `apply_surf_r=
eloc`.
- [High] The `reloc.src_offset` field is unsafely truncated and never valid=
ated against the source buffer object's size, allowing out-of-bounds QXL ph=
ysical addresses to be generated.
--

commit 6b7944f1931ada1db6b099ba1549d51a63365bb2
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

drm/qxl: validate relocation dst_offset against the destination BO

This patch adds bounds checks to qxl_process_single_command() to prevent
out-of-bounds writes when processing relocations. It verifies that dst_offs=
et
stays within the release's command data area and that the final offset plus
write width does not exceed the destination BO size.

> diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_io=
ctl.c
> index 591b026ceff9c..b62f32b6dc81a 100644
> --- a/drivers/gpu/drm/qxl/qxl_ioctl.c
> +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
> @@ -227,10 +227,27 @@ static int qxl_process_single_command(struct qxl_de=
vice *qdev,

[Severity: Critical]
This is a pre-existing issue, but does qxl_process_single_command() allow a
large overflow when copying the command payload?

The function permits cmd->command_size up to
PAGE_SIZE - sizeof(union qxl_release_info). However,
qxl_alloc_release_reserved() ignores the requested size and allocates exact=
ly
RELEASE_SIZE (256 bytes).

The copy_from_user_inatomic_nontemporal() call then writes up to ~4032 bytes
directly into the 256-byte slot:

qxl_process_single_command() {
    ...
    unwritten =3D copy_from_user_inatomic_nontemporal
        (fb_cmd + sizeof(union qxl_release_info) +=20
         (release->release_offset & ~PAGE_MASK),
         u64_to_user_ptr(cmd->command), cmd->command_size);
    ...
}

If the release offset is near the end of the mapped page, could this
completely overflow the single-page mapping and overwrite adjacent memory?

>  				goto out_free_bos;
>  			reloc_info[i].dst_offset =3D reloc.dst_offset;
>  		} else {
> +			if (reloc.dst_offset < sizeof(union qxl_release_info) ||
> +			    reloc.dst_offset >=3D sizeof(union qxl_release_info) +
> +						cmd->command_size) {

[Severity: High]
Is the command bounds check missing an addition for the write width?

If a userspace render client sets reloc.dst_offset to
sizeof(union qxl_release_info) + cmd->command_size - 1, this check passes.
However, apply_reloc() writes 8 bytes, which extends 7 bytes past the allow=
ed
command size.

Because multiple releases are tightly packed in cmd_bo, can this
out-of-bounds write corrupt the qxl_release_info header of the adjacent
release?

> +				ret =3D -EINVAL;
> +				goto out_free_bos;
> +			}
>  			reloc_info[i].dst_bo =3D cmd_bo;
>  			reloc_info[i].dst_offset =3D reloc.dst_offset + release->release_offs=
et;
>  		}
> =20
> +		{
> +			size_t write_size =3D reloc.reloc_type =3D=3D QXL_RELOC_TYPE_BO ?
> +					    sizeof(uint64_t) : sizeof(uint32_t);
> +
> +			if (reloc_info[i].dst_offset + write_size >
> +			    reloc_info[i].dst_bo->tbo.base.size) {

[Severity: Critical]
Is this bounds check susceptible to a 32-bit integer overflow?

Because size_t is 32-bit on 32-bit platforms, if a render client provides a
dst_offset like 0xFFFFFFFC and write_size is 8, the addition wraps around
to 4, which bypasses the check against tbo.base.size.

The truncated offset 0xFFFFFFFC would mask to a negative page offset (-4096=
),
which is then passed to the mapping function:

qxl_bo_kmap_atomic_page() {
    ...
    return io_mapping_map_atomic_wc(map, offset + page_offset);
}

Could this map physical memory preceding the VRAM BO into the kernel fixmap
and overwrite it?

[Severity: High]
This is a pre-existing issue, but should this bounds check also verify that
the write doesn't cross a page boundary?

If a user submits a relocation with a valid dst_offset within the BO size
but unaligned and near the page end (e.g., dst_offset & ~PAGE_MASK =3D=3D 4=
092),
the 8-byte write will span bytes 4092 to 4099:

apply_reloc() {
    ...
    reloc_page =3D qxl_bo_kmap_atomic_page(qdev, info->dst_bo,
                                         info->dst_offset & PAGE_MASK);
    *(uint64_t *)(reloc_page + (info->dst_offset & ~PAGE_MASK)) =3D=20
                                         qxl_bo_physical_address(...);
}

Since qxl_bo_kmap_atomic_page() only maps a single 4096-byte page, does this
overwrite the adjacent virtual page in the kernel's fixmap area?

> +				ret =3D -EINVAL;
> +				goto out_free_bos;
> +			}
> +		}
> +
>  		/* reserve and validate the reloc dst bo */
>  		if (reloc.reloc_type =3D=3D QXL_RELOC_TYPE_BO || reloc.src_handle) {

[Severity: High]
This is a pre-existing issue, but reloc.src_offset appears to be unsafely
truncated and used without validation.

In qxl_process_single_command(), reloc.src_offset (which is a __u64 from
userspace) is assigned to reloc_info[i].src_offset, which is a signed 32-bit
int:

qxl_process_single_command() {
    ...
    reloc_info[i].src_offset =3D reloc.src_offset;
    ...
}

It is then passed to qxl_bo_physical_address() without any bounds check
against src_bo->tbo.base.size:

qxl_bo_physical_address() {
    ...
    return slot->high_bits | ((bo->tbo.resource->start << PAGE_SHIFT) +
                              offset);
}

Can a forged or negative offset generate a physical address pointing
completely outside the source BO, allowing the guest to bypass protections?

>  			ret =3D qxlhw_handle_to_bo(file_priv, reloc.src_handle, release,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912025009.1991=
197-1-qwe.aldo@gmail.com?part=3D1

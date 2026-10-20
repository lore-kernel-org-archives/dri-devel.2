Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEED606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V4v7Ui3x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE2110F339;
	Tue, 20 Oct 2026 08:01:54 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E120810F339
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:01:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B4A1601F9;
 Tue, 20 Oct 2026 08:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D211B1F000C4;
 Tue, 20 Oct 2026 08:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792483307;
 bh=QUWQjmpTnWBmgs7H4cGoanizBeMWtf0ZIuBran+UyIo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V4v7Ui3xQJchk44e5Pk0TxBC+lIJFgrE7ckgqb22qzpto4jg9K2vwTluzCJZgOgRA
 g21tfUlrLBAXTkG4zPhuVRt/HNScAtQ7h7fCLg8X/nd3Q6AP+hO9P0q66zFwIb3VG9
 UTppeSrY322GEHySv5veHFM/eUiTM6XaoVp2JsRhJU056whO4cunFVlGy+2ft/HSCM
 dTHdtj7+/rJOc5K5l7aaIdJ6eY2vsb/kIVce83aTwVRdDAvKHcDqe2He0hYI4XDduY
 AsjF9SRLZv5EinARplYJZn2qfwWLZ7YUdG9E6gXiC2DsBMO9aqXWkWs1dB/KIjFRMK
 tEur9q0gFd/pQ==
Message-ID: <sashiko-outbox-178468@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/qxl: validate relocation destination offsets
To: "Zhou Qiuyue" <n0ps1edzz@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <179240154188.24976.18308245375219473922@gmail.com>
References: <6acafc03.6b76d992.279a8.b343@mx.google.com>
 <sashiko-outbox-166994@kernel.org>
 <179240154188.24976.18308245375219473922@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:01:46 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] drm/qxl: double PAGE_SIZE scaling in qxl_bo_kmap_atomic_page()=
 fallback
- [High] drm/qxl: natural alignment check in qxl_process_single_command() b=
reaks UAPI
- [High] drm/qxl: integer wrap and missing command bounds check for dst_han=
dle =3D=3D 0
--

commit ac35098698450b791455e5afa6c8c8c17114609f
Author: Zhou Qiuyue <n0ps1edzz@gmail.com>

drm/qxl: validate relocation destination offsets

This commit widens relocation destination offset types and validates
the destination offset and alignment against the destination buffer
object size in qxl_process_single_command().

> diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_io=
ctl.c
> index 591b026ceff9c..9a031bb3f9b0c 100644
> --- a/drivers/gpu/drm/qxl/qxl_ioctl.c
> +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c

[ ... ]

> @@ -231,6 +232,26 @@ static int qxl_process_single_command(struct qxl_dev=
ice *qdev,
>  			reloc_info[i].dst_offset =3D reloc.dst_offset + release->release_offs=
et;
>  		}
> =20
> +		/*
> +		 * The relocation is applied with a plain write into the memory
> +		 * window of the destination object, so the user supplied offset
> +		 * must be validated against the object size.  Otherwise userspace
> +		 * can write anywhere in the mapping window set up by
> +		 * qxl_bo_kmap_atomic_page(), i.e. outside of the object.  The
> +		 * offset must also be aligned to the access size so the write
> +		 * cannot straddle a page boundary inside the window.
> +		 */
> +		reloc_size =3D (reloc.reloc_type =3D=3D QXL_RELOC_TYPE_BO) ?
> +			     sizeof(uint64_t) : sizeof(uint32_t);
> +		if (!IS_ALIGNED(reloc_info[i].dst_offset, reloc_size) ||
> +		    reloc_info[i].dst_offset > reloc_info[i].dst_bo->tbo.base.size ||
> +		    reloc_size > reloc_info[i].dst_bo->tbo.base.size -
> +				 reloc_info[i].dst_offset) {
> +			DRM_DEBUG("reloc dst offset out of bounds\n");
> +			ret =3D -EINVAL;
> +			goto out_free_bos;
> +		}

[Severity: High]
Won't requiring dst_offset to be aligned to reloc_size (8 or 4 bytes) in
qxl_process_single_command() reject valid QXL draw commands from userspace
with -EINVAL?

In drivers/gpu/drm/qxl/qxl_dev.h, the QXL protocol structures are defined
under #pragma pack(push, 1):

drivers/gpu/drm/qxl/qxl_dev.h:
    struct qxl_drawable {
            union qxl_release_info release_info;
            uint32_t surface_id;
            uint8_t effect;
            uint8_t type;
            uint8_t self_bitmap;
            struct qxl_rect self_bitmap_area;
            struct qxl_rect bbox;
            struct qxl_clip clip;
            uint32_t mm_time;
            int32_t surfaces_dest[3];
            struct qxl_rect surfaces_rects[3];
            union {
                    struct qxl_fill fill;
                    struct qxl_opaque opaque;
                    struct qxl_copy copy;
                    ...

Because of the three uint8_t fields (effect, type, self_bitmap), subsequent
relocated fields inside struct qxl_drawable sit at unaligned byte offsets,
such as clip.data (offset 51), surfaces_dest[0..2] (offsets 63, 67, 71), and
union u fields like u.copy.src_bitmap (offset 123).

Similarly, when relocating into another buffer object (reloc.dst_handle !=
=3D 0),
struct qxl_data_chunk places prev_chunk and next_chunk (8-byte QXLPHYSICAL
fields) at offsets 4 and 12:

drivers/gpu/drm/qxl/qxl_dev.h:
    struct qxl_data_chunk {
            uint32_t data_size;
            QXLPHYSICAL prev_chunk;
            QXLPHYSICAL next_chunk;
            uint8_t data[];
    };

and struct qxl_image places u.surface_image.surface_id at offset 18.

To prevent a relocation write from straddling a page boundary inside the
single page mapped by qxl_bo_kmap_atomic_page(), should this check that the
offset within the page does not cross PAGE_SIZE (for example,
offset_in_page(reloc_info[i].dst_offset) > PAGE_SIZE - reloc_size) rather
than requiring natural alignment via IS_ALIGNED()?

[Severity: High]
Also in qxl_process_single_command(), when reloc.dst_handle =3D=3D 0, can
reloc.dst_offset + release->release_offset wrap around or write outside the
command's slot in cmd_bo?

In qxl_alloc_release_reserved(), cmd_bo is a PAGE_SIZE buffer object shared
across multiple 256-byte release slots at release->release_offset, with
union qxl_release_info stored at the start of each slot:

drivers/gpu/drm/qxl/qxl_release.c:qxl_alloc_release_reserved() {
    ...
    bo =3D qxl_bo_ref(qdev->current_release_bo[cur_idx]);

    (*release)->release_bo =3D bo;
    (*release)->release_offset =3D qdev->current_release_bo_offset[cur_idx]=
 * release_size_per_bo[cur_idx];
    qdev->current_release_bo_offset[cur_idx]++;
    ...
}

When release->release_offset > 0, adding a large user-supplied
reloc.dst_offset can wrap around in uint64_t to a small offset before the
bounds check. Furthermore, checking only against cmd_bo->tbo.base.size
(PAGE_SIZE) instead of the command's range
[sizeof(union qxl_release_info), sizeof(union qxl_release_info) + cmd->comm=
and_size)
allows a relocation to overwrite the union qxl_release_info header or
adjacent release slots sharing cmd_bo.

> =20
>  		/* reserve and validate the reloc dst bo */
>  		if (reloc.reloc_type =3D=3D QXL_RELOC_TYPE_BO || reloc.src_handle) {
>  			ret =3D qxlhw_handle_to_bo(file_priv, reloc.src_handle, release,
> diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_o=
bject.c
> index 313f6c30cac85..0df48141c2db7 100644
> --- a/drivers/gpu/drm/qxl/qxl_object.c
> +++ b/drivers/gpu/drm/qxl/qxl_object.c
> @@ -204,7 +204,7 @@ int qxl_bo_pin_and_vmap(struct qxl_bo *bo, struct ios=
ys_map *map)
>  }
> =20
>  void *qxl_bo_kmap_atomic_page(struct qxl_device *qdev,
> -			      struct qxl_bo *bo, int page_offset)
> +			      struct qxl_bo *bo, unsigned long page_offset)
>  {
>  	unsigned long offset;
>  	void *rptr;

[Severity: Critical]
When dst_bo is backed by TTM_PL_SYSTEM (such as a multi-page dumb BO created
via DRM_IOCTL_MODE_CREATE_DUMB with QXL_GEM_DOMAIN_CPU), can a relocation
with dst_offset >=3D PAGE_SIZE still write out of bounds in the fallback pa=
th
of qxl_bo_kmap_atomic_page()?

In apply_reloc() and apply_surf_reloc(), the caller passes a byte offset
masked with PAGE_MASK and does not check the return value for NULL:

drivers/gpu/drm/qxl/qxl_ioctl.c:apply_reloc() {
    ...
    reloc_page =3D qxl_bo_kmap_atomic_page(qdev, info->dst_bo, info->dst_of=
fset & PAGE_MASK);
    *(uint64_t *)(reloc_page + (info->dst_offset & ~PAGE_MASK)) =3D qxl_bo_=
physical_address(qdev,
                                                                           =
       info->src_bo,
                                                                           =
       info->src_offset);
    ...
}

In qxl_bo_kmap_atomic_page(), the io_mapping_map_atomic_wc() path treats
page_offset as a byte offset, but the fallback path multiplies page_offset =
by
PAGE_SIZE a second time:

drivers/gpu/drm/qxl/qxl_object.c:qxl_bo_kmap_atomic_page() {
    ...
    offset =3D bo->tbo.resource->start << PAGE_SHIFT;
    return io_mapping_map_atomic_wc(map, offset + page_offset);
fallback:
    if (bo->kptr) {
            rptr =3D bo->kptr + (page_offset * PAGE_SIZE);
            return rptr;
    }

    ret =3D qxl_bo_vmap_locked(bo, &bo_map);
    if (ret)
            return NULL;
    rptr =3D bo_map.vaddr; /* TODO: Use mapping abstraction properly */

    rptr +=3D page_offset * PAGE_SIZE;
    return rptr;
}

If dst_offset >=3D PAGE_SIZE (while still within dst_bo->tbo.base.size, pas=
sing
the new bounds check), doesn't page_offset * PAGE_SIZE advance rptr far past
the end of the buffer object (or return NULL if qxl_bo_vmap_locked() fails)?

[ ... ]

> --=20

=E2=80=94
=F0=9F=A4=96 Generated by Sashiko =E2=80=94 Linux Kernel Patch Review
https://sashiko.dev
=E2=80=94

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179240154188.24976.=
18308245375219473922@gmail.com?part=3D1

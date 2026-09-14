Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A62FC88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:00:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1669810EBDF;
	Mon, 14 Sep 2026 08:00:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hvGYjPpZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79F0B10EBDF
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:00:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2E5DB4348B;
 Mon, 14 Sep 2026 08:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE0E1F000FF;
 Mon, 14 Sep 2026 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789372831;
 bh=FVdx79R3tQ/5guHZC+i3wpAzVPiw07WrBMmsEZT+hHE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hvGYjPpZf/qBjY10PPghWVNZntJ7yyfQNsVhJ1lJbSLNh/39WWtql/Z8B5AOcVkVz
 yCurRLEUY86Owc0b0R3mc3HBr+T8UW/xHpEH7z10HrGafexOztvWWok9Iwk2vxNMbk
 RTNR5KcdOiuZrzV8/ivec23kYpwnlmzulgrZu0OM7eWa8eQaBsAUvaXjfnSVqJ4w1z
 VGAJBs9WO8glYP1rt9lOxrcyNWI7VqOAxKn8A5l1gAsrMOAQNRWgKrpLqpVpwid9EV
 mhDTFMYxFvcoedPFRcm+C5dhTsMB070bdulw2WVuRNqkrFxywR9oEl4ShofkZ6BwVk
 Yc7G52coM8J5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.10] drm/amdgpu: Fix integer overflow in amdgpu_cs_pass1
To: "Roman Demidov" <roman.demidov.nn@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914074050.10384-1-roman.demidov.nn@gmail.com>
References: <20260914074050.10384-1-roman.demidov.nn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 08:00:30 +0000
Message-Id: <20260914080030.DBE0E1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Returning success (0) for an empty chunk list leaves parser fi=
elds uninitialized, causing a NULL pointer dereference.
- [Critical] Missing bounds validation for AMDGPU_CHUNK_ID_IB chunks leads =
to out-of-bounds reads and NULL pointer dereference.
- [Critical] Double free and use-after-free of user fence BO when amdgpu_cs=
_user_fence_chunk() fails.
- [Critical] NULL pointer dereference in amdgpu_cs_parser_fini if chunk arr=
ay allocation fails.
- [High] Integer overflow in amdgpu_bo_create_list_entry_array when calcula=
ting bytes for copy_from_user and memset leaves kernel heap memory uninitia=
lized.
- [High] Memory leak of user fence BO when multiple FENCE chunks are provid=
ed.
--

commit 9efe72932540079a0dc0c2bc02c23c524aa5971d
Author: hackyzh002 <hackyzh002@gmail.com>

drm/amdgpu: Fix integer overflow in amdgpu_cs_pass1

This commit fixes an integer overflow where size *=3D sizeof(uint32_t)
could overflow the unsigned int type if size is 0x40000000. It updates
size to a size_t to prevent uninitialized memory from being referenced.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 12598a4b5c788..6c18054e045dc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -110,7 +110,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_par=
ser *p, union drm_amdgpu_cs
>  	struct amdgpu_vm *vm =3D &fpriv->vm;
>  	uint64_t *chunk_array_user;
>  	uint64_t *chunk_array;
> -	unsigned size, num_ibs =3D 0;
> +	size_t size;
> +	unsigned int num_ibs =3D 0;
>  	uint32_t uf_offset =3D 0;
>  	int i;
>  	int ret;

[Severity: High]
This is a pre-existing issue, but does this code overflow the bytes variabl=
e?

drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c:amdgpu_bo_create_list_entry_arr=
ay() {
    ...
		unsigned long bytes =3D in->bo_number *
			in->bo_info_size;
    ...
		memset(info, 0, in->bo_number * info_size);
    ...
}

Since both in->bo_number and in->bo_info_size are uint32_t from the BO list
ioctl, could multiplying them cause a 32-bit integer overflow?

For example, if bo_number is 0x20000002 and bo_info_size is 8, the result
overflows to 0. Would copy_from_user then copy only 16 bytes while
kvmalloc_array allocates a 4 GB array, leaving gigabytes of kernel heap
memory uninitialized and later used as BO handles?

[Severity: Critical]
This is a pre-existing issue, but does returning 0 for an empty chunk list
leave parser fields uninitialized?

drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:amdgpu_cs_parser_init() {
    ...
	if (cs->in.num_chunks =3D=3D 0)
		return 0;
    ...
}

If userspace calls amdgpu_cs_ioctl with num_chunks =3D 0, this returns early
and skips parser setup, leaving parser->entity as NULL.

Will this cause a NULL pointer dereference later in amdgpu_cs_ib_fill()
when it unconditionally dereferences parser->entity?

drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:amdgpu_cs_ib_fill() {
    ...
	ring =3D to_amdgpu_ring(parser->entity->rq->sched);
    ...
}

[Severity: Critical]
This is a pre-existing issue, but is there a missing length check for
AMDGPU_CHUNK_ID_IB chunks?

drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:amdgpu_cs_parser_init() {
    ...
		case AMDGPU_CHUNK_ID_IB:
			++num_ibs;
			break;
    ...
}

If userspace passes an IB chunk with length_dw =3D 0, kvmalloc_array could
return ZERO_SIZE_PTR (0x10).

Could this unvalidated pointer then be dereferenced in amdgpu_cs_ib_fill(),
causing a page fault or out-of-bounds heap read?

drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:amdgpu_cs_ib_fill() {
    ...
		chunk_ib =3D (struct drm_amdgpu_cs_chunk_ib *)chunk->kdata;

		if (chunk->chunk_id !=3D AMDGPU_CHUNK_ID_IB)
			continue;

		if (chunk_ib->ip_type =3D=3D AMDGPU_HW_IP_GFX &&
    ...
}

[Severity: Critical]
This is a pre-existing issue, but does this error path lead to a double-free
and use-after-free of the user fence BO?

drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:amdgpu_cs_user_fence_chunk() {
    ...
error_unref:
	amdgpu_bo_unref(&bo);
	return r;
}

If this error path is taken, the BO is unreferenced, but the dangling point=
er
remains in p->uf_entry.tv.bo.

Will the parser cleanup path then blindly unreference the same BO a second =
time?

drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:amdgpu_cs_parser_fini() {
    ...
	if (parser->uf_entry.tv.bo) {
		struct amdgpu_bo *uf =3D ttm_to_amdgpu_bo(parser->uf_entry.tv.bo);

		amdgpu_bo_unref(&uf);
	}
    ...
}

[Severity: Critical]
This is a pre-existing issue, but does setting p->nchunks before checking
if the chunk array allocation succeeded cause a NULL pointer dereference?

drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:amdgpu_cs_parser_init() {
    ...
	p->nchunks =3D cs->in.num_chunks;
	p->chunks =3D kmalloc_array(p->nchunks, sizeof(struct amdgpu_cs_chunk),
			    GFP_KERNEL);
	if (!p->chunks) {
		ret =3D -ENOMEM;
		goto free_chunk;
	}
    ...
}

If the allocation fails and we branch to free_chunk, p->nchunks is not clea=
red.

Does this cause the cleanup loop in amdgpu_cs_parser_fini() to iterate over
and dereference the NULL parser->chunks array?

drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:amdgpu_cs_parser_fini() {
    ...
	for (i =3D 0; i < parser->nchunks; i++)
		kvfree(parser->chunks[i].kdata);
    ...
}

[Severity: High]
This is a pre-existing issue, but does this code leak the previous user
fence BO if multiple FENCE chunks are provided?

drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:amdgpu_cs_user_fence_chunk() {
    ...
	bo =3D amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
	p->uf_entry.priority =3D 0;
	p->uf_entry.tv.bo =3D &bo->tbo;
    ...
}

If userspace submits multiple AMDGPU_CHUNK_ID_FENCE chunks in a single CS
ioctl, this blindly overwrites p->uf_entry.tv.bo with a new BO reference.

Does this permanently leak the previous GEM buffer objects, potentially
leading to system memory exhaustion since amdgpu_cs_parser_fini() only
unreferences the final BO?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914074050.1038=
4-1-roman.demidov.nn@gmail.com?part=3D1

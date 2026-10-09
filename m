Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A933BCA601C
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D1610E2F0;
	Fri,  9 Oct 2026 10:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P6Al0/e7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C29FB10E2F0
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 10:49:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3AD8F60534;
 Fri,  9 Oct 2026 10:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70C41F000FF;
 Fri,  9 Oct 2026 10:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791542962;
 bh=3fNC8WQQQPpJZLbEA0XMD7hqyrdx8nqJ57fF2JSEF64=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P6Al0/e78RRllj1FiHZuhSOGrQKbdTwQalhSUIjM9XXLjRTg7EaY0c8kNPHgrE5Bl
 7DOUsKcOjcwrFDtZLP34fLKLXZkHn9VEVTNF7oRlusZKb5U03Ot8qf3GJ9JOl8pNJK
 glocUZKRj5CTHzPLoJUOLp4fSyjdR00lF1JA3TsH51Ldj4EH7pCKFWsrW0ETthHBKR
 pjhuvW3DpyNdiIUl5cBO041HKC8IQWR46zhmHlx7kJt92khKRGpoD8rduaP2NzSDmR
 GUcN+vNuQoMzkiXNntl011q7rmapIH9nPHYkKcVAtfAff3Mf+78dMvurkMeGOETB62
 GTthe4QYtg+gw==
Message-ID: <sashiko-outbox-165273@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/ttm: return an error when kmapping a BO without
 pages
To: "Jesse Zhang" <Jesse.Zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009103419.4122940-1-Jesse.Zhang@amd.com>
References: <20261009103419.4122940-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 10:49:22 +0000
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
- [High] ttm: NULL pointer dereference in CPU fault and memcpy fallbacks fo=
r SG BOs
--

commit ba111d71d680811150fde6d535fc740c46cc9d63
Author: Jesse Zhang <Jesse.Zhang@amd.com>

drm/ttm: return an error when kmapping a BO without pages

This commit adds checks to return an error when attempting to kmap or vmap a
buffer object that lacks a pages array, which occurs with imported SG table=
s.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_=
bo_util.c
> index bd0b23ac2cc4b..f9458a4d5a09d 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -356,6 +356,10 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object =
*bo,
>  	if (ret)
>  		return ret;
> =20
> +	/* Imported sg tables only come with DMA addresses, no pages to map. */
> +	if (!ttm->pages)
> +		return -EINVAL;
> +

[Severity: High]
While this handles the kmap and vmap paths, can a similar NULL pointer
dereference occur in the CPU fault path and memcpy fallback for SG BOs?

If an imported BO is mapped via the DRM fd, userspace page faults can reach
ttm_bo_vm_fault_reserved(), which unconditionally dereferences ttm->pages:

drivers/gpu/drm/ttm/ttm_bo_vm.c:ttm_bo_vm_fault_reserved() {
    ...
    page =3D ttm->pages[page_offset];
    if (unlikely(!page && i =3D=3D 0)) {
    ...
}

Similarly, if hardware copies fail on an imported BO and it falls back to
ttm_bo_move_memcpy(), the TT iterator initialized there is later used in
ttm_kmap_iter_tt_map_local(), which also accesses the pages array:

drivers/gpu/drm/ttm/ttm_bo_util.c:ttm_bo_move_memcpy() {
    ...
    dst_iter =3D ttm_kmap_iter_tt_init(&_dst_iter.tt, ttm);
    ...
}

drivers/gpu/drm/ttm/ttm_tt.c:ttm_kmap_iter_tt_map_local() {
    ...
    iosys_map_set_vaddr(dmap, kmap_local_page_prot(iter_tt->tt->pages[i],
                                                   iter_tt->prot));
    ...
}

Do these paths also need to check for a missing pages array and return an
error to prevent a crash?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009103419.4122=
940-1-Jesse.Zhang@amd.com?part=3D1

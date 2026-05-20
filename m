Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54577CD4F5E
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 06:16:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A819510E0A6;
	Wed, 20 May 2026 06:16:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="NU6Za/ei";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4816A10E0A6
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779257773;
 bh=QhEY74D9z4Dh/emvIJ/nWeCVZgPpAM04f+LEhYim0kg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=NU6Za/eiRsHxH6sVx6Ztni8rRtqDN7h2+nczjYiymndMyTl46cMc6hDtYQtQBFWZr
 TPfTBYkDajWWAmK5I30vP+CTNoDgAwl4fwmv4jgkf/qTK2CbmBcKuSzf90xtPkZVbi
 WBPDVCNye92JZbhfP9c7G3iGI9r5z7dnpiJ8AP96YqbnUidARDSl7aGd9HK9sEYqa0
 rkxkUwhQUEAphGWGbSFEkd6/mthw9RMVXYSV6cFoQvWOdG+OQDKA8BCLkrVZWbOf7o
 MoyOCZl5jBSt7/pEB9hVPpk4pQ7o0NFUp3ZIrcfazJ3SvrBcf84GxN003br2cZAAVC
 w0XWpxzfH5/fg==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5A91B17E05B5;
 Wed, 20 May 2026 08:16:13 +0200 (CEST)
Date: Wed, 20 May 2026 08:16:08 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel@collabora.com, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v11 5/6] drm/panthor: Support sparse mappings
Message-ID: <20260520081608.0122a1d4@fedora>
In-Reply-To: <agy06w1k_rbiZTFN@sobremesa>
References: <20260507214939.2852489-1-adrian.larumbe@collabora.com>
 <20260507214939.2852489-6-adrian.larumbe@collabora.com>
 <661a6aab-a643-496b-94d2-ae9230df1a54@arm.com>
 <agy06w1k_rbiZTFN@sobremesa>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Tue, 19 May 2026 20:15:34 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Hi Steven,
>=20
> On 13.05.2026 16:46, Steven Price wrote:
> > On 07/05/2026 22:49, Adri=C3=A1n Larumbe wrote: =20
> > > Allow UM to bind sparsely populated memory regions by cyclically mapp=
ing
> > > virtual ranges over a kernel-allocated dummy BO. This alternative is
> > > preferable to the old method of handling sparseness in the UMD, becau=
se it
> > > relied on the creation of a buffer object to the same end, despite th=
e fact
> > > Vulkan sparse resources don't need to be backed by a driver BO.
> > >
> > > The choice of backing sparsely-bound regions with a Panthor BO was ma=
de so
> > > as to profit from the existing shrinker reclaim code. That way no spe=
cial
> > > treatment must be given to the dummy sparse BOs when reclaiming memor=
y, as
> > > would be the case if we had chosen a raw kernel page implementation. =
=20
> >
> > Do you need to fix up the remap_evicted_vma() path though? At the moment
> > that will go through panthor_vm_map_pages() without doing the
> > panthor_fix_sparse_map_offset() dance. Also I suspect it won't map the
> > whole region (just the first 2MB in the sgtable). =20
>=20
> You're right, we need to account for the case in which the VMA is of the =
sparse kind
> and backed by the dummy BO. I suggest something as follows:
>=20
> ``` diff
>  		ret =3D panthor_vm_lock_region(vm, evicted_vma->base.va.addr,
>  					     evicted_vma->base.va.range);
>  		if (!ret) {
> -			ret =3D panthor_vm_map_pages(vm, evicted_vma->base.va.addr,
> -						   flags_to_prot(evicted_vma->flags),
> -						   bo->dmap.sgt,
> -						   evicted_vma->base.gem.offset,
> -						   evicted_vma->base.va.range);
> +			struct drm_gpuva_op_map map_op =3D {
> +				.va.addr =3D evicted_vma->base.va.addr,
> +				.va.range =3D evicted_vma->base.va.range,
> +				.gem.obj =3D &bo->base,
> +				.gem.offset =3D evicted_vma->base.gem.offset,
> +			};
> +			if (evicted_vma->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)
> +				drm_WARN_ON(&vm->ptdev->base, map_op.gem.offset !=3D
> +					    (map_op.va.addr & (SZ_2M - 1)));
> +
> +			ret =3D panthor_vm_exec_map_op(vm, evicted_vma->flags, &map_op);
>  			if (!ret)
>  				evicted_vma->evicted =3D false;
> ```
>=20
> However, it seems to me there's no need for panthor_fix_sparse_map_offset=
() in this code path,
> because a VMA should always have the right gem offset even after eviction=
. This holds true in
> the event of an sm_remap of a VMA that had already been evicted.

Yep, I think you're right.

>=20
> This led me to think doing a WARN_ON test on the offset is the right way =
to go.

A WARN_ON[_ONCE]() would do, yes.

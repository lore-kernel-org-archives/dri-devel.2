Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB770FE5215
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 12:15:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4753310E3FC;
	Fri, 24 Apr 2026 12:15:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Bt4WYcFb";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1622510E3FC
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 12:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777032896;
 bh=o2ZI0I4s9d/58R3WUl5kvlz6gMyKHjB727VwP4p52OM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Bt4WYcFbtWIaOe7qCirfPcKpy+N8GWn8NIbDUkRdkCYUJziiub+0eBxSuv+7FS+pJ
 Ubw1MbYn6ygCodpdv5fgqD1lrLIJE4L2fqjPV0JOQYAnqEyFNibFlw99/ZfHKxfjxH
 JxvS7Ifsq9ytByEmCkmJB2amx4HDjutYNN6TKFnKxTNhC3xms3m5T+MYGdu16lwg9b
 +aVjFm56Bygc3GXrekNoYDZ6h/8ixFC9DFrh3L62WpDbHJS5fQoPPt5ff7gB6SDzV8
 dQBCVy+hYtia5ob5gkY2gR/8yPLJ53Dcm+VFAtS8++RceO2+Brstik1b9fI3DCRYR9
 YDQ3BNQa9dznQ==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 333AE17E14D4;
 Fri, 24 Apr 2026 14:14:56 +0200 (CEST)
Date: Fri, 24 Apr 2026 14:14:51 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: Steven Price <steven.price@arm.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel@collabora.com, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v9 5/6] drm/panthor: Support sparse mappings
Message-ID: <20260424141451.70a86322@fedora>
In-Reply-To: <aetcRc4eciDFmOi8@sobremesa>
References: <20260422122538.3117380-1-adrian.larumbe@collabora.com>
 <20260422122538.3117380-6-adrian.larumbe@collabora.com>
 <f0ec1b96-a6ff-49c6-b57d-740f97ac867f@arm.com>
 <20260424123103.28f6ada7@fedora> <aetcRc4eciDFmOi8@sobremesa>
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

On Fri, 24 Apr 2026 13:06:24 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Hi Boris,
>=20
> On 24.04.2026 12:31, Boris Brezillon wrote:
> > On Fri, 24 Apr 2026 11:09:27 +0100
> > Steven Price <steven.price@arm.com> wrote:
> > =20
> > > Hi Adri=C3=A1n,
> > >
> > > On 22/04/2026 13:25, Adri=C3=A1n Larumbe wrote: =20
> > > > Allow UM to bind sparsely populated memory regions by cyclically ma=
pping
> > > > virtual ranges over a kernel-allocated dummy BO. This alternative is
> > > > preferable to the old method of handling sparseness in the UMD, bec=
ause it
> > > > relied on the creation of a buffer object to the same end, despite =
the fact
> > > > Vulkan sparse resources don't need to be backed by a driver BO.
> > > >
> > > > The choice of backing sparsely-bound regions with a Panhtor BO was =
made so
> > > > as to profit from the existing shrinker reclaim code. That way no s=
pecial
> > > > treatment must be given to the dummy sparse BOs when reclaiming mem=
ory, as
> > > > would be the case if we had chosen a raw kernel page implementation.
> > > >
> > > > A new dummy BO is allocated per open file context, because even tho=
ugh the
> > > > Vulkan spec mandates that writes into sparsely bound regions must be
> > > > discarded, our implementation is still a workaround over the fact M=
ali CSF
> > > > GPUs cannot support this behaviour on the hardware level, so writes=
 still
> > > > make it into the backing BO. If we had a global one, then it could =
be a
> > > > venue for information leaks between file contexts, which should nev=
er
> > > > happen in DRM.
> > > >
> > > > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> =
=20
> > >
> > > Looks good, a few issues below.
> > >
> > > I'm worried about remap_evicted_vma() and how that interacts with spa=
rse
> > > mappings. Does that need to be fixed up to handle sparse mappings? Or=
 is
> > > there something to prevent the dummy BO being reclaimed? I might be
> > > missing something here. =20
> >
> > Given the sparse mappings still have a vm_bo+gem object attached to the=
m,
> > I think reclaim is fine, but I'll double check.
> > =20
> > > > +static int
> > > > +panthor_vm_map_sparse(struct panthor_vm *vm, u64 iova, int prot,
> > > > +		      struct sg_table *sgt, u64 size)
> > > > +{
> > > > +	u64 start_iova =3D iova;
> > > > +	int ret;
> > > > +
> > > > +	if (iova & (SZ_2M - 1)) {
> > > > +		u64 unaligned_size =3D min(ALIGN(iova, SZ_2M) - iova, size);
> > > > +
> > > > +		ret =3D panthor_vm_map_pages(vm, iova, prot, sgt,
> > > > +					   0, unaligned_size);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +
> > > > +		size -=3D unaligned_size;
> > > > +		iova +=3D unaligned_size;
> > > > +	}
> > > > +
> > > > +	/* TODO: we should probably optimize this at the io_pgtable level=
. */
> > > > +	while (size > 0) {
> > > > +		u64 next_size =3D min(size, sg_dma_len(sgt->sgl)); =20
> > >
> > > Here we're only using the first entry of the scatter list. So I think=
 in
> > > the fragmented case we don't end up using the full 2MB. =20
> >
> > It should just be
> >
> > 		u32 chunk_size =3D min(size, SZ_2M);
> >
> > really. The fact the BO is backed by physically contiguous memory
> > doesn't matter because panthor_vm_map_pages() can cope with that
> > already.
> > =20
> > > =20
> > > > +
> > > > +		ret =3D panthor_vm_map_pages(vm, iova, prot,
> > > > +					   sgt, 0, next_size);
> > > > +		if (ret)
> > > > +			goto err_unmap;
> > > > +
> > > > +		size -=3D next_size;
> > > > +		iova +=3D next_size;
> > > > +	} =20
> >
> > To sum up, the whole thing can be simplified to something like:
> >
> > static int
> > panthor_vm_map_sparse(struct panthor_vm *vm, u64 iova, int prot,
> > 		      struct sg_table *sgt, u64 size)
> > 	u64 offset =3D 0;
> >
> > 	while (offset < size) {
> > 		u32 chunk_size =3D min(size - offset, SZ_2M - (iova & (SZ_2M - 1))); =
=20
>                                                                ^
>                                     I suppose here you meant ((iova + off=
set) & (SZ_2M - 1))?

Yep, sorry, it's (iova + offset), I went back and forth on this loop,
and forgot to add the `+ offset` there (we probably want a local var
containing iova + offset that we can directly pass to
panthor_vm_map_pages(), and which also reduce the length of this line).

>=20
> > 		ret =3D panthor_vm_map_pages(vm, iova + offset, prot,
> > 					   sgt, 0, chunk_size);
> > 		if (ret) {
> > 			panthor_vm_unmap_pages(vm, iova, offset);
> > 			return ret;
> > 		}
> >
> > 		offset +=3D chunk_size; =20
>=20
> Would you be alright if I named it 'mapped' instead of 'offset'?

Sure, mapped sounds okay to me.

>=20
> > 	}
> >
> > 	return 0;
> > } =20
>=20
> Adrian Larumbe


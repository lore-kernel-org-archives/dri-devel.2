Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC45FE5205
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:31:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E3210F4E7;
	Fri, 24 Apr 2026 10:31:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="mTjKWwUU";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99A6B10F4E7
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 10:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777026668;
 bh=CSIDPJJ8p3zm+XDwljCYWLRFPMiDgxT5iS5X0HuRjd0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=mTjKWwUU/Ui+mpiG5bdLpx0JCgH8NOIMFNuxJiMobCUpHPyG0w6tLQP8ZhfG7/YE+
 gkbRYbh/tnty0L1D0tb378klLD5m+0JfiHU2HYTdhpn/yUL0J6KlgR4o8inJpBiZEa
 kTNRxVZ8fT65z7hpuXuUAms41PvMIfa9/IZl8o25hodNiwqtNTYjl5NnB/AizjmP+2
 e1xF8t0AFxL7SmZ5tZBrSYqk0df9D5ggbuLRNIHk4LWmruNebXkT+Osz5ATgAS5xzi
 jcCcN+Hobu5h1Dzm3DSPDV8p9e7/qG/Nsdeb01TM+WPmwrDrfM9grd+HVN+TBeV5Rc
 ZkRVSgVgYhGFA==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9679817E12E5;
 Fri, 24 Apr 2026 12:31:07 +0200 (CEST)
Date: Fri, 24 Apr 2026 12:31:03 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com, Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v9 5/6] drm/panthor: Support sparse mappings
Message-ID: <20260424123103.28f6ada7@fedora>
In-Reply-To: <f0ec1b96-a6ff-49c6-b57d-740f97ac867f@arm.com>
References: <20260422122538.3117380-1-adrian.larumbe@collabora.com>
 <20260422122538.3117380-6-adrian.larumbe@collabora.com>
 <f0ec1b96-a6ff-49c6-b57d-740f97ac867f@arm.com>
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

On Fri, 24 Apr 2026 11:09:27 +0100
Steven Price <steven.price@arm.com> wrote:

> Hi Adri=C3=A1n,
>=20
> On 22/04/2026 13:25, Adri=C3=A1n Larumbe wrote:
> > Allow UM to bind sparsely populated memory regions by cyclically mapping
> > virtual ranges over a kernel-allocated dummy BO. This alternative is
> > preferable to the old method of handling sparseness in the UMD, because=
 it
> > relied on the creation of a buffer object to the same end, despite the =
fact
> > Vulkan sparse resources don't need to be backed by a driver BO.
> >=20
> > The choice of backing sparsely-bound regions with a Panhtor BO was made=
 so
> > as to profit from the existing shrinker reclaim code. That way no speci=
al
> > treatment must be given to the dummy sparse BOs when reclaiming memory,=
 as
> > would be the case if we had chosen a raw kernel page implementation.
> >=20
> > A new dummy BO is allocated per open file context, because even though =
the
> > Vulkan spec mandates that writes into sparsely bound regions must be
> > discarded, our implementation is still a workaround over the fact Mali =
CSF
> > GPUs cannot support this behaviour on the hardware level, so writes sti=
ll
> > make it into the backing BO. If we had a global one, then it could be a
> > venue for information leaks between file contexts, which should never
> > happen in DRM.
> >=20
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> =20
>=20
> Looks good, a few issues below.
>=20
> I'm worried about remap_evicted_vma() and how that interacts with sparse
> mappings. Does that need to be fixed up to handle sparse mappings? Or is
> there something to prevent the dummy BO being reclaimed? I might be
> missing something here.

Given the sparse mappings still have a vm_bo+gem object attached to them,
I think reclaim is fine, but I'll double check.

> > +static int
> > +panthor_vm_map_sparse(struct panthor_vm *vm, u64 iova, int prot,
> > +		      struct sg_table *sgt, u64 size)
> > +{
> > +	u64 start_iova =3D iova;
> > +	int ret;
> > +
> > +	if (iova & (SZ_2M - 1)) {
> > +		u64 unaligned_size =3D min(ALIGN(iova, SZ_2M) - iova, size);
> > +
> > +		ret =3D panthor_vm_map_pages(vm, iova, prot, sgt,
> > +					   0, unaligned_size);
> > +		if (ret)
> > +			return ret;
> > +
> > +		size -=3D unaligned_size;
> > +		iova +=3D unaligned_size;
> > +	}
> > +
> > +	/* TODO: we should probably optimize this at the io_pgtable level. */
> > +	while (size > 0) {
> > +		u64 next_size =3D min(size, sg_dma_len(sgt->sgl)); =20
>=20
> Here we're only using the first entry of the scatter list. So I think in
> the fragmented case we don't end up using the full 2MB.

It should just be

		u32 chunk_size =3D min(size, SZ_2M);

really. The fact the BO is backed by physically contiguous memory
doesn't matter because panthor_vm_map_pages() can cope with that
already.

>=20
> > +
> > +		ret =3D panthor_vm_map_pages(vm, iova, prot,
> > +					   sgt, 0, next_size);
> > +		if (ret)
> > +			goto err_unmap;
> > +
> > +		size -=3D next_size;
> > +		iova +=3D next_size;
> > +	}

To sum up, the whole thing can be simplified to something like:

static int
panthor_vm_map_sparse(struct panthor_vm *vm, u64 iova, int prot,
		      struct sg_table *sgt, u64 size)
	u64 offset =3D 0;

	while (offset < size) {
		u32 chunk_size =3D min(size - offset, SZ_2M - (iova & (SZ_2M - 1)));

		ret =3D panthor_vm_map_pages(vm, iova + offset, prot,
					   sgt, 0, chunk_size);
		if (ret) {
			panthor_vm_unmap_pages(vm, iova, offset);
			return ret;
		}

		offset +=3D chunk_size;
	}

	return 0;
}

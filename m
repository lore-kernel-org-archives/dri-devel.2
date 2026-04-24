Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DAAFE51FE
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 12:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 187F810E3CB;
	Fri, 24 Apr 2026 12:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="lLlLSt5f";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF1FF10E3CB
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 12:06:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777032391; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CH7j5q5OBpyzXt4CYQNHx8IF8ijwA6mjF+0zrTPoRi2CtwfzBajLbFIv+ney2qxpVg5VsLr9GsroEHkk7VKlmejERIxWzE/hRcptKOoSp3xgBskIDSsJ4yT3x30ORdq7qYiWzuADbtIDpnyvdl6rppNh3e68ihW2X+qdVJ1qLZA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777032391;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wIfioaMKdxXkMLLrQfC/H+yBe/zaaGN3lZU/bRCZ0qw=; 
 b=c+qQwLQeVXFpk+U1aZMjT2kPK1Pt72sd2QKgR3QPl/QYd3RElYl2BVCZ+uvnVIBJ3QJ4WjKZD2FlcX1m8oc32i+Ux22RJVRa/VVbPLTXRCp+JsADQ5NAAWDQAS8UZ0GlYBvHtOqcZRfW/zg4Qr2z3AZ4XjifZxQs6MABM5D2aZE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777032391; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=wIfioaMKdxXkMLLrQfC/H+yBe/zaaGN3lZU/bRCZ0qw=;
 b=lLlLSt5f9jsKoWaba8aKYNuMoqTf7AC4MqDVRoZNuw17qpnj86oUWwtl0YMAZWte
 vlGFytCffiY1CR0gVYPEo8UTZI/mYSAY3q+D8c03HNbnLU45QO7krAm9MJvdlOfZx4n
 cmJH4uygkaqde4y4wdLAWu9gVq4Od5dnPC/0AvEs=
Received: by mx.zohomail.com with SMTPS id 1777032389389990.1226301088174;
 Fri, 24 Apr 2026 05:06:29 -0700 (PDT)
Date: Fri, 24 Apr 2026 13:06:24 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, kernel@collabora.com,
 Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v9 5/6] drm/panthor: Support sparse mappings
Message-ID: <aetcRc4eciDFmOi8@sobremesa>
References: <20260422122538.3117380-1-adrian.larumbe@collabora.com>
 <20260422122538.3117380-6-adrian.larumbe@collabora.com>
 <f0ec1b96-a6ff-49c6-b57d-740f97ac867f@arm.com>
 <20260424123103.28f6ada7@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424123103.28f6ada7@fedora>
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

Hi Boris,

On 24.04.2026 12:31, Boris Brezillon wrote:
> On Fri, 24 Apr 2026 11:09:27 +0100
> Steven Price <steven.price@arm.com> wrote:
>
> > Hi Adrián,
> >
> > On 22/04/2026 13:25, Adrián Larumbe wrote:
> > > Allow UM to bind sparsely populated memory regions by cyclically mapping
> > > virtual ranges over a kernel-allocated dummy BO. This alternative is
> > > preferable to the old method of handling sparseness in the UMD, because it
> > > relied on the creation of a buffer object to the same end, despite the fact
> > > Vulkan sparse resources don't need to be backed by a driver BO.
> > >
> > > The choice of backing sparsely-bound regions with a Panhtor BO was made so
> > > as to profit from the existing shrinker reclaim code. That way no special
> > > treatment must be given to the dummy sparse BOs when reclaiming memory, as
> > > would be the case if we had chosen a raw kernel page implementation.
> > >
> > > A new dummy BO is allocated per open file context, because even though the
> > > Vulkan spec mandates that writes into sparsely bound regions must be
> > > discarded, our implementation is still a workaround over the fact Mali CSF
> > > GPUs cannot support this behaviour on the hardware level, so writes still
> > > make it into the backing BO. If we had a global one, then it could be a
> > > venue for information leaks between file contexts, which should never
> > > happen in DRM.
> > >
> > > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> >
> > Looks good, a few issues below.
> >
> > I'm worried about remap_evicted_vma() and how that interacts with sparse
> > mappings. Does that need to be fixed up to handle sparse mappings? Or is
> > there something to prevent the dummy BO being reclaimed? I might be
> > missing something here.
>
> Given the sparse mappings still have a vm_bo+gem object attached to them,
> I think reclaim is fine, but I'll double check.
>
> > > +static int
> > > +panthor_vm_map_sparse(struct panthor_vm *vm, u64 iova, int prot,
> > > +		      struct sg_table *sgt, u64 size)
> > > +{
> > > +	u64 start_iova = iova;
> > > +	int ret;
> > > +
> > > +	if (iova & (SZ_2M - 1)) {
> > > +		u64 unaligned_size = min(ALIGN(iova, SZ_2M) - iova, size);
> > > +
> > > +		ret = panthor_vm_map_pages(vm, iova, prot, sgt,
> > > +					   0, unaligned_size);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		size -= unaligned_size;
> > > +		iova += unaligned_size;
> > > +	}
> > > +
> > > +	/* TODO: we should probably optimize this at the io_pgtable level. */
> > > +	while (size > 0) {
> > > +		u64 next_size = min(size, sg_dma_len(sgt->sgl));
> >
> > Here we're only using the first entry of the scatter list. So I think in
> > the fragmented case we don't end up using the full 2MB.
>
> It should just be
>
> 		u32 chunk_size = min(size, SZ_2M);
>
> really. The fact the BO is backed by physically contiguous memory
> doesn't matter because panthor_vm_map_pages() can cope with that
> already.
>
> >
> > > +
> > > +		ret = panthor_vm_map_pages(vm, iova, prot,
> > > +					   sgt, 0, next_size);
> > > +		if (ret)
> > > +			goto err_unmap;
> > > +
> > > +		size -= next_size;
> > > +		iova += next_size;
> > > +	}
>
> To sum up, the whole thing can be simplified to something like:
>
> static int
> panthor_vm_map_sparse(struct panthor_vm *vm, u64 iova, int prot,
> 		      struct sg_table *sgt, u64 size)
> 	u64 offset = 0;
>
> 	while (offset < size) {
> 		u32 chunk_size = min(size - offset, SZ_2M - (iova & (SZ_2M - 1)));
                                                               ^
                                    I suppose here you meant ((iova + offset) & (SZ_2M - 1))?

> 		ret = panthor_vm_map_pages(vm, iova + offset, prot,
> 					   sgt, 0, chunk_size);
> 		if (ret) {
> 			panthor_vm_unmap_pages(vm, iova, offset);
> 			return ret;
> 		}
>
> 		offset += chunk_size;

Would you be alright if I named it 'mapped' instead of 'offset'?

> 	}
>
> 	return 0;
> }

Adrian Larumbe

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6612CCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9977110F094;
	Wed, 20 May 2026 14:44:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Jk+SBRmX";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9F8310F094
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779288257;
 bh=QmwuzewkVbLg4n5w3vw+KAhs4FYKjhey77KymFbvj/g=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Jk+SBRmXKrd5OZNxuf19CskKl3KYqJdl/mLtKpaGjYrK/gml8sp9nI1RH+M1kmaxt
 +VfYm2nX0mJNN1yMviCUr5zKJidA5IV+XQAJTIbzQYt9/UMAwJJ9pPm7qn+s9LqljO
 8dgatVbHLFFjvwosMj8910BF8Msh2clj/owUkeguYt9aATO80hvY9rmR2pN86BaVZu
 R97cdl9yI+ex4sbdhs8BF6dO1nriOvZPCz1yoCto1uUxXrJxcm8yPVRGCr7nHT5/GL
 g5o87/Uox7PVLEd+hJZIWCn+HfuQmiDc4nJQG6oJUC7X94bTP80DerMvkGdpHk9OaF
 IPeQVHQrRfb8g==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B5C1917E0504;
 Wed, 20 May 2026 16:44:16 +0200 (CEST)
Date: Wed, 20 May 2026 16:44:12 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Igor Torrente <igor.torrente@collabora.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, loic.molinari@collabora.com,
 willy@infradead.org, frank.binns@imgtec.com, matt.coster@imgtec.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 5/6] drm/gem-shmem: Track folio accessed/dirty status
 in mmap
Message-ID: <20260520164412.3a73d85a@fedora>
In-Reply-To: <d89422f1-f00a-47b1-b68a-d949d6d6a974@collabora.com>
References: <20260209133241.238813-1-tzimmermann@suse.de>
 <20260209133241.238813-6-tzimmermann@suse.de>
 <d89422f1-f00a-47b1-b68a-d949d6d6a974@collabora.com>
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

On Wed, 20 May 2026 10:11:03 -0300
Igor Torrente <igor.torrente@collabora.com> wrote:

> On 2/9/26 10:27, Thomas Zimmermann wrote:
> > Invoke folio_mark_accessed() in mmap page faults to add the folio to
> > the memory manager's LRU list. Userspace invokes mmap to get the memory
> > for software rendering. Compositors do the same when creating the final
> > on-screen image, so keeping the pages in LRU makes sense. Avoids paging
> > out graphics buffers when under memory pressure.
> >
> > In pfn_mkwrite, further invoke the folio_mark_dirty() to add the folio
> > for writeback should the underlying file be paged out from system memor=
y.
> > This rarely happens in practice, yet it would corrupt the buffer conten=
t.
> >
> > This has little effect on a system's hardware-accelerated rendering, wh=
ich
> > only mmaps for an initial setup of textures, meshes, shaders, etc.
> >
> > v3:
> > - rewrite for VM_PFNMAP
> > v2:
> > - adapt to changes in drm_gem_shmem_try_mmap_pmd()
> >
> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com> =20
>=20
> Hi Thomas,
>=20
> I have and Radxa ROCK 5B+ with Mali-G610 GPU and I'm developing the VDRM=
=20
> (native context) driver
> for panthor.ko.
>=20
> Recently I update my kernel from 7.0 to the 7.1-rc3, and qemu started=20
> freezing with KVM error below
> when running any graphical application with Venus or Panthor VDRM. For=20
> some reason Virgl is not affected.
>=20
> ```
> error: kvm run failed Bad address
> PC=3D0000ffffb4a86d70 X00=3D0000ffffb4be5000 X01=3D0000ffffb2279bb0
> X02=3D0000000000000600 X03=3D0000ffffb4be5000 X04=3D0000ffffb227a1b0
> X05=3D0000ffffb4be5600 X06=3D0000000000000001 X07=3D0000aaaaf384fd80
> X08=3Ddcc58d0daf897753 X09=3D0000000000000002 X10=3D0000ffffb4b96758
> X11=3D000000002533f84b X12=3D0000000000001060 X13=3D0000000000000000
> X14=3D0000000000000000 X15=3D0000000000000010 X16=3D0000ffffb3880128
> X17=3D0000ffffb4a86c80 X18=3D0000000000000000 X19=3D0000aaaaf384f8a0
> X20=3D0000aaaaf37cec80 X21=3D0000aaaaf37c7210 X22=3D0000aaaaf37c9550
> X23=3D0000aaaaf37c74e0 X24=3D0000ffffb3b47fc8 X25=3D0000ffffb3b47fc8
> X26=3D0000ffffb3b43c78 X27=3D0000aaaaf37e1840 X28=3D0000aaaaf37cee50
> X29=3D0000ffffecbf1a60 X30=3D0000ffffb364b530=C2=A0 SP=3D0000ffffecbf1a60
> PSTATE=3D0000000020001000 --C- EL0t
> ```
>=20
> After bisecting I reach to your commit.
>=20
> ```
> 28e3918179aa75cfd4490b3b0281496ed91d829a=C2=A0 drm/gem-shmem:
> Track folio accessed/dirty status in mmap
> ```
>=20
> It still reproducible in the 7.1-rc4 (ab5fce87a778).
>=20
> Appling the following patch (Boris suggestion) fixes the issue for me.
>=20
> ```
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c=20
> b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 545933c7f712..1e036f69c1ce 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -696,7 +696,7 @@ const struct vm_operations_struct=20
> drm_gem_shmem_vm_ops =3D {
>  =C2=A0#endif
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 .open =3D drm_gem_shmem_vm_open,
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 .close =3D drm_gem_shmem_vm_close,
> -=C2=A0 =C2=A0 =C2=A0 =C2=A0.pfn_mkwrite =3D drm_gem_shmem_pfn_mkwrite,
> +//=C2=A0 =C2=A0 =C2=A0.pfn_mkwrite =3D drm_gem_shmem_pfn_mkwrite,
>  =C2=A0};
>  =C2=A0EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);
> ```
>=20
> I'm not familiar with the drm_gem, code so I don't any more insightful=20
> information
> to share.=C2=A0 But hopefully we can find a better fix for this.

Hm, given how close we are from the end of the release cycle, it might
be safer to revert those .pfn_mkwrite changes and consider them again
once all the details have been sorted out (it's the second time around
we hit issues on this patch, and the lack of reviews from MM devs is
scaring me bit to be honest).

Thomas, any opinion?


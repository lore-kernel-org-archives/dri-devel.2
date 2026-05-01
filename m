Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACF7FF8864
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 04:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FCE510E1CA;
	Fri,  1 May 2026 04:15:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ebbbgoaJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5A9610E1CA
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 04:15:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6602943C5F
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 04:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A430C2BCB9
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 04:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777608914;
 bh=hwui33Gqc7TcxagOv3mfkPPBrPZLNR0VJUZ+uXQBFVM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ebbbgoaJfH0H2QNq/r3U5qQlj2If2T+VMqOAnQI2RngEcd26Ehz3a0R2RsQJ+Caq9
 gDS9FCjUrCqVBZLytR+0XifERlMbUASZ+GTnVBxsyiRYKKcv69QbMdWHFT1JoX1ZtJ
 cAVDceamM7V/dNSVQSCzGelYfYquATRv37/onb8tq+gRgIImRnBj/Kjj1fldbJ4U5l
 Noht2LsBm+zSDTv1cK3d06V+w1yW03DDm3ngzP92gDfvOKsirlCYGgjH5U/Zaim8zt
 pD4uNxLgWwp4nTEvrecHsDbo4eWI+0INwPIXyGHwM7Wu09dOXDl+220hDrHloF5bma
 gnztHzGoNXlRw==
Received: by mail-qv1-f46.google.com with SMTP id
 6a1803df08f44-8b45dff1eebso11201266d6.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 21:15:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+qe9i3zLKWB+bF+zwASwbNKRBZuIozgbLlBbGkvoLoV8wnEXAqZmx+IZA0jAGuTjAVaxdXDI9tCc8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/rJY7oV78VHFaR2pA1+kUHPwTCy1aVcxHN1weKDDxveTmAfzL
 xEuAgtbtVjNSRij8wBDva0zkFx5EMVWSLqxNcIN1k5GmQgqwqAib9UOfrG8SWP7PDxKUZR01zGi
 l/l5OPeYwXX4TBbjzorp6Ki56eqEKW08=
X-Received: by 2002:a05:6214:20c8:b0:8ac:8cbb:49bd with SMTP id
 6a1803df08f44-8b48200b722mr76592026d6.38.1777608913488; Thu, 30 Apr 2026
 21:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260406214938.24142-1-baohua@kernel.org>
 <a6d1c89a-3c71-4e06-adcb-56595071dcc2@amd.com>
 <CAGsJ_4xquCzQLbvpkC8arAN=9KhrAkdPdxnB=v85GvvQu23Xyg@mail.gmail.com>
 <9034246e-3971-4fad-94b7-80f4ad0e29db@amd.com>
In-Reply-To: <9034246e-3971-4fad-94b7-80f4ad0e29db@amd.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 1 May 2026 12:15:01 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4z5EZoNMBVnu6sCkThyi9VTCeCH29buVecuySuv_Ry8fw@mail.gmail.com>
X-Gm-Features: AVHnY4LHlyYebn_G01H7PE4heMOjmK8GdhdSAhmc9BNXcAEKzwaicCFdtdH3nd8
Message-ID: <CAGsJ_4z5EZoNMBVnu6sCkThyi9VTCeCH29buVecuySuv_Ry8fw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: system_heap: Optimize sg_table-to-pages
 conversion in vmap
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Xueyuan Chen <Xueyuan.chen21@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Apr 22, 2026 at 3:10=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/7/26 13:29, Barry Song wrote:
> > On Tue, Apr 7, 2026 at 3:58=E2=80=AFPM Christian K=C3=B6nig <christian.=
koenig@amd.com> wrote:
> >>
> >> On 4/6/26 23:49, Barry Song (Xiaomi) wrote:
> >>> From: Xueyuan Chen <Xueyuan.chen21@gmail.com>
> >>>
> >>> Replace the heavy for_each_sgtable_page() iterator in system_heap_do_=
vmap()
> >>> with a more efficient nested loop approach.
> >>>
> >>> Instead of iterating page by page, we now iterate through the scatter=
list
> >>> entries via for_each_sgtable_sg(). Because pages within a single sg e=
ntry
> >>> are physically contiguous, we can populate the page array with a in a=
n
> >>> inner loop using simple pointer math. This save a lot of time.
> >>>
> >>> The WARN_ON check is also pulled out of the loop to save branch
> >>> instructions.
> >>>
> >>> Performance results mapping a 2GB buffer on Radxa O6:
> >>> - Before: ~1440000 ns
> >>> - After:  ~232000 ns
> >>> (~84% reduction in iteration time, or ~6.2x faster)
> >>
> >> Well real question is why do you care about the vmap performance?
> >>
> >> That should basically only be used for fbdev emulation (except for VMG=
FX) and we absolutely don't care about performance there.
> >
> > I agree that in mainline, dma_buf_vmap is not used very often.
> > Here=E2=80=99s what I was able to find:
> >
> >   1   1638  drivers/dma-buf/dma-buf.c <<dma_buf_vmap_unlocked>>
> >              ret =3D dma_buf_vmap(dmabuf, map);
> >    2    376  drivers/gpu/drm/drm_gem_shmem_helper.c
> > <<drm_gem_shmem_vmap_locked>>
> >              ret =3D dma_buf_vmap(obj->import_attach->dmabuf, map);
> >    3     85  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> > <<etnaviv_gem_prime_vmap_impl>>
> >              ret =3D dma_buf_vmap(etnaviv_obj->base.import_attach->dmab=
uf, &map);
> >    4    433  drivers/gpu/drm/vmwgfx/vmwgfx_blit.c <<map_external>>
> >              ret =3D dma_buf_vmap(bo->tbo.base.dma_buf, map);
> >    5     88  drivers/gpu/drm/vmwgfx/vmwgfx_gem.c <<vmw_gem_vmap>>
> >              ret =3D dma_buf_vmap(obj->import_attach->dmabuf, map);
> >
> > However, in the Android ecosystem, system_heap and similar heaps
> > are widely used across camera, NPU, and media drivers. Many of these
> > drivers are not in mainline but do use vmap() in real code paths.
>
> Well out of tree drivers are not a justification to make an upstream chan=
ges.
>
> Apart from a handful of workarounds which need to CPU access as fallback =
DMA-buf vmap is only used to provide fb dev emulation.
>
> The vmap interface has already given us quite a headache in the first pla=
ce and there are a couple of unresolved problems regarding synchronization =
and coherency.
>
> When a driver would be pushed upstream which makes so frequent use of the=
 dma_buf_vmap function that it matters for the performance I think there wo=
uld be push back on that and the driver developer would require a very good=
 explanation why that is necessary.
>
> So for now I have to reject that patch.

Well, it doesn=E2=80=99t seem to increase complexity, and the code is quite=
 easy
to understand. It would be great if the community could be more welcoming
to developers who are just getting involved, rather than discouraging them.

Apparently, no one can control whether the source code of those kernel
modules will be upstreamed except the vendors themselves, but products
can still benefit from the common kernel.

>
> Regards,
> Christian.
>
> >
> > As I can show you some of them from MTK platforms:
> >
> > 1:
> > [    6.689849] system_heap_vmap+0x17c/0x254 [system_heap
> > 8d35d4ce35bb30d8a623f0b9863998a2528e4175]
> > [    6.689859] dma_buf_vmap_unlocked+0xb8/0x130
> > [    6.689861] aov_core_init+0x310/0x718 [mtk_aov
> > 96e2e5e9457dcdacce3a7629b0600c5dbeca623b]
> > [    6.689873] mtk_aov_probe+0x434/0x5b4 [mtk_aov
> > 96e2e5e9457dcdacce3a7629b0600c5dbeca623b]
> >
> > 2:
> > [  116.181643] __vmap_pages_range_noflush+0x7c4/0x814
> > [  116.181645] vmap+0xb4/0x148
> > [  116.181647] system_heap_vmap+0x17c/0x254 [system_heap
> > 8d35d4ce35bb30d8a623f0b9863998a2528e4175]
> > [  116.181651] dma_buf_vmap_unlocked+0xb8/0x130
> > [  116.181653] mtk_cam_vb2_vaddr+0xa0/0xfc [mtk_cam_isp8s
> > 0cf9be6c773a8f14aab9db9ebf53feacb499846a]
> > [  116.181682] vb2_plane_vaddr+0x5c/0x78
> > [  116.181684] mtk_cam_job_fill_ipi_frame+0xa8c/0x128c [mtk_cam_isp8s
> > 0cf9be6c773a8f14aab9db9ebf53feacb499846a]
> >
> > 3:
> > [  116.306178] __vmap_pages_range_noflush+0x7c4/0x814
> > [  116.306183] vmap+0xb4/0x148
> > [  116.306187] system_heap_vmap+0x17c/0x254 [system_heap
> > 8d35d4ce35bb30d8a623f0b9863998a2528e4175]
> > [  116.306209] dma_buf_vmap_unlocked+0xb8/0x130
> > [  116.306212] apu_sysmem_alloc+0x168/0x360 [apusys
> > 8fb33cbce3b858d651b9da26fc370090a67cfb70]
> > [  116.306468] mdw_mem_alloc+0xd8/0x314 [apusys
> > 8fb33cbce3b858d651b9da26fc370090a67cfb70]
> > [  116.306591] mdw_mem_pool_chunk_add+0x11c/0x400 [apusys
> > 8fb33cbce3b858d651b9da26fc370090a67cfb70]
> > [  116.306712] mdw_mem_pool_create+0x190/0x2c8 [apusys
> > 8fb33cbce3b858d651b9da26fc370090a67cfb70]
> > [  116.306833] mdw_drv_open+0x21c/0x47c [apusys
> > 8fb33cbce3b858d651b9da26fc370090a67cfb70]
> >
> > While we may want to encourage more of these drivers to upstream,
> > some aspects are beyond our control (different SoC vendors), but we
> > can at least contribute upstream ourselves.
> >

Best Regards
Barry

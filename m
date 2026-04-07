Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5EFFEEF24
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 11:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFAFB89266;
	Tue,  7 Apr 2026 11:29:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nFsprJ4z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D9089266
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 11:29:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F13D42AE2
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 11:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70221C116C6
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 11:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775561386;
 bh=qzFdNf24GS4Ly5CHwayANIzIoWhMQniFzGPpI4pUPho=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=nFsprJ4zJZSyDb2PTmpEZNyptyMpkpG+ZnGeiOFUe/tBj5Q9bJWN0AsKWqKdbo9ZB
 d4GHZ/7/0QhSTQCAAGy7KPAQ4JOtjmYQ4ksiYEQXF1c1TBzd60OijCfr7Xhr2QrbLy
 9rQXtOyu8bio+Z7lz1X7fSIQKx8gBK93d+dmRt/ZvcHoDKpcqxdzlbA2iYZb9Cy0Oj
 KKI0KtmTsCE/0/QEubPWZn/TLYDfe+YkWvU8plJK9Fg/uFeI9gJlJ/HAKSxEapWsxz
 /nS3uWJ84LzoipKWXquluFIdAPieYbX+pD3qy1npgu5Qk1nUvS7cPPAMjkLcxnm2J9
 kjFWwfPnM68pA==
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-899a9f445cbso63249796d6.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 04:29:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWUbWGYEjGN0X/HCrPGPifV0xZislkrc9Hu53sBtF2M+X96Y4tI7qXyjELNz00UpQ/Grz9x8osYRbk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwABIyaB/hhwOIIN/JyRT0qiRzlFYO/uJp/wfpiJ/NuLSzOMWEG
 6PyR+u6PiavD+loH4h27f/FOm8SvlbrZOeFlwT3BPwxcIA8MRJ67kUVcmUC+s5UjvAipEia3RIn
 b+Fttr2Ag6QzNFIoiMyNP/sML5rO3xuU=
X-Received: by 2002:a0c:f107:0:b0:89a:13a5:77c4 with SMTP id
 6a1803df08f44-8a7042f8989mr199609476d6.29.1775561384825; Tue, 07 Apr 2026
 04:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260406214938.24142-1-baohua@kernel.org>
 <a6d1c89a-3c71-4e06-adcb-56595071dcc2@amd.com>
In-Reply-To: <a6d1c89a-3c71-4e06-adcb-56595071dcc2@amd.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 7 Apr 2026 19:29:33 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xquCzQLbvpkC8arAN=9KhrAkdPdxnB=v85GvvQu23Xyg@mail.gmail.com>
X-Gm-Features: AQROBzByIp-0FrtX8dG4RIp7qFh22LJ0SbQzx_vfuvErBnErshq0dg6Qu7Vr00I
Message-ID: <CAGsJ_4xquCzQLbvpkC8arAN=9KhrAkdPdxnB=v85GvvQu23Xyg@mail.gmail.com>
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

On Tue, Apr 7, 2026 at 3:58=E2=80=AFPM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 4/6/26 23:49, Barry Song (Xiaomi) wrote:
> > From: Xueyuan Chen <Xueyuan.chen21@gmail.com>
> >
> > Replace the heavy for_each_sgtable_page() iterator in system_heap_do_vm=
ap()
> > with a more efficient nested loop approach.
> >
> > Instead of iterating page by page, we now iterate through the scatterli=
st
> > entries via for_each_sgtable_sg(). Because pages within a single sg ent=
ry
> > are physically contiguous, we can populate the page array with a in an
> > inner loop using simple pointer math. This save a lot of time.
> >
> > The WARN_ON check is also pulled out of the loop to save branch
> > instructions.
> >
> > Performance results mapping a 2GB buffer on Radxa O6:
> > - Before: ~1440000 ns
> > - After:  ~232000 ns
> > (~84% reduction in iteration time, or ~6.2x faster)
>
> Well real question is why do you care about the vmap performance?
>
> That should basically only be used for fbdev emulation (except for VMGFX)=
 and we absolutely don't care about performance there.

I agree that in mainline, dma_buf_vmap is not used very often.
Here=E2=80=99s what I was able to find:

  1   1638  drivers/dma-buf/dma-buf.c <<dma_buf_vmap_unlocked>>
             ret =3D dma_buf_vmap(dmabuf, map);
   2    376  drivers/gpu/drm/drm_gem_shmem_helper.c
<<drm_gem_shmem_vmap_locked>>
             ret =3D dma_buf_vmap(obj->import_attach->dmabuf, map);
   3     85  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
<<etnaviv_gem_prime_vmap_impl>>
             ret =3D dma_buf_vmap(etnaviv_obj->base.import_attach->dmabuf, =
&map);
   4    433  drivers/gpu/drm/vmwgfx/vmwgfx_blit.c <<map_external>>
             ret =3D dma_buf_vmap(bo->tbo.base.dma_buf, map);
   5     88  drivers/gpu/drm/vmwgfx/vmwgfx_gem.c <<vmw_gem_vmap>>
             ret =3D dma_buf_vmap(obj->import_attach->dmabuf, map);

However, in the Android ecosystem, system_heap and similar heaps
are widely used across camera, NPU, and media drivers. Many of these
drivers are not in mainline but do use vmap() in real code paths.

As I can show you some of them from MTK platforms:

1:
[    6.689849] system_heap_vmap+0x17c/0x254 [system_heap
8d35d4ce35bb30d8a623f0b9863998a2528e4175]
[    6.689859] dma_buf_vmap_unlocked+0xb8/0x130
[    6.689861] aov_core_init+0x310/0x718 [mtk_aov
96e2e5e9457dcdacce3a7629b0600c5dbeca623b]
[    6.689873] mtk_aov_probe+0x434/0x5b4 [mtk_aov
96e2e5e9457dcdacce3a7629b0600c5dbeca623b]

2:
[  116.181643] __vmap_pages_range_noflush+0x7c4/0x814
[  116.181645] vmap+0xb4/0x148
[  116.181647] system_heap_vmap+0x17c/0x254 [system_heap
8d35d4ce35bb30d8a623f0b9863998a2528e4175]
[  116.181651] dma_buf_vmap_unlocked+0xb8/0x130
[  116.181653] mtk_cam_vb2_vaddr+0xa0/0xfc [mtk_cam_isp8s
0cf9be6c773a8f14aab9db9ebf53feacb499846a]
[  116.181682] vb2_plane_vaddr+0x5c/0x78
[  116.181684] mtk_cam_job_fill_ipi_frame+0xa8c/0x128c [mtk_cam_isp8s
0cf9be6c773a8f14aab9db9ebf53feacb499846a]

3:
[  116.306178] __vmap_pages_range_noflush+0x7c4/0x814
[  116.306183] vmap+0xb4/0x148
[  116.306187] system_heap_vmap+0x17c/0x254 [system_heap
8d35d4ce35bb30d8a623f0b9863998a2528e4175]
[  116.306209] dma_buf_vmap_unlocked+0xb8/0x130
[  116.306212] apu_sysmem_alloc+0x168/0x360 [apusys
8fb33cbce3b858d651b9da26fc370090a67cfb70]
[  116.306468] mdw_mem_alloc+0xd8/0x314 [apusys
8fb33cbce3b858d651b9da26fc370090a67cfb70]
[  116.306591] mdw_mem_pool_chunk_add+0x11c/0x400 [apusys
8fb33cbce3b858d651b9da26fc370090a67cfb70]
[  116.306712] mdw_mem_pool_create+0x190/0x2c8 [apusys
8fb33cbce3b858d651b9da26fc370090a67cfb70]
[  116.306833] mdw_drv_open+0x21c/0x47c [apusys
8fb33cbce3b858d651b9da26fc370090a67cfb70]

While we may want to encourage more of these drivers to upstream,
some aspects are beyond our control (different SoC vendors), but we
can at least contribute upstream ourselves.

Best Regards
Barry

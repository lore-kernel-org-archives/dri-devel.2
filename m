Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052FEFF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 14:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3712110EAEA;
	Tue,  5 May 2026 14:44:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="KUrQfZ64";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D02110EAEA
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 14:44:18 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-48d1c670255so51935e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 07:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777992257; cv=none;
 d=google.com; s=arc-20240605;
 b=c8oqjaLQPkg7584kYQfT6DF/FXhkQ3djuHi5V1WvkJzcg2PAr/VRrlFLTJV6Ah7dAO
 HZHx7ISFFauDnxJMwVfsl81c8eVRiHeR83MLijXA7SsUq3y+laITHq+1U3jQBVpqbUjk
 Q+LLcE6iuzTgfJKg6HLrpA9fhGKpaBKUFvCLBlshzb30ROnFKRL2rVO2ulPVSVZll8K5
 hBh8UkFxGAKnfZANaufzi0kJS36lK/LVltEWmjoFIel2tTZ7neU7DWZYVQXFfRLG9ti9
 RuvFfB5VroI9JExaNBewm63m1ErrW4UoXg2Q3yVGAHArIYpaKCYa0mMkMktIIVFW4CGt
 b/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xImKjLpphistWNUhM/BMGUgvs4K16/nDs7wCf3O5gxg=;
 fh=QgM6HjydHnATcSVxLRyfAKMrDVAr9R4CWr9TapmvSH0=;
 b=VlHOHRdtmIZUj4kW4LcLsP1T7MRfvkNAB0Dhky3RB17om22qAHermaLPq9nxHNDuSd
 NSQLbKrqgSKXQqch/Lh/FKryXJaphwoO4kWXhHH4qAtYa6tlliIWWlwBdXk2VQlxdvb/
 riJxB+u5lfdsBsCnpLvqUMiZiDf7TAxwErPVpj7C5nrfIbUYHEgVB0jR1t2zTELFaYhV
 YulitSBzSv+k4cNNxASfO7HSgYodl8SM9wZIjZi2uYYgrH28dKO9hWgJSJqZezMsH2Iv
 S/HHRFLSlSNqjmJcnXSSXXCZ2uSX5maGrDlLPk2V5SbSkeehco/LEsitj0iu/3FKD/l1
 JWSQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777992257; x=1778597057;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xImKjLpphistWNUhM/BMGUgvs4K16/nDs7wCf3O5gxg=;
 b=KUrQfZ64uqZiod/CWA8BBmYlmDmU5WlEuOR4FBgUCieHsKFck/M8cBe1vxcKI1wUF8
 CubQy7qsvvT7lYhqOG4PjDxO7pWIHH8QXScjQgl3SZFgtLoMD02NoT17jemqSfKNKJWS
 U+lVkxOHwuZbXOFJeF83i+j+z3Mhm8yqtNH580H/1OmixVb82YC5vTIaFOgEImgEemaP
 c73qu+E8e7ai4yPqoKLGrMrunFnBe88gNd0325Y0A7KnYx/sGY1pm8cKl8mWEQfnz6dQ
 g9TrgUS1BspGYgLje4i2SG0h9FhntNpt/eVwCEEs0pzG/qIsbRMTLC0zgHhstnTw/r44
 MrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777992257; x=1778597057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xImKjLpphistWNUhM/BMGUgvs4K16/nDs7wCf3O5gxg=;
 b=fZwKIcnZjRhvdovAZlGkGCCbA/9UPtB9a1/UCmu9dHoB9Q1Qp4ckpgWXLpiWemBykE
 aJr942zi2x2TfCNBDpvwNOvEwX6i4K4u8Azx0lI65chdC7Xj+TP2npWU6WKW8eIqQd5x
 XnRlkHwE9QMYOURy8eCo2OYCk0qzt3RcNN9vT+WhKsMw5xyT99NSN8n/I/C0+2+qOzZj
 9wPNapJ/F+fS8ixaQ1rw96VEESQV0flCky0REvCpY3jcMz3LAecIp+mvDEWw1FBPqQUJ
 C68JsnBJxeIj6VeTA3Hf2LZSj5nB29CxMc3p/52fmOYmH/zDwPuDRyrVmnowA2cxL1x/
 1NQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8JkgaqKHtbrMK1UOf9zjhldeHVVBulOoOynawgMcmj0oamE8IygKSDSoBzmiWa0/yvjtF4inLvrIQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyNDTE1l/2iKTSK4lwKS/yvDwkKiZYl3wybj7jXTaDivTMwUJMV
 I8OdI18gHUeQMte6lDY9dddVnP3eLtrbjSaN/7KGsVMtGB+2jqpTGAt6EOu82CJvJhtN19sQ0B9
 3oV8kj+g2Df74Ev1AH4QbAEicRvmi00AapxzNjzPm
X-Gm-Gg: AeBDietfVuQOirqyajjgWt11pSsnc+hBaImHBDmZzQfROX4KySCZ5qLH6dBvXb/CkG6
 YIXr86/y/m0ltwgpLi98CIIan3m09vI6q4YVrC+zhjiXBR5NcutLX2powYDm1U8ZF0Vrk0JCATp
 1u0NdCijgcusZ7f8KvMD2ytQVVDqfhTKF7JtSHn8pvoOt9cic4LJhzveplACMXZqRFvH8CS4hOD
 685vYqb/8fiDnNl68I/BHkXcQOxO9/oBtcNa6KXhK2jXO1xHeOO+VZtTCHFrqZ1m170MPWUGKZB
 06C/x6kmKjlyZxh6NdRrIz6/LL7r6OLCmeddTRIBlriQNYKRmV2qfRPsRPcm
X-Received: by 2002:a05:600c:4fd3:b0:485:1a54:9407 with SMTP id
 5b1f17b1804b1-48d14696188mr1306875e9.0.1777992256465; Tue, 05 May 2026
 07:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260406214938.24142-1-baohua@kernel.org>
 <a6d1c89a-3c71-4e06-adcb-56595071dcc2@amd.com>
 <CAGsJ_4xquCzQLbvpkC8arAN=9KhrAkdPdxnB=v85GvvQu23Xyg@mail.gmail.com>
 <9034246e-3971-4fad-94b7-80f4ad0e29db@amd.com>
 <CAGsJ_4z5EZoNMBVnu6sCkThyi9VTCeCH29buVecuySuv_Ry8fw@mail.gmail.com>
 <CABdmKX3baqmBkZxMB6PTG6Sj5S9qi+RwVvwpmkLqKkqvfeZAUw@mail.gmail.com>
 <bc74694b-9cbc-4cbb-9dcd-9e25960d3b97@amd.com>
In-Reply-To: <bc74694b-9cbc-4cbb-9dcd-9e25960d3b97@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 5 May 2026 07:44:03 -0700
X-Gm-Features: AVHnY4KKm8ChPu7Yq7OfV6LJFs9X7Wuvyr_qOd_TfzJJJ5G91zdYSk83n0ma0pE
Message-ID: <CABdmKX39gWcPy2PWxZ-bJBgXEQrk8Y7JWdFhkcS=LkOmU2v4zA@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: system_heap: Optimize sg_table-to-pages
 conversion in vmap
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Barry Song <baohua@kernel.org>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, Xueyuan Chen <Xueyuan.chen21@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>
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

On Mon, May 4, 2026 at 12:49=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/1/26 17:54, T.J. Mercier wrote:
> > On Thu, Apr 30, 2026 at 9:15=E2=80=AFPM Barry Song <baohua@kernel.org> =
wrote:
> >>
> >> On Wed, Apr 22, 2026 at 3:10=E2=80=AFPM Christian K=C3=B6nig
> >> <christian.koenig@amd.com> wrote:
> >>>
> >>> On 4/7/26 13:29, Barry Song wrote:
> >>>> On Tue, Apr 7, 2026 at 3:58=E2=80=AFPM Christian K=C3=B6nig <christi=
an.koenig@amd.com> wrote:
> >>>>>
> >>>>> On 4/6/26 23:49, Barry Song (Xiaomi) wrote:
> >>>>>> From: Xueyuan Chen <Xueyuan.chen21@gmail.com>
> >>>>>>
> >>>>>> Replace the heavy for_each_sgtable_page() iterator in system_heap_=
do_vmap()
> >>>>>> with a more efficient nested loop approach.
> >>>>>>
> >>>>>> Instead of iterating page by page, we now iterate through the scat=
terlist
> >>>>>> entries via for_each_sgtable_sg(). Because pages within a single s=
g entry
> >>>>>> are physically contiguous, we can populate the page array with a i=
n an
> >>>>>> inner loop using simple pointer math. This save a lot of time.
> >>>>>>
> >>>>>> The WARN_ON check is also pulled out of the loop to save branch
> >>>>>> instructions.
> >>>>>>
> >>>>>> Performance results mapping a 2GB buffer on Radxa O6:
> >>>>>> - Before: ~1440000 ns
> >>>>>> - After:  ~232000 ns
> >>>>>> (~84% reduction in iteration time, or ~6.2x faster)
> >>>>>
> >>>>> Well real question is why do you care about the vmap performance?
> >>>>>
> >>>>> That should basically only be used for fbdev emulation (except for =
VMGFX) and we absolutely don't care about performance there.
> >>>>
> >>>> I agree that in mainline, dma_buf_vmap is not used very often.
> >>>> Here=E2=80=99s what I was able to find:
> >>>>
> >>>>   1   1638  drivers/dma-buf/dma-buf.c <<dma_buf_vmap_unlocked>>
> >>>>              ret =3D dma_buf_vmap(dmabuf, map);
> >>>>    2    376  drivers/gpu/drm/drm_gem_shmem_helper.c
> >>>> <<drm_gem_shmem_vmap_locked>>
> >>>>              ret =3D dma_buf_vmap(obj->import_attach->dmabuf, map);
> >>>>    3     85  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> >>>> <<etnaviv_gem_prime_vmap_impl>>
> >>>>              ret =3D dma_buf_vmap(etnaviv_obj->base.import_attach->d=
mabuf, &map);
> >>>>    4    433  drivers/gpu/drm/vmwgfx/vmwgfx_blit.c <<map_external>>
> >>>>              ret =3D dma_buf_vmap(bo->tbo.base.dma_buf, map);
> >>>>    5     88  drivers/gpu/drm/vmwgfx/vmwgfx_gem.c <<vmw_gem_vmap>>
> >>>>              ret =3D dma_buf_vmap(obj->import_attach->dmabuf, map);
> >>>>
> >>>> However, in the Android ecosystem, system_heap and similar heaps
> >>>> are widely used across camera, NPU, and media drivers. Many of these
> >>>> drivers are not in mainline but do use vmap() in real code paths.
> >>>
> >>> Well out of tree drivers are not a justification to make an upstream =
changes.
> >>>
> >>> Apart from a handful of workarounds which need to CPU access as fallb=
ack DMA-buf vmap is only used to provide fb dev emulation.
> >>>
> >>> The vmap interface has already given us quite a headache in the first=
 place and there are a couple of unresolved problems regarding synchronizat=
ion and coherency.
> >>>
> >>> When a driver would be pushed upstream which makes so frequent use of=
 the dma_buf_vmap function that it matters for the performance I think ther=
e would be push back on that and the driver developer would require a very =
good explanation why that is necessary.
> >>>
> >>> So for now I have to reject that patch.
> >>
> >> Well, it doesn=E2=80=99t seem to increase complexity, and the code is =
quite easy
> >> to understand.
> >
> > I agree with this. This change introduces basically no downsides for
> > upstream, even if it primarily benefits a rare use case. Since
> > dma_buf_vmap is exported for driver use, why not enhance the
> > performance for all callers?
>
> Because we essentially want to restrict the vmap interface to only the fb=
 dev emulation use case and not promote or even expand it.
>
> When this matters performance wise the caller is clearly doing something =
wrong and by improving the performance we just paper over the issue instead=
 of fixing it.

Ack, I understand your position.

> Regards,
> Christian.
>
> >
> > -T.J.
> >
> >> It would be great if the community could be more welcoming
> >> to developers who are just getting involved, rather than discouraging =
them.
> >>
> >> Apparently, no one can control whether the source code of those kernel
> >> modules will be upstreamed except the vendors themselves, but products
> >> can still benefit from the common kernel.
> >>
> >> Best Regards
> >> Barry
>

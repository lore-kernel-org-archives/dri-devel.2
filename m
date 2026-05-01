Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B77DCD3423
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 15:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B59FC10E1E7;
	Fri,  1 May 2026 15:54:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="a+2mPvHk";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDB7B10E1E7
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 15:54:43 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4891ca4ce02so86715e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 08:54:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777650882; cv=none;
 d=google.com; s=arc-20240605;
 b=TLqVed6rb/2sasbrBuqi2iJrqFsitgcRuzOhq8HyEjcORqq8Dnd/XgJUjyHXIsujN/
 cjmWSHnvjCzB2tDl+rnsRMPVWwATNAjf0xAFS7EN8DE14zHmuPHIjZXlgPUvRLwTDK1e
 HeTyRbDeUvcraiDYy04HjT8l1Nb0sgfk2vzQuAQU6cktv0LZ4fVFpcUBrgw1+VlpKzaR
 h3uu54MGg4VqYuMKaG83FI8oN9dVn0AlZUt+gHJUzDBZYXChZUz9Bay74HiEYH84jgVn
 W9aSUByhE8uP4mS69b+N8d+s/Br+vYhVz1p9+9Rhlbvt6FokzO+Q/v2UdrkmMEhlIjnL
 wBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jwUF0jTP/NOVRMHfd02ulbOWRiSGddGMyJftTXYHjDU=;
 fh=3K30IC/zqB6gqe/p/xKkN8ehsN961/tjZnpN2WqjZGg=;
 b=Zc/vp7euB1hHUl+1L9E6TJzuIfV3OHKjbffVYZJEyvAx1gph/D2xLssNPQ83zZThTp
 lxNGsMF4pu7u1K5kh/y4/wwC2MRll1N0z4xe83Xt4G+9g9HYmC7w0i4mbaRtJtzNnoC+
 gtV1yCZwxmxbFWtMdScfpImtr/iVRU3f3XZnubOPxB34mjFivlOXP2lr/fGGLph2Y3XB
 uKF+k8hMxRIPlISDCn2ysuyBusOIafzFRQTumeQ5t+s+x/dNHdnsHwg2pjFBAuicYGeM
 QHpU+iQhqXfJmmxzmSsVx9LNrMnwnvRwtkJgkNjXntWj4C10CYQB0tjmH3PBynKEM1dA
 mSUg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777650882; x=1778255682;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jwUF0jTP/NOVRMHfd02ulbOWRiSGddGMyJftTXYHjDU=;
 b=a+2mPvHk99MpcFP5KOohvt5AvNPI9rbnwLPRcKBSvrE84am19klh26NZsSg5yyuTi4
 WzElDvhUzW5/EvvwzE8c2DmuMuj+U3xUUu34cgCyVOBSwUosu0Ort3g8JMjKIfHczQsk
 U6Ftse/De/zEpuuX+wErGUrSlBqWxLiKtnVDONLyf/q+1mHVqyeybOseUfi3eVuBFWgF
 EMBXn38WlOGQFARQGkn/9G3nKFnW7H/nqmWyEKxPZEUlLbGYj6F4ZEqiVA67/5EWZB9R
 TrICF4jmLAvPHq8XD1cw+OHrb1RPW1P19sqGzjXNGrm85FKZeo2MsYDi1MyAPFDOJr9K
 IzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777650882; x=1778255682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jwUF0jTP/NOVRMHfd02ulbOWRiSGddGMyJftTXYHjDU=;
 b=abx3KhNapYjFadPrEusw6IKgVi8lhspJBtwAdAfTiLWJQwk1V7RdiESF71TAR/eVbi
 8A/hZ97Sa2sTqbJCmS2UMbyDDPbpVe8sANxOHze019oqNWUJqa2HWKkmO8qWd1u/CxaJ
 +gqXFauzc8XK0ealMsgLjHKEJ0ZhdnTldVrkpEaCibOllPogbEvGkDRCvgJXU0G2jPzX
 1wha59hzx8NHhoKndg/pVPlUXTz7kHDkTvIZSiRTMYP+1dlbBaJY66FA8AJ/dSrbU44Y
 8pn9eHNv/aX0F+H9nhuemn66hHwH7pebStBRQMUnVnznZTnIZF3ca/HuicZ1kfpSur6P
 PtHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9KzVCgYeMyDAVovqQ2qGcfGdwAs0C4v+1wgfEk66FDI7TJDQnxULISNKGTo0Ccodmgt9M8ZJ8laO0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwuGtgiEDVfKluDv6dDXiX3cKjPmKqSDlrgMw8/0L9qMR0Bbyk3
 B/yMM47RX37gbQ6Y8w4JFuOnWVtOmhO7BRNqNJY1gbygOEjbdBtglGKBGNKw2Fb004HAhSo92Xf
 rDHizkYvXE0YwqLZtNkdFg1ZiN1WAW/clxnv4Qx1b
X-Gm-Gg: AeBDievnvv3v4PY6DlW4zz2H1LWEJgEt7l8KmYDuY11sksKuG/xEajihFlzpo2IjZjE
 UlP7SZ0/UNxJMCnECGH2oEJed/v02zGY9qxnaKHiEK6pSjEu8f9o8sZDhUWp6Fy0kyati1ukXF4
 puNtI3sLAEvauuo/LurBl2gEKHqWmjYmsK8oKhw7mjH8xprrhyViDeCDAZ2TyG5uVBW1ubEXoAs
 VzOuzHGlybkEcnnEULdAAP6gM28Ey2VERs2QTUZrAQcQHOKpCBxt/fET6tnyoLFeHSVQWqFRnTR
 Y1OH4aiQ73Qa7O+qhinb7xWHGpgA9bX7to+aeWGYSy8uGXjM0GY1/JTHeZo=
X-Received: by 2002:a05:600c:588a:b0:48a:55dc:9c1e with SMTP id
 5b1f17b1804b1-48a8dbd8581mr1073235e9.10.1777650881744; Fri, 01 May 2026
 08:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260406214938.24142-1-baohua@kernel.org>
 <a6d1c89a-3c71-4e06-adcb-56595071dcc2@amd.com>
 <CAGsJ_4xquCzQLbvpkC8arAN=9KhrAkdPdxnB=v85GvvQu23Xyg@mail.gmail.com>
 <9034246e-3971-4fad-94b7-80f4ad0e29db@amd.com>
 <CAGsJ_4z5EZoNMBVnu6sCkThyi9VTCeCH29buVecuySuv_Ry8fw@mail.gmail.com>
In-Reply-To: <CAGsJ_4z5EZoNMBVnu6sCkThyi9VTCeCH29buVecuySuv_Ry8fw@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 1 May 2026 08:54:29 -0700
X-Gm-Features: AVHnY4K9IQcLD4rvVzmAGkjSkrXkB2IVyJxFSBLPqAnQQvgeGWt-GzWKe8Eu21c
Message-ID: <CABdmKX3baqmBkZxMB6PTG6Sj5S9qi+RwVvwpmkLqKkqvfeZAUw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: system_heap: Optimize sg_table-to-pages
 conversion in vmap
To: Barry Song <baohua@kernel.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Xueyuan Chen <Xueyuan.chen21@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>,
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

On Thu, Apr 30, 2026 at 9:15=E2=80=AFPM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Wed, Apr 22, 2026 at 3:10=E2=80=AFPM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > On 4/7/26 13:29, Barry Song wrote:
> > > On Tue, Apr 7, 2026 at 3:58=E2=80=AFPM Christian K=C3=B6nig <christia=
n.koenig@amd.com> wrote:
> > >>
> > >> On 4/6/26 23:49, Barry Song (Xiaomi) wrote:
> > >>> From: Xueyuan Chen <Xueyuan.chen21@gmail.com>
> > >>>
> > >>> Replace the heavy for_each_sgtable_page() iterator in system_heap_d=
o_vmap()
> > >>> with a more efficient nested loop approach.
> > >>>
> > >>> Instead of iterating page by page, we now iterate through the scatt=
erlist
> > >>> entries via for_each_sgtable_sg(). Because pages within a single sg=
 entry
> > >>> are physically contiguous, we can populate the page array with a in=
 an
> > >>> inner loop using simple pointer math. This save a lot of time.
> > >>>
> > >>> The WARN_ON check is also pulled out of the loop to save branch
> > >>> instructions.
> > >>>
> > >>> Performance results mapping a 2GB buffer on Radxa O6:
> > >>> - Before: ~1440000 ns
> > >>> - After:  ~232000 ns
> > >>> (~84% reduction in iteration time, or ~6.2x faster)
> > >>
> > >> Well real question is why do you care about the vmap performance?
> > >>
> > >> That should basically only be used for fbdev emulation (except for V=
MGFX) and we absolutely don't care about performance there.
> > >
> > > I agree that in mainline, dma_buf_vmap is not used very often.
> > > Here=E2=80=99s what I was able to find:
> > >
> > >   1   1638  drivers/dma-buf/dma-buf.c <<dma_buf_vmap_unlocked>>
> > >              ret =3D dma_buf_vmap(dmabuf, map);
> > >    2    376  drivers/gpu/drm/drm_gem_shmem_helper.c
> > > <<drm_gem_shmem_vmap_locked>>
> > >              ret =3D dma_buf_vmap(obj->import_attach->dmabuf, map);
> > >    3     85  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> > > <<etnaviv_gem_prime_vmap_impl>>
> > >              ret =3D dma_buf_vmap(etnaviv_obj->base.import_attach->dm=
abuf, &map);
> > >    4    433  drivers/gpu/drm/vmwgfx/vmwgfx_blit.c <<map_external>>
> > >              ret =3D dma_buf_vmap(bo->tbo.base.dma_buf, map);
> > >    5     88  drivers/gpu/drm/vmwgfx/vmwgfx_gem.c <<vmw_gem_vmap>>
> > >              ret =3D dma_buf_vmap(obj->import_attach->dmabuf, map);
> > >
> > > However, in the Android ecosystem, system_heap and similar heaps
> > > are widely used across camera, NPU, and media drivers. Many of these
> > > drivers are not in mainline but do use vmap() in real code paths.
> >
> > Well out of tree drivers are not a justification to make an upstream ch=
anges.
> >
> > Apart from a handful of workarounds which need to CPU access as fallbac=
k DMA-buf vmap is only used to provide fb dev emulation.
> >
> > The vmap interface has already given us quite a headache in the first p=
lace and there are a couple of unresolved problems regarding synchronizatio=
n and coherency.
> >
> > When a driver would be pushed upstream which makes so frequent use of t=
he dma_buf_vmap function that it matters for the performance I think there =
would be push back on that and the driver developer would require a very go=
od explanation why that is necessary.
> >
> > So for now I have to reject that patch.
>
> Well, it doesn=E2=80=99t seem to increase complexity, and the code is qui=
te easy
> to understand.

I agree with this. This change introduces basically no downsides for
upstream, even if it primarily benefits a rare use case. Since
dma_buf_vmap is exported for driver use, why not enhance the
performance for all callers?

-T.J.

> It would be great if the community could be more welcoming
> to developers who are just getting involved, rather than discouraging the=
m.
>
> Apparently, no one can control whether the source code of those kernel
> modules will be upstreamed except the vendors themselves, but products
> can still benefit from the common kernel.
>
> Best Regards
> Barry

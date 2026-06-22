Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CFACDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:26:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA61710E822;
	Mon, 22 Jun 2026 21:26:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="GKHBiOgO";
	dkim-atps=neutral
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52F7310E822
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 21:26:26 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5ad2abf31aeso824e87.1
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 14:26:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782163584; cv=none;
 d=google.com; s=arc-20260327;
 b=WDbblLmPl9Y9s/DSv8pRyHczJvIh0IJ1Hmej+ztZz3l3XWPP3uFauPL5QcDHdiXnHx
 YB04fPZb9hJ493NYmh27zpP8j4p9e7ROIubeEeva/uZhu3hi4zy3h48vK7O6DCuDGWcM
 uxcC4ogZ8YsxcOo4Oa+7FUOo2GJJJ5MkL5kr+dx4ZlS6905dLCRtghqtkJI1LQscVv4A
 k+CN7tlRpYmu3SSA8/HCivcTl/c7W+UQ3kB2PThCjZB6Rlk9NMRyKvIZQvfxGHZju06Q
 1eBIUblQp1GD+/V/eJhxdtd7WWiHN33waLyJAisHRiKZfKP+YWQMsJxUkv8VVPIAzj0g
 Pllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ssE3TLUG/7J9ufeN9q/DrGgYY9Z2q4mT+HtG/803YCc=;
 fh=AuV6EE7BeHcSpbqmX4rtyHHYZISiTVJVxYv5XHbXsJE=;
 b=SlVjtE0yUt1pQCUOd4dntEyIV23iRkGAEtAvvu25e366GIEsbj5D9nLxa2cuuqI6aQ
 lhf3wpPPSPE9+4JK3bIbSmNHcBoOdJU+qPd1tSWlJTX0TDONs3U1NLBco/SPEIB7CCip
 wC+UAcnmRQqvRcEmvyw1S5OykG8yEgYdPtbS7HK/rH2dcVw3/+QCPGQiqu03seplYDbv
 BisksJVVGmutyYFRjCepuNgSgyJDD54eEg0HDwvbYseP4Vr453df8gJYB3GcV/BTk/Eg
 mtInJgnyRAufy7NN80Gmi2OFRK2ffNKEz99DLUfyaTlTr/KlCEGjSuLPynSMFscBy66o
 1FOA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782163584; x=1782768384;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ssE3TLUG/7J9ufeN9q/DrGgYY9Z2q4mT+HtG/803YCc=;
 b=GKHBiOgOmfnmTwQngOA3KiZSez5iTMd9wcpqD11OnnO7rh1NSFCe700JYrDGL3SI+o
 uv8HvAM9KsLoAEfDYvj+Ez5EwH1Nln5snQQy7C/yZacYHfiFkquP/VUZgu37VPuMewC4
 wPOsEQRmV+UvgVpBj8oYEazvJ8yUx385+MlSPVk2l0H+R+JijmPISuQEJFNEMEdwbK5t
 NTIZATmcV5sFRbNM1N6h9yhwaDYPM7qz9T1ny7E8TpOQkwU1xNqp/eJ6kBcGMGjhdjx7
 AUCVmnuBt8mv/pMUwDXwqnI9jB3RbeZwFj5TIyHaMf4P0Tru7ETmo3pS2/vJUyyesJaj
 QRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782163584; x=1782768384;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ssE3TLUG/7J9ufeN9q/DrGgYY9Z2q4mT+HtG/803YCc=;
 b=jkH8bGLRNYklQXuoc7+4dsTuHD3tiIn7DQI8sw6OZtcz4aoSJo1EZkBp5EsQicJy/c
 VsrIWilUd3NWE+cQx5L8LwBUi8gwNbERKXf5MFhBreE/NuuDeZ2DLy5R4+lXxtEvhhE0
 uOietLGMU605vj+uXDmxxrY6masKkEqT7WSc3rdVYg1JqcGaFJIjSuAkm1s0VxyXvA2f
 f1bNV77kGnLqbJ+/Hau3rTQ2s3VvGVe1qGPiCWrXPGbeyBVr5kOPj9pqlYSPQv7dAyCm
 KWXoRyFIVYQ9lTv7NfmFMCX5oe2K9lCrY0uQoX6Sszces5/2Dtef6c9z4kWQpsWQcJGS
 jXug==
X-Forwarded-Encrypted: i=1;
 AFNElJ/5cJfWK1ll16Vzzhri4ZtU3cRGgOrPEzAMkLEhxn+7n/gT4MdkHKYIgMJs2PbXVN6LxPDg90gJx+c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6WNPFr9ZnEYAC8GDnVkO0C8bhkjYs4m2Ooc4bVI1Nb3syACfy
 TskQH9H1PGVT2uBJfuVFJdMFGqzIvOxvTzWJ4VYY4qsq0ijKjzcLmMVlRTWrlpnZqGh3Rp7xk1H
 NKeuy1J+Kd3SulRXwr/tGVc49xg0f7168S2+lddE=
X-Gm-Gg: AfdE7clStLp/ej1poLDa76Tj99VyvD/EzXnVbqWuC9dnUQrDMZZZEIqn1nIZ+TXQQ9U
 LVwZQ7g9OSydhWUvkSpr6QZf2zMB4pUHXDBZ0Jkh9DsypaRWcv5ph15nRFE6+9LzUunvqJZROp7
 UoCtMwzTH9H0aOaBT/CAZ5dA3JyiuhlkcNTNEy1oa1fibt1FQgSmmNEkP5+mymFmnbm07SUxMMa
 C9WjGjw5M6X/sVJ2NLNZKSELBoQZFxCmI+03Xy8ANy1ImvByqLSlpELLBj29tG7Lx74gkeghgfO
 pik=
X-Received: by 2002:a05:6512:2302:b0:5aa:883f:5da4 with SMTP id
 2adb3069b0e04-5ada9edb8famr21097e87.11.1782163583717; Mon, 22 Jun 2026
 14:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260621222130.1667453-1-xuehaohu@google.com>
 <20260622091344.794e0d74@pumpkin>
In-Reply-To: <20260622091344.794e0d74@pumpkin>
From: David Hu <xuehaohu@google.com>
Date: Mon, 22 Jun 2026 17:26:10 -0400
X-Gm-Features: AVVi8CfJIbyQ0LZKF2B9vVNXYGGvbzr3GZ2ukEdWP929fB_vPszHbNiUlAHw-3A
Message-ID: <CAPd9Lg9+d=Rw4230FdcMFd0VYfyhXhD=eju53iURR8c61iXsWw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: Split sgl by largest page-aligned chunk
To: David Laight <david.laight.linux@gmail.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, 
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, 
 Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
 praan@google.com, kpberry@google.com, sashiko-bot <sashiko-bot@kernel.org>, 
 stable@vger.kernel.org
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

On Mon, Jun 22, 2026 at 4:13=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>

Hi David,

Thank you for your review. You raised many good points regarding
optimizations here. I'll switch to using 2G as the max entry size
(`SZ_2G` from `linux/sizes.h`), and remove divisions and
multiplications. I'll also replace the `for()` loop with `while
(length)`, and drop `min_t()` in favor of `min()` by casting `SZ_2G`
to `size_t`. I'll send out a v2 with these changes shortly.

Thanks,
David

> > Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> > This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> > first entry, resulting in non-page-aligned DMA addresses for all
> > subsequent entries.
>
> How did you find this?
> It requires a single buffer over 4GB - seems highly unlikely.

It was observed during experiments with buffers over 8GB on an accelerator.

> >
> > While the underlying IOMMU mapping may be contiguous, hardware
> > DMA engines often require explicit address alignment (e.g., page,
> > cacheline, or storage sector boundaries). Passing unaligned
> > addresses and lengths can cause explicit failures in DMA descriptor
> > creation or silent data corruption if lower unaligned bits are
> > truncated.
> >
> > Fix this by splitting the scatterlist by the largest possible page
> > aligned chunk within `UINT_MAX` (`ALIGN_DOWN(UINT_MAX, PAGE_SIZE)`).
> > This ensures all scatterlist DMA addresses and lengths remain page
> > aligned and satisfy hardware constraints.
>
> It would almost certainly better to spilt into 2G chunks.
> That removes any need for any divisions.

I agree. 2G naturally aligns with most hardware boundaries, while also
allowing compiler optimizations with simple bit shifts.

>
> > Page-aligned entries allow the system to cleanly chunk payloads into
> > PCIe MaxPayloadSize (MPS) (e.g., 128 bytes, 256 bytes, 512 bytes).
> > As a result, this may help reduce TLP fragmentation in P2P transfers
> > and alleviate potential congestion within a logical PCIe switch
> > partition, especially when Relaxed Ordering is not possible due to
> > hardware constraints.
> >
> > Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/all/20260609165431.778061F00893@smtp.ke=
rnel.org/
> > Fixes: 3aa31a8bb11e ("dma-buf: provide phys_vec to scatter-gather mappi=
ng routine")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Hu <xuehaohu@google.com>
> > ---
> >  drivers/dma-buf/dma-buf-mapping.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-bu=
f-mapping.c
> > index 794acff2546a..f2bde38fdb1f 100644
> > --- a/drivers/dma-buf/dma-buf-mapping.c
> > +++ b/drivers/dma-buf/dma-buf-mapping.c
> > @@ -5,6 +5,9 @@
> >   */
> >  #include <linux/dma-buf-mapping.h>
> >  #include <linux/dma-resv.h>
> > +#include <linux/align.h>
> > +
> > +#define MAX_ENT_SZ ALIGN_DOWN(UINT_MAX, PAGE_SIZE)
>
> >
> >  static struct scatterlist *fill_sg_entry(struct scatterlist *sgl, size=
_t length,
> >                                        dma_addr_t addr)
> > @@ -12,9 +15,9 @@ static struct scatterlist *fill_sg_entry(struct scatt=
erlist *sgl, size_t length,
> >       unsigned int len, nents;
> >       int i;
> >
> > -     nents =3D DIV_ROUND_UP(length, UINT_MAX);
> > +     nents =3D DIV_ROUND_UP(length, MAX_ENT_SZ);
> >       for (i =3D 0; i < nents; i++) {
>
> Why not change that to 'while (length) {' to avoid the division above.

Sounds good, will do.

>
> > -             len =3D min_t(size_t, length, UINT_MAX);
> > +             len =3D min_t(size_t, length, MAX_ENT_SZ);
>
> I bet that doesn't need to be min_t()

Agreed.


>
> >               length -=3D len;
> >               /*
> >                * DMABUF abuses scatterlist to create a scatterlist
> > @@ -24,7 +27,7 @@ static struct scatterlist *fill_sg_entry(struct scatt=
erlist *sgl, size_t length,
> >                * does not require the CPU list for mapping or unmapping=
.
> >                */
> >               sg_set_page(sgl, NULL, 0, 0);
> > -             sg_dma_address(sgl) =3D addr + (dma_addr_t)i * UINT_MAX;
> > +             sg_dma_address(sgl) =3D addr + (dma_addr_t)i * MAX_ENT_SZ=
;
> >               sg_dma_len(sgl) =3D len;
>
> Replace the multiply with 'addr +=3D len'.

Will update this as well.

>
> -- David
>
> >               sgl =3D sg_next(sgl);
> >       }
> > @@ -41,14 +44,14 @@ static unsigned int calc_sg_nents(struct dma_iova_s=
tate *state,
> >
> >       if (!state || !dma_use_iova(state)) {
> >               for (i =3D 0; i < nr_ranges; i++)
> > -                     nents +=3D DIV_ROUND_UP(phys_vec[i].len, UINT_MAX=
);
> > +                     nents +=3D DIV_ROUND_UP(phys_vec[i].len, MAX_ENT_=
SZ);
> >       } else {
> >               /*
> >                * In IOVA case, there is only one SG entry which spans
> >                * for whole IOVA address space, but we need to make sure
> >                * that it fits sg->length, maybe we need more.
> >                */
> > -             nents =3D DIV_ROUND_UP(size, UINT_MAX);
> > +             nents =3D DIV_ROUND_UP(size, MAX_ENT_SZ);
> >       }
> >
> >       return nents;
>

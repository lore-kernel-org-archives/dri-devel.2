Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AF6C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 15:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1351510E279;
	Fri, 25 Sep 2026 15:30:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="GHaga3eU";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAA1510E22F
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 15:30:12 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49e65a8f70eso44145e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 08:30:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790350211; cv=none;
 d=google.com; s=arc-20260327;
 b=B/BBujGV9ff19Oe5sJnS9iNAOBNerW3mQIceGdf/FU3X+fSIBPWoWTrr3WVgM6C0fu
 TN0SBEGxPOSc3NhMrFhzMKaNpI464BV858bA3ExhNKrsv71uiANBw1P+kLXwQD2qhH5Z
 SbinMslaWUQO8Gia39kNgf6ybfpKiFwdTtzgIGq49L2pCGVa0E2B1YDVCxIRfYAUQnTY
 kEYwIQ0eciSND0A7wNQj1Litajmt4DG5/GQvmQPqh0IGmCiS3COYe7JCbYQXq7bXpnuf
 Xivi4BU1xOIQH3xqyiXQia7tON1SyGhnxbYZKZqZuhsLoUmiimdVwm2TS5WR3Gsq8R7d
 AEdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ROrsOcUgsvdnaotZ8dOgUC/WrOneg/H1WIYmp3Dbi2o=;
 fh=fZ0ZfkepB2Wapc2oqWm+hcgk/ani9hkyVEtm1f6cnwc=;
 b=MZq20zu/aEDDpX/58fJK3daCfyBPdtenxN1BhdaodZTjswtY4Mj+zu+axdRCWm+KlC
 VjW8XnOBLVi71aSNVXkmo283qQ60cv9dCtuWfBmfVO/ts+em+whpZFsww8+XhSIzwWCB
 +JZH21tq72TwjjuXj95zRgZvKHtfjoxTkuzpANCmPIF1UlC10kapcK7u88ZJJB/qPHt4
 pSNTLUUSbYhL/cOpis4wdA6OvYdvUSiHPKzQMgpp2xxZGU7V0F3xAe2lbnrGs/WfGPgz
 vyESq7AcsyxFxz+52bU1B8dY/xoOdGRXY2E+4oaRRnRVSuQ2FMBW7zTURr1+AE6A6Ii7
 lxzg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790350211; x=1790955011;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ROrsOcUgsvdnaotZ8dOgUC/WrOneg/H1WIYmp3Dbi2o=;
 b=GHaga3eU3O4L8isT5Ge6a71vhZxpvyq2d1bm6ii1U3HmhuBD0lSCG6sECeMj/XfhsM
 FQpCQnNYRjzs97stzJm9Gtt9fnRdsmD+lZ9dg14G2u2PifxzQ2f2tf7wl5VAGnnDMQmv
 aYKGMnRJXyeA1dKRKq2TA2M+G6kI1XmHl4Nlr2r8SoG3+Dt+XRZYgc7/+5EHoPwvvNtk
 utjsLuIKob3UbwhJ2UmdTL9oLmtqxARtFiC2h+GRfekVoYzQwc2j61bxxMrcnflG3fey
 hN7EO9c/j1pfVzVJWFU9exIvZ0FG6Zqf40ahiFbmRHNkJLCKc2hkUeazw263a511XDSs
 Fg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790350211; x=1790955011;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ROrsOcUgsvdnaotZ8dOgUC/WrOneg/H1WIYmp3Dbi2o=;
 b=e1vsrCJlZkc2gIBuTrf4VEUUcrNSo7cxpzCLvKDlEyiiRVqMXPS15N5TdsUGt2O5te
 u33CF5RLA7C6n6bPmvxw6knIsbepoU6feUkYtM+Z1sigB9vGOgxLgYmqepd59t0UA5AF
 SqMz2q+LRKidHMyqWsxqN5totCL3V2FBYVHdMstGoXdENx8TYsBAlUakoiiBe6kd0OZW
 rkJ6SxZ8tgifUnOUK0JGGpnfn7VJScd0ReKtpMeu1Lfy/fsgnKWph44d4RzkrhPulqWm
 EwABXYDZ8FCNi0lpsfrMKtoDEpNDu614+JuAKJwfQNTfwrLhEbo292pCjUfhQ3WhdOxS
 yKZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByLzWg7SRPrZuftYu5/NdcatS5P/pf7KlbuvRbXiWvqQvV4MAJb2PPQ1orZMLswGf7uj9YVgftnne8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++krEBcasc5PRyKtlFEb4qbZwPpBFDCwkmG/PEFI43ORrxEZsQna
 zpTk28MlLTeCl2kkpCs/E+J0VxCqg9d5QGa8QAdvECaZLm/HG9/cFsVAOkXKVYbmxuvdDl4VfMO
 PGuIo73KVo79FwlLlt43C0rtOsfoac/CO3ITEulrg
X-Gm-Gg: AYBFou0ApqUnqwt0FRqQliBEeBhmot1g4eHypmF1MnfcafGlhN1ZrE6Z8z1R8xDJ8Lu
 IkFsbOkHutEM54F72Z3pFlDoKoxiTntHC9beX5HM7bxNdu5tcl4THwuVSqD+0x1fYeDsuTD0dxp
 Tq7DV+1B5vBXDV3uneLIUCy7mhlU6b2wnIKySNTiRKnRqU+Nzk6N4e5XvtTnWGNtQ75+x3gx9g3
 bVQUr2rMg8sGb866Rc/aPCKQ3q8yvD/JdGBh9QyGHPPrG8vS6aPXpjv35FaVcJYnvNkAsG3QmF8
 H14AFaXbV2t6KbgNyeUdzLxo6ac0u+f9UVRz7r3BvPIGgyup7vIjgzL5RpyDbqEKZMF2rsbgXcs
 Ymtioh3b5RyhkWg==
X-Received: by 2002:a05:600c:3014:b0:49f:e12d:1a60 with SMTP id
 5b1f17b1804b1-49ff638a87fmr227415e9.4.1790350210427; Fri, 25 Sep 2026
 08:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250417201913.2393655-1-jyescas@google.com>
 <df0a5e79-f2a2-4f74-868b-8f6291accb04@oss.qualcomm.com>
In-Reply-To: <df0a5e79-f2a2-4f74-868b-8f6291accb04@oss.qualcomm.com>
From: Juan Yescas <jyescas@google.com>
Date: Fri, 25 Sep 2026 08:29:58 -0700
X-Gm-Features: AclHuK91aA7NHqV433GteBTggY1TVKYNnE0__wEQzOG6MTG22gothUdiDWS_u9I
Message-ID: <CAJDx_rhLvcWV2-qzwVNG1DHnh2G4i26FgusebATLDj9zGg166g@mail.gmail.com>
Subject: Re: [PATCH v3] dma-buf: system_heap: Set allocation orders for larger
 page sizes
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 baohua@kernel.org, dmitry.osipenko@collabora.com, jaewon31.kim@samsung.com, 
 surenb@google.com, kaleshsingh@google.com
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

On Tue, Sep 22, 2026 at 5:11=E2=80=AFAM Pankaj Patil
<pankaj.patil@oss.qualcomm.com> wrote:
>
> On 4/18/2025 1:49 AM, Juan Yescas wrote:
> > This change sets the allocation orders for the different page sizes
> > (4k, 16k, 64k) based on PAGE_SHIFT. Before this change, the orders
> > for large page sizes were calculated incorrectly, this caused system
> > heap to allocate from 2% to 4% more memory on 16KiB page size kernels.
> >
> > This change was tested on 4k/16k page size kernels.
> >
> > Signed-off-by: Juan Yescas <jyescas@google.com>
> > Acked-by: John Stultz <jstultz@google.com>
> > Reviewed-by: T.J. Mercier <tjmercier@google.com>
> > ---
> >
> > Changes in v2:
> >   - Add John's Acked-by tag.
> >   - Add TJ's Reviewed-by tag
> >   - Use dma-buf: system_heap: in the subject since this is specific to =
the
> >     system heap, as per TJ.
> >   - Remove extra space in if statement.
> >
> > Changes in v3:
> >   - Remove defines for the orders as per Christian.
> >   - Update the order array for 64k page sizes as per TJ
> >
> >  drivers/dma-buf/heaps/system_heap.c | 21 ++++++++++++++++++---
> >  1 file changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heap=
s/system_heap.c
> > index 26d5dc89ea16..8c10c0f2b473 100644
> > --- a/drivers/dma-buf/heaps/system_heap.c
> > +++ b/drivers/dma-buf/heaps/system_heap.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/module.h>
> >  #include <linux/scatterlist.h>
> > +#include <linux/sizes.h>
> >  #include <linux/slab.h>
> >  #include <linux/vmalloc.h>
> >
> > @@ -44,14 +45,28 @@ struct dma_heap_attachment {
> >  #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
> >                               | __GFP_NORETRY) & ~__GFP_RECLAIM) \
> >                               | __GFP_COMP)
> > -static gfp_t order_flags[] =3D {HIGH_ORDER_GFP, HIGH_ORDER_GFP, LOW_OR=
DER_GFP};
> >  /*
> >   * The selection of the orders used for allocation (1MB, 64K, 4K) is d=
esigned
> >   * to match with the sizes often found in IOMMUs. Using order 4 pages =
instead
> >   * of order 0 pages can significantly improve the performance of many =
IOMMUs
> >   * by reducing TLB pressure and time spent updating page tables.
> > + *
> > + * Note: When the order is 0, the minimum allocation is PAGE_SIZE. The=
 possible
> > + * page sizes for ARM devices could be 4K, 16K and 64K.
> > + */
> > +#if (PAGE_SIZE =3D=3D SZ_64K)
> > +static gfp_t order_flags[] =3D {HIGH_ORDER_GFP, LOW_ORDER_GFP};
> > +/* 1MiB allocs are calculated with (2 ^ (20 - PAGE_SHIFT)) * PAGE_SIZE=
 =3D 1MiB */
> > +static const unsigned int orders[] =3D {20 - PAGE_SHIFT, 0};
> > +#else
> > +static gfp_t order_flags[] =3D {HIGH_ORDER_GFP, HIGH_ORDER_GFP, LOW_OR=
DER_GFP};
> > +/*
> > + * 1MiB allocs are calculated with (2 ^ (20 - PAGE_SHIFT)) * PAGE_SIZE=
 =3D 1MiB
> > + * 64KiB allocs are calculated with (2 ^ (16 - PAGE_SHIFT)) * PAGE_SIZ=
E =3D 64KiB
> >   */
> > -static const unsigned int orders[] =3D {8, 4, 0};
> > +static const unsigned int orders[] =3D {20 - PAGE_SHIFT, 16 - PAGE_SHI=
FT, 0};
> > +#endif
> > +
> >  #define NUM_ORDERS ARRAY_SIZE(orders)
> >
> >  static struct sg_table *dup_sg_table(struct sg_table *table)
> > @@ -318,7 +333,7 @@ static struct page *alloc_largest_available(unsigne=
d long size,
> >       int i;
> >
> >       for (i =3D 0; i < NUM_ORDERS; i++) {
> > -             if (size <  (PAGE_SIZE << orders[i]))
> > +             if (size < (PAGE_SIZE << orders[i]))
> >                       continue;
> >               if (max_order < orders[i])
> >                       continue;
>
> Hello Juan,
> I've posted a respin of the patch by extending upon your work,
> Can you please review?
> Aplogies for adding signed-off by, will drop it in v2.
>
> Link -
> https://lore.kernel.org/all/20260921-dma_buf_improvement-v1-1-23d82e771de=
c@oss.qualcomm.com/
>

Hi Pankaj,

There is another change that fixes the problem and adds the 2MiB
order. It has already been
reviewed the Christian K=C3=B6nig:

https://lore.kernel.org/all/20260914212258.2657788-3-dave@stgolabs.net/

>

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C810EC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6EBD10E056;
	Tue, 15 Sep 2026 16:26:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="pwjesfKW";
	dkim-atps=neutral
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com
 [74.125.230.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B7D810E056
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 16:26:56 +0000 (UTC)
Received: by mail-qk2-f12.google.com with SMTP id
 d75a77b69052e-530411c7ee1so85711cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789489615; cv=none;
 d=google.com; s=arc-20260327;
 b=Pa0NN5awXSWYeEeBU9X2Dq4pP8NSvEf0GxVo6d29Rcmiri7317+92scf8A9v5B6i8Y
 dlbYNPYO4dftyqv9MtbthFc+wZbMJWFRP7vwZ0rUogmET3SwlKRYM7y4saJg4RQhEoRQ
 qsMSkK1L8fd9/IIdZMvx7vqFCv8P3v378FcG6SKDbfnX53iVEwKUNHh/nUB7Ucv5Gv2H
 TGNWUOanbSNUwqxMgAXbcnyFF/kIQ8Xk7A704WeVsokYTNx8Eb3mU5c7xgQlvlQDVGY+
 UlcWn8ZUknRBBIJoJX2BZ6eqM4cyYxv+NuWp/N7CfvY8IKriel0cPCww0X6NU8IpqtqK
 J+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yVsdbL4Nf3Bwu61qw5TPwMH34bzVbrtCOAxvi0a+fbY=;
 fh=q8Y3I2FkDOLXEXOj9Q7S7ZFv+VbP6C1oR3qjjnm2AwU=;
 b=kJlGfujezZ0ahWoZ2JrrbFIYjEEwOF8SMKwflh8S/XvkpEDE6SgbDNXZvShLeIiXma
 20FAs6yQGEuGnDI6KmpWWkMKS6iGTLPIa1iYXZS4uqZ8273hc6iQVAwRQiBpBSjcGtCR
 xqsonvulQZCtnScvuY8hXkSKjabmrCXkPHdvn3B9GoR/ZCFKUYzPavzRsmGf2kvcC+le
 uPQa5Bc0bfgoC59hUh48gSsK8mSxpeGCPAhtP7WR9u9/RfRJYIomeGbRS+8Xf0iWkrVs
 cccYT3n9cb05lSAJIW8Bvq7EqUEzvdJY0ffWXumOTAb3InCfxm+txIHw27MOY6To28QE
 RYRg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789489615; x=1790094415;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yVsdbL4Nf3Bwu61qw5TPwMH34bzVbrtCOAxvi0a+fbY=;
 b=pwjesfKW4THvcBmYWAqVq88UD7wfyOBs0If8/XX9s5ghk92FJ67MdHHtYXwb6leFe1
 l7z+PuDUin+f6kCeJ0dX34OOCwX9QcwX+yqqDIeffJmgG3G2PbE/uaPBzFOK8XTDouEv
 BiNs6Yhl782JZWcyaVDL9TAB5hpm1x/BTNBVWF+2gQuD9B2u+GWFH8RmZrq87L7ceGRq
 t83ztA1NlflprjzfWBx1/mrU3CJkJh5GtnJ1z1uYh5LipmuyWFXacWsHa282oHamltBo
 wCH6OQEeqNNsDyEjEGo6twLM2mR/I+5r9Ew5dCHbQw+xK8iKrE1kafkjcscNNqbeSDjx
 3X0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789489615; x=1790094415;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yVsdbL4Nf3Bwu61qw5TPwMH34bzVbrtCOAxvi0a+fbY=;
 b=1liMEshw4R2rrAHsECOrHiuu+E2SVLsDTAPx2R8y3wdcp8KWt2P63/Vxmm3bf4JgBw
 RunnaTLE0VcUP2uZrcI9qPf8HwA6P6JDGjEXkIoL8FriP5cUP36H3ZWHyfks7XLR65UO
 l4bjLHn1nFZnnx9UoIXpDZfOcZGgvnB41BLs+IkccjiuRdm6zQigkede4gtl//lz0c+c
 NGJ1lfxKQ6yUp2OWcBCDPlQFphV+5tZ60B73RNDZsI5pIYWrfuRzs8OlzFPpLrHjWFNN
 M9ekUNVWpVX11rTN2CY10reFWFVEuAxQfKk5kXeKRIhe1QlnTO9vT3zubpFvOIexzuD5
 4Sbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTkg7W+ap5fbbbuvjPtgPIqSt5HbpFfLHJxrr+0cmHyHb0Xak1aLNrlm4Kvg1haI1ULZMfp3jwQns=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lfWmZXsrAiCV9RNXI4GEyZ+u9v0L3wJdIvm/CVqekvucVhk0r0
 x4cWk5M262IGnW6S8HZVJa82uTBcR7GkISnT0doKxYpro+dkeMExG4c4R5+Q5gLIa33DJHyTqIf
 rfBAcQ8qAkTM3NM/O81lR0lAfVMdwl3lDg9g9pucSiPrWluTrQoFNaxb2o0g=
X-Gm-Gg: AYBFou22ktXTwGKOoc/c0nX80LVTQ6fCmREVfvw11rSeqBzucT8uGWLbG9JrQ91xSJh
 zrPkIGyuNMM1VCDUYneBWS10JkARhVAXUYsr8wkZngk3ZlKoH3tAEiiKt4TdgoO55HF44eYQP+D
 EhKr0BJYMrEq+c2UNRkOrFK2kp9BamvOdTX7wA5wOLjPMoCfLiieoT/ZQtbyI3wh1hIqtJI10ri
 3ue7SK/qXOgYNX1aWom4yiUoRZKLVKbZ4WXX4b+T2PXBIu2aEAY1g/8PJGA73lS/8DZUi+RbSyi
 7iaSDHA6jS9JChIFL3BQtAU+BqJ4qZ9D7+pnU5FIyPHyN95W5F+sSt8h3hyTmQpvvvcw4iQmlfQ
 SN82g0kv/WEFK4M0DfjaFqm5xMpEtcmA2XXmXr40C9I2t57tGqRT7
X-Received: by 2002:ac8:7e92:0:b0:530:4381:e745 with SMTP id
 d75a77b69052e-5311c75235cmr16483171cf.10.1789489614432; Tue, 15 Sep 2026
 09:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260914212258.2657788-1-dave@stgolabs.net>
 <20260914212258.2657788-2-dave@stgolabs.net>
 <54ae0d83-d777-4357-8e87-dfc3a5c7b835@amd.com>
 <CABdmKX1ky3Jfr7B-Oqaz17aLJwo1SSh1huZ05NG7D44SMF=9fw@mail.gmail.com>
 <871b6fc6-e126-429f-881c-9cc517ee8dcc@amd.com>
In-Reply-To: <871b6fc6-e126-429f-881c-9cc517ee8dcc@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 15 Sep 2026 09:26:39 -0700
X-Gm-Features: AcwNN1Ublkw1G4b_G7djr5SdAcXDGM_6QerSz9j4ZUwkBsSgS1ICq54mARllNGQ
Message-ID: <CABdmKX1g=wcLHOFkRN6DLPTABrnn2uWmgCKpCtixhiV_b+9J1g@mail.gmail.com>
Subject: Re: [PATCH 1/3] dma-buf: system_heap: add a 2MB allocation order for
 IOMMU superpages
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, sumit.semwal@linaro.org,
 phasta@kernel.org, benjamin.gaignard@collabora.com, jstultz@google.com, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Tue, Sep 15, 2026 at 8:44=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 9/15/26 17:33, T.J. Mercier wrote:
> > On Tue, Sep 15, 2026 at 1:41=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 9/14/26 23:22, Davidlohr Bueso wrote:
> >>> With 4KB base pages, the system heap allocates buffers in 1MB, 64KB
> >>> and 4KB chunks. The conventional Intel VT-d second-stage and AMD-Vi v=
2
> >>> page-table formats, and Arm SMMU's 64-bit long-descriptor format with
> >>> a 4KB translation granule, define 4KB pages and 2MB/1GB large-page
> >>> mappings, but no 1MB leaf. A 1MB chunk therefore requires 256 4KB lea=
f
> >>> entries unless it can be combined with adjacent chunks into a
> >>> suitably aligned larger mapping.
> >>
> >> Yes, it was an intentional design choice to *NOT* optimize for AMD nor=
 Intels IOMMU here.
> >>
> >>> Adding a 2MB allocation order provides naturally aligned, physically
> >>> contiguous chunks matching the 2MB leaf size, without relying on this
> >>> being accidental for separate smaller allocations. The new cost
> >>> is one failed order-9 attempt (keeping current large allocation seman=
tics)
> >>> per buffer when 2MB pages are exhausted.
> >>
> >> We have plenty of experience with this with TTM and the overhead this =
results in is usually not acceptable.
> >
> > Overhead from compaction and reclaim to get 2M pages? That is disabled
> > for non-0 page orders here in HIGH_ORDER_GFP.
>
> Ah! Thanks for pointing that out, I misread the code that __GFP_RECLAIM i=
s ORed into the mask.
>
> But the question is still why? Without reclaim that is pretty much an use=
less feature on most x86 boxes.

Even on arm64 phones free 2M pages aren't likely to be available for
very long after boot, but lately we have been doing more proactive
reclaim triggered by userspace before launching workflows that desire
large dma-buf allocations (and also at other times during application
lifecycle in general). That somewhat increases the likelihood that
high order pages will be available. I agree there's no guarantee we'll
get any, but without __GFP_RECLAIM the attempt is pretty cheap and the
payoff can be pretty benficial which Davidlohr's allocation and
mapping measurements demonstrate.


> Regards,
> Christian.
>
> >
> >>> Two benchmarks, measured on an AMD EPYC 7313P.
> >>
> >> Why in the world are you testing the system heap on an AMD EPYC system=
?
> >>
> >> AMD clearly doesn't recommend using the system heap on those boxes for=
 ROCm, so I'm really wondering what combination of HW you have here?
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> (i) Mapping, into an idle NVMe function's translated DMA-FQ domain,
> >>> measuring map/unmap: with the v1 page table restricted to 4K/2M/1G
> >>> (amd_iommu=3Dv2_pgsizes_only), a 1GB buffer goes from 1024 1MB chunks=
,
> >>> only one of whose 2MB windows was superpage-mappable in that run, to
> >>> 512 2MB chunks with all 512 mappable. dma_buf_map_attachment() costs
> >>> decrease by ~16x on average with ~32x for the worst cases. Unmapping
> >>> that buffer drops from ~500 us to 1.25 us.
> >>>
> >>> (ii) A microbench that measures the cost of DMA_HEAP_IOCTL_ALLOC+clos=
e
> >>> across various thread counts decreases by factors of ~3-7x alleviatin=
g
> >>> allocator's zone->lock contention by being PMD order and therefore is
> >>> pcpu list eligible. Once the buffer size is large enough then the cos=
t
> >>> of the zeroing takes over.
> >>>
> >>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> >>> ---
> >>>  drivers/dma-buf/heaps/system_heap.c | 13 +++++++------
> >>>  1 file changed, 7 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/he=
aps/system_heap.c
> >>> index c8959eadc71d..621cf238ef97 100644
> >>> --- a/drivers/dma-buf/heaps/system_heap.c
> >>> +++ b/drivers/dma-buf/heaps/system_heap.c
> >>> @@ -55,14 +55,15 @@ struct dma_heap_attachment {
> >>>  #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN =
\
> >>>                                 | __GFP_NORETRY) & ~__GFP_RECLAIM) \
> >>>                                 | __GFP_COMP)
> >>> -static gfp_t order_flags[] =3D {HIGH_ORDER_GFP, HIGH_ORDER_GFP, LOW_=
ORDER_GFP};
> >>> +static gfp_t order_flags[] =3D {HIGH_ORDER_GFP, HIGH_ORDER_GFP,
> >>> +                             HIGH_ORDER_GFP, LOW_ORDER_GFP};
> >>>  /*
> >>> - * The selection of the orders used for allocation (1MB, 64K, 4K) is=
 designed
> >>> - * to match with the sizes often found in IOMMUs. Using order 4 page=
s instead
> >>> - * of order 0 pages can significantly improve the performance of man=
y IOMMUs
> >>> - * by reducing TLB pressure and time spent updating page tables.
> >>> + * The selection of the orders used for allocation (2MB, 1MB, 64K, 4=
K) is
> >>> + * designed to match with the sizes often found in IOMMUs. Using lar=
ger order
> >>> + * pages instead of order 0 pages can significantly improve the perf=
ormance of
> >>> + * many IOMMUs by reducing TLB pressure and time spent updating page=
 tables.
> >>>   */
> >>> -static const unsigned int orders[] =3D {8, 4, 0};
> >>> +static const unsigned int orders[] =3D {9, 8, 4, 0};
> >>>  #define NUM_ORDERS ARRAY_SIZE(orders)
> >>>
> >>>  static int system_heap_set_page_decrypted(struct page *page)
> >>> --
> >>> 2.39.5
> >>>
> >>
>

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7867C88E77
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:26:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B11910E136;
	Tue, 15 Sep 2026 17:26:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="i/oWXYyV";
	dkim-atps=neutral
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com
 [74.125.230.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED9310E47F
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 17:26:47 +0000 (UTC)
Received: by mail-qk2-f12.google.com with SMTP id
 d75a77b69052e-530411c7ee1so16661cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:26:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789493207; cv=none;
 d=google.com; s=arc-20260327;
 b=gZEROnhcJIBr8a93otVRhYUHNIE6Lgft4XiChwbr4npjPVkf2J4gWHatM9VqZuuwu4
 16mDIFZHTPwM0DQZgmyxu6yDGAcnbxKJO3VkWhraeAKyXUgYv2i0VFyxlO4xLH3mX9ud
 sK3Co35zbQUMj5Mmtib5sYRCgvlPa3T6rbIkfXvo7ckrQo7qljd4nTyXXKd52s/bv3c8
 frgpFZul/pdBMzCgfM+RH0pRQuNwBtr9pyijP73tOpY4cR5CnRDeHFsnYxMw/720lIVy
 7rSl65G/Ai0kWDjtEd1vaxXIn+oHwT1yHIDvDwX6mdfbqU6I0KKIDaX9+9H3ZxVfZPI6
 BzWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oLaqbeOPsXClMTG3juLppJfmRTdwa3EBaFJjE6KcofM=;
 fh=NRd5I4luGSFN8mOuU9puDz7D3n9wsB8QhiEws8toUOU=;
 b=n48ZKFj8OqmUV5Af5PLgg2bAhO8q6O8oCgT6nSTGpQljX6Kysn9F1nzpyr3UW7jFZw
 d1DRHFwAfm2zQw2/j8CVHrxO+LVon/TA1k9Yl9mafxrMsi3zUJDavnHcbdvsMx9y2M94
 jTZD3iH7GtrE01ThiHkAGvsT4h0OM8Uyl8dh3iTK+hz56wKr07IDUxB0OTgnnkPmOJ4l
 QjwGNQ7PTxwEijwXTZ+RwDRpXwpMOtY/I5zlMK5p/tNZLh16vfcUeLkiOwsiob5TrTvY
 wcvB5WJLlyqGigAOeA/BHubUPowtGwTng1Pg1Q8HAMU6aHQ1bkJE08QyMolpVPnLZ9G1
 Gvbw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789493207; x=1790098007;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oLaqbeOPsXClMTG3juLppJfmRTdwa3EBaFJjE6KcofM=;
 b=i/oWXYyVJ8RPDM+41cxwCcgIyLg3v+Xw63M9cWKblUgvoo2/qcYPk0lOsSgxoAoae+
 ZmvUYeW7y5Bkvo/7WIRvGR7iNApHAlaVBnRwKBsOPoFvClfeQP7BHDb9mR/eNZ7/Ksc1
 +JarNx7efiu3Whh4X0aaXKtVVvxsiL9Xzne9QWEsrO3e71gBOXE/acE5Lh3vJbdSaA14
 dmnQzJlzH6ee06hEa8oWIsHPZ9MUOQN5pjlpIckn8vGrdG9l9kdA0YzffcKTcRgnp3zl
 oZ57T1xSKVRdGxy+INzX5wAvs/LVph5MOISue7qyAjt6l/TlvKwrakUDHepGoaSlw21c
 lhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789493207; x=1790098007;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oLaqbeOPsXClMTG3juLppJfmRTdwa3EBaFJjE6KcofM=;
 b=lb/e+91qo7hbKUO4HFW9WLi3hKynhtAz1Mk0GHhRXewhbgASKaWlZupY2pVWd/awEf
 C6MMWLDvNWOHV6sDMVvRXAHzBcYobaCyUNq6EEnaULlGyks8IuOG6SC78T/eDTuJ62D2
 cAdY2QG5h0/glb1zZ0mZVuOh0REjc4qMLbc81iZhG+xkzBTTK/h+6nkv4z7Y0ZUoguSs
 LtfHq+LGTU7iPToI0KTXh0f794svhYoC/xyDa4udjM8bAKS7jOzF+glquY49GE/Al7Z4
 IOdySBvdtDpsttXLnXktBpGRrAckdK6f9QymLSGnDKUQ01iuK1iSDxWB/+5nD4r/1KGV
 5IKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVywnsIxi0MwsJFfVNTvb/7maQmY9z02eCGqqxpaQA9rCPeCSzInqkZtc+O0B9qsceLTUAbF6ieqw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nU6oB5ceVTcy8GjSPNcPy6+Il4PxPVv+7XtUWD4WSB/MRmDkme
 k5+yS/Nbg7rG1Se5maLcljWtdbAB2aQH3Nszf0F17BVDwAh79aRYezEW6LISaap2Cs+9iBlqSE+
 RNYLGHoMO+aZ9MP9j8EDSXOIr3g+Tmm0AvGg9mDhy
X-Gm-Gg: AYBFou3sxNiyOWqxJa0GCNFcoL1osZnKr1iPInFUaodhzjEEShIGga/0RcctTCQWW4N
 Vt+kAvGxD5YutTXfNIcDEZtveNtmX0j+c+kD1VSHonjOvxxFhde27fgfrMWvmhw7BZdQBRIF6Hp
 3uEh1RrMPxVuA0Qy6cK+uQ0oQ04vLDmhfVqEGnUk7Jz73O6VGLDyk/rYGY3WpdIOldse2RJeHL7
 a+KMTSpFvf08X5sJmL92QLqdBnxDlxg+TW/Rg7z5eCP6Ar9s6fOIbZkdGlHXcew0bPwPVwOJtIu
 88rlU48oCPQKMpmjQNCUAFBMZnEmDmx8iF/2LHeKYe0grSEQUo+vdhOUpRAPDFYGfyOtuFtSTwp
 0YvG0nDmy8MJGP10CU7W4R94UuxvMrXAf7XPr70mm2Q==
X-Received: by 2002:a05:622a:5c9:b0:530:4381:e745 with SMTP id
 d75a77b69052e-53250834fe9mr94401cf.10.1789493201557; Tue, 15 Sep 2026
 10:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260914212258.2657788-1-dave@stgolabs.net>
 <20260914212258.2657788-2-dave@stgolabs.net>
 <54ae0d83-d777-4357-8e87-dfc3a5c7b835@amd.com>
 <CABdmKX1ky3Jfr7B-Oqaz17aLJwo1SSh1huZ05NG7D44SMF=9fw@mail.gmail.com>
 <871b6fc6-e126-429f-881c-9cc517ee8dcc@amd.com>
 <CABdmKX1g=wcLHOFkRN6DLPTABrnn2uWmgCKpCtixhiV_b+9J1g@mail.gmail.com>
In-Reply-To: <CABdmKX1g=wcLHOFkRN6DLPTABrnn2uWmgCKpCtixhiV_b+9J1g@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 15 Sep 2026 10:26:27 -0700
X-Gm-Features: AcwNN1XgAXQrCiy3YZ1p64q4FHCH2J-I58ecoKjfCu7iBX3NTW0TOAZWTeHuVc4
Message-ID: <CABdmKX2GU0Eby=SEeALzeEp5ragEjU3Fw468Jv1yykD1Zdrgag@mail.gmail.com>
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

On Tue, Sep 15, 2026 at 9:26=E2=80=AFAM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Tue, Sep 15, 2026 at 8:44=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > On 9/15/26 17:33, T.J. Mercier wrote:
> > > On Tue, Sep 15, 2026 at 1:41=E2=80=AFAM Christian K=C3=B6nig
> > > <christian.koenig@amd.com> wrote:
> > >>
> > >> On 9/14/26 23:22, Davidlohr Bueso wrote:
> > >>> With 4KB base pages, the system heap allocates buffers in 1MB, 64KB
> > >>> and 4KB chunks. The conventional Intel VT-d second-stage and AMD-Vi=
 v2
> > >>> page-table formats, and Arm SMMU's 64-bit long-descriptor format wi=
th
> > >>> a 4KB translation granule, define 4KB pages and 2MB/1GB large-page
> > >>> mappings, but no 1MB leaf. A 1MB chunk therefore requires 256 4KB l=
eaf
> > >>> entries unless it can be combined with adjacent chunks into a
> > >>> suitably aligned larger mapping.
> > >>
> > >> Yes, it was an intentional design choice to *NOT* optimize for AMD n=
or Intels IOMMU here.
> > >>
> > >>> Adding a 2MB allocation order provides naturally aligned, physicall=
y
> > >>> contiguous chunks matching the 2MB leaf size, without relying on th=
is
> > >>> being accidental for separate smaller allocations. The new cost
> > >>> is one failed order-9 attempt (keeping current large allocation sem=
antics)
> > >>> per buffer when 2MB pages are exhausted.
> > >>
> > >> We have plenty of experience with this with TTM and the overhead thi=
s results in is usually not acceptable.
> > >
> > > Overhead from compaction and reclaim to get 2M pages? That is disable=
d
> > > for non-0 page orders here in HIGH_ORDER_GFP.
> >
> > Ah! Thanks for pointing that out, I misread the code that __GFP_RECLAIM=
 is ORed into the mask.
> >
> > But the question is still why? Without reclaim that is pretty much an u=
seless feature on most x86 boxes.
>
> Even on arm64 phones free 2M pages aren't likely to be available for
> very long after boot, but lately we have been doing more proactive
> reclaim triggered by userspace before launching workflows that desire
> large dma-buf allocations (and also at other times during application
> lifecycle in general). That somewhat increases the likelihood that
> high order pages will be available. I agree there's no guarantee we'll
> get any, but without __GFP_RECLAIM the attempt is pretty cheap and the
> payoff can be pretty benficial which Davidlohr's allocation and
> mapping measurements demonstrate.

Oh I forgot to add that this behavior is similar to how slab
allocations are done for slabs requiring more than an order 0 page per
slab. A large optimal order is attempted first with ~__GFP_RECLAIM,
but if that fails a fallback to a smaller min order is done. When the
optimal order allocation attempt fails, the cost is just taking the
zone lock for a quick peek at the free lists.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/=
slub.c?h=3Dv7.2#n3373

> > Regards,
> > Christian.
> >
> > >
> > >>> Two benchmarks, measured on an AMD EPYC 7313P.
> > >>
> > >> Why in the world are you testing the system heap on an AMD EPYC syst=
em?
> > >>
> > >> AMD clearly doesn't recommend using the system heap on those boxes f=
or ROCm, so I'm really wondering what combination of HW you have here?
> > >>
> > >> Regards,
> > >> Christian.
> > >>
> > >>>
> > >>> (i) Mapping, into an idle NVMe function's translated DMA-FQ domain,
> > >>> measuring map/unmap: with the v1 page table restricted to 4K/2M/1G
> > >>> (amd_iommu=3Dv2_pgsizes_only), a 1GB buffer goes from 1024 1MB chun=
ks,
> > >>> only one of whose 2MB windows was superpage-mappable in that run, t=
o
> > >>> 512 2MB chunks with all 512 mappable. dma_buf_map_attachment() cost=
s
> > >>> decrease by ~16x on average with ~32x for the worst cases. Unmappin=
g
> > >>> that buffer drops from ~500 us to 1.25 us.
> > >>>
> > >>> (ii) A microbench that measures the cost of DMA_HEAP_IOCTL_ALLOC+cl=
ose
> > >>> across various thread counts decreases by factors of ~3-7x alleviat=
ing
> > >>> allocator's zone->lock contention by being PMD order and therefore =
is
> > >>> pcpu list eligible. Once the buffer size is large enough then the c=
ost
> > >>> of the zeroing takes over.
> > >>>
> > >>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > >>> ---
> > >>>  drivers/dma-buf/heaps/system_heap.c | 13 +++++++------
> > >>>  1 file changed, 7 insertions(+), 6 deletions(-)
> > >>>
> > >>> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/=
heaps/system_heap.c
> > >>> index c8959eadc71d..621cf238ef97 100644
> > >>> --- a/drivers/dma-buf/heaps/system_heap.c
> > >>> +++ b/drivers/dma-buf/heaps/system_heap.c
> > >>> @@ -55,14 +55,15 @@ struct dma_heap_attachment {
> > >>>  #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWAR=
N \
> > >>>                                 | __GFP_NORETRY) & ~__GFP_RECLAIM) =
\
> > >>>                                 | __GFP_COMP)
> > >>> -static gfp_t order_flags[] =3D {HIGH_ORDER_GFP, HIGH_ORDER_GFP, LO=
W_ORDER_GFP};
> > >>> +static gfp_t order_flags[] =3D {HIGH_ORDER_GFP, HIGH_ORDER_GFP,
> > >>> +                             HIGH_ORDER_GFP, LOW_ORDER_GFP};
> > >>>  /*
> > >>> - * The selection of the orders used for allocation (1MB, 64K, 4K) =
is designed
> > >>> - * to match with the sizes often found in IOMMUs. Using order 4 pa=
ges instead
> > >>> - * of order 0 pages can significantly improve the performance of m=
any IOMMUs
> > >>> - * by reducing TLB pressure and time spent updating page tables.
> > >>> + * The selection of the orders used for allocation (2MB, 1MB, 64K,=
 4K) is
> > >>> + * designed to match with the sizes often found in IOMMUs. Using l=
arger order
> > >>> + * pages instead of order 0 pages can significantly improve the pe=
rformance of
> > >>> + * many IOMMUs by reducing TLB pressure and time spent updating pa=
ge tables.
> > >>>   */
> > >>> -static const unsigned int orders[] =3D {8, 4, 0};
> > >>> +static const unsigned int orders[] =3D {9, 8, 4, 0};
> > >>>  #define NUM_ORDERS ARRAY_SIZE(orders)
> > >>>
> > >>>  static int system_heap_set_page_decrypted(struct page *page)
> > >>> --
> > >>> 2.39.5
> > >>>
> > >>
> >

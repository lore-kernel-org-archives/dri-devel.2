Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DE7C982C7
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6142C10FA27;
	Tue, 15 Sep 2026 15:34:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Ghgh7MKb";
	dkim-atps=neutral
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com
 [74.125.230.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6917A10F7B8
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:34:11 +0000 (UTC)
Received: by mail-qk2-f12.google.com with SMTP id
 d75a77b69052e-530411c7ee1so60861cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 08:34:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789486450; cv=none;
 d=google.com; s=arc-20260327;
 b=g9dHZV6Z7kqN6nsAkYKvoYDXqKsguGPT4n8jTa9b959a4cUXhNClwQm3iUtHaSzIbi
 kndEFxFzRtub20A6yLBLJLrOThfbN8G4NMwb6uIt75fZpkL99RPhJHtoNiJxhZoupvn7
 GU/l78BfyVj0MFi8N5CAnElKVCAec1lH4tJFtCLeD4bOEghzfQJOtWs6OuEelUZUkpM1
 2IBeEtwgKywdBU8s2QZTphwdFVRqzbkCIhfWrdrHaN5ykImzjN5rl99Kg4UBuSxMLF56
 PR5+rnl3ff6UDN9N1BYspH6LP0zPVTdRVMGmw5jGYZmmaut35xu0pcb0/iqtRYTpGWeM
 axKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gt2obvr/vrzXbdJZb7+7fZvd97UZ/AmDVWmrtkgr1HY=;
 fh=pZyfvDPQg35FeU6++z2SCK/C9ir/OL98Tumq06thrS4=;
 b=TwkImB/ZyzLjFmm3XSyChdAEk/EYpTItwUQkuR10AuLPdUEsUr+xKFD/ynUAIpyNBd
 VlRvhMmsws91NMu6qu2RoX6bapwe7dT5LOPP/TVgrxHxKsOYWVGMu2rwvEIo3ivt/k6+
 Q4PxZWNFoWyKSlzOE5fblV+e6UQ4ePeuL2+AjIkrv+jnjUDd1zbBoFp6HlwmVI7Xy8vt
 vjgUhtQYuKnE3GWdUZ9ohKo7FbwMuvhF1aaH0qd0WKrlwE2JMs2GwHawCzuHWt1aIXZe
 3g9hqG+uTTRTHRtcn8dl3KaKh4drRuy7gXcG41Fz2jFS4dOGwnT7v3PQ6aSh2t47VW0I
 +42A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789486450; x=1790091250;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gt2obvr/vrzXbdJZb7+7fZvd97UZ/AmDVWmrtkgr1HY=;
 b=Ghgh7MKbC+0YFtiq6wlmBV+0POlpIiUqWBs4A+eX0oOz/z4aURZdf6onKqrhwXgSbw
 rvhvVhdQyHqeI4X4pxTt14sJos2lVVR5RTBwWV9xASwt9rpzXfhQp5Dl5RRRUj9wmP/j
 yIgja41i8hMzIc8YpE6/JzRsLkMO42zIvnV5qs4ND1WOj0ff7mvVn/tfgCDFS53bzuWg
 CG1u76Ad8Nc9BleF8c8Bsl6C7/qyMGQNEiE6S7OaOpJVabkysDjLRNhD1Azm4InK5Bno
 CF+7LhcGIKCE78kwj9qyMgvdqh5mTZ42VZq+P+xak4KxCODnihrrnRM7f2A91SlGAqSS
 sWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789486450; x=1790091250;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gt2obvr/vrzXbdJZb7+7fZvd97UZ/AmDVWmrtkgr1HY=;
 b=UxwFShaxwhWhEuvBDn3W9jX9LcJoua9XEub8AykPiDViCDoQLp5hcKp3X/TK0zNpjc
 OncpxnsdKQt7wLF+WMnnQwUYIGopZdca1oNUzH43tcxOg+KlgZjwn1vWDnKF94SyjJY6
 43Y/DabnnL/X2SQCgM/eBvMesSbPqdgsUqFUOrdvqWxvlSIl0mVcyWmtuPynZvsEBhec
 nUiIJkO20Vxtlz+Jpmy++Gg943Azaa2KYlW7ZdyV1u/0kH/H8iIDDoe73aCGH6lpyxld
 cUpRtsyGil2bjMfREWpWYjCdjd301RMR5bz4fFagmuuEOWbFXSPRmRs2G4iS9IusYsfI
 FeMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy16kHZ2dRt49tUeHWftgib0els/7TgdtB1F/7CLg6Z1GtzvydwtxMNVTmyeOOOmhJq/zMBawSWFkA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kNuI5g/Zx37fGpQ29ME8/09yIwY06gH+7VAnH+MG/o4c3cxP0i
 dlAVqi2BoO4s6TBlo3B/UmVcPyXSxPc3zV7ckbRVVi+XUR4mSqY5w0/ntLy+UrR6ZoNPt0/+jHM
 YoVVD6fjBfs8qWl8k4ZhS9/R1U3TMeckn/EmsgpIk
X-Gm-Gg: AYBFou2KCHIU9Rq5LTZC79cQGF/ZXRNjcjs8XEn7ZNAsbkRZXyiwqrIc6Eg5j4sT8/c
 7kxAT7b4OPifMG6M9K8Wmt7s8TfRcoBH/3QffN3v+nCMzVyMY1eiLoM9NSVYY59mHopIFX81LRP
 9eBsM6g8mCyAXIQVVCUQ9RB8egIMT6iWy1nJR+2DCvHAiCZml7A+6DGRgi3Qw1gj9Ujiv0lAwSC
 gdcX2U/wbeoTygo6BpVNNschueAWUmwLUxM6CFlsJxhCT4NlmXVdjHxmqrGb1rmpZ/InEMaq0Xk
 Amk+Kn9LApMDOJP62HzWNhycWYN2q0+zPEucvvjeCc6KYoieo4nZ2+x4YXdWCYF6ZFx4HqusVuW
 pSszfzSQnlhcm1aS2vmF1jORuVPE57mOArAGfgWXWFg==
X-Received: by 2002:a05:622a:5809:b0:530:3f93:9023 with SMTP id
 d75a77b69052e-5311a5c4ddbmr20364911cf.4.1789486444831; Tue, 15 Sep 2026
 08:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260914212258.2657788-1-dave@stgolabs.net>
 <20260914212258.2657788-2-dave@stgolabs.net>
 <54ae0d83-d777-4357-8e87-dfc3a5c7b835@amd.com>
In-Reply-To: <54ae0d83-d777-4357-8e87-dfc3a5c7b835@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 15 Sep 2026 08:33:50 -0700
X-Gm-Features: AcwNN1UtZ4NVKEtG0gDNaQN9gNuUkQxhk8G8OfUhBdsUri_jipzZr0yInGwVu2Y
Message-ID: <CABdmKX1ky3Jfr7B-Oqaz17aLJwo1SSh1huZ05NG7D44SMF=9fw@mail.gmail.com>
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

On Tue, Sep 15, 2026 at 1:41=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 9/14/26 23:22, Davidlohr Bueso wrote:
> > With 4KB base pages, the system heap allocates buffers in 1MB, 64KB
> > and 4KB chunks. The conventional Intel VT-d second-stage and AMD-Vi v2
> > page-table formats, and Arm SMMU's 64-bit long-descriptor format with
> > a 4KB translation granule, define 4KB pages and 2MB/1GB large-page
> > mappings, but no 1MB leaf. A 1MB chunk therefore requires 256 4KB leaf
> > entries unless it can be combined with adjacent chunks into a
> > suitably aligned larger mapping.
>
> Yes, it was an intentional design choice to *NOT* optimize for AMD nor In=
tels IOMMU here.
>
> > Adding a 2MB allocation order provides naturally aligned, physically
> > contiguous chunks matching the 2MB leaf size, without relying on this
> > being accidental for separate smaller allocations. The new cost
> > is one failed order-9 attempt (keeping current large allocation semanti=
cs)
> > per buffer when 2MB pages are exhausted.
>
> We have plenty of experience with this with TTM and the overhead this res=
ults in is usually not acceptable.

Overhead from compaction and reclaim to get 2M pages? That is disabled
for non-0 page orders here in HIGH_ORDER_GFP.

> > Two benchmarks, measured on an AMD EPYC 7313P.
>
> Why in the world are you testing the system heap on an AMD EPYC system?
>
> AMD clearly doesn't recommend using the system heap on those boxes for RO=
Cm, so I'm really wondering what combination of HW you have here?
>
> Regards,
> Christian.
>
> >
> > (i) Mapping, into an idle NVMe function's translated DMA-FQ domain,
> > measuring map/unmap: with the v1 page table restricted to 4K/2M/1G
> > (amd_iommu=3Dv2_pgsizes_only), a 1GB buffer goes from 1024 1MB chunks,
> > only one of whose 2MB windows was superpage-mappable in that run, to
> > 512 2MB chunks with all 512 mappable. dma_buf_map_attachment() costs
> > decrease by ~16x on average with ~32x for the worst cases. Unmapping
> > that buffer drops from ~500 us to 1.25 us.
> >
> > (ii) A microbench that measures the cost of DMA_HEAP_IOCTL_ALLOC+close
> > across various thread counts decreases by factors of ~3-7x alleviating
> > allocator's zone->lock contention by being PMD order and therefore is
> > pcpu list eligible. Once the buffer size is large enough then the cost
> > of the zeroing takes over.
> >
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > ---
> >  drivers/dma-buf/heaps/system_heap.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heap=
s/system_heap.c
> > index c8959eadc71d..621cf238ef97 100644
> > --- a/drivers/dma-buf/heaps/system_heap.c
> > +++ b/drivers/dma-buf/heaps/system_heap.c
> > @@ -55,14 +55,15 @@ struct dma_heap_attachment {
> >  #define HIGH_ORDER_GFP  (((GFP_HIGHUSER | __GFP_ZERO | __GFP_NOWARN \
> >                                 | __GFP_NORETRY) & ~__GFP_RECLAIM) \
> >                                 | __GFP_COMP)
> > -static gfp_t order_flags[] =3D {HIGH_ORDER_GFP, HIGH_ORDER_GFP, LOW_OR=
DER_GFP};
> > +static gfp_t order_flags[] =3D {HIGH_ORDER_GFP, HIGH_ORDER_GFP,
> > +                             HIGH_ORDER_GFP, LOW_ORDER_GFP};
> >  /*
> > - * The selection of the orders used for allocation (1MB, 64K, 4K) is d=
esigned
> > - * to match with the sizes often found in IOMMUs. Using order 4 pages =
instead
> > - * of order 0 pages can significantly improve the performance of many =
IOMMUs
> > - * by reducing TLB pressure and time spent updating page tables.
> > + * The selection of the orders used for allocation (2MB, 1MB, 64K, 4K)=
 is
> > + * designed to match with the sizes often found in IOMMUs. Using large=
r order
> > + * pages instead of order 0 pages can significantly improve the perfor=
mance of
> > + * many IOMMUs by reducing TLB pressure and time spent updating page t=
ables.
> >   */
> > -static const unsigned int orders[] =3D {8, 4, 0};
> > +static const unsigned int orders[] =3D {9, 8, 4, 0};
> >  #define NUM_ORDERS ARRAY_SIZE(orders)
> >
> >  static int system_heap_set_page_decrypted(struct page *page)
> > --
> > 2.39.5
> >
>

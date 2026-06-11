Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F351CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 23:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BD4710F1B7;
	Thu, 11 Jun 2026 23:08:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="S/OjtqUr";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C678110F1B7
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 23:08:00 +0000 (UTC)
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BDcwiC3039240
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:08:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=eSd4DfDWKCJhrlk+WFf1HJuCXJjV3yJV405FpCwAOa8=; b=S/OjtqUrfaHy
 U2tzFcZ8mycupW/bmzC0ry9dC6/TLZhsjYUOLx9kRDPB0KY54IyAWb3v/8NCzgIb
 Lo7j7/o2b10gCRzYHkStHM3+46rjVxu480Rw69rpMHhOshrelnhYeaEHIAZWHY2c
 45cn3iSQuWvr09tWHy11Rg98ilzmEcTlYqqh9Q7sHC11wTUiTKCHHmUjQuUuiz+2
 BUzCK5pTcOnMAmuXtXpOjrSB6KpO6VLwRJcO/kgZ1gLYJTGY+KSd+TwJCKLMpmK8
 S3GzefST7H4aOVX962Ewe73xPQFn9Ny/oy+d2hIXiJkNWwIp7UrGbCvYz36QF7sN
 eBQXf3TFYQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe78sn4s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:07:59 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7e6dd5840c1so669575a34.2
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:07:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781219279; cv=none;
 d=google.com; s=arc-20240605;
 b=azbwKXG2guE/TDywypZ59DKrCCljhOKmUmY7Kk9CN/zGvWFDrX7g/l8JnCrTduVrSW
 a81XNsMMXvYSv46jI0C+Dk5YD5x0EcX7E0wcajnbehD0IsAR+QfxMvrWJNVKn7EAO/BW
 KskNXJXUMxzYyhrYaVuOboeaK9nWhJ3xP55jeDiwdAk2YHTK4HosAR54VfxMQ8hSDTrP
 E3FWkTz0xu0hkTGC0K5Nb6fH8v124wjikGQmWYvknk2eVAtbFhPha6sVJ+Q7nccHs83x
 /WQhBsKvmIx1lGv9ZWQgZLCFSvr1vuidtgujpVBoaRtAUKQMCnjKnJ6fQe+E0Qqqd2Ok
 lWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=jKBgDS5EhOCeCGVgkUxAvmWq6B4D8KMNSa2GuVyeKb0=;
 fh=yGZFQ+7D9ujQyL1vtBvO67JyyHayqTHCg+60SRITA/g=;
 b=HTCyziH+L7jHMIRnCvIpY5Xbgq6b+upC6z28u9btacZJqh4MZPcnDM+FO/cHVBCl5R
 cVQjWA4faA08yLLwdyVcVHQOh5DKfkKZYS32BiJ8JQmBx1ijHF020kVn3te9J3azAjpG
 sLU1ZfB8hx01MH0vaKlI3Zo8wo5q4E/RKtogAOxqsWtI33AHPlECotROUXcArCHx70P6
 xVs6BYi0SNzJkSnTKZ3MolN7/6A4o4Kg1Os6gaRckqRGE3naQVCPTJnKFO7YsXqXUe97
 u8+hHSaIpd/QtLV84Nn/+1lMiVYAt3egV3vdP1W24xcdULLHT+8tLItIXGhh+cswVRgt
 yalw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781219279; x=1781824079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jKBgDS5EhOCeCGVgkUxAvmWq6B4D8KMNSa2GuVyeKb0=;
 b=Nw0c2YfHToxYcfi0gnOI4UJL1YWjqPSFsmtv5guKJ7bNrustVn2AbCcauAV3A0hRrU
 bmFoP5y84TBUMLtOv5Nd7MyJXcd7MP/k4WjeSA4zY5OzGJVn5AMEG0HlC87ps/MkWUAL
 FhMQJ36SX8zFwnA2lFRtj7kppTv7/e+gbteoXVyMsPpphWm/I9UNneeHZmjG68eLyHKJ
 am02J9p2KEtM19jLz9E9GwoIYn4v1JBV4xgXm7Omp9IqYDhssGSKGRGtLAjyHj+zctXi
 Lc9f07jQrTcupIJwd8HNvY6c2CNrwBnjf9Zy6S+z9DSpMh5qty4Zaj79EP28ToLc13/1
 qjyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WuVotC59/qN34qNc7q6xlGA5ZvnelBVjkDfQ0l38as/XSkqLwn/6rDgTPHbH1mBCRQeyOTy7Sih8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyExSvlAEZQ+3XCLtKH8Fs7QLAmc2xEKi6JLUJ/woQb13GxweaR
 wfg42P09fC+eGhgeYjvY/NTt5H1z/Bjw3bGI9IMUKHF/9TgBRr0zVHYtk4vwbLxwN+BbjFk+cZa
 OR4tHwQQrgBZDII2fcDuCnPQgjppeQ4slmiJzeFyzUpI+qKm7x89GzovPhQve7D2JTm8Tn/h8f3
 V6AWEKHWJ/cFwCXTZyGRPW6QafttS50iMYTjs3spXbkYM=
X-Gm-Gg: Acq92OGWMpJyZRzSNIPUmSErWP1utpdn7G31IB70arKU8CL4czsL83M/TdXrt3wsm21
 Vh4WhF95XAUKxLmuCTWmKmwk+L8x4IbbV2/20rOoxWx3kG1H8TWUQe24g/TvEQqGWsTmXaq7cqa
 e6CjXHF41uarhzBD3pq9yg/hoT0z/pM5nOpbu52qwAtI2YoEyiaaIwlWIFMbdd9v6MyIO5SslzY
 q8g7CVG0rl8eK49ctBO7w==
X-Received: by 2002:a05:6830:6810:b0:7db:b7ae:ef0b with SMTP id
 46e09a7af769-7e7848a9e26mr96703a34.24.1781219279114; 
 Thu, 11 Jun 2026 16:07:59 -0700 (PDT)
X-Received: by 2002:a05:6830:6810:b0:7db:b7ae:ef0b with SMTP id
 46e09a7af769-7e7848a9e26mr96676a34.24.1781219278679; Thu, 11 Jun 2026
 16:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260610193158.2614209-1-zhipingz@meta.com>
 <20260610193158.2614209-4-zhipingz@meta.com>
 <98b65e1f-1b5f-47fc-a4fb-0cdfab6725ed@amd.com>
In-Reply-To: <98b65e1f-1b5f-47fc-a4fb-0cdfab6725ed@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 16:07:47 -0700
X-Gm-Features: AVVi8CfN6ELCKVsJhBpTTQfWRh3GrCVI0SUXGM4wH5Fa1maXhiidrAdOyWsdUPU
Message-ID: <CAH3zFs1=CKtS524vU6f2inbX05JcyMi-5FouDxSCZAjNG0OUmQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] dma-buf: add optional get_tph() callback
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzMSBTYWx0ZWRfXxLmi/2VO4VTg
 0Nz+3LsF7y8xLKeQWjkIxle94wiPcJBxLwsAAzBbfpca3Pjc/7GXxRKU1x/uitrHghBZ9DnOlSw
 mvjfeSRr8FhcLEhIMDiIpReLycupLy5PgxDO7nmLaewHa7CyI/Ez/BZgFUj51uKQh9GWSMbOJFY
 XZs4dEsghnuLIRk9PR6k8BPpeQpusghADNWNBdfbT6Ju2GKZfRcnLIbteeb1cNuF6V2KQL4h4Gc
 ucAWWYEbhRKeoK/R82o31VfKH4RtBLMnVw6RDGtjTD4kE4QMOjmoiPzIc3ZBcA9KmWJKzwG2FiC
 lBfsUZ1aIOuTAzRVCaR0YHdlcEwEKLukAgaZPmHmk9pbdXBsIFvWyWpwgNZHRDfaeYgBVRM+X+L
 kgnj0tTScjZ0fxvissAVaJJHsMh8A75QiD9fFixK3Azcc+o1/qFDCc7c2rFuf8YMnJ9rc7BswOT
 cTWGOJJNd4vxUAOtpOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzMSBTYWx0ZWRfXxVG7m3FUFWUp
 P1SZi8eG9qrlXGxNkzOUCYczPsrLScVuZdJUVp8rPOtC0dVX6m/1HlcptH8mGwi6n9QkuD4oQVy
 hsj5J8WCpfJz+RLRYFt7GzHF9tU2LpA=
X-Proofpoint-ORIG-GUID: WRTRBkEI1bfFBeUMWkHY-AIoI-WuqJvN
X-Proofpoint-GUID: WRTRBkEI1bfFBeUMWkHY-AIoI-WuqJvN
X-Authority-Analysis: v=2.4 cv=ZaAt8MVA c=1 sm=1 tr=0 ts=6a2b3fcf cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=zd2uoN0lAAAA:8 a=VabnemYjAAAA:8 a=Zb6pUuT0p51Zl8jFNtYA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01
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

On Thu, Jun 11, 2026 at 3:35=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> >
> On 6/10/26 21:31, Zhiping Zhang wrote:
> > Add an optional dma_buf_ops.get_tph callback and a dma_buf_get_tph()
> > wrapper for importers.
> >
> > 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces, so
> > the importer requests the namespace it can emit and the exporter
> > returns the matching ST/PH tuple or -EOPNOTSUPP.
> >
> > dma_buf_get_tph() is the importer entry point. It returns -EOPNOTSUPP
> > when the exporter lacks the callback and requires dmabuf->resv to be
> > held while the callback runs.
> >
> > The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
> > mlx5 as the first importer.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/dma-buf/dma-buf.c | 25 +++++++++++++++++++++++++
> >  include/linux/dma-buf.h   | 21 +++++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index d504c636dc29..aff79ea12e43 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *at=
tach)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
> >
> > +/**
> > + * dma_buf_get_tph - Retrieve TPH metadata from an exporter
> > + * @dmabuf: DMA buffer to query
> > + * @extended: false for 8-bit ST, true for 16-bit Extended ST
> > + * @steering_tag: returns the raw steering tag for the requested names=
pace
> > + * @ph: returns the TPH processing hint
> > + *
> > + * Wrapper for the optional &dma_buf_ops.get_tph callback.
> > + *
> > + * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
> > + * exporter does not implement the callback or has no metadata for the
> > + * requested namespace.
> > + */
> > +int dma_buf_get_tph(struct dma_buf *dmabuf, bool extended,
> > +                 u16 *steering_tag, u8 *ph)
>
> That name needs improvement, maybe something like dma_buf_get_pci_tph().
>
> It also needs some brief explanation what TPH is, maybe a reference to th=
e PCIe spec name etc...
>
> And document in the list of functions that this one should be called with=
 the lock held.
>
> > +{
> > +     dma_resv_assert_held(dmabuf->resv);
> > +
> > +     if (!dmabuf->ops->get_tph)
> > +             return -EOPNOTSUPP;
> > +
> > +     return dmabuf->ops->get_tph(dmabuf, extended, steering_tag, ph);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(dma_buf_get_tph, "DMA_BUF");
> > +
> >  /**
> >   * dma_buf_map_attachment - Returns the scatterlist table of the attac=
hment;
> >   * mapped into _device_ address space. Is a wrapper for map_dma_buf() =
of the
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index d1203da56fc5..6a54e0f251a2 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -113,6 +113,25 @@ struct dma_buf_ops {
> >        */
> >       void (*unpin)(struct dma_buf_attachment *attach);
> >
> > +     /**
> > +      * @get_tph:
> > +      * @dmabuf: DMA buffer for which to retrieve TPH metadata
> > +      * @extended: false for 8-bit ST, true for 16-bit Extended ST
> > +      * @steering_tag: Returns the raw TPH steering tag for the reques=
ted
> > +      *                namespace
> > +      * @ph: Returns the TPH processing hint (2-bit value)
> > +      *
> > +      * Return TPH metadata for the namespace selected by @extended. R=
eturn
> > +      * 0 on success, or -EOPNOTSUPP if no metadata is available.
> > +      *
> > +      * This callback is optional. Importers must not call it directly;
> > +      * the dma_buf_get_tph() wrapper is the only entry point and hand=
les
> > +      * the NULL-callback case. The callback is invoked with
> > +      * &dma_buf.resv held.
>
> That most of that should be obvious, we only need that it's optional and =
that the lock should be held. Everything else can be dropped.
>
> And most of the description/documentation should be on the wrapper functi=
on, exporters who implement the callback should know what they are doing.
>
> Regards,
> Christian.
>

sure will do

Thanks,
Zhiping

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4F0CD98DE
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 06:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3026C10EC58;
	Thu, 18 Jun 2026 06:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="hEbHoDIc";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12E6210EC58
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 06:10:54 +0000 (UTC)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65I383Jd1650485
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 23:10:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=g5sz6xIN2DOx/R49RD/V8A7DarhSxstt7fwwKkQBLVw=; b=hEbHoDIcNNBH
 sZQV9mk7PiiboxdNzb2rNmI7KBN6NuhX/NwRqSVyxP5vjpQuiVqvYgDlAsy9Zdkh
 Tgcyc7uRW8eAc3fozG8JcWlf9hfVD+uBtdLV8+caTR1qKSIE+88Ezoo/MJ3rmGyC
 jcejquyAHng7TfyGE3Z4rqdgnkiroTqWLpuu8qmFQoHaV8tG9ZP9WEMDZVWQKBJm
 bFqMqdhR2XWBGl2F6B6sIHCBRl+9WgPa7bchX/8lF9rfzbPAYunO2eH7BQStVytC
 3EGL5UOGoab/Pt1Tfkhveb6OOhzXos1WVdxlfCazGkh3Yrd5JWZz6c9LG9zbg7pd
 DI7ZUVO+Iw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eueg8swjr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 23:10:53 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e6fd5f007eso1164462a34.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 23:10:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781763053; cv=none;
 d=google.com; s=arc-20240605;
 b=dVQsPw7gegUC9CqfdCnTM4x1NddsmAmWsp9rFaUgK91xL+0n1kJr/xmXeFH97aBnLN
 1ztuyln2nS0vh9v18V7Cj/zQbhLuHHNdtMu+/+4SIqMgjondZ66ObhvYdJthofl3xiGK
 fwwaM5aMWVEXI8hjRU5VloxV84qRLQXDI75fXePfSQLR8nxINfO3QmAOqnvI7yztNjHC
 wzVtgKvmukpqxnXlhyRyDkWmW4QS3W0x2nhVo4cyoy5tSo39Y4zdnAmeJL+8iuMwBjOj
 1AGteqV++zW7kUvEOtSCYjKToAwBIaWfLx3v2AhxMIr5YUYM+24joqMzQ1lhxNaxsu/t
 gXYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=9Eq8HAHlBMSmfq0hKVbVZbpTCPzs57KvCvKHerONY4Q=;
 fh=DmCc98Xcik8o6XbQnIJVUXpNNz78T7jAdRZbq/MTObc=;
 b=aAHSdmjYrBMeVhfY9bO1kJlEekCWkpujRStFBjRU8xoJz68yDAKkQjC4yRKZPfaO3b
 QaJXkS4TRmTYXWwzmo+EOvU/a+5BTsDVFJ+eD8PqYmObwN9gkv2mK2X49OOAMNpsvOJ1
 mo7oAGEAxTNfF52U+6Qi6LMCwMW1U2XnDp/rNU+40+DuqUaASkxIwPdbKLQCtbli0I2x
 zmLgVv0SJsetD6O6GPL70GLclsck/xIZB8lBzN9flttCSQLzSmJS/ikfhtc5MLL2hKuQ
 pfLPXCSyzPtymjoS0LQW73d5l3LaCFds6SI3CH22PVFQ9HXrmW1ur2ivFt2nyPaFkVDT
 Qoaw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781763053; x=1782367853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Eq8HAHlBMSmfq0hKVbVZbpTCPzs57KvCvKHerONY4Q=;
 b=Hxw9sjO/IaW2OhUf5fxdRHMdrHoGf2HMewq5T1fsFtnV3bvmshY+6yP6rrODuSZxS5
 +54Zgd3BTa1LrbLPHwtNEyENAqbjO9Fw5ictlfEfTRmi6nXt6qCGlfhsn1DcBsYGZqh6
 njmPYONkkWmWjPkBBWfDBnKD3uATMIYyg8nnpBHkoVMptzcGoh6QS5iBVzSMHB8hhv0R
 WpKCdfrs9Jf5lYP2WQLlkSXaUhkwLQyMm4w49iCnptJIUiO5Tl8DLRC6NXoDaZ3jRwn+
 OlK6YzRc6Oonqp556ayYvmgI8If6Sn4iY/StlZmxsbTdRH6cgIP8YVjB+axJpACCKxHo
 ++wQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ80ESmKhi5Z/CBsZR2Vy/1rtCLykRI6knK3bHr9lmXUnfk35KZ7bAmmR79wqhsXSZbmg3P0s5N+tz4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1iayLEv08dTJB7FrdKK1Iwq7x207lYpbPTDrCecoF5J5DkeRl
 QZHCtYo2DsVOU52umVLApJT5biAkzRTFRwWgLQTC2k/wg+fsrnUC39+KtvnvZeiB15nh45f8GLF
 x21KkIrxLMCBj/jiB02DzDDDpnamhj0Ae3C/1Cdwr5DelDd07UbtrNOZPQvBXeSMqlnpzMEDE0l
 dQpY9/W549HNRjKdkuVbh5Bq505XnjleAGq90GpWlBdiA=
X-Gm-Gg: Acq92OGyey3X2jPoGn1OmbZu0p/xNwD7KdE/IaFNTLpRaMKTg0kd+vQDSj4Jc9JS8t1
 oganSzv+B82azo5q6ZRNjxSUhJvAMKCKnhQ69xcHxH6TrfTVAunJxjtHbfqkq8KmYlrCM4nKzT5
 iByD4wcFDUiareeZ6LMkbDu9GaBsc7dzOsoAB2mhHkthyYqOW3cL8egMWdlGf2KB/ah3W6hjwTB
 bS+sc6naSOP7eUWzoH/+BY/W8BfTg==
X-Received: by 2002:a05:6830:4119:b0:7dc:d725:fdb with SMTP id
 46e09a7af769-7e91ac6d2b6mr2060573a34.8.1781763052714; 
 Wed, 17 Jun 2026 23:10:52 -0700 (PDT)
X-Received: by 2002:a05:6830:4119:b0:7dc:d725:fdb with SMTP id
 46e09a7af769-7e91ac6d2b6mr2060543a34.8.1781763051390; Wed, 17 Jun 2026
 23:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260615065912.2177918-1-zhipingz@meta.com>
 <20260615065912.2177918-3-zhipingz@meta.com>
 <20260617094113.GU327369@unreal>
In-Reply-To: <20260617094113.GU327369@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 17 Jun 2026 23:10:40 -0700
X-Gm-Features: AVVi8CdOrBaOwYRxFRdDVRsJhHRei-ObhsXGhIoQfKNO7YbBBbYe7t0f7TbFl64
Message-ID: <CAH3zFs3wBwbmvEMp498LTdbrSt4Y5w7PNpqtcN_L_vHdqsvnxw@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] dma-buf: add optional get_pci_tph() callback
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Michael Guralnik <michaelgur@nvidia.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: y2XtWLacgpviaqyGktpmoA_aMwqwNFhi
X-Proofpoint-ORIG-GUID: y2XtWLacgpviaqyGktpmoA_aMwqwNFhi
X-Authority-Analysis: v=2.4 cv=LaoMLDfi c=1 sm=1 tr=0 ts=6a338bed cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=IaYQQxp-055UKQrtbooA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA1NCBTYWx0ZWRfXwiZpuGLIfXLf
 bJVGtMJbUfTMt6MuXK+D0152U3w0N6ryf31ZSVHl7sCNvK7oLCKMv7MgnngObaRxkFqgenOJItg
 zbqq5DDbvmEURll4dbGvBnL8Ri1Ln3A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA1NCBTYWx0ZWRfX/ovGJq4P/5W4
 /Zxcc7G4brdUQ1kyZkchliGrouqofMGRgYEoEx0zbvEsCLlJ6e7bqij4qJX/q4K8DntNBTblnHv
 9kUqaDfxq1kBIF+KjYoAhp0auEYYzJruZbVYk2R6N4P3gLJ7B65e1hVXD+mHmsiFrDHgvZCu3G1
 skIkutnNgZdl8NI1vequwVItF+FVBZu+CH2VHaqW2hmMyGlXpvtbShBH8RVQ1Ct5EiCY5hq6zBv
 pvRy7I5b/BQ5WLKmVV7BcWHB0T2oQ7SkK0QO/OtdV38DrqL5wezU227qRH40ltNJ8knnsMavEWI
 3G+PFf14WbytWbawPSM8dss1b/Iiu2JzIx0mPsH12wJ7U4FoVvl7RIPLzhrJbdXP0SyvkACsCio
 3RB57ERtrfz2FDWYSb6ID7wumFgN83+Eo76jON4vI2fAWiXoxqYPigfdLoqIYX7W59Lff2robLh
 RG9WXe6p4ZDO2bhma1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
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

On Wed, Jun 17, 2026 at 2:41=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> >
> On Sun, Jun 14, 2026 at 11:58:59PM -0700, Zhiping Zhang wrote:
> > Add an optional dma_buf_ops.get_pci_tph callback and a
> > DMA-buf importer wrapper, dma_buf_get_pci_tph().
> >
> > TPH is PCIe TLP Processing Hint. 8-bit ST and 16-bit Extended ST are
> > distinct PCIe TPH namespaces, so the importer requests the namespace it
> > can emit and the exporter returns the matching ST/PH tuple or
> > -EOPNOTSUPP.
> >
> > dma_buf_get_pci_tph() is the importer entry point. It requires
> > &dmabuf->resv to be held while the callback runs and returns
> > -EOPNOTSUPP when the exporter does not provide PCI TPH metadata.
> >
> > The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
> > mlx5 as the first importer.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/dma-buf/dma-buf.c | 25 +++++++++++++++++++++++++
> >  include/linux/dma-buf.h   | 16 ++++++++++++++++
> >  2 files changed, 41 insertions(+)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index d504c636dc29..7a4c9b0d5dab 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *at=
tach)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
> >
> > +/**
> > + * dma_buf_get_pci_tph - Retrieve PCIe TLP Processing Hint (TPH) metad=
ata
> > + * @dmabuf: DMA buffer to query
> > + * @extended: false for 8-bit ST, true for 16-bit Extended ST
> > + * @steering_tag: returns the raw steering tag for the requested names=
pace
> > + * @ph: returns the TPH processing hint
> > + *
> > + * Wrapper for the optional &dma_buf_ops.get_pci_tph callback.
> > + *
> > + * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
> > + * exporter does not implement the callback or has no metadata for the
> > + * requested namespace.
> > + */
> > +int dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
> > +                     u16 *steering_tag, u8 *ph)
> > +{
> > +     dma_resv_assert_held(dmabuf->resv);
> > +
> > +     if (!dmabuf->ops->get_pci_tph)
> > +             return -EOPNOTSUPP;
> > +
> > +     return dmabuf->ops->get_pci_tph(dmabuf, extended, steering_tag, p=
h);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(dma_buf_get_pci_tph, "DMA_BUF");
> > +
> >  /**
> >   * dma_buf_map_attachment - Returns the scatterlist table of the attac=
hment;
> >   * mapped into _device_ address space. Is a wrapper for map_dma_buf() =
of the
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index d1203da56fc5..5e7b69a40f3d 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -113,6 +113,20 @@ struct dma_buf_ops {
> >        */
> >       void (*unpin)(struct dma_buf_attachment *attach);
> >
> > +     /**
> > +      * @get_pci_tph:
>
> There should be a blank line after the line above, along with a clear and
> concise description of what this callback does.
>
> Thanks
>
Sure, will change!

Thanks,
Zhiping

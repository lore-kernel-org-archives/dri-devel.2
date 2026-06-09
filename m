Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DD3CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8BD710E37D;
	Tue,  9 Jun 2026 14:39:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="bofmRsKL";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30D1B10E3B3
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 14:39:21 +0000 (UTC)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659DhZmc491607
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 07:39:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=s2048-2025-q2; bh=kNeH4tXtKNJiFBFWJPRK
 N1EPfU64g+YPkV/H/UdFhBs=; b=bofmRsKLK4osQcAFWiwXbtpr69w36y9aEPuV
 DGBeGSJClR6Iux5v8lxlgpMiVzO5x2Rc7XvV3WDDGERk1A0vudeYRpxUQTgVJ8FP
 Vp24tp6sGkRRtgnEWh5ISlm3X8w10Fv5cHFadx3zazkv3Puh6lk2WAALivP4RcaP
 osrasMZGfR98HjII9TAhAiRWO3neAxrV6MDSF+gSO8eKfKkKXqCwiEoRahlhPycg
 4+6EMm9OA50YdVt23PeVBTNs8CTpAfdAPGVGJTNzDE3Lz+aVd4fRXAzpSV2n29Ro
 DBqbIiI7haSoaEF0q5UsONLcNWq3+7vIqLg83UvH33HJ3kZ2gw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4epkyf0c91-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 07:39:20 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e74781faaaso2882176a34.2
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 07:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781015960; cv=none;
 d=google.com; s=arc-20240605;
 b=PbVdYIpc7eIXsg1JZSkqjCDmIp9nN3QqtNI7J0rwE9p9hK+vdV0njV2p71VkxPc9B+
 hgFi/IG2tEQJXs1haylRiyPP64xeZKuSwVKWecqFkzZDtcCkki/ZKB19Hv8/S3otsxW0
 MFkBOtcSwOmYI041SW5UfJcDfrw7vTRueNyCm3Dp3IReBxjZahne4I1SESFHlMiI4Wdu
 JqUrpyZ1CftxBIHGgUTdLvcfR00Nj/hFqN7ZWJYKWnGJ/feHmgY2KQl85jY7XTny4PH5
 Kzz1vq+aNSkPkipvoinpJKNf6EVnWpAOkdWLKpwK5A9s+XvSQjxj4tzTDfI5RkIdcAvW
 FAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version;
 bh=kNeH4tXtKNJiFBFWJPRKN1EPfU64g+YPkV/H/UdFhBs=;
 fh=fV40/MDdqXmXvGKMkR5wLXij6oBlam7Ap7QUgHYd1sc=;
 b=ZZolPgl5lAUoyE7Qeskgc3i+tfuyB2ma6j1PJkk+cLxyG55OkoOE96Io7i67cPKfuI
 CSG8jGqHM738JX6cMY3GAy1W9vU0NULRAbpfli4rI2+WScaeCr8tEOvSSVmsbTzodOXV
 KUqhsrveabZhX76dpD7AdCvIFRmmv5wSpQa98iNR65B3B3qzGmKO9UXkVUSI0H5PHRpB
 0QYtHUrp/xhWuPt3v3nUJCE5w9Ft8R91+7oFjEZcZfbrFlNxPHUDj0W/jIcL4fdkfWvD
 +R6xTbyBymURjkngnEh9sXeOcG9KHkMqetwiHmYSE0+xj2V4ItrDAiU8dlNIees0vNF8
 A6VA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781015960; x=1781620760;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kNeH4tXtKNJiFBFWJPRKN1EPfU64g+YPkV/H/UdFhBs=;
 b=pGol09qMxZan0li01l/iaVggFK9GAsxmHlYvoOQDqRLl9g9pDKqgJ+coI43mGYFCd3
 KqQFUbj6dGKx7r0lEUKI0npvI4jiMbvzjlA3WXbqIAMd2NylqYdb9B53KF5PgNZZ5YJ1
 4218wA7fGhNqDMs82YnzlYtVdnvUp1b9It2mvYQ1UIPSiQNeQWfwkIe/hi9ljzeZwIBD
 dFjNWmPS4ZwWtjJNx8+jgu9OpR8mq2OLxP/D4mGlIqsHeYq6roQ/ZPNUE0277Jpc/a6A
 M2/GL7WpsvW6OUGIJgsAjrEgkwx5ODhz2boyN4zfhZpH9Zp968YG+dPjK9nq0bR9r1p1
 6P/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ84WnBdmj3toyZk9e6C/0qcOftaZnf56oUrkSAaz82jITAuBisQWKmtLzyUANpcB369W6G0FdP2MJA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEobIN6bpnXsLdlZQrTMxE4kQfLF4ofXktm1ouRaRTP7v4OW13
 IufhuM4rNs2nGfQPWv73bIvYVmvhWC32EgioPld7UkrbABFmjIaMau7nb5XQ2YzCLbtMTnuoid2
 //bp7AYK8aoGjn7xuqOne4Ae/IL1PVGgZjpoSn4LzJuKsAWRL5LB/4Qj0fdbnSUQE7a8JCuN1Uc
 Z0q8lx4Ix8B/84aoeRzjQmYphYK7GeAkvc1ps4xmd/yTs=
X-Gm-Gg: Acq92OGfPfNK3wI1pXkwSh4ju6YMb6dM7rjG/x9rbGjuHs0/Nid8q5vXkVTphRQjf9c
 LU3qgp4aCcAzyfxoQ/H6685QC25w52BukbpPYRYoiMMyHBPIRIz1TollWZLnIXehdvd61dQ7svk
 /5zfCEmCbRp6e6LM/Lw6CPO1NeS7Mjzjj69Qluc6W3zsnpITq33NsHr5lo+DM0oYnHaDvmNWypd
 WJ/Zkgig2a4DCINlyfINXIsD5/pc7NqNOVs6EevkVJlhnqwezg=
X-Received: by 2002:a05:6830:67f8:b0:7e6:ed97:ce6e with SMTP id
 46e09a7af769-7e70ca3ef99mr13168168a34.19.1781015959822; 
 Tue, 09 Jun 2026 07:39:19 -0700 (PDT)
X-Received: by 2002:a05:6830:67f8:b0:7e6:ed97:ce6e with SMTP id
 46e09a7af769-7e70ca3ef99mr13168142a34.19.1781015959353; Tue, 09 Jun 2026
 07:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260608185646.4085127-1-zhipingz@meta.com>
 <20260608185646.4085127-5-zhipingz@meta.com>
 <fdf1bb37-7158-46a0-b6a2-6cca0ac7ae20@amd.com>
In-Reply-To: <fdf1bb37-7158-46a0-b6a2-6cca0ac7ae20@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 9 Jun 2026 07:39:08 -0700
X-Gm-Features: AVVi8CcZCg6NF1_DYHadZzneoVcOoxTF9hqIosFI2rLUJBAF8tno0qEb8k4EdV4
Message-ID: <CAH3zFs2FtVN9LZw487ei6cs3AMwh-30jRHenn3X87PAkZ8CmRA@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: Mp8BtAIQVx9ZBDAkG9kw3_Pi6gTQL2g0
X-Authority-Analysis: v=2.4 cv=bd9bluPB c=1 sm=1 tr=0 ts=6a282598 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=zMbl56DWmGmIhi6d5aIA:9 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-GUID: Mp8BtAIQVx9ZBDAkG9kw3_Pi6gTQL2g0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0MCBTYWx0ZWRfX58hap7ybPBkk
 hDmXmyjvCGbQuz/dNX48UeYxhs9tUeuwdY5MuEbiLNgM9z35YVpB3xnT6In7SlL/QYCMT+Frwq+
 AkVJvBBztvaTlWeBvFYkyF9B7+NlfYbmjfZPuK6nleSk08swh0b1f2f43Am/3/qpV+p82qlXPTS
 IbJm9OnkJqOiAJl/DxQY2D0XU6rjVnk73y8DSukutPsS/kKrBkPRLIHbcv+WUKF2RwXCyUTsc5v
 5uEdYPvlwvFMPHCA0Fpvdi3RPKUvqmUb8I5MR0snpPeDeqkoQry2XdQBYLAv+4F80BpKEv2zIeZ
 I/hyjym8C+IkolJ2EM+tOOt6sjKfGTQDnal3ObY9O7T2aJGiQKK1Hm3jXKiZ4kDl2HC5vYk4RJP
 dprORC3rVNb3qeopxTkIpGSjtiQEWQvEMTnOxERUOIsIfC538UMyS0moAG4RfgdwJpO6cKns0oh
 CtEs3wlfNsK1OTkwCoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
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

> >  drivers/vfio/pci/vfio_pci_core.c   |  3 +
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 92 +++++++++++++++++++++++++++++-
> >  drivers/vfio/pci/vfio_pci_priv.h   | 12 ++++
> >  include/uapi/linux/vfio.h          | 45 +++++++++++++++
> >  4 files changed, 151 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > index 050e7542952e..4fa36f2f7555 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1569,6 +1569,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
> >               return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
> >       case VFIO_DEVICE_FEATURE_DMA_BUF:
> >               return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
> > +     case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > +             return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > +                                                      argsz);
> >       default:
> >               return -ENOTTY;
> >       }
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > index 1a177ce7de54..dd11a7db6b41 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -2,7 +2,9 @@
> >  /* Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES.
> >   */
> >  #include <linux/dma-buf-mapping.h>
> > +#include <linux/mutex.h>
> >  #include <linux/pci-p2pdma.h>
> > +#include <linux/pci-tph.h>
> >  #include <linux/dma-resv.h>
> >
> >  #include "vfio_pci_priv.h"
> > @@ -19,7 +21,14 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > -     u8 revoked : 1;
>
> > +     /* @tph_lock serializes TPH SET vs get_tph on the TPH fields below. */
> > +     struct mutex tph_lock;
>
> Clear NO-GO.
>
> When that info is exposed through DMA-buf it must be protected by the DMA-buf resv lock.
>
> Christian.
>

Understood, will fix in next revision.

Thanks,
Zhiping

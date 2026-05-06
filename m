Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAECDCD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 18:13:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5A3610E237;
	Wed,  6 May 2026 18:13:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="WohxvzDB";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8BCE10E237
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 18:13:29 +0000 (UTC)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6467iMP31552118
 for <dri-devel@lists.freedesktop.org>; Wed, 6 May 2026 11:13:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=bsbBvRMYnEJLwO6vFciq2lgaf49YRFfLC0382/bbMDg=; b=WohxvzDB7qU8
 o2wqk7WXisIZ2+qX8jjaoaehtsTVUyToiY5UVloN7qizzETPowd5S4Zb8nsC9EMl
 ULfRCe+eyS5F3L7XFUvewUEdAC5eCpjIHy/fSU0RKXCPBgxqLmVKOK5uz4d1xyua
 Eke9sevlGUcg5bDSN2idKRVF5h0mP8Krj1GJ0bk7ZFEuvrRJTHCQyy6EslL8rHDc
 eY2QYB8+Y7raLFdBngjmOlFSqJJ7pt4TUuOaX0mcx7wJ+l1lJ5lGdJpHSXCX+lte
 R3HEpqoAP35QuGsNrP9kQzHI0fvkMtoI/VDJafYjIWur8zAzA/LlV1Ml+TglKNA0
 ju/vhonoEw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dwgjh1x65-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 11:13:29 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7de75c9be4aso84824a34.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 11:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778091208; cv=none;
 d=google.com; s=arc-20240605;
 b=PlOQ065+VCrSUcwIb+8dBBnEzLPINzutfn3byGRuuvbKAg/zKCrmVFneZf8hTtGOaI
 D72FDS7+9Ecg996EVsGC67IJtFTbmoGHDJzhUv/dJdBooTRIAFU8fn759D/aBhpCePZE
 NYkdafJKNYKxe/UZQeooCLVZ69Pl3S4K3mtJ6ByW7QWgVHMdubYJ4IXz/h6GMGgVqbdx
 plbrNlP4/KMqDo2gFk/RCOe4O1QIfQp6dWJ9y/T+yX3QNz+/jhNPQ89bfe9FxGd7BVQw
 8svcOo7YoHd0+rHH1OvU65R3aOFxdc7kGBFfj8BcoiYpDmUPZmxvVJzg3/xH8JTYUBbE
 Q2Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=3NDxADxfe9nDq1onSpJIot5yt/9B+/JmRFYIwD1lbrE=;
 fh=SHaeMTUPO1xtzae8sNULdjVevPbmzOyLSMoJGUtGi2U=;
 b=gTX5DZWXDotqO2JXG3B/sz+C5NQKBk4zd55GfAb9YpNmFMRXNeWk7t6O3T5uahOi/z
 a3Wz1dc7PM8ob3smGwd7cXsQXkwzJJhCZZele3rtSyd/cHco6MWMp/DeSKgg62wSQCtV
 OP2kD5w4GGZ7uugpohX5Gob4bGCHEP9N5eMr7ipjC2qUOMj9biIN1Sjc0kXlUuZg6js5
 w4wqR3HJOybIeExaiio43ZH7Uho4ZwRvKzL03ljowvvk2//Ma6DlgWlmROsp9UkFCalD
 FHc+76y7BWdJ+UJlPo3hsIu9uG1Vq6qXnWeE8k3yOqZJBakUd4txMo/3h0ou7iunt3EC
 x05A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778091208; x=1778696008;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3NDxADxfe9nDq1onSpJIot5yt/9B+/JmRFYIwD1lbrE=;
 b=VoSjXvKea3CMC184LuXQUpf+ySz+nhhRks3iGlzgH+fMhD9nVZSab5vkxGUgJBs0yJ
 0UIakrFK4dKGvc41WOVpUojxD8KvkpN/u+X7vAmujj5tJoIwrFl9ZUuC7eO0ACdD5myr
 Tyf4J3oJQ3cvnbVOonGrwnNxonq6ebyQndPs8usEaY/aoaZOCNZUUtDCJZfTNjgu8oDq
 AkBuv4aIdIeVHlNzCa9QzbWgq/qNzAceL/z5u3dTZDcBeTIsa/vJHcHCgkWNZmMGsCC7
 DAiywuTipCOc+Y9zoYxgYZUR7eECnawuJmTRlp21e0LG8Toe2XFGvInkfU9rJD+5C/JB
 6psg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/OU6FhgTlIJNBZ5e1tq31PPjTRrNyjjBjtYFwCHo/TuOSvBN6KaW4SgR3E7O/toysiC9/AdwWtp3o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFN/EE3IOWrdN6b6OyE8DFDdhREsTzbt0u0navg4E0E1OXy0I8
 AsPXIHvJoFHx0GufPZhk/4AOzATHoAhhs32XPh4Q+FIt+43y/+hLBA59647WhZBsz+nmzwi/DqZ
 tW0JLvOatM1tESR07Bd/j8MjCpuMq8g8nXMnn3Tm1jOVaHbxiPl6GN2hOop3c4hn/R+I74X8TCG
 OhfM/u32gJhtpw+9rRPfGEEKO4QO+9gNguDQ4z7lDGfJ8=
X-Gm-Gg: AeBDieuPTvC/xcDFrTv1pkcWqp2KwKbxKB3V6ggbuekFRiIgTVNtY7SPyYf911eEvJP
 cFoB5sPIxl8riNzJWD1XmanDo1RiY/tYoebgmAQ7MKlzWzwwCVDRuJbY/zO+DlVmmbzpGMYKuOp
 KjFXEg44ijdIOPHg3/rY4DwIhuOSYg06A8NvJ7xEVlurOkcH6DVa3WTad3af8LqMh+Frde4yEvJ
 DJV19ndhtv0jtHE5pIjAt6Fb9vyFgyX
X-Received: by 2002:a05:6830:6615:b0:7dc:da80:42c5 with SMTP id
 46e09a7af769-7e1df2863femr2542381a34.28.1778091208320; 
 Wed, 06 May 2026 11:13:28 -0700 (PDT)
X-Received: by 2002:a05:6830:6615:b0:7dc:da80:42c5 with SMTP id
 46e09a7af769-7e1df2863femr2542358a34.28.1778091207771; Wed, 06 May 2026
 11:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260430200704.352228-1-zhipingz@meta.com>
 <20260430200704.352228-3-zhipingz@meta.com>
 <a63179d7-28b1-4269-9ef2-c20368d0b91c@huawei.com>
In-Reply-To: <a63179d7-28b1-4269-9ef2-c20368d0b91c@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 6 May 2026 11:13:16 -0700
X-Gm-Features: AVHnY4IkP9FyuA_XByk4LxkXqiqZTgspyYe5GlY8B_-IOTQbxE0OcjjDWm1D7Xc
Message-ID: <CAH3zFs0zAf0=kxxMfyxuBF0Mw+0FTFANHDG5C9d7-vQ9dFO0Qg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: fengchengwen <fengchengwen@huawei.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=FpA1OWrq c=1 sm=1 tr=0 ts=69fb84c9 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=i0EeH86SAAAA:8 a=VabnemYjAAAA:8 a=kFoJLRxUVyBjw7Himy0A:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: ntDOODNHE00gEi_gPVTBrPdUiSZfbQgV
X-Proofpoint-ORIG-GUID: ntDOODNHE00gEi_gPVTBrPdUiSZfbQgV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE3OCBTYWx0ZWRfX83nTF9aH5CPU
 J13FQksQ7m2I2EKsbfH1TA9bUsdVUEHEzCYnaA1e1iSjZ9YPPzTrVHCD/egsIlFhis8IaV6sYPz
 TKHgItBHLJk0B97B+AdVQVfIifst2qdDQ+znuKkv70Xej0Q4rrxImIeoPbfN2rgDrcZohDMc6BO
 izcc68qLv3PTFD5rochQ0RRjmPMZFQK6bNF0j9012pR3tTV6tGbsOU6DUai/asWlBIlomwvrPLz
 xL/tdcHq+ijh3zqWlRssknvu7kPIhZJCWtIizyiBmQLMtWFmmYVCymsOIsP9BaDqXguwlXdh7PA
 aXDCvybqC6quG5mo++GexCvoI7qgaT6Ge8CkgnxO5qsj0D5wKEnTgGm0FDZ52jHGbuntGl5Irdd
 98y90ol0GOX+WI1DISeIM8rOg0yJJH05DIZIqax30QLCxnBSvA2Fk7ssb3eLHMPjBNCDCHcTrwo
 N/gykL6x2/cno9vCx5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
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

On Wed, May 6, 2026 at 12:04=E2=80=AFAM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> On 5/1/2026 4:06 AM, Zhiping Zhang wrote:
> > Query dma-buf TPH metadata when registering a dma-buf MR for peer to
> > peer access and translate the raw steering tag into an mlx5 steering tag
> > index. Factor mlx5_st_alloc_index() so callers that already have a raw
> > steering tag can allocate the corresponding mlx5 index directly. Keep t=
he
> > DMAH path as the first priority and only fall back to dma-buf metadata =
when
> > no DMAH is supplied.
> >
> > Pass the device's supported ST width (8 or 16 bit, derived from
> > pdev->tph_req_type) to get_tph() so the exporter can reject tags that
> > exceed the consumer's capability. Initialize ret in mlx5_st_create() so=
 the
> > cached steering-tag path returns success cleanly under clang builds.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> >
> > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/ml=
x5/mr.c
> > --- a/drivers/infiniband/hw/mlx5/mr.c
> > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > @@ -46,6 +46,8 @@
> >  #include "data_direct.h"
> >  #include "dmah.h"
> >
> > +MODULE_IMPORT_NS("DMA_BUF");
> > +
> >  static int mkey_max_umr_order(struct mlx5_ib_dev *dev)
> >  {
> >       if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
> > @@ -899,6 +901,40 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_at=
tach_ops =3D {
> >       .invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
> >  };
> >
> > +static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, int fd, u16 *st=
_index,
> > +                           u8 *ph)
> > +{
> > +     struct pci_dev *pdev =3D dev->mdev->pdev;
> > +     struct dma_buf *dmabuf;
> > +     u16 steering_tag;
> > +     u8 st_width;
> > +     int ret;
> > +
> > +     st_width =3D (pdev->tph_req_type =3D=3D PCI_TPH_REQ_EXT_TPH) ? 16=
 : 8;
>
> The tph_req_type is defined under CONFIG_PCIE_TPH, how about add a wrap f=
unction
> to query it.
>
Good catch!
so the direct dereference here will break the build when TPH is
disabled. I'll add a small
wrapper in include/linux/pci-tph.h alongside the existing helpers, e.g.:

  #ifdef CONFIG_PCIE_TPH
  u8 pcie_tph_get_st_width(struct pci_dev *pdev);
  #else
  static inline u8 pcie_tph_get_st_width(struct pci_dev *pdev) { return 0; }
  #endif

  with the implementation
in drivers/pci/pcie/tph.c returning 16 for PCI_TPH_REQ_EXT_TPH and 8 otherw=
ise.
Then get_tph_mr_dmabuf() becomes:

  st_width =3D pcie_tph_get_st_width(pdev);
  if (!st_width)
      goto end_dbuf_put;

which also gives us a clean early-out when TPH isn't supported on the
device. Will fix in v3.

Thanks,
Zhiping

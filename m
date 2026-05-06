Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E76CD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 18:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 557A310E25A;
	Wed,  6 May 2026 18:23:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="ecrKNO8M";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE18210E25A
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 18:23:32 +0000 (UTC)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6464u76m885586
 for <dri-devel@lists.freedesktop.org>; Wed, 6 May 2026 11:23:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=2YYLKXiToPfzzk84iAjnpM/kE1au7fYknVhGTQOnVXE=; b=ecrKNO8MJk5q
 oKIjdTP3cT9AdMHpRtYIW89FhY5abcRsfaMChsqaI29WSGcVqrxmCW6KF0syyjsU
 vXI+L5TDYQh9jgaGGd8jj0BHllL5waomMFt0M0n9CBCiB1dPI9YoWYdjX9Ms3CAr
 /SAHXyeletOuK9p8msNRfKXlukH2yHk5gRcTM18srPB6KJhdvGbk2B06ATSaEUy0
 GNA4BpGfx4il8hopju1ylXLm53Xe1Jd0huucKOv9aqixb3LuPoCYJS2o5kzLnMkP
 tS+7rw11iVZoYfP9udWgz/AiMp9YnhOy+Cp1r+syjSjMfpGJEU/w5r3R/fpUCjql
 KHoh0wEEWw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dwgjh20gn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 11:23:32 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7dcc5fa38faso59564a34.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 11:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778091811; cv=none;
 d=google.com; s=arc-20240605;
 b=T6Ph/sBTXNAiestHy4vrxDW+cGCjWIBW4IqAEsDUnfF0IaP6Z4HC9EFrRjQNqchBLo
 j5t0IQlU3IXy6JknBYaqaJ7pQ6xT8HSY1MgTMMI8Ghkk5sszbBJdkrIHyhq06u3ZG8ba
 U8QY0wM0PAmoj1aN+QPfFaFQeLbZaI8eYx97aidaJ+UsiObBQmlKbpEDDQg5iGt+RiUk
 Yt29C4DmENoGPMAxzw15uP88hf2lEXO7TUzn9obZQG58EpfDdRWgdmK4iW098xlVQEkX
 2f46l2g29fhUwkLjS03Xtibvu0Ad2fTXWUslsZrITQZXAS1gzj7TwCmHWKwlxipzqxUU
 r5dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=06MsYmJiQI0tIH7Lw/430OArMXdAJd2jDLxFSIS0mBU=;
 fh=tFlg6U9vLwF2jN9G/nmawCMzSaOmdo9SHvot9OAbvis=;
 b=Wq8acWiTdiZE7f1YrrJPcfJEEUkO06SwsHLk4orOyU/BFwRX5d0U4ngDf/ENeYMoPO
 zp5Txqb6Is2tPaDcpoPeBvVPUAVlruSwSewXzNU+hq+TJ1ctkLKdcTJ/a55Rs9yBN161
 emDXmlyTnH28fy6iMNpP0iRxMemJPJVPXrsyIZ1+tQvEW5oLVf1D1vhfVlrPPWdjiziC
 TRGf/BdspCEGHaEN+wTK8LtQIzAhqLUGRx4qseHBx0OvZQAV0nTorn5d56czSIzDdb/s
 QGdZdRjl2M0PdSgOQHhjFczYS7rCVWhlAv8Wk2sPlZqIKa64WhpJijUsIX47wXEjD8jg
 vz+w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778091811; x=1778696611;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=06MsYmJiQI0tIH7Lw/430OArMXdAJd2jDLxFSIS0mBU=;
 b=Uw8mMRgMRsa0O3OUTTWNCewuVb7BHifXtzvjhgaPu/CnY/37Acv5RYSXtaoMQdQO1F
 JrC5DbeDL3o9VGIWgsZwCzN6LAK+WXYW3eCAjZmzYRaIoz7gGuNDRVKCXcjLAT8Gga1n
 esACc5tLMGkQKlOV+EkGD1PLvZyvl95VG6keBIsvgShVZh14Xce5kxcqp/Smv1DZdltm
 qFHwRN6ceyt9lU6y7lkhg+GS4GcxASCLiueJOg8SQ33iElnfTzDRxtDimo9ICaz1dt6j
 w/SQUP9nOSP2V6djTNrz+8CgDTT2p2hBDygSey3zbulfgFA2S8Gl3FkOAkuwlKjzd+GI
 E2+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+OZZpjEef+rB6zr2SmKEvUy3yyM1YtnQfV543YSE5TfFGBysxRSncMkdi2H6kXalr0pKbhDyLVdbQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSSdtKd5+hKoB9azK3zaJNK7DQMIHbBDCMc9b4oNmkJBe/NhkJ
 T5sKuDCE+PqbzULa1/zu5+nOCWjdz8A7JYCMipTE6Ca/GMreBbgwQH4aw7hGxxT7Yyl+rg+Dws2
 lZn60o5kVaV5KT1oEukIYecL04kMiU8BRhv0WxWjh3ZLTxm/B6VXMGqAW6/L19P59UfWsaAGCIi
 WlKrNkfl32WfYoTBx8R8kNFUgNLvl/ePcxpmuHw0DSMZQ=
X-Gm-Gg: AeBDievOuPy+x/L0fPO2JwDdBlVetgOZh6rAl7enozPt5iD3g5eY/1qjoC4nic7ALop
 cK/64j0j5nHjNUfrVgx+4X7x5zuwt13ZArjeyGmARLf/psRCFQvhz6L9IVdgqZo7p5BWdfyxtMF
 m5PuZAWACIld6w+Qqd7bCLcsbyjlN2b3/UBTwq24zpJHhSm5yyYPM46OH6l1kLzbnmvlKSZGzv6
 07DaQ6gNNcQQ4uR5guj+QPxqzQ9A+tyHnIFwcGdnY4=
X-Received: by 2002:a05:6830:4986:b0:7dc:e032:9b5f with SMTP id
 46e09a7af769-7e1df220611mr2715778a34.25.1778091811266; 
 Wed, 06 May 2026 11:23:31 -0700 (PDT)
X-Received: by 2002:a05:6830:4986:b0:7dc:e032:9b5f with SMTP id
 46e09a7af769-7e1df220611mr2715758a34.25.1778091810773; Wed, 06 May 2026
 11:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260430200704.352228-1-zhipingz@meta.com>
 <20260430200704.352228-2-zhipingz@meta.com>
 <09995589-b81d-4cb7-a313-15a943d8b28d@huawei.com>
In-Reply-To: <09995589-b81d-4cb7-a313-15a943d8b28d@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 6 May 2026 11:23:19 -0700
X-Gm-Features: AVHnY4Lr6ainK1nflhUwWMi2SscR_b7hHjj8HpGh-ezHilmWJEso71FyiVM42gA
Message-ID: <CAH3zFs2x2QebpqDC0qwQg_GP2FVs-qqNxPupck40cEHNrBMEsA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vfio: add dma-buf get_tph callback and DMA_BUF_TPH
 feature
To: fengchengwen <fengchengwen@huawei.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=FpA1OWrq c=1 sm=1 tr=0 ts=69fb8724 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=i0EeH86SAAAA:8 a=VabnemYjAAAA:8 a=jjQCJkVV9gP_kkOIbcAA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: RYLbAWEO2zQ7Z0s9P8J-kn-DcR_gz9If
X-Proofpoint-ORIG-GUID: RYLbAWEO2zQ7Z0s9P8J-kn-DcR_gz9If
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE4MCBTYWx0ZWRfX0VDq0aVJxLVf
 BWYVlTjVmXNI+HMwsXH2xFi6MN0ItJ9LsJNwgLvMSmeOlRSUZaFiamX6GPIdIOVonUOrb+qX69i
 EAYIJ73MV8WY6zpi9gNlMHL1WWZHJJd2YkIdR4LdUZe4rStChbqUuaYiOm3VdQOtbZwCzrtkod9
 cvTi4Y0NlsGtJpdPxQHpu7Fp+AtMViU1ZfBeIItB0de4aQKNFgXHGdaYGCveTqzgTuIgo/nbz3n
 Y4/0HUN2kx01mcJ3KySQEhT0Gou6+KWBlLf50QkKJ83Yq0CvsXeab764O5L96BuWxVj4+WA4KPU
 3EFsGzcLkVOQcxtv/luqPj7zuUzpglhP3AUIKCsSFyPNxK09IRkH5nXZ6uhtB26ERDYp+B+sLoN
 6dAGnpjm6UYLKOyjf67TJGYHvsoURh7FeQZClhts7wfUkWTgXW2H78Td1nDS6UywIcQpGC6UHHI
 irH/rQvazsrZSsFAo9Q==
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

On Tue, May 5, 2026 at 11:58=E2=80=AFPM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> On 5/1/2026 4:06 AM, Zhiping Zhang wrote:
> > Add a dma-buf callback that returns raw TPH metadata from the exporter
> > so peer devices can reuse the steering tag and processing hint
> > associated with a VFIO-exported buffer.
> >
> > Add a new VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl that takes the fd from
> > VFIO_DEVICE_FEATURE_DMA_BUF along with a steering tag and processing
> > hint, validates the fd is a vfio-exported dma-buf belonging to this
> > device, and stores the TPH values under memory_lock. This keeps the
> > existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI completely unchanged.
> >
> > The user sequences setting TPH on the dma-buf before the importer
> > consumes it.
> >
> > Add an st_width parameter to get_tph() so the exporter can reject
> > steering tags that exceed the consumer's supported width (8 vs 16 bit).
> > When no TPH metadata was supplied, get_tph() returns -EOPNOTSUPP.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_p=
ci_core.c
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1534,6 +1534,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_devic=
e *device, u32 flags,
> >               return vfio_pci_core_feature_token(vdev, flags, arg, args=
z);
> >       case VFIO_DEVICE_FEATURE_DMA_BUF:
> >               return vfio_pci_core_feature_dma_buf(vdev, flags, arg, ar=
gsz);
> > +     case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > +             return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > +                                                      argsz);
> >       default:
> >               return -ENOTTY;
> >       }
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio=
_pci_dmabuf.c
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -19,6 +19,9 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > +     u16 steering_tag;
> > +     u8 ph;
> > +     u8 tph_present : 1;
> >       u8 revoked : 1;
> >  };
> >
> > @@ -69,6 +72,22 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *atta=
chment,
> >       return ret;
> >  }
> >
> > +static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steer=
ing_tag,
> > +                                 u8 *ph, u8 st_width)
> > +{
> > +     struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
> > +
> > +     if (!priv->tph_present)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (st_width < 16 && priv->steering_tag > ((1U << st_width) - 1))
> > +             return -EINVAL;
>
> The checker will failed in following cases:
> 1. If the exporter passed 8bit st, and importer support 16bit st, then it=
 will pass
>    the checker.
> 2. The exporter enabled 16bit st and its st is < 256 (note: the pcie prot=
ocol doesn't
>    restrict 16bit-st must >=3D256), and importer only support 8bit st, th=
en it will also
>    pass the checker
>
> Suggest userspace passing both st(8bit) and extend-st(16bit), and importe=
r chose the
> right one.
>

 Agreed =E2=80=94 8-bit ST and 16-bit Extended ST are distinct namespaces
(firmware returns
them as separate fields with separate validity bits), so a numeric
range check is insufficient.
For v3 I'll change the uAPI to carry both, gated by a flags field:

  #define VFIO_DMA_BUF_TPH_ST (1 << 0)  /* steering_tag valid */
  #define VFIO_DMA_BUF_TPH_ST_EXT (1 << 1)  /* steering_tag_ext valid
*/
  struct vfio_device_feature_dma_buf_tph {
      __s32 dmabuf_fd;
      __u32 flags;
      __u16 steering_tag;       /* 8-bit ST */
      __u16 steering_tag_ext;   /* 16-bit Extended ST */
      __u8  ph;
      __u8  reserved[3];
  };

get_tph() then picks the field matching the importer's st_width and
returns -EOPNOTSUPP
if that one isn't valid.

Thanks,
Zhiping

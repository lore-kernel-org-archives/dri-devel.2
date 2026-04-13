Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBA3F9D0ED
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E6E010E614;
	Tue, 14 Apr 2026 18:48:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="BhCoaxeI";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0829810E501
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 18:33:01 +0000 (UTC)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63D1gFrQ443657
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 11:33:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=zG1i4GOJI0Qqxhx6X/y+OYVi9v31A3eEgoxO9M8dGo8=; b=BhCoaxeIAUTn
 YJ7JhPz3Cx4IihaBsBpITr2/1JYDB8qkbM1UsOnx6Hz7lD9+VdcpE1EJyypDO/KG
 WCuinBHxBNAbk1fqrW0/uMUNq3AFMFBcyij842gJXDxEArbnbnSFlkWcDzkkpHJw
 93uzWR86iB/Yoqf4nv/24SWhVkPlWjvuAPhNCj2eGDalRmeGG5B83FBpS4No7Y7L
 joGCbmbGXSXrXvzc89j++TyvF2Kco6Mo2SyFjdP79qHqn/VKxxhWFXQ309Ujk0O2
 ZWUwUErBjTlmgcLhxUNhmB9eD3sRs8I5KPtN+ckqJ0rrQA5u0slfiHH3Lke5SO3z
 mic2S/rLnA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dg92h72tt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 11:33:00 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7dbe11b1f03so28973a34.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 11:33:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776105180; cv=none;
 d=google.com; s=arc-20240605;
 b=b+35Yod8A/pqqVVT4xIbeSimfhuMQMtxy0wGhGBqu1eyDtf0p/f4WmdC8iLv7QX0oX
 jpG7M+FoV5kX0scC5KMwRVPJxemi7wf68E+E9mYtM4tETD5RN5JykKKeplWiA6ZF12OK
 cEIGspTMMVfJD+HkiSxUyuHW07USgAE1Qq3+B0r3zTC27f4tcWnKIlVbdFOphlYFqnfe
 XpEsba4ZP9KAyaHPSeZ6IPzNH0yjcdUvckh6s+9i3K3svi4gGVXZGk5/efflXXA2Wa8p
 O89RktLgacW0UF9IqJzBv5XCfBCg0cqAB7Wf8B7XZNPYKVH1VBKkpyhFzVdOXFVR1k2W
 fYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=+JPsy6ZFn+T7uthNgDQuwBwhJArt54L0xqFFmpZV85I=;
 fh=TSq6k7dM0M6h9P5txoRc+vOWF4fPy914ZW7MAYstsmk=;
 b=EHsKqI3dVYVKIF0jBKYhIMmw0g9cP28G0nFJ7BqyG7Y0eSuFVEAYzRumqR0n1Ileja
 ozzvVpo1jMXUWs5TBjXif66KfjLSyT0wDCtlfEDLvtpWddLKOJpiocJBkanIuJx/KOas
 WBLW/j/ZZ7ejFn0GDWLBUjnGC+/DJZfingfVmKV9BX+f5MPb1bXaHyPo5nFYfjZ5N3nW
 PDA/fBkxFgkxjUslmu2Gsdm6eSeaHg7Qhe+BxGFsrw0XSUxTvAgDGLqUZ93Bq6fY4EaP
 mfkLiDwbFa7m6tlMenLx8IsE9Xa43uRDVLev/xaqJ2g7crr80kzx4p9b8I34dbfI5/DV
 fT/w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776105180; x=1776709980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+JPsy6ZFn+T7uthNgDQuwBwhJArt54L0xqFFmpZV85I=;
 b=UqYvL8Q8ZWfdFRgFrIC+XR4KkSJsB4bmQLMiOyfsgyutuplFRdNj8EzkZ+pP/l1Jws
 yiRmEVvG7a8bOkjuSbtSpd43A73FMsrd2elFfyaWNKAIBk4os0YjWTmxKB9gfI+uf7d3
 OmxxYXTPJBTQ+0kqfzYt3w+4EYA9WR+acRNh9omgE1XSt7ZphfIqkJIJlPxE+sPosaj7
 eGlM0Khte5vvsiQpHsdvSAN+CLagRbO7jq1DzKg7E2k0f2rBFz6lxwV342QcZll73FR2
 I+EeXMcDf0Fi0QkPCmfZ2mZAl/GhNh12QkipwU27Ix7OuvyE1RK3hUd+H0VMpAID8clh
 EX1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0NI8hQw/naV7Yx2j1iYrucmOZmMC28VxTmIpC+C0Ix+0S7vEflyWfNvGuOvKWsnQKD86qGwvCiv0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdaO/j6o24IRbzyf6Qodok27Y0Ju00Alfc/0/9tKaM2XXsiBhF
 ZoZ+MLlNmRP95XRAn1ZJsIDyhPfQPYwwDBUEZckAh4urqwfl1ASXklbxvlkZvD7uSjSfqJtBgCA
 28xBRNWItnsTlzs2Aj7ViAIY7MK4j8IugA7pI59pwc6jZibq37IxAt1OQ8Co0PLPb4CSWBSXRES
 bvoJvUZS2kjy2O7lg0T2rUkhijInb0VYfBquCLPxxMOfM=
X-Gm-Gg: AeBDieuCpOc5ORqDWmmYtwYSP+wMeja7nYoKNqKfUIKYDHXLz3yoIT0PiVkX60h0BPM
 OPhKFmYdOQhMMmbP4IjYmhWgSzarhR+OV2eFHkx5aW+gH3iJ9HCwuyzckA1FDBSQQ86LVkAd9ee
 U92oG1t5izVEBH2p7jjA3Y/WWRggyfQIP08l15Q7tRuWAgeZIjwCIhL3YbXKJAnV4Jhae7IfnWI
 ev80UAlQcFKtYusfOnL9VJDp7D52zWJ
X-Received: by 2002:a05:6830:488e:b0:7db:a0b2:b5d5 with SMTP id
 46e09a7af769-7dc27e1ca9cmr8189345a34.24.1776105180155; 
 Mon, 13 Apr 2026 11:33:00 -0700 (PDT)
X-Received: by 2002:a05:6830:488e:b0:7db:a0b2:b5d5 with SMTP id
 46e09a7af769-7dc27e1ca9cmr8189318a34.24.1776105179660; Mon, 13 Apr 2026
 11:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260325082534.GN814676@unreal> <acW2BwQKaUbS3eL9@kbusch-mbp>
 <20260331083758.GA814676@unreal> <acvFV8c5QVxnt3Em@kbusch-mbp>
 <20260331132942.GC814676@unreal> <acvNsvS5ShlQlrox@kbusch-mbp>
 <20260331140309.GH814676@unreal> <acvWplw67b3Gwlkc@kbusch-mbp>
 <20260331190220.GI814676@unreal> <acwkAo2k41xaxdTS@kbusch-mbp>
 <20260409120415.GF86584@unreal>
In-Reply-To: <20260409120415.GF86584@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 13 Apr 2026 11:32:48 -0700
X-Gm-Features: AQROBzDIIpZEN3aiHYPi89ixDuzK7SpFChCr2JMeXAVEQc6s_3ctAex9jcSvckQ
Message-ID: <CAH3zFs0hx_-3LetSUaPRMg=0jaL=GD7Mop3pEUhJ3O3qkaJrQg@mail.gmail.com>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
To: Leon Romanovsky <leon@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: E5zvcXvdezoMaTxWBYvVfyjtLLYlEoTi
X-Authority-Analysis: v=2.4 cv=DvVmPm/+ c=1 sm=1 tr=0 ts=69dd36dc cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=VwQbUJbxAAAA:8 a=f99BUTzuh9MxvKowt8oA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-ORIG-GUID: E5zvcXvdezoMaTxWBYvVfyjtLLYlEoTi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE4MiBTYWx0ZWRfX9wZGU9skrFeY
 orGkj+f8LAdS0/mVOFeokwCQIpTX3oNb8XtzMkZBOwqsM4CfkESOXOMLL0AcqEPI7lp0Rqs66Iv
 7gFIR8732J8e0Bau/Svlb7mE5fSWw04XXfSJyh8gavIsXpu7LNX6rcDs66TGdNJWKo5/GFAOhzI
 G/ZLATffub+iVZfghhHcBh6QLkqstIzMhCTNGS/HNQTNQLY8vRuNZrkdWjwsFuh8F4bnyxZSVAH
 Tm3tq77Vrmxozv8oD1FRBGeZOQfuj0T4v2o97/fnTH7kHCPLkEgDFCTHiWxp8iLueXy0ZzyosBx
 NbiDuQIGtrALn2nefWwVUcp73k8KxKjYfiL0fod/J+jvrp/hGW+wkPJY8S87jiDDXtGVKOELzXB
 swH7f3pKQDphov6pyg7z1ITdB2osT0rBQvEVJtiYs0B1TYCB/j6rM5ZmvDPIRpOls6XJ/14RnZH
 noqqFK0CD6pw5pm8P7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Mailman-Approved-At: Tue, 14 Apr 2026 18:48:22 +0000
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

On Thu, Apr 9, 2026 at 5:04=E2=80=AFAM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> >
> On Tue, Mar 31, 2026 at 01:44:02PM -0600, Keith Busch wrote:
> > On Tue, Mar 31, 2026 at 10:02:20PM +0300, Leon Romanovsky wrote:
> > >
> > > Right, what about adding TPH fields to struct vfio_region_dma_range
> > > instead of struct vfio_device_feature_dma_buf?
> >
> > You might have to show me with code what you're talking about because I
> > can't see any way we can add fields to any struct here without breaking
> > backward compatibility.
> >
> > If we can't claim bits out of the unused "flags" field for this feature,
> > then my initial reply is the only sane approach: we can introduce a new
> > feature and struct for it that closely mirrors the existing one, but
> > with the extra hint fields.
>
> Something like that, on top of this proposal:
>
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index 3961afa640391..70d5ee1e3ef7b 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -241,9 +241,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_cor=
e_device *vdev, u32 flags,
>                 return -EFAULT;
>
>         if (!get_dma_buf.nr_ranges ||
> -           (get_dma_buf.flags & ~(VFIO_DMABUF_FL_TPH |
> -                                  VFIO_DMABUF_TPH_PH_MASK |
> -                                  VFIO_DMABUF_TPH_ST_MASK)))
> +           (get_dma_buf.flags & ~VFIO_DMABUF_FLAG_TPH))
>                 return -EINVAL;
>
>         /*
> @@ -300,13 +298,10 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_c=
ore_device *vdev, u32 flags,
>                 ret =3D PTR_ERR(priv->dmabuf);
>                 goto err_dev_put;
>         }
> -       if (get_dma_buf.flags & VFIO_DMABUF_FL_TPH) {
> -               priv->steering_tag =3D (get_dma_buf.flags &
> -                                     VFIO_DMABUF_TPH_ST_MASK) >>
> -                                    VFIO_DMABUF_TPH_ST_SHIFT;
> -               priv->ph =3D (get_dma_buf.flags &
> -                           VFIO_DMABUF_TPH_PH_MASK) >>
> -                          VFIO_DMABUF_TPH_PH_SHIFT;
> +       if (get_dma_buf.flags & VFIO_DMABUF_FLAG_TPH) {
> +               priv->steering_tag =3D
> +                       dma_ranges[get_dma_buf.nr_ranges + 1].tph.tag;
> +               priv->ph =3D dma_ranges[get_dma_buf.nr_ranges + 1].tph.ph;
>         }
>         /* dma_buf_put() now frees priv */
>         INIT_LIST_HEAD(&priv->dmabufs_elm);
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index e2a8962641d2c..a8b8d8b1a3278 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1497,20 +1497,30 @@ struct vfio_device_feature_bus_master {
>   */
>  #define VFIO_DEVICE_FEATURE_DMA_BUF 11
>
> +struct vfio_region_dma_tph {
> +       u16 tag;
> +       u8 ph;
> +};
> +
>  struct vfio_region_dma_range {
> -       __u64 offset;
> -       __u64 length;
> +       union {
> +               __u64 offset;
> +               struct vfio_region_dma_tph tph;
> +       };
> +       union {
> +               __u64 length;
> +               __u64 reserved;
> +       };
> +};
> +
> +enum {
> +       VFIO_DMABUF_FLAG_TPH =3D 1 << 0,
>  };
>
>  struct vfio_device_feature_dma_buf {
>         __u32   region_index;
>         __u32   open_flags;
>         __u32   flags;
> -#define VFIO_DMABUF_FL_TPH             (1U << 0) /* TPH info is present =
*/
> -#define VFIO_DMABUF_TPH_PH_SHIFT       1         /* bits 1-2: PH (2-bit)=
 */
> -#define VFIO_DMABUF_TPH_PH_MASK        0x6U
> -#define VFIO_DMABUF_TPH_ST_SHIFT       16        /* bits 16-31: steering=
 tag */
> -#define VFIO_DMABUF_TPH_ST_MASK                0xffff0000U
>         __u32   nr_ranges;
>         struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
>  };

Sounds good, thanks! We will follow up and move this RFC to a formal patch.

Zhiping

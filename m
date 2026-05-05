Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FC9CD13DA
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 06:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13C8010E0F3;
	Tue,  5 May 2026 06:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="IhXflBOe";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6809510E0F3
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 06:54:19 +0000 (UTC)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644HUxrV3703959
 for <dri-devel@lists.freedesktop.org>; Mon, 4 May 2026 23:54:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=D1mf9Znv8+ZNWIl/62MdhJpFIl6cZ0E08irrbj6h/RE=; b=IhXflBOemPK3
 U8Z15qfbXAtar3VVsStb8w8V6wh1lL2Ws0tmFDXc99BVDS7Lo21exksx9//XQMUo
 DBuksD73qntJ+bIuhKGsMusUX8KD2Z6Q1vueNAPDNMzQiBh8DAxMOo/GYY+gLh8K
 cmxuT+sv/xGOvDt99IP0ecrA6vErAQe5cN6jEUwhzHS2o2nb5mFKdUeCvXQbtTUK
 Eja7bMB/foB8yPMA2nUogQvg0I/LLcJxjf7s1hxBfoDxtmnD+lRAAgDGEL9fOx+R
 YQykJpmeDb9fGCDSBTOeJdine5TdaUnpHeOn9c53exrV+NGMQyBxtSB076wdHsTj
 X96BUp0ASw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dwexyph3j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 23:54:18 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7de44ba64e7so6979740a34.1
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 23:54:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777964058; cv=none;
 d=google.com; s=arc-20240605;
 b=USlYMaAjWX0nbr+5klRgYQsA61Q+FLVpxhKDM9LvudFq7tScKpH3PzVuRPGzeVpfCb
 pmUnNZhwmPHe02VfHkgrkAbPmpZT0yWEjEHZoEYD37Lm0ds0RT6LJn6R6DPJmU1GlcNR
 OcaHHEtT3UkXtxR/8Scs/plmV5Op7gG3uGLPypKYq4MBFjAFqqcw1uqnxQ32McIwVa48
 ssGnCBcwMcXQrhiEGKV+vvCux0Hd7/NPwb2WXBzuUyJhsy47A9390rJwXJIneVEJw8tB
 /GwTkiRGZL04467MxzB0r2a5fcRVzk6hkokdT2GtER5OWRb+0YhILtx+M8ldB43XfM4o
 Doig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=uhzg8pVh5XZoijloMRfkO2ATqnu2chpe+p7ocg9d4tw=;
 fh=U80sT5KCHSHAHILpmP7bZKyUI03SW9v1OVmLSI97xOc=;
 b=bK/Ng8CzDEITEnPcZZ0Wehxxkf1siCf9yI9QK41pk+lJwZQYUa87o0Rc1qPW9XJgvL
 t2QXj7RqIrNQVfnTccuiPJ3P3TZWg66uW6s8FYDJ/uVxpvjJSgpGbk8rCUeJH//pYqSv
 +ZkYXPe2KdOxBKEw/b3XEvOSTMAlm+b/y7ZarIh4zbc1egRwgbq3t3y0p8WdkCDZ3+Tm
 IostjTk9VMHqYSky7KKfI8i0yomdBboiwcRAYTszLvPTC1AVNrrVT17HLjJO/blOZ95X
 4ggVh/RpWWTJQxWMmKh3V8/O6CjsqI/gLsml+Ck/KRAHsZ2x/FxrzkCnuxpsCpATpuYJ
 qcHQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777964058; x=1778568858;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uhzg8pVh5XZoijloMRfkO2ATqnu2chpe+p7ocg9d4tw=;
 b=IteRow2nZEeortdH54ZNLdEvYVtvZO/jfAOnbrcfgspTizYTxnnV/foLkPaqKIsXY3
 pogN5H4fM5YU1GB/s3SY+KpfZHz8K6J95W8KOtkM1gVa9ffVoqUawFK6N03z5VCckIdj
 WaE0qySZXbG45ht6EnIxgaath1IxNZJZc4rPuTRpxoT2elHGkJGLLDerpLgZF5EYfbsj
 OK3RGgkk7gP78pmFVI39MNrFTXN/hQ1oi9wdyGYrvfO0KOXM9k1JhlKWYxe+zrmubaQU
 /lUZDfI+XsFd9BwWDoLwKfHUxVrv7oNy+dQNl2cG7lZpHmO2YV8lS+ZXLlxzsxSljEdp
 SrHg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dbZiPsPitkeiq/YLBH6hxfuXbxivzCwRhpOZdW/GgBiEF9B4xsipwQOPMblvKVeiYah0JeoaISQE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEPJQNBfF/jdtbE+rX8duoWAl+HWdiI4jcCMX/9v1VE9yXZQ7f
 Jve4dr1la6R/sjbzmRj0WzyloFO5V4FVBzPhmbvLp93h9sGUz6YT44sq/31kyWcLsMRzH+N/UJC
 8X7+8ZuePZU/kbpqvruhChqJH2q3tDVBcEOR2uvH9IZqMGF+LX1lFlitCSjuegQBA2keeej4kIJ
 x+cbyjo1QKr68ni0ACztCBdGU3eBvJxkYcCBUasVSFGY0=
X-Gm-Gg: AeBDieuqHHyZD9/XriJZGndFfl7a/xwkqiC/U5iuyR/AF1494X/oAHg/Q7AAancXi7T
 2DUbX0+K5VwgKfHfjUFpmStlGZdgyNEZ6j9NBLCFu6q+We64k5ugPRnUOwRV6k2QNLqxiQgCod4
 4zFzdfGtLiKTGpMvyiHuUsYjKr1zsGex1mmw+9M9wie1i4jKSSUnE/5A3SDg+6ewHgOHZPfVa7p
 1h6eQIOYiUCSgt8uo3+Zk8KRxYIuqcxUa4Q79entRsC9y7xTMw=
X-Received: by 2002:a05:6830:6e1b:b0:7e1:cbe3:bb1b with SMTP id
 46e09a7af769-7e1cbe3be7emr251848a34.0.1777964057785; 
 Mon, 04 May 2026 23:54:17 -0700 (PDT)
X-Received: by 2002:a05:6830:6e1b:b0:7e1:cbe3:bb1b with SMTP id
 46e09a7af769-7e1cbe3be7emr251833a34.0.1777964057130; Mon, 04 May 2026
 23:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260430200704.352228-1-zhipingz@meta.com>
 <20260430200704.352228-2-zhipingz@meta.com>
 <20260504154459.77b8153d@shazbot.org>
In-Reply-To: <20260504154459.77b8153d@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 4 May 2026 23:54:06 -0700
X-Gm-Features: AVHnY4LnfRqtsa29br_gywqWSmKi9XQx9-UD43AecyJJP1ECdfbRFsjVzAPHTkA
Message-ID: <CAH3zFs3ZEAjsy_8nq4EHGbNWzXVVfJeRynEdVNYu9_j8N24s8w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vfio: add dma-buf get_tph callback and DMA_BUF_TPH
 feature
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Keith Busch <kbusch@kernel.org>,
 Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: u_U3vST30t6WDfFUuF-VgRELZv9UpIOe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA2MiBTYWx0ZWRfX85LMqgOEiRam
 3q5/zH8ijemMyKh5/8qzi3fI1COw02Z5C6c1XqeFrmXeL/pmiZEzHS2l3/jY9AUkLXWU5nc6O8q
 O0DIwjBFgggzRMjxTY+XNpGT2G8earMXWAcsMH9V2klPQmieSQjc03UNAM1K6m58WVkxKK4EKuv
 DQInJ8c2twZ4hxkj43K7wbIms5eWJKXH96C2bff4IGPgdpCXLcvrJB81cTOMLR73pQ/le2NpKqW
 FWJ05hb2HVreZMEEv+HTbi1GsTuoF0R2QVVmak38Aatj9sZO9ZAZSKr5CwNf/9K8l62Y9d5fSAm
 2vJvW1v4AJtFQgnFSNYYD5Xl6lr1ITHZXYk3847Cpk5K2lSPSC7KdaqqeS6YLCfXN+TxCM63B1e
 h4CVr+RfsvydylBDMolfM7tKmhx6JeZdBNQ0uRXkWy9JJUJ7ZSYefWftcHF5gcwtmD17GhsU9GJ
 G+d1BQDzD2z5nKYhOnQ==
X-Proofpoint-ORIG-GUID: u_U3vST30t6WDfFUuF-VgRELZv9UpIOe
X-Authority-Analysis: v=2.4 cv=Zcwt8MVA c=1 sm=1 tr=0 ts=69f9941a cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22
 a=c92rfblmAAAA:8 a=VabnemYjAAAA:8 a=r1p2_3pzAAAA:8 a=VwQbUJbxAAAA:8
 a=YLhAehpVo6qmETfym2AA:9 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=gKebqoRLp9LExxC7YDUY:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
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

On Mon, May 4, 2026 at 2:45=E2=80=AFPM Alex Williamson <alex@shazbot.org> w=
rote:
>
> >
> On Thu, 30 Apr 2026 13:06:56 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
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
>
> The uAPI is better, but sashiko has some review comments[1] for you.
>
> Please also copy the kvm list for vfio related development.  Thanks,
>
> Alex

Got it, thanks Alex. let me check sashiko's comments and post a new
revision. i also copied kvm@vger.kernel.org and will include in future
revisions.

Zhiping

>
> [1]https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260430200=
704.352228-1-zhipingz@meta.com__;Iw!!Bt8RZUm9aw!7glmqoMRhcdDwOgCAQuuEVqlhFJ=
rh9bAYHXvicXPAO2M-k-NPwE_wFeUjVhe7EXbkXMd6g7eOe13$
>
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
> > +
> > +     *steering_tag =3D priv->steering_tag;
> > +     *ph =3D priv->ph;
> > +     return 0;
> > +}
> > +
> >  static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachme=
nt,
> >                                  struct sg_table *sgt,
> >                                  enum dma_data_direction dir)
> > @@ -101,6 +120,7 @@ static void vfio_pci_dma_buf_release(struct dma_buf=
 *dmabuf)
> >
> >  static const struct dma_buf_ops vfio_pci_dmabuf_ops =3D {
> >       .attach =3D vfio_pci_dma_buf_attach,
> > +     .get_tph =3D vfio_pci_dma_buf_get_tph,
> >       .map_dma_buf =3D vfio_pci_dma_buf_map,
> >       .unmap_dma_buf =3D vfio_pci_dma_buf_unmap,
> >       .release =3D vfio_pci_dma_buf_release,
> > @@ -331,6 +351,55 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_=
core_device *vdev, u32 flags,
> >       return ret;
> >  }
> >
> > +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vde=
v,
> > +                                   u32 flags,
> > +                                   struct vfio_device_feature_dma_buf_=
tph __user *arg,
> > +                                   size_t argsz)
> > +{
> > +     struct vfio_device_feature_dma_buf_tph set_tph;
> > +     struct vfio_pci_dma_buf *priv;
> > +     struct dma_buf *dmabuf;
> > +     int ret;
> > +
> > +     ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> > +                              sizeof(set_tph));
> > +     if (ret !=3D 1)
> > +             return ret;
> > +
> > +     if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> > +             return -EFAULT;
> > +
> > +     if (set_tph.reserved)
> > +             return -EINVAL;
> > +
> > +     dmabuf =3D dma_buf_get(set_tph.dmabuf_fd);
> > +     if (IS_ERR(dmabuf))
> > +             return PTR_ERR(dmabuf);
> > +
> > +     if (dmabuf->ops !=3D &vfio_pci_dmabuf_ops) {
> > +             ret =3D -EINVAL;
> > +             goto out_put;
> > +     }
> > +
> > +     priv =3D dmabuf->priv;
> > +     down_write(&vdev->memory_lock);
> > +     if (priv->vdev !=3D vdev) {
> > +             ret =3D -EINVAL;
> > +             goto out_unlock;
> > +     }
> > +
> > +     priv->steering_tag =3D set_tph.steering_tag;
> > +     priv->ph =3D set_tph.ph;
> > +     priv->tph_present =3D 1;
> > +     ret =3D 0;
> > +
> > +out_unlock:
> > +     up_write(&vdev->memory_lock);
> > +out_put:
> > +     dma_buf_put(dmabuf);
> > +     return ret;
> > +}
> > +
> >  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool rev=
oked)
> >  {
> >       struct vfio_pci_dma_buf *priv;
> > diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_p=
ci_priv.h
> > --- a/drivers/vfio/pci/vfio_pci_priv.h
> > +++ b/drivers/vfio/pci/vfio_pci_priv.h
> > @@ -118,6 +118,10 @@ static inline bool vfio_pci_is_vga(struct pci_dev =
*pdev)
> >  int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u=
32 flags,
> >                                 struct vfio_device_feature_dma_buf __us=
er *arg,
> >                                 size_t argsz);
> > +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vde=
v,
> > +                                   u32 flags,
> > +                                   struct vfio_device_feature_dma_buf_=
tph __user *arg,
> > +                                   size_t argsz);
> >  void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
> >  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool rev=
oked);
> >  #else
> > @@ -128,6 +132,13 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core=
_device *vdev, u32 flags,
> >  {
> >       return -ENOTTY;
> >  }
> > +static inline int
> > +vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev, u=
32 flags,
> > +                               struct vfio_device_feature_dma_buf_tph =
__user *arg,
> > +                               size_t argsz)
> > +{
> > +     return -ENOTTY;
> > +}
> >  static inline void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_devic=
e *vdev)
> >  {
> >  }
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -113,6 +113,23 @@ struct dma_buf_ops {
> >        */
> >       void (*unpin)(struct dma_buf_attachment *attach);
> >
> > +     /**
> > +      * @get_tph:
> > +      * @dmabuf: DMA buffer for which to retrieve TPH metadata
> > +      * @steering_tag: Returns the raw TPH steering tag
> > +      * @ph: Returns the TPH processing hint
> > +      * @st_width: Consumer's supported steering tag width in bits (8 =
or 16)
> > +      *
> > +      * Return the TPH (TLP Processing Hints) metadata associated with=
 this
> > +      * DMA buffer. Exporters that do not provide TPH metadata should =
return
> > +      * -EOPNOTSUPP. If the steering tag exceeds @st_width bits, return
> > +      * -EINVAL.
> > +      *
> > +      * This callback is optional.
> > +      */
> > +     int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *ph,
> > +                    u8 st_width);
> > +
> >       /**
> >        * @map_dma_buf:
> >        *
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1534,6 +1534,28 @@ struct vfio_device_feature_dma_buf {
> >   */
> >  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
> >
> > +/**
> > + * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) m=
etadata
> > + * with a vfio-exported dma-buf. The dma-buf must have been created by
> > + * VFIO_DEVICE_FEATURE_DMA_BUF on this device.
> > + *
> > + * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DM=
A_BUF.
> > + * steering_tag and ph are the raw TPH values that importing drivers s=
hould use
> > + * when accessing the buffer.
> > + *
> > + * The user must set TPH on the dma-buf before the importer consumes i=
t.
> > + *
> > + * Return: 0 on success, -errno on failure.
> > + */
> > +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
> > +
> > +struct vfio_device_feature_dma_buf_tph {
> > +     __s32   dmabuf_fd;
> > +     __u16   steering_tag;
> > +     __u8    ph;
> > +     __u8    reserved;
> > +};
> > +
> >  /* -------- API for Type1 VFIO IOMMU -------- */
> >
> >  /**
>

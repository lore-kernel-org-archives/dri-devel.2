Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1389FCD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 05:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6162210EC3F;
	Thu, 28 May 2026 05:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="uc/+wgvg";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A3110EC3F
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 05:34:22 +0000 (UTC)
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKjRAB444178
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 22:34:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=yigIwCbHimjWd+a6wHDY1b3tSI1vv5FfPy4Pq/4DlQw=; b=uc/+wgvgCCA+
 dSWOwnjyOqXpj98DA/6ncZvRaWij2CDBABR7wAHevHeUoBOHl8oAm8V7edgPrs/E
 dUc+fGzhHlUo64J2CoEAfQqr96FtbyNuoBxzXkJaS1nSay8C04QylaGzIJyjdDnM
 gHR/aiA3luAwRbH1KLjkr/2EOBdVckA4KSbzfL295pNZDkCDCqGEzBmANwfBZDhj
 BpL/eLKVqA85pwb26QIxUWCNwQ3B3jVNVXq3lgCLMTuw4RD0dol23gx+dIlwYr2V
 romXbIAH31Qb8d55S94nZHU9W2uH5QposzDj3qWWjy1EPwLWHZ4z2HZyaUU45ZPU
 gKiTAWkw0A==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x1tck7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 22:34:21 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7e65a0125c3so4880107a34.3
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 22:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779946461; cv=none;
 d=google.com; s=arc-20240605;
 b=LILVVaYrySoBdMEUQN3qHxULsl1E7vyuB/8u3NtLTSw+8JeU/5kyjKiYMLPUnuS1WT
 Fn++axUjeQyMO5dQEmRk1JvkvsDPnDDcA+MSHW+zY+IXwIrLavwdUk5EVBWt77AsJMQv
 iAwWpLGwraKJ57JfqvN+73kyHzRw+kkyj1t2aJGhUVPapfkHdaf8419oJTFMa7s6epUt
 uQRXMZqTkvdhjWd5zRWvACowfyptuxJtdVmiPqGfiJrCdE+dIMRf++kRY/n5SkCkqq1e
 BDGzVol74bMMVUaX8uRnw1C4awDWrFFFqpKXLF2W2xIoj2yg6enxn+hiXAcqmalcpnXH
 9LFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=NsemaC8yIGA+q/PWkZ1wuh9lBXS1IQhsEGeGywafozI=;
 fh=mh8ymI+2RVjrRy8nhBI75vNS3KfsGDjc7acEdC63fJM=;
 b=ke/7kectSrhyipF5mR7pfydvqiDDsDrgNczrlszy253W6NQ5j/2SdJPO7PfBLTvPEg
 mLHCh8rcG0lJzyzHvnnSeIYLgkphwKKdlE1PiOJyOjrs8Ho8ytEu5L6UvBKrM+IKrioK
 +byLKGzVPXr3wo7bVMJ/lxKV9WhF4SQTtMYNLIDb4YsHEkR0AbYn8uZ+jch72O3nkg2M
 P2CUOaK1s3+clAOvaaY63NZqJbkvx4z+/1gB7uFKBHDiFTos2nrFZyJ2NQ2VhHT1Ao1b
 BLqNAGXayi9PovZGeTWMiv0gsBUSgmsKVN673/of2FNjvJG3IxTfAcvFaScPwjoqZ87X
 gBKQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779946461; x=1780551261;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NsemaC8yIGA+q/PWkZ1wuh9lBXS1IQhsEGeGywafozI=;
 b=Tj295UHWk92H8zU5L1hT2mpybc600JVNjiY2/TG5obCxXe92prLgBpMt/ReJI3U3zF
 EXjOc94WVAz9p2pgX3y4gwyNcJytFqe/Ije0ShRvviJji6tNSxaoyqDsNd8jju2c/osm
 TOY3hYD+XamCCrrW/58agzkN9XyeoPzS8C/6mbpQmaoJ0ZkDbSA2gfJ0HximocBHECSC
 FJXyABzJy2rFTx1SLkz76UPa5Gf+xmtUHYKWQUOw6AuRrkorcq2cHbGieyXqyv7zShQa
 TUOLRy55BELu5MoNE1cuTJC5eSLw+PaKuRym7qQaKKl2dPn/G3hI6FDbDTEVg68jcNYK
 EKww==
X-Forwarded-Encrypted: i=1;
 AFNElJ+A3uzyOfCNTX2nuN0XVa6MXmDTHJjdFavK2mRW8Lqki7WjVKmeYnuqz+y21yREstbT1iXEQfwiq10=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTQOZN+H+sQpD1DGwFe0yTxu9kn0xaHNrATYS3ckRMjuDKtj+d
 +7PNAH5WBS+TFPnr/Y9BX3H8MRy7vMFLMbp64KWYWQo8pqUqhEqRMsDpuWJVi+PPhndOeo1sgPS
 +sZXbO0sx/Wc9/9hi9bPAJjgpU5uAmvJNRzp1ywEeVGETCnxfucf8+NuNddd1oNi7OJRX3nweTd
 CxH4rdzJ26OHTBvqp8HgdmzMK23eu2q4HWPY+K3mHWk14=
X-Gm-Gg: Acq92OG1YsjL8hopNipJ+5x3ee1Wx3umnsazoj5M97KWvpzXT0DJ9ZYhk9tCwyVxPu9
 H2dLhrH3FK9NIlINYHAJ1XdsfKNCr6KkRXApz3P1nIQ1pVt4G4at2E8J/QX/b5SXHlH/ByQhJyU
 5V//79YNG9sqKgY3x+4zAR3Peno01I3DibH+YF8qi4Ws4XMvataBYLerjivUjFr8iKb5oDBh5sR
 0SrURij2COi42BRe2iWC+g7l64YzAVIdIFuzmFHvFzH3jipoLU=
X-Received: by 2002:a05:6830:d09:b0:7d7:e142:2ead with SMTP id
 46e09a7af769-7e5fef2fed1mr15293314a34.20.1779946460548; 
 Wed, 27 May 2026 22:34:20 -0700 (PDT)
X-Received: by 2002:a05:6830:d09:b0:7d7:e142:2ead with SMTP id
 46e09a7af769-7e5fef2fed1mr15293297a34.20.1779946459924; Wed, 27 May 2026
 22:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <20260526144401.1485788-4-zhipingz@meta.com>
 <20260527120607.248867c1@shazbot.org>
In-Reply-To: <20260527120607.248867c1@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 27 May 2026 22:34:09 -0700
X-Gm-Features: AVHnY4IPizydUUisI1vbdajmFSBFq1y3z7-Dj6POour1Bigd-el14zQJMiUUXOQ
Message-ID: <CAH3zFs0dxty7VPd+_00E2yHtw8a0V2Givn9k57RA2ytGdHBXUg@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] vfio/pci: implement get_tph and DMA_BUF_TPH feature
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=F4NnsKhN c=1 sm=1 tr=0 ts=6a17d3dd cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=QGR5yYSNmr8It09QZWMA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 1mmub7BLq-bOlpfkZ-wktonPgCA4Mcf8
X-Proofpoint-ORIG-GUID: 1mmub7BLq-bOlpfkZ-wktonPgCA4Mcf8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA1MyBTYWx0ZWRfX6jUy+RYqh605
 Xqzhoa+2zO3Tc6htLGkPwUY4gxYw7mEDpmXjYMq0P2y6O+fnnpQQEQim/FexL39IHLh3N/xcGte
 bZfWz2LR+WH3h53I2Z2qKrrdYpyaGC9s/GtkKoU+rAtP/pdbfAajnwTdjwtFhmEHNSqvJBYNp6S
 8LvObiG74mB6bugoSkb4qo/8igUXessfSzoUehQHCrSJAEx9uR1G/m9sliEnLTtu0Sbj7+jAQko
 6ivsJBWi819JWbhmHzoWgfDmRVHC9Aap22LfnXSuT/UEWKaoQJfV4hkBYGy6I8GlXoOxYd4Ib5I
 Svycec3rK1UgWaFmgQfyviSiVVAlHNZVxCJpIYoZhIRAzdtN5IHo7PlaPJTIf8NcTCn65B+uLX3
 H+Crs8omgUh7pxCNJADBUmMb79P2i6DZb81i53DlnqjfTO3n9C6xKiXGH4XMVEeYIpRIyWMUoa1
 QEUX9zJD4Iu5Dldh5MA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
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

On Wed, May 27, 2026 at 11:06=E2=80=AFAM Alex Williamson <alex@shazbot.org>=
 wrote:
>
> >
> On Tue, 26 May 2026 07:43:55 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Implement the dma-buf get_tph callback for vfio-pci-exported dma-bufs
> > and add VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can attach TPH
> > metadata to such a dma-buf.
> >
> > 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> > uAPI carries both with explicit validity flags, and get_tph() returns
> > the value matching the importer's requested width (or -EOPNOTSUPP).
> >
> > The TPH descriptor is published under a new per-dma-buf mutex
> > (priv->lock) and read by get_tph() under the same mutex. The same
> > mutex serialises with the priv->vdev clear in
> > vfio_pci_dma_buf_cleanup() so a SET racing with device teardown
> > cannot observe a half-detached dma-buf. memory_lock remain on the
> > existing dma-buf paths; the outer order is memory_lock -> priv->lock.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c   |   3 +
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 110 ++++++++++++++++++++++++++++-
> >  drivers/vfio/pci/vfio_pci_priv.h   |  12 ++++
> >  include/uapi/linux/vfio.h          |  37 ++++++++++
> >  4 files changed, 161 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_p=
ci_core.c
> > index 050e7542952e..4fa36f2f7555 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1569,6 +1569,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_devic=
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
> > index 1a177ce7de54..3ea2978c376c 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -19,7 +19,19 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > -     u8 revoked : 1;
> > +     /*
> > +      * @lock serializes TPH SET vs get_tph and the priv->vdev clear in
> > +      * vfio_pci_dma_buf_cleanup(). It nests inside memory_lock:
> > +      * the outer order across these paths is
> > +      * memory_lock -> priv->lock.
> > +      */
> > +     struct mutex lock;
> > +     u8 tph_st_valid:1;      /* priv->lock */
> > +     u8 tph_st_ext_valid:1;  /* priv->lock */
> > +     u8 tph_ph:2;            /* priv->lock */
> > +     u8 tph_st;              /* priv->lock */
> > +     u16 tph_st_ext;         /* priv->lock */
> > +     u8 revoked:1;           /* dma_resv_lock */
> >  };
> >
> >  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> > @@ -69,6 +81,38 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *atta=
chment,
> >       return ret;
> >  }
> >
> > +static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steer=
ing_tag,
> > +                                 u8 *ph, u8 st_width)
> > +{
> > +     struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
> > +     int ret =3D 0;
> > +
> > +     mutex_lock(&priv->lock);
>
> Use guard semantics and drop ret, return from the error branch directly.
>

ack, will do.

> > +     switch (st_width) {
> > +     case 8:
> > +             if (!priv->tph_st_valid) {
> > +                     ret =3D -EOPNOTSUPP;
> > +                     break;
> > +             }
> > +             *steering_tag =3D priv->tph_st;
> > +             *ph =3D priv->tph_ph;
> > +             break;
> > +     case 16:
> > +             if (!priv->tph_st_ext_valid) {
> > +                     ret =3D -EOPNOTSUPP;
> > +                     break;
> > +             }
> > +             *steering_tag =3D priv->tph_st_ext;
> > +             *ph =3D priv->tph_ph;
> > +             break;
> > +     default:
> > +             ret =3D -EINVAL;
> > +             break;
> > +     }
> > +     mutex_unlock(&priv->lock);
> > +     return ret;
> > +}
> > +
> >  static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachme=
nt,
> >                                  struct sg_table *sgt,
> >                                  enum dma_data_direction dir)
> > @@ -95,12 +139,14 @@ static void vfio_pci_dma_buf_release(struct dma_bu=
f *dmabuf)
> >               up_write(&priv->vdev->memory_lock);
> >               vfio_device_put_registration(&priv->vdev->vdev);
> >       }
> > +     mutex_destroy(&priv->lock);
> >       kfree(priv->phys_vec);
> >       kfree(priv);
> >  }
> >
> >  static const struct dma_buf_ops vfio_pci_dmabuf_ops =3D {
> >       .attach =3D vfio_pci_dma_buf_attach,
> > +     .get_tph =3D vfio_pci_dma_buf_get_tph,
> >       .map_dma_buf =3D vfio_pci_dma_buf_map,
> >       .unmap_dma_buf =3D vfio_pci_dma_buf_unmap,
> >       .release =3D vfio_pci_dma_buf_release,
> > @@ -265,6 +311,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_c=
ore_device *vdev, u32 flags,
> >               ret =3D -ENOMEM;
> >               goto err_free_ranges;
> >       }
> > +     mutex_init(&priv->lock);
> >       priv->phys_vec =3D kzalloc_objs(*priv->phys_vec, get_dma_buf.nr_r=
anges);
> >       if (!priv->phys_vec) {
> >               ret =3D -ENOMEM;
> > @@ -327,12 +374,71 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci=
_core_device *vdev, u32 flags,
> >  err_free_phys:
> >       kfree(priv->phys_vec);
> >  err_free_priv:
> > +     mutex_destroy(&priv->lock);
> >       kfree(priv);
> >  err_free_ranges:
> >       kfree(dma_ranges);
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
>
> Don't we need to test whether the device supports the TPH capability
> somewhere here?  AIUI the device must exposed a TPH capability to act
> as a TPH completer.
>

Good catch, i will discuss this with my team internally and see if the
test/check is
necessary. In practice the device owner should know whether the device supp=
orts
TPH, so this would be a sanity gate.

> > +
> > +     if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> > +             return -EFAULT;
> > +
> > +     if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_E=
XT))
> > +             return -EINVAL;
> > +
> > +     if (!set_tph.flags)
> > +             return -EINVAL;
>
> This seems to block the path to marking both steering tags to invalid
> without any particular reason to do so.
>

Agreed, i will drop the check.

> > +
> > +     /* PCIe TLP Processing Hint is a 2-bit field. */
> > +     if (set_tph.ph & ~0x3)
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
> > +     mutex_lock(&priv->lock);
>
> Use guards.
>

ack, will do.

> > +     if (priv->vdev !=3D vdev) {
>
> For here and the next chunk, why is priv->vdev pulled into this lock?
> We're calling an ioctl on the vdev, that's stable.  We have a reference
> to the dma-buf, that's stable.  I think the ordering prevents this from
> needing to be under the lock, which probably means it should be
> s/lock/tph_lock/.
>

 You're right. I'll:
  - rename priv->lock to priv->tph_lock to make the scope obvious,
  - move the priv->vdev !=3D vdev check outside the lock,
  - drop the lock around priv->vdev =3D NULL in
  vfio_pci_dma_buf_cleanup.

> > +             ret =3D -EINVAL;
> > +             goto out_unlock;
> > +     }
> > +
> > +     priv->tph_st =3D set_tph.steering_tag;
> > +     priv->tph_st_ext =3D set_tph.steering_tag_ext;
> > +     priv->tph_ph =3D set_tph.ph;
> > +     priv->tph_st_valid =3D !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST);
> > +     priv->tph_st_ext_valid =3D !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST=
_EXT);
> > +     ret =3D 0;
> > +
> > +out_unlock:
> > +     mutex_unlock(&priv->lock);
> > +out_put:
> > +     dma_buf_put(dmabuf);
> > +     return ret;
> > +}
> > +
> >  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool rev=
oked)
> >  {
> >       struct vfio_pci_dma_buf *priv;
> > @@ -398,7 +504,9 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_=
device *vdev)
> >                       continue;
> >
> >               list_del_init(&priv->dmabufs_elm);
> > +             mutex_lock(&priv->lock);
> >               priv->vdev =3D NULL;
> > +             mutex_unlock(&priv->lock);
>
> As above, seems unnecessary.
>

ack, as replied above.

> >               vfio_device_put_registration(&vdev->vdev);
> >               fput(priv->dmabuf->file);
> >       }
> > diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_p=
ci_priv.h
> > index fca9d0dfac90..c58f369be4b3 100644
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
> > @@ -128,6 +132,14 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core=
_device *vdev, u32 flags,
> >  {
> >       return -ENOTTY;
> >  }
> > +
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
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 5de618a3a5ee..55cac3b7122c 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1534,6 +1534,43 @@ struct vfio_device_feature_dma_buf {
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
> > + *
> > + * 8-bit ST (steering_tag) and 16-bit Extended ST (steering_tag_ext) a=
re
> > + * distinct namespaces in the PCIe TPH ST table and may both be presen=
t with
> > + * different values. Userspace should populate the value(s) it has fro=
m the
> > + * firmware ST table for this device and set the matching VFIO_DMA_BUF=
_TPH_ST /
> > + * VFIO_DMA_BUF_TPH_ST_EXT bit in @flags. An importer requests a speci=
fic
> > + * width and receives the matching value; if the requested width is not
> > + * present, the importer is told TPH is unavailable for this dma-buf.
> > + *
> > + * ph is the 2-bit TLP Processing Hint and must be in the range [0, 3].
> > + *
> > + * Userspace is responsible for setting TPH on the dma-buf before hand=
ing the
> > + * fd to the importer. Calling SET again replaces the previously publi=
shed
> > + * values; racing a SET against an importer that is already consuming =
the
> > + * dma-buf is a userspace ordering problem.
> > + *
> > + * Return: 0 on success, -errno on failure.
> > + */
> > +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
> > +
> > +#define VFIO_DMA_BUF_TPH_ST          (1 << 0)  /* steering_tag valid */
> > +#define VFIO_DMA_BUF_TPH_ST_EXT              (1 << 1)  /* steering_tag=
_ext valid */
> > +
> > +struct vfio_device_feature_dma_buf_tph {
> > +     __s32   dmabuf_fd;
> > +     __u32   flags;
> > +     __u8    steering_tag;
> > +     __u8    ph;
>
> Nit, I'd swap the order of these so the steering_tag fields are
> back-to-back.  Thanks,
>
> Alex

sure, will re-order.

Thanks,
Zhiping

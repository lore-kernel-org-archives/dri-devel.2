Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A1BCDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEE9D10E041;
	Wed, 24 Jun 2026 05:25:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="i4PMNbop";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4634A10E034
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 05:25:09 +0000 (UTC)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65O39dvK2360867
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 22:25:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=obF+BXbpjwuxPtFMpKFj4tWFuIoMfWAxgPOaOEO/2Kk=; b=i4PMNbopiEyN
 dzJXF0sq4fQea/c+oGnEpQ3W40KWgQKMYp94BGV8TEah8W7YPRSPV0TWDxq9lK/c
 IH69OUDDNs4d0nLVIpJwr+XEv92pv/JuZswxBiUsvdERfmY5R4LlqN0TVFMY2Dvn
 08IxKg79hkxPM+eiEkYQh+L2YtGse+/WxlLJoLeIZTZ7DJJufjtjFVKTVUf07DeY
 Q0Fv1ltuXkx9gHTE8OgS6FoI4d2kaZ96QvTwthCibr43A1fFQI9UNcJYigi296TU
 3a6RjwS1xU1710l1vTTAfpyebNS7gpak3yb9NRra53jg5yCM5pdMRjLZuvUzzMdY
 3oI6N0shDA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eyv23dnkx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 22:25:06 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7e943138b94so992298a34.2
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 22:25:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782278706; cv=none;
 d=google.com; s=arc-20240605;
 b=XBE+qcQLykUWRK2huQZkP0xuYWfxPDmwGPLUyLXwrmwvF6snY0wNIMVRzOPnY48njU
 JQiZVFJjm9ySIjuK1CSQ5qYdD1dsT9/AuGYORXhATRItgUis2WbNuE5paRUcIlXk6JhZ
 4QDBHsrc2zKNTI10POZJXn2cFZB8K5MLIIEakbjkJwGxwAv85wdOCBWSZ+r0vo/OmBIQ
 bJl/+UhPTkhCSVjOF0q5koqwH5mpijFOiUlZPnUCVMB6TEPlxTdMaScAJPzGZYIm1PJ9
 aYdwJDO4DScEId1vMmvwzhZlEIYAU1psz9RF/rOLKBV3YdaGX2fxKFGOi8ogX0rnEcNv
 4q3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=nmAO6MORM+JCILZd6Ab8MnktXVX1EvzetGEcyzVhRCY=;
 fh=f1wCs6YMEITmT1pS/vrMq+88ZB0saoy5tm/7V3wMc7A=;
 b=lcEyLFVnbIurQYTb4FYC/Z7sb79BoD7SdCZwmHr7FbSzxXfNeihqRtwbBHnNNx2yDT
 mswXmAhwG+WWdTECgoI3E6BJHMbsBovzN8Ciwu221VdB50QIJ6ftwdzFElgYA8MZDPxk
 q+B9iaVSs803XC7wLGPJHiscULBjT3GRF/QtZz7YdWmG9nguMkP45+TNZb2g0FhUfI2X
 YgVhVvx/RIovT/gU089wJoBmDvGL13bSGPpejpHmiNexXmpJbO5wz2wo9jGKyxJw+IXQ
 JXNKOVXiiHhcImxuXI4xsXWG48wTMo4ZIttOlm59eXFPToZqMy9Rs4UPLRlR1jsUnmQH
 BSYw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782278706; x=1782883506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nmAO6MORM+JCILZd6Ab8MnktXVX1EvzetGEcyzVhRCY=;
 b=PaSLoWoXivXq6/M6yHP2kY1r4Et+3xbro0JyiNSxOY2eP2N21JvGWBZ7NVWXRh71k+
 DvhkezDYWXCo1gh6SqY+P8bW4Zc9xqgj2EyGAvJhrivndc8RTdztq7S++fm35rXR6L0c
 VMCX3Jx92Yt7Mn6zlrBOGvn3Nc00EN5aWNnQlw6X+z9AWN/7RMmjCYk38TOMKgznEHYm
 ZYkjbj2hTXPN2sZNrrOIRWEY2H/hb/pRNpQcZwFmCn9mcbRpXfWCuRY+OcaqbwsWJyog
 nqShRRayBeJrhko+LGvjNniPf8KeBWnmgb/YFj10P5CIOF+nhFjT0XxzxQrO47RNGrae
 9H9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ84qhqCHb2gEVNbVzH9UhHpKhRm+DU71RIwEKu5+rqt5beifNnRLaSzvyaRLCUtkEKft23+lJAQ8iU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0dnUesyF7YXJfUJgFy5CVFIEFtmVb2h8HQhzxFkYiieVLE+wn
 Bf2I0Jqc/cC2Vvb3xUxSxzPPA3PLqusJEwYhHVawbWb4XKkJdtb4wk4tskwwbjNKuDf70+6GTdN
 WQ2WqPJiQSOBtlqAnqWgzlOSs3a5EQiWihAQC0SaMh3T4lOxZNeYr0POCBrlwUqMnq8W+k1SOEm
 LNqzZtRh4BnZ+md6ewX1moxBQQ48Jh4BpWixmt+Gt8zGc=
X-Gm-Gg: AfdE7cmHmMY6L1f5OL6LVYeaYZqF8Ywk2X5IKRtTfMvFjJfcdKNnP9nRTsGV5xm03J1
 n9MfhhmO05JPbqP+ssyH798LBebNLirISzOFemreOCuDW3wAL2Ly6gIjL+Br5TK1hNVXJ+czMm0
 UY2lad2Lo2va/JqK1SH87RX5Zqv4f1pdzET/DZ1qlTN6/G8WQEl0dl2z9cF2GtKp4DPXehGl5hd
 BZX4yVK/AZLgKBYaElt03r9HelUag==
X-Received: by 2002:a05:6830:6c12:b0:7e6:f4a3:1dfc with SMTP id
 46e09a7af769-7e986c83822mr1589289a34.23.1782278705576; 
 Tue, 23 Jun 2026 22:25:05 -0700 (PDT)
X-Received: by 2002:a05:6830:6c12:b0:7e6:f4a3:1dfc with SMTP id
 46e09a7af769-7e986c83822mr1589274a34.23.1782278705036; Tue, 23 Jun 2026
 22:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260622184211.2229399-1-zhipingz@meta.com>
 <20260622184211.2229399-4-zhipingz@meta.com>
 <20260623121736.4d9e38b9@shazbot.org>
In-Reply-To: <20260623121736.4d9e38b9@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 23 Jun 2026 22:24:54 -0700
X-Gm-Features: AVVi8CcrRluVCfzsDiRhgyOh9k6XVpc_dByJFZOVuR1nJUXz2ghm7PL2MvWIArU
Message-ID: <CAH3zFs25EfNMRpYTtDTPXNY3FcYg7tYWKExVm-rbcuQRE=qBLw@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] vfio/pci: implement get_pci_tph and DMA_BUF_TPH
 feature
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA0MSBTYWx0ZWRfX0lbtJLlA6nr1
 HBKd4dfMqh3u1lnBQYRTKkMPrlr7KQxKW/w1ar4mKp+r5ncfge0vEfa8XPU5xuJp2qs9xYnqKYw
 JyNgi1fVXK50ud4v8caWH3AgZ0/277ofBdeo3D49cuNdCYrK32Uw+KfefLVcgzANWK3YV9lFaFO
 dlSqwFjHSU+46R2nmBlR9GYw+lTVU4fNrFc6piGnc/+8899LhMLtnrAgsST5+bxs3GBTYaWBD0J
 0z3jV5SeWsUaPnybrsNwerS++ZixTrqnZWHsGESBi4jnFc70d0EzlzGX2nboiJEzg+o3pA/iF+1
 A8yQnC3td5GokLJ6k3sh9VeRTFJciDMhlKcdpOHiiYQci0uUjRV6kECD+C1JupvTyewMGAN7P4q
 SKyAvt1X/bwBb+rB5ZmgU3HW22eT3w==
X-Proofpoint-ORIG-GUID: FL_GKY0XzzLXYX-Tj0wFWmsyBt9LBVCZ
X-Authority-Analysis: v=2.4 cv=b9aCJNGx c=1 sm=1 tr=0 ts=6a3b6a32 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=_DGCK_szeJEHVohcwy8A:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA0MSBTYWx0ZWRfX30PmOyVKYDhu
 bFvV2T5t98EWLkhUETS3MXLok53fDlq0jAj7GekJErB9hp7qTCDnSe89WE085jClX9xEjTBTixC
 6UNIrGrxkm53b//zpRdcAJY4UXLmfQ4=
X-Proofpoint-GUID: FL_GKY0XzzLXYX-Tj0wFWmsyBt9LBVCZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_01,2026-06-23_01,2025-10-01_01
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

On Tue, Jun 23, 2026 at 11:17=E2=80=AFAM Alex Williamson <alex@shazbot.org>=
 wrote:
>
> >
> On Mon, 22 Jun 2026 11:41:36 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Implement dma-buf get_pci_tph for vfio-pci exported dma-bufs and add
> > VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can publish TPH metadata
> > for a VFIO-owned device.
> >
> > 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> > uAPI carries both with explicit validity flags, and get_pci_tph()
> > returns the value matching the importer's requested namespace or
> > -EOPNOTSUPP.
> >
> > Publish and read the TPH descriptor under dmabuf->resv, matching the
> > locking used for other importer-visible dma-buf state. The SET ioctl
> > takes dma_resv_lock_interruptible(), while the callback runs under
> > DMA-buf's asserted resv lock.
> >
> > Reject requests the device cannot consume as a completer:
> > pcie_tph_completer_type() must report at least
> > PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY, and Extended ST requires
> > PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH. Make PROBE follow the same hardware
> > gate so the feature only probes as supported when the device can really
> > consume it.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c   |  3 +
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 97 +++++++++++++++++++++++++++++-
> >  drivers/vfio/pci/vfio_pci_priv.h   | 12 ++++
> >  include/uapi/linux/vfio.h          | 37 ++++++++++++
> >  4 files changed, 148 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_p=
ci_core.c
> > index a28f1e99362c..c7d6902bc61b 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1572,6 +1572,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_devic=
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
> > index c16f460c01d6..d6f5dd321000 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -3,6 +3,7 @@
> >   */
> >  #include <linux/dma-buf-mapping.h>
> >  #include <linux/pci-p2pdma.h>
> > +#include <linux/pci-tph.h>
> >  #include <linux/dma-resv.h>
> >
> >  #include "vfio_pci_priv.h"
> > @@ -19,7 +20,14 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > -     u8 revoked : 1;
> > +
> > +     /* Protected by dmabuf->resv. */
>
> Nit, it would be more accurate to say:
>
>         /*
>          * Updates protected by dmabuf->resv, @revoked additionally
>          * protected by memory_lock.
>          */
>
> revoked also has an unprotected read, but it's previously existing and
> benign, and likely just needs a READ_ONCE() annotation.
>

Agreed, I'll update the comment and add READ_ONCE() as well.

> > +     u16 tph_st_ext;
> > +     u8 tph_st;
> > +     u8 revoked:1;
> > +     u8 tph_st_valid:1;
> > +     u8 tph_st_ext_valid:1;
> > +     u8 tph_ph:2;
> >  };
> >
> >  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> > @@ -69,6 +77,26 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *atta=
chment,
> >       return ret;
> >  }
> >
> > +static int vfio_pci_dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool e=
xtended,
> > +                                     u16 *steering_tag, u8 *ph)
> > +{
> > +     struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
> > +
> > +     dma_resv_assert_held(dmabuf->resv);
> > +
> > +     if (extended) {
> > +             if (!priv->tph_st_ext_valid)
> > +                     return -EOPNOTSUPP;
> > +             *steering_tag =3D priv->tph_st_ext;
> > +     } else {
> > +             if (!priv->tph_st_valid)
> > +                     return -EOPNOTSUPP;
> > +             *steering_tag =3D priv->tph_st;
> > +     }
> > +     *ph =3D priv->tph_ph;
> > +     return 0;
> > +}
> > +
> >  static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachme=
nt,
> >                                  struct sg_table *sgt,
> >                                  enum dma_data_direction dir)
> > @@ -101,6 +129,7 @@ static void vfio_pci_dma_buf_release(struct dma_buf=
 *dmabuf)
> >
> >  static const struct dma_buf_ops vfio_pci_dmabuf_ops =3D {
> >       .attach =3D vfio_pci_dma_buf_attach,
> > +     .get_pci_tph =3D vfio_pci_dma_buf_get_pci_tph,
> >       .map_dma_buf =3D vfio_pci_dma_buf_map,
> >       .unmap_dma_buf =3D vfio_pci_dma_buf_unmap,
> >       .release =3D vfio_pci_dma_buf_release,
> > @@ -333,6 +362,72 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_=
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
> > +     u8 comp;
> > +     int ret;
> > +
> > +     comp =3D pcie_tph_completer_type(vdev->pdev);
> > +     if (comp =3D=3D PCI_EXP_DEVCAP2_TPH_COMP_NONE)
> > +             return -EOPNOTSUPP;
> > +
> > +     ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> > +                              sizeof(set_tph));
> > +     if (ret !=3D 1)
> > +             return ret;
> > +
> > +     if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> > +             return -EFAULT;
> > +
> > +     if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_E=
XT))
> > +             return -EINVAL;
> > +
> > +     if (set_tph.ph & ~0x3)
> > +             return -EINVAL;
> > +
> > +     if ((set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT) &&
> > +         comp !=3D PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH)
> > +             return -EOPNOTSUPP;
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
> > +     if (priv->vdev !=3D vdev) {
> > +             ret =3D -EINVAL;
> > +             goto out_put;
> > +     }
> > +
> > +     ret =3D dma_resv_lock_interruptible(dmabuf->resv, NULL);
> > +     if (ret)
> > +             goto out_put;
> > +
> > +     priv->tph_st         =3D set_tph.steering_tag;
> > +     priv->tph_st_ext     =3D set_tph.steering_tag_ext;
> > +     priv->tph_ph         =3D set_tph.ph;
> > +     priv->tph_st_valid   =3D !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST);
> > +     priv->tph_st_ext_valid =3D
> > +             !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT);
> > +     dma_resv_unlock(dmabuf->resv);
> > +     ret =3D 0;
> > +
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
> > index 5de618a3a5ee..2d30ba43e2cf 100644
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
> > + * VFIO_DEVICE_FEATURE_DMA_BUF on this device, and the device must rep=
ort
> > + * TPH Completer support in Device Capabilities 2 (bits 13:12); reques=
ts
> > + * carrying VFIO_DMA_BUF_TPH_ST_EXT additionally require the device to
> > + * report the Extended TPH Completer encoding. Otherwise the ioctl
> > + * returns -EOPNOTSUPP.
> > + *
> > + * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DM=
A_BUF.
> > + *
> > + * 8-bit ST (steering_tag) and 16-bit Extended ST (steering_tag_ext) a=
re
> > + * distinct namespaces. Userspace supplies whichever values are valid =
and sets
> > + * the matching VFIO_DMA_BUF_TPH_ST / VFIO_DMA_BUF_TPH_ST_EXT bits in =
@flags;
> > + * an importer requests one namespace and receives the matching value.
> > + *
> > + * @flags =3D=3D 0 marks any previously published ST / Extended-ST as =
invalid
> > + * for future PCI TPH queries on this dma-buf.
>
> I think we should avoid "published" as it still suggests we're somehow
> able to invalidate what was previously reported and consumed.  It's
> offset by the trailing clause here, but that's absent below.
>
> Also, we're noting @flags =3D=3D 0 as if it's a special case, but we real=
ly
> need the clarity that if either flag bit is not set, the corresponding
> field is marked invalid for future queries.  Perhaps something like:
>
>    * @flags is the authoritative validity for each namespace: when
>    * VFIO_DMA_BUF_TPH_ST is set, @steering_tag becomes the valid 8-bit ST=
; when
>    * VFIO_DMA_BUF_TPH_ST_EXT is set, @steering_tag_ext becomes the valid =
16-bit
>    * Extended ST.  A namespace whose bit is clear is marked invalid and
>    * reported as unsupported to importers requesting it.
>    *
>    * Each SET fully replaces the dma-buf's TPH state: any namespace not s=
elected
>    * in @flags is left invalid, so @flags =3D=3D 0 marks both ST and Exte=
nded ST
>    * invalid.  This only affects TPH queries made after the SET completes=
; an
>    * importer that has already retrieved a value is unaffected.  Userspac=
e must
>    * therefore configure TPH before handing the dma-buf fd to an importer.
>

Thanks, I'll use your suggested wording here.

> > + *
> > + * ph is the 2-bit TLP Processing Hint and must be in the range [0, 3].
>
> Slight inconsistency here, @ph.  We might also help to silence the
> Sashiko warning to note:
>
>    * Undefined @flags and @ph bits must always be zero.
>

Yes, I'll fix @ph and add the undefined-bits-must-be-zero wording.

> > + *
> > + * Userspace must publish TPH before handing the dma-buf fd to an impo=
rter.
> > + * Calling SET again replaces the published values.
>
> The above suggestion is meant to replace this as well.
>
> > + */
> > +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
>
> There are several series in-flight contending for device feature
> indexes, so this should really go in through the vfio tree to reduce
> the risk of duplicates.  We also still need acks from the relevant
> maintainers for PCI, dma-buf, and mlx5 before this can be queued for
> v7.3.  Thanks,
>
> Alex
>

Sure!

Thanks,
Zhiping

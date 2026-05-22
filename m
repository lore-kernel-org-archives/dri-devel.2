Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBAFCD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 23:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2952910E2B8;
	Fri, 22 May 2026 23:54:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="HprCEILq";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCEB010E2B8
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 23:54:12 +0000 (UTC)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
 by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64MBYGmv380410
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 16:54:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=BJr1ZIFg0dApTPOKxEBWywjJAcZm+0SNH1wNhtJCPaQ=; b=HprCEILqoF+v
 cvKFEdCNE4M+GpUSlWvyDFSrqaysRza2gDHyHcQxfxabuxsv4H4440tBNg3URcwe
 IhKiL8qQoEkEObdZ8T4MddEVks4EE4PSO6CZXR/hQWgOqfq0Q+wppM2H8BL8krGN
 uNuClSzb9I25LxnmtHxJuy+WHaYwlKKB9CDPtOCnGGkOzLjs9Gcv159bnoND0fCZ
 RbT7A9qW88aYhXODSOz7vErLtRl5Ls2rPEGm2Ezmoy6XkEhIM094HhFeAV9vJhdS
 beEubh96WirNIK+JJ8565yhP9ZS5sw9XApDZ6Hc8/1BAlCeyVndv+1AQyJfroCFI
 je2kIFe8xg==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by m0001303.ppops.net (PPS) with ESMTPS id 4ea5x81gvk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 16:54:11 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e60dfccf42so1682135a34.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 16:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779494051; cv=none;
 d=google.com; s=arc-20240605;
 b=Dtqu0iC4v2oX0jYhEZPB5XCTT3TEMBO/1EHHx6hbwQ8bVG9Npss2hJLJh23sxkT+Oi
 NdLw0OrbXiQzZO6kW9UCU5QU21m1428C8v5qCfjGeKJPW986n7tomomparfOLKtz8PfV
 3zVU8i0cSAYQ6gaZhSr37OazrQU7UOzEazRZLhmW8GOKd2M47q4YZAwyRgFkKyzNoXMv
 4rOjl9uQJb9RorXwI3qBsrK+X601Y8t0gVaEhbBclgbXIIRL/1zAPwjKZar/47VMzXbI
 GPoOHuY+cpVQOHlEiG43lJwfghBCes/AsilomeWOUX8+y7bXaHNTGuIG8JvR9+U9UH86
 07Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=xPbccRhP9AzeKhw0/hE7Uzqn/4Emm7Q1lz66iybs3r8=;
 fh=25NjTkVuyE2xCuPpCNh+7UORTJNAtLhyoEnohyd9D1A=;
 b=RMohKMhPsw+QxTMkd9wo469CoxMW0QscVvl0JX4a2yv16/R6iQnLYG/LzYx4Avha3l
 KEyPP0VMlWP+3Q7S1q91M112wk4Cpw1lyYcs8SP/ZVUJtE4AWHi2LY/V8Y3fNprk+bjf
 Dq0WvzwgAJABP/ND7bdyFuWBuowGG2kILqsLRbie0AM0OVRH1dv79vN6VaphjXSL+U0p
 MS1v42pPTrg0xRbXBQJRQr+5jMjyBhnxFTNBCNjutGQAYbCBK1+bwIjJLNnApQ+NqFgP
 uv8HSl9v/X7VE/FjU1edy44E7wp6832xTBp1LqzEle3VelXoafp0Twk31/YvHrcx+iBw
 mAVA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779494051; x=1780098851;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xPbccRhP9AzeKhw0/hE7Uzqn/4Emm7Q1lz66iybs3r8=;
 b=HhpnNbe7fy4rFYYuvwe/QYMj5pfsvttuTb25x9eXDWkyb042nZ2FW5d+cAkQAS4Ews
 2+gtyfNgUUpJjvsr2q2saV/LnMeE3MBGDqROinWIbPNLNjmihCBTg1RYX/ihl4NqPIiR
 muyl10/CuSCKJFi/QY8LwARJb8JTDQU/4mN7v5sBiVaHkr47jHEg+UxvDTxBM72rJyAP
 GwHAcCZcuqzcVBWnwg4cRZnsXxdtXeKe2XWoZl73kY8I2Jvr6W9+y7MAb/GKs+gebBUO
 ltwDGYSHsUyKnYd+ejJzU9deo77jXkou6LGTJrx60F/eKPiLTBccpWMByqOsTRYqYR0H
 e7VQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8uNCvzNdQjFEUQnVAlM8X+n15e+zvQL5ZOACJ3ChMIJyXvpUL7RtmXIYRv9nSmJ7Hxf/ZoQ6GEoOQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLKK0JrHyGdDfj99orky5LI2vCEFIfUJmWBoyXJpK1F2bHxlo0
 yMjhHToKUYEoPvLg4UWxoUqwf91ujm1hfFbnNWSDq/DB7siCTBc+M+K7INw27NThIY8N4OqFDGt
 gzU2aSV6iUVkKheE/RNb362Lq7zFK1OL1UwG80X8TC3DWj7f3dj/d5kl2TnMMFUYsFye30wk5Kv
 owmeaET+pkVzp+fvGb86X02uReU5G4fERaUGStJrA10G0=
X-Gm-Gg: Acq92OEMqtxqsM4U7wKIUALeIKnJzfBLPj01tvCkYRuZIVd5nOaJ/MPmODfiPtSjPTg
 VxYQOkoPJbvki0WsbyT9xMJEDRgYMbtKB8pf/bCe87/IgfHKyXn1Nm0AUs6tn/K7AzsvRP+SWaA
 5iGh/P23/JUzoRWcHlTD5n7/FsS5T/3iOr65OE0Q2bNmPekx3qF8xV+1jp8fKUVPwtSVG9TAzXl
 a8WAmN6IQ5rpkp4arZ9wTLqz6Juzrg=
X-Received: by 2002:a05:6830:3789:b0:7dd:b184:1338 with SMTP id
 46e09a7af769-7e5fed5b607mr3897072a34.6.1779494050718; 
 Fri, 22 May 2026 16:54:10 -0700 (PDT)
X-Received: by 2002:a05:6830:3789:b0:7dd:b184:1338 with SMTP id
 46e09a7af769-7e5fed5b607mr3897049a34.6.1779494050127; Fri, 22 May 2026
 16:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260519201401.1558410-1-zhipingz@meta.com>
 <20260519201401.1558410-2-zhipingz@meta.com>
 <20260521160412.4fa75406@shazbot.org>
In-Reply-To: <20260521160412.4fa75406@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Fri, 22 May 2026 16:53:59 -0700
X-Gm-Features: AVHnY4Kei3lLPfGxalIVqJuqv9pOsHiferZdcWI224JMky8geVIn4yYyhSSh2jY
Message-ID: <CAH3zFs0ZUpHnc2WdyoLQBKuHRVDPNZDO6Zay-caW82Qk5ej+nw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] vfio: add dma-buf get_tph callback and DMA_BUF_TPH
 feature
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=daewG3Xe c=1 sm=1 tr=0 ts=6a10eca3 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=iTjJCpD9-klLVKPjRfgA:9 a=QEXdDO2ut3YA:10
 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: L9stqOHys3uxfS1jf_vqp7LgQdkJXsuG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIzOSBTYWx0ZWRfXzflYlNzpRz8Q
 pHD970Yu3RDbLSzCeptKRPwziZm2+aQKEiwsDx89NyBz65p+x4tWJ5zBeJNuHuHxTRPuHPSf2d1
 bTQAMFqOtbTG4dO0N0+Tv6YA5pZ1c+VHfWrTCdYw+nkfkYvR59oGfj4oVpuTKMOoHu7QXCB4JKN
 lNMkyqAa20GmM5fbZNfyJapm+sSfXAgtTGifhA+Hdkpa3VzvdU6dF8heBQMdwVshH6wDvHfcL+W
 Im6kZEuJFlmFaSsQjlHl+1HUyduOhk5ENJPBmppKFXCDt3tloKu9Ib1C1g2oz2vLHEq/crdaJ6T
 owNqohS+6Ia0dIqe0WqHXEAYRZEU0qFthy1ykfqM+NhsGClFn9ZIIWq8AAYkf22U1K8Z3yxC5GE
 0Jii362bUCrBzigJtumzyGPC+Gz4zrq1aVNURDMG9vd7HFVsLFQp1EtdG8sOaqFbwKDycMinuZZ
 sYFjC2DbG/L1NHUwGmQ==
X-Proofpoint-GUID: L9stqOHys3uxfS1jf_vqp7LgQdkJXsuG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
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

On Thu, May 21, 2026 at 3:04=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Tue, 19 May 2026 13:13:49 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Add a dma-buf get_tph callback for exporters to return TPH
> > (TLP Processing Hints) metadata, and add VFIO_DEVICE_FEATURE_DMA_BUF_TPH
> > so userspace can attach that metadata to a VFIO-exported dma-buf.
>
> This should be two patches, the first extending the dma-buf framework
> for the get_tph callback for explicit approval from dma-buf maintainers
> (who are not even copied here).  The second the vfio-pci implementation
> of get_tph.

Agreed, let me split. v5 will have:
    1/2 dma-buf: add optional get_tph() callback
    2/2 vfio/pci: implement get_tph and VFIO_DEVICE_FEATURE_DMA_BUF_TPH
I will also add Sumit Semwal and Christian K=C3=B6nig, the dma-buf maintain=
ers.

>
> > 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> > uAPI carries both with explicit validity flags so importers get the
> > value matching their requested width. SET is write-once per dma-buf;
> > the existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI is unchanged.
>
> I didn't see what motivated this write-once change, I thought we
> understood that it was a userspace problem that the tph values need to
> be set before providing the dma-buf fd to the importer and that races
> relative to that are a userspace ordering problem.  Write-once seems
> unnecessarily restrictive and there's no justification provided here.

Got it, yes the "set TPH before handing the fd to the importer" contract is=
 a
userspace ordering problem. I'll drop write-once. I'll allow SET to
overwrite and
document the ordering requirement in the uAPI comment instead.

>
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c   |   3 +
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 134 +++++++++++++++++++++++++++--
> >  drivers/vfio/pci/vfio_pci_priv.h   |  12 +++
> >  include/linux/dma-buf.h            |  21 +++++
> >  include/uapi/linux/vfio.h          |  35 ++++++++
> >  5 files changed, 198 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_p=
ci_core.c
> > index 3f8d093aacf8..94aa6dd95701 100644
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
> > index f87fd32e4a01..be1c65385670 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -19,7 +19,24 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > -     u8 revoked : 1;
> > +     /*
> > +      * TPH metadata published by VFIO_DEVICE_FEATURE_DMA_BUF_TPH and
> > +      * consumed by the @get_tph dma-buf callback.
> > +      *
> > +      * @tph_flags is the publish/consume gate: writers populate
> > +      * @steering_tag, @steering_tag_ext and @ph first, then store
> > +      * @tph_flags with smp_store_release(); readers do
> > +      * smp_load_acquire(&tph_flags) before accessing the value fields.
> > +      * @tph_flags =3D=3D 0 means "TPH not set". Writers publish a non=
-zero
> > +      * value only once per dma-buf and serialize via vdev->memory_loc=
k;
> > +      * readers stay lockless to avoid AB-BA against the dma_resv_lock=
 held
> > +      * by importers.
> > +      */
>
> Can you outline the ABBA hazard, I'm not seeing it.  You're acquiring
> memory_lock in the feature SET and dma_resv_lock doesn't appear to be
> held when calling .get_tph().  There's a lot of lockless complication
> here balanced on this claim of avoiding a hazard that doesn't appear
> present.

You're right: the release/acquire scheme is solving a problem that
doesn't exist.
v5 will drop it; see the reply to your follow-up for the replacement.

>
> > +     u32 tph_flags;
> > +     u16 steering_tag_ext;
> > +     u8 steering_tag;
> > +     u8 ph;
> > +     bool revoked;
>
> If we still used memory_lock for tph, these could be:
>
>         u8 tph_st_valid:1; /* memory_lock */
>         u8 tph_st_ext_valid:1; /* memory_lock */
>         u8 tph_ph:2; /* memory_lock */
>         u8 tph_st;
>         u16 tph_st_ext;
>         u8 revoked:1; /* dma_resv_lock */
>
> The existing change of @revoked from bitfield to bool has no rationale
> noted for it in the commit log.

Will adopt the bitfield layout you suggested in v5, with the lock annotatio=
ns.

>
> >  };
> >
> >  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> > @@ -69,6 +86,36 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *atta=
chment,
> >       return ret;
> >  }
> >
> > +static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steer=
ing_tag,
> > +                                 u8 *ph, u8 st_width)
> > +{
> > +     struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
> > +     u32 flags;
> > +
> > +     /* Pair with the smp_store_release() in VFIO_DEVICE_FEATURE_DMA_B=
UF_TPH. */
> > +     flags =3D smp_load_acquire(&priv->tph_flags);
> > +     if (!flags)
> > +             return -EOPNOTSUPP;
> > +
> > +     switch (st_width) {
> > +     case 8:
> > +             if (!(flags & VFIO_DMA_BUF_TPH_ST))
> > +                     return -EOPNOTSUPP;
> > +             *steering_tag =3D priv->steering_tag;
> > +             break;
> > +     case 16:
> > +             if (!(flags & VFIO_DMA_BUF_TPH_ST_EXT))
> > +                     return -EOPNOTSUPP;
> > +             *steering_tag =3D priv->steering_tag_ext;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     *ph =3D priv->ph;
> > +     return 0;
> > +}
> > +
> >  static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachme=
nt,
> >                                  struct sg_table *sgt,
> >                                  enum dma_data_direction dir)
> > @@ -84,16 +131,17 @@ static void vfio_pci_dma_buf_unmap(struct dma_buf_=
attachment *attachment,
> >  static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
> >  {
> >       struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
> > +     struct vfio_pci_core_device *vdev =3D READ_ONCE(priv->vdev);
> >
> >       /*
> >        * Either this or vfio_pci_dma_buf_cleanup() will remove from the=
 list.
> >        * The refcount prevents both.
> >        */
> > -     if (priv->vdev) {
> > -             down_write(&priv->vdev->memory_lock);
> > +     if (vdev) {
> > +             down_write(&vdev->memory_lock);
> >               list_del_init(&priv->dmabufs_elm);
> > -             up_write(&priv->vdev->memory_lock);
> > -             vfio_device_put_registration(&priv->vdev->vdev);
> > +             up_write(&vdev->memory_lock);
> > +             vfio_device_put_registration(&vdev->vdev);
> >       }
> >       kfree(priv->phys_vec);
> >       kfree(priv);
>
>
> This seems unnecessary.  I think this is just because priv->vdev is now
> (unnecessarily) set via WRITE_ONCE, right?  These are very well ordered
> paths, prior to exposing the dma-buf, while the device is opened, during
> release, after release. They don't seem to need the READ/WRITE_ONCE
> treatment.  This looks like noise from trying to make it lockless.

Got it, this is fallout from the lockless attempt. priv->vdev
transitions are already
well-ordered by memory_lock. I'll drop all the READ_ONCE/WRITE_ONCE on
priv->vdev in v5 and leave the existing accesses as they were.

>
>
> > @@ -101,6 +149,7 @@ static void vfio_pci_dma_buf_release(struct dma_buf=
 *dmabuf)
> >
> >  static const struct dma_buf_ops vfio_pci_dmabuf_ops =3D {
> >       .attach =3D vfio_pci_dma_buf_attach,
> > +     .get_tph =3D vfio_pci_dma_buf_get_tph,
> >       .map_dma_buf =3D vfio_pci_dma_buf_map,
> >       .unmap_dma_buf =3D vfio_pci_dma_buf_unmap,
> >       .release =3D vfio_pci_dma_buf_release,
> > @@ -269,7 +318,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_c=
ore_device *vdev, u32 flags,
> >               goto err_free_priv;
> >       }
> >
> > -     priv->vdev =3D vdev;
> > +     WRITE_ONCE(priv->vdev, vdev);
> >       priv->nr_ranges =3D get_dma_buf.nr_ranges;
> >       priv->size =3D length;
> >       ret =3D vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
> > @@ -331,6 +380,77 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_=
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
> > +     if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_E=
XT))
> > +             return -EINVAL;
> > +
> > +     if (!set_tph.flags)
> > +             return -EINVAL;
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
> > +     down_write(&vdev->memory_lock);
> > +     if (READ_ONCE(priv->vdev) !=3D vdev) {
> > +             ret =3D -EINVAL;
> > +             goto out_unlock;
> > +     }
> > +
> > +     /*
> > +      * TPH metadata is write-once per dma-buf so that lockless reader=
s only
> > +      * have to observe a single release-published transition from 0 -=
> flags.
> > +      */
> > +     if (READ_ONCE(priv->tph_flags)) {
> > +             ret =3D -EBUSY;
> > +             goto out_unlock;
> > +     }
> > +
> > +     priv->steering_tag =3D set_tph.steering_tag;
> > +     priv->steering_tag_ext =3D set_tph.steering_tag_ext;
> > +     priv->ph =3D set_tph.ph;
> > +     /*
> > +      * Publish the TPH values before the gate flag, so that lockless
> > +      * readers in vfio_pci_dma_buf_get_tph() see fully-initialized
> > +      * fields once they observe a non-zero tph_flags.
> > +      */
> > +     smp_store_release(&priv->tph_flags, set_tph.flags);
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
> > @@ -388,7 +508,7 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_=
device *vdev)
> >
> >               dma_resv_lock(priv->dmabuf->resv, NULL);
> >               list_del_init(&priv->dmabufs_elm);
> > -             priv->vdev =3D NULL;
> > +             WRITE_ONCE(priv->vdev, NULL);
> >               priv->revoked =3D true;
> >               dma_buf_invalidate_mappings(priv->dmabuf);
> >               dma_resv_wait_timeout(priv->dmabuf->resv,
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
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index d1203da56fc5..49eb6ad644a2 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -113,6 +113,27 @@ struct dma_buf_ops {
> >        */
> >       void (*unpin)(struct dma_buf_attachment *attach);
> >
> > +     /**
> > +      * @get_tph:
> > +      * @dmabuf: DMA buffer for which to retrieve TPH metadata
> > +      * @steering_tag: Returns the raw TPH steering tag for @st_width
> > +      * @ph: Returns the TPH processing hint (2-bit value)
> > +      * @st_width: Consumer's supported steering tag width in bits (8 =
or 16)
> > +      *
> > +      * Return the TPH (TLP Processing Hints) metadata associated with=
 this
> > +      * DMA buffer for the requested steering-tag width. 8-bit ST and =
16-bit
> > +      * Extended ST are distinct namespaces in the PCIe TPH ST table a=
nd may
> > +      * both be present with different values, so the exporter must se=
lect the
> > +      * value that matches @st_width and must not substitute one for t=
he other.
> > +      *
> > +      * Return 0 on success, -EOPNOTSUPP if no metadata is available f=
or the
> > +      * requested width, or -EINVAL if @st_width is not 8 or 16.
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
> > index 5de618a3a5ee..a9cb6cbc6ade 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1534,6 +1534,41 @@ struct vfio_device_feature_dma_buf {
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
> > + * The user must set TPH on the dma-buf before the importer consumes i=
t.
> > + * TPH metadata is write-once per dma-buf; a second SET returns -EBUSY.
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
> > +     __u16   steering_tag_ext;
> > +};
>
> Sure is tempting to make the ph field the first 2-bits of u8 flags.

I went back and worked through the layout both ways and I'd actually
like to keep ph as
its own field. I think the separate ph field reads better and costs nothing.

> Thanks,
>
> Alex

Thanks,
Zhiping

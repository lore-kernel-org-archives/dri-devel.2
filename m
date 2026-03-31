Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AB0FF60D9
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 07:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE98210E890;
	Tue, 31 Mar 2026 07:23:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="hmtSJqlW";
	dkim-atps=neutral
X-Greylist: delayed 731 seconds by postgrey-1.36 at gabe;
 Tue, 31 Mar 2026 01:02:13 UTC
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B216A10E12A
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 01:02:13 +0000 (UTC)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
 by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 62UIaFlk2874382
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 17:50:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=G9PUQuU9Xd7OgZlLFFg33R8o/sQFjvSbJ31P2p7vH2c=; b=hmtSJqlWLivr
 FpTCzdmZ1sdgK0lw6T1On9MlFTNr/uNvKi/cXLpsRpNesknsvaBMgIL79u+XmQ4X
 OvONh8klorX+4pLd8y8kkhUDUQTnOoHsKZW+iV8xX7MGNxRD5b2L9dy2O8krlqFT
 T4CSD5bI4B7RrT4qwqBKOb4ybQ//NBf86XefGKXCzg+XsF/ie0yV8UBASZD+WhiY
 gHfb9ugRF/OC6V2rmi2H21Z8NJ7kJVUQ3wl8TD8HczsB5w6HeFYEojFVp/BfWvYQ
 hI+l07YKBq3lwSAlJXh0h1OGR0o8bpFCEz5x3yz03g+scWTCs0skkJpFTqyKTDiT
 LC6Prj3gjA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by m0089730.ppops.net (PPS) with ESMTPS id 4d6xvm9en8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 17:50:01 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7d7f7164b12so12470485a34.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 17:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774918200; cv=none;
 d=google.com; s=arc-20240605;
 b=aMuomMdy/zRpHi7gleH0FYgpyaRo8hNV66UV//L2u/bRLlp3XELkBbb4SyjqIDoNmP
 QqLQ+ZYKd+37eD08VLjNvL9WNgBOO6tJTBH4CQfAF41l2vf0IVZp0fsNRyAast3CWfAq
 s9v1MGyNPBOYbEtox/wxRTo2yPfxcEerBriWeoosUGT0OGIb2DG6cNReDj/OAVV72XUA
 4zX+u1pZZbLfjs9Tow5bqhgopiT6E1O5g/o4dShoxTek1qqtD2amcTK6kh4P9fixxQ0B
 6Yi7PGekTDNNjxUwlRtm2j/MqBNEqyTYwQW98KC6vv3CG0ECMUmQ5ZbXkskX8KIMspTn
 Otww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=TOfgVd4WxlQKE+hK9yudL6ZnSayBQl5VVP5wHI64dXg=;
 fh=LD1RrZkhORGRVcqdV0/4McCqZZeDhVCJLD2A+N+PbVM=;
 b=fwezve+4DqYhBGlNCfzZh+hxFzJHrgiApspUpF2W3m6YuhFn0plwagabnEOX8Kn2d+
 L4Np8oVJ+CR4lLHCmEStMPqlCwQJAe5xVzdZDklQ9OJx3K8LFSq/5D5hvPwHuw9ut+0Q
 D3QIOv70EMOlC0Ab+1EA/GkVeuoCZBXYKqXMejpy9qhNWM91379ZHU7RkHUIJhBKMAxa
 lbOvPQSjE8SemEsoAar6D5cKfFs0ORUUf4wKd9WKpvWB7wqqrYtLqMnBpT/pvBF/jS9Z
 vyYBoknglblS+pEWKQVlaEF1cIKPAeT2R207wbGVIQDIchroNpzxTvHH1grQw4OyNvk0
 cySg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774918200; x=1775523000;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TOfgVd4WxlQKE+hK9yudL6ZnSayBQl5VVP5wHI64dXg=;
 b=jYXXuSwx4m+GHSlt0U4RehCOG9Bxrb7CUYSsstZrF/KJzGRAyL4gxd0jub9MTUqFT6
 ZX1Kf13Nr+dLribMTcJJGwv/WjppJf2CzNy9FH9LJc1NSAXYw25rJUeCDQdm+PTxpiVz
 OwgoVlC8sDA77mnosO3bm42Gqs+9C6Uh1+PDbKrqkw4VAEi9Qryfw4jJWVM/8D5/aajp
 45KBZVuTD2g64LPwPL/7S2uQifOk0IeDPikwVr7jZsjqgs+JIbGL5z8nNs12SXz9nXfJ
 kRvH38fZREZzrmjHgkLL789AGfBwqnkUebvSjAN2TPwrpPTsjUISfugULDLRHRxjK0Q8
 lsDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsdEyQhGwK8dKbnEOBal1jN7cvcVMbCsA2DX3wSiT3Sd6AgBPXUe6O3tZJY4ADVspZQP8WMHHkKDM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzq3Me+kcFVtRlOlpM/vsChT9FHgS/RA2xVLjOSus5stlNVYld2
 sprf0xsB07rs0ZTS5pXH0S6+bib0jwV7tCsg/lQCEXwX2SDp3ThD3ZzMer7KI0YdNYEGCjFCRqh
 3z7mignv7Qo2AmEKgql2wZa9gyfkpqVLvWla8p3SR3c09iG4XyOVGtU3M89QTACNyFRltefpnJ/
 xq59nS8Q+NRqYDvRU150gWUtwAkTc8R1aoGa9PfjAygIg=
X-Gm-Gg: ATEYQzzHwZfMYIGDz4/Wop5J2tF/CIXOmg8ZLwPj4wDJyJGHX/Yb1QdW64hdUNguv3G
 K5Nb+3OBo2HnwjHCTUGXHHvKEN/m2VyYiiu/mqmDJoI9irXLsulCI2oUMyOWXjA9Fdcf6gbd4v7
 A2JpEBlVVdoal9JWEmd1+RorhH/xj7txZFE7bMfPiGBUs3xLoKYQhorl44W3yK+FkxEnme4lfuR
 H3Yg/KtDnQZ5J5d0Tc=
X-Received: by 2002:a05:6830:6d4f:b0:7d7:d4ee:c02d with SMTP id
 46e09a7af769-7d9faebd4e9mr8218634a34.21.1774918200516; 
 Mon, 30 Mar 2026 17:50:00 -0700 (PDT)
X-Received: by 2002:a05:6830:6d4f:b0:7d7:d4ee:c02d with SMTP id
 46e09a7af769-7d9faebd4e9mr8218613a34.21.1774918200006; Mon, 30 Mar 2026
 17:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260324234615.3731237-1-zhipingz@meta.com>
 <20260324234615.3731237-2-zhipingz@meta.com>
 <04859df4-6fa4-4b2b-aef1-621f3c053c2e@huawei.com>
In-Reply-To: <04859df4-6fa4-4b2b-aef1-621f3c053c2e@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 30 Mar 2026 17:49:49 -0700
X-Gm-Features: AQROBzDnJHaZAUclxmUw4Fi3GhjHKGCAE6QyCPHZcIf2necy4jORB1gzd3l2wJA
Message-ID: <CAH3zFs2ia80jkLRTUdExd4wQM4tK_FSgGTgZumDWpL-gjoDERg@mail.gmail.com>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
To: fengchengwen <fengchengwen@huawei.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Keith Busch <kbusch@kernel.org>,
 Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDAwNSBTYWx0ZWRfX6L8AslTvI8oT
 +dnckGmpkr52pxlQGtkU6THEfhXWjvILw5picDVjvO5O01QSup68Ws8kwmPF8iCtLTkuQIho2y/
 CnmvsUdqgKR9eRrCm4QrLziGy7uSUN04N3xP3q5aZpCWAb3G0jwsQeCnFpK97WEHqmaqT/YZ5j1
 X1RByRzN6buVwGBwmZ6mDmE7Zw3aTIoy7g6bMLfvvoaJSjIaznuEX49i6TEkqjCvc+8Up6HrXdm
 7UfS53d35Jk/bE6L6O69I/tl1OXKt1NMHDL8Eht8qX+bvE9COCN4E0ii9121C2tGzByz1WF04zK
 5QbbrFyhiuPQ+fWNuQ18D43GGJrM8zIA1uiO0GPcNogwrRE7FpQh7TZkYOiyQjEZN8uB8YIAVHR
 G5knvD+i2Q9NIl3mX3W+H8Hmamf+8YgYYhnMR8PtU/VhSNhfkn1IYBItvVu+oXXHp3xqV+zzPtP
 7S0zdFu1IDIUmpjI/cw==
X-Authority-Analysis: v=2.4 cv=StadKfO0 c=1 sm=1 tr=0 ts=69cb1a39 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=i0EeH86SAAAA:8 a=VabnemYjAAAA:8 a=o_g7sp7U41fvUp2KB-EA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: -kj7dElhI3pRDBRxh4jXiqSErDYPS7Ca
X-Proofpoint-GUID: -kj7dElhI3pRDBRxh4jXiqSErDYPS7Ca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_02,2026-03-28_01,2025-10-01_01
X-Mailman-Approved-At: Tue, 31 Mar 2026 07:23:33 +0000
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

On Fri, Mar 27, 2026 at 7:22=E2=80=AFPM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> Hi Zhiping,
>
> On 3/25/2026 7:46 AM, Zhiping Zhang wrote:
> > This patch adds a callback to get the tph info on DMA buffer exporters.
> > The tph info includes both the steering tag and the process hint (ph).
> >
> > The steering tag and ph are encoded in the flags field of
> > vfio_device_feature_dma_buf instead of adding new fields to the uapi
> > struct, to preserve ABI compatibility.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 26 ++++++++++++++++++++++++--
> >  include/linux/dma-buf.h            | 30 ++++++++++++++++++++++++++++++
> >  include/uapi/linux/vfio.h          |  9 +++++++--
> >  3 files changed, 61 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio=
_pci_dmabuf.c
> > index 478beafc6ac3..c45cb3884b85 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -17,6 +17,8 @@ struct vfio_pci_dma_buf {
> >       struct phys_vec *phys_vec;
> >       struct p2pdma_provider *provider;
> >       u32 nr_ranges;
> > +     u16 steering_tag;
> > +     u8 ph;
> >       u8 revoked : 1;
> >  };
> >
> > @@ -60,6 +62,15 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *atta=
chment,
> >                                      priv->size, dir);
> >  }
> >
> > +static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steer=
ing_tag,
> > +                                 u8 *ph)
> > +{
> > +     struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
> > +     *steering_tag =3D priv->steering_tag;
> > +     *ph =3D priv->ph;
>
> If the dmabuf exporter don't provide st&ph, this ops should return error

That is a good call, let me address that in the new revision.

>
> > +     return 0;
> > +}
> > +
> >  static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachme=
nt,
> >                                  struct sg_table *sgt,
> >                                  enum dma_data_direction dir)
> > @@ -90,6 +101,7 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops =
=3D {
> >       .unpin =3D vfio_pci_dma_buf_unpin,
> >       .attach =3D vfio_pci_dma_buf_attach,
> >       .map_dma_buf =3D vfio_pci_dma_buf_map,
> > +     .get_tph =3D vfio_pci_dma_buf_get_tph,
> >       .unmap_dma_buf =3D vfio_pci_dma_buf_unmap,
> >       .release =3D vfio_pci_dma_buf_release,
> >  };
> > @@ -228,7 +240,10 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_=
core_device *vdev, u32 flags,
> >       if (copy_from_user(&get_dma_buf, arg, sizeof(get_dma_buf)))
> >               return -EFAULT;
> >
> > -     if (!get_dma_buf.nr_ranges || get_dma_buf.flags)
> > +     if (!get_dma_buf.nr_ranges ||
> > +         (get_dma_buf.flags & ~(VFIO_DMABUF_FL_TPH |
> > +                                VFIO_DMABUF_TPH_PH_MASK |
> > +                                VFIO_DMABUF_TPH_ST_MASK)))
> >               return -EINVAL;
> >
> >       /*
> > @@ -285,7 +300,14 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_=
core_device *vdev, u32 flags,
> >               ret =3D PTR_ERR(priv->dmabuf);
> >               goto err_dev_put;
> >       }
> > -
> > +     if (get_dma_buf.flags & VFIO_DMABUF_FL_TPH) {
> > +             priv->steering_tag =3D (get_dma_buf.flags &
> > +                                   VFIO_DMABUF_TPH_ST_MASK) >>
> > +                                  VFIO_DMABUF_TPH_ST_SHIFT;
> > +             priv->ph =3D (get_dma_buf.flags &
> > +                         VFIO_DMABUF_TPH_PH_MASK) >>
> > +                        VFIO_DMABUF_TPH_PH_SHIFT;
> > +     }
> >       /* dma_buf_put() now frees priv */
> >       INIT_LIST_HEAD(&priv->dmabufs_elm);
> >       down_write(&vdev->memory_lock);
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index 133b9e637b55..26705c83ad80 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -113,6 +113,36 @@ struct dma_buf_ops {
> >        */
> >       void (*unpin)(struct dma_buf_attachment *attach);
> >
> > +     /**
> > +      * @get_tph:
> > +      *
> > +      * Get the TPH (TLP Processing Hints) for this DMA buffer.
> > +      *
> > +      * This callback allows DMA buffer exporters to provide TPH inclu=
ding
> > +      * both the steering tag and the process hints (ph), which can be=
 used
> > +      * to optimize peer-to-peer (P2P) memory access. The TPH info is =
typically
> > +      * used in scenarios where:
> > +      * - A PCIe device (e.g., RDMA NIC) needs to access memory on ano=
ther
> > +      *   PCIe device (e.g., GPU),
> > +      * - The system supports TPH and can use steering tags / ph to op=
timize
> > +      *   cache placement and memory access patterns,
> > +      * - The memory is exported via DMABUF for cross-device sharing.
> > +      *
> > +      * @dmabuf: [in] The DMA buffer for which to retrieve TPH
> > +      * @steering_tag: [out] Pointer to store the 16-bit TPH steering =
tag value
> > +      * @ph: [out] Pointer to store the 8-bit TPH processing-hint value
> > +      *
> > +      * Returns:
> > +      * * 0 - Success, steering tag stored in @steering_tag
> > +      * * -EOPNOTSUPP - TPH steering tags not supported for this buffer
> > +      * * -EINVAL - Invalid parameters
> > +      *
> > +      * This callback is optional. If not implemented, the buffer does=
 not
> > +      * support TPH.
>
> It seemed already impl...

Yup, it's supposed to be implemented.

>
> > +      *
> > +      */
> > +     int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *ph);
> > +
> >       /**
> >        * @map_dma_buf:
> >        *
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index bb7b89330d35..e2a8962641d2 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1505,8 +1505,13 @@ struct vfio_region_dma_range {
> >  struct vfio_device_feature_dma_buf {
> >       __u32   region_index;
> >       __u32   open_flags;
> > -     __u32   flags;
> > -     __u32   nr_ranges;
> > +     __u32   flags;
> > +#define VFIO_DMABUF_FL_TPH           (1U << 0) /* TPH info is present =
*/
> > +#define VFIO_DMABUF_TPH_PH_SHIFT     1         /* bits 1-2: PH (2-bit)=
 */
> > +#define VFIO_DMABUF_TPH_PH_MASK      0x6U
> > +#define VFIO_DMABUF_TPH_ST_SHIFT     16        /* bits 16-31: steering=
 tag */
> > +#define VFIO_DMABUF_TPH_ST_MASK              0xffff0000U
> > +     __u32   nr_ranges;
> >       struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
> >  };
>
> Another question:
> 1\ PCIE protocol define 8bit and 16bit ST
> 2\ In host-device ST impl, the ACPI will provide 8bit and 16bit ST, the c=
hoice of which
>    one to use depends on the minimum supported range of the device and th=
e RP.
> 3\ So in this P2P scene, although exporter (e.g. GPU) support 16bit ST, b=
ut the consumer
>    (e.g. RDMA NIC) only support 8bit this may lead to mis-match
>

Hmm, let me check how we can address this mis-match issue. One option
is to add an
additional parameter and fail the get_tph call when a mis-match is found.

> >
> > --
> > 2.52.0
> >
> >
> >
>

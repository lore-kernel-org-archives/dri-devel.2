Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012CECD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 05:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 604DF10EC63;
	Thu, 28 May 2026 05:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="tbSbpLMQ";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD7B510EC63
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 05:55:08 +0000 (UTC)
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKjRbA826791
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 22:55:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=fCWJk+yJSEw0QmMgTgm6c5hQ8WDFshVgdpTjabTs05U=; b=tbSbpLMQe9V1
 fRrJsZLmCEINOnKwTwP24JHLpfkIKwEepx/Dh3tfucJeXjyBmxUl4K+3pzS40lhe
 Vk0KGeyW3V3XwtowE8EShojrRZa6LzLLYzZHk0cQiurg9iLcff5bt/+GGIVjUhJg
 GS2yjzLlbBm1Fz4V9mfBh9ZrCRYNbh87Q2e58QbU0kZl0LslSz8HIGX1FN2WqmJn
 V6u86OtEtfnMzSmkk0ZLjfBzjM5sNOAWRA7g+AaUWdIpOcgd0eCkAao9PZ/W168l
 EQ62MMb9iFTIqzogr6WSS9W4iYEsdvQL/qDgcEewoSbDNuHTRvFxM9ZwvkmAy0OU
 GhfeODKKwA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x8je8f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 22:55:07 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7e6691e48b7so3115346a34.2
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 22:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779947707; cv=none;
 d=google.com; s=arc-20240605;
 b=g63FIxMgL2caWp0hwPFXeAqpkKEPudrT5DHbN6/TCK1UxXIbwGH6gD1Y146CqdvMtg
 ZXT9Vinkr/hqOw2Fe8yIgfO+YH0Rd7eebskaRlZZoQQyq4zKjr3RBtcyF6bT8XYtMniw
 JecigfvzwTgcKcCkh62lG/9Wzsuk0RoWRVb7jaiCwWrYkJAkhG8neASk4teSwHtVrmth
 ao+ndB9M6iYVjtkK8VyZK3HYLD2pZ3NJ/5FA8/uufp1napz4BAGgNYFQx3c73MrPNCQr
 SLT+G/Dk0d7U3Bth3KzYH8zw3KTGeqGWXVs1u86UYuzbCmFNmMTaBMy8Gb5nWMO0V3a7
 BEzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=7OjunUEtjbIoqlgaeDvI71z7AvyuDzMU0DogPcHFH+E=;
 fh=bnTyshZvO1jZqqqfJiw75TZH9MkIfO5FLB2fxlKqDVw=;
 b=K2X1GVNRvOif0lcoNiawvXg3wNzQZXYAnRLfzWKUVmxFjfOxLVX7gtpetX4oPJKoBj
 mOvk6kdOygEYbdU1baYYtRThnSIK36pfYMKVAwEx2ikLM+3Y1yGeOmNe69cWq3RfFRNA
 l41a+yiAwdF/yx0oiyTQVh4HANLUQqmEclumukby8/mkAaQjiUwJVeUcZXNgOz8hxEgU
 PchJ4yfV8A40EAzLz4LG0dOhLoHR0d4EiXPb5fV4eVV3BI/3KPRex7FjTDtpqwVZwVrR
 oYorEwW8ILolswVhlLpNNijgv/36rQ2F6KUDBJzr6c0l4Zb8JZft/X08dGxKnhuc7MnT
 oTyw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779947707; x=1780552507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7OjunUEtjbIoqlgaeDvI71z7AvyuDzMU0DogPcHFH+E=;
 b=b40sIJy7tAnw1K4w5+bc5IYkPsDYoH9AqWF7wSvsEfaurX0/oTamEZIkd3QalT3Vzj
 pbYSewlh0Ahb8w/BPOw39jCVz/7orbW2XeYuz7C4n9W4JVP2RVLx8Ie60KjhomZYtaqH
 p0vmOA38UdEMLdP7zBU6TvcI3NoajLDJ3NM7gZiSPTnXjoI+PLgT2LwEy4zgNC+jRnup
 1kafq8X47IMaNn9R6v8Uk0W+EJHQvBd/+fSVlu/nqREMVhpxV9a60edI+qgFXIr0Ybqs
 ZwtXJLoeohN+Nsi0hMY2MynEGqweiaeQllXW8pldz6BsP3w6tBVXcSBem9Igpzac1FsL
 pdzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Sw5VXKmH8xbogpB+fNOflLmt6DPnZgaEU7WShNJcikjx/JBeubFaeNSqFgExYVdeE6bjDv4t0ox8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzxQ3KzswBxR7fCNcieEfBRKpfIIR5Y888PXwOUHaXHhzKOEkUk
 tPq0ya8Ugdwu8iy662O0khsOBRK5IXIaYVUWrzn8lMCVOGjVh0QKoio63i6aOi/wD4TETTs3c57
 irvr6eVDN/avgMHCGEl6oUjbWbctGZa3jHiyVK2+6TkhpscxtJqWqMbmpyy3a1d06eInky3XZnU
 q5DRrzqGLj6Ba4QxihQ9rZZvtzZ5Su+oK/aij0+qPDsTw=
X-Gm-Gg: Acq92OGrJpXEtcP2/NYXkLN7YHj1acOUnk3lCMWf3yMD7LCigu/SX0sc+F0gWZyfShr
 waAf5S76+mbcEhqFDMUzhsN7u+lFR4HfuFGeoXs1KaorCcsOi5i7uZQiHHCWhN6B/Hq2whYr8LH
 tJp76NK6Z2u4g8QsxZKa1SAw/oJmOPE+x+/8V+2BsREjFSP2zXn0HsJkklPpWbQdsUF6VpGyDS9
 6nQwxQx3kqF/mzeVbKoa3dj3+oyQnjL+K+GqNVw5+29VSf5t84=
X-Received: by 2002:a05:6830:6d4d:b0:7d7:f158:1f44 with SMTP id
 46e09a7af769-7e5feef5d68mr16377933a34.21.1779947706913; 
 Wed, 27 May 2026 22:55:06 -0700 (PDT)
X-Received: by 2002:a05:6830:6d4d:b0:7d7:f158:1f44 with SMTP id
 46e09a7af769-7e5feef5d68mr16377893a34.21.1779947706138; Wed, 27 May 2026
 22:55:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <20260526144401.1485788-5-zhipingz@meta.com>
 <20260527130045.704a4502@shazbot.org>
In-Reply-To: <20260527130045.704a4502@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 27 May 2026 22:54:54 -0700
X-Gm-Features: AVHnY4ICjE7MkEm4LXONvDpsmeBdG0UBYV3y_krDxSXZVAQVCJMknB8fJo9QBXs
Message-ID: <CAH3zFs2RuXC06tkg2gBNMLfBuL4FXzu+AV_axEh+ZnzdGCo1XQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
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
X-Proofpoint-GUID: smIRx95_dARCZJDHIDzVfrSPkidNMI-c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA1NiBTYWx0ZWRfXzl70xnv/RoQj
 CCwpfLgyA9SZh5gnOZcbxydgj9FDTRC9BeZggPBrfphDSrBblzurWXeYMHgYB4+70Mo3Rh6DPmm
 Z9DB9z4NQ5N7oZ0O6Jnz3Vr9l32Qz3Srs+B489MNILbg/eEA8D8zmojpLbMja2PauK4wF9yrr6l
 t23sHTnK4/P1tQvUuMwLxF9ueuUUm88W6lLfEOk9jCX1sWzsBnaXSPGbrPoK40VpK9hN10Baxw9
 SE4ARsQVn+bv/m6BACILG8wbvvzqPPC7WBB5xQewDwrrkSRFyzFqSplPz5mMbxxvLlclrvuh1PB
 ocfHKUuZg3GcgRlIgz2Gp7FhtplArJzOfTix7Z16eKepB60thGaaXN57T4rPhaEiufg642jjdVr
 qblkBo3tBDI8u+I5OuDjRJ+s44z3ir62LCosIhftXlfRtv9llKqP8ffPVU2Tcns0AunF7Cl3L+7
 X1wx+LDJ5aap8T2EdpA==
X-Proofpoint-ORIG-GUID: smIRx95_dARCZJDHIDzVfrSPkidNMI-c
X-Authority-Analysis: v=2.4 cv=PomjqQM3 c=1 sm=1 tr=0 ts=6a17d8bb cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=25xbtWhBidXVKMBX-WEA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
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

On Wed, May 27, 2026 at 12:00=E2=80=AFPM Alex Williamson <alex@shazbot.org>=
 wrote:
>
> >
> On Tue, 26 May 2026 07:43:56 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Query dma-buf TPH metadata when registering a dma-buf MR for peer-to-
> > peer access and translate the returned steering tag into an mlx5 ST
> > index. Keep the DMAH path as the first priority and only fall back to
> > DMA-buf metadata when no DMAH is supplied.
> >
> > Track per-MR ownership of the allocated ST index and release it on MR
> > setup failure, destroy, and FRMR-pool reuse. Release the ST index before
> > the MR is pushed back into the FRMR pool, and free mlx5_st_idx_data when
> > its refcount reaches zero so repeated allocation/deallocation does not
> > leak memory.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  6 ++
> >  drivers/infiniband/hw/mlx5/mr.c               | 86 ++++++++++++++++++-
> >  .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 28 ++++--
> >  include/linux/mlx5/driver.h                   |  7 ++
> >  4 files changed, 115 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/=
hw/mlx5/mlx5_ib.h
> > index e156dc4d7529..4ab867392267 100644
> > --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > @@ -721,6 +721,12 @@ struct mlx5_ib_mr {
> >                       u8 revoked :1;
> >                       /* Indicates previous dmabuf page fault occurred =
*/
> >                       u8 dmabuf_faulted:1;
> > +                     /* Set when the MR owns dmabuf_st_index and must
> > +                      * release it via mlx5_st_dealloc_index() once the
> > +                      * firmware mkey is no longer referencing it.
> > +                      */
> > +                     u8 dmabuf_st_owned:1;
> > +                     u16 dmabuf_st_index;
> >                       struct mlx5_ib_mkey null_mmkey;
> >               };
> >       };
> > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/ml=
x5/mr.c
> > index 3b6da45061a5..8059b5e4da97 100644
> > --- a/drivers/infiniband/hw/mlx5/mr.c
> > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > @@ -38,6 +38,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/dma-buf.h>
> >  #include <linux/dma-resv.h>
> > +#include <linux/pci-tph.h>
> >  #include <rdma/frmr_pools.h>
> >  #include <rdma/ib_umem_odp.h>
> >  #include "dm.h"
> > @@ -46,6 +47,8 @@
> >  #include "data_direct.h"
> >  #include "dmah.h"
> >
> > +MODULE_IMPORT_NS("DMA_BUF");
> > +
>
> This doesn't appear to add any dma-buf namespace dependencies.
>

sure let me check and drop if not necessary.

> >  static int mkey_max_umr_order(struct mlx5_ib_dev *dev)
> >  {
> >       if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
> > @@ -899,6 +902,63 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_at=
tach_ops =3D {
> >       .invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
> >  };
> >
> > +/*
> > + * Query TPH metadata from @dmabuf and translate the raw steering tag =
into
> > + * an mlx5 ST index. On success, returns 0 and the caller becomes the
> > + * owner of *@st_index (must be released with mlx5_st_dealloc_index()
> > + * once the firmware mkey no longer references it). On any failure
> > + * *@st_index and *@ph are left as the no-TPH defaults set by the call=
er.
> > + *
> > + * @dmabuf must already be referenced by the caller (e.g. via the umem=
's
> > + * attachment) so we don't re-resolve the user's fd here and avoid a
> > + * dup2() TOCTOU between umem creation and TPH lookup.
> > + */
> > +static void get_tph_mr_dmabuf(struct mlx5_ib_dev *dev, struct dma_buf =
*dmabuf,
> > +                           u16 *st_index, u8 *ph)
> > +{
> > +     u8 req_type;
> > +     u16 steering_tag;
> > +     u8 st_width;
> > +     int ret;
> > +
> > +     if (!dmabuf->ops->get_tph)
> > +             return;
> > +
> > +     req_type =3D pcie_tph_enabled_req_type(dev->mdev->pdev);
> > +     switch (req_type) {
> > +     case PCI_TPH_REQ_TPH_ONLY:
> > +             st_width =3D 8;
> > +             break;
> > +     case PCI_TPH_REQ_EXT_TPH:
> > +             st_width =3D 16;
> > +             break;
> > +     default:
> > +             return;
> > +     }
> > +
> > +     ret =3D dmabuf->ops->get_tph(dmabuf, &steering_tag, ph, st_width);
> > +     if (ret) {
> > +             mlx5_ib_dbg(dev, "get_tph failed (%d)\n", ret);
> > +             *ph =3D MLX5_IB_NO_PH;
> > +             return;
> > +     }
> > +
> > +     ret =3D mlx5_st_alloc_index_by_tag(dev->mdev, steering_tag, st_in=
dex);
> > +     if (ret) {
> > +             *ph =3D MLX5_IB_NO_PH;
> > +             mlx5_ib_dbg(dev, "st_alloc_index_by_tag failed (%d)\n", r=
et);
> > +     }
> > +}
>
> ph handling is inconsistent, why not use a local variable and only set
> the caller's pointer on success?
>

good point -- will do that.

> > +
> > +static void mlx5_ib_mr_put_dmabuf_st(struct mlx5_ib_mr *mr)
> > +{
> > +     if (mr->umem && mr->dmabuf_st_owned) {
> > +             mlx5_st_dealloc_index(mr_to_mdev(mr)->mdev,
> > +                                   mr->dmabuf_st_index);
> > +             mr->dmabuf_st_owned =3D 0;
> > +     }
> > +}
> > +
> >  static struct ib_mr *
> >  reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
> >                  u64 offset, u64 length, u64 virt_addr,
> > @@ -941,16 +1001,26 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct devi=
ce *dma_device,
> >               ph =3D dmah->ph;
> >               if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
> >                       st_index =3D mdmah->st_index;
> > +     } else {
> > +             get_tph_mr_dmabuf(dev, umem_dmabuf->attach->dmabuf,
> > +                               &st_index, &ph);
> >       }
> >
> >       mr =3D alloc_cacheable_mr(pd, &umem_dmabuf->umem, virt_addr,
> >                               access_flags, access_mode,
> >                               st_index, ph);
> >       if (IS_ERR(mr)) {
> > +             if (!dmah && st_index !=3D MLX5_MKC_PCIE_TPH_NO_STEERING_=
TAG_INDEX)
> > +                     mlx5_st_dealloc_index(dev->mdev, st_index);
> >               ib_umem_release(&umem_dmabuf->umem);
> >               return ERR_CAST(mr);
> >       }
> >
> > +     if (!dmah && st_index !=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDE=
X) {
> > +             mr->dmabuf_st_index =3D st_index;
> > +             mr->dmabuf_st_owned =3D 1;
> > +     }
> > +
> >       mlx5_ib_dbg(dev, "mkey 0x%x\n", mr->mmkey.key);
> >
> >       atomic_add(ib_umem_num_pages(mr->umem), &dev->mdev->priv.reg_page=
s);
> > @@ -1377,9 +1447,17 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5=
_ib_mr *mr)
> >       bool is_odp =3D is_odp_mr(mr);
> >       int ret;
> >
> > -     if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr) &&
> > -         !ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
> > -             return 0;
> > +     if (mr->ibmr.frmr.pool && !mlx5_umr_revoke_mr_with_lock(mr)) {
> > +             /*
> > +              * The mkey has been revoked: firmware no longer referenc=
es
> > +              * dmabuf_st_index, so release it before this mr can re-e=
nter
> > +              * the FRMR cache for reuse by another registration.
> > +              */
> > +             mlx5_ib_mr_put_dmabuf_st(mr);
> > +
> > +             if (!ib_frmr_pool_push(mr->ibmr.device, &mr->ibmr))
> > +                     return 0;
> > +     }
> >
> >       if (is_odp)
> >               mutex_lock(&to_ib_umem_odp(mr->umem)->umem_mutex);
> > @@ -1400,6 +1478,8 @@ static int mlx5r_handle_mkey_cleanup(struct mlx5_=
ib_mr *mr)
> >               dma_resv_unlock(
> >                       to_ib_umem_dmabuf(mr->umem)->attach->dmabuf->resv=
);
> >       }
> > +     if (!ret)
> > +             mlx5_ib_mr_put_dmabuf_st(mr);
> >       return ret;
> >  }
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c b/drivers=
/net/ethernet/mellanox/mlx5/core/lib/st.c
> > index 997be91f0a13..8929c17c88bc 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/st.c
> > @@ -29,7 +29,7 @@ struct mlx5_st *mlx5_st_create(struct mlx5_core_dev *=
dev)
> >       u8 direct_mode =3D 0;
> >       u16 num_entries;
> >       u32 tbl_loc;
> > -     int ret;
> > +     int ret =3D 0;
>
> Unnecessary change.
>

ack, will check and revert.

> >
> >       if (!MLX5_CAP_GEN(dev, mkey_pcie_tph))
> >               return NULL;
> > @@ -92,23 +92,18 @@ void mlx5_st_destroy(struct mlx5_core_dev *dev)
> >       kfree(st);
> >  }
> >
> > -int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type m=
em_type,
> > -                     unsigned int cpu_uid, u16 *st_index)
> > +int mlx5_st_alloc_index_by_tag(struct mlx5_core_dev *dev, u16 tag,
> > +                            u16 *st_index)
> >  {
> >       struct mlx5_st_idx_data *idx_data;
> >       struct mlx5_st *st =3D dev->st;
> >       unsigned long index;
> >       u32 xa_id;
> > -     u16 tag;
> > -     int ret;
> > +     int ret =3D 0;
> >
> >       if (!st)
> >               return -EOPNOTSUPP;
> >
> > -     ret =3D pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
> > -     if (ret)
> > -             return ret;
> > -
> >       if (st->direct_mode) {
> >               *st_index =3D tag;
> >               return 0;
> > @@ -152,6 +147,20 @@ int mlx5_st_alloc_index(struct mlx5_core_dev *dev,=
 enum tph_mem_type mem_type,
> >       mutex_unlock(&st->lock);
> >       return ret;
> >  }
> > +EXPORT_SYMBOL_GPL(mlx5_st_alloc_index_by_tag);
> > +
> > +int mlx5_st_alloc_index(struct mlx5_core_dev *dev, enum tph_mem_type m=
em_type,
> > +                     unsigned int cpu_uid, u16 *st_index)
> > +{
> > +     u16 tag;
> > +     int ret;
> > +
> > +     ret =3D pcie_tph_get_cpu_st(dev->pdev, mem_type, cpu_uid, &tag);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return mlx5_st_alloc_index_by_tag(dev, tag, st_index);
> > +}
> >  EXPORT_SYMBOL_GPL(mlx5_st_alloc_index);
> >
> >  int mlx5_st_dealloc_index(struct mlx5_core_dev *dev, u16 st_index)
> > @@ -175,6 +184,7 @@ int mlx5_st_dealloc_index(struct mlx5_core_dev *dev=
, u16 st_index)
> >
> >       if (refcount_dec_and_test(&idx_data->usecount)) {
> >               xa_erase(&st->idx_xa, st_index);
> > +             kfree(idx_data);
> >               /* We leave PCI config space as was before, no mkey will =
refer to it */
> >       }
>
> Should this be pulled out as a fix separate from the feature added
> here?  Thanks,
>
> Alex
>

Yes, will split it out as its own patch.

Thanks,
Zhiping

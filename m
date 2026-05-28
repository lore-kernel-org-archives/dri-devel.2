Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE45CD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 06:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47A6C10EC71;
	Thu, 28 May 2026 06:07:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="ZOFqU3Ho";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A18310EC71
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 06:07:36 +0000 (UTC)
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S5ganD1718674
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 23:07:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=GzyvN6ALmGZhc9sEe0zXVntaZeAULheQgTQ/UjOlmfA=; b=ZOFqU3Hokw+Y
 1tWm8OSAw3VppcsXhCy7NjQiED7GF+zwJ1AY0cTIbpcpdYBGC9llvuLJbd1+8rlL
 AXglm2b6A1JTOk8fAn271XgFKVQJNxo2oeVdhw6YawXARksZ4FY4tBG2ugql/lrl
 OpiEUZkdO9HHKOHR42fEty/p77Y0/ml5/z5VbIqwt1zZ3po1sXwT9rtBHbQ0Yd0z
 OPfICWCY2j6tJ46Bv6NfLAq1xI7tfkCqinN5m/CdB/cWEoFzjnUgH0lExTWRP6QW
 U1M02kqSfyicM6TQnFCDh+VID+oYzzysKR/LHRJ/8h9AQoXwa+/h4ymbOE6Zwdfz
 Cn+zoh4Arg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x1tgnd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 23:07:35 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7e60308f6b9so2964388a34.1
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 23:07:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779948455; cv=none;
 d=google.com; s=arc-20240605;
 b=g/ixy/KV8J5zZoenpm0Ep+haFghRv4OrhVy4CeHxuW2TtCrTkNlnyEj+9AtR8t+6Ok
 XNQESl4eMDTqWoVobi5j4m4wqlBbBX943GQ5b71rQgqlwrYBGXX1PDwU5pAQ5nMfVdRI
 vp4k0FFp9ztyApzd/CEbtNo43Ru6OoHqgEWgRPeGTYCj1PwE6E3BeqNwo9rjJ1MIEj76
 KOxRbzAFVA8GEBlHPiYzslypbk++hLzXWajzyNDjSNOEjd0psTcBkTTCKsv4PIh3Wn9h
 dPNaKyuxSmodafmHYbNtuFgRXq4goIYtdcykGioaGEiY1W53b0lG5jQcRGzKYa6pgOpH
 5VpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=UyukGN55miahfwjIGNs2ZpmYU5zHedrWyyN1uj6F1U8=;
 fh=4UkZl40zQe4UgpFAKN951bkTz/wJ1uMyo23ilFKCTYU=;
 b=Jgd8GtgxdX+nzcNuxXXZT7T3gfVS3HVsgXmzsup9S/jmyb2DxquXvD/2CoTVFfb4VY
 z4EcMiMna3P/kVjxGUKllhmd6g5hETkOaZl/eXc4uKjaXnqwTwrSpIHVhRcga8/Pl82i
 nrcCLvnAl1CPXQrtuvG2qYZeLG9InbFyjVVcz84Pgjz0A89q+DwOXUjycNMCviRejPuv
 Eu6wZ65ug5ahLTvQU43aOd0wf39gsn9f73utDSx0YjKxTElHXYO4lgn8YleFfDrz8YtD
 3/YUQLmwjkYix+udwrbThOvj2cJB+SQpxxXKZ+8CaWbBs52z++W0lI+dHc53olXrRqph
 H3SA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779948455; x=1780553255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UyukGN55miahfwjIGNs2ZpmYU5zHedrWyyN1uj6F1U8=;
 b=a0vL+mgHmjJiTM5Afl9yDLpv/HYV6Ntmn46i8nk/MxNTOYntPcLRjZOloJsDkgYtvy
 9iwQlnfMpm7eC8imSTVznJmPJuhrH+T0L2+5o11Nye/+ef2EwTStCS6ENh6tYIpus/QN
 Ypwt09rnSoo+gDruRh9xBza+9/KsAn9DNWainJVoibzU3wT7k3ALoHmBYZ2dCeHmf6Sm
 AuYssLHPi5oTyqnmV22IkWZ79HRrTXkm7GXUKHU8eWbb864NxkiOvdwRgDBVYQqyBC6L
 rTldR2F5Iq/DHqv3X1yLnOnVDUGE6aqJT8F9pPkeCpT169xLDLt11r6TJFSPklUikDAh
 LJuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mOc2IyKL2l56qAr9VMvi83wVk9umGI7c7b0hvfPNs7WhwSQO4qFE/aEuFtzU8qJox6YVMQbpOO50=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjuHoNNocYPCYU83UZss7VNBjLYzYJSzQIZ9KT5BjzoqrKsZ0M
 3FbdYnapNdiaHund4EyWpISq+guzGp85AvhR+4NDAgDiKmPKG0wdK83TK0wROa9JaB92kdP5WsF
 lifot1h7DHfYWkYe3RebaD+toSCplWLVs13r0eZHFB+dj7f1Fr4g1J+5QGKzV7FEivgLtVMRalA
 wBD0iybsPMHdo6eRbV9JIIg05t6mO0fK6UIIOhuMdyx3g=
X-Gm-Gg: Acq92OENmIv5L8DnZ7yqXP+2cRNBgFMhDdxznbuLSwZ2n/xL06DM4IMVFQpvnbztuNX
 Gia0m+DbIFP13Mdu/Ga1G5gxy/qXJCr91O7WK4xv7LUCKWni7MgF3Dd/G++mlAQvelM3JPXobu8
 IrOn7tKA6v476xm4P9HU//gLH2nBoeU/ENcrubiNle4cWX4Xc+jOsPkRMJr9ysoP1mYVML4Wruh
 txrEurSKrmLExA+E5Ra7r4/5CFdFwohLgjX1v1ui9SDbdV0b28=
X-Received: by 2002:a05:6830:3789:b0:7dc:cdea:7d4 with SMTP id
 46e09a7af769-7e5fed4d4c7mr17428830a34.11.1779948454548; 
 Wed, 27 May 2026 23:07:34 -0700 (PDT)
X-Received: by 2002:a05:6830:3789:b0:7dc:cdea:7d4 with SMTP id
 46e09a7af769-7e5fed4d4c7mr17428818a34.11.1779948454085; Wed, 27 May 2026
 23:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <20260526144401.1485788-5-zhipingz@meta.com>
 <55b57a12-6714-4c51-8ce1-f47c97cfecde@nvidia.com>
In-Reply-To: <55b57a12-6714-4c51-8ce1-f47c97cfecde@nvidia.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 27 May 2026 23:07:23 -0700
X-Gm-Features: AVHnY4K3avPQ8FNE3xy07LlbZrchvRUwd-Dc4i84TnsR6M8GdnFKvihXHQqWEMo
Message-ID: <CAH3zFs27rY5E5q1ybjYf0jjMc_t7NCs6T1dt=1P4io9MOrK5nQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Michael Gur <michaelgur@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=F4NnsKhN c=1 sm=1 tr=0 ts=6a17dba7 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=Ikd4Dj_1AAAA:8 a=VabnemYjAAAA:8 a=rnG5qNUxfvSO4QYeIecA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: s79-QKJnFLxDrXTIX1L5ZsHJf4oLBY3p
X-Proofpoint-ORIG-GUID: s79-QKJnFLxDrXTIX1L5ZsHJf4oLBY3p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA1OCBTYWx0ZWRfX2Md1mKCaYWh6
 3o3lvXxdwpGMojguNmsOQmV6FnaAYeGicNzGXBADVMyygB+9dC3g95RJXxCUfRlMWqFwCGRa6RG
 lxWY8DQOh0N7jGaCtdR7Mjj50kbMZClOgyHeC4xeIOWkkmN4virrg41GRBXcdu2yC9jdnGregMp
 +U1XtvBBn4dScws4sy1zkgZqU/KeVERzrvxT6/TnUwMfdxBE78P2DJkwhD2+jlDY7WB4poJ/G6W
 jAbDUTP4CDhWA7k9ntZm9i0xT1pook9NUQOpS8Rhy8zzrP2NRMY+nIWs92EicAm+FFpe51BCQ5E
 wgWped3J6pMHG4UpPojf0OqpvlSxzQUsOsfwpsJn6bewVWOCrA8WCYPtdEATXx7hmDAt46WF2Vs
 toqDyxT86T1AQac9m4CWJ1wv1+B4ZrKOZh00g4V8solA4YRBG1TSrBja3P2O0NujrBPhmvzR+1Y
 6TkR7tvLz22hrGi1dxQ==
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

On Wed, May 27, 2026 at 3:55=E2=80=AFPM Michael Gur <michaelgur@nvidia.com>=
 wrote:
>
> >
>
> On 5/26/2026 5:43 PM, Zhiping Zhang wrote:
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
> >   drivers/infiniband/hw/mlx5/mlx5_ib.h          |  6 ++
> >   drivers/infiniband/hw/mlx5/mr.c               | 86 ++++++++++++++++++-
> >   .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 28 ++++--
> >   include/linux/mlx5/driver.h                   |  7 ++
> >   4 files changed, 115 insertions(+), 12 deletions(-)
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
> mkey st value is kept after revoke, regardless of st alloc and dealloc.
> mkeys are kept in FRMR pool for future reuse even if their st index is
> currently stale.

Understood, i'll work the comment accordingly.

> > +                     u8 dmabuf_st_owned:1;
> > +                     u16 dmabuf_st_index;
> st_index can be read from the frmr pool key. No need to store again.
> >                       struct mlx5_ib_mkey null_mmkey;
> >               };
> >       };
> > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/ml=
x5/mr.c
> > index 3b6da45061a5..8059b5e4da97 100644
> > --- a/drivers/infiniband/hw/mlx5/mr.c
> > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > @@ -38,6 +38,7 @@
> >   #include <linux/delay.h>
> >   #include <linux/dma-buf.h>
> >   #include <linux/dma-resv.h>
> > +#include <linux/pci-tph.h>
> >   #include <rdma/frmr_pools.h>
> >   #include <rdma/ib_umem_odp.h>
> >   #include "dm.h"
> > @@ -46,6 +47,8 @@
> >   #include "data_direct.h"
> >   #include "dmah.h"
> >
> > +MODULE_IMPORT_NS("DMA_BUF");
> > +
> >   static int mkey_max_umr_order(struct mlx5_ib_dev *dev)
> >   {
> >       if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
> > @@ -899,6 +902,63 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_at=
tach_ops =3D {
> >       .invalidate_mappings =3D mlx5_ib_dmabuf_invalidate_cb,
> >   };
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
> >   static struct ib_mr *
> >   reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
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
>
> The Sashiko comment on previous version of this series was wrong about
> the concept of FRMR pools and its reuse of mkeys.
>
> Please move the st put operation outside the mkey cleanup flow.
>

will do.

Thanks,
Zhiping

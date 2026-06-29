Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A989C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 22:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B441B10E10F;
	Mon, 29 Jun 2026 22:46:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="D6Y+Suqj";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5594710E10F
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 22:46:44 +0000 (UTC)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TKgViF2902238
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 15:46:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=wLX+q6aZUGU2+tNflRbeS5hmHMHpHmOV5uipQIZIRjc=; b=D6Y+SuqjEQrM
 f2QeVXHoqMHxZexgeghszFXVrZw4LS2kXjWpFfTX8mYzWTSEZtH/ttBdVAMkyWdy
 t22Kq702OWpcjEU/kF74grLjnJ54kbNPw0ntlbzzWsw9KEK4RR3CgBqUj3aHbeET
 ijCi6YifPqpFYhAvAOCkBJNfzC61asm2Ur9WnbU9jxmtIccXlhxFn7djlehRcrRk
 CI4mOnrSJnRZys+tAPctwAstQLwZ/r0gp8f8Cpuv+y14HBevZ8rrU6ANkQzUAHDJ
 nM51q117Utf29kv/dShBoc87MTcZ26F0vt+BK+TCjbX+Yw7l2sLH0bG+JlOh+Qz+
 pPe0+S/ERg==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f2c1bq96f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 15:46:43 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7e9bd376d65so4077441a34.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 15:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782773202; cv=none;
 d=google.com; s=arc-20260327;
 b=VWxpcnKDjrMHEhtjZWol65Td+08vF/Z1ckfTm71fYqyGZMbmbmnugUPb9xBIUmw7C/
 R0cQZbXoAPNSdGxKuWYrtrm7u7VrLrvkRJ4WZ1E1PT6UIokec8Gi1w0nX5ChYJWNgPag
 +vrFWZL9AiRfhGpVPA5MOE5tqNF5jQGyA2DDx1OFlLnjept+a/CuvNHFWdT3Azm7FXl9
 +T2mWLmrWA5So9A5kYkvE6cXCQ3/PRO3OyHpAfFZxy4lsjgfgv68kGUaG/ExgDOaEapV
 z8w279ZfTyhCT5yhJv5UT41PcT4L5JvHQAE6InufQEHegBMpK+9oaXbivc1vED5MfK55
 s2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=qoepALekrUydMw3++ECBWh0/IG+kKVdwdlDn299LcLI=;
 fh=F5CdWq9JYqqykfYNer4GzLwrOAvAOiiH+HNaQ8qiBB8=;
 b=lAPOX8vVsT6hs8HP3sZi0lLPlNpopBc3FZfn7c9HDIsVt1hUjRYbLOPaCkdFe3vmHT
 bsgdHJ9a1fdMeldyHYn0bXjzZaQ3sf4ZPtCSHhTxNvR7FhDamsbGAjhwEPWANDcFG6Ik
 BSCALekS8iiprJhrtZpoFDFVqeJyVJInewYHw/BOB5Epj9a3+Y+7u4hYlIn//t8lPEdw
 GNargEzuMv2PsHoQFYv8cVjO7OlnYJe96kWQ4IFEYPqa6Md6OpriMjvnwBLnsIskBj9x
 58QfZA+Y7wpIM5CjS6ESp52oXhK/CYLG6mPJ3vQW++wB2XoN8b+raNXL8GTpkZ7qwafC
 XaJA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782773202; x=1783378002;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qoepALekrUydMw3++ECBWh0/IG+kKVdwdlDn299LcLI=;
 b=JzRPa5DSxsEv6IB+NvgkPbe1OeBMZicq25BPhkUNAOVaMaSYWKqvFofk8q1LEi+Yaq
 RnpyjUAPYC6TRZ6KZfc8DHfv+kRYUwHxmt+Q4Ob556+B1GbLI5rzdnZrgoaCf/sbttPD
 RdctUfZ92vt6/RlNu7Qr8xxXbO7fO9kz3/A/n+7/ZDliNxP4jCg9xpdX3W/LptDvriiX
 eDaAelKoxkFVIwT2PZ9G5YNwSlXX8kZVUpLnccYfiWwJ7/d+MoptJORxGFvuUihyABzF
 BxDL8fSf0pHNk7xqGf6TTKl36XaKxe7WG1c+lFoUUrMhB3RN3GZQEpChLam+Pfv5fwlf
 SdPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gfpFvKxfbO5CIsTOJwfpg+mQKDGPfeJj6BB52C/pgJ/g94InErXbKIIKzK+yDBAciU4ixnjpSw8o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQXBawuwUZERyYoXcaHvMV8FWPou8zyAdQ5ZIMxBvAVEYuxBik
 9wS7sNlz5H7F8r132B4IvLYIURYwjAUs0CQaJ2M5VkKwibrjOJU7BR7QWeLEal5BbdQAcJte4dI
 lRbAliw6C4Yx1kgusxuGou2QIBRbuolA2MvC9z8wSsGq8PLLcyzLReoLPgtv+8GRTE++tufpEm4
 NNUnnwZ82khUroRjOnScJkeoG9e1sEgA9lLJHFXGjQL3s=
X-Gm-Gg: AfdE7cnm00mGiRUhnab2pUIcatzAEF8WegG/pMfnXLecbyrIH3/rttZNAipHhFEZaTj
 8M3Z00K69Xcy2qDMM0xIgcA2VgkFYLGPDou4ZjywgmuL76oQb9IuDsWIP6Hn4YNZY52izo1BPCF
 1zw7fUXJ78JZE82oB6YltKtp4Ytwryn0VNrrFjqf+555VTXE69BseP4nWQU7ZtlC8hoMvoB/z2D
 x43snzf
X-Received: by 2002:a05:6830:6389:b0:7e9:e860:6ee with SMTP id
 46e09a7af769-7e9ec7c6eaemr1372416a34.31.1782773202407; 
 Mon, 29 Jun 2026 15:46:42 -0700 (PDT)
X-Received: by 2002:a05:6830:6389:b0:7e9:e860:6ee with SMTP id
 46e09a7af769-7e9ec7c6eaemr1372389a34.31.1782773201883; Mon, 29 Jun 2026
 15:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260622184211.2229399-1-zhipingz@meta.com>
 <20260622184211.2229399-5-zhipingz@meta.com>
 <b4c98f5a-b3a4-4dff-96ea-be2aa33cd1e8@nvidia.com>
In-Reply-To: <b4c98f5a-b3a4-4dff-96ea-be2aa33cd1e8@nvidia.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 29 Jun 2026 15:46:31 -0700
X-Gm-Features: AVVi8CfM8-1FZc35vpJ8kCojEp6xp5zFP0DjBW3kt6zGgKV_ax4f1nQ8Em8QwAQ
Message-ID: <CAH3zFs2LbjPCn9B2iCvFyW5yKoAirkZqdhwxmZh+U65wH9uy=Q@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Michael Gur <michaelgur@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: vujaglZni9gkSEc7nvXh7jRwcHVB1TOD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE5NCBTYWx0ZWRfXxQ1kCDq9pT7J
 g3SvRD0hWqlBUc+BaW5PyBTugxGYsPcrkaZC/KZ/JUSkTuE/zo+aDAwoKCskBCN9nGbcs85SGbb
 I80ETM8+WpNRoljtzaGBKJ2dQtI5pMpHWa4K15CaPcxPf7XTV5zn8nzG0Q1G2a84TP/QAoYPCLc
 MyWnY6N23hPidfheCPIEvRnlP/MurpQRuSb210AiXymwYv4hZ5/teCUfnFzFSCJVJ8sqBy0k4Cx
 8xmu0aoIuig6rhL8+ZwHSZu38sVpiMCQz/kvVX/cG6owb5+wOXyL0OjAS0gfzQsKJ5swHcCVvjd
 yHlxlGF7zxc4urJoX4E8CgEUIjE3RXPz5VUfNUyIUiek5qL3GpnAI6RaSB49Fi1bdl4oB0scPr4
 NK0aqegkM/OhRSuuTsmuApflBfO4BXoTjSBbixzzpOnXSbOywDYzDi78ftpC2XGzV2ogtYhzYYL
 cAj4NN/7V0v2i4bz1Dg==
X-Proofpoint-GUID: vujaglZni9gkSEc7nvXh7jRwcHVB1TOD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE5NCBTYWx0ZWRfX3Yr7FD/fIRbw
 GCY6so6TydpASTJhb4JDVpEgOFqKmWhI1dNhT9+idJ+474OD4ML8pQSkOZomFnEeuJVLgkE5h+n
 55kkY6A6fqfB3/VTfu28BQJ0fzjWLow=
X-Authority-Analysis: v=2.4 cv=NPjlPU6g c=1 sm=1 tr=0 ts=6a42f5d3 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=Ikd4Dj_1AAAA:8 a=VabnemYjAAAA:8 a=CbDCq_QkAAAA:8 a=l0kR5rhSyQLp93Ybf_gA:9
 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22 a=gKebqoRLp9LExxC7YDUY:22
 a=1qrBK16LubpBFNPVNq2M:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_05,2026-06-26_01,2025-10-01_01
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

On Mon, Jun 29, 2026 at 12:11=E2=80=AFAM Michael Gur <michaelgur@nvidia.com=
> wrote:
>
> >
>
> On 6/22/2026 9:41 PM, Zhiping Zhang wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > Peer-to-peer DMA between a mlx5 NIC and a foreign PCIe endpoint
> > (typically a GPU or a vfio-pci passthrough device) traverses the host
> > PCIe fabric. The endpoint exporting the dma-buf knows which PCIe TLP
> > Processing Hint (TPH) Steering Tag yields the best placement for the
> > traffic it will sink: per-endpoint hint selection lets the root complex
> > or switch direct DMA to a specific cache slice / NUMA node, cutting
> > cross-socket snoop traffic and DRAM pressure under sustained p2p
> > workloads.
> >
> > Until now the mlx5 importer had no way to learn the exporter's chosen
> > ST tag, so dma-buf MRs were registered without TPH and ran with the
> > default (no-hint) routing. With dma_buf_get_pci_tph() in place this
> > patch wires up mlx5_ib to query that metadata at MR registration time
> > for p2p access and use it to program requester-side TPH on the outbound
> > mkey. If the exporter has no metadata, fall back to the existing
> > no-TPH path so behavior for non-TPH-aware exporters is unchanged.
> >
> > Use mlx5_st_alloc_index_by_tag() to translate exporter-provided
> > steering tags into local ST entries when table mode is active, and add
> > mlx5_st_get_index() for DMAH-backed flows that already carry an ST
> > index.
> >
> > For TPH-backed FRMRs, keep the extra ST-table reference tied to MR
> > lifetime rather than pooled mkey lifetime. Acquire the ref before MR
> > creation and release it again when the MR is returned to the pool or
> > the backing mkey is destroyed, while leaving the generic FRMR pool
> > core unchanged.
> >
> > Import the DMA_BUF namespace for the new dma_buf_get_pci_tph() call so
> > modular mlx5_ib builds link cleanly.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >   drivers/infiniband/hw/mlx5/main.c             |   1 +
> >   drivers/infiniband/hw/mlx5/mr.c               | 103 +++++++++++++++++-
> >   .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  49 +++++++--
> >   include/linux/mlx5/driver.h                   |  13 ++
> >   4 files changed, 157 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/=
mlx5/main.c
> > index 02809114fc79..a2b497f6b16b 100644
> > --- a/drivers/infiniband/hw/mlx5/main.c
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -60,6 +60,7 @@
> >   MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
> >   MODULE_DESCRIPTION("Mellanox 5th generation network adapters (Connect=
X series) IB driver");
> >   MODULE_LICENSE("Dual BSD/GPL");
> > +MODULE_IMPORT_NS("DMA_BUF");
> >
> >   struct mlx5_ib_event_work {
> >          struct work_struct      work;
> > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/ml=
x5/mr.c
> > index e6b74955d95d..7aced3f55456 100644
> > --- a/drivers/infiniband/hw/mlx5/mr.c
> > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > @@ -39,6 +39,7 @@
> >   #include <linux/delay.h>
> >   #include <linux/dma-buf.h>
> >   #include <linux/dma-resv.h>
> > +#include <linux/pci-tph.h>
> >   #include <rdma/frmr_pools.h>
> >   #include <rdma/ib_umem_odp.h>
> >   #include "dm.h"
> > @@ -167,6 +168,32 @@ static int get_unchangeable_access_flags(struct ml=
x5_ib_dev *dev,
> >   #define MLX5_FRMR_POOLS_KERNEL_KEY_PH_MASK GENMASK_ULL(23, 16)
> >   #define MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_MASK GENMASK_ULL(15, 0)
> >
> > +static int mlx5_ib_get_frmr_st_handle_ref(struct mlx5_ib_dev *dev,
> > +                                         u16 st_index)
> > +{
> > +       if (st_index =3D=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
> > +               return 0;
> > +
> > +       return mlx5_st_get_index(dev->mdev, st_index);
> > +}
> > +
> > +static void mlx5_ib_put_st_index_ref(struct mlx5_ib_dev *dev, u16 st_i=
ndex)
> > +{
> > +       if (st_index =3D=3D MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
> > +               return;
> > +
> > +       mlx5_st_dealloc_index(dev->mdev, st_index);
> > +}
> > +
> > +static void mlx5_ib_put_frmr_st_handle_ref(struct mlx5_ib_dev *dev,
> > +                                          u64 kernel_vendor_key)
> > +{
> > +       u16 st_index =3D FIELD_GET(MLX5_FRMR_POOLS_KERNEL_KEY_ST_INDEX_=
MASK,
> > +                                kernel_vendor_key);
> > +
> > +       mlx5_ib_put_st_index_ref(dev, st_index);
> > +}
> > +
>
> Please remove the _frmr_ from the functions naming.
> This is now unrelated to the frmr and is strictly tight to MRs.
>

Agreed. Will rename for v10:
    mlx5_ib_get_frmr_st_handle_ref() -> mlx5_ib_get_st_handle_ref()
    mlx5_ib_put_frmr_st_handle_ref() -> mlx5_ib_put_st_handle_ref()

> ....
>
> > @@ -335,6 +364,7 @@ static int mlx5r_build_frmr_key(struct ib_device *d=
evice,
> >                  get_unchangeable_access_flags(dev, in->access_flags);
> >          out->vendor_key =3D in->vendor_key;
> >          out->num_dma_blocks =3D in->num_dma_blocks;
> > +       out->kernel_vendor_key =3D in->kernel_vendor_key;
>
> This path is used to translate an frmr key passed from user-space to the
> right values, enforced and masked by the drivers.
> kernel_vendor_key is not allowed in this path as user-space is not
> allowed to control those.
> Please drop this line.
>
> Thanks,
> Michael
>

Good catch, will drop.

Thanks,
Zhiping

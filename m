Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD21CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 06:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F5B10E2EF;
	Wed, 13 May 2026 06:37:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="vpMyG/0T";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 438B510E2EF
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 06:37:49 +0000 (UTC)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CFePvw2088910
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 23:37:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=LAM65dsmKstrNrOI5lpRjp6+6YUiNRddRB1paFn5Tj4=; b=vpMyG/0TqYlK
 FWur0gKHVAvJLoyN0BSGdH/as0387H96++tNCUt3QXLPzIH8p4iQVhoAWfqG5rIL
 PJ8R14LbD6TgPnBJVBKbPpbdVILQkJgwZKS+0j92/oMcMMWJ6YSQw55sVRvWsjnv
 BK/NZREMWIfqkQkozj9BcGNXRWm9pg4/DgAPmrQfwhM3YcV7+5PrtgRlcs0tQ6Iv
 2sv9r9VJfHH/yIJi1TSk1Tg8YBNDS6675+5PvwhHEKsVCveXe4BTBOJndjzhI9G3
 GBkVoYXXxprMnmmG/IdN4YW+qAjnw0hImptu3z2Tk3hWF9aSB5AQvuc7ytezl1l/
 OsvLiBRgJQ==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e3nvrx78x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 23:37:48 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-48270ee051dso4382946b6e.0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 23:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778654267; cv=none;
 d=google.com; s=arc-20240605;
 b=OZ+MG5SyGtHAFjOng6sx7/mn4KucuV0pTHyuY8jpHm96g8Gcd1yh2GOaWddWNdAuBh
 JyWiWcTp8hwG6tRkIQK6MSr1mZGNRUIeOLD23PmAmTr8TfcCxSWL5NraZbh5mI4zooCL
 R6dsV2xUpO/Vj2MkMCLJdM5J1vvIaEzbEDOhbDQhLblUMpqs3LW+MdIpRfN3QlRwpugG
 Cp8Zm8tFi0Mxe871mhySIPfR1HWs9ZopK4uLqvYpAHCrwRMILa6JS6a0p05NbNOWD/A4
 B0cYrug7+gWJIckZgcpIupQhtvzQ2VbtssYwV7J8mp41UyHDBg2FBXfuNJ7bKvr94QkA
 Sk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=P9w2oPSXP1dmZeF210Jp6h9CK0SajjpVEjMBSbv21rw=;
 fh=5u6q5Z7D/V/VH9STqerREBBNCnw7JGxP5BltX09hJLE=;
 b=L6L9HEUkh73hNMCOajLhX/Xs9oguxEIlmygsb0qPpAcoR8NlHtT6CyxcJU0zWora7R
 YIYnBW/Kn+MHnWgj4IXp+X+/C8IA/vi17IRElZWvseOBGWaV3z2Q7Vs8lmUoKlbbZg3w
 wEa/QmjtFccWuKiVWi1NbiD/0GnHAz+ZKpvJK+b3j55o1A092M+2/0yrYVBhwdi2vd0u
 cTYUnyM1v0emMo7eibsX/67JUEl4nDpa74R6KahK5iQUlsi4SHJ8+wR7jwKzJZE9wcYY
 pFXY5cwuvIgWt3gMLSS06+8cceGyxR7MPXWf64PeN8RNhCFd7RzEZkE9AvvVDjz5vq+/
 vVcQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778654267; x=1779259067;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P9w2oPSXP1dmZeF210Jp6h9CK0SajjpVEjMBSbv21rw=;
 b=g5MmRv3bSp3ia4Z9xw8wFnueu2E1ssf9K7SPfabb3TBYhHP0IMdn1+hWNj9SA2rRWW
 9eDFY36uc61TVL4zgHcZmpLrOjta0/gVx8Q9wQ2gbTLFY1xVdDZm4xuFj0QhRzRXxzfp
 mAQjOi4A/iyYDYdFmYsIwT6HCMevxLdHJdwiUuFg0edizYUtMqje7wVMJ7vq1dT9ktsD
 25nMmdvtlGjuVqwSBUtoMg/2AMCwj52mAfpBS9aT3hAfX3zhnnjODengSky7tv8H6rHL
 61NZns/ouc3usRmVdGpxZNCt8fmA7GQBg/YOk+bBLRodxMdbm9XisjyRrbnGIQ8u20aM
 Q9sQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+A3GMe37p30ZulTW1u01l/2PImvPj3wJtkv4cZUkaCscLSLE55GI1GvMjKsWDCtOATFghluDTAEEU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyjXgUYgInJxl56IvQB9R8Ta4JL8D4ao6wpqggEmUsDbvfK1Pct
 PIqVWzWcj4ZtUU+iD+gHGX08msnxEU4+55FbcZApsoaiafhhkYEia77JnaRHjRSbQefC9PlRR17
 GNNAY773hqCKmjjzbu0lqVGJiKHf1wvX61By6nyHIw0gCgynqJNk+Yo6id1rbskm8Ok+ejVQaI5
 JHr3frgXQgh0NEEurUMBdFPfqX8SNj86hP4BEqnX6EeOg=
X-Gm-Gg: Acq92OGlDxL9na+XjQhorj45sGQbcdomtJil0g9j+BqrTjdhUU7mMr7CiFg1P1FI/ND
 4SR/o5aeZSAde337iQdInoKd2GkNFpJzTxrl5yqIxfCX1BYXVd+/RFqKxjNz8I6aCp20iekrOok
 ZQfVC1Fb06WBC1Rseyd8HZV5ELdIW+X2Oh228uCich6Q2W0N8wVxtYRdaXl4grvfK1hH8KXLDaq
 1JKFCSJpu+iydX5TbXzedKAIgCtDmMMDNJDw3VX
X-Received: by 2002:a05:6808:1492:b0:45f:13fe:4a3d with SMTP id
 5614622812f47-482b28c375cmr1554321b6e.7.1778654267596; 
 Tue, 12 May 2026 23:37:47 -0700 (PDT)
X-Received: by 2002:a05:6808:1492:b0:45f:13fe:4a3d with SMTP id
 5614622812f47-482b28c375cmr1554304b6e.7.1778654267114; Tue, 12 May 2026
 23:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260512184755.4137227-1-zhipingz@meta.com>
 <20260512184755.4137227-3-zhipingz@meta.com>
 <d5b26695-f1fd-4cb6-8e19-201f689eceaf@huawei.com>
In-Reply-To: <d5b26695-f1fd-4cb6-8e19-201f689eceaf@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 12 May 2026 23:37:36 -0700
X-Gm-Features: AVHnY4KQd48YcOfbXPjFCGlTijSz26BhC9fVFq41RkqL4K2-2maS91GmCZxuWQI
Message-ID: <CAH3zFs2V_EENYzq+MRbSV_XPqz99xzA1V=Yc_GpgjGxxt41quw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: fengchengwen <fengchengwen@huawei.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Keith Busch <kbusch@kernel.org>,
 Yochai Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=BMKDalQG c=1 sm=1 tr=0 ts=6a041c3c cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=i0EeH86SAAAA:8 a=VabnemYjAAAA:8 a=xwbcgjOLmlna_7dmNJkA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 93YgNsN0lBPQyDZgiKCenbtgtA1JaxzS
X-Proofpoint-ORIG-GUID: 93YgNsN0lBPQyDZgiKCenbtgtA1JaxzS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA2NiBTYWx0ZWRfXzmCRYTr6YKnt
 fwWFgLtRUW8mz2K49ZZAynSb5RabcDf8w6FEb5E3HtJ8aeSfBKKO+nskgdGE9W1S6TyQBydj4av
 fM2cnqeg80wixk+U9IYQ7Q88Jug7zp6Bpfpo1ILsZoZaFORho11JPKqrhrDz+oJyIfeNPnvCDyc
 iRVQ2WGXLMCNV/cgbXkS60d1XDSVnb0xGdDC/HYVpoxna9w62iANYMqfdiF3ynGB26f/o0kbaQo
 2HsfeypBeRvvXSttUXxWAQRz6mX+aPLC/WymTTt+7PahBGzl8GG91/iDxztntHdRODvemIqRQB6
 yw80OxTHOtWvDDUToOS97AIynOTYDXRerGZtTuRILDoMlv/FJVnAaO2hKtLmk1+q5p95XXQsp3T
 XCADW29JDwGv5jvrl+rlytrPXr7T4rJrrYE3Kt4Qr87vBOT/7xnPUiCsx1weuYwYAC7gTyG+2Nn
 g8OoKaHY9b5U4ato7Kg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
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

On Tue, May 12, 2026 at 6:49=E2=80=AFPM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> On 5/13/2026 2:47 AM, Zhiping Zhang wrote:
> > Query dma-buf TPH metadata when registering a dma-buf MR for peer to
> > peer access and translate the raw steering tag into an mlx5 steering
> > tag index. Factor mlx5_st_alloc_index() so callers that already have a
> > raw steering tag can allocate the corresponding mlx5 index directly.
> > Keep the DMAH path as the first priority and only fall back to dma-buf
> > metadata when no DMAH is supplied.
> >
> > Add pcie_tph_get_st_width() so the mlx5 IB driver can query the
> > device's negotiated ST width without poking pci_dev::tph_req_type
> > directly (that field is gated by CONFIG_PCIE_TPH and would otherwise
> > break !CONFIG_PCIE_TPH builds). Pass the width to the dma-buf
> > get_tph() callback so the exporter can return the value that matches
> > the consumer's capability.
>
> 1\ Recommend the PCI/TPH modification be committed separately.
> 2\ How about rename it to pcie_tph_enabled_req_type() ? so we could
>    use already defined macro:
> #define   PCI_TPH_REQ_DISABLE           0x0 /* No TPH requests allowed */
> #define   PCI_TPH_REQ_TPH_ONLY          0x1 /* TPH only requests allowed =
*/
> #define   PCI_TPH_REQ_EXT_TPH           0x3 /* Extended TPH requests allo=
wed */
>

Hi Chengwen,
  Thanks for the great suggestions.
  1. Splitting the PCI/TPH helper change into a separate prep patch
sounds reasonable.
  2. I see your point about exposing the enabled TPH request type! I
want to take one
      more pass over the overall flow and switch to that if I don=E2=80=99t
find any issues.

  Zhiping

> >
> > Pass the dma_buf pointer that the umem already resolved into
> > get_tph_mr_dmabuf() instead of re-resolving the user-supplied fd.
> > Re-resolving opens a TOCTOU where a concurrent dup2() can substitute a
> > different dma_buf between umem creation and TPH lookup.
> >
> > Track the per-MR ownership of the allocated mlx5 ST index on
> > mlx5_ib_mr (dmabuf_st_index / dmabuf_st_owned) and release it once the
> > firmware mkey no longer references it. Both the cached path
> > (mlx5r_umr_revoke_mr_with_lock + ib_frmr_pool_push) and the
> > destroy_mkey path call mlx5_ib_mr_put_dmabuf_st() so the ST index does
> > not leak when the MR is reused from the FRMR pool.
> >
> > Initialize ret in mlx5_st_create() so the cached steering-tag path
> > returns success cleanly under clang builds.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  6 ++
> >  drivers/infiniband/hw/mlx5/mr.c               | 72 ++++++++++++++++++-
> >  .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 27 ++++---
> >  drivers/pci/tph.c                             | 20 ++++++
> >  include/linux/mlx5/driver.h                   |  7 ++
> >  include/linux/pci-tph.h                       |  2 +
> >  6 files changed, 124 insertions(+), 10 deletions(-)
> >
>
> ...

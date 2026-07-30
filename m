Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24D6C5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 23:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF73A10E011;
	Thu, 30 Jul 2026 23:59:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="jWhIvPAu";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1C0510E011
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 23:59:37 +0000 (UTC)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UNWDfw3525497
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:59:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 pps82601-s2048-2026-q3; bh=aFHuyGsjsa956iCoWQLUmEvVwVe7uwZZhrewi
 8w6Mn8=; b=jWhIvPAuqvVFcHLbLiDbK0cVadXlVv/ohNS/DhYlJ6mYaT12UCVXw
 oexjZjyFAFDA+f8DiWclsfHu9FcMCzk7vjsWjW5YuOeRuj9sA7pLqrwfdmGPohry
 x2PKA/CrzkufCYEL44vzw6Y1hX41H/YxuBbzEyqWVQJXdfoRsBSfffyA+9oNObz6
 lSvgRWC3B+K5RTWefpMGGtGiiXQMIcvkmdyWQ51cxZ1PQqW6Rjtn9Jvrv2p56ytc
 tSf/PSQqoyW9mEa5jqrnn71vTb9+ty4tHPOe8lll5PY9TFUAcCr6MMXW3ykyk8Xa
 5JaXB36DeNKn/+GQM6TgJuy9ATY596evg==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fqrm09nfm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:59:37 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7e9ee20bde0so300363a34.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:59:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785455976; cv=none;
 d=google.com; s=arc-20260327;
 b=n5EJaAYDwwqbKhjsP+d29ugGlYUPazFlpx3ZuZguPvtOm9AEpYc9eWva0iRdF1uHEy
 vl/jQfKzazv42lzCmbGcd9p9NY5yq8c1AOyW65ErGelZzkiqk5ggcJpQ9do4gFPjzaJK
 djqkLbwZiGJc9DO5Lo2hXPHG2WkI82ZzcI/4YXXiXULTVwFUXz2e2YwM2cU/kxmuEgmp
 j5OfvRchkod05o/gvjnujcrDishSz7lmWRxPImQk/Ys/3EJGQXiLkwfxyTWjbasAxsHN
 ZrEPvPYMbcE/COT7pr5/WO+5rWJvgksS70QszkeV8Onb7Q2o820jRrlPvCx78SfnFjH7
 p8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=aFHuyGsjsa956iCoWQLUmEvVwVe7uwZZhrewi8w6Mn8=;
 fh=VeljR/oZaWk/0ueXr3IxavPsaKHBw3AZRNbXU4s+RUI=;
 b=GaP1XHIQAiHuY5Ny7I7H5iwDw7loYxZs1+2eg468cP/OHk8YpyuGOF8a9qS+lAcrPn
 FVV9guj0m6CvyO64pZpmAXAzZ40gpMWK4yAxGDcum0Ys/YORTjdayVT4xplAiy9wv/HP
 PERQN5glHNXQzWrsyZSHCKL4HATvI+sBb0u/5iZeZjl3a2ClM/FSYDCNmZdqpWgEQYSj
 mdHQrp0f7l3reITpxxxdidq3xWg+jMokcH+uX3NFTTKy542SH+BiZILiJUh1poDMV2I8
 T1+qvZAPRTJt9WrQYInDu8qOc/M3qtJabYtDCE33TibRVum3rcuC74X0ILNV8I5+RVTR
 wkLw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785455976; x=1786060776;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aFHuyGsjsa956iCoWQLUmEvVwVe7uwZZhrewi8w6Mn8=;
 b=VrPMyogJGYZ6fM7oZ2c0xr8fi2/zr2/daCJUDt/hKNNVzIhw/FUXlF9qpZk3rX1afg
 EW+gAkNJUegdkvCep5Jc+n/3GOZz6q9KBamLLswKUIzkQzz8ejr6OGDYkgPIrfGjmxy0
 svp3Jzn/ORHQbmUdnHgDZpJUEtbar/nbcomTe/tmOvfvDP3qSioEcWAhTp8jdOYog4oU
 oNrbm9OXfZYXg6+WDY6WRCEzCKN8uZffaswltcFuq+ihyOOLx4zo5ESYXKDw/1NZYKP5
 Zen/y5uARK1A57AL8cKVVg9rNqmR+4S7aWZHyipPEF21hIiPlkJ1ut1kyp9hISTEyNfE
 dBjw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMrGbRkC/4l48hpre76cSa4be6Bqa5Q56QR5lpcFgojttucmFh1OGdy+grFXLWDLiVZtJCfrG0wKY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7i05zz+8/CDmFG7frt3xe9CtzrPnQ7FRS7/8DOLOauXj7XZrp
 OwmXnkafPT8r49PMN02k8mYvgUWkHlqaJNfWk38DW322ggkFT1QuKkvGlbiG1+MFyFeOIM8Mb7T
 UqEP4feZ+Wh6+775htaQxthWdvzmmsT3LLPB0+ciKudzRTPnKWmfBQcfdLfM5MH1GRnu/A9vbql
 6Z0L2sD1xN5Kas1mvQZdDwdLcB83HTQflzun1KLwIU95o=
X-Gm-Gg: AR+sD11TcIg4BqYSC3sbPANpsqgzY5Hw7j37WUdVfcYDAyslExungPyGn3U/VRa1iUH
 ErVgSUG3KCYeDaPQhIzqWFQ19QMdZoqoM0UgdNecQaeCmf9xpkgblQlL1PBTJ2tASb0aT3AHheJ
 QmUv2fpaGkwcQmUIUwB6POoPvc+vz+0z5Uz48Eu8Z86jwhlMK9sasOA6qG7u+ueVOaH/spqrZv
X-Received: by 2002:a05:6830:82ce:b0:7d7:fbe2:9725 with SMTP id
 46e09a7af769-7f02becc0aamr3745867a34.5.1785455976208; 
 Thu, 30 Jul 2026 16:59:36 -0700 (PDT)
X-Received: by 2002:a05:6830:82ce:b0:7d7:fbe2:9725 with SMTP id
 46e09a7af769-7f02becc0aamr3745791a34.5.1785455974484; Thu, 30 Jul 2026
 16:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260715204008.3911275-1-zhipingz@meta.com>
 <20260729170350.1a1c2229@shazbot.org>
In-Reply-To: <20260729170350.1a1c2229@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 30 Jul 2026 16:59:23 -0700
X-Gm-Features: AUfX_mx-hlfiuAI4ouKh3POt6LNkchZ4_m4FnV7O04E1uYsL5TQ-m_yA6NY7xNk
Message-ID: <CAH3zFs0pnmy=q1-jwsE69Wam1TNszKyBg-U219Sjt_syQ1JruQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
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
X-Authority-Analysis: v=2.4 cv=QMdYgALL c=1 sm=1 tr=0 ts=6a6be569 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=r1p2_3pzAAAA:8 a=JJdtByxIUwxPJm2e3F4A:9
 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22 a=gKebqoRLp9LExxC7YDUY:22
 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE2OSBTYWx0ZWRfX8cV+rosEvNsJ
 DOyIWSJAkKKo7CK6WNpSt86goFmNkM2kTxLEGHCk55GLnXOFEsIE1UyZJZszvYLhynpVsoSUbfM
 KTATT0IgLayAoIzgHgQqU+2Cp06ckGw=
X-Proofpoint-GUID: lJEoe5BOhPRy_YQ42VXsasLomLrYz6El
X-Proofpoint-ORIG-GUID: lJEoe5BOhPRy_YQ42VXsasLomLrYz6El
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE2OSBTYWx0ZWRfX9fW65q/6NBor
 seXDW2HiukiBlQlONoPcY40yw8HbcrEAWAe3zB3bOzzcoYI0/n65cfp0RUSiS1oVpjwmrvI+WaY
 XSMt29dHEPDs7CIAkHHZYxoAdE1r2StEg8IywHnaTcI5cTgdL8kxiOh16/vaekRuEqY2uPJIuuu
 KU3hvjlrZrgpimhWD+6ixfLs+paFXzUmHobwuL+8GWTp7tN/azlO44AD9VIa5W5EAv2ytv4ILbo
 ocL7zYhoFnX95jIG7LJmZObvR/H4bqr/8Ws/3/Uj7Jl2EpKRQRF4TQp/e4xnHdXJMR+1/6+H0lM
 m8Y7iXCpwKq/mczs73qQ7x55Xgk3iYR7DejDRYk3Qzc84dcT1LoA/CvSSOGsMEt8C8GOdwRwVwG
 dOSjVHfSp4y03iZKk+p4DToIZ9SmLQOCmmWXlkzqEh9SJNh5LlcSteEpGQMgDZZo+xi7rS6MUe/
 WTtZ8SReoh2rmUyi+0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
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

On Wed, Jul 29, 2026 at 4:03=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
...
> On Wed, 15 Jul 2026 13:39:55 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
> >
> > Depends on (submitted separately):
> >   net/mlx5: free mlx5_st_idx_data on final dealloc
> >     https://lore.kernel.org/linux-rdma/20260612170406.3339093-1-zhiping=
z@meta.com
> >   PCI/TPH: fold reserved completer encoding in get_rp_completer_type()
> >     https://lore.kernel.org/linux-pci/20260715202409.3767494-1-zhipingz=
@meta.com
>
> Sashiko failed to apply[1], it can't handle such dependencies.  The
> first dependency already exists in linux-next, I applied the latter
> manually, therefore the patch indexes in the below local sashiko run
> results are off by one.  This used Claude Opus 4.8 rather than the
> standard Gemini 3.1 Pro Preview used in the on-list reviews, other LLMs
> may find more or less.
>

Thanks for applying it by hand and running this locally.  Both
findings are real and v13 will fix them.

> We should probably reevaluate the best merge path for these, it doesn't
> make a lot of sense to me to have one patch routed through Bjorn's tree
> for a self-contained fix where no known hardware makes use of the
> reserved encoding, then depend on that change in the first patch of
> this series.  We need Bjorn's ack here anyway, the Fixes: tag is
> academic in current code.  Suggest adding that patch into this series
> on the re-spin and prodding required subsystem maintainers for review.
>

Agreed, and I've said the same on the PCI thread
[https://lore.kernel.org/linux-pci/20260720172304.117134-1-zhipingz@meta.co=
m].

...
> [Severity: Low]
> Should the PROBE path here also require that the device can actually
> export a vfio dma-buf?
>

> The only gate before vfio_check_feature() is the completer-type check:
>
>         comp =3D pcie_tph_completer_type(vdev->pdev);
>         if (comp =3D=3D PCI_EXP_DEVCAP2_TPH_COMP_NONE)
>                 return -EOPNOTSUPP;
>
> vfio_check_feature() returns 0 for a PROBE request, so on a device that
> reports TPH Completer support in Device Capabilities 2 but whose pci_ops
> has no get_dmabuf_phys, a VFIO_DEVICE_FEATURE_PROBE for
> VFIO_DEVICE_FEATURE_DMA_BUF_TPH reports success even though no vfio
> dma-buf can ever be created to carry the TPH metadata. Every real SET
> would then fail later, either at dma_buf_get() or at the
> dmabuf->ops !=3D &vfio_pci_dmabuf_ops ownership check.
>
> The sibling base feature vfio_pci_core_feature_dma_buf() opens with:
>
>         if (!vdev->pci_ops || !vdev->pci_ops->get_dmabuf_phys)
>                 return -EOPNOTSUPP;
>
> so its PROBE reports unsupported when no dma-buf can be created.
>
> The commit message says PROBE was made to "follow the same hardware gate
> so the feature only probes as supported when the device can really
> consume it." Would adding the same get_dmabuf_phys check make PROBE
> consistent with vfio_pci_core_feature_dma_buf() and match that stated
> intent?
>

For this VFIO PROBE issue, yes, I agree this should use the same
dma-buf export capability gate as VFIO_DEVICE_FEATURE_DMA_BUF. TPH
metadata is only useful for a vfio-pci dma-buf, so PROBE should not
report support on a device that cannot create one. I will add:

        if (!vdev->pci_ops || !vdev->pci_ops->get_dmabuf_phys)
                return -EOPNOTSUPP;

before the completer-type check in vfio_pci_core_feature_dma_buf_tph().

> --- Patch [5]: RDMA/mlx5: get tph for p2p access when registering dma-buf=
 mr ---
> commit e612584ae6697d1ebf77baf0fb1487a41e4c6511
> Author: Zhiping Zhang <zhipingz@meta.com>
>
...
> [Severity: Low]
> This refactor moves the if (!st) return -EOPNOTSUPP; short-circuit into
> mlx5_st_alloc_index_by_tag(), so the remaining mlx5_st_alloc_index() now
> calls pcie_tph_get_cpu_st() before that guard is reached.
>
> Before this patch mlx5_st_alloc_index() checked !st first and returned
> -EOPNOTSUPP without ever calling pcie_tph_get_cpu_st().  Now the order is
> reversed:
>
> mlx5_st_alloc_index()
>     pcie_tph_get_cpu_st(dev->pdev, ...)   /* runs first */
>     mlx5_st_alloc_index_by_tag()
>         if (!st) return -EOPNOTSUPP;      /* guard now lives here */
>
> For a device where dev->st is NULL (TPH not supported, e.g.
> !MLX5_CAP_GEN(mkey_pcie_tph), no pdev->tph_cap, or a failed mlx5_st_creat=
e()),
> the DMAH-with-CPU-id path mlx5_ib_alloc_dmah() -> mlx5_st_alloc_index() n=
ow
> reaches pcie_tph_get_cpu_st(), which performs an ACPI _DSM invocation
> (acpi_get_cpu_uid() + pcie_find_root_port() + tph_invoke_dsm()) that was
> previously skipped entirely.
>
> Is this added firmware query on a device that does not support ST intende=
d?
>
> There is also an errno change: when the _DSM lookup itself fails,
> mlx5_st_alloc_index() now returns pcie_tph_get_cpu_st()'s error (e.g.
> -ENODEV or -EINVAL) to userspace instead of the prior -EOPNOTSUPP.  When =
the
> lookup succeeds the by_tag re-check still returns -EOPNOTSUPP, so the two
> differ only on the sub-path where the _DSM fails.
>
> Would it be worth restoring the !st early-out in mlx5_st_alloc_index() be=
fore
> the pcie_tph_get_cpu_st() call, or noting this behavioral change in the
> commit message, which currently presents the change only as extracting
> mlx5_st_alloc_index_by_tag()?

Agreed. The added _DSM query on the !dev->st path was not intended;
that function should preserve the old early -EOPNOTSUPP behavior
before calling pcie_tph_get_cpu_st(). I will restore the !dev->st
early-out in mlx5_st_alloc_index(), while keeping the guard in
mlx5_st_alloc_index_by_tag() for the dma-buf-provided tag path.

I will include these fixes in the next respin, including the folding
patch as patch 1 in the set.

Thanks,
Zhiping

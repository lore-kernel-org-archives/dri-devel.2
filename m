Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC76CD5BD2
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 06:41:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0482B10F985;
	Fri, 29 May 2026 06:41:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="myui/KH8";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 599B510F985
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 06:41:52 +0000 (UTC)
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SNIVrL2977287
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 23:41:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=wjl2lJMhu3x6YF6VZMdTDkNQcozAcKqTdHEY7+axmxo=; b=myui/KH8juDb
 9VFRxDDFEIimNoAd5XwHhraUO/L1qE4ZtZnO5K+/nzprny+oPTbRJWHwUl7Iab/B
 cMLPIr8HMpKYeWusLbb/K+iwCBNNEvNQ4TbH/N8JWoEGZzYAl66wAE0qc8sarvKy
 NYv2JsEurivQoqaAHfEmVHaXwieB82fQ7S1h7lyRTkK45xQ7kvSunBJhbh5mhqcS
 R4u4gH7+DhvThFUOuSUwR7HsCG5Cx58JsKiG3AGPcpDd3+2CHCL50PZkKvpuBsSW
 56zV2uZKI0BOQNtMOtj246H6KVeuu5CBuNc+Twlud+11KyL2joGJMeL7vJmJjcwU
 nf9M3D97/Q==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x1j75d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 23:41:51 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-48576b309c7so8579509b6e.3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 23:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780036911; cv=none;
 d=google.com; s=arc-20240605;
 b=UkSRFZ3ApxodvoMOXjco3Fd+g10ylHhzyhUOQHH3S5+d3+w8somX0TKWfMvVLcJG5x
 qhMtg6YKRpLI+4ZQiIKFUlYEpbhmScx8eVJKcD864pqqKZkyDfzzaQOlhEyLWU8NHJjc
 /gZNYrfuiZvFIb2im2WzemY0ClQm8VHPLI5tyjiTIGI/D4E+baZZyYSrq/jUB+bAeR+B
 D+q/58u5onZzyJrBQ2itYdQMYDDuNz4nddfF1CYjQ4iNiWm61JGl1H+ANptZkT6VGZKz
 snUfgfbMv2ZUQYryq2ieqUu/NDwFXVJN59BfV12EXAZZfnWdCA9ZY1a5YTbU1Kp0igD8
 NfoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=5hKWaaPr0jpqnvHMhDmJMKNnaKkhbQEW5A8xM9/5BHs=;
 fh=RZ+fzhXcUIZs4SlWaycq/CHp+aBil40eXEGWBGckKmQ=;
 b=c3YwzO4pb3Lsujwo486fRUv0lIV/UgurW4uGCKhxKfgD+WmESc2SX8daEbuwgLbkL9
 LRensFZEEhWRsdHsHZ2gIJWt99XM7YQwfD+BpDLV+4FWFzqIAM3cFa1z1Asw3Kps3PuN
 dd5iaVwDUy9z02S1GsyB9wVx9Pi01ZQ+Qjv/2cLo+gS5Q5XdKfhkVws3sIXd6u+jg6rp
 q4B4hzr6uuLrdzFYhZtjqWbD8HuAnXnw8XQirYcyMYZ4KZyKsMft4bDUuhDyZXHjjlpS
 zHE7vltHoNn4+FfXD2GzB97Tz51xRIx3ntuuKCCrYRWjX5o826BkIwRtPJvdcS6dAhG7
 qvTg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780036911; x=1780641711;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5hKWaaPr0jpqnvHMhDmJMKNnaKkhbQEW5A8xM9/5BHs=;
 b=fDvRhUny3/up2LfZ/YA0TvMpC8K1Sxi/7ROYTTev+p4PI4hMDQXo/25ky0Vzv8hTrX
 sqYBGTVMXAyjKMGb2DWJmSlEUBQQR2l4EQ9aMzUV0VEKFK/974lWZGWxYmobuIaU8xoN
 dHF24bZh/5EQeufTDqxDuFH6apO80RyFuKap8z8krNUsgDfsSVj/Nrt5546XmkJ9YZwa
 X+t4PheqDPsd/DIukUhgv9GZVnl7RSmgn2tZ7dDRPaSpqKprKVJ/A1yEf6iFsH3m9ESF
 nM55D7GzqMW7MHHag/ErmfRRGDT/ptVKtHHWcSOY6kKqnbRduA48M6LobZerLxdHpnGK
 IZsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/kWtdDxLFhDvYCHmEsXgTrjsqbimAjtUqp7R28XHlEUhd9tVeXxXK+XP6cn6R7OA8Pl8Jb26iFY9Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwwhsXboIq1uv+r0BqYe0M/3yKoFN8YSfmf0uAgRpvS9bZjh36T
 Edj4GraiPJhsGpSdoVE71/VclsedaVmmo7r4h8QRV/k0oURDA30Ehcpl70T3oHLGlaY+54VflzB
 hJgv+LItDdGijUkHyEtmIS0ccTxGZFqqm72+qTqfzG0Nw2eaxpQy64j1QIs0mxBb7vFE0IE+xEt
 Wyy4eZt1vle5vRoLqTsGNJ4YXRMn8vK75Up5y9z+jGk4Y=
X-Gm-Gg: Acq92OEoxnYTy57Qlba9eJFIXPD6tB17q9+1259PofffZD3CYF1qwBl0e6W/STsTCBW
 jL8nAM8FRd9UD8Xxe2F/nDklS436GGMIn9meJf26sPUVjxTI82mulZoFcObMoqdbWTf9/2LTVTH
 xHLF3MJ9jCdFMo5GWJXkJcV/aMmOvgmrnRPh9E0yN8MPibMPn4v1I3GigjfaxZsEhnUBePbaFNL
 LxVw1Qs9oQhT9rsdCzfOa0UeqEzqLEIAM6W6LzRaJ4xRI4oHkc=
X-Received: by 2002:a05:6808:1c07:b0:467:1212:46eb with SMTP id
 5614622812f47-485e6dc0223mr972290b6e.35.1780036910686; 
 Thu, 28 May 2026 23:41:50 -0700 (PDT)
X-Received: by 2002:a05:6808:1c07:b0:467:1212:46eb with SMTP id
 5614622812f47-485e6dc0223mr972266b6e.35.1780036910218; Thu, 28 May 2026
 23:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <20260526144401.1485788-2-zhipingz@meta.com>
 <20260527145332.30412ea4@shazbot.org>
 <CAH3zFs3Yv2G0rQNE7x8DjBWPE+3sFC_3X6ZtF4x-mPp==h0BQA@mail.gmail.com>
 <65b3d63a-271a-4aa8-ba8c-fc2b186349dc@huawei.com>
In-Reply-To: <65b3d63a-271a-4aa8-ba8c-fc2b186349dc@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 28 May 2026 23:41:39 -0700
X-Gm-Features: AVHnY4JOme_X08lKUfayqc49fxg4J4ab3o3Y14UzTjVjHMNZxrhWL7QV4gYwqO4
Message-ID: <CAH3zFs3eddZUtb08oNpjEg5b2=DJtRCuEcjsxuPyRA-zB2idag@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] PCI/TPH: expose the enabled TPH requester type
To: fengchengwen <fengchengwen@huawei.com>
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
X-Proofpoint-GUID: dGb4949NCHlAegry8nx4TUk-K8D0U6TY
X-Proofpoint-ORIG-GUID: dGb4949NCHlAegry8nx4TUk-K8D0U6TY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA2MiBTYWx0ZWRfX5jOks3vLVQ0i
 SGvWTyqqOqrYv35QIQITzTcMWD/vR8DA59/vnr7VjWkN4fW8ol9RUIc2Md1QJbPBqKB7yJrJUjS
 x4Olc3wDL6KvFfOBLqCiDcxej6hP+5mVAkVpFfj69pph9WRuk53/LApNbB1iTq3/eGNZsafupot
 HTPefcMWBRoCdJGmJg4mhICs9NCc32KVGM8siPw8QWx7CoVGJesGGq3AyW6afgIjSXPMzaZ2352
 uK0lY2XG2eXIZURgn0Rj/CZ3dhIYLGZ/Xh8W99MLDE5WgfcCVFUrb2LE4M83kEar5bb+RtKj3YC
 iXNdM6WnNccs6ITYfD96enDvcpMC2/yodqb/P6yhnSkI4ZR1I5DzZgPq7MR6HmD0cEgf9py3TnG
 eqUMABJOFF1B0PD3Biaz1Z3+oEUL+LcLo9a+gCkvh05l/TqxwrePrVVMGgn4/9wsB/ir5OxX5Qr
 jgQREnyTzKSJ8vBrN4g==
X-Authority-Analysis: v=2.4 cv=fMUJG5ae c=1 sm=1 tr=0 ts=6a19352f cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=i0EeH86SAAAA:8 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=zzBG9ipUb6nLY-ocZWUA:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22 a=r_pkcD-q9-ctt7trBg_g:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_02,2026-05-28_03,2025-10-01_01
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

On Thu, May 28, 2026 at 1:04=E2=80=AFAM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> On 5/28/2026 1:35 PM, Zhiping Zhang wrote:
> > On Wed, May 27, 2026 at 1:53=E2=80=AFPM Alex Williamson <alex@shazbot.o=
rg> wrote:
> >>
> >>>
> >> On Tue, 26 May 2026 07:43:53 -0700
> >> Zhiping Zhang <zhipingz@meta.com> wrote:
> >>
> >>> Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> >>> requester mode without reaching into pci_dev internals.
> >>>
> >>> This keeps pci_dev::tph_req_type inside the PCI/TPH code and provides=
 a
> >>> !CONFIG_PCIE_TPH stub for callers.
> >>>
> >>> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> >>> ---
> >>>  drivers/pci/tph.c       | 12 ++++++++++++
> >>>  include/linux/pci-tph.h |  2 ++
> >>>  2 files changed, 14 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> >>> index 91145e8d9d95..6c4492075ae9 100644
> >>> --- a/drivers/pci/tph.c
> >>> +++ b/drivers/pci/tph.c
> >>> @@ -174,6 +174,18 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pd=
ev)
> >>>  }
> >>>  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
> >>>
> >>> +/**
> >>> + * pcie_tph_enabled_req_type - Return the device's enabled TPH reque=
ster type
> >>> + * @pdev: PCI device to query
> >>> + *
> >>> + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_=
EXT_TPH.
> >>> + */
> >>> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> >>> +{
> >>> +     return pdev->tph_req_type;
> >>> +}
> >>> +EXPORT_SYMBOL(pcie_tph_enabled_req_type);
> >>> +
> >>>  /*
> >>>   * Return the size of ST table. If ST table is not in TPH Requester =
Extended
> >>>   * Capability space, return 0. Otherwise return the ST Table Size + =
1.
> >>> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> >>> index be68cd17f2f8..fe572737b409 100644
> >>> --- a/include/linux/pci-tph.h
> >>> +++ b/include/linux/pci-tph.h
> >>> @@ -30,6 +30,7 @@ void pcie_disable_tph(struct pci_dev *pdev);
> >>>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
> >>>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
> >>>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
> >>> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
> >>>  #else
> >>>  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
> >>>                                       unsigned int index, u16 tag)
> >>> @@ -41,6 +42,7 @@ static inline int pcie_tph_get_cpu_st(struct pci_de=
v *dev,
> >>>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
> >>>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
> >>>  { return -EINVAL; }
> >>> +static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev) { r=
eturn 0; }
> >>
> >> nit, s/0/PCI_TPH_REQ_DISABLE/ for consistency.  Thanks,
>
> It need add #include <linux/pci.h> at beginning too, else it will counter=
 compile error like this:
>
>    In file included from drivers/vdpa/mlx5/core/mr.c:8:
>    In file included from include/linux/mlx5/qp.h:36:
>    In file included from include/linux/mlx5/device.h:37:
>    In file included from include/rdma/ib_verbs.h:46:
> >> include/linux/pci-tph.h:48:10: error: use of undeclared identifier 'PC=
I_TPH_LOC_NONE'
>       48 | { return PCI_TPH_LOC_NONE; }
>          |          ^
>    1 error generated.
>

Great catch =E2=80=94 thanks for testing.  I will add
#include <linux/pci_regs.h> to pci-tph.h so the TPH macros
(PCI_TPH_REQ_*, PCI_TPH_LOC_*) are in scope wherever the header is
included.

Thanks,
Zhiping

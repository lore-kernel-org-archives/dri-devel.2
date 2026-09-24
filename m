Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148B9C98314
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 06:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA7B10E8EB;
	Thu, 24 Sep 2026 06:25:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="kVpR4J2c";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1061210E8EB
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 06:25:09 +0000 (UTC)
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5dT23057511
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 23:25:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 pps82601-s2048-2026-q3; bh=dumiTwGbMEgraHXzScODaqcrl57xN/pkOOLYC
 cmVuK0=; b=kVpR4J2cMlHzqIDDgIwDNRJKn8dds0XKZoAj3OuhpAobjcceNl0Bu
 lbg5D+lbA8CbPmTwKFk7+P9ILanDRGAi05aIxnTFuZ43UVMM/4+qDIBkN6C9YRFG
 IHueetZOt54ETnH+qsE4FIKotfPKQDH8rt4NVkm1+3IL6jolTyEOLLwJmpBn0uju
 gZkmJJjhBdcR/w50XWF7pn04IJiaJvS+3p3s6euzs154NtYbjvGfGPrlSbJ7kNRv
 rLyGbzA42lxnnIsp7gJ8tDUTh1gq3l85Sch1Tuo75/IOWkwLClaKgleRjE3hVug1
 TUvXeAqjqctf8mUTc4IxwuMOWegiHDbEw==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4guyr1fbra-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 23:25:09 -0700 (PDT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6c18e7d53b9so1128037eaf.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 23:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790231108; cv=none;
 d=google.com; s=arc-20260327;
 b=YYdKxOWC5iYYOY96jQdYnZ849lYasL2jKa6TKWNv47PzNC9OaR50PgeOQqx4S9QpwL
 eOBCN8Nx6jYOxmx5DyaRfVj7pygSw771dAp7TB6pLERlxtetx3s5vYmYZL4z2tJKj4ZT
 SqE6Ms2T5ULlXJAjsebmm79tqPJReXpdquAHDgOAbr+cNM9CBniBzUEFc9Sbvfam9dfv
 fIAcPNeErRwKBhkfTIBIrqFYNFM54w368tL7T7Tl4Vt1BPAp27NtCMngn+o1TL/ROg0M
 EUfDafeLYVo/vo3aUpQoI7mYV2WmbTBPPBjTqxprOg2MahSywS5S9V1Qf7Ax/wHfM0Jb
 RhLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=RHSnVwj4ta4xwY4ZaPurv5a8QLd5HiVRVFjxaoUelIo=;
 fh=iqmXX0+DE3gBQuwaksihmrXo1BipttzRdA3GX0k1g68=;
 b=f311VdhaJ4/CVQeb8MkqUiJF1mSF7sAkf10VzlS6mFAuOap12u+rxhOGsc2UIDhtI7
 m0PUPZ3ZXPGBLsjZ9nvnqYEP9bnY2V8XmBSXpSeZrkkgPiilhHCZxOi/uZbBynwpkSZ1
 mLIh6YhXgqrkS7ELqkkh9NCNbw6WwJBmfAcBPx/hKEZZbO+Pss4qMEy+sRgDSiIIHhP8
 80t1hLfmtOKttbLSYGFmNQLP+uh00bBIGdGcIfYH2jsFaXBCiHB54vTeRvCcS2WowBFe
 LrWYyaU7AGiKLhlpCZRVn6bdDrnQ0Ls6ZxK1I/IAcxje7GtWJJsqbl+qQStT7MrM2s2F
 VVfA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790231108; x=1790835908;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RHSnVwj4ta4xwY4ZaPurv5a8QLd5HiVRVFjxaoUelIo=;
 b=NTa71Q3g+esSk0UI4Yxf2flCos9b84Hd9ADvwk62lU8MY/gUUditB27fYa/bjG0TFG
 qwjzpdHG0GMfukJU+EfTXOc4TGhtNJ3e+R3MNyd7tc+/LP15ZPL9cibt+6Jw7u9EvXaq
 97vujy8hxvkP8aqCQ6+XiurhJ6QeGftdVXtU20gJkjHLgB1oPh3Y7+0ebgiB3xLgPSFN
 T33rGi3w0ovyEXbdiYO7DwieYx2nLoxEjRYj/ciCA/9shftEg+nmF5E0ZjPp/nL+ExvQ
 aFhrl9923HlsNqBz2Ddsv5ke4pR57eLjF2NhQFzZVqY+iiGdRfD+LkT8KBPhLxpCeCD2
 NF8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFUe9rtjMfFIRiGMOrqrJHhh4kc3k2NrZ0fZgBOMX2G3M+WGpPKMaNho6Y5oDPS6bWBKLYUycuG3g=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nwReSfXCVE8W2CXMOjkLIQpsAEnQgR1oIYSk8eqXBDRnlFWaH7
 T5n3UwpHG8JNVAwZKUyw4/POggR297yQ473qb7Xmvx3ZzXx8TN8cFa2CDRvCQt1ZCqBzXBLQP81
 wAvkUUrEYd9xFPz1doTyGYPETliSSFXbFBbkWV7G/UNTS/9CIB+pEHxjIdJePmrw08Q8qb+JzsS
 Y9wO4nilccjmWAKW8t0wWA2yDhnt8f4fhafvcCwFeAT84=
X-Gm-Gg: AYBFou26icP4XyZO4Mp5W4r5b73krCEDQWCQhR38o4rvn9Aq9O0rdZzeGRxcmc1We45
 kxszbviqKfoDArityysS25E/hUWxcZafsgX81KqSAhw1Oiva7dLQWxjSC46DgNmfE1UxjBU+ToO
 djxoj9Ak8jj/4d3OAPIt91p8ths0MNjgqP093WZyHy6+Qat7WCqxaITSXE0sBBxc/3t4ePBIWDS
 ZNI0+6nLCaEwAcoRWs=
X-Received: by 2002:a05:6820:a07:b0:6bd:f79e:5022 with SMTP id
 006d021491bc7-6d43f4b92f1mr1105076eaf.23.1790231108100; 
 Wed, 23 Sep 2026 23:25:08 -0700 (PDT)
X-Received: by 2002:a05:6820:a07:b0:6bd:f79e:5022 with SMTP id
 006d021491bc7-6d43f4b92f1mr1105058eaf.23.1790231107597; Wed, 23 Sep 2026
 23:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com>
 <20260731211601.3033906-6-zhipingz@meta.com>
 <f4ff7ced-63b6-42e6-8e01-9f01d2e59843@huawei.com>
In-Reply-To: <f4ff7ced-63b6-42e6-8e01-9f01d2e59843@huawei.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 23 Sep 2026 23:24:56 -0700
X-Gm-Features: AclHuK8ihUvHi9sCYY6U80mehJKIocBbXx4TYk849EeeC-OYipx5xqfc_idP75U
Message-ID: <CAH3zFs24esHCGA=wPrkiH8oKQCv7SnOwcBbkMxrOEvOVtwstYg@mail.gmail.com>
Subject: Re: [PATCH v13 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
To: fengchengwen <fengchengwen@huawei.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyNyBTYWx0ZWRfX4mrsq92FgzEz
 FeZyxC7zHFTNAJKBHpAO0xyy+C24b6YxhV7GGxroVo+AKiA0J8qNx5zIcllDo8O60qWI8Xk0Zo6
 ZctG6mWCVFZfTcMc/Dlk4vuFRZKVym0NEjWOXtCsID0pi7HzOOk1OvSwCr9E5qZZai3GX4a6nWw
 JN24R1bNH9W6BrQe+UuRijokLZP35R3c5eHAXvUHAMCY8yVFh/d05f2NLaGRf4KLw66lGHJU5OL
 u1Jr35LIXlJg3YOSQ+v9r4+3C1U8pc6SFGMrxQseqMQKD0y0SXX3FkPJWng92NcvRMXl0RH5a4G
 M5vHh4exBhFKJ2L1LxozZqUg8VQajs6TcDgC8f3KzdHpLpErFzqRe6T39wa//DwOOAYoHJBk3B9
 4RzKtWnLQ8MVJvnp9RnN0XF5HHGU1QorzLn1jxBDrDxer6bKV1hdZp8avuW4Ysvn6lL0UKS1ixY
 D4zjjEsgJrEDDQbotrg==
X-Authority-Analysis: v=2.4 cv=DNMacCNb c=1 sm=1 tr=0 ts=6ab4c245 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=i0EeH86SAAAA:8 a=L1Z5B5hNzKdfmK81vbcA:9 a=QEXdDO2ut3YA:10
 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyNyBTYWx0ZWRfX2t43bEOqTnuq
 Vk/J+8Iz9aifNR+6b7bKiYO3mRsWeWrCjK5Gh5YWPQSv4noPgo6g513aM7usyN8gyFvWZCy6XJ/
 CmbEIGC1yN0Vw35HcoyIVRIO5o34jrU=
X-Proofpoint-ORIG-GUID: fRwgVmasVEeeAstjnZFA7lFtQCnEr15V
X-Proofpoint-GUID: fRwgVmasVEeeAstjnZFA7lFtQCnEr15V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
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

On Wed, Sep 23, 2026 at 6:13=E2=80=AFPM fengchengwen <fengchengwen@huawei.c=
om> wrote:
>
> >
> Hi Zhiping,
>
> On 8/1/2026 5:15 AM, Zhiping Zhang wrote:
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
>
>
> While working on v21 of the VFIO PCIe TPH series, we got review
> feedback that importers must add pci_p2pdma_distance() validation
> before retrieving ST values from a dma-buf.
>
> Your mlx5 patch follows the same importer pattern =E2=80=93 it consumes
> dma-buf TPH metadata. I think this patch should also include the
> same distance check.
>
> Thanks,
> Chengwen
>

Hi Chengwen,

I don't think this belongs in the importer. Every in-tree dma-buf
caller of pci_p2pdma_distance() is the exporter, in its .attach,
clearing attach->peer2peer -- amdgpu_dma_buf.c, xe_dma_buf.c,
habanalabs memory.c. There is no importer-side caller.

mlx5 also can't be one: pci_p2pdma_distance() takes the exporter's
struct pci_dev, and an importer only has a struct dma_buf. Reaching it
would mean introducing PCI types into the dma-buf core, which is what
Christian's ack on patch 3 rules out.

The routing check is already enforced by the core before any p2p DMA
can happen: vfio_pci_dma_buf_map() goes through
dma_buf_phys_vec_to_sgt(), which switches on
pci_p2pdma_map_type(provider, attach->dev) and fails -EINVAL on
PCI_P2PDMA_MAP_NOT_SUPPORTED -- the same calc_map_type_and_dist()
computation pci_p2pdma_distance() performs. An ST that mlx5 programmed
into the mkey cannot reach the wire unless that mapping has succeeded.

Thanks,
Zhiping

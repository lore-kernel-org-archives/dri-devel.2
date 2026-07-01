Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292CDC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 17:53:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 614D410E1A1;
	Wed,  1 Jul 2026 17:53:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="te9NKp0K";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0018010E1A1
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:53:39 +0000 (UTC)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661GqUbC512041
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Jul 2026 10:53:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=e7kmcvrJXFeA+SwUp+Q4JZ9GBs/Tu0VczqJ6zfGHtFQ=; b=te9NKp0KSuAB
 gJAStcqVmXyO90PdrOMhuz1QH+omYd4+Mw3B8TEdXPLJtkYQrsX/45BVNWyEblz+
 JCUQhK20eJ/NvICPYCtpkvbiKi0EHSaSmpoWEug8KslbHuTVqxo1Cyiq8npvWq8O
 iWJN4c+SNKe9prCgyypFFuDT+2fW//iCpWAfn5FZiHT3Ma+UfgQldfxu1JwL3wjT
 puoEMSaFB2J+gLTdLoKhlZdm4JHFAsQvSKn60MMl3h0pRepyXYCBK4DH/emUGdVP
 7d65A6CTugo700ojlRhKudPV6DZBXhMFm8x8LUWJmnAbgYzkzF4XYX6nodZkJ3HT
 F2Y7Da8ekA==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f48k5p588-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:53:38 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7e9f6f0240eso1062066a34.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782928418; cv=none;
 d=google.com; s=arc-20260327;
 b=Is9GJ+GlTjBFkyJBgtHmUj2tXO8kcOKp4Jxuge1HEIepO0RFiEjBTpRBqYphuCbLDZ
 DYFrMIOonUeM/lE5GtWntZPN+v2dGy8Bkk2e5YrJeAGLLzfwCFChHAEvH5ZPKHJj7msl
 htXb5RsU85WIWa0AYieD+EPD80oUWnuKop0/I3K3qkSJk0BM19Ag7nz3MMqROeoNMucM
 Lx3kVrn/BsmvXzBXzDc2YWrMurYspJYqgg/BiE/X18q1xVgbUvdyjBdc1otraEEmyhAI
 P9QBXADSd+NzAzjsUTIFARU4WESOFtTF/LZJN+sKzCnwuZglvAA9dqpAKHhNYWc85KtC
 ptVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=e7kmcvrJXFeA+SwUp+Q4JZ9GBs/Tu0VczqJ6zfGHtFQ=;
 fh=zBKKKA/dVI9wpLbxJm31KMnvJS6KZPITw+KRlzZD80M=;
 b=RC/SZnpXUrSLYdmq4lUqpfCuNaBrchWqX3rWYMUYcUlFvA8/BMFhSVANxiiRTRVBK4
 pGYuOLtXs/dXDst4SnZ9DM9/bsvRBtlJdTZizycYXc1Qv5FBgYzYZJmB9Mf6A97Pce/Q
 yZYUrBNesuMKoLbOxBnB5tdph3lQ/w1SbRyWsL2Ld6HMb9LpnCTSJEeFyTJ52GFfgGkx
 EBPa7s+PTWWPV4DGpzQ0pxgCQk+suXmt0+jnES1UrYuBAhSFOhjtz3HxqpgqHyXVutTr
 umbnu4PbXHhB6CYZDXH1nsU9rTcU2hfffzmAIK7wsepHiADHcoM+KoOzhqtYMslrFMON
 qodQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782928418; x=1783533218;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e7kmcvrJXFeA+SwUp+Q4JZ9GBs/Tu0VczqJ6zfGHtFQ=;
 b=pdQaYWM9LUqdu2hC03CqeRkMeKHu8sCaeCevmYw0IVuHNZ3G5ynai5oTZO5MH22W5p
 i5fIsnGszBD/abPsP1UZhwHCgN0zZjBfQD1ii9mSERR17sA9jazuSMHsUp3zmTLqNU4T
 Vk8IXQDTQ5WZEN1x6uhmysSSF/XMmlnglf94l1wh3u9FhqDAgA3V2yD7l3y8Uqscr87V
 W3Knz1IApeo05T/zpbe3hHGrEe9NL+rNl0z4X3+ukpO8X6nFxKUPX2/LsFfxsjR2kDFh
 32cQCtyU1ADwFmgCAGFRD/2UssaxgDh0lRghVSZMtN+XZZIGAKLm2xMx4kwN9tURCDCo
 h3Bg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Phw0oIz2ss+id++WvYSl9i+QY7HhY6ZEnoKG8aHG3ecVQUaxlMY5fpHlhYywCbQNDcTb14mfPie0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzhlKuw989h4cOxMJHU7S2DVoAJ/6ySD+RYWITTqrUv39/aQZj5
 fXDc/d8DHc2+fm6y7lfJ1poaNNt1qx0AFb3HoIZHVciWLA2/auKCsiAP26KZWaLRaPRoRrQvBEh
 SElATPhNA971B/OQi5xwfhWZlJ9r/oRuxC8sj5lV311v4iq4etlCRN89aScWmLF0pGwSqBfU6RS
 7F72ZYB1CUYbBCDRRaq4aamWmvndJFwG467EWc2ms9t3w=
X-Gm-Gg: AfdE7cmCg7lT/48tiSA1KKkfDOkNKQMzuzPMTpOYUZYjhehmrNWOVKGIl4ycyC5LO+6
 SVm3KqZbk6T4d+L1bldq2xARNJ0lrclOXmwiHZuPPBJACPyBQiZvVuTfAAqZS0EwQqUbQ8LXu8M
 vg12D4uBfJQBSzJgaO86xniRgHD+U1zQpeDf2JxbLBb9bSueOytC5G+2RWC2LX5knOzsIz9AW6G
 n/bWJPXKA==
X-Received: by 2002:a05:6830:348f:b0:7e7:62f:727e with SMTP id
 46e09a7af769-7eb505175d6mr1172075a34.22.1782928418037; 
 Wed, 01 Jul 2026 10:53:38 -0700 (PDT)
X-Received: by 2002:a05:6830:348f:b0:7e7:62f:727e with SMTP id
 46e09a7af769-7eb505175d6mr1172044a34.22.1782928417437; Wed, 01 Jul 2026
 10:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260630224328.3218796-1-zhipingz@meta.com>
 <20260630224328.3218796-3-zhipingz@meta.com>
 <e132eb91-554e-493f-9da2-aff5a538da6a@amd.com>
In-Reply-To: <e132eb91-554e-493f-9da2-aff5a538da6a@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 1 Jul 2026 10:53:26 -0700
X-Gm-Features: AVVi8CfUmWw3yG8Q376o8lxaFsAzKao0Cd3LEJcq9dJNu4sURoDLmPjujqACaso
Message-ID: <CAH3zFs2tkxA9w-oCr0N4ixe2VupXXQF-cA2o8-fToj6uFyuMJQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] dma-buf: add optional get_pci_tph() callback
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE5MSBTYWx0ZWRfX4BIFLPgoQ7EZ
 z5eVWNX7/DyY1NB3lOyyUsGS8bBB+C8A+3cfpKRx4as7cO1eDsryGQn26ul1p+ORaC1CAO3GuHW
 KldjeRI2G5plo5KD3ZB/P1/6e46dnh8=
X-Proofpoint-ORIG-GUID: 9thTD7X2rMF7AFr_0zSxrFgxmifKFHJK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE5MSBTYWx0ZWRfX2jEbJJo0LPpP
 iBMQ2mbubNOPF4bn7O4tSVTIsPyyisEERWhQeMVdpTHbKVP9VmTeEVYwenAioBCnZ9Hjdgi1+jl
 5QUIwUMSoQKrW+3zecRYP6Ccnnnx+VthEnDHJ8sxKLDO6i/oO0R1I3t9/X6pI6fqKYVtduI1DfM
 Ej93OPC/3GvpV+We0YhdbuC3pWd7TKpMpAnRVZBWS7KiZK8CdqUolLPp+2VlLITskhax/SJ8fyQ
 rxXwDdsZnYLkPdztQ/eKcGgOWI56V9PYRRyDgoyA5R1GC/g/BiBuaaSAEzAlhnK5BLhjTUUXWOw
 0OINcMjSBzkfrBFoRltHoyty8BGWAm/OsJ+hvagWFrnAO807+h+aZojBmUXP53UUvUQzEFeXzU0
 +gs8Ov13XzhZcDyMi6UPi0DyHsTgwPIoAcuQ0Ip9OPEwZlaRMF+SUsV3alFQNCud3Nx+G1cGrca
 x2vdLDniCafElS3SP4g==
X-Proofpoint-GUID: 9thTD7X2rMF7AFr_0zSxrFgxmifKFHJK
X-Authority-Analysis: v=2.4 cv=QMtYgALL c=1 sm=1 tr=0 ts=6a455422 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=crHB47gyY4rKiduisYu9:22
 a=I4J65MU22ScPYueRrkgA:9 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
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

> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index d504c636dc29..7a4c9b0d5dab 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *at=
tach)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
> >
> > +/**
> > + * dma_buf_get_pci_tph - Retrieve PCIe TLP Processing Hint (TPH) metad=
ata
> > + * @dmabuf: DMA buffer to query
> > + * @extended: false for 8-bit ST, true for 16-bit Extended ST
> > + * @steering_tag: returns the raw steering tag for the requested names=
pace
> > + * @ph: returns the TPH processing hint
> > + *
> > + * Wrapper for the optional &dma_buf_ops.get_pci_tph callback.
> > + *
> > + * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
> > + * exporter does not implement the callback or has no metadata for the
> > + * requested namespace.
>
> Please add something like this:
>
> * The returned information is only valid till the next invalidate_mapping=
s() callback from the exporter and should be re-queried when a new mapping =
is created after invalidation.
>

Thanks, Will do in v11!

> Apart from that it looks good to me, but I still think we need some kind =
of example that this works for other DMA-buf users as well.
>
> Just demonstrating that this also works with some simple FPGA or similar =
PCIe endpoint should be sufficient.
>
> Regards,
> Christian.
>

On v10, I have validated a second importer: another vendor's NIC
(driver not upstream yet, so locally patched to
call dma_buf_get_pci_tph). A PCIe analyzer confirms the TLP steering
tag matches the exporter's for both mlx5/ConnectX-8
and this second NIC =E2=80=94 two unrelated importer drivers exercising the
API end-to-end.

Thanks,
Zhiping

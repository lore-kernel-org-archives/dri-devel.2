Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154C6CA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 21:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D5A110E173;
	Mon, 28 Sep 2026 21:48:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="kOlYqGiD";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5A9410E173
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:48:00 +0000 (UTC)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SLTlg43076008
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 14:48:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 pps82601-s2048-2026-q3; bh=OVdNSiqQUhRQfp/JGpi7EaQ9UmFZis0CHFKmY
 zkvi1s=; b=kOlYqGiDxua0gnAE94K8BoX1NpPHaagCIF/NCVsflq+xJJtWzb0YO
 YBz6kPJxXBjaCNh3T3N0DhRurSOV0/7GVM28F/QnZ/33gICD9+BdtSZshieGanER
 vkLOi/B0XbuISnjkPoUk6rjCHlg1hWu9itC41ZN+PCfbNrj2xaueHxJIxQBEr4mX
 RYbT1AgUpkZn3AQcdT6NVr7FTzap0WZo1xshFg+qb7pA3nGyffOzxt/7/jstZw1c
 QAEC64RTXEw+vOSZeiCr82m/OtVaCK+KDEYEmzFgK2UQLd21WhAZEmuzhfp2WhSF
 CSFY0u34VEvqr/lTJHB4spcEJIIWbkwzg==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gx9c3hxbp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 14:47:59 -0700 (PDT)
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-6d82f22830dso1814872eaf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 14:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790632079; cv=none;
 d=google.com; s=arc-20260327;
 b=lsdJHH0lpIVljfXMn4Y5cq9fufq5e+FeJeB1ZiCJyXoGp0emQ816FWML5fVauzSfJT
 l2JGMLc2Olhg2KJ/PJG6wMXHBiYW9EpqTgPpNnj0Pryq7IgWSO0ubKR6MznPm7kkTEH4
 idmmEureZx8NwjGtpqTE7SN3FvZFYjk02a84j8pknJWPHhaSZcYpsxyH4MtxYZP5ZcmX
 9rWcka2SZJOro5hTiY0bT7iiSkguB9hVXPwmPwfXlvpBbVLnNO9h9EcAbQgnU/pD23JI
 zlJqrptbe42q0Ok691E6mnxe0t++C9tPMywVpAZBSxqZBwC69oC1pSlPAQkAUJjMT0Af
 iH3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=nsM/d13GDOKofLPZVXyaTADEaxrWWppyFB4m09sEx30=;
 fh=1aXoP6lVb6wMcwsm0QUbtJCaKxOAjJwYV0i6GCrZVWc=;
 b=eGVvLcF7xnuKRdn0RGnErppTxCagWK23yv44A4fmlmc85beCJP8OcPL0JtiTj6qFqH
 qkFlj3j0Z9vjgGZG56FiufkpjC48lcqlc6ptX+n6l8EBfmK+nLQXA3B8XdsOpqd5WyzX
 bLbvcG/qUipo+B3DAy05rRIYGo/TEudu911Ew/5YQvsvVsxySSnUvyDEHMe++fDA0boW
 gTgX8/HLJ+Ye68sHIZG7SkszSlwRk2yx+kku5cbI3svwCJLHzeeIA8wLlL0P/utc2wKI
 1zH/rTF47Wamj71YW5oD+oHMaRnFr40JlVFz1pnY8PL/f85mlKZ5kznYzUgJiL9Y19xI
 qNNA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790632079; x=1791236879;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nsM/d13GDOKofLPZVXyaTADEaxrWWppyFB4m09sEx30=;
 b=mSrXijjDpS3CXfyh1YYpZwC0jskISxk4ceRxho3tQ+o9W2UY4etlzcgDBv3s2CNZ4n
 zFaUfVq2PmwgpgIUFSQC3TAi6FMXeGWYBrxYVg7a71cuUs3s3K8Cehbq3tHBkrGzmr/e
 I38YDpEqBOBkjty/bHm2inHhuonkuB11APE5CElKdBVQICtovfAUoq6MKM0jmqXDJXoj
 zPmTf2EHlr0dNHqvT+k+yV+1yoEv/bIyxWjMRGhQcnwu/VbjEafrRPZkjMEyQFF7fsl5
 UoTNEX+oORbXGfqHl78MIREJyhkKek+G8J/lAqNBdn9HbnHwUzUTarcoPeSKsuCXb5u0
 DDzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7yFDyLKaK6E+KrSrHyEGlFVvZ/N/0bQ1TgH1hXijdgFQQa9flOS7cGV/3E8PSbIICMA/yzF9y0N0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nn43IOtnvrNblY2fILmg2JZNshgXp5lsLEjFGa5wm7cGujhjS2
 fd9RGuxgkUgOETi5+2Mg5K0kV1WSj26LxMeV54C32Hm6Td0ubVM8mCYZ/XpA47a1JZ8WlpCBywt
 LnyT/DN9OtpQRy1weF4nui+q7vvmZ3a6vRmFMc/X7HEmaklYCIEPNV89NoMqODvPCBxsbPQwxsu
 0EjixWE605hM48uPwadM9conW6UHhKftJKiw2wk+EZU9s=
X-Gm-Gg: AYBFou16rJ2PN3kJHekPabJs+TuSMzE+q5Jxmt5iVZsGU1TL2ZIpqjiGP9mJsb/On7C
 ABZS7EXNmNBeNMgOWJpYv/h0tddNjK7m4aH8b3fN+Q1t/ix21v7G3T8daHRWCvmZyHt8+o1yQ+6
 ge0lneczLFSWSc72ScZrw4qYiVM4bR3j4kPC/JeehYM8Qfljm7tgaRmtR6M051+1zJyiOMYvYG
X-Received: by 2002:a05:6820:f012:b0:6d7:fe06:604 with SMTP id
 006d021491bc7-6d7fe0607eemr5411473eaf.18.1790632079046; 
 Mon, 28 Sep 2026 14:47:59 -0700 (PDT)
X-Received: by 2002:a05:6820:f012:b0:6d7:fe06:604 with SMTP id
 006d021491bc7-6d7fe0607eemr5411459eaf.18.1790632078491; Mon, 28 Sep 2026
 14:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com>
 <20260731211601.3033906-6-zhipingz@meta.com>
 <f4ff7ced-63b6-42e6-8e01-9f01d2e59843@huawei.com>
 <CAH3zFs24esHCGA=wPrkiH8oKQCv7SnOwcBbkMxrOEvOVtwstYg@mail.gmail.com>
 <20260924233058.GA163130@ziepe.ca>
 <CAH3zFs2rhg6-b-pVDps1V8LsM4Dn48t4J4LFVyKOZtT4axdY=Q@mail.gmail.com>
 <20260928172939.GK163130@ziepe.ca>
In-Reply-To: <20260928172939.GK163130@ziepe.ca>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Mon, 28 Sep 2026 14:47:46 -0700
X-Gm-Features: AclHuK-FrHEzthVV7FZ3Ls3GrwbmAQee8rpJCMTJYpOGKi1s1NipCikGQwgcBpk
Message-ID: <CAH3zFs1mCujYjB=5ywo+huAjPJZQoe9u7NM4evNRYr5_ZQbcXQ@mail.gmail.com>
Subject: Re: [PATCH v13 5/5] RDMA/mlx5: get tph for p2p access when
 registering dma-buf mr
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: fengchengwen <fengchengwen@huawei.com>, Leon Romanovsky <leon@kernel.org>, 
 Michael Guralnik <michaelgur@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Christian Konig <christian.koenig@amd.com>,
 Alex Williamson <alex@shazbot.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: zRmXQG5DEaNnG_sG6eHtWvqheXpKR7Zl
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA4NiBTYWx0ZWRfX9U6NNKcMNdHy
 SLeOhExNkK/Pqkty4+U0JAEG2AL0eRAKxv5T2MOY51wP/A3NvlKkaTadJM9tUTJG3m4ynHK0Lgg
 Vv9OQuOkKOE4FgJMZPzSXoKU/CESDrc=
X-Proofpoint-GUID: zRmXQG5DEaNnG_sG6eHtWvqheXpKR7Zl
X-Authority-Analysis: v=2.4 cv=KrfYSmWN c=1 sm=1 tr=0 ts=6abae08f cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=9jRdOu3wAAAA:8 a=l_Ha6740zCVOtLZIeloA:9
 a=QEXdDO2ut3YA:10 a=-UhsvdU3ccFDOXFxFb4l:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA4NiBTYWx0ZWRfX7K9dzVizbLEZ
 bnE+JPqOs5SuOX0ZgadTiuuhMUhU1HKVuJVuB4TasTtoHDxCh73usiFi0vTp6mwrjmQ5JNL04//
 /8ISa5gYGWMeWWgfoMUC60eQ4+rAJjBpPyc+d42ZWyOcqte9naS9v0veC5FAnPuOpiPVGdPvnzK
 UUpq2JPUy5YIIDtxbcWOJRLNVdqCm4XfLn5SV9ITvR34y11/0DUFh1atWQE7SLwY8gE1Q3TV+Lf
 Pvu6Dtw+DMdP90Eumf1b7EhZ7zKtJOuQGJxKHWc4+r44L3YubjiphZwGC9X/rvLUX3j+WAwMw9q
 m4zeAx16SIn6dMNW41CmcPlrSYKc5qOTojwIQ4osZ4zFzmOsjvW1CquRti9CFKXHSHhCVtz8Wv3
 N40a1CBydmVYF2r1P/NuB6x1W+Hu8uIFEbf+paAlWCmKN2dBb8QfJaLPsx1ziuNhqDFuzj+RXLE
 A+JdaqCnSdXthbJ7lOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_06,2026-09-21_02,2025-10-01_01
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

On Mon, Sep 28, 2026 at 10:30=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> >
> On Thu, Sep 24, 2026 at 11:17:57PM -0700, Zhiping Zhang wrote:
> > On Thu, Sep 24, 2026 at 4:31=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > >
> > > >
> > > On Wed, Sep 23, 2026 at 11:24:56PM -0700, Zhiping Zhang wrote:
> > > > I don't think this belongs in the importer. Every in-tree dma-buf
> > > > caller of pci_p2pdma_distance() is the exporter, in its .attach,
> > > > clearing attach->peer2peer -- amdgpu_dma_buf.c, xe_dma_buf.c,
> > > > habanalabs memory.c. There is no importer-side caller.
> > >
> > > Right, and they shouldn't be doing that, but it still has to be
> > > checked that the st is going directly to the peer device not the host
> > > bridge. Not using the distance, but by the PCI_P2PDMA_MAP_BUS_ADDR
> > > indication.
> > >
> > > I fear you will need some of Leon's series to make that happen.
> > >
> > > So probably the proposed change to dmabuf ops is far too simple.
> > >
> > > Jason
> >
> > Hi Jason,
> >
> > Thanks for the comments.
> >
> > Agreed -- the tag should not be handed out unless the routing is
> > PCI_P2PDMA_MAP_BUS_ADDR. That can be enforced conservatively on 7.3
> > with two changes. I can fold both into patch 4.
> > ```
> > In drivers/pci/p2pdma.c, make pci_p2pdma_map_type() callable from
> > tristate VFIO_PCI_CORE:
> >
> >     EXPORT_SYMBOL_GPL(pci_p2pdma_map_type);
>
> No, that's been rejected several times already.
>
> > and in drivers/vfio/pci/vfio_pci_dmabuf.c,
> > vfio_pci_dma_buf_get_pci_tph() gains:
> >
> >     struct dma_buf_attachment *attach;
> >
> >     if (list_empty(&dmabuf->attachments))
> >         return -EOPNOTSUPP;
> >
> >     list_for_each_entry(attach, &dmabuf->attachments, node)
> >         if (pci_p2pdma_map_type(priv->provider, attach->dev) !=3D
> >             PCI_P2PDMA_MAP_BUS_ADDR)
> >                 return -EOPNOTSUPP;
> > ```
>
> Also no, this has to be done via PCI_P2PDMA_MAP_BUS_ADDR which also
> enforces putting the determination in the right place in the code
> flow..
>
> > Two properties are worth stating explicitly:
>
> Ah! AI!
>
> Jason

Thanks Jason, I see what you meant by Leon's series now:
  https://lore.kernel.org/all/20260928-fix-p2p-acs-v4-0-v8-0-404453b9c435@n=
vidia.com/

Looking at v8, it seems patches 1-4 can stay functionally unchanged,
while patch 5 uses dma_buf_p2pdma_map_type() on its own attachment for
both the initial TPH query and revalidation. Is that what you expect?

If so, would you prefer that I wait for Leon's series and rebase the
whole stack on it, or split the series so patches 1-4 can land first
and patch 5 follows after Leon's series?

Thanks,
Zhiping

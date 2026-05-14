Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D918CD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 05:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E7BF10F109;
	Thu, 14 May 2026 05:52:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="fsyf2ung";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6996910F12D
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 05:52:51 +0000 (UTC)
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64E3xJn12277319
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 22:52:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=uPcBPEjsltb6cCR8nYMfRID/9nwc2fCBltEgFyYw4tk=; b=fsyf2ungMeq6
 yshHRzeQ4U6BrRrLOw2m5LnpTLwWNRFjtrke7zVSXSFihlkGIGQqF9ZGo3jGgRXv
 2rFeRHThXTMGtORk281jxrE4gu3k+yTDpZgaO0RXgdCq1N5vftBndt64eqJWuKnS
 +qFgwbyeb4nBJPMKSoH2gapTvLOVcXTpgpJbzNuSuxsG6wL6MDQuJFxJqBTW1JNi
 IVV9KnN8WwJIC23O9zBqlSvbZlQqGkv8pX6J8DxJKQRvwoU15pvU+KJVRC+Shz/1
 pdRz08JIRHpjjYq3PaY5+SYfamSp6mY3XF0mgHmyOf5/MBFj0ETZ9P3+2Z1Vr68E
 ax4mD3GJvw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e3nvqw6uf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 22:52:50 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7deb9de359bso12766137a34.3
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 22:52:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778737970; cv=none;
 d=google.com; s=arc-20240605;
 b=gJZ/6T50UIM5CH9fYhuMUsut1YiVTEZvkMqx0fUwU8N0XsASLx1m1Tw446lygg/gvs
 JvnKUiiQ9oYlOzD24jJxH3r8tuyjbWx19YnnGBlC155hX33IrQBHaOeFn7DDWztBqJ2f
 YCegAE72sPXdiHG1fSOraKtFPeUGBvsKHLlHHkVLpSXAm+DXEkcIoUty4c6FnbVOTePs
 4dMecSb+O4wymKdBlw6MNEa8AvoxUiAwH7BDYksdW+xqMPRbyf0Nniljl+rqdTrhvSRi
 2LDTZO2izm96B17IJ2BLL8U4+0BSRoSo8I3xbfBVjvVBvgJ7nA7tpgUEFUNz549hxklv
 EcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=uPcBPEjsltb6cCR8nYMfRID/9nwc2fCBltEgFyYw4tk=;
 fh=UbRzWeuYtLRE0Uz0xUuCAygB9Hd1gGjn5sbLTYG7v4g=;
 b=Cc+4RnazU9UJRbbh/EN3vgY92StnvAknOYmvosImzqsjf/jEOsxTDZUoZ7Eg/gJT6x
 CqYt7c+0X/D5MaPSPKm/PXJBYkwzjnYB4oFcJywZnWEp4pykGrptdOoGhsQEeSGlsUPt
 UnexJF/z8BsW21oZruoOfid3Dkct8r3m5QKhHfB/V86xW+r3VU1+mUHkM9uYDyGJangy
 h31EuSaN85OkZKEooepdVPjCDLhiTdq0K5GhzS+7UH7E6oy0mM7FBpvIXbgVP5UVzAl9
 3bMN1itrLMLX2w09lbEXrEmRmAIevDgMSJddogwZhbzjKGDtiYzg5+KOGQJ0cowmBytJ
 kxBg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778737970; x=1779342770;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uPcBPEjsltb6cCR8nYMfRID/9nwc2fCBltEgFyYw4tk=;
 b=ap1BsdXc7r4TpJU7rmASc0b5rYiS1BFu4S5/7MS3fJiM4xeav3xXWkwjNUpwopIRxJ
 wpo0ik34pcrosEhA2IfoKCwjU0oq+4iaoiDpipuDzh7NMnj/dZCTKujRq1/W/pLrdWlZ
 5xsDfUbpHVjd9oYTEUdHP2nDs5fuagEpJ+bFfG+81/KgSIKyPPoTERHjZRqVkCsMZswV
 He/6Q3QSKwWUWmZFrRfPJlmpTlJi7D9IbBpGV4tymDGeDGfSwKi5oyN9wpjUzXHXYUC+
 m3ilAURelaG+eWubC4eHqFWcUZD0acgOTQfsXTnK/5YSKZh380FnFIRWLZkC819SnBHl
 Q4oA==
X-Forwarded-Encrypted: i=1;
 AFNElJ81zk/F9xWkLVPZTMgS4AdfJ3grvgMSeUUCRY84+XR68gbRyK2c982uOPopqeBohx2EJXCzX94AZ9o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywk5HmECvgNmyteTNmuGo8GeCfehay3L7+h765m2okck3Q3r3CF
 TWzZ6Do0OsXSh4gEQ1iGxjs6fq3J2ycpoGr2xjQS/X4slenUTDioIR9W/Xs2p+iPiHRK1R0oysV
 AFQO5xW/Oee02rNFGyqXyNjoc30GAen8ARMr56WOQsHcAk+iXNgb9W6njgrQRZzfXRKpj1r6LJ7
 DwwVv5/lyOtsnUFpChiuJveB1z5ZG0jkZtbX3O1GpTr3w=
X-Gm-Gg: Acq92OF+L9H4EVeq3CLxO9G35SxNvuGwl9Fxfu8BosEfmbPdfwu3RZWWGOBCIlofxZR
 CmUfYxibVdGI7aUomR01HgbIE2/6oTLCxFE8gf8wc9UwvH/F0hstBNOyujbYS4TJyOG/geDYhXV
 UTofl+LMXFkPG/bTpUfwhWISmr83BiZm4REZCK5KCh1LUZogcG7ELjdw579bpxdWP7JP+uoYNhx
 C4WoXBZYqrnUeg5IkDwR/1On2qKEFQs7PEONQFk3tGzcRuUucM=
X-Received: by 2002:a05:6830:2a06:b0:7dc:da80:42b8 with SMTP id
 46e09a7af769-7e3da47a167mr4289733a34.18.1778737969720; 
 Wed, 13 May 2026 22:52:49 -0700 (PDT)
X-Received: by 2002:a05:6830:2a06:b0:7dc:da80:42b8 with SMTP id
 46e09a7af769-7e3da47a167mr4289722a34.18.1778737969331; Wed, 13 May 2026
 22:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260430200704.352228-1-zhipingz@meta.com>
 <20260430200704.352228-2-zhipingz@meta.com>
 <09995589-b81d-4cb7-a313-15a943d8b28d@huawei.com>
 <CAH3zFs2x2QebpqDC0qwQg_GP2FVs-qqNxPupck40cEHNrBMEsA@mail.gmail.com>
 <20260513063141.GC15586@unreal>
In-Reply-To: <20260513063141.GC15586@unreal>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 13 May 2026 22:52:38 -0700
X-Gm-Features: AVHnY4L9mpkzt-pRZEvg5JzN0p2zqJY8w2-rDz2pv9D7N-e0Agw9sPJQbQsXATM
Message-ID: <CAH3zFs2XyXxzVwru2gYZn-9ioyvy44HMmfppf7shTn8Qop-4iw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vfio: add dma-buf get_tph callback and DMA_BUF_TPH
 feature
To: Leon Romanovsky <leon@kernel.org>
Cc: fengchengwen <fengchengwen@huawei.com>, Alex Williamson <alex@shazbot.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA1NiBTYWx0ZWRfX1moFcmMOFSLf
 +7X/B90G29Val5QjWNpcRXxXfLCOEGQr+1uccJ5e4RU4q3u8ZudMdx6x6KOa/+DqCLIrRSMMPfK
 Te/TulpQqMvsoO3kh0vYOm5ybJYqKLtnau1VbaIFFT5WhExgF0WbPzhiBHZk7LbyL8Ab8R7xsAN
 9rn4Dc2AEP3WsoCGJA2s/CyZX3RW/x+SiGDkk7GJ0tFYKC1Te855roO8FcSiT3jYT7d9zUZqohd
 d4rHLGrDpdH21JHFhCTQ0zGwmBTgS6SaU1KJptIC7FwdFm6iUMJrE6XnGrQHAwVnvbRBjYvzV7H
 /nCNaVdLn7CY30vM84C88yOLuAuSzhCvrm0CI3zavmYWBbFQ4Ups/9TcJIwjKfgAFjvmNaM+fTO
 NB+F1QyZXwSJf4WjoMILA36ipn9JBHArkoaDwZwvEf5MlI++QdXZ8qb3RsDa8wEHs9YK0od2RA0
 zahsl6aC8vbtGMoK1Eg==
X-Authority-Analysis: v=2.4 cv=f4F4wuyM c=1 sm=1 tr=0 ts=6a056332 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=VwQbUJbxAAAA:8 a=hJXI5Qx6rLfdTxNNxg4A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-ORIG-GUID: aZro7a4G06H5nHCo9rlZn6cEucmHnMkY
X-Proofpoint-GUID: aZro7a4G06H5nHCo9rlZn6cEucmHnMkY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
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

On Tue, May 12, 2026 at 11:31=E2=80=AFPM Leon Romanovsky <leon@kernel.org> =
wrote:
...
> >   #define VFIO_DMA_BUF_TPH_ST (1 << 0)  /* steering_tag valid */
> >   #define VFIO_DMA_BUF_TPH_ST_EXT (1 << 1)  /* steering_tag_ext valid
> > */
> >   struct vfio_device_feature_dma_buf_tph {
> >       __s32 dmabuf_fd;
> >       __u32 flags;
> >       __u16 steering_tag;       /* 8-bit ST */
> >       __u16 steering_tag_ext;   /* 16-bit Extended ST */
>
> I wonder whether `steering_tag` and `steering_tag_ext` can coexist
> and hold different values at the same time.
>
> BTW, please send your patches with diffstat.
>
> Thanks

Yes, firmware can report both `steering_tag` (8-bit ST) and
`steering_tag_ext` (16-bit Extended ST), they may differ. An importer
can consume only the one matching its width. I=E2=80=99ll clarify that in t=
he
next revision.

I=E2=80=99ll also make sure the next posting is sent with diffstat.

Thanks,
Zhiping

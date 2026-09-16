Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74AFC88E75
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 00:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E48E10E2DC;
	Wed, 16 Sep 2026 00:17:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="SV3hPlDn";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E43B10E143
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 00:17:21 +0000 (UTC)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FMOj4P1531696
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 17:17:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 pps82601-s2048-2026-q3; bh=y4AfS6tr9HrRnC6D4zpOkbqwXmfmGihLXHO3T
 H7isxM=; b=SV3hPlDnkLVLzLZ5wbnt0LfyWojFDHoTKaL9JlUmAXLtdCh4GpdZ/
 SKD174SCvrUikKcMBYauckYS3JgM+tWicqg6Oj1Bmcs0oYCNvfbaKfuYGlrVLJKf
 r6OwvK9Qe/f4pBy01MEWp1c9CWkCnaxUkeQw8Qd9+jvYiKtQS4cVfUVdETDA7xaZ
 i02VojdTANK3f3sj2LsPaRR7E9gJFNv8lt86XsIF/4fC95eqm/hGduydG7DxeyJK
 pir0xIEvbcfyHKR1q53dV/4//VMrQo9fK9ExB2hkeqKevwM0hhR489OnIDrdaCGJ
 MkoepWkx0zrAKKuQkN2Vqp+EvaVdA5v5g==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4gq4w8dfyw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 17:17:19 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-80621978fddso2110660a34.2
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 17:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789517839; cv=none;
 d=google.com; s=arc-20260327;
 b=FM6+/bZIMHblwjiEWNfX35PONMrkJMmU5huqb7L3ZxWmAO/vwz3fUYtjkP0sVB3Wuo
 98eHakMzmp5RKktaLqrYR8prHAuUJmnlUwGhxMHkjla9ummxp044NhPg6Kut9gpYGmst
 lqDVJhr9unzuPDI8x/L3DHD2xa23r3KwJIgcfX+xxVDoXnKdALVVPqQdjabYA0iFAD6m
 lIP++zea1Uz4fTWZndgX3sAUKbodgpnFUjSTh3lnj0c1nBwaj1/Y4q2BTpm5gX/W57BL
 XEYQRAeyxi2Zj/tJ+LGtrI9XdtGL4q8Sj/uKxFotlQTfSG7Jr8tZLN2+QtWlydYPprC8
 vyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=Kw8qhFcrPQrG+D+0UL2QgWXn6zGjS5meCnbxBsS+WIw=;
 fh=bOKtLPJIuuqEFK4zp/tP2DAv5ixAelTZ2E8o2ObYN6Y=;
 b=IuGcZ1la+OTlwfucxPVH5PHKyQbeyn/VGiIKb0flbEAJRZNl7OXRA4S2v1H/p1jOip
 rQ0jYLKmkxuhCwONUVs2LH3WeRo4AeeM66UUa4TsRWBFrs6Q/4R5ut78pEpMTpJthxQb
 o4/G75BXkNI6tTOgVe/MuZjIuT0/KXxozNI8pVfw2Dm5fnXtA02cPA5HG3zs6JzE2i2G
 3wSTApZWPuEiTzXlVS8zJf3kZeGzOy1ltD6D4TNCSkWhY6bT/QP715HOV6PxMw/crFv7
 OVJ+LILvUSFyGkuHopj9pgB1ZsF+AgkjpH6HLy69GelTJ6jIs9gooLbt0adtqkJENYaf
 P20Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789517839; x=1790122639;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Kw8qhFcrPQrG+D+0UL2QgWXn6zGjS5meCnbxBsS+WIw=;
 b=m/NXYtKm+UoHS2Ql0nsTtMAguhWwKA38wAolqaL2DeV1JT6sn1TBHcfDp/h91QBTB7
 HqZF5/4MJMWaWr778lhT+aHWOohOWY2v7vN5G/UiLJIX2wVN6LtPi0XE+wxVLCrE1EAa
 1MUhvZuAuU6wgq6i6tY1qzssfUqsLDpUgjcMMrgdjAJqShrV+x9Qm1J5FmQsZmTKWsEw
 mqss1wS/2ImYUWoSRyw836dRp+plSah6PcodxDz8/B1XlQsvKWDnfZe4MSp8Bq7VKieg
 HCYOOZB+UXpwaZZ7NkBuhP0si7h8NHq5rOMuactmq0lC6ukM92V/RQOO5gWAgnDkaImi
 QzIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7ur0+Wx9bKtBxVflcrmkOdxyNP1MzpB+LLhoAE9joiwrMupsYcYWgUE3S9qZ/53pwLkNyCszZNJ8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n3Ar7XTm+ZPxPpw9ZBDay1af2u3Q7cTY/j846lQoVGYe6VOKa+
 EyeTD/z9mR2jbs/GNDnOWitk7Q976+seBixTOi8kdggKpAIykImVqsxzPhMwaLawRczunHqvg1g
 +2tO065QoHwzUYlsdAidHo9RFM5FzXzN8cPvOke/a1Frx2DHLyQGCns/Vdr5OGivs0+RGgfHCKU
 a5xxaLQ3VTa/afLb3k5W86UVHdfeC9b6B6UVZp0PfpigQ=
X-Gm-Gg: AYBFou0RqCt8riyVZhAOvSRSmfNxdH1kJt58eamgUBS0knpnWzEXbLjsO4gCdKWfoJ3
 DupXJM4woZFb56pTk7XzLhrsoT6jvlLvJ9k2FmtMNxQTdxay7TV6AJCKbVC0uLq5Is5xOBKXLOO
 xCcUB0AUzQ8oeZQ/pX/aQx6KCU+H2FnA5BRHKfoCWTm33PT/ppYPZHIv8ouFnBM4H542HN4wmZ
X-Received: by 2002:a05:6830:d0a:b0:7e6:d54e:8fe3 with SMTP id
 46e09a7af769-80b2d408fadmr803749a34.9.1789517838960; 
 Tue, 15 Sep 2026 17:17:18 -0700 (PDT)
X-Received: by 2002:a05:6830:d0a:b0:7e6:d54e:8fe3 with SMTP id
 46e09a7af769-80b2d408fadmr803625a34.9.1789517837178; Tue, 15 Sep 2026
 17:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260731211601.3033906-1-zhipingz@meta.com>
 <CAH3zFs0vQidHOWif_LmS0=65S9iiCo7yGibqLvFT5jadjj8wVA@mail.gmail.com>
 <CAH3zFs2XnH6gT0fO4=WLi4x1SL2+Y0S=Jo45SWkR=unPegQ8Hw@mail.gmail.com>
 <CAH3zFs2X8=x-XMXhwC7_aUZivCCPQOSuyXMy-ryKqxLEFY9u-Q@mail.gmail.com>
 <c0c8dea4-1571-482e-be33-f965c7c357d2@amd.com>
 <CAH3zFs3=t3rNDDjUsCAekfhEGOJPyx-YXKta7NdHy3kBKU_RHQ@mail.gmail.com>
 <20260915144901.554f905f@shazbot.org>
In-Reply-To: <20260915144901.554f905f@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 15 Sep 2026 17:17:06 -0700
X-Gm-Features: AcwNN1UDllFH7fZheftU62Oc0zcY8368FZvRR7u05GnfBjshQDxnxMnIHm9x8No
Message-ID: <CAH3zFs3MwpxLNL+qK9e-jPBLasjfxeMvudhgz5XzwrtvL1Dz=w@mail.gmail.com>
Subject: Re: [PATCH v13 0/5] vfio/dma-buf: add TPH support for peer-to-peer
 access - ping
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=D7HSufRj c=1 sm=1 tr=0 ts=6aa9e00f cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=r1p2_3pzAAAA:8 a=tEdGRIS0mffteslzfD0A:9
 a=QEXdDO2ut3YA:10 a=EyFUmsFV_t8cxB2kMr4A:22 a=gKebqoRLp9LExxC7YDUY:22
 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDAwMiBTYWx0ZWRfX31bV/edHjHpy
 BVnvDTtiU2v0JY5C6Mqk/jTRuRb/nWiQOTJROLbIu9JiaQendHxHHacVddzs1T7IND0mBgar5yt
 KQZYh5JtMtJ+JD1GGrE+eYk67ris/rI=
X-Proofpoint-ORIG-GUID: 9IkJFQli8M-5EbMPleOJlPgAPdEoxYUY
X-Proofpoint-GUID: 9IkJFQli8M-5EbMPleOJlPgAPdEoxYUY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDAwMiBTYWx0ZWRfX95sMiXi3aLvB
 bVCx9PY7KGRjyDGPQADkD9y091vrhw2a/A3o1mg3rG5SKs5SzFAlUAjiX6wn5XpM4+fDMIXT3vY
 M81rnRIF+Wm1JjLSRgRuGV3rpl+8N8xG7wAZ7CsEYy1pKZdvgey5Y0mbh7TrpatnsIDQHJNAFok
 76mCdaUOJseiRSBiZyrWeSFPgW9ETLVsrFM7+JvfzvSE0HU9A9Wc7xxkNf5iGsdY12DFmxHGGyq
 tBtk2veH0wsE8n0KQOU3RdYCjd07+j1BcyC/XwmYXs3ni5M3gzAFNbUkgLcB8lr9u5LKelvwlXU
 1Ap1Auq+e7O42O6TpXpXgkd6ZTiDGid3L4KRTwvKbFvSjelEnwHzJZvSJp9akcv/93yIhGUd0JA
 5YFZbvVnROzpvdluuS7Plj4UrRpKmFDPSDIqfEYJNYcSF3MJFCxmgKexjUn+eIt2cNZHLboJdQf
 8PB9K4I9ofUHPASJvXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
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

On Tue, Sep 15, 2026 at 1:49=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Mon, 14 Sep 2026 09:44:57 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Thanks Christian -- no worries on the bandwidth, I'll add the Acked-by
> > to patch 3.
> >
> > Hi Alex, Jason, Bjorn,
> >
> > Could you help with reviews on patch 4 (vfio/pci) and patch 5
> > (RDMA/mlx5), plus acks on patches 1-2 (PCI TPH core) so the set can
> > travel whole if it goes through the VFIO tree, which is the route
> > Christian suggests?
> >
> > I've also rebased the set onto 7.3 (base 5225b8eec4c9) and retested on
> > hardware -- PCIe analyzer captures confirming the requested ST and PH
> > on outbound TLPs, no splats.
> >
> > One thing to decide: upstream took 13 for
> > VFIO_DEVICE_FEATURE_ZPCI_ERROR after v13 went out, so
> > VFIO_DEVICE_FEATURE_DMA_BUF_TPH becomes 14 in the respin -- let me
> > know if you'd rather it be something else.
> >
> > I'll post v14 after I hear from you. Delta from v13 is the rebase,
> > that feature-number move, and nothing else functional.
>
> IIRC, we're pretty well settled on the vfio-pci front.  The feature
> number does need to be iterated to the next available.  We still need
> acks from PCI and mlx5, and given the extent of the mlx5 changes I
> expect I need to provide a branch for Jason/Leon once I merge it.
> Thanks,
>
> Alex
>

Thanks Alex, it is great to know the vfio-pci side is settled! Bjorn
acked patches 1 and 2 today, so PCI is covered.

Hi Jason, Leon, could you take a look at patch 5, the RDMA/mlx5 consumer?

https://lore.kernel.org/linux-pci/20260731211601.3033906-6-zhipingz@meta.co=
m/

Thanks,
Zhiping

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1851ACD6E45
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 06:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6748E10F96F;
	Fri, 29 May 2026 06:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="tE2F1C3+";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34C6410E062
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 06:34:52 +0000 (UTC)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
 by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64SMkqMq1178533
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 23:34:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=ZiT8x+cfHgSyrwMnA66rNUoxHkXDnwIwkwrIcOdA0Bc=; b=tE2F1C3+IWIc
 hD6uPAo9NgDmLx3SiAIqN6xdU/vi1BTlNSH50fpgV8+w2z56TbYNWRvwyATimLcQ
 6gBB7u+bSsBhHZxDEcSgqK3/4LhMs0I3XhEpCctNiBQjacxzZ64Ht3GAKINKXsRe
 2a4b6ZZDgp7DFIXB6NZzeM/x8uiRnSviRZdPNOFY+C+No5faqHXGRxg3ix2FcSdL
 ETSBtsgPPA9Za6p83WxjzQ6xcL+i2YajrLWFKyrDiNGr07q5cwUoyo4ikTdnEkY3
 yiwI4qfRPsWTAFXgnVqxw2XBZSbFpE5+g2k/neK+34pAldo7nom/u4tzd6ac5WIM
 FzG4O2F7ag==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by m0001303.ppops.net (PPS) with ESMTPS id 4ee7xg2915-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 23:34:51 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7e607b85521so7537405a34.1
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 23:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780036490; cv=none;
 d=google.com; s=arc-20240605;
 b=cxybcnj6VWFdrzjoxDVf5zBvtoA7FhghlCwFeLF9JxToGX64HEiDibHFpJJEVwo/uT
 c+9C+hqwZAKEWAhUb4RkKYWG+/JuqSR8hnMEt6efjelWET4h936tLnk6qU8P6JAl45K4
 MbL95wlVAcJcUsgGUZa3s1o+cs+z+WgvoBPLTfkGBwkJWzO5k33Xq+Cqf6cFMMcE1dyc
 9W0Mlvj1nRAQQ4ZZkKuctZPeQFi8A5fCyOTX/SGd1yqWr0d13eRej/EPbk7MmosFWHVy
 XULesrQW4/PZLsZQMib/4jArEAe8ARIez8bfFcg8Lr7z3iU8vhIj0XAIfZYEzvDXIO6i
 oIvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=sjBZwiGe18mw6X67+Um2SWVYDlncy8HfxAJKV10muTE=;
 fh=nHeR0mGKfP+DTnX2q6bBHgU/uu8T6ioA8ERLmkTrwGw=;
 b=VmPG0aW67LWsM1+li7mzGFDhgaujRu9d2oL13bLZfy5aSl7Lv1jcB62ds43iyr2H7D
 ayyLItpF6nr2j9tutMbul7CSxDJzXFYNLYCPz+vOWsIigvfGgIfe97EAXON78wLrsUFP
 +oc2WBOB7m1hGACI2V+Ix/noali+pHzTCNMN5x6kM5ypzzxdUsXExrSNZnXAkq4HcXEo
 dT37DB5K3VYzRwR9ye805ok0Ltf7QT5DiYGnRllqSG28LQ10eTeKfkPfYqhKMp/801MW
 wf0hVM3kymB/iMLahTLVo8j+MJ5YQmThB3IiYFYtterwvVbwNS2RGiReLnzIvuSmvVPy
 cLIQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780036490; x=1780641290;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sjBZwiGe18mw6X67+Um2SWVYDlncy8HfxAJKV10muTE=;
 b=V57ztWJ5rB/rebYqO23zbtmZvZztQB+QRZ0H+srxTr842KXZH5n4q5IwXDnw9324nj
 yZM8PIT/W/hOjnXRS5vNrp6shnR3JpepuT9G3llh6qvS4X/B2u77k/yhO6EiZJSywT4i
 7+cq4tGvcSn31dYzpUwencU0KiY53BJGir4yQFj01D6TfECXqAy249pvDsB3Kd0wzNC6
 tXfJ5dzosElQZqrvnjRLqny3+506p7TjvxbBlTjaOG9+hnA9+L1y56W17S1U+rGsm3QN
 QB94/bqkgv69LmodsTMy4Kr7JxfHUS/MX4l5wzemj96Nz++naET23L0xsv2uUz5Gt9bs
 hEUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8A6ThA5LVMO+HcEqxHnyLL4Iqc4DzlwQAikM+DBPiRNkJ7hfOQT5mZXTIWaKYyDtOql51k0sFDalM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDI6sh9Z30FFE4Uc6xahcmO5ZXxIiTibU/j27YV+8I3ozfNAbM
 Q6ytWgdpw7rd9bfuvpoDAKVUINcX39vgyobI/PMA25bVXDfVzsLqXjxvSMAzYahE+5WSzCIo9vY
 bJVHo4kRKAaC6kpOVLpnlV62527fsldahdWygU2/BDxCsG5yGwbPQrCKeEJNZOIUR+keUeG3+jt
 8z9C/SnHmu5iXjCXHqSmAErfHoey46U3J/9IjzqLoWB0M=
X-Gm-Gg: Acq92OE+FG/bX+Fwc1UBSaQ3BwZMcf5DuBFG/tFaSNxlnWKh5gdxSn/Xsxm4tF2gc9F
 ArZu8cv7rixIfHY5ZLY31WdpXxoP5GWh1/0p8PllXWF2IhHLqi8jSt6CCC5B4vfypPGlvFocjbZ
 Bc8PAcBcUJm+NDxMzvHXrHKDV05CvNmuHkolR8Y98hl1GsTG4H42UOkv89iFZCrXZjFGsbo4Ana
 m0/ZkUZJtvoSh6b4JeA6t4/uhlNiXDEMxVAv4+ofiQen1qSSm0=
X-Received: by 2002:a05:6830:8285:b0:7d9:d2b6:1568 with SMTP id
 46e09a7af769-7e694dc2b7cmr1101938a34.17.1780036490370; 
 Thu, 28 May 2026 23:34:50 -0700 (PDT)
X-Received: by 2002:a05:6830:8285:b0:7d9:d2b6:1568 with SMTP id
 46e09a7af769-7e694dc2b7cmr1101924a34.17.1780036489896; Thu, 28 May 2026
 23:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca>
 <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca>
 <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
In-Reply-To: <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 28 May 2026 23:34:39 -0700
X-Gm-Features: AVHnY4LezOs9bV0UClJoUOHcNCdwbl4qfviQEKqNUnQx0j2Atcq5JV3HHpZqmfs
Message-ID: <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: YcgiozHObf9YpNtimkTtrNi5T71FofC3
X-Authority-Analysis: v=2.4 cv=demwG3Xe c=1 sm=1 tr=0 ts=6a19338b cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=zd2uoN0lAAAA:8 a=f7uq7ceqOUF8L-MFIRoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YcgiozHObf9YpNtimkTtrNi5T71FofC3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA2MSBTYWx0ZWRfX0Ww+Iu2sx9BK
 78DcOipFKGmBiDRW23xCNWxGqcWZcnRFvUAoDSiAoN5qg1Rul692klI3F56y5M1PN/jRIskilgo
 AuA2XW6OqrZ9KLT70UjI1bSaxqQnLiQIyZx8lJn2Yh+N5Fj+5IIVnJfdaBbfX/lR+th7OGy+7Ft
 eAyUD9J8NsJPJ+o+TOcjWCOVgvoBjB0WcN0mH5scJQEpC4yd1Jy6s4X92KUO5B3H4MAthQXiR2R
 Xy5GhMaS3T7TSR26OoeMuOXP351qGAHUrkuypnGF3nEGG23utszPVA7X0YAMFzqOO7ZkZfwr11D
 LYOftvvNiU8srthE3RRwHIZhNmmvzO4KZ5owUCjKRKp+Ri1YAJyS7EfNcTRz0tIFd+NmAKkhY2z
 S4mcRUWq3NC0nm9IYtEz4SGIlCeoBkrXrjqkjCPutuqhsnIosJr12SUt7JkD0PArT/kfe6ChYsq
 gnpsutBKaAchhWc7oow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
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

On Thu, May 28, 2026 at 12:46=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> >
> On 5/28/26 06:55, Zhiping Zhang wrote:
> > On Wed, May 27, 2026 at 5:53=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >>>
> >> On 5/27/26 14:36, Jason Gunthorpe wrote:
> >>> On Wed, May 27, 2026 at 02:23:46PM +0200, Christian K=C3=B6nig wrote:
> >>>
> >>>> Yeah that's a good point, I should probably rephrase the question.
> >>>>
> >>>> I'm aware of how TPH works by adding the extra ST to the TLP.
> >>>>
> >>>> But my question is how is that useful to a PCIe endpoint? What is th=
e effect of the ST here?
> >>>
> >>> TBH I've never heard Meta explain what their device is doing with
> >>> it. At least it seems to be super important to their device..
> >>
> >> Yeah I think at least a brief description of what is going on here wou=
ld be necessary for the review.
> >>
> >> Otherwise we have only the info that the exporter wants to give an opa=
que ST for the importer to use and no technical description what that is go=
od for, how to test it etc...
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Jason
> >>
> >
> > Fair point =E2=80=94 I'll add a couple of paragraphs to the v6 cover le=
tter and the
> > patch's changelog as well.
> >
> > The short version: in this series the vfio-pci device is the completer
> > of the P2P
> > writes and mlx5 is the requester. As Jason noted, ST semantics on the c=
ompleter
> > are implementation-defined, so only the driver that owns the completer =
(here,
> > vfio-pci on behalf of its userspace owner) can hand out a meaningful ST=
; the
> > importer treats it as opaque and just places it on the TLP.
>
> Yeah but that is not really sufficient to justify a driver 2 driver inter=
face.
>
> Which PF driver is backing the vfio-pci and what effect does sending TLPs=
 with ST to it compared to TLPs without an ST?
>
> Regards,
> Christian.
>


There's no in-tree vendor PF driver =E2=80=94 the device is a Meta MTIA
accelerator managed entirely from userspace via VFIO passthrough.
That's why the ST has to flow through a uAPI: userspace owns the
device and its ST table, so it's the only entity that can publish a
meaningful value for a given dma-buf.

On the effect: the endpoint's PCIe ingress block uses the 8-bit ST as
an in-band instruction for the incoming P2P TLP =E2=80=94 selecting a target
cache partition and, on writes, an in-flight operation on the data
before it lands. The dma-buf callback keeps this opaque to the
framework =E2=80=94 only the producer (userspace owner of the VFIO device) =
and
the consumer (endpoint block) need to interpret the value.

will include these words into v6's cover letter.

Thanks,
Zhiping

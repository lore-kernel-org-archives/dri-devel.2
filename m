Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB99CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 23:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A237010F1B9;
	Thu, 11 Jun 2026 23:06:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="aAliD7hP";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 431A210F1B9
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 23:06:14 +0000 (UTC)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BF70wf2135131
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:06:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=efsnF3+1jWR8pvzMYJfBE7lVlQMbzzxbwMqOReRrznE=; b=aAliD7hP4Pnb
 sDHga9w9vOIaX4gPrLDH9CxWfUDul6tHQH4Xi0x95taVkfEY+GcuJ5llY9o7rdU/
 6IxhrOtNRPf0TZXzirIqsi4bvN0RdnQAebO3TXTwQ1ciy0nZK/Rpu2xM5w244SPJ
 RXgJk7lo9T1WisKqszJAd+5MNgI/KlpyBjNrdHxIF9RMJjY3r8Q959ivZHAEzgoG
 khu0ku8hPaoN7AYRRbn9WFZIlTuHEdyYgbXmb7kn2o0lgBqUwRaYgCIBG8ogF9SH
 Vazr4Xq0IrMxhXUedk59GhVrJIceY2weOoGa+2aM1YsFU9fskt3OQlTECK6T/8pJ
 mXSX9Zuhtw==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe81sasu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:06:13 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4863c8d459eso453962b6e.3
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 16:06:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781219173; cv=none;
 d=google.com; s=arc-20240605;
 b=HOLEmTxbmbxzl/yWqywInr5Nxs7m8oBzhkMJMqrwauUzk1029Fos3Wf6/7qY9sK9J8
 siZcgKv6JKW1uVLeONI8baPm40KV4DTd2L9PKUvt8NP88bmlWI7fFXXggEuiRNnyh4sG
 BIUU18cEjjS8Dpj8szUxK9hT/Oae1toUmomds41Jk/u6EP8pPiAbBjpTvrsXijS6qiB0
 O2VPzzc94zhkGmhGsD4chg0qloIRFHUUH9Mia4KpfeNP7yXHBFqjp4mATEyiLc1BvS7j
 7t35/JouMc3jNG+o5LuUCSsLloylIAmfLMSLB2zwGTNZOL4IOl+sYGyR2uJxDTI5gTWA
 c9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=5o88lgTdR3UljadKJlYcq0XYptrmydXykEVU7qCr7g8=;
 fh=9dFXWPPSq314KtnSCgvkZxFyQJPxDUTEebxIq6UhW3g=;
 b=BVDqFy8vHc/e9AF2lcQ4UIgp7a+MkJ4IhvYLqwNAJMrlnRmPwWu8p8KlHJMaTol1Gt
 /9JypRGCZFXv5g2MNXzB9mhUXKLnQ7Mp8J7Oy7d52wulebNDkXN42/evboOp2qT4666u
 t5uIxD/SwaBFWP7EnnNfJY4fuTaqQ57Ub394dWSByp59gN/CYb4RB2F+TGXYlfhMzuoQ
 7unGQdi5RILeUzmtIPmv0dCWjxXSE3fBtAYnAj9Ugx0rTk+b35pZBywvCV7I3z7KMNjc
 yrVkjSQtYqY/mm4zFPUjDO4dvftmH34EPKje0kE4tX4bUaR8SczvoxFn5tzCvt+Pb0Qk
 7w1g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781219173; x=1781823973;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5o88lgTdR3UljadKJlYcq0XYptrmydXykEVU7qCr7g8=;
 b=G6xg0Cl0uZoeLiuI4nEyVHUwHt/CaOPuz/sncWgrZN/G39bRQxQIFsFnNzmg8Drizw
 r3vG56Bi43DThTU/68bHxJ1oqX2WqyxCUNUQAzXBkEiUQDwZBqISux8Wo7ffgZZF0jsi
 KwJOhsCb/O4kG2wfkAGWa63uMbsb+eqRJ4dvIupUOmANXpryGbi0zkmvoSSWQEvP/dYw
 mSPEsUdoWF9l8SWdxQno/6X7DbeFWWc0zMrbrkME1Gv3cxwAfqAEiz06IOw6klI04cqK
 W0/YHFYiFFwvNICvCcO4Cke50YxuYPaEo7L1iXNhMsDE2vbelxvtGwXiEuZzRU8O7wP1
 bRYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+g83KJ05Yw5TjYehKJ/XA0dKgzC/AmPMbT0IF0e3Ql581ef5/V9NpdTZ3RTqQAwcLNu/UKX3ZTCKk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyd3hRCNUQPNfE90Yt4QpKHIojv7mWaOxR/Q8vjLI0m3cvMa7wd
 yLwF6vMRHz7nsIhmkBsylM3Db/ZJiKUTGDHGbeBujyVFRgo3WBIObgJFrXXUGg+VEByJoPopxmp
 qkzdGAvmGq+akHULOhltYgijuxg69bpfAGMxCBvlJkDD2Hx/qaRddHQiFy/5aXBRIVw58gL2Tv1
 bY8w8WvRuxVPjcJ30hjrhbRcCoQxEWsmj1ijQNgId5CTk=
X-Gm-Gg: Acq92OEc7hjDAZYyy/Tn2dXp0Qszk26OnwvQ/1lLovsG6dKlU8ecsHyGivxaVTE0FxY
 2AQtEDjYVmALmnGNA/GuqSD4jfkHfmc6kn8CbZJHLlQkMcuRJNR9Ijm8DiuwvoJ4TuFr9G+q5tr
 1GvyZdKrsnc3YgQMunVMuMjnl3JDYZGC+3BGHNJZyRFh+GnqemnMRi60dgyV6HdAjthqVtK7UIM
 gm2LeOcA5Dg80YwEV5gOA==
X-Received: by 2002:a05:6808:3089:b0:486:3498:d1ae with SMTP id
 5614622812f47-4872f397045mr351962b6e.18.1781219173061; 
 Thu, 11 Jun 2026 16:06:13 -0700 (PDT)
X-Received: by 2002:a05:6808:3089:b0:486:3498:d1ae with SMTP id
 5614622812f47-4872f397045mr351942b6e.18.1781219172624; Thu, 11 Jun 2026
 16:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260610193158.2614209-3-zhipingz@meta.com>
 <20260611202558.09C691F00A3A@smtp.kernel.org>
In-Reply-To: <20260611202558.09C691F00A3A@smtp.kernel.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 16:06:01 -0700
X-Gm-Features: AVVi8CeJj9q0ez37YfrPTO2KXyhyeT-bv8zCIdToMWZsgp_4cN-UqKdyKzNGj7A
Message-ID: <CAH3zFs24Gs6MSccrNoP-UmowvpcV8PmweegczKU7Ymq+kMtdxw@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] PCI/TPH: Add requester/completer type helpers
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzMSBTYWx0ZWRfX3w+N3eANpbUl
 RDIqpru3vtv2z2AC/YsaQrh9//OuE32zCYzFvo7bW9Wtcx5w8eoX2ga1anL9sz4MrhpPPkNzTWM
 cTGWCQsnAL2nz+6SLALMt9sRd+vcSQpPE20WyxJfzAqJZZQL8GjV0duAhf/PpunR1o9zF85dKdk
 w3nrzGgBW4OkM+ELk+IiaXcJKoTH4z+uv4wCdpkhexVR7rleTO1x1zkBkdDFELN17tenRJ2qRZ1
 Hs9xUQaWZIMtf0xKbQG8QGr88uw1FE3b8CVA0etoC2NVQ4qZjkVbw+sRtm5pPOkaHG+54w679MM
 kFq++k6qeyDg8Rp+5Qj0pcT5UPJJmHO3Bl7ygZMQiEQde5SmI8mhbg8FHBFVz/QJZJ8pzM+UexE
 OJJn1PLe3jgAx/opAdXyRJu9gZaL6CeJnfpEHNHEYIWgQEwCRBwdmXS7zTQI9MbMIAnoU/RWZzM
 z9Ea9LH/iXaVYtDGlqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzMSBTYWx0ZWRfX1ZW6M+uj39Gv
 Fxtq+sUgoYAjuRO6yPzggbREjC168uZNleD5iLclJb40qx/ZcP7r7DSWYUJF7TxeYVUxxcoICbs
 o95SQjoJVeJVtkm9jc4W1zPRGfahu8Q=
X-Proofpoint-ORIG-GUID: 6BgozEhNjR0A8SDJ5pyFdCYie0Kt1jy8
X-Authority-Analysis: v=2.4 cv=ToXWQjXh c=1 sm=1 tr=0 ts=6a2b3f65 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=VwQbUJbxAAAA:8 a=4OgE2WNpP8yww339eGMA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: 6BgozEhNjR0A8SDJ5pyFdCYie0Kt1jy8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01
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

On Thu, Jun 11, 2026 at 1:26=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> >

> > diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> > index 91145e8d9d951..4fe076bba953a 100644
> > --- a/drivers/pci/tph.c
> > +++ b/drivers/pci/tph.c
> [ ... ]
> > +u8 pcie_tph_completer_type(struct pci_dev *pdev)
> > +{
> > +     u32 reg;
> > +
> > +     if (pcie_capability_read_dword(pdev, PCI_EXP_DEVCAP2, &reg))
> > +             return PCI_EXP_DEVCAP2_TPH_COMP_NONE;
> > +
> > +     switch (FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg)) {
>
> [Severity: Medium]
> If the device is hot-removed, pcie_capability_read_dword() returns succes=
s (0)
> but can leave reg as 0xFFFFFFFF (PCI_ERROR_RESPONSE due to master abort).
>

will fix this one with check like below before the switch statement:
 +     if (PCI_POSSIBLE_ERROR(reg))
 +             return PCI_EXP_DEVCAP2_TPH_COMP_NONE;

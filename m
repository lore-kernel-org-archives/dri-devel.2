Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EEFC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 21:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C5610E3F2;
	Wed,  1 Jul 2026 21:07:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="JriekQid";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CBDF10E3F2
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 21:07:20 +0000 (UTC)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661GqCE6088348
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Jul 2026 14:07:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=24aInYXtnwOY36q1nTcGx+GLSA67zMg6UsmTMMOvEvo=; b=JriekQidIHFn
 3OZIro8QTgAFnzTOmG7w3ybAxj4FiStpeTTRGBLMAMypxTBXO/RGcUhrKlV7/8+I
 NGp2k1oxd1md4lnH8eLkzcoRP6bO/irin9BMsg0lfaoBV8svypOfCmDIAXLNW5sK
 GtZ3MwaSl62Wu0/6dVeDLcyETxRKmxu3+aaDSQG1+4lqXzSIaR/Z73n1wWbswdiY
 JS+tG40E48v0uq/02iJ0qwE/0HOR2lWNrkfJif1YbJnyfmSRCgkJvV3Ifv5Qcrni
 D5okVxBynFuMB98gOqC6WhFZmaUI875K2RzzzSTr2Jczefn/3aJenaP3WDlVdFCR
 x47wIFjeLg==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f4d405t6d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 14:07:19 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7eae3ac0072so670184a34.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 14:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782940039; cv=none;
 d=google.com; s=arc-20260327;
 b=ADwdxMq+FewtWl+QIaxe2zw3ds1C2BclMRzeSztcITQk4bdKO0uzaUgCfhlnkb76W2
 oXw2rQ34Uu7bMqFUkEcRGB8VAC98SJVPkC7/T+glixZ6Kbn1gF0S64zIfdJxJHtvKpLW
 +RLqnuJoXl4Afu/3sfU6eyLYkbo/6S08pyTnacKRRvPpD1CDM1bEKz8qODJaznWgPKOV
 3PLramQ/VBxF2ELll4CWfxyhH9L4cdTwQ6XYtAhxPgAYzNpK6jUyKzXYG+YEpgKdgbCv
 R02IinWPTWik4cZKvSEbUkUJQeGBM6tN5q4vxlpjLRfGToM+agVB6NMmphj4gHVNvssp
 b4mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=24aInYXtnwOY36q1nTcGx+GLSA67zMg6UsmTMMOvEvo=;
 fh=SzoKwnbTB1QNML4TlX5luFeHC5KwOh2A2GsRxIUjSxE=;
 b=WEEk9hgB9m4p/UoS00hZ7shjH61c74HJBvCaBOEnGQreJ6dNAf2/kldEY51/ceBnUb
 i650Ka2WP+dI8LPepnY5dctrWzFJlgl+RLqOX+99ZtuN8kJNWd7kRLSANvGHULamXeDU
 rhF6ry15XV47TY/g7stletwZIHi/UXQV7x/wLmxWKP0EJMHzT3gRz4rAKm2o66IUQDDF
 iXfLbxZ36nvCwdT0IQdBz0QzoFuR1IH6ytYoqD3aRsKYkDHR/5y4YbEN2w1KjG2OMGbW
 5yNeiXJwQlzelvVWbaiI4rKZugiazXF9MIvMqRZIBQ6kgI9uS7byYscwAIK95U0Zgz4T
 8EyQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782940039; x=1783544839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=24aInYXtnwOY36q1nTcGx+GLSA67zMg6UsmTMMOvEvo=;
 b=dvOwd6PbjD5daqR0W0Tz9RWhyzn+j5jjef1zalR2J3LvFx4TKZrkqbZJDHp+LdOjVR
 uolcDg0Ze2Dh8nUV7NYCqLtzUY/mW8Vs1uY6ffBVyBVdSXuFacEQttMhqxa5x5NocH/x
 +BjwKW3CdRf3WslxfB+a9e2BqQQDXSQN5rkMDQQYGSEdeXigNjdsfoAKWw8P16HU0gul
 JG0KavWYf8PaYDtaRBPVFbtp0vIvQ1SMogLolZABWsUQa2efjyJ3DCUw8ehdm69uiueC
 iwfFbYriJJJmzEZrw+7SweKX+ZjBZvH453yJTR5oWKsG6zNXWNsYVMbkMTfugc0PKcZE
 hRrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EeHcMrzU2M58XXXV8TU6ySD5zZ7aKWGzJhurXaesLeifmOj4SHdn558iCunucVsy8eiLpuseska8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxKIux2XXLURAuDluEiyu0glSF9RywwaO7o1KP7NXJwcmV3a7P+
 Ja4toKHImmPhqCxrhWVKRz22jIX4Dw/nYob4WM+Koc139zNPoMubATUyVIfa021iof4zj2fPCHm
 OpMbvw7kFfs9x6W2DIP3DKG1njrgdi4owZgu7iy6n0ktgEjOGjtiOuT7ksdZCZObZNNZCUHlLv6
 Pdzm6XFu2p1HWcPZInkPUDkxdq0rGplI463BaWK/oRKks=
X-Gm-Gg: AfdE7cngfgiPeHna5mJYGJygsDY5Jiujry1FUjA6J/xKDl9cQnDDb5afQR6x9SElSTy
 5QrNJW6aHQ35Y2x5mmQh05XyBFfgubR759MXXkG3Ul+F/qqzPRPbQ8y+FEHlXFtGiPbEQxaMzl4
 7BOOeaxjoTDaUPzn7fvCe3G2VegpaDGzZPBQfIeuWF03P6tpF3OWn5MEf8x0EKtB0IzykxtJ30O
 hjNr5vZEA==
X-Received: by 2002:a05:6830:82b5:b0:7e9:c481:ff8a with SMTP id
 46e09a7af769-7eb48b0dad2mr2267498a34.11.1782940039028; 
 Wed, 01 Jul 2026 14:07:19 -0700 (PDT)
X-Received: by 2002:a05:6830:82b5:b0:7e9:c481:ff8a with SMTP id
 46e09a7af769-7eb48b0dad2mr2267473a34.11.1782940038625; Wed, 01 Jul 2026
 14:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260630224328.3218796-1-zhipingz@meta.com>
 <20260630224328.3218796-4-zhipingz@meta.com>
 <20260701120700.58bcafa1@shazbot.org>
In-Reply-To: <20260701120700.58bcafa1@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 1 Jul 2026 14:07:06 -0700
X-Gm-Features: AVVi8CfZM9KJwSZGN9TaUIufGVTMoHcKZ-xzBFuNkplSBdDCFbtywxUsQs319WM
Message-ID: <CAH3zFs0bmTTTtw-WZsbhFqzdPfriwOOqp4XAgo4TGekA8HYw0g@mail.gmail.com>
Subject: Re: [PATCH v10 3/4] vfio/pci: implement get_pci_tph and DMA_BUF_TPH
 feature
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIyNiBTYWx0ZWRfX9SF51ygKKKkK
 IEN64NREXhUUpwQptJuYUWrjQ2eKTCOQh29DLCMO0SLnbMcj0gAXenZZDgtDUuWs/hHy3hHyHO2
 Or68EygbbifLAPFkSJTdNPyMxFYx0qU=
X-Proofpoint-ORIG-GUID: Ef7L3jMqZbM-fWbSmQT2zCnD74ztnuhj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIyNiBTYWx0ZWRfXxFFa8znBo2sS
 w/IqJGLT4lgN9YjR6PCsjb5LDT58acABhtOXYBmzRwQ4q60f8WXrKikzHcAcm+3R4Dq+sYKOBbO
 ytb436Iw+Jdzu206cML5TWJtlh8TrCIJ4bZO9z+AzB0YTLG4iI0cDXBemb6Z6Br/HEpENUNKZiz
 515wQ94XyIDENwBJHRCwU/WVKdp2reWIUFw5MX75rPUUFgGdlnSjutUBJ0BSImtGNljqe9q63Up
 gj2U9nNJyrbXfPOXngts5N7BwrZDA3vsO3FytyTwwtIUUvOUYuCVFxIvKan53gNQUNWCKO0KsoT
 X2aPVZG1lHC/dT/4LW41Mobcgo3ImCo5brUYe7x0qTzUsFRQE8hTvv/J+GWOyoqDB9d+cggYsrA
 UYN3/1p2bPpgtkO/KlN5nUHOPTDcCK61ccTpq1YTSS7m2dPADLnRjQsa7dPPvt7mzykaI8jRig7
 A1zGOxLQQ4VXWY1RdnQ==
X-Authority-Analysis: v=2.4 cv=JeWMa0KV c=1 sm=1 tr=0 ts=6a458187 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22
 a=VabnemYjAAAA:8 a=r1p2_3pzAAAA:8 a=vGJ5o9TXFsc4WUGASEEA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=gKebqoRLp9LExxC7YDUY:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-GUID: Ef7L3jMqZbM-fWbSmQT2zCnD74ztnuhj
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

> Since it seems there will be a v11, note again the comment made here on
> v9:
>
> On Tue, 23 Jun 2026 22:24:54 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
> > On Tue, Jun 23, 2026 at 11:17=E2=80=AFAM Alex Williamson <alex@shazbot.=
org> wrote:
> > >
> > > Nit, it would be more accurate to say:
> > >
> > >         /*
> > >          * Updates protected by dmabuf->resv, @revoked additionally
> > >          * protected by memory_lock.
> > >          */
> > >
> > > revoked also has an unprotected read, but it's previously existing an=
d
> > > benign, and likely just needs a READ_ONCE() annotation.
> > >
> >
> > Agreed, I'll update the comment and add READ_ONCE() as well.
>
> The READ_ONCE was added, but the comment remains as in v9.  The
> READ_ONCE rationale should be described in the commit log too.  Thanks,
>
> Alex

Sure, sorry for the miss. will do!

Thanks,
Zhiping

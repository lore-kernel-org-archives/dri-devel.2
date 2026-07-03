Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D682C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 04:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8142710E32D;
	Fri,  3 Jul 2026 04:11:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="GULRh6Cs";
	dkim-atps=neutral
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 830DA10E32D
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 04:11:46 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5aeb688ae83so32969e87.1
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 21:11:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783051904; cv=none;
 d=google.com; s=arc-20260327;
 b=EHwTOcAtJFTtWWuIDkfD/MahxEAXXXJ0+roE9bW3544H81BCx1OgvB7QGbEruWHYFG
 AhBA095ZkCS9CGqgCM0JMXiCQXO4dU/D5hXxRUXLTvFncnyUsFnhbhaki2UTpJ0ZxyJO
 iX4SuKdUq3iZooi1MTqMtmHwiURYECqYaX1UqQuwNkvunxFkc26YKWQlNuotRcDbJdeO
 zjKQkbwQ9nT3YiYJDLan9p9P1zocg+dzyfTuqrwXnEKbsEYJQRtmli5NpZqWSBPRJ7RK
 H7QQlp0z6Wh3OVfGK5IBRiIM2Bp9YBNZkJLBYSPmQNTQ2Pd/j3JXFrmlZ6cLtB+yH9Pv
 xqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mYG5gbdqiZUgRx9K2qyqNMU3tiBr/+AhYbboeAOaEGY=;
 fh=zLU/U7BQ3LWqRN0t6G4+Y5/ZxZp3kTL1s1M77GewQfc=;
 b=GmlWHcF4ISbgn3NREu43QctRpEZGtUiHZnMAiHjPWy6Q9JbiWab7qNxEDYBYcGGzy8
 R45OBscFZuf2PtrYaS03QEQsKOl3UZSlW+4SDkuiap3ETKswbKdNKBdVW6k75Qv9XQTl
 Szwpk3MT3S/TJPt1YcJqWv7d/q6nUTJHlhx0QB5ynlp9yUCjeVO+vx1FYHDvx0q57OP2
 rrFkZiZC7YTe+MxXZYlZp6B48K1c3Bw2XyMEz83FejNtWYHLhzk/YNrG2YaP8E6UjydQ
 omIIc5vsUzW3kauXFHqtqogZTdxHD0DXqAVArJqakqWBHDmPT4qV6sBfcBT8/LtlCNYN
 7/3w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783051904; x=1783656704;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mYG5gbdqiZUgRx9K2qyqNMU3tiBr/+AhYbboeAOaEGY=;
 b=GULRh6CsIlgKiLmOAG6y+NV3H948V4MvJBLz5icdGrcK4El7p9marSps9GWi6dAwLC
 JsTBxKVB8ZjOPT1FNTzh6tFuzON+ijGDXbDETAyr0Z+EEZJeRo4B2PZGERT44WWciuS0
 Z+/XnorzLG09S1gF7hdqSJKJB9oB+l+uYLbVCfupyp9Zmmnn+lYQQj8S45kkh78w1OmK
 a+yzHZ2PWz3WEhWofGuO3LkTddVbS5HV7ZduILsKxui6hm7KIAs0RApGbxGArk8DUsDg
 vDLobK3ktunH87sdqCW61+Zt7wBDMep4e1XqeL2MbVtyf9M465xmvYSv8wJTKlhf3/9I
 bP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783051904; x=1783656704;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mYG5gbdqiZUgRx9K2qyqNMU3tiBr/+AhYbboeAOaEGY=;
 b=UFDT0gEjFEtAbY5Zh+R4x8snaPFnWnB0VF4m+D/eod4a6D8/nB2gmYFrJpSgg3+3wy
 WclALBSJTa4x110hQXAA003TgbNynqu07p+xU5YR9s+45Y/sS7PhlIUTsGk61w61lJZH
 nXUigCIIcmKspRX9m28YsnXHVje+oMhlyTRAHmGpOsVVT11Fe2pQviStSD1AR6htplaO
 7fnkB8/O9Xibbt3dahkkyf7asB/mDBoM1rM6vmCxgcrMfOMX2XVQompR9AAR2lNoBrtD
 tKZdwMaUS8RSWjLDIBd+3u2Vey7QUKdTDC09B/wi9fjeSLCoUSkL487DgizCWvNdb7HX
 NSrw==
X-Forwarded-Encrypted: i=1;
 AHgh+RojTPEn2yntYe0RVhHheBqBr8dM71jAQhTHmkJw+bUoypJTthSRhvk7pwuFE++Mb+w/1Vcbn15xPQc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzN/ArqA7EIPndu0A+36mwRKfA/0URYaPzZaN0rNII6miAxJZzD
 81svkv4VFv2wI5cie0X8Glu1W3AJJ1g90CP1cw3xzJ3YozDQqUiiwECHQVRdCV9K6b+HzqZhyVk
 typ8WGyau8FCd78vncs11aHw5+drpGIc0uDxpbQA=
X-Gm-Gg: AfdE7ckgFEk4lZXS4MllGjujmF+M8pVs4YWjoU24H1eO76XJiCbpEl+dLB3uB5Blepv
 LDzh9hVBr/wsfN4u7BFLMTGXx1PPYwuMeYaAV3V6RtArkQpWo3raFBXpi6YdYIH6B5pyvgO4lCP
 1uFSVd1MtdIT0EVThGX5WQck0924jAaGWS2+f7VTWf8HF3dC6PezSO+34QULOyDOL7YNC9HGSJQ
 wHF9qUYbynyK+m9glrG78DqBYOD/Sf/x2XEPpS4fahzzAJqlUoLI52rlZrIS3MM/lkx/e5ccPsJ
 U81xyscUhKgyqI+FZk0NXPjwDs/ktQ==
X-Received: by 2002:a05:6512:3b0d:b0:5ad:4a8f:58ed with SMTP id
 2adb3069b0e04-5aecc237342mr247261e87.7.1783051903965; Thu, 02 Jul 2026
 21:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260621222130.1667453-1-xuehaohu@google.com>
 <20260623015459.1153884-1-xuehaohu@google.com>
 <20260623094446.4a8fc2ed@pumpkin> <ajryxMaT5evDUxaq@google.com>
 <20260623235350.6540eaa2@pumpkin> <20260630124252.GD7525@ziepe.ca>
 <CAPd9Lg9uY1RZvYUtcbKUg=VdWM61M2f3aqmS5veUg_8M_Ce80g@mail.gmail.com>
 <20260702091040.35eff00c@pumpkin>
In-Reply-To: <20260702091040.35eff00c@pumpkin>
From: David Hu <xuehaohu@google.com>
Date: Fri, 3 Jul 2026 00:11:31 -0400
X-Gm-Features: AVVi8CeOojzP-I_HmExSVQqRC_n17UpgYFkRlrxVBr237r7JGuzRVJ9YNtE2VWM
Message-ID: <CAPd9Lg-ti9hOr4-62xExbNuBJ1fmnhg_Vi1uxFZ8h-9FoeGAnA@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: Split sgl into page-aligned 2G chunks
To: David Laight <david.laight.linux@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Pranjal Shrivastava <praan@google.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Kevin Tian <kevin.tian@intel.com>, 
 Ankit Agrawal <ankita@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, jmoroni@google.com, 
 kpberry@google.com, chriscli@google.com, sashiko-bot@kernel.org, 
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Jul 2, 2026 at 4:10=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Thu, 2 Jul 2026 00:56:40 -0400
> David Hu <xuehaohu@google.com> wrote:
>
> > On Tue, Jun 30, 2026 at 8:42=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
> > >
> > > On Tue, Jun 23, 2026 at 11:53:50PM +0100, David Laight wrote:
> > >
> > > > > If we restrict incoming dmabuf transfers to fit within VFS-centri=
c
> > > > > limits (2GB), we impose unnecessary overhead on the RDMA stack, f=
orcing
> > > > > it to manage a significantly higher number of memory registration=
s. By
> > > > > cleanly splitting these massive contiguous device buffers into
> > > > > page-aligned SGL entries, we directly improve the efficiency of P=
2P
> > > > > transfers and memory registration.
> > > >
> > > > But a divide by '4G - PAGE_SIZE' is also non-trivial and (I think a=
ffects
> > > > a lot of io) when the quotient is always 1.
> > > > Splitting into 2G chunks is a lot cheaper.
> > >
> > > Doesn't matter this isn't fast path stuff. It is better to use fewer
> > > SGL entries, IHMO.
> > >
> > > > > Since this change doesn't seem to have a negative impact on stand=
ard file
> > > > > I/O or break existing VFS constraints, I'm curious why we shouldn=
't
> > > > > support splitting these >4GB P2P transfers? Am I missing somethin=
g?
> > > >
> > > > I was only wondering whether it was needed...
> > > > It does bring up the question of why the >4GB transfers even need s=
plitting.
> > > > But that is another question.
> > >
> > > SGL can only store an unsigned int size, so any large physical range
> > > has to be split down.
> > >
> > > rdma now a days has code to process the sgl and restore back the > 4G
> > > sizes since mode RDMA HW can accept that.
> > >
> > > commit 486055f5e09df959ad4e3aa4ee75b5c91ddeec2e
> > > Author: Michael Margolin <mrgolin@amazon.com>
> > > Date:   Mon Feb 17 14:16:23 2025 +0000
> > >
> > >     RDMA/core: Fix best page size finding when it can cross SG entrie=
s
> > >
> > > So whatever this produces needs to be compatible with that to undo it=
.
> >
> > Thank you everyone. It looks like most open issues are sorted out.
> > I'll wait for maintainers to weigh in before sending out v3 (which
> > will remove the type cast for min() per David L.'s feedback, and
> > revert to ALIGN_DOWN(UINT_MAX, PAGE_SIZE) per Jason's feedback).
>
> Does this code get used a lot for 'normal' transfers?
> I'm away from my normal systems and can't check.
> But if pretty much all of the fragments are small (< 4G) then
> it is probably worth adding a check for 'size < limit' before
> anything else and optimising that case.
>

Hi David,

Thank you for raising this. This file (`dma-buf-mapping.c`) was
recently added [1] to exclusively export MMIO device memory.
Therefore, it is bypassed completely for `normal` transfers (IIUC,
e.g., video buffers for V4L2 or DRM).

Regards,
David

[1] https://lore.kernel.org/all/20251120-dmabuf-vfio-v9-6-d7f71607f371@nvid=
ia.com/

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5C3C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 00:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 143B610F091;
	Thu,  9 Jul 2026 00:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ub2zTjgy";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0459810F091
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 00:12:16 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-698a9f11776so2090782a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 17:12:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783555934; cv=none;
 d=google.com; s=arc-20260327;
 b=NmOnDcoVsqfEqK0udhzjc4gyv/m5yX0Q5usdnywLgarBucgNENy5IdcEcMui62MOvT
 i0SAUf0ZH+cmRcEe4uL27YhoOi/4h289+NPNHcciUOxoJr06Qg5ORUFQmcJlsRTMkyVW
 i0hERbQOZnqjyQ9XvZnfWSEaBJTwyDBLsYmjaB9NTg4WwX8u+TVfufVkEzQJAVlRN3a+
 iUaGafYdpFlQRd8monUzEeN7V5xNP+SoeqAXiexL5H7oIrnE1Z3kHRD3aYhMPQt5l/y9
 07Pu1cwZPS4JQrMwrAFsdBZQsDgRLriJn5tVmMTkWnj/oJmlH/6s6WGTmufqKEnWu+ra
 x+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ujm2++fOaQbhOA4MmQSTLdq4gprqLzthH/E1smRUGkc=;
 fh=yaoCG2vAZBfDE5p52xN20FFxB2aqL08R40xmIGQKUmQ=;
 b=VUTyrsZCV67V/A2v+XkjRU03w5Rl7waGOXJbzxfGNIxNlyxiroitTj1wcemvN0qwaJ
 quPp8uTY8WxWuUow+ZNjeZb0Bkn+fKCMOxKG5pD60KjC8ht48Hzy1pFFiASc4luCs0ZZ
 u6w8Efm6iG5buoPc2HXVuUZOA6z/m+QHkkCBd+UbLyOEZ1pHmjVBvC3h1FvFWjrkZpxo
 UZJw684B06edUiT1pJZTtRJt1ykKmdYzCGM6DogurmvYxrlLYVJAuWE1zmtY1xkKaKkX
 76Qiqt1Ib3PWWRF5vHyUlpmUMN5LvHNMhJPQ1JvRGpUSRkrf7eThz0s3Kqg/MsiL6yOF
 jVow==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783555934; x=1784160734; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ujm2++fOaQbhOA4MmQSTLdq4gprqLzthH/E1smRUGkc=;
 b=Ub2zTjgy1RTmuEJLfnkdSaWLNTNFkeVNmXqLPzbx+gW6qIQwcVYz/ysm/gfeyf56zW
 QbWb+qXhsgEvCRXQ18zTtMl708b3dn1fuK1EjRUIKgE+UyZrhnu8mbGGrK6WPTVxFMvl
 QvvwsRwNBzNuJFWvb1qSoVdjlItMUh5fwYXEA1CCWLOdwyk9VYO/wDvqW5erM4aI/B5h
 3NRpCatM3vRVxKkamtEk4IPfT6YacrQ6HHotv34WZnV4J0Pn5G/4IJ1Zkjtx37cT1zyb
 p9CVYW0YBSK6GFvBmZNdLng5cVf+0E7Vt398l/KukHHV7dXgQmrhpimdSPMx5RJ/3CKO
 n90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783555934; x=1784160734;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ujm2++fOaQbhOA4MmQSTLdq4gprqLzthH/E1smRUGkc=;
 b=fxmvWJkB5KpiP3asdbduAVDOHcCwtiaD/zh9xsQs8RoVaJOBItr3iFVt9KdQIoqgRv
 rpDEstLweM07zXMJhDtju3JerKQRzA8xlVHfA+F3lo3Jb73ZfWmeLzgUbmm7B8+2Nl1Q
 JebXptWP79SWUJGGsBzAFyO1CNIuCGjpE/BRfaxbg35oY3lCmpS6LiCS4+Due8lNlsZq
 cWgGypBDK4LkAysbZo/+GUjm18gbebGKvJFZ/End2gBIVBn8NJq/yZwLi/1qxQCjrG6q
 vsa9dWFPdGYz1fa+UfsB/3htcLhc7FHbvOtoLueRwKA9il7CRWWls6mug4BcJAjj7it3
 Qq0w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxFSQ3kuYEDpG0UWB6ptPyUxwiXDgip6Kpseoji2NQz359zLd+vhPFh/4Js+T3N52xUgavLdjBF44=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcW06QxLwVOGb6alb5tNIYLnePI3ITHYQvJs/JKveh5aVdNwRN
 jI88gr1i9bvpjmzIKP7bc/BXzJzKyci239MvqYICbDbMQwzoApB1ycJD82BoIitKGRAkdLcWqAv
 0VFhUb0Fr5asP7YV2zP1affRJYRhZjf0=
X-Gm-Gg: AfdE7ckE1ReRkYvknOo+NEZoEZePJII0R2o8Sp2YocrqHmpTjc/8ZLlm9PY4yUCMNcS
 V1AjLzVRKkjdsmYFw/mHBGlPwVU0DIH43ov7DY0AXVGK7QdC7uhCvxjquthQWe3d14wihE1MTqX
 t6nGmIdrioLxtvcby6IEi49NlcDY2O9QRt0CSTyzaUccEYlvA2fFr4u01rZB9rmh73q+YmKKNOJ
 l7WRO4VCCetnCfklmv7IwKdL1BfxUK1pX1VQFao0/XhEYfnV+mT10aXFGQSXF/xfFOFsSWOIv+e
 +skOh2AgxXkAyxazRoYaGH/necQ8uL6SZcW4yfsQ
X-Received: by 2002:a05:6402:4283:b0:69a:b3ab:dbea with SMTP id
 4fb4d7f45d1cf-69ab4460cf7mr1758244a12.13.1783555934141; Wed, 08 Jul 2026
 17:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260604135255.62682-1-midgy971@gmail.com>
 <20260604135255.62682-7-midgy971@gmail.com>
 <e44b506e-e9d2-48e3-acea-ab28b7be9b37@rock-chips.com>
 <CA+GS1Y16++cztPxdUGLrPA73ENm4vJGFrjm-jP8r=8OQqcMJGA@mail.gmail.com>
 <0919ffcc-81c3-483a-a3ba-404b455c2040@rock-chips.com>
 <42f1f39f-ab2b-4473-a82a-7ccefad41fcf@rock-chips.com>
In-Reply-To: <42f1f39f-ab2b-4473-a82a-7ccefad41fcf@rock-chips.com>
From: Midgy Balon <midgy971@gmail.com>
Date: Thu, 9 Jul 2026 02:15:34 +0200
X-Gm-Features: AVVi8CcApkElNM_3Z1d6_PvamEAEJfcZGBI9cxUob9-qJkpZOuLDZsOO_EVsZe8
Message-ID: <CA+GS1Y1i87vkv+9NAdqRGNCNsxjQwat2yqEFxjgDZRAPsQjaQA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/9] iommu/rockchip: Clear AUTO_GATING bit 1 on the
 RK356x v1 IOMMU
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Simon Xue <xxm@rock-chips.com>, tomeu@tomeuvizoso.net, ogabbay@kernel.org, 
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
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

Hi Chaoyi,

Sorry for the slow follow-up =E2=80=94 and thanks again for the pointers, t=
hat closes
this out cleanly.

I read the two rockchip-linux commits (7f8158fb, 6a355e5f) and the merged
patch you mentioned: "iommu/rockchip: disable fetch dte time limit"
(Sven P=C3=BCschel, From: Simon Xue,
20260428-spu-iommudtefix-v2-1-f592f579e508@pengutronix.de), which Joerg
applied on 2026-06-02. It adds DISABLE_FETCH_DTE_TIME_LIMIT (BIT(31)) and
does exactly the auto_gate |=3D BIT(31) read-modify-write you suggested, in
rk_iommu_enable() before paging is enabled, for every Rockchip IOMMU. So bi=
t
31 disables the DTE-fetch time limit (without it the newer revision blocks
after four consecutive master DTE fetches racing the CPU's IOTLB zaps); the
RK3568/RK3588 erratum is the same one as RV1126/RV1109. That's the accurate
description I was missing =E2=80=94 thank you.

Since that fix is already upstream, I'll drop the AUTO_GATING change
from my series entirely rather than carry a
duplicate: v4 will rebase on top of it and the NPU MMU picks up BIT(31) for
free. For the record, on the ROCK 3B the NPU IOMMU services the NPU's reads
with zero faults both with BIT(31) and on the reset value (0x3), so this is=
 a
no-op on my hardware/workload =E2=80=94 but rebasing past the merged patch =
is the
right thing regardless.

So my v4 IOMMU dependency list becomes: your per-device-ops series, plus th=
e
merged "disable fetch dte time limit" patch. My series no longer touches th=
e
IOMMU driver itself.

(The convolution output is still uniform zero-point / the job times out =E2=
=80=94
that's the separate NPU compute-completion issue, unrelated to this.)

Thanks again, and kinds regards
Midgy


Le lun. 8 juin 2026 =C3=A0 05:40, Chaoyi Chen <chaoyi.chen@rock-chips.com> =
a =C3=A9crit :
>
> On 6/8/2026 9:45 AM, Chaoyi Chen wrote:
> > Hi Midgy,
> >
> > On 6/8/2026 5:05 AM, Midgy Balon wrote:
> >> Hi Chaoyi,
> >>
> >>> As I said, it is v2. Could you please try using the code below instea=
d and
> >>> see if it works?
> >>> [ auto_gate =3D read(RK_MMU_AUTO_GATING); auto_gate |=3D BIT(31); wri=
te(...) ]
> >>
> >> Thanks -- that's clearly the right shape (read-modify-write, before pa=
ging is
> >> enabled, keeping the reset value instead of my clobbering 0x2).
> >>
> >> I rebuilt v7.1-rc6 (with the rocket RK3568 series + your per-device-op=
s work)
> >> using your bit-31 version and tested it on a ROCK 3B: the NPU IOMMU co=
mes up and
> >> services the NPU's DMA cleanly -- the NPU probes, attaches its domain,=
 and runs
> >> repeated conv submissions with no DMA_READ_ERROR and no page-walk stal=
l. No
> >> regression from the write.
> >>
> >> To be precise about what I can and can't show: I tested both ways on v=
7.1-rc6 --
> >> with your bit-31 write, and on the reset value (0x3) -- and the NPU
> >> IOMMU services
> >> the NPU's reads with zero faults in both cases (no DMA_READ_ERROR, no =
page-walk
> >> stall). So I don't have a failing baseline here that bit-31 visibly
> >> fixes. Is the
> >> AUTO_GATING write needed on current mainline, or only under conditions=
 I'm not
> >> reproducing (a particular traffic pattern / silicon rev)? I'll keep th=
e patch in
> >> your form unless you'd prefer to drop it.
> >>
> >> One question so I document it correctly: what does bit 31 of RK_MMU_AU=
TO_GATING
> >> control on the v2 block -- is it a master "disable internal auto clock=
-gating"
> >> for the page-table walker (i.e. so a TLB-miss walk's AXI master keeps =
its clock
> >> to completion)? The RK3568 TRM I have doesn't cover the IOMMU register=
s, so a
> >> one-line description would let me write an accurate comment.
> >>
> >
> > Glad to hear this works. Please refer to the commit below.
> >
> > [0]: https://github.com/rockchip-linux/kernel/commit/7f8158fb41b5cc8e73=
8aaeebc3637c50ebd74cae
> > [1]: https://github.com/rockchip-linux/kernel/commit/6a355e5f9a2069a230=
9e240791bc3aad63b7324e
> >
>
> It looks like RGA needs this patch too, and it has already been merged :)=
.
>
> https://lore.kernel.org/all/20260428-spu-iommudtefix-v2-1-f592f579e508@pe=
ngutronix.de/
>
> --
> Best,
> Chaoyi

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4A6C43327
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 20:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F7B210E1A5;
	Tue, 30 Jun 2026 20:45:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a6iRVBeO";
	dkim-atps=neutral
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E979310E1A5
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 20:45:24 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-92c7a0a7059so329734285a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 13:45:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782852324; cv=none;
 d=google.com; s=arc-20260327;
 b=cBylDRp8SmXZRyY1DWu7I/5WSjEsfUhSL67UKpGiUWr1duiXmQZUcl1VdgXgR56lEn
 zHLBEjJ+Pb9R0W898g+UOEvH9j7qin2Z8sglJlFsg4tXofb6zGf0uvmatz/oA7CrZqUg
 USsSqS7CNDR83LVJHBD4FTKyY8W6Zhb10KXOLUD+ZvOamhC0i5RncOgyLCY+ZMEcyIX9
 TNjMpb7iGQF6z4If+krS4GeIuqemPjB33Ky1kRjnvaAWmOU4AL8fNzl5NavgewiFOlkq
 7GRH5wCBikOO3PMoeeAYRQYEw/NRs/0/Mnb+hIDW5pXlyOVQVO9tNXYOklxQ0SOnlNco
 Fkuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XbiwBbZPLTstEkkk4C8AvTs+JOgY/jyCAE3KLvaKzTE=;
 fh=qFtw+MakEgHQHXWgXlkPxpmPhHtsQ9O9sYMpY+5+7vM=;
 b=MPug8NPAcE5ohi/uana1H/9pHS08qbMddETcORQwjSOoh/64ehNor7EKZXygEyb+g8
 Q8996Wyp2MlXk3Umk4h+4d/7dXU2bEoXTDaQ0L+qdt1iJcXFM9l0CmtT0/xS1sVOn+cI
 n3tXCRZbX99hIzg8sgUAUBV93a09CKz29LlpHg8kkiuRY1m+qVi04DSfcfZy+2Cpb+iI
 X0rxLbnduOjxASxSntV5IWC+G17KcnpzHy+luLg4iJ24w3lv6SCB15YDFeziUCUNt/su
 JJiqzBfKS/Q1IWDej4inhZaDHShAyY9sFsfjcZQeAxquXGA1izpSgDQ0Tw+ll325MWft
 G/EQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782852324; x=1783457124; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XbiwBbZPLTstEkkk4C8AvTs+JOgY/jyCAE3KLvaKzTE=;
 b=a6iRVBeOsLHCQnpB6jyANOyVNQnimqOGB6/u17h0wRz6XO/aFWDtc1AGblnWirvmx7
 +fOoBd6N+tScIwGTIXY4n1TuadmR4qX0JZJvEFvHwzXpKCjCqiX3MW9Fno0Fad0FpgI7
 IXrOJjpNGaZ0xMqKY6Tn9D/iD4Jtp72+SSPxpsc02e90KirfNhZpslG0mOyGOhEc0ILQ
 5e1vFLHOcWhR1C7MpTFGQZKaeOmYfYppLahOjG61JlHwSuZ3FSMVI4rZYGaVXeElVlxE
 voaIprpAo8/k8jYCQi7kYeFWhfMpWDtSQnaOukuemfCjEG4iGsDsV691lGccu31jKcZ+
 FlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782852324; x=1783457124;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XbiwBbZPLTstEkkk4C8AvTs+JOgY/jyCAE3KLvaKzTE=;
 b=CItMGv71KwksnIR3ZnymcsYqRkielFOT5rrcC9hUtNuuV3BEd/md2+bmLN+6aJr7+q
 wQJijSCh25BuSS+0Bt/XY8+QbMnJwUQjr+Odb5LfJw7BIcpgntOt3T4Q8gQujMcB3zWC
 IYa0QTMdt3WR3Q74iM7ZVYHQywzscwhrmb3zLHctjJolksIeJ5FzMDGa9Ubzbwa9QXbD
 P1taDhZAtZ7yTfxyvJhtz8j7cySGFz3BNBRSNc8B83mQG+ZmiyMf7r3TNW2fTIC8e3Ck
 xuAeo0VnhkDo3JYAnECGZItJxH7H0oEWF2Jm2Nhp9FLHZVxz8VVCiRN3XN6pH/A+HC5K
 c5GQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Tevqm4CSJPelzLDw0tpPzFSHFpxRo06zPUzl7sa5bBCCBrlho8m0nqT2+QLB9QA9Tqs8PQw/njA8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNbKnBLmUEQYgl4k76xq23pp7m0QvyCLvzZugE15vSvP6GejRE
 ze38vaYcQy2pVpmDTecU3Kx6AncH3049jao5Mtpr3VRw5I0s/Cteh9XB9Bx8xV1S7V6hpEJTOML
 e+hSMelzPkpHk/2zKGwKLv5pTQe4ngRg=
X-Gm-Gg: AfdE7cmSU6umcpPXyYfYJ31YKF6T/iPaDYbsE4ICou4bxmGbkCLE7YOmk+wjMC8bWRi
 H1FoF1cWAoaliRsrzElvpa/nZrRHVCh7Alj7fNzUU6SsDEXqrj6wu+86NxODBpy8frpmkpBgO5h
 Yy9q4BA5zU5kNJyBtM3u0d1ifrHd6+CkNXMNpON2NnqqoAEebwYCY1PvIPqZxoZywOt58zvftmb
 JR5br2fspe03NcxIMG0EOx1Xs2TGNMt3lkoMxowPhhshOmw+EmS5QhpMZqFxmAG3hIdddK+dvQ1
 j2ZbjBhdugacVUsf3tEQq4klA/QmkyoIPHRSdidnXPr7srxkOHtahwjyFA==
X-Received: by 2002:a05:620a:1b95:b0:92b:67e6:8ab8 with SMTP id
 af79cd13be357-92e6282238amr889475985a.66.1782852323511; Tue, 30 Jun 2026
 13:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tyu7JAF9GD8GbSbeb++i-UqX59_OcBVY-cFyDyB4tBO8A@mail.gmail.com>
 <8702af7f-47b2-4dcd-bed2-9fa64a8fee9b@amd.com>
 <20260630115150.GD7481@nvidia.com>
In-Reply-To: <20260630115150.GD7481@nvidia.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 1 Jul 2026 06:45:11 +1000
X-Gm-Features: AVVi8CfCtojzmr55RgOQ3zsbIasTHb3f-VmKjr6k8e1tiX4l21aFj_4vIX8bILU
Message-ID: <CAPM=9tyajYEV7tN+J9oG0wrJfx6Sy-ydB8-ZS+izBEpDJdT0CA@mail.gmail.com>
Subject: Re: iommu/smmu/PCI ATS + TTM unmaps + nouveau best way forward
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 dri-devel <dri-devel@lists.freedesktop.org>, iommu@lists.linux-foundation.org, 
 Alistair Popple <apopple@nvidia.com>, Matthew Brost <matthew.brost@intel.com>
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

On Tue, 30 Jun 2026 at 21:51, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Tue, Jun 30, 2026 at 01:24:57PM +0200, Christian K=C3=B6nig wrote:
>
> > > Today I finally hit up iommu.strict=3D1 makes things a lot happier,
> > > non-strict IOMMU seems to allow a race between dma_unmap_page and
> > > free_page where the unmap goes into the IOMMU flush queue, where the
> > > actual unmap are delayed until something triggers a flush later, and
> > > the ATS translations stay alive past when they should, and after the
> > > page has been allocated by some subsequent user.
> >
> > Try disabling ATS, that was a common source of problems during HW
> > bringup for us in the past.
>
> The spark HW cannot run without ATS.
>
> > > 2. split ttm page unmap/free into two stages, and force an iommu
> > > flush/ATS sync operation after the unmap before the free. (I don't
> > > think iommu has an interface for this).
> >
> > Yeah that idea already came up on similar issues as well. I
> > certainly wouldn't be opposed to that.
>
> Only for debugging, it is completely wrong to rely on this for
> functionality.
>
> > You either have to use memory fences which use the same path as the
> > DMA operations itself
>
> Yes, in a PCIe system generally something like the GPU TLB
> invalidation command will complete and flush the fabric path to quiet
> the DMAs. That won't be true on spark though.
>
> Dave could be facing a fabric issue. AFAIK the ATS invalidation that
> the iommu=3Dstrict pushses should fence the fabric so would resolve a
> missing fabric fence. I suppose if you don't see any evidence of a
> non-present ATS response explosion with strict then this would be a
> really good theory.

It's definitely a fabric issue, the iommu ATS invalidation is what
"fixes" it, but I'm not figuring out how to flush it from the GPU
side, and I'm not seeing where the official driver does this either,
guess I have to keep digging. Maybe Alistair knows something.

>
> However, the GPU must have another way to inject a fabric fence. The
> production driver does not rely on ATS fencing to synchronize memory
> operations!
>
> > So far the record for grace periods you need after a TLB flush is 6
> > seconds on production HW with up to 10 seconds on engineering
> > samples (because of HW bugs).
>
> Yeah, if the HW mechanism to fence the fabric don't work spark would
> need similar times to guarentee a fabric drain.

From the ubuntu kernel this thing ships with:
https://bugs.launchpad.net/ubuntu/+source/linux-nvidia-6.14/+bug/2132033

"Add two more Spark iGPU IDs for the existing iommu quirk "

diff -u linux-nvidia-6.14-6.14.0/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.=
c
linux-nvidia-6.14-6.14.0/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
--- linux-nvidia-6.14-6.14.0/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ linux-nvidia-6.14-6.14.0/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3654,7 +3654,9 @@
  if (IS_HISI_PTT_DEVICE(pdev))
  return IOMMU_DOMAIN_IDENTITY;

- if (pdev->vendor =3D=3D PCI_VENDOR_ID_NVIDIA && pdev->device =3D=3D 0x2E1=
2)
+ if (pdev->vendor =3D=3D PCI_VENDOR_ID_NVIDIA &&
+    (pdev->device =3D=3D 0x2E12 || pdev->device =3D=3D 0x2E2A ||
+     pdev->device =3D=3D 0x2E2B))
  return IOMMU_DOMAIN_DMA;
  }


I should probably work out if anything upstream does this or if I can
mess up the production driver against an upstream kernel.

Dave.

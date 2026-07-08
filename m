Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87C7C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 18:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E162B10F223;
	Wed,  8 Jul 2026 18:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UKYB/qpR";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C54710F215
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 18:13:02 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2cc7a269ca1so1575045ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 11:13:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783534382; cv=none;
 d=google.com; s=arc-20260327;
 b=OhAFQX2uc+gRqH0OzZjM42MphCNWw8kuNAFLUuinBGq/S4uo5l8PMGjqFWkkgykqqf
 Xr0fGQuFBsPVi2FoJ6UGOoWNY3d7fbzmuafkQXIIG6M+wwBHTh/mgTDJGJxzP1FRr/p5
 dpcOWlzWiW7QjzpyzJR+q3JxKgs8D/LvagCe8hSTQ/+jOO73o0d+NcbtY4wmRFr2ip9K
 wW3dG1dQBMXdgXMZsD+pX199vmgFgsJDjAQMHa8HOc7PMxyhftGOJ0HpcQXK0pSs1SCM
 YtsyXax/T6M8zaFXfpIWL3sLov0y1SZ9wo94qGRaQ9RyO9GrQpseeBPy8Yuvsk6elqpF
 Pz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ljYf+JhNp07JavIXeIdpn1aei6zbPHggmQvYy8nGttM=;
 fh=02LP2D8lQF/8fDztUZy3yqpSV9W4ASwXO1NlIV0J8zs=;
 b=S646+eRzQtc9jvFMzHK09niOnL6qhGwpkCQpnftGJvyG/dhNDwCjLVTzVux5TNENOU
 0HGOHVcd4+O66LVxo8VoGm5ErwlysDycJBXV21SepVLNd0aPnXJoXEl2SOMGyvogLuNC
 p3NyIXKhVMam0Rhlk7VXVpa7y7+t2ZwUU2yuDmU/gjwHOzjf1nr5t6DRQYBCkCU8KWZk
 Xh9g+0YeECXMOKG2g/ntq7Q+PVDYsyd/yW7l70hUUGaToJUQr8FxOkoAWixZ9T5WLNR5
 U5R22qNkHJOEd1w6L/YDR7VTTZLaDFQ+Wlkw5zKn7ZnOKrQynbSMBPhp8FweYb2SMP1j
 00xg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783534382; x=1784139182; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ljYf+JhNp07JavIXeIdpn1aei6zbPHggmQvYy8nGttM=;
 b=UKYB/qpRHISeHaNBUrrA81TDnD0qIvzzb4bwYy08NJRgLUKpPPFMYh3hvAgoY10zoZ
 41VzkRvcwTYuFw6oXEP2qtOQYz7Rcn7hgazYqX9R0JGA2FeC6jfSCMVktjMHFDwnWpwj
 JRqwVmAO75/T6cLHVdi4NMd8pMaMhsNFAEcYbFLWKuGthpIrI0zPbfLTuTwT+mEyrGS4
 IwEgsLdpZlHCWC/f/5AyDy8LEZuRq5PsgM8jKCl0CJvuHadXZCBwuZpidew4WdCAYcM+
 sgr9aUVIWWTCUmLvN0ZmJMdmN+9Y/L12DVw5A0QqJuTv6iITi1xGXVA9XSt2kzzHJ6Ag
 JsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783534382; x=1784139182;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ljYf+JhNp07JavIXeIdpn1aei6zbPHggmQvYy8nGttM=;
 b=eekKfqW+GAPddEsD7MMPdSpOOAlH1j5n/iEVYxAbbPOA/6GDAveVrZsNKnl6cPckFj
 2stgSQes3aL6nhW2I/58aeBwFJt+Ovn1+TFLwYl1mx1MW6Gw/kxfjUZ2Vg0BpO1xlm+b
 kqTTisTo9D25VGLlggwf14VVV9r855t/olMiV+l4r0J/fRPLiee+nP1iP5Wpaaw3hdsz
 Tq3HyR1i+nQIfLCXJ3oDc3BA3Uw+tUDGoVrKHGGLamkM22q0m3VS0fxYaLoN9Aoj2xnw
 7zfyCzdnqtcyAZS04jRk1Se+PmCaQJ2974sfTKQdWYoa/0kmmO+KKlOjWHqEXeHIQIdR
 NL3w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7IMo2Apvjizs66ULWlCx8Y5CDmh+skWyijU7fcSLKZqlmtqKwJYlWeujT6pVr/DjtUMbejeplKaE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw40p03hRjyLzvomfH2zHkp5TpJTGx5HlSZF4WJInI1JVmxsg5D
 DH23mtmSybPRFpdOeSvvRKVUYp8SkIXztYSFArB6Mk8AgUbGbucc0CMZ1dFHvnNtOOFWpA12J6J
 n6eVKeZ56nTkRNyGX1pSuQbU0toeENvQBWA==
X-Gm-Gg: AfdE7cnf7NgsEWY5MIozWNNyzbqRj+tJomAlBYmWUfSH5g+FdN6RXXS1wlASkV4Mefs
 pOo/yOm0W0+6HQqDdiXhufImy8SEGUcbQEnfA+Uqor0LLyBr85P/zsBLF48oS6uLgQJMmUc9Q5z
 kymoFkpOcXamnrDRpK8iGRwGEMKax1+mvQcsURA3Q96x4WmuHFiGBQs4viwyMlXlt0sMylV3vF6
 40+cSniO2hjpanhiwEk5grFm+gr514K3NJiZtGol/Ohg5MhAOEvBC/mH5bz6o3cIebvHcHwz7Mr
 /9U8h640Eq1O83nEGptzrf5qJNG5zaRqWo54iMQCRQSeitC90rOxSoN79A4=
X-Received: by 2002:a17:902:e94d:b0:2cc:9d9:b8df with SMTP id
 d9443c01a7336-2ccff2d2fb5mr4764295ad.5.1783534381494; Wed, 08 Jul 2026
 11:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com>
 <20260705100436.6877-1-oz@shift-computing.de>
 <a8339282-e3ef-4a4f-a135-968f94855e76@amd.com>
 <42e07bbb-9384-4871-a345-e0fd6c00a772@shift-computing.de>
 <bd1f1632-f53d-4bfd-9d28-5b66e466366c@amd.com>
 <80f34509-9781-421e-b60f-1b8c772a01a9@shift-computing.de>
 <8dd56d76-e46d-43b6-831d-27e66fa2879a@amd.com>
 <cc849fb3-224e-43c0-bc50-67fd025009e7@shift-computing.de>
 <0478bdcd-dc55-4eeb-b7a3-6c5e625ac5c1@amd.com>
 <6e2eaccf-823b-4db2-a4f3-451e5753af8d@shift-computing.de>
 <bc1dbadd-a3ea-4ff9-826e-6826c20bb54e@amd.com>
 <d224d046-0480-4e38-9e93-29a0d37f3331@shift-computing.de>
 <fc0fbda4-87a1-4a58-a66f-728274b4df92@amd.com>
 <CADnq5_Niga7=B9DqPAOJLkBGMqf25jfcexeCXzBO5_4Cu-Lfhg@mail.gmail.com>
 <a316f414-b995-4ee6-a082-259b4ea2d7ca@amd.com>
In-Reply-To: <a316f414-b995-4ee6-a082-259b4ea2d7ca@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jul 2026 14:12:48 -0400
X-Gm-Features: AVVi8Ce2UvHm9I2klo-FGx7iznRPS5u2vCPo2lexnkMQB63hags_fNHYGAzQX_0
Message-ID: <CADnq5_Nr5ntC07sAnOJTMBkh2UH4d5d00AgfuvPt-3Bzo5M5DQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/amdgpu: add firmware file fallback for APU
 VBIOS discovery
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Oz Tiram <oz@shift-computing.de>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Wed, Jul 8, 2026 at 2:03=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 7/8/26 13:02, Alex Deucher wrote:
> > On Wed, Jul 8, 2026 at 1:59=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >>
> >>
> >> On 7/8/26 12:52, Oz Tiram wrote:
> >>> Hi Mario,
> >>>
> >>> Tested on 7.2-rc2 with your patch applied. The mismatch condition is
> >>> unchanged from 6.18.35:
> >>>
> >>>     amdgpu 0000:0b:00.0: VFCT bus number mismatch: table 106 !=3D run=
time 11,
> >>>         matching by device identity (vendor 0x1002 device 0x1900)
> >>>     amdgpu 0000:0b:00.0: Fetched VBIOS from VFCT
> >>>
> >>> Both GPUs initialise fully with your patch.
> >>>
> >>> I also tested 7.2-rc2 without pci=3Drealloc,assign-busses to check wh=
ether
> >>> the pci/realloc changes fixed the dGPU probe failure. They did not --=
 the
> >>> dGPU still fails on 7.2-rc2:
> >>>
> >>>     amdgpu 0000:03:00.0: Fatal error during GPU init
> >>>     amdgpu 0000:03:00.0: probe with driver amdgpu failed with error -=
12
> >>>
> >>> Without the kernel argument the iGPU sits at its POST bus (0x6A), VFC=
T
> >>> matches directly, and it works fine -- but the dGPU is unusable.
> >>> pci=3Drealloc,assign-busses remains necessary for this machine on 7.2=
-rc2,
> >>> which means the VFCT mismatch persists and your patch is still needed=
.
> >>>
> >>> Thank you for not giving up on me so quickly!
> >>> This is my first time working on such issue. It feels
> >>> daunting to modify kernel code.
> >>
> >> OK, in that case I will clean up and post the patches shortly.  You'll
> >> be able to use them for a workaround if everyone else is aligned.  The
> >> part I'm worried about with these is how they would interplay with a
> >> system with multiple of the same GPU.  But I don't believe we would be
> >> fetching VBIOS from VFCT in that case most likely?  Not sure.
> >
> > It's allowed by the spec.  A number of apple systems use VFCT for
> > multu-GPU systems with the same GPU.
>
> But then what happens with the bus numbers?  They all need to be on the
> same bus?

I'm not sure.  As far as I know, the VFCT is populated by the sbios
based on the locations at boot time.  We can ask the vbios team for
more details.

Alex


>
> >
> > Alex
> >
> >>
> >> We really shouldn't have to set pci=3Drealloc,assign-busses on a desig=
n
> >> with all internal PCIe devices.  We should adjust resource allocation
> >> code for this case.
> >>
> >> So please start another another thread with the linux-pci mailing list
> >> on this issue, include a full dmesg showing what happens when you don'=
t
> >> add the parameters and then what happens when you do (feel free to
> >> include/reference this patch in that thread too).
> >>
> >> If you want to use one, this is the kind of thing an LLM with access t=
o
> >> a kernel checkout and both those dmesgs might be good at helping to
> >> propose a draft for a solution to the resource allocation code too.
> >>
> >> You can CC me on that linux-pci mailing list submission, and we'll see
> >> if we can come up with a better solution for you.
> >>
> >>>
> >>> Oz
> >>>
> >>>
> >>> On 7/8/26 18:39, Mario Limonciello wrote:
> >>>> On 7/8/26 11:35, Oz Tiram wrote:
> >>>>> Hi Mario,
> >>>>>
> >>>>> The GPU is internal. It's an AMD RADEON PRO W7800 48GB.
> >>>>> The kernel is built from gentoo-sources-6.18.35.
> >>>>>
> >>>>> I will test the latest sys-kernel/vanilla-sources (7.1.3) and let y=
ou
> >>>>> know.
> >>>>>
> >>>>> Best regards,
> >>>>
> >>>> Thanks. Can you please test 7.2-rc2?
> >>>>
> >>>> I'll clean up the workaround and propose it for review in parallel.
> >>>>
> >>>>>
> >>>>> Oz
> >>>>>
> >>>>> On 7/8/26 15:13, Mario Limonciello wrote:
> >>>>>>
> >>>>>> On 7/8/26 08:10, Oz Tiram wrote:
> >>>>>>> Hi Mario,
> >>>>>>>
> >>>>>>>   > If you drop that - does this notice still come up?
> >>>>>>>
> >>>>>>> No, the notice does not appear without pci=3Drealloc,assign-busse=
s.
> >>>>>>> The iGPU  stays at its POST bus (0x6A =3D 106), VFCT matches
> >>>>>>> directly, and it fetches the VBIOS without any mismatch.
> >>>>>>>
> >>>>>>> However, dropping the kernel argument is not an option on this
> >>>>>>> machine:
> >>>>>>> without it the discrete GPU (0x7449) fails to probe entirely:
> >>>>>>>
> >>>>>>>     amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU init
> >>>>>>>     amdgpu 0000:03:00.0: probe with driver amdgpu failed with err=
or -12
> >>>>>>>
> >>>>>>> The firmware BARs cannot be mapped without resource reallocation,=
 so
> >>>>>>> pci=3Drealloc,assign-busses is required for the dGPU, which in tu=
rn
> >>>>>>> reassigns
> >>>>>>> the iGPU to bus 0x0B and triggers the mismatch your patch resolve=
s.
> >>>>>>
> >>>>>> Got it; thanks for clarifying.  I would like to dig a little bit
> >>>>>> futher into that though.  What kernel are you finding this behavio=
r
> >>>>>> and can it still reproduce with 7.2-rc2 if it's older? There was a
> >>>>>> bunch of pci/realloc changes that happened in the last cycle that
> >>>>>> might have helped this.
> >>>>>>
> >>>>>> Also; is it an eGPU (external) or dGPU (internal)?
> >>>>>>
> >>>>>> If it's an dGPU IMO this is arguably a BIOS issue that not enough
> >>>>>> resources were applied in the first place.
> >>>>>>
> >>>>>> Thanks,
> >>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> Thank you,
> >>>>>>>
> >>>>>>> Oz
> >>>>>>>
> >>>>>>>
> >>>>>>> On 7/8/26 14:55, Mario Limonciello wrote:
> >>>>>>>> Hi Oz,
> >>>>>>>>
> >>>>>>>> On 7/8/26 07:36, Oz Tiram wrote:
> >>>>>>>>> Hi Mario,
> >>>>>>>>>
> >>>>>>>>> Tested on a Morefine MNAS X1 AI Workstation (AMD Ryzen 7 Pro
> >>>>>>>>> 8845HS / Radeon 780M iGPU) with pci=3Drealloc,assign-busses.
> >>>>>>>>>
> >>>>>>>>> The VFCT entry for the iGPU has PCIBus=3D106 (0x6A, recorded at
> >>>>>>>>> POST) while the
> >>>>>>>>> runtime bus is 11 (0x0B). Your patch fires exactly as expected:
> >>>>>>>>>
> >>>>>>>>>     amdgpu 0000:0b:00.0: amdgpu: VFCT bus number mismatch: tabl=
e
> >>>>>>>>> 106 ! =3D runtime 11,
> >>>>>>>>>         matching by device identity (vendor 0x1002 device 0x190=
0)
> >>>>>>>>>     amdgpu 0000:0b:00.0: amdgpu: Fetched VBIOS from VFCT
> >>>>>>>>>
> >>>>>>>>> The iGPU initialises fully and drives the framebuffer.
> >>>>>>>>>
> >>>>>>>>> One minor nit: the dev_notice format string ends with \\n (two
> >>>>>>>>> characters) rather
> >>>>>>>>> than \n. The resulting kernel message has a literal "\n" at the
> >>>>>>>>> end. Same issue
> >>>>>>>>> exists in the nearby "too short #2" dev_info -- not introduced =
by
> >>>>>>>>> your patch, but
> >>>>>>>>> might be worth cleaning up.
> >>>>>>>>>
> >>>>>>>>> Tested-by: Oz Tiram <oz@shift-computing.de>
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Thanks for confirming.  Before I split up this patch and post it
> >>>>>>>> in smaller logical pieces can you confirm my proposed root cause
> >>>>>>>> is right that this issue happens because "pci=3Drealloc,assign-
> >>>>>>>> busses" was on your kernel command line?
> >>>>>>>>
> >>>>>>>> If you drop that - does this notice still come up?
> >>>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>>
> >>>>>>>>> On 7/6/26 02:56, Mario Limonciello wrote:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> On 7/5/26 14:10, Oz Tiram wrote:
> >>>>>>>>>>> Hi Mario,
> >>>>>>>>>>>
> >>>>>>>>>>>     To make sure I understand correctly: are you suggesting t=
hat
> >>>>>>>>>>> the bus
> >>>>>>>>>>>     number in the VFCT was legitimate at BIOS POST time, and =
that
> >>>>>>>>>>>     pci=3Drealloc,assign-busses is what changes it at runtime=
,
> >>>>>>>>>>> causing the
> >>>>>>>>>>>     mismatch?
> >>>>>>>>>>
> >>>>>>>>>> That's what it sounds like right now.  You can easily drop all
> >>>>>>>>>> the superfluous kernel command line optiosn and see.
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>     I'm not familiar enough with the PCI subsystem to know th=
e
> >>>>>>>>>>> right way to
> >>>>>>>>>>>     implement that =E2=80=94 could you point me in the right =
direction?
> >>>>>>>>>>
> >>>>>>>>>> Well there's a variety of ways to do it.  But how about we sta=
rt
> >>>>>>>>>> here - if we make that specific busnr match optional and inste=
ad
> >>>>>>>>>> make a VID/DID match.
> >>>>>>>>>>
> >>>>>>>>>> See if the attached patch helps.
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>     Oz
> >>>>>>>>>>>
> >>>>>>>>>>> On 7/5/26 20:37, Mario Limonciello wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>> On 7/5/26 05:04, Oz Tiram wrote:
> >>>>>>>>>>>>> APUs (e.g. AMD Radeon 780M / HawkPoint, PCI 1002:1900) have=
 no
> >>>>>>>>>>>>> dedicated VBIOS ROM chip.  amdgpu_get_bios_apu() attempts
> >>>>>>>>>>>>> four paths
> >>>>>>>>>>>>> before giving up:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>     1. ACPI VFCT table
> >>>>>>>>>>>>>     2. VRAM BAR read
> >>>>>>>>>>>>>     3. ROM BAR read
> >>>>>>>>>>>>>     4. platform BIOS
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On some systems all four fail.  The specific case motivatin=
g
> >>>>>>>>>>>>> this patch
> >>>>>>>>>>>>> is a hybrid graphics machine (dGPU + APU) where:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>     - The VFCT table contains the iGPU entry but with a sta=
le
> >>>>>>>>>>>>> PCIBus value
> >>>>>>>>>>>>>       from BIOS POST time (0x6A).  When the kernel boots wi=
th
> >>>>>>>>>>>>>       pci=3Drealloc,assign-busses, PCI bus numbers are
> >>>>>>>>>>>>> reassigned dynamically
> >>>>>>>>>>>>>       and the iGPU lands on bus 0x0B at runtime.
> >>>>>>>>>>>>> amdgpu_acpi_vfct_bios()
> >>>>>>>>>>>>>       matches entries by bus number, so the entry is never =
found.
> >>>>>>>>>>>>>     - The VRAM BAR is unmapped at probe time.
> >>>>>>>>>>>>>     - The ROM BAR is zero (PCI firmware did not assign it).
> >>>>>>>>>>>>>     - No platform BIOS mapping exists.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> The UEFI GOP driver initialises the iGPU successfully for
> >>>>>>>>>>>>> early display,
> >>>>>>>>>>>>> confirming the hardware is functional.  The VBIOS image dat=
a
> >>>>>>>>>>>>> embedded in
> >>>>>>>>>>>>> the VFCT is also valid; only the PCIBus metadata is wrong.
> >>>>>>>>>>>>
> >>>>>>>>>>>> So the BIOS on this machine is actually totally fine; it's
> >>>>>>>>>>>> just when the kernel is booted to reassign busses there is a
> >>>>>>>>>>>> problem?
> >>>>>>>>>>>>
> >>>>>>>>>>>> In that case; why not detect the kernel was booted this way
> >>>>>>>>>>>> and keep track of the original bus number when reassigned to
> >>>>>>>>>>>> avoid the issue?
> >>>>>>>>>>>>
> >>>>>>>>>>>>> The firmware
> >>>>>>>>>>>>> file can be extracted directly from the VFCT using dd:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>     dd if=3D/sys/firmware/acpi/tables/VFCT bs=3D1 skip=3D$(=
(0x68))
> >>>>>>>>>>>>> count=3D16896 \
> >>>>>>>>>>>>>        of=3D/lib/firmware/amdgpu/1002_1900.bin
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> (0x68 is the byte offset of the VBIOS image after the ACPI
> >>>>>>>>>>>>> table header
> >>>>>>>>>>>>> and VFCT_IMAGE_HEADER; the image length 16896 comes from th=
e
> >>>>>>>>>>>>> ImageLength
> >>>>>>>>>>>>> field in VFCT_IMAGE_HEADER.)
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> The driver then prints "Unable to locate a BIOS ROM" and
> >>>>>>>>>>>>> refuses to
> >>>>>>>>>>>>> bind, leaving the APU completely unusable under Linux.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Add a fifth fallback: request a firmware file named
> >>>>>>>>>>>>> "amdgpu/<vendor>_<device>.bin" (e.g. "amdgpu/1002_1900.bin"=
) via
> >>>>>>>>>>>>> request_firmware().  This allows a VBIOS image extracted as
> >>>>>>>>>>>>> above to be
> >>>>>>>>>>>>> placed in /lib/firmware/ and makes the binding succeed
> >>>>>>>>>>>>> without patching
> >>>>>>>>>>>>> ACPI tables or BIOS.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> The fallback is only reached if all existing paths have
> >>>>>>>>>>>>> already failed,
> >>>>>>>>>>>>> so there is no regression risk for boards where VFCT or ROM
> >>>>>>>>>>>>> BAR work.
> >>>>>>>>>>>>
> >>>>>>>>>>>> What happens if the VBIOS changes in another way one boot to
> >>>>>>>>>>>> another? You might have some other stateful information that
> >>>>>>>>>>>> isn't updated.
> >>>>>>>>>>>>
> >>>>>>>>>>>> The whole thing to me feels like a hack for a behavior we ca=
n
> >>>>>>>>>>>> control in the kernel when doing reassignments.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Signed-off-by: Oz Tiram <oz@shift-computing.de>
> >>>>>>>>>>>>> ---
> >>>>>>>>>>>>> v2: Fix commit message: clarify that VFCT contains the iGPU
> >>>>>>>>>>>>> entry but
> >>>>>>>>>>>>>       with a stale PCIBus from BIOS POST that mismatches th=
e
> >>>>>>>>>>>>> runtime bus
> >>>>>>>>>>>>>       number assigned by pci=3Drealloc,assign-busses. Expla=
in
> >>>>>>>>>>>>> that the VBIOS
> >>>>>>>>>>>>>       image data is valid and document the dd extraction
> >>>>>>>>>>>>> command and byte
> >>>>>>>>>>>>>       offsets.  Note that the UEFI GOP driver initialises t=
he
> >>>>>>>>>>>>> iGPU
> >>>>>>>>>>>>>       successfully, confirming the hardware is functional.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 ++++++++++=
+++
> >>>>>>>>>>>>> ++ ++ ++ ++++
> >>>>>>>>>>>>>    1 file changed, 23 insertions(+)
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/
> >>>>>>>>>>>>> drivers/ gpu/ drm/amd/amdgpu/amdgpu_bios.c
> >>>>>>>>>>>>> index aa039e148a5e..86064c753b09 100644
> >>>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> >>>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> >>>>>>>>>>>>> @@ -26,6 +26,7 @@
> >>>>>>>>>>>>>     *          Jerome Glisse
> >>>>>>>>>>>>>     */
> >>>>>>>>>>>>>    +#include <linux/firmware.h>
> >>>>>>>>>>>>>    #include "amdgpu.h"
> >>>>>>>>>>>>>    #include "atom.h"
> >>>>>>>>>>>>>    @@ -457,6 +458,28 @@ static bool amdgpu_get_bios_apu(str=
uct
> >>>>>>>>>>>>> amdgpu_device *adev)
> >>>>>>>>>>>>>            goto success;
> >>>>>>>>>>>>>        }
> >>>>>>>>>>>>>    +    {
> >>>>>>>>>>>>> +        const struct firmware *fw;
> >>>>>>>>>>>>> +        char fw_name[32];
> >>>>>>>>>>>>> +        size_t fw_size;
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>> +        snprintf(fw_name, sizeof(fw_name), "amdgpu/
> >>>>>>>>>>>>> %04x_%04x.bin",
> >>>>>>>>>>>>> +             adev->pdev->vendor, adev->pdev->device);
> >>>>>>>>>>>>> +        if (request_firmware(&fw, fw_name, adev->dev) =3D=
=3D 0) {
> >>>>>>>>>>>>> +            adev->bios =3D kmemdup(fw->data, fw->size,
> >>>>>>>>>>>>> GFP_KERNEL);
> >>>>>>>>>>>>> +            fw_size =3D fw->size;
> >>>>>>>>>>>>> +            release_firmware(fw);
> >>>>>>>>>>>>> +            if (!adev->bios || !check_atom_bios(adev,
> >>>>>>>>>>>>> fw_size)) {
> >>>>>>>>>>>>> +                amdgpu_bios_release(adev);
> >>>>>>>>>>>>> +            } else {
> >>>>>>>>>>>>> +                adev->bios_size =3D fw_size;
> >>>>>>>>>>>>> +                dev_info(adev->dev, "Fetched VBIOS from
> >>>>>>>>>>>>> firmware file %s\n",
> >>>>>>>>>>>>> +                     fw_name);
> >>>>>>>>>>>>> +                goto success;
> >>>>>>>>>>>>> +            }
> >>>>>>>>>>>>> +        }
> >>>>>>>>>>>>> +    }
> >>>>>>>>>>>>> +
> >>>>>>>>>>>>>        dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
> >>>>>>>>>>>>>        return false;
> >>>>>>>>>>>>
> >>>>>>>>
> >>>>>>
> >>>>
> >>
>

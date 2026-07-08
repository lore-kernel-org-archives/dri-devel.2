Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D13C44501
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 18:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3FA710F212;
	Wed,  8 Jul 2026 18:02:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NxtayGi7";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A116410F20A
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 18:02:52 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cad85b7b5aso899015ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 11:02:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783533772; cv=none;
 d=google.com; s=arc-20260327;
 b=WuGgAVIcFkzanjnWwnGFRQkrNGnV+jmP+bYGw3JOJm/EARms7XueFQkKAhnyZbxqkr
 jLurFjXHJuz3UaJfOfuEXRFV0a9sT1xHHwb2I7uwaY/4GUqJkBCEN7L/DURBuB2FSnp4
 Ft0LUPh+9AEAbTChJWGCi8thHBhZ41/FcEt2Dy7qavL2iQDLCN74NmDo0yas94/zWHPU
 BR+TACZUpWbTn+EWyncJXZTyiFrHr8DUrRiPdrF3stq3bqigTbNzZbMZU3iljLRO1cPt
 fBe/FAOi8885KXRBljg3Ac2Du/k+xLs4LCeyyIpgl7Wl3Eag8fAqr0YM97g21qqqpJFh
 nJ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FEh+4EcBFMGEIfYduhvV//Y/vK21ASSnlf6NhijwXog=;
 fh=lYJAReXu6pNnSqxNBJK1vQvoh7Lk/utTa5QtNahGQEY=;
 b=CregLnplirREvJI8FS6s+FGikp0zoM2h25wL1d0XkbXf6xDvhg1CZ5n1N2FyF/U/Ju
 EdjU6AaUbAjgmKqRXCe+M9rFQdPUlopJrmEvEjPbp3vmUoXivFFxT0772QEURXh9+Ljr
 c5mumc4ckb1tXzZLQwfpXGRsEsaN4zv1yHi9/lyKpEtXcskipLJL7wKdRA6k37EbW8nk
 tSWW/smxK3nZI6xKVrvbWWrsuTjj/yGWE8KsywN4pu3cWSUcudIioVniRpoOnnHJYmF2
 y9ctRkori34xynOmRm6gRGsfDNcc3iViwYvid2kfIqKP6WdA1HDeK4lH75UGoPrWPZCs
 tgzw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783533772; x=1784138572; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FEh+4EcBFMGEIfYduhvV//Y/vK21ASSnlf6NhijwXog=;
 b=NxtayGi7k5bR8JWShEsvmUOprfCxD54cpLKhmr8mOeHWe1NbvVWgruPDEDdSIirLXT
 b1UOz1IBG6dcNRpIagDWJFkZncxBeimtA6PD+489VjQuAvq+bINNud0WVsNukJ2rQaTD
 u/43j99S8SU8b85yP9lA+aGB4/+IBac2buB2S6Wh7i/Al7WM0zCKx17g8K9PgknGY/qp
 rZXEUQ8I3gc8olCudw5xnoyRQGvJW11xD4uYLKGuXw2BYlKs1bhN6de49BHQoISZV5x4
 bPHVJZhynD0EeapZ4zo9Z1PStwsj1drQDvg8xuUa0f2Si82syf/1+pkU2nD6P/WY0Nrh
 VyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783533772; x=1784138572;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FEh+4EcBFMGEIfYduhvV//Y/vK21ASSnlf6NhijwXog=;
 b=mU+fge1wPclM+gIgO2ykdUlLv4iHNEd2Kri/15qawXgMYVIsQJ9AM4rqtP0hjc8TA4
 YXGnpscoE2mAHjI9snrwy6EloIgSZIDNSs6YHtbd12eCkIsHMaHGdrV+MoaKzNdTJQHp
 kmPVE+CNqnb7bYOeehmk0p77zyrd8Y5UhE+v3WSGlH4SfhTSgoQJGV59zC6W2Yv2GoDA
 puGjhtN16Vdf3DfeKKdEt0fEV13uqOb8gR258hgh9+AAzlHy+6NJ88wa2Hbi1YY32HBS
 8LGH2SQDclnwXp/+6CML/YyFTJt7p1Fshs8DSfk6WHeJAndqcPnOIVXhBqXbwPIEq3EG
 NfPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqmfHpARTvhpVcvekPrGwOwIqrn7KRMKvE5HqxbWF4JUHvBkAGaCwLhPe9YqLXj2za4ww7S9EB3Enc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOZ3dg2eSA8nF8EtgO8ciQlsmkVy9YW+ViZpng9S7KpjejloWr
 kz8nvSWUi7Xo3TSYECs2dsBeaj52gJV9EBPCQ8dv4AGBBrXKtKGugG0D1Q5RPLZZVLUR19mzl+x
 PKCBRHpG8ODEKUlv0EUimzjxsSjExRtsojQ==
X-Gm-Gg: AfdE7cl9bzgLkzKarfgLWTL9WWuB040DwwK37HxuVdg5IxHfOqoT7M4E2rIaNbmWXBP
 lBa3sRX+anXoqZuEk4JyH/Bk/d9wWdhEoefKbBIqMpDC75yX0vco+e1R4LfV93lfGtVtGYDkFgj
 V4DFSWoZQC9ZaeK0WTLxK/Iqfb3Ie6OuFALm9p3o68MX0ZSGHwE3GvTeTrKLhvnARIvASxG6ge1
 a9rbBjZdd2qZhIfNKZLIm7vTrd/fvUvVR7dLEPV4IgAox34Zr+B4J8QMTlYzhkHOvmpfXOSUs9Y
 ByOmtNQLmcSYy55QzOB9DdP23qm0xdtAZVl/8k507p67zL7iU+lPlYCR2xI=
X-Received: by 2002:a17:902:dacd:b0:2c9:fbde:ab68 with SMTP id
 d9443c01a7336-2ccea3f7e6cmr28601695ad.3.1783533772026; Wed, 08 Jul 2026
 11:02:52 -0700 (PDT)
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
In-Reply-To: <fc0fbda4-87a1-4a58-a66f-728274b4df92@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jul 2026 14:02:40 -0400
X-Gm-Features: AVVi8CeZnKc_eZrwGViGliXNNNfOnAbTKHaH0XuyV9KvzQSgox-hPCDhzUTP0XI
Message-ID: <CADnq5_Niga7=B9DqPAOJLkBGMqf25jfcexeCXzBO5_4Cu-Lfhg@mail.gmail.com>
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

On Wed, Jul 8, 2026 at 1:59=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 7/8/26 12:52, Oz Tiram wrote:
> > Hi Mario,
> >
> > Tested on 7.2-rc2 with your patch applied. The mismatch condition is
> > unchanged from 6.18.35:
> >
> >    amdgpu 0000:0b:00.0: VFCT bus number mismatch: table 106 !=3D runtim=
e 11,
> >        matching by device identity (vendor 0x1002 device 0x1900)
> >    amdgpu 0000:0b:00.0: Fetched VBIOS from VFCT
> >
> > Both GPUs initialise fully with your patch.
> >
> > I also tested 7.2-rc2 without pci=3Drealloc,assign-busses to check whet=
her
> > the pci/realloc changes fixed the dGPU probe failure. They did not -- t=
he
> > dGPU still fails on 7.2-rc2:
> >
> >    amdgpu 0000:03:00.0: Fatal error during GPU init
> >    amdgpu 0000:03:00.0: probe with driver amdgpu failed with error -12
> >
> > Without the kernel argument the iGPU sits at its POST bus (0x6A), VFCT
> > matches directly, and it works fine -- but the dGPU is unusable.
> > pci=3Drealloc,assign-busses remains necessary for this machine on 7.2-r=
c2,
> > which means the VFCT mismatch persists and your patch is still needed.
> >
> > Thank you for not giving up on me so quickly!
> > This is my first time working on such issue. It feels
> > daunting to modify kernel code.
>
> OK, in that case I will clean up and post the patches shortly.  You'll
> be able to use them for a workaround if everyone else is aligned.  The
> part I'm worried about with these is how they would interplay with a
> system with multiple of the same GPU.  But I don't believe we would be
> fetching VBIOS from VFCT in that case most likely?  Not sure.

It's allowed by the spec.  A number of apple systems use VFCT for
multu-GPU systems with the same GPU.

Alex

>
> We really shouldn't have to set pci=3Drealloc,assign-busses on a design
> with all internal PCIe devices.  We should adjust resource allocation
> code for this case.
>
> So please start another another thread with the linux-pci mailing list
> on this issue, include a full dmesg showing what happens when you don't
> add the parameters and then what happens when you do (feel free to
> include/reference this patch in that thread too).
>
> If you want to use one, this is the kind of thing an LLM with access to
> a kernel checkout and both those dmesgs might be good at helping to
> propose a draft for a solution to the resource allocation code too.
>
> You can CC me on that linux-pci mailing list submission, and we'll see
> if we can come up with a better solution for you.
>
> >
> > Oz
> >
> >
> > On 7/8/26 18:39, Mario Limonciello wrote:
> >> On 7/8/26 11:35, Oz Tiram wrote:
> >>> Hi Mario,
> >>>
> >>> The GPU is internal. It's an AMD RADEON PRO W7800 48GB.
> >>> The kernel is built from gentoo-sources-6.18.35.
> >>>
> >>> I will test the latest sys-kernel/vanilla-sources (7.1.3) and let you
> >>> know.
> >>>
> >>> Best regards,
> >>
> >> Thanks. Can you please test 7.2-rc2?
> >>
> >> I'll clean up the workaround and propose it for review in parallel.
> >>
> >>>
> >>> Oz
> >>>
> >>> On 7/8/26 15:13, Mario Limonciello wrote:
> >>>>
> >>>> On 7/8/26 08:10, Oz Tiram wrote:
> >>>>> Hi Mario,
> >>>>>
> >>>>>  > If you drop that - does this notice still come up?
> >>>>>
> >>>>> No, the notice does not appear without pci=3Drealloc,assign-busses.
> >>>>> The iGPU  stays at its POST bus (0x6A =3D 106), VFCT matches
> >>>>> directly, and it fetches the VBIOS without any mismatch.
> >>>>>
> >>>>> However, dropping the kernel argument is not an option on this
> >>>>> machine:
> >>>>> without it the discrete GPU (0x7449) fails to probe entirely:
> >>>>>
> >>>>>    amdgpu 0000:03:00.0: amdgpu: Fatal error during GPU init
> >>>>>    amdgpu 0000:03:00.0: probe with driver amdgpu failed with error =
-12
> >>>>>
> >>>>> The firmware BARs cannot be mapped without resource reallocation, s=
o
> >>>>> pci=3Drealloc,assign-busses is required for the dGPU, which in turn
> >>>>> reassigns
> >>>>> the iGPU to bus 0x0B and triggers the mismatch your patch resolves.
> >>>>
> >>>> Got it; thanks for clarifying.  I would like to dig a little bit
> >>>> futher into that though.  What kernel are you finding this behavior
> >>>> and can it still reproduce with 7.2-rc2 if it's older? There was a
> >>>> bunch of pci/realloc changes that happened in the last cycle that
> >>>> might have helped this.
> >>>>
> >>>> Also; is it an eGPU (external) or dGPU (internal)?
> >>>>
> >>>> If it's an dGPU IMO this is arguably a BIOS issue that not enough
> >>>> resources were applied in the first place.
> >>>>
> >>>> Thanks,
> >>>>
> >>>>>
> >>>>>
> >>>>> Thank you,
> >>>>>
> >>>>> Oz
> >>>>>
> >>>>>
> >>>>> On 7/8/26 14:55, Mario Limonciello wrote:
> >>>>>> Hi Oz,
> >>>>>>
> >>>>>> On 7/8/26 07:36, Oz Tiram wrote:
> >>>>>>> Hi Mario,
> >>>>>>>
> >>>>>>> Tested on a Morefine MNAS X1 AI Workstation (AMD Ryzen 7 Pro
> >>>>>>> 8845HS / Radeon 780M iGPU) with pci=3Drealloc,assign-busses.
> >>>>>>>
> >>>>>>> The VFCT entry for the iGPU has PCIBus=3D106 (0x6A, recorded at
> >>>>>>> POST) while the
> >>>>>>> runtime bus is 11 (0x0B). Your patch fires exactly as expected:
> >>>>>>>
> >>>>>>>    amdgpu 0000:0b:00.0: amdgpu: VFCT bus number mismatch: table
> >>>>>>> 106 ! =3D runtime 11,
> >>>>>>>        matching by device identity (vendor 0x1002 device 0x1900)
> >>>>>>>    amdgpu 0000:0b:00.0: amdgpu: Fetched VBIOS from VFCT
> >>>>>>>
> >>>>>>> The iGPU initialises fully and drives the framebuffer.
> >>>>>>>
> >>>>>>> One minor nit: the dev_notice format string ends with \\n (two
> >>>>>>> characters) rather
> >>>>>>> than \n. The resulting kernel message has a literal "\n" at the
> >>>>>>> end. Same issue
> >>>>>>> exists in the nearby "too short #2" dev_info -- not introduced by
> >>>>>>> your patch, but
> >>>>>>> might be worth cleaning up.
> >>>>>>>
> >>>>>>> Tested-by: Oz Tiram <oz@shift-computing.de>
> >>>>>>>
> >>>>>>
> >>>>>> Thanks for confirming.  Before I split up this patch and post it
> >>>>>> in smaller logical pieces can you confirm my proposed root cause
> >>>>>> is right that this issue happens because "pci=3Drealloc,assign-
> >>>>>> busses" was on your kernel command line?
> >>>>>>
> >>>>>> If you drop that - does this notice still come up?
> >>>>>>
> >>>>>> Thanks,
> >>>>>>
> >>>>>>> On 7/6/26 02:56, Mario Limonciello wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 7/5/26 14:10, Oz Tiram wrote:
> >>>>>>>>> Hi Mario,
> >>>>>>>>>
> >>>>>>>>>    To make sure I understand correctly: are you suggesting that
> >>>>>>>>> the bus
> >>>>>>>>>    number in the VFCT was legitimate at BIOS POST time, and tha=
t
> >>>>>>>>>    pci=3Drealloc,assign-busses is what changes it at runtime,
> >>>>>>>>> causing the
> >>>>>>>>>    mismatch?
> >>>>>>>>
> >>>>>>>> That's what it sounds like right now.  You can easily drop all
> >>>>>>>> the superfluous kernel command line optiosn and see.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>    I'm not familiar enough with the PCI subsystem to know the
> >>>>>>>>> right way to
> >>>>>>>>>    implement that =E2=80=94 could you point me in the right dir=
ection?
> >>>>>>>>
> >>>>>>>> Well there's a variety of ways to do it.  But how about we start
> >>>>>>>> here - if we make that specific busnr match optional and instead
> >>>>>>>> make a VID/DID match.
> >>>>>>>>
> >>>>>>>> See if the attached patch helps.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>    Oz
> >>>>>>>>>
> >>>>>>>>> On 7/5/26 20:37, Mario Limonciello wrote:
> >>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> On 7/5/26 05:04, Oz Tiram wrote:
> >>>>>>>>>>> APUs (e.g. AMD Radeon 780M / HawkPoint, PCI 1002:1900) have n=
o
> >>>>>>>>>>> dedicated VBIOS ROM chip.  amdgpu_get_bios_apu() attempts
> >>>>>>>>>>> four paths
> >>>>>>>>>>> before giving up:
> >>>>>>>>>>>
> >>>>>>>>>>>    1. ACPI VFCT table
> >>>>>>>>>>>    2. VRAM BAR read
> >>>>>>>>>>>    3. ROM BAR read
> >>>>>>>>>>>    4. platform BIOS
> >>>>>>>>>>>
> >>>>>>>>>>> On some systems all four fail.  The specific case motivating
> >>>>>>>>>>> this patch
> >>>>>>>>>>> is a hybrid graphics machine (dGPU + APU) where:
> >>>>>>>>>>>
> >>>>>>>>>>>    - The VFCT table contains the iGPU entry but with a stale
> >>>>>>>>>>> PCIBus value
> >>>>>>>>>>>      from BIOS POST time (0x6A).  When the kernel boots with
> >>>>>>>>>>>      pci=3Drealloc,assign-busses, PCI bus numbers are
> >>>>>>>>>>> reassigned dynamically
> >>>>>>>>>>>      and the iGPU lands on bus 0x0B at runtime.
> >>>>>>>>>>> amdgpu_acpi_vfct_bios()
> >>>>>>>>>>>      matches entries by bus number, so the entry is never fou=
nd.
> >>>>>>>>>>>    - The VRAM BAR is unmapped at probe time.
> >>>>>>>>>>>    - The ROM BAR is zero (PCI firmware did not assign it).
> >>>>>>>>>>>    - No platform BIOS mapping exists.
> >>>>>>>>>>>
> >>>>>>>>>>> The UEFI GOP driver initialises the iGPU successfully for
> >>>>>>>>>>> early display,
> >>>>>>>>>>> confirming the hardware is functional.  The VBIOS image data
> >>>>>>>>>>> embedded in
> >>>>>>>>>>> the VFCT is also valid; only the PCIBus metadata is wrong.
> >>>>>>>>>>
> >>>>>>>>>> So the BIOS on this machine is actually totally fine; it's
> >>>>>>>>>> just when the kernel is booted to reassign busses there is a
> >>>>>>>>>> problem?
> >>>>>>>>>>
> >>>>>>>>>> In that case; why not detect the kernel was booted this way
> >>>>>>>>>> and keep track of the original bus number when reassigned to
> >>>>>>>>>> avoid the issue?
> >>>>>>>>>>
> >>>>>>>>>>> The firmware
> >>>>>>>>>>> file can be extracted directly from the VFCT using dd:
> >>>>>>>>>>>
> >>>>>>>>>>>    dd if=3D/sys/firmware/acpi/tables/VFCT bs=3D1 skip=3D$((0x=
68))
> >>>>>>>>>>> count=3D16896 \
> >>>>>>>>>>>       of=3D/lib/firmware/amdgpu/1002_1900.bin
> >>>>>>>>>>>
> >>>>>>>>>>> (0x68 is the byte offset of the VBIOS image after the ACPI
> >>>>>>>>>>> table header
> >>>>>>>>>>> and VFCT_IMAGE_HEADER; the image length 16896 comes from the
> >>>>>>>>>>> ImageLength
> >>>>>>>>>>> field in VFCT_IMAGE_HEADER.)
> >>>>>>>>>>>
> >>>>>>>>>>> The driver then prints "Unable to locate a BIOS ROM" and
> >>>>>>>>>>> refuses to
> >>>>>>>>>>> bind, leaving the APU completely unusable under Linux.
> >>>>>>>>>>>
> >>>>>>>>>>> Add a fifth fallback: request a firmware file named
> >>>>>>>>>>> "amdgpu/<vendor>_<device>.bin" (e.g. "amdgpu/1002_1900.bin") =
via
> >>>>>>>>>>> request_firmware().  This allows a VBIOS image extracted as
> >>>>>>>>>>> above to be
> >>>>>>>>>>> placed in /lib/firmware/ and makes the binding succeed
> >>>>>>>>>>> without patching
> >>>>>>>>>>> ACPI tables or BIOS.
> >>>>>>>>>>>
> >>>>>>>>>>> The fallback is only reached if all existing paths have
> >>>>>>>>>>> already failed,
> >>>>>>>>>>> so there is no regression risk for boards where VFCT or ROM
> >>>>>>>>>>> BAR work.
> >>>>>>>>>>
> >>>>>>>>>> What happens if the VBIOS changes in another way one boot to
> >>>>>>>>>> another? You might have some other stateful information that
> >>>>>>>>>> isn't updated.
> >>>>>>>>>>
> >>>>>>>>>> The whole thing to me feels like a hack for a behavior we can
> >>>>>>>>>> control in the kernel when doing reassignments.
> >>>>>>>>>>>
> >>>>>>>>>>> Signed-off-by: Oz Tiram <oz@shift-computing.de>
> >>>>>>>>>>> ---
> >>>>>>>>>>> v2: Fix commit message: clarify that VFCT contains the iGPU
> >>>>>>>>>>> entry but
> >>>>>>>>>>>      with a stale PCIBus from BIOS POST that mismatches the
> >>>>>>>>>>> runtime bus
> >>>>>>>>>>>      number assigned by pci=3Drealloc,assign-busses. Explain
> >>>>>>>>>>> that the VBIOS
> >>>>>>>>>>>      image data is valid and document the dd extraction
> >>>>>>>>>>> command and byte
> >>>>>>>>>>>      offsets.  Note that the UEFI GOP driver initialises the
> >>>>>>>>>>> iGPU
> >>>>>>>>>>>      successfully, confirming the hardware is functional.
> >>>>>>>>>>>
> >>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 +++++++++++++
> >>>>>>>>>>> ++ ++ ++ ++++
> >>>>>>>>>>>   1 file changed, 23 insertions(+)
> >>>>>>>>>>>
> >>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/
> >>>>>>>>>>> drivers/ gpu/ drm/amd/amdgpu/amdgpu_bios.c
> >>>>>>>>>>> index aa039e148a5e..86064c753b09 100644
> >>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> >>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> >>>>>>>>>>> @@ -26,6 +26,7 @@
> >>>>>>>>>>>    *          Jerome Glisse
> >>>>>>>>>>>    */
> >>>>>>>>>>>   +#include <linux/firmware.h>
> >>>>>>>>>>>   #include "amdgpu.h"
> >>>>>>>>>>>   #include "atom.h"
> >>>>>>>>>>>   @@ -457,6 +458,28 @@ static bool amdgpu_get_bios_apu(struct
> >>>>>>>>>>> amdgpu_device *adev)
> >>>>>>>>>>>           goto success;
> >>>>>>>>>>>       }
> >>>>>>>>>>>   +    {
> >>>>>>>>>>> +        const struct firmware *fw;
> >>>>>>>>>>> +        char fw_name[32];
> >>>>>>>>>>> +        size_t fw_size;
> >>>>>>>>>>> +
> >>>>>>>>>>> +        snprintf(fw_name, sizeof(fw_name), "amdgpu/
> >>>>>>>>>>> %04x_%04x.bin",
> >>>>>>>>>>> +             adev->pdev->vendor, adev->pdev->device);
> >>>>>>>>>>> +        if (request_firmware(&fw, fw_name, adev->dev) =3D=3D=
 0) {
> >>>>>>>>>>> +            adev->bios =3D kmemdup(fw->data, fw->size,
> >>>>>>>>>>> GFP_KERNEL);
> >>>>>>>>>>> +            fw_size =3D fw->size;
> >>>>>>>>>>> +            release_firmware(fw);
> >>>>>>>>>>> +            if (!adev->bios || !check_atom_bios(adev,
> >>>>>>>>>>> fw_size)) {
> >>>>>>>>>>> +                amdgpu_bios_release(adev);
> >>>>>>>>>>> +            } else {
> >>>>>>>>>>> +                adev->bios_size =3D fw_size;
> >>>>>>>>>>> +                dev_info(adev->dev, "Fetched VBIOS from
> >>>>>>>>>>> firmware file %s\n",
> >>>>>>>>>>> +                     fw_name);
> >>>>>>>>>>> +                goto success;
> >>>>>>>>>>> +            }
> >>>>>>>>>>> +        }
> >>>>>>>>>>> +    }
> >>>>>>>>>>> +
> >>>>>>>>>>>       dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
> >>>>>>>>>>>       return false;
> >>>>>>>>>>
> >>>>>>
> >>>>
> >>
>

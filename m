Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46704606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SjGrl1at
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 875FD10FD1E;
	Wed, 28 Oct 2026 14:53:42 +0000 (UTC)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02E8810FD11
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 14:53:36 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-36a1467ca93so133025eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 07:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793199215; cv=none;
 d=google.com; s=arc-20260327;
 b=J3Y4SEVgJqQF5rZZ0nnzaG/fNZ/PRD+hiFk9hjNL9R0Yvcev0NjidOp6vOgAlbam9A
 1SsesgIQJFbboMEV5fLFbwmP8ufVzOYHjmsb/DDgMoBgB3RwiUe82i/VaaKBqYgehHTg
 n9J1OAydTYbef+MPfqVb95d1qdbEHbHFdgNwAUqT9ZM+GNhS9N/6+l4MwtGeAqJyAqaZ
 bK3JdEJF5lhK1W/KSqgvydJ7i54SjfrmiPed5mveweeohoDuUEqnTsRrgbqv8UHxPFpm
 E6+bGV3HGGwUmvVoMR3WCrWM432k/bORNteB2fssrpSkP0Xe3Q3WEtK7wFroTsqKVRFq
 +xAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hHpZdOuRh3k05zToFRnsSy2dvYFiJ6TeIqmJJw0GgYg=;
 fh=4dPjuPipZtW0W542O1PpVDrF1XiBkSGJuuZByhiZPOU=;
 b=kW5AajguxfLX5h6FiB3Sat+mkTEU9w7EJP5KOeHmODX2DamWY2aIYyZaWX6TFu9CET
 h/sEZmsgAGZz/gxfmyhpaWFea2KIVWjrr/x9p8aHGO38LMgXT75+wOjRHq5M20fKHCGS
 DoTF6MU3A8il2jUftG2l22cjmZSfqOyZJTrW9jvjEfgO6AnhYN/nbMSxmZ55QzkjyJKv
 Pv/tAqvOa5IgbVFVThUCnjfk34S1J6T8l3DcSB3C4Yy80PmkEbzJFKWyMoOoRLobEAH7
 p/y1JcTq5A6wgl0uM+t39rFdwqn2qSaj5u1imMc5uh+G4M+gKYG+aVUL3RFqH3vw4PzW
 1EDg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793199215; x=1793804015; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hHpZdOuRh3k05zToFRnsSy2dvYFiJ6TeIqmJJw0GgYg=;
 b=SjGrl1atV/X8tqQkgNjZXLb0LYpR0T9I1821he4KratI2COeNo2QVPA9e8+wqhVCxI
 O9XGEkUkcyDlmQbKk4vvpY54VskJH5POtRKTOFm884RZg5OISQgJP5psNMsNzGjJVqNE
 DzLiiiczeegrZ7XuQKNQ6NwToQT5eZ6kcRal/neLlI3dRGCf0WA+8Yje8erv+BK19vUI
 XmWnFcCZ/OURY/hv8GwtR9yZrdHfUtbCGmuSHs5aZn81maKtuPDj9a8RECyVtUzXrhBO
 D3VXKPa8CXD2G7Rs00UEhHuVTlWmVAWKC9iKaEzjrX9apnHxUTaAp5xRYTfxxAHMJKlm
 qRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793199215; x=1793804015;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hHpZdOuRh3k05zToFRnsSy2dvYFiJ6TeIqmJJw0GgYg=;
 b=kUZ3QKxL5wgTK3bHaKpMDveLILS+5wIU5AGoI9Diw1U54CNHluJ2HhNIAOo7BjCkH9
 aMR6YOAiAUuvV/gKGS7TCllasgCT1mji7ZPdmFUk1ysTstUcbb0T9mzfUVvPUow/luD9
 uWpcxDSZFIvde5qrhooyAffhqPCqHilwkP8tNSWN0o7bcY/cFcCTOSHcrsRolI5C1+km
 FsCbG5jh4NQLspttQbg5iN/O4GZIb9UFKP8afVKX+k1VbqQrg0kJfBFk8YXqU96m/d6j
 pbpWyIzUm8jtcm4WhLSd92b8yCeav9M1hD7wf78Mcjr55fTBkfbbgIIwycgAtgn5grH7
 TQQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYzjbw5QhHEZOaeRH71koIRtvmv0Psh58w4UizZ6qRgoMBnBRlsat3VYrw5jU89Lzt2j4m6UXI0vc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ/V7N6TY6Y46Q+e39sqe8rxdF4jOXLR3hVOxXFvqjP0rTICUVS
 P0+PVa1XAY2JfpTKyQvXoxUeqA6EjWXV7MZGgRw6QDqHvVjz6w7qHHckTMFQcupABDmZi9zTEtH
 Nv1WrsyphdeNOFPulFZDVPK3TcyhjUMA=
X-Gm-Gg: AYBFou0jnSDQTw0qVm42EcEB9s23/tu12PTQUoy75gk6KfMJosDygcy3mxLVcBXuLvb
 DmR/ATL6H3k3jdZzIwROZJgcXx7gWH0FIOfN289vMuyiRNRxaC1EcAPDwiNQ94U7/o44j0J7Nvk
 SONkk6M2KKmdlRBrC8JLCA6idwWqCwLJa1VOs62zFuB10/+IU64BjNJOHiCydqiKQqlAg8TVlv7
 /E0ijs8juRDded3CosnslgcxoiIayMpGtdn0Ddz055umGcktphRzxRkmGRJFWDTc+DwXfguCKRN
 gFf0vQe9AmDyD48T8vqpBu9w6dFCDNR/eKyS8cxp4r9RfMsThBERklBdcf4kHpHHLy18ffqSe84
 Mba5HY7B/gFZqWfIQc0Qpdll8F55XjZTyieLYPtRUZ4eI5HNiOV+gz6R6f0ndBZzLKm5g5SDQrM
 M3ozX+NFV7etpeUuRX4fA60aQ5Sk8BtI1c3/Nay8igSFrv
X-Received: by 2002:a05:7301:1a8c:b0:369:ffc5:6767 with SMTP id
 5a478bee46e88-36a1ffc100fmr5213282eec.2.1793199215122; Wed, 28 Oct 2026
 07:53:35 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <a826b32d-597a-4c01-8b30-218cbca8627a@gmail.com>
 <e0573e72-dcc1-4ff2-8cf2-53aefde912cb@amd.com>
 <CADnq5_M8f2Hgs06n9EXUaihGsr6YEm6G4YFVQmPfQbGU08XkBg@mail.gmail.com>
 <6f79a3e2-5510-4018-aabd-45fcdf5dcbb3@amd.com>
 <CADnq5_OTLQuD3B6-VUgZv6wGjhFNY_U77wqdv5Y+e25+O0B2ZA@mail.gmail.com>
 <138497f6-2271-4229-87f1-4e42e9d2b581@gmail.com>
 <76b577d9-e8ce-45d5-9330-564411cc099d@amd.com>
In-Reply-To: <76b577d9-e8ce-45d5-9330-564411cc099d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Oct 2026 10:53:22 -0400
X-Gm-Features: AclHuK9PGvqElJiJ4JkJ6TDlP1xlfh9iqAhttNXCNmpg8zpVdT6TtOWjX57qcnA
Message-ID: <CADnq5_NUKVeF_UNqx=8KfPQ8ntvkT5iv_Tfgp5v9r9ADv8go9g@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: reserve 64M stolen memory for Apple 5K
 iMac
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Richard Lane <richardlanedev@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 10:14=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 10/27/26 18:59, Richard Lane wrote:
> > On 27/10/2026 13:37, Alex Deucher wrote:
> >> On Tue, Oct 27, 2026 at 9:16=E2=80=AFAM Mario Limonciello
> >> <mario.limonciello@amd.com> wrote:
> >>>
> >>>
> >>>
> >>> On 10/27/26 07:57, Alex Deucher wrote:
> >>>> On Tue, Oct 27, 2026 at 8:21=E2=80=AFAM Christian K=C3=B6nig
> >>>> <christian.koenig@amd.com> wrote:
> >>>>>
> >>>>> On 10/26/26 23:46, Richard Lane wrote:
> >>>>>> Apple 27" 5K iMacs report a single 2560x2880 tile (28.125 MiB) in
> >>>>>> VIEWPORT_SIZE while scanning out up to 64 MiB across the relocated=
 EFI
> >>>>>> framebuffer.
> >>>>>>
> >>>>>> Override the stolen VGA memory allocation size to 64 MiB when matc=
hing
> >>>>>> PCI_VENDOR_ID_APPLE with a 2560x2880x4 viewport size to prevent
> >>>>>> framebuffer corruption during boot handover.
> >>>>>
> >>>>> Hacks like those are usually a big no-go.
> >>>>>
> >>>>> Why is that framebuffer handling not working with DC out of the box=
?
> >>>>
> >>>> The GMC IP code reserves the memory used by the display hardware fro=
m
> >>>> the pre-OS console.  The gmc get_vbios_fb_size() callback looks to s=
ee
> >>>> what display viewport was set by the pre-OS environment.  If the Mac=
s
> >>>> need a workaround, that's where it should go.  Since these displays
> >>>> require multiple display pipes, my guess is you need to double the
> >>>> allocation in that case since the current code just checks the first
> >>>> pipe.
> >>>
> >>>
> >>> Could this also be a logic error in that callback?  Would it be worth
> >>> double checking all the register values in that callback for this sys=
tem?
> >>>
> >>> I know for example there are a few different IP specific implementati=
ons
> >>> in gmc_v9_0_get_vbios_fb_size().
> >>
> >> Not likely.  I suspect the issue is that these systems use two display
> >> pipes so we only reserve enough memory to cover half of the display.
> >> On PCs the vbios never sets up MST.
> >>
> >> Alex
> >>
> >
> > I tested doubling the allocation in gmc_v8_0_get_vbios_fb_size():
> >
> >       if (adev->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_APPLE &&
> >           size =3D=3D (2560 * 2880 * 4))
> >               size *=3D 2;
> >
> > That eliminated the corruption across the middle (45-60%) of the screen=
,
> > but still left a band of corruption along the very bottom (95-100%) of
> > the screen.
> >
> > Dumping the DCE registers inside gmc_v8_0_get_vbios_fb_size() on the
> > iMac17,1 showed:
> >
> >    vram_start =3D 0xf400000000, d1vga =3D 0x0
> >    CRTC0: grph_en=3D0x1 surf_hi=3D0xf4 surf_lo=3D0x300000 pitch=3D5120 =
vp_size=3D2560x2880
> >    CRTC1: grph_en=3D0x80000000 surf_hi=3D0x0 surf_lo=3D0x0 pitch=3D0 vp=
_size=3D0x0
> >
> > Even though only CRTC0 is active at EFI boot with a 2560x2880 viewport,
> > Apple's EFI allocates a full 5120-pixel stride surface (mmGRPH_PITCH) a=
nd places
> > mmGRPH_PRIMARY_SURFACE_ADDRESS at a 3 MiB offset (0x300000) from
> > vram_start.
> >
> > Because CRTC0 scans out 2880 lines at a 5120-pixel pitch starting at
> > offset 3 MiB, the active pre-OS scanout spans [3 MiB, 59.25 MiB) in VRA=
M:
> > - Reserving 2560 * 2880 * 4 (28.125 MiB) places permanent driver BOs at
> >    ~28.125..32 MiB, corrupting the middle (40-60%) of the screen.
> > - Reserving 2 * 2560 * 2880 * 4 (56.25 MiB) places those BOs at
> >    ~56.25..59.25 MiB, leaving the final 3 MiB exposed due to the 0x3000=
00
> >    surface offset and corrupting the bottom (95-100%) of the screen.
> > - Accounting for the 5120 pitch and the 0x300000 surface offset reserve=
s
> >    the full 59.25 MiB span and eliminates the corruption completely.
> >
> > For v2 of the patch, which of the following two approaches in both
> > gmc_v7_0/v8_0_get_vbios_fb_size() would you prefer? Both tested working=
.
>
> My feeling is that Option A is less magical.  I'd actually wonder if we
> should be doing this more widely.  I'd *think* the same problem could
> happen on a non-Apple display that behaves similarly.

I had discussions with the vbios teams when this code was added.  They
said the display base was always put at the start of VRAM.  The only
area I have a concern about is adding the surface address.  It works
ok if the the displays are put near the start of VRAM, but if not
(e.g., the pre-OS environment puts then at the top of VRAM), we'll end
up reserving most or all of VRAM.  I think the right solution is to
add an offset to the reservation and then use the surface address as
the offset.  That's more work however so maybe it would be better as a
follow up clean up.

Alex

>
> >
> > Option A (change whole function):
> >
> >   static unsigned gmc_v8_0_get_vbios_fb_size(struct amdgpu_device *adev=
)
> >   {
> >       u32 d1vga_control =3D RREG32(mmD1VGA_CONTROL);
> >       unsigned size;
> >
> >       if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE=
)) {
> >               size =3D AMDGPU_VBIOS_VGA_ALLOCATION;
> >       } else {
> >               u32 viewport =3D RREG32(mmVIEWPORT_SIZE);
> > -             size =3D (REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT=
_HEIGHT) *
> > -                     REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_W=
IDTH) * 4);
> > +             size =3D REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_=
HEIGHT) *
> > +                    RREG32(mmGRPH_PITCH) * 4;
> > +             if (size)
> > +                     size +=3D RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS) =
-
> > +                             lower_32_bits(adev->gmc.vram_start);
> >       }
> >
> >       return size;
> >   }
> >
> > Option B (add Apple 5K iMacs quirk):
> >
> >   static unsigned gmc_v8_0_get_vbios_fb_size(struct amdgpu_device *adev=
)
> >   {
> >       u32 d1vga_control =3D RREG32(mmD1VGA_CONTROL);
> >       unsigned size;
> >
> >       if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE=
)) {
> >               size =3D AMDGPU_VBIOS_VGA_ALLOCATION;
> >       } else {
> >               u32 viewport =3D RREG32(mmVIEWPORT_SIZE);
> >               size =3D (REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT=
_HEIGHT) *
> >                       REG_GET_FIELD(viewport, VIEWPORT_SIZE, VIEWPORT_W=
IDTH) * 4);
> > +
> > +             if (adev->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_APP=
LE &&
> > +                 size =3D=3D (2560 * 2880 * 4))
> > +                     size =3D size * 2 + RREG32(mmGRPH_PRIMARY_SURFACE=
_ADDRESS);
> >       }
> >
> >       return size;
> >   }
> >
> >
> > Richard
> >
> >>>
> >>>>
> >>>> Alex
> >>>>
> >>>>>
> >>>>> Regards,
> >>>>> Christian.
> >>>>>
> >>>>>>
> >>>>>> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
> >>>>>> ---
> >>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 +++++++++-
> >>>>>>    1 file changed, 9 insertions(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_gmc.c
> >>>>>> index 4204c3c750a8..8b196fbfa724 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> >>>>>> @@ -1232,7 +1232,15 @@ void amdgpu_gmc_init_vga_resv_regions(struc=
t amdgpu_device *adev)
> >>>>>>           } else {
> >>>>>>                   size =3D amdgpu_gmc_get_vbios_fb_size(adev);
> >>>>>>
> >>>>>> -               if (adev->mman.keep_stolen_vga_memory)
> >>>>>> +               /*
> >>>>>> +                * Apple 5K iMacs report one 2560x2880 tile in VIE=
WPORT_SIZE
> >>>>>> +                * while scanning out up to 64M across the relocat=
ed EFI
> >>>>>> +                * framebuffer.
> >>>>>> +                */
> >>>>>> +               if (adev->pdev->subsystem_vendor =3D=3D PCI_VENDOR=
_ID_APPLE &&
> >>>>>> +                   size =3D=3D (2560 * 2880 * 4))
> >>>>>> +                       size =3D 64U * 1024 * 1024;
> >>>>>> +               else if (adev->mman.keep_stolen_vga_memory)
> >>>>>>                           size =3D max(size, (unsigned)AMDGPU_VBIO=
S_VGA_ALLOCATION);
> >>>>>>           }
> >>>>>>
> >>>>>> --
> >>>>>> 2.55.0
> >>>>>
> >>>
> >
>

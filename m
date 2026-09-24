Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1CFC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:21:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C87C610E19B;
	Thu, 24 Sep 2026 15:21:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Or/7QVYn";
	dkim-atps=neutral
Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com
 [74.125.229.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9221110E19B
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:21:38 +0000 (UTC)
Received: by mail-dy2-f12.google.com with SMTP id
 5a478bee46e88-32836a9fa23so147783eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 08:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790263298; cv=none;
 d=google.com; s=arc-20260327;
 b=mR475oFC09Nr9W/j7Kf5PhMHNaFS+/WUtqKhGTIMaOdH83HcvNK9v5LQRjqvxO/OEY
 cWXlwfaGz0D9630lDwLFBQX9t3nmtPY0C4gwTORrOiF4TO6xqO9wWjCMEwhQruZ5bmcH
 0O/4IaTYxQfe1xp5o8IQBn4aR9SrzwZCwMPsXZnvBtG80mr4zKroEYHsRIFB0VosRr8k
 ROwKJj9PsYH+RXk6re6sPFup1I78PV2Wqc4i0WoCK0rJjb11r44QVtiGLmjAvRPHAsZ3
 irYHgsIhR1j5EVO/Ne11PfPBfIM0SuOpSJqBRdsWti3tvJYcps/I3xi+Tmng5Q1YYDRb
 XUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1HbT6s9c6aFM0LJbQwaDMayMtoWgK4wRQAnAVfXVUqE=;
 fh=dd2FsEpjI6ZWIf/TJDlrpqqLmKkRAmq1HpkgfogmGY4=;
 b=htbvjDSSPzoE/u8z0Pdl3xBr1BZCXYQlMUq1RnXWHmH8NXkcnD7nni1SCoSw5xjaGW
 /b7aJBq437aFdmEiHaqGDJitSzEwxU4U0cHsczptMWyeFYNcaEEtxPOsUXRAYqYi1qrX
 1Hvg7uObnhjeYsOzjhOeMVUe8f6AKpVirULUrV+TK9dDtEOgly5zniB1G+OAPEVc4BOw
 rKj/gFkrTQ+z2wIHObQP2vOPzF+C+KHIQ/r7lCVw8tB4bMvFlaUr7XG6i1XUPYElCuHj
 PR50+2+0IcNLnVjUA5V+puD/GE7j9uMmZHnBgyW1mCGoY2tD7XfALx1N86Y36fDcuSpn
 Bozw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790263298; x=1790868098; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1HbT6s9c6aFM0LJbQwaDMayMtoWgK4wRQAnAVfXVUqE=;
 b=Or/7QVYnS/097Cjs+yLn5LKPw9iQxWcoOAsxHuVQN6JjdQf1KhzTCS2iFnu7hSA5r0
 inLVNWvmnUNnSH0pZXt56vCURB0aNet9utpP2Ky0OakYp3gAnnFVe/1IQ1diB8914e4L
 /kzTuB4caafRI8H8o3VXXSdx7ds1xG4q7RUYcwaQdc2jPBBeMfjngGXnUzRH4ok/Snui
 XxK1F7TtS9A/Z0kPHYkTSlbT+4/Y7cUP0oeyU8FCyND11JDIQ/zS+MegOPzVRkKzyKIh
 Ryygmx+AYdPwGI2WPBERp0nPWg5tla5BnrZk+fkjrCUO+ss00689rdb7WaPPTqfypJtM
 QIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263298; x=1790868098;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1HbT6s9c6aFM0LJbQwaDMayMtoWgK4wRQAnAVfXVUqE=;
 b=TogAKahGFP5grM+PPZ1AvUiRoXK+tKatlQaeR0N2rv7cpyJixoAmsCRmZLyBlNZjLq
 G++4CBl82l57DuGUSeeGLCd8/R1vk7OomqdIZ4lEzYvSprCRwFWOpsDLp42UNdK+2lrx
 hzYbn0CHqclQEWDQPotMHF8dKfxxcEtLCleADpyeV3fY29YCriqGcQHNLZ0anX9m/RVE
 Y7YarI/M2XObLIadUx/hmdvZdpA1dDylnDq0O1jKzw3WY0JgBJ0kRYxHA1FJ0abFKiPL
 SmEwOMUd24vebsJpzeT4NoIPljdPpJM8s+aK+GQHFTt07uATtt5kwRi/91kE3hfHO91T
 uTmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmVT3tiImBYZw6mX02cng9xUe55rXBsB9eOOIe7q5zQ+fNv/XgqFB/ac496g3RF3bz3IhnOP27r4M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k/EymrKlk9sVFFH8NsNxg4p7SQCXLMyDNgczHVHkd+M/6K33ti
 Hr/ZKGKdtRrnmtoKsj0NgywQU/98YaQgkmh37qqRrthvv2uXjrJeOMM3ZDzOtQ9C9H7r3oRGHQz
 fRrFNcYwINlpJZtlgA5ICqxQyGmuKy1E=
X-Gm-Gg: AYBFou0+H0yJVFxvRSqgh/GmxOZrfMxKaTagNV+SOCg4xjOs3LMR7J4Y9sRkP4dKS2g
 lIta1rsP2doiyhNVNKATPJzJbun7pvWyXdHmle8JrbQpE+eLOMGHfXubFSXPU8b2/Uan01j9zNy
 gOLvhvK0iOvaQOeD6tt0gVumfQ0u+o7GpvaY74dxZY3bzyTKdyVK6DDKEIckKnNWMHZyqwBmTew
 d+hvNPdtYBiU7PTF7NLjal8yJc0OAjdkA8fLempJfGA2JcxEkxu36QrCYZp02zAwFeSM1uJV9OW
 xzCitTgrXZ5ec66TwmsHRru2bkJOvYEmaPoeKj34i9Gi0AQapa0Mf2Qhrutd12pZNkP08jtkxEy
 gRSpsbKdwR3d2praBPjBcvCSrwX7LI/8JsURVntz0B1Bw6Ipembq0
X-Received: by 2002:a05:701b:4510:10b0:139:81c6:67a1 with SMTP id
 a92af1059eb24-1450405cf58mr3632727c88.1.1790263297559; Thu, 24 Sep 2026
 08:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260924132952.25054-1-fbeltranmillalen@gmail.com>
 <9c2ce6d3-46ea-4a69-a227-a5431c3447a6@amd.com>
In-Reply-To: <9c2ce6d3-46ea-4a69-a227-a5431c3447a6@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Sep 2026 11:21:25 -0400
X-Gm-Features: AclHuK939X-LsDc1Mw-gpXK0-LhWwyhpUJXbBj2XeAIu67VCJD_e4BSptwVLNXw
Message-ID: <CADnq5_PsKKiOXPuH9c8n0u8viyg0u3rTeDnPoeDBk11MP4V_hg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gmc_v8_0: restore the FB location after a
 re-POST
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Francisco_Beltr=C3=A1n_Millal=C3=A9n?=
 <fbeltranmillalen@gmail.com>, 
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, airlied@gmail.com, 
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

On Thu, Sep 24, 2026 at 11:06=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 9/24/26 15:29, Francisco Beltr=C3=A1n Millal=C3=A9n wrote:
> > On a MacBookPro14,3 (Radeon Pro 560, POLARIS11) amdgpu has never recove=
red
> > from an ASIC reset: five attempts recorded, zero successes.  Since susp=
end
> > to RAM goes through a reset, S3 fails the same way, and as the internal
> > panel hangs off the AMD GPU the machine comes back blind.
> >
> > The failure looks like VRAM going write-only-dead: writes are silently
> > dropped while reads still work, the driver reports success at every ste=
p,
> > and then it hands the SMU a pointer to a table that was never written:
> >
> >   amdgpu_device_asic_init()  -> 0          (reports success)
> >   gmc_v8_0_hw_init()         -> 0          (reports success)
> >   memcpy_toio()                             (write silently discarded)
> >   send_msg(0x251, ...)                      (SMU parses garbage)
> >   smu7_check_fw_load_finish() -> -EINVAL -> black screen
> >
> > It is not VRAM dying.  It is the framebuffer moving.
> >
> > On this machine the Apple firmware places VRAM at MC address 0 on a col=
d
> > boot, and gmc_v8_0_vram_gtt_location() reads MC_VM_FB_LOCATION once, at
> > init, to derive vram_start.  A re-POST -- which is what an ASIC reset a=
nd
> > an S3 resume both trigger -- lets the VBIOS put the framebuffer back at
> > its own default instead, 0xf400_0000 here:
> >
> >   cold boot:   MC_VM_FB_LOCATION =3D 0x007f0000
> >   after reset: MC_VM_FB_LOCATION =3D 0xf47ff400
>
> Mhm, interesting I'm really wondering where those values come from.
>
> >
> > gmc_v8_0_mc_program() programs the system aperture from the stale
> > vram_start, but only writes MC_VM_FB_LOCATION and HDP_NONSURFACE_BASE
> > under SR-IOV; on bare metal it trusts whatever the VBIOS left behind.
> > While the MC is still in pass-through everything appears to work, so th=
e
> > mismatch goes unnoticed.  Then gmc_v8_0_gart_enable() sets ENABLE_L1_TL=
B,
> > SYSTEM_ACCESS_MODE=3D3 and ENABLE_ADVANCED_DRIVER_MODEL, the MC starts
> > checking the system aperture, and every access lands outside it -- whic=
h
> > is why reads return data written before the reset, from a different
> > physical place than the writes are going to.
> >
> > Write the framebuffer location back when it does not match the one the
> > driver is working with, which is what the SR-IOV path already does.  Th=
e
> > comparison keeps this a no-op on machines where the VBIOS restores the
> > same location, so nothing changes for them.
>
> That is still a rather bad idea for multiple reasons.
>
> You often run into suspend/resume and random memory corruption issues whe=
n stuff like that is done and we never fully implemented blocking VRAM acce=
ss during a runtime ASIC reset.
>
> I think the more defensive approach is to do an ASIC reset on driver load=
 and use the values the AtomBIOS init function comes up with.
>
> @Alex what's your take here?

Sounds like crazy Mac specific behavior.  The asic_init bios table has
to reprogram the FB aperture otherwise the pre-OS environment won't
work.  Moreover, at some point, these registers became privileged such
that only firmware can program them.  I agree that running asic_init
on boot for Macs would make sense.  I think we already have a similar
workaround for some other mac models, probably to work around a
similar issue:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Da5be7ad8f5f0e067613e9197638f216f46252946
Maybe add your device to that existing quirk or make the quirk generic
for all VI boards with apple ssids?

Alex


>
> Regards,
> Christian.
>
> >
> > This runs after the VGA aperture has been locked out and with the displ=
ay
> > suspended, so the MC does not need to be stopped; only CPU access throu=
gh
> > the BAR could land while the FB and HDP bases disagree, so BIF_FB_EN is
> > cleared around the update and re-enabled below.
> >
> > With this the GPU survives resets and S3: the machine has since complet=
ed
> > twelve suspend/resume cycles in a single boot without a failure, and th=
e
> > restore is visible on each resume:
> >
> >   amdgpu 0000:01:00.0: amdgpu: FB location 0xf47ff400 does not match
> >   vram_start, restoring 0x007f0000
> >
> > To be precise about what those cycles prove: the kernel they were run o=
n
> > also carries unrelated local patches for this machine's Thunderbolt
> > controller, which fails separately.  This patch is the one that brings =
the
> > display back -- without it the GPU never recovered from a reset at all.
> >
> > Tested on 6.18.49 on a MacBookPro14,3.  I have no other smu7 hardware, =
so
> > this is only known to matter on machines whose firmware boots the GPU a=
t a
> > different framebuffer location than the VBIOS default; elsewhere the ne=
w
> > branch does nothing.
> >
> > Signed-off-by: Francisco Beltr=C3=A1n Millal=C3=A9n <fbeltranmillalen@g=
mail.com>
> > ---
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > @@ -472,14 +472,42 @@
> >         WREG32(mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR,
> >                adev->mem_scratch.gpu_addr >> 12);
> >
> > +       tmp =3D ((adev->gmc.vram_end >> 24) & 0xFFFF) << 16;
> > +       tmp |=3D ((adev->gmc.vram_start >> 24) & 0xFFFF);
> > +
> >         if (amdgpu_sriov_vf(adev)) {
> > -               tmp =3D ((adev->gmc.vram_end >> 24) & 0xFFFF) << 16;
> > -               tmp |=3D ((adev->gmc.vram_start >> 24) & 0xFFFF);
> >                 WREG32(mmMC_VM_FB_LOCATION, tmp);
> >                 /* XXX double check these! */
> >                 WREG32(mmHDP_NONSURFACE_BASE, (adev->gmc.vram_start >> =
8));
> >                 WREG32(mmHDP_NONSURFACE_INFO, (2 << 7) | (1 << 30));
> >                 WREG32(mmHDP_NONSURFACE_SIZE, 0x3FFFFFFF);
> > +       } else {
> > +               u32 fb_loc =3D RREG32(mmMC_VM_FB_LOCATION);
> > +
> > +               /*
> > +                * On bare metal vram_start is the FB base found at ini=
t (see
> > +                * gmc_v8_0_vram_gtt_location()).  Normally the VBIOS p=
ut it
> > +                * there and a later re-POST puts it back in the same p=
lace.
> > +                * On MacBookPros with switchable graphics VRAM is at 0=
 at boot
> > +                * instead, and a re-POST (S3 resume, ASIC reset) moves=
 it to
> > +                * the VBIOS default, away from the addresses the drive=
r
> > +                * already uses.  Move it back.
> > +                *
> > +                * This only happens after a re-POST: the display is su=
spended
> > +                * and the VGA aperture has been locked out above, so t=
here is
> > +                * no need to stop the MC.  Only CPU access through the=
 BAR
> > +                * could land while the FB and HDP bases disagree, so b=
lock it
> > +                * here; BIF_FB_EN is enabled again below.
> > +                */
> > +               if (REG_GET_FIELD(fb_loc, MC_VM_FB_LOCATION, FB_BASE) !=
=3D
> > +                   REG_GET_FIELD(tmp, MC_VM_FB_LOCATION, FB_BASE)) {
> > +                       dev_info(adev->dev,
> > +                                "FB location 0x%08x does not match vra=
m_start, restoring 0x%08x\n",
> > +                                fb_loc, tmp);
> > +                       WREG32(mmBIF_FB_EN, 0);
> > +                       WREG32(mmMC_VM_FB_LOCATION, tmp);
> > +                       WREG32(mmHDP_NONSURFACE_BASE, (adev->gmc.vram_s=
tart >> 8));
> > +               }
> >         }
> >
> >         WREG32(mmMC_VM_AGP_BASE, 0);
>

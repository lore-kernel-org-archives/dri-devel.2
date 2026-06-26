Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D57C43211
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 19:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70AC510E405;
	Fri, 26 Jun 2026 19:39:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BxE8KJc7";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F3E910E3E7
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 19:39:04 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-30c8f531a03so106718eec.2
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:39:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782502743; cv=none;
 d=google.com; s=arc-20260327;
 b=iejhJvrRIDN7abSJ8v8TNWuzsSsyVKpTuM443p8UTAhFVEy1nq8FeDH1xwpkaRUcVF
 IKTivhyZP0N23N0hqUj+AST5WRzuDUpoJtqIDNjm58wEwCUgTi5BokycE41LicetEXve
 gwAZUSvdVmFvzTr4deEy19eRNDXVbZruJDbkPKbGd3u1ksmUg514wEyhe5dT9Sv/kRC9
 dE1fbgENpZYlBNeRdEwKgqoJ2yErEPPeRIivqRkcuwH6yI38R0J5GWN1WTnvSZ1tNpji
 mp+TLJsBo1CWHgMxRzqMKAM7ysjEDvS0DKryosf7+upxbrIn7KESriCUwdq8xTEBdagx
 0tTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ymD8IT6kcNdhPEekps/Z9O7NDXYnPeYvMCZ8i3L3Juw=;
 fh=/wK4gB3At1/6XdQ/izpkCE2TmBvmnyE92qAG1/nBaLc=;
 b=WuxyMhDPBQcpsrLgY2Y46yHzqkzLi3CWqhx2MzpClKf0wPSgHlS1wMz/oi4jlbzcXA
 gWHEmKu4jOaEdGDA+45LuWXVdXYyiNHnRWMagOQ6e7wRMpB1ynxIkTkkMn6m8enp5jpx
 5B50a7nlA6Ekoy3G95smj/bC/KMD4JAKFe8FUnE/KwEq4Erkq1lvdD1ZMN/vbv+iByVs
 wIKve1I6OhJuJ+zhiJkfCnlUsJaLM4UC/JpDJ4NaYmMFBHnITEUOEPOj5z3A51SRi7aC
 0fVRqC7PfSfZDU7+hHRbJQFCH1GG2HhdvIX+AQUkvzUsrcfd9xGfNvBuVwRAAL9EUUfF
 xpTQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782502743; x=1783107543; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ymD8IT6kcNdhPEekps/Z9O7NDXYnPeYvMCZ8i3L3Juw=;
 b=BxE8KJc7UyJcWN49rq+oJ0+14wo80NUSZuzZFKfE/aoaBIpYmSxLWKIUzm1qsRYrIP
 9E70JWZiEh6lwUzG5Qo0DDM/hFTm77BzAR5ZA2aC5PdLDGulwox0uGTNTeF5UsADqrho
 qrfoVmYxxgAUhzQgLFH2aoerCcYQeq/NuKpmNg0ZyFtVMkusjHFgnF0nXYnYCS8t+7FS
 dgIdLtuzohyhwGMHaQblSmlJJMmRmDg1Ld9wg6z99rzJTcdlYPBuZKZrbcDVTsrj0WrH
 8f6AAQlFEk7AnjBPpApzTq6SNlpi2tJHRnsH1amljEgV3P1qAyO7wDnzrw+0M68Dih8q
 GJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782502743; x=1783107543;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ymD8IT6kcNdhPEekps/Z9O7NDXYnPeYvMCZ8i3L3Juw=;
 b=JjujFsrFeB8GTpSdC7l1R32SPzyb24enz4PebXpTlTTuH9tFOikab6Fmr9zR50ZAou
 mRjSo0DjBy1e6dQQwNWZk19lRtd+Ull98dEMO2im7O6v4in3M1yKYKTIDMv90TDGD761
 qnOGpKvoPwHukcWOUNi4SJjX1z9cYLdriSxry8/TqmWs5b29x4IDnXJ5LkMUbwMTGYnU
 frauKhTohwm6MLqJV8HnJPJHq0pzgikStYl6PRACh1ACk7gTwEN9FsPBOVzh/CGHog0M
 E/lhn+0i5OurgEGQayHGkFCbbBZngYf3TKU0ErNfxBOsOimgYWRa2S1sy6BHoFe3xU1z
 szuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ym3bAE2OSFHWwbJVtfZOz2tKGFs8yE/vAQ15STANcWDcNlVwG99QzlFyQYM3t4GELiKf7GIoYy6s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZL3ejVrII65XaNjavxFBzZq3cZ1zZwopg2hWCCGR8ZJ7MSmGA
 me86LaDGcl/Grrbd9bxfNvtzXNZd8ogxgDwyEs+es9t3kwi2zu/3zQzzxbAhffTTM+3QE9AKXgh
 N4HFx4ocq83h5Eit1JkQtbpQuPiaLTf8=
X-Gm-Gg: AfdE7cnVHymjvFQ5O9B9Duo6BL4ubLQBmaMr6QLQrPHIVFalxPg3mBDnVKDjWZFy/nB
 6XWRXKKM3wqaIJuO4/BzkZ2zC0kSPpNib5OgC81H184bYn++8eawnzwisYZVBqIGyFcHhj5LC2y
 AGFiIThRpTqW3gJsuxNgd951HRGCSyQwr20fom3Y/Bm7oxkFIAcz71JJ3vVR5tXkaG0hs1yAJ8D
 0LgyPyJ65FyMEhU1RGwhgIQV0dXyIlrV/t3bQDKcki19KM4qMByxM3Z0nealCKSd5o0zPQV0rcx
 fd4qCTtrKaz/CBWjTEcmKE7NN3ZqiywKzAAY2/OwC7g8X5KAVfNEFvdKAFxonlxv3gJ3Dw==
X-Received: by 2002:a05:7022:6b9c:b0:139:ed5b:1459 with SMTP id
 a92af1059eb24-139ed5b1529mr545472c88.9.1782502743091; Fri, 26 Jun 2026
 12:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260621173211.28443-1-oz@shift-computing.de>
 <20260621180154.30421-1-oz@shift-computing.de>
 <716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com>
In-Reply-To: <716a31c5-0484-4ef9-b49e-b71310f92d86@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Jun 2026 15:38:51 -0400
X-Gm-Features: AVVi8Ceqj9OvWI37y5ACqaKD1A7BQxhav_LOaaBB5xtZRRVm9ASTNOh1QdbNUsM
Message-ID: <CADnq5_MWX-xO=+rUzCiMR=J+Jovi8=RRJFBke=4J-7JsR1xLqQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: add firmware file fallback for APU VBIOS
 discovery
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Oz Tiram <oz@shift-computing.de>, amd-gfx@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
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

On Fri, Jun 26, 2026 at 1:42=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 6/21/26 13:01, Oz Tiram wrote:
> > APUs (e.g. AMD Radeon 780M / HawkPoint, PCI 1002:1900) have no
> > dedicated VBIOS ROM chip.  amdgpu_get_bios_apu() attempts four paths
> > before giving up:
> >
> >    1. ACPI VFCT table
> >    2. VRAM BAR read
> >    3. ROM BAR read
> >    4. platform BIOS
> >
> > On some systems all four fail:
>
> That's pretty odd to me.  Isn't this a BIOS bug?  Can you share more
> about why all of these are failing?
>
> Does the UEFI GOP driver work?
>
> >
> >    - The VFCT table is absent or contains only the discrete GPU entry
> >      (e.g. when a custom ACPI override is present for the dGPU only).
> >    - The VRAM BAR is unmapped at probe time.
> >    - The ROM BAR is zero (PCI firmware did not assign it; observed even
> >      with pci=3Drealloc,assign-busses).
> >    - No platform BIOS mapping exists.
> >
> > The driver then prints "Unable to locate a BIOS ROM" and refuses to
> > bind, leaving the APU completely unusable under Linux even though the
> > hardware is functional.
> >
> > Add a fifth fallback: request a firmware file named
> > "amdgpu/<vendor>_<device>.bin" (e.g. "amdgpu/1002_1900.bin") via
> > request_firmware().  This allows a VBIOS image extracted from the
> > running hardware
>
> I thought you just said this didn't work.  How did you extract it?

This is not likely to work which is why we don't generally support
this.  On APUs, the base vbios image is updated by the sbios at boot
depending on the runtime configuration of the specific system (OEM
display configuration, etc.).  Overriding these values with something
else can cause serious problems.

Alex

>
> > to be shipped as a firmware blob in /lib/firmware/ and
> > makes the binding succeed without any change to the ACPI tables.
> >
> > The fallback is only reached if all existing paths have already failed,
> > so there is no regression risk for boards where VFCT or ROM BAR work.
> >
> > Signed-off-by: Oz Tiram <oz@shift-computing.de>
> > ---
> > v2: Validate the fetched firmware with check_atom_bios() before accepti=
ng
> >      it, consistent with all other VBIOS discovery paths.  Save fw->siz=
e
> >      before release_firmware() so it remains valid for the size check.
> >      Release the buffer via amdgpu_bios_release() if validation fails.
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 +++++++++++++++++++++++
> >   1 file changed, 23 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_bios.c
> > index aa039e148a5e..86064c753b09 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> > @@ -26,6 +26,7 @@
> >    *          Jerome Glisse
> >    */
> >
> > +#include <linux/firmware.h>
> >   #include "amdgpu.h"
> >   #include "atom.h"
> >
> > @@ -457,6 +458,28 @@ static bool amdgpu_get_bios_apu(struct amdgpu_devi=
ce *adev)
> >               goto success;
> >       }
> >
> > +     {
> > +             const struct firmware *fw;
> > +             char fw_name[32];
> > +             size_t fw_size;
> > +
> > +             snprintf(fw_name, sizeof(fw_name), "amdgpu/%04x_%04x.bin"=
,
> > +                      adev->pdev->vendor, adev->pdev->device);
> > +             if (request_firmware(&fw, fw_name, adev->dev) =3D=3D 0) {
> > +                     adev->bios =3D kmemdup(fw->data, fw->size, GFP_KE=
RNEL);
> > +                     fw_size =3D fw->size;
> > +                     release_firmware(fw);
> > +                     if (!adev->bios || !check_atom_bios(adev, fw_size=
)) {
> > +                             amdgpu_bios_release(adev);
> > +                     } else {
> > +                             adev->bios_size =3D fw_size;
> > +                             dev_info(adev->dev, "Fetched VBIOS from f=
irmware file %s\n",
> > +                                      fw_name);
> > +                             goto success;
> > +                     }
> > +             }
> > +     }
> > +
> >       dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
> >       return false;
> >
>

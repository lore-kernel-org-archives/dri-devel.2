Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826066093F74
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o/zB8bPc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCF7010EF64;
	Mon,  2 Nov 2026 14:53:37 +0000 (UTC)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E3E310EF64
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 14:53:31 +0000 (UTC)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-5eab979d6easo138197e0c.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 06:53:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793631210; cv=none;
 d=google.com; s=arc-20260327;
 b=CoJDCYyM0x5psp59DmlBpLHPUKLcuxWbZ11JiwyAJ5TT7z1cHGx7JJoXhNh1t+ZNH6
 62gYQbpkGJYhsBlkUjb+HYwEk4e0hBaCY/G/LPPnUihWrk+bQ150llGsJsbnevylr5B1
 4CBwglmCjExqriELtIe2IOpEZOlyHYCjdn1aGhGF08amC7LsCnL2Ygv6nbthXTjEqNM5
 fGis6Bl9olgWws/adamiJ+lHwUWERlvY0ptuYmBSK515UH+LAXbWZ2j+BaUU3Kxfta/9
 gAPK+FghcuRpRFTkDUvgB5fQ7RfJ1HZALnkiD33DgseIQmu1lFzYytiAv1Ik4yVxk7T7
 mHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iv0Opuv7/g5dGhurve1r2EU5goEiuuajU/Znr60WItk=;
 fh=YYkGfXqKB6S2uboWqhy7zze0TwQt9IuGqCdIh5oCSm0=;
 b=KyX/PtlgDhTM/HBlWplFUU0vmyOInwpr0f0AwM8tiUbIYmjONiirktACM0ev0Zy0s/
 BT7lt3+TG+SnjVYYNRtA1A42FaoTdhoMBgjaiN3nguSakWTS2L00WIVa1mDEGw3EjyJX
 WRJgqc6AFeZy63W73FNBZPkIIenxpWCh4EKkn2YOLrdpdF49DzM0BFfGGUKdWVCrY6CZ
 2HJFM0jN2n5GanS5pzumTKLyRlcXGgeBB98R6A89wf/sGnrRMd6ngai9//l22qjzeqbO
 yQgO+oijDBa3n5u0tstnuSDBfQugp8L+t+aZcn17t5V+0CdKSrr2/AZjdS4pu0Sid/Oa
 ZhlA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793631210; x=1794236010; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iv0Opuv7/g5dGhurve1r2EU5goEiuuajU/Znr60WItk=;
 b=o/zB8bPclPU7EfsVBtKHknOWqbowvQtuUftRCHbx4QidAZReCBCl8widNqA4d2IHDJ
 mNWAdT7cjR4GjD69GPimIK7zhCK/n9LOU9aDqt2RmDsgpNQSoZMcDrWjbQf+229Ol3Rv
 A5O+ItHytLbmtjdeDqy1GKWeKo8c1toPRURRZx5IEzOc4FBniCPVdNWV32P6no/0O54W
 nqvD5KlOKXwmgTC01EgTCdAYLeN6o+vGF8BMoQHgfLWuKY9Px26CoGPCkqMMqaDLzOXQ
 poxJShqBzQQ66NNloFUDZPQS0yKoEiT+oOpp42a/6zGkq8941JauLCZgLIxVsaYVc9p2
 93VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793631210; x=1794236010;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iv0Opuv7/g5dGhurve1r2EU5goEiuuajU/Znr60WItk=;
 b=V9/w+edtoVZ1FR8I8pb2dYdijWuR7ZwwNxFn2I4o2T1UREZsmIedCywE0TPwgxtZYt
 jRg4f6vUI47AGhgW+fIjqxh2juLZMst4i0Rxy8t+c2L2ggZGBQABbOjZr/UY5nAOTGRW
 ePvst3bBPxM47Ro3h5N18OENaYnX8gVvZstFsPVEdSXJ6ImM2bSy6GiU6a9xrYGcdgPe
 d7vhgm0b8D6awJoi2HVhNA4DqG/gvCpVeetp5EWuNp/ZvpXGDwMz/Q9aY8Z9GsesXqBW
 zbQOAkHWwGNMvbF5pdAEyoKnF4RBgKwfEHBEiP5VDwe6mkUv0KwUzSuwg1t/As1zrJc5
 CqBA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2XmWzphIeQZTL8VzjZemfp1tIN97BIIo2ZYZ1WxjqV2ZhEMvEgw6u4v16K5PXe9ijmi1RQw1Fpl4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/HXJDgEVcqt3QrujMotP8ALdc3U8YOiEXMiNJvv8+08n/uTJDH
 VigxdfFNiV7iRg5Xkz19vvz6AEbTTpG2FRFDQJUwjcbk4IL7AqwxPkRhntG4NYZsvksNveVBbb5
 d0hKZXJQ+T9D2o53Ya9jsu1/f7s+qmk4=
X-Gm-Gg: AYBFou3LH4qQDG7vEM4wjC3abVVLJZW+qmyrBT/z/oObPY1i7LuoOFKntwdcNgf5pXO
 Rhx+SW0gfFpcXRF+gHv+gjxtE7LPkCEc7sSxIc/tKqEskK4+mCZK6rmiman7BtzpiRwuUqbLceE
 1flmfGJVyBsNiHxqUNTzNGHJRaoTT52pOlrznlHW0ptN59lCRtCX+QmVrCb6ifCjyLaI/ZZosGy
 39w9DISFaGXietPVkwkeNeNSJl4ZcrRKVuqqd2RkRFfaTv1T8o/oahsR+72flksWmqpXpqC1TRn
 01ClwU/JFflq+AMUJpiHy9qqAfeXFO44TOAgrEAyEyxHT4W/Q+VQwarVjOhY1LHZo8NgXrNMZ3U
 GL51WFHrPP2imVXAW25RNric8YmDtolKXPTWABmNpHqG5HnYbCZ+F9ibsAaDWdIGaa1cjLCaMf5
 8xHlIJ4IELikuAtGFMPEYBxfk=
X-Received: by 2002:a05:6122:2b16:b0:5e0:2ba:5a06 with SMTP id
 71dfb90a1353d-5ec6896981emr4303924e0c.4.1793631209491; Mon, 02 Nov 2026
 06:53:29 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <6C5E74D6-8F98-48BC-9173-7E85D243B3D3@gmx.net>
 <sashiko-outbox-191902@kernel.org>
 <2630FE08-2F46-4D29-AF3C-DD9EF2DE581E@gmx.net>
 <sashiko-outbox-192131@kernel.org>
 <3CAB8D41-76B4-49D9-A4B4-6C78A93296C3@gmx.net>
In-Reply-To: <3CAB8D41-76B4-49D9-A4B4-6C78A93296C3@gmx.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Nov 2026 09:53:16 -0500
X-Gm-Features: AclHuK8wHgKFAL9IE6u51OD-FgMQVUF63LQs5DMX6Z93wgGJFSyEsyc3E1Nf9Ac
Message-ID: <CADnq5_OP7RLsj_RgEX9UN06x7_9wVWMX9FzTCP6+Je0ogxb72A@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: prefer exact bus match in VFCT VBIOS lookup
To: Matthias Kesenheimer <m.kesenheimer@gmx.net>
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, alex.deucher@amd.com, christian.koenig@amd.com, 
 airlied@gmail.com
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

On Sun, Nov 1, 2026 at 7:11=E2=80=AFAM Matthias Kesenheimer
<m.kesenheimer@gmx.net> wrote:
>
> When multiple cards share the same PCI device ID (e.g. RX 6600 and
> RX 6600 XT both use 0x73ff), the VFCT table contains separate VBIOS
> images for each card distinguished by their bus number.
>
> The current implementation iterates VFCT entries and returns on the
> first device-identity match, which may not have an exact bus match.
> This causes cards to load the wrong VBIOS image (e.g. RX 6600 loading
> RX 6600 XT's VBIOS), resulting in incorrect clock speeds and
> potential system hangs.
>
> Walk the VFCT table in a single pass, preferring an exact bus match.
> amdgpu_acpi_vfct_match() returns 0 on an exact bus match, 1 on a
> device-identity-only match, or -ENODEV on no match. The walk records
> the matched entry - an exact bus match ends the walk immediately,
> otherwise the first device-identity match is kept as a fallback. The
> VBIOS is then loaded and validated once, after the walk, and the
> bus-mismatch notice is emitted only when that fallback is actually
> used.
>
> Changes since v2:
> - Load and validate the VBIOS once, after the walk, instead of
>   duplicating the kmemdup()/check_atom_bios()/amdgpu_bios_release()
>   sequence between the exact-match and fallback branches.
> - Only emit the bus-mismatch notice when the device-identity fallback
>   is actually used, avoiding a false notice on multi-GPU systems where
>   an exact bus match exists.
>
> Signed-off-by: Matthias Kesenheimer <m.kesenheimer@gmx.net>

This should be fixed properly with this series:
https://patchwork.freedesktop.org/series/176969/

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 66 ++++++++++++++++--------
>  1 file changed, 44 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index f9315e0472fe..d69f8df87249 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -441,7 +441,8 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_d=
evice *adev)
>   * the bus numbers disagree we accept the entry if the device identity
>   * matches.
>   *
> - * Returns: 0 on match, -ENODEV on no match
> + * Returns: 0 on exact bus match, 1 on device-identity match (bus
> + * mismatch), -ENODEV on no match
>   */
>  static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
>                                   VFCT_IMAGE_HEADER *vhdr)
> @@ -460,11 +461,7 @@ static int amdgpu_acpi_vfct_match(struct amdgpu_devi=
ce *adev,
>                 return 0;
>
>         /* Bus mismatch but device identity matches (PCI renumbering case=
) */
> -       dev_notice(adev->dev,
> -                  "VFCT bus number mismatch: table %u !=3D runtime %u, m=
atching by device identity (vendor 0x%04x device 0x%04x)\n",
> -                  vhdr->PCIBus, adev->pdev->bus->number,
> -                  adev->pdev->vendor, adev->pdev->device);
> -       return 0;
> +       return 1;
>  }
>
>  static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
> @@ -474,6 +471,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_devic=
e *adev)
>         UEFI_ACPI_VFCT *vfct;
>         unsigned int offset;
>         bool r =3D false;
> +       GOP_VBIOS_CONTENT *vbios =3D NULL;
>
>         if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
>                 return false;
> @@ -487,8 +485,9 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_devic=
e *adev)
>         offset =3D vfct->VBIOSImageOffset;
>
>         while (offset < tbl_size) {
> -               GOP_VBIOS_CONTENT *vbios =3D (GOP_VBIOS_CONTENT *)((char =
*)hdr + offset);
> -               VFCT_IMAGE_HEADER *vhdr =3D &vbios->VbiosHeader;
> +               GOP_VBIOS_CONTENT *entry =3D (GOP_VBIOS_CONTENT *)((char =
*)hdr + offset);
> +               VFCT_IMAGE_HEADER *vhdr =3D &entry->VbiosHeader;
> +               int match;
>
>                 offset +=3D sizeof(VFCT_IMAGE_HEADER);
>                 if (offset > tbl_size) {
> @@ -502,23 +501,46 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_dev=
ice *adev)
>                         goto out;
>                 }
>
> -               if (vhdr->ImageLength &&
> -                   !amdgpu_acpi_vfct_match(adev, vhdr)) {
> -                       adev->bios =3D kmemdup(&vbios->VbiosContent,
> -                                            vhdr->ImageLength,
> -                                            GFP_KERNEL);
> -
> -                       if (!check_atom_bios(adev, vhdr->ImageLength)) {
> -                               amdgpu_bios_release(adev);
> -                               goto out;
> -                       }
> -                       adev->bios_size =3D vhdr->ImageLength;
> -                       r =3D true;
> -                       goto out;
> +               if (!vhdr->ImageLength)
> +                       continue;
> +
> +               match =3D amdgpu_acpi_vfct_match(adev, vhdr);
> +               if (match < 0)
> +                       continue;
> +
> +               if (match =3D=3D 0) {
> +                       /* Exact bus match wins - use it and stop scannin=
g */
> +                       vbios =3D entry;
> +                       break;
>                 }
> +
> +               /* match =3D=3D 1: record the first device-identity match=
 as a fallback */
> +               if (!vbios)
> +                       vbios =3D entry;
>         }
>
> -       dev_info(adev->dev, "ACPI VFCT table present but broken (too shor=
t #2),skipping\n");
> +       /* Load and validate the matched VBIOS once */
> +       if (vbios) {
> +               VFCT_IMAGE_HEADER *vhdr =3D &vbios->VbiosHeader;
> +
> +               if (vhdr->PCIBus !=3D adev->pdev->bus->number)
> +                       dev_notice(adev->dev,
> +                                  "VFCT bus number mismatch: table %u !=
=3D runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n=
",
> +                                  vhdr->PCIBus, adev->pdev->bus->number,
> +                                  adev->pdev->vendor, adev->pdev->device=
);
> +               adev->bios =3D kmemdup(&vbios->VbiosContent,
> +                                    vhdr->ImageLength,
> +                                    GFP_KERNEL);
> +
> +               if (!check_atom_bios(adev, vhdr->ImageLength)) {
> +                       amdgpu_bios_release(adev);
> +                       goto out;
> +               }
> +               adev->bios_size =3D vhdr->ImageLength;
> +               r =3D true;
> +       } else {
> +               dev_info(adev->dev, "ACPI VFCT table present but broken (=
too short #2),skipping\n");
> +       }
>
>  out:
>         acpi_put_table(hdr);
> --
> 2.56.0
>
> > On 31. Oct 2026, at 21:51, sashiko-bot@kernel.org wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 3 potential is=
sue(s) to consider:
> > - [Medium] drm/amdgpu: changelog and Signed-off-by placed below --- sep=
arator
> > - [Low] drm/amdgpu: false bus-mismatch notice in amdgpu_acpi_vfct_match=
()
> > - [Low] drm/amdgpu: duplicated VBIOS load logic in amdgpu_acpi_vfct_bio=
s()
> > --
> >
> > commit 02e5f189d060ccb33fa88a19690736b51eba300f
> > Author: Matthias Kesenheimer <m.kesenheimer@gmx.net>
> >
> > drm/amdgpu: prefer exact bus match in VFCT VBIOS lookup
> >
> > This commit modifies amdgpu_acpi_vfct_bios() and amdgpu_acpi_vfct_match=
()
> > to walk the ACPI VFCT table in a single pass, preferring an exact PCI b=
us
> > number match and falling back to the first device-identity match only i=
f no
> > exact bus match is found.
> >
> >>    drm/amdgpu: prefer exact bus match in VFCT VBIOS lookup
> >>
> >>    Thanks for the review. Addressing both points:
> >>     - The unused fallback_vbios/fallback_vhdr are now actually used: t=
he first device-identity match is recorded during the pass and loaded only =
if no exact bus match is found.
> >>    - Collapsed the two passes into a single table walk, keeping all ma=
tching logic in amdgpu_acpi_vfct_match() (returns 0 exact-bus / 1 identity-=
only / -ENODEV none). Matching behavior is unchanged from v1.
> >>
> >>    The patch works on a live system.
> >
> > [Severity: Medium]
> > It looks like the v2 review reply was placed above the --- separator, w=
hile
> > the actual commit description and Signed-off-by tag were placed below i=
t.
> > When applied via git am, everything below --- is stripped, leaving the
> > commit without its changelog explanation or Signed-off-by tag. Could th=
e
> > commit description and Signed-off-by be moved above the --- line, with =
the
> > v2 changelog notes below it?
> >
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_bios.c
> >> index f9315e0472fe9..ef9fd98eb9e1a 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> >> @@ -441,7 +441,8 @@ static bool amdgpu_read_disabled_bios(struct amdgp=
u_device *adev)
> >>  * the bus numbers disagree we accept the entry if the device identity
> >>  * matches.
> >>  *
> >> - * Returns: 0 on match, -ENODEV on no match
> >> + * Returns: 0 on exact bus match, 1 on device-identity match (bus
> >> + * mismatch), -ENODEV on no match
> >>  */
> >> static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
> >>  VFCT_IMAGE_HEADER *vhdr)
> >> @@ -464,7 +465,7 @@ static int amdgpu_acpi_vfct_match(struct amdgpu_de=
vice *adev,
> >>   "VFCT bus number mismatch: table %u !=3D runtime %u, matching by dev=
ice identity (vendor 0x%04x device 0x%04x)\n",
> >>   vhdr->PCIBus, adev->pdev->bus->number,
> >>   adev->pdev->vendor, adev->pdev->device);
> >> - return 0;
> >> + return 1;
> >> }
> >
> > [Severity: Low]
> > Will amdgpu_acpi_vfct_match() log a false bus-mismatch notice when prob=
ing
> > the second GPU on a system with multiple identical PCI device IDs?
> >
> > When amdgpu_acpi_vfct_bios() walks the VFCT table for the second card,
> > amdgpu_acpi_vfct_match() first encounters the entry for the first card =
on a
> > different bus and immediately prints:
> >
> >    dev_notice(adev->dev,
> >               "VFCT bus number mismatch: table %u !=3D runtime %u, matc=
hing by device identity (vendor 0x%04x device 0x%04x)\n",
> >               ...);
> >
> > before returning 1, even though a subsequent VFCT entry matches the sec=
ond
> > card's bus number exactly and is used instead.
> >
> > Would it be better to move this dev_notice() out of amdgpu_acpi_vfct_ma=
tch()
> > and emit it in amdgpu_acpi_vfct_bios() only when the fallback entry is
> > actually selected after the loop?
> >
> >>
> >> static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
> >> @@ -474,6 +475,8 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_de=
vice *adev)
> >> UEFI_ACPI_VFCT *vfct;
> >> unsigned int offset;
> >> bool r =3D false;
> >> + GOP_VBIOS_CONTENT *fallback_vbios =3D NULL;
> >> + VFCT_IMAGE_HEADER *fallback_vhdr =3D NULL;
> >>
> >> if (!ACPI_SUCCESS(acpi_get_table("VFCT", 1, &hdr)))
> >> return false;
> >> @@ -489,6 +492,7 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_de=
vice *adev)
> >> while (offset < tbl_size) {
> >> GOP_VBIOS_CONTENT *vbios =3D (GOP_VBIOS_CONTENT *)((char *)hdr + offse=
t);
> >> VFCT_IMAGE_HEADER *vhdr =3D &vbios->VbiosHeader;
> >> + int match;
> >>
> >> offset +=3D sizeof(VFCT_IMAGE_HEADER);
> >> if (offset > tbl_size) {
> >> @@ -502,8 +506,15 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_d=
evice *adev)
> >> goto out;
> >> }
> >>
> >> - if (vhdr->ImageLength &&
> >> -    !amdgpu_acpi_vfct_match(adev, vhdr)) {
> >> + if (!vhdr->ImageLength)
> >> + continue;
> >> +
> >> + match =3D amdgpu_acpi_vfct_match(adev, vhdr);
> >> + if (match < 0)
> >> + continue;
> >> +
> >> + /* Exact bus match - use immediately */
> >> + if (match =3D=3D 0) {
> >> adev->bios =3D kmemdup(&vbios->VbiosContent,
> >>     vhdr->ImageLength,
> >>     GFP_KERNEL);
> >> @@ -516,9 +527,29 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_d=
evice *adev)
> >> r =3D true;
> >> goto out;
> >> }
> >> +
> >> + /* Device-identity match (bus mismatch) - record as fallback */
> >> + if (!fallback_vbios) {
> >> + fallback_vbios =3D vbios;
> >> + fallback_vhdr =3D vhdr;
> >> + }
> >> }
> >>
> >> - dev_info(adev->dev, "ACPI VFCT table present but broken (too short #=
2),skipping\n");
> >> + /* No exact bus match - use the first device-identity match */
> >> + if (fallback_vbios) {
> >> + adev->bios =3D kmemdup(&fallback_vbios->VbiosContent,
> >> +     fallback_vhdr->ImageLength,
> >> +     GFP_KERNEL);
> >> +
> >> + if (!check_atom_bios(adev, fallback_vhdr->ImageLength)) {
> >> + amdgpu_bios_release(adev);
> >> + goto out;
> >> + }
> >> + adev->bios_size =3D fallback_vhdr->ImageLength;
> >> + r =3D true;
> >> + } else {
> >> + dev_info(adev->dev, "ACPI VFCT table present but broken (too short #=
2),skipping\n");
> >> + }
> >
> > [Severity: Low]
> > As reported by Sashiko on v1 [1], this isn't a bug, but the kmemdup(),
> > check_atom_bios(), and amdgpu_bios_release() sequence in
> > amdgpu_acpi_vfct_bios() is still duplicated between the exact-match bra=
nch
> > inside the loop and the fallback_vbios branch after the loop.
> >
> > Since vhdr is &vbios->VbiosHeader, could the loop simply record the mat=
ched
> > GOP_VBIOS_CONTENT pointer (breaking immediately when match =3D=3D 0) an=
d run the
> > allocation and validation once after the loop?
> >
> > [1] https://lore.kernel.org/r/6C5E74D6-8F98-48BC-9173-7E85D243B3D3@gmx.=
net
> >
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2630FE08-2F46-4=
D29-AF3C-DD9EF2DE581E@gmx.net?part=3D1
>

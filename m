Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B656072200
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W4Rcgq1Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AD0C10E694;
	Mon,  2 Nov 2026 16:26:32 +0000 (UTC)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6689210E694
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 16:26:21 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1397a4855beso168890c88.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 08:26:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793636781; cv=none;
 d=google.com; s=arc-20260327;
 b=TCCLHG2pwpcJvhMmZBlmRhZwdyNX0jO/tDy9A1+yTw4eFJk2q7vhYacBMT7MC+MHps
 w2xkWzPa3E6Lla495jGoC2PqJjpEKEmEb5Ve64T4LVDewCmkMRo53uuh1xd6mE3VxF14
 +G3g4RQ9DV6hnVlLVymlXY5h/L1fmrL72vdZMKIUEIT7sCF0CzG7H12s7o7hTJ2ibgUx
 drppj6sCA6725hB5rxlllj3Gy+HwPmswXCxU7N6FeygjUePa0NbdzqYrSyzbYJE4tXXU
 lGZtYzhmNfwTqpsij6GI4Wzmb7sX++sEJk4fCkI+phN7Gy4h8g/C0p3qddaJGN0rNH3i
 EE/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qucegT0GPEVFirSiuMs+ziNH5YCrypPe21lyqCO0TWs=;
 fh=2rSmgt4QXBKRThjPxbXh3jYK6d+1iijT0bEMBjm3r1I=;
 b=DUuaen1tJndFB6ee2+RqSwARdyClaa6fj5c8YLGA0P12h85f7Fm0m84eujX/9gDvba
 +vD9S5c1cnvoai0lGjvB94iZBVYylVCi1+wXVYcbfHwTS/ew7/+cH9DesygwG+urh3HM
 8jQwNjgHvmJ6RMvh5dv0njnV0rmFmKnFGjV/XoGb3I+Nms/48I3Hx+FZSQ+lHs8lTFcB
 A9c3fODBOyv0sBRdhAyk1VjxJF3qqbzUIvlTvPBHkqlgLjiKgkpdzNirQ/ihC0vkuqA0
 Oo4r4i6p+dYn5+kXmEThMLsGoQVSIL/yzKtc8I4Mu4gPWeICAAujnSHz0AVZZns6P9v+
 sz7g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793636781; x=1794241581; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qucegT0GPEVFirSiuMs+ziNH5YCrypPe21lyqCO0TWs=;
 b=W4Rcgq1YnhL0tZw9YTqeE2LqTHnIZc9czMuaYrD2KV9JcyFjUgdvtly53F9uOljJPH
 Tjgx+hLyqjzZOkCV+WV2iofoyuC8FjDJBJksAxN/r6xTcbFHPRkOx/vcpdOl09W6ldON
 LR5v2LpqadDOlxcp2H9noGVEo9NhlJzld+uvjsMmIeQ0nV/E32tuR8AF1RKDBDg2VaC/
 s8q2WKHA5PJiNLUf3qRfPq7pIXGiSjt8F4cCEvEMagtQ7dQp6XtnGECzEIZSI0S0Pjrl
 XGD04WT6xKf+rCx111RoJ1EmiPwrPNKMFGpL2nBzmShGN0C79m1C2MbIym7dhT7BiAK6
 JYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793636781; x=1794241581;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qucegT0GPEVFirSiuMs+ziNH5YCrypPe21lyqCO0TWs=;
 b=a+9YW4Uf8G1E5LuLu1usi3xiMGX6VpRdCio8z5bGgGUlZ/5gs7jFqyzAVkVnV6xuv3
 TsxFtxsVEqPFL6rzN4DjjGGey0EsEW6hpZ/JEFpYscopy82/etjFCu9/rrc8BoJEWDu/
 jnYOyX+1fNzVfle5Wr9Js7quhOHmiWNQucsfLaQLvAP+X0/xovim0JM5pqf4Whdvaklm
 wKj7/niEIKH0xBwz+ktV6YiN7mCghrCeob2XD2vc208cJ5nQp651sRqWs+kSqrL8xCs1
 kavunB+re+cTj9tiB2wirI6qWSL6o04mbdRw+nratz5b+vk6qxCTfU/Fal5eHDI5ZyTh
 fmfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtaT3KxNrghD6cuyrjnNf7pSRDB/7yHt9QgkHfxellkpxT5x9NJbv1xeflg9w1cF2WyqCs+ZkqziI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLxAQUy7leVd2F55dEfJx1Bo00Af+Lp8gVAKENzq338prf0INr4
 NMitKQk/fWuCrOq8ky6g4bgZxw6ZXgurDaA+rQPJg0FmAPU9D6o3YnRpMruCyZZ7hHNxC7+LBMv
 GMi2tCZh4kSsatDFdfHNIEjO4DY+/Hp4=
X-Gm-Gg: AYBFou1AvQtPxSI21LfbCuBOPuKspmLdfoFSmCcLpcvYDub6QPaqR2649gdx4fxIdX5
 MhcNj+65oQMl2FRVSAWLxd8BxUEbCKREdEsxTTshpEilIBhtmKdS1U+Aco+9pPMiCbDoBu/vFmU
 mODugB5e7wyUv9joPXZqBO2ZkeEPj1fQuWTHzmEBxnFCgdik45lEa23C9ay45Xj0Z2I7qGUSHeJ
 GbHDuIYS7a5uE8YBdvQsX1/faIl1/ewPRwJqJPO4ofcxTkrV0z9N9qKMmySCgABLNGjvjDLs9ww
 ZeS70XhwatdDeb2YuXKEhe3rkXqAmV/ykLJRA57cLAXsMCxuJgq6NOR25lfpJkCAwU7f8ztDNix
 CcQKkZtpSW5oDqT+BhcT+8a4qrteWUzPppv5uz5NrsdpErg+XKR4YJi7nr4isiOSzC9rXJnltmm
 KHVqMG4CWy3ETSGLYKt6WTIILqO4zkNDDuP6D/HnwEB15Z
X-Received: by 2002:a05:7022:c90:b0:127:def:dd72 with SMTP id
 a92af1059eb24-1ac5914348dmr21533874c88.2.1793636780378; Mon, 02 Nov 2026
 08:26:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMwFX_CpeF-K1-9R38Fscu7EghETOOV5FmJvd=8No7YhapvL1w@mail.gmail.com>
In-Reply-To: <CAMwFX_CpeF-K1-9R38Fscu7EghETOOV5FmJvd=8No7YhapvL1w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Nov 2026 11:26:08 -0500
X-Gm-Features: AclHuK9xq0E4ivi-W8VggfJkbcZCnlA03ilqfpjC2gopSzo50cdjzh-WV6hPi_g
Message-ID: <CADnq5_P-oF5U1sYWiDKGNRZOCEc5p-oOFA9zJpH69Cb2dUSEdQ@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/radeon: UVD GTT corruption and RV6xx coverage
To: Ted Bullock <tbullock@comlore.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org, airlied@gmail.com, 
 simona@ffwll.ch, linux-kernel@vger.kernel.org
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

Applied.  Thanks!

On Thu, Oct 29, 2026 at 4:05=E2=80=AFAM Ted Bullock <tbullock@comlore.com> =
wrote:
>
> I investigated video corruption on my older iMac7,1 (RV610/M74,
> device ID 1002:94c8).
>
> When the decoder was reading compressed video from system memory while
> the GPU was drawing, it would corrupt video frames. Moving the input
> to VRAM allowed frames to decode correctly. Disabling graphics draws
> also stopped the corruption.
>
> Here is a proposal to keep UVD buffers in VRAM for this family of
> devices, as the driver already does for some other chips. The patch
> covers RV610, RV620, RV630, RV635 and RV670. These chips share the
> RV6xx decoder path and legacy R600 firmware, so I think they are
> likely to have the same hardware requirements. Someone with the
> other hardware would need to verify that.
>
> I tested this on Debian.
>
> I used Codex to help with the investigation, testing and patch.
>
> Signed-off-by: Ted Bullock <tbullock@comlore.com>
> ---
>  drivers/gpu/drm/radeon/radeon_cs.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_cs.c
> b/drivers/gpu/drm/radeon/radeon_cs.c
> index 2db819a..9bfd3ea 100644
> --- a/drivers/gpu/drm/radeon/radeon_cs.c
> +++ b/drivers/gpu/drm/radeon/radeon_cs.c
> @@ -125,11 +125,16 @@ static int radeon_cs_parser_relocs(struct
> radeon_cs_parser *p)
>
>                 /* The first reloc of an UVD job is the msg and that must=
 be in
>                  * VRAM, the second reloc is the DPB and for WMV that mus=
t be in
> -                * VRAM as well. Also put everything into VRAM on AGP car=
ds and older
> -                * IGP chips to avoid image corruptions
> +                * VRAM as well. Also put everything into VRAM on RV6xx, =
AGP cards
> +                * and older IGP chips to avoid image corruptions
>                  */
>                 if (p->ring =3D=3D R600_RING_TYPE_UVD_INDEX &&
>                     (i <=3D 0 || pci_find_capability(p->rdev->pdev, PCI_C=
AP_ID_AGP) ||
> +                    p->rdev->family =3D=3D CHIP_RV610 ||
> +                    p->rdev->family =3D=3D CHIP_RV620 ||
> +                    p->rdev->family =3D=3D CHIP_RV630 ||
> +                    p->rdev->family =3D=3D CHIP_RV635 ||
> +                    p->rdev->family =3D=3D CHIP_RV670 ||
>                      p->rdev->family =3D=3D CHIP_RS780 ||
>                      p->rdev->family =3D=3D CHIP_RS880)) {

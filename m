Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2FEC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 13:24:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C548D10EC22;
	Wed, 29 Jul 2026 13:24:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ljg11bEm";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 752CA10EC3A
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 13:24:46 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-383fff6e8b6so47563a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 06:24:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785331486; cv=none;
 d=google.com; s=arc-20260327;
 b=IhM7igFeu8aOM3hXqk1iOif+BBYpa0w3YoQEb1gBrEr/9nQk+G0D0mWAPdMItDPlcn
 yqtglEE0boWCX6CJokO2HhczBajaZl/fgWYyiGjrFp2PDoUZktI71XOF48PteVshGkux
 zX1FrJsu7kLlSOMDEWkjA0yK4W3MkhXaw2UgGQ+WnxxDN+otKbhFYMrwys22h+rSXsqk
 NWlcvVlBhDIJAovEQn62EW/b3DDRT49muyy2EALJw6/P0tMmow9HPKHibbhuOkyIrnDU
 7HH6vW75P9PTsxcTQypDhHlC3YMFGc9RkHdiRzk8RSzLJ3x5eAv+xii4wV11eg0fcGw+
 s3Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FMxHAg20evSZle1OQ/hLhWCF0lxvl+hBcpKqdq68BZs=;
 fh=MK9H8yHFFwcon8Nzp1BgwhjpGICZN2xON76I7FmpaUk=;
 b=BzpqyX37Jd4+TMSGrce9Jsl+d2dV5DMLwMY897C04scRl9ZNgPmE1Z6CNU49LDV0SB
 kSC++sC1P7y6WIEryaT50x4tGDkNqjEyDcoV2+KkSqVkD9xYjMXvdJZbD+FUzjx5/dUA
 a9zCQ8Maa/1H5KTmISDA3ahjnVh8t+ffxC9jAno4jz7x3VWvpeaZ9v/6I+F6gkRqvRhT
 FNKG8TNGGMt/tcLOBjn/8zhq8wrtFSyw7EniPs4CWasYpmjGFFF1mz+A5u9sztjN9/qT
 u+0Ydm+fUlRgFpo/Poh55fnlGd8DZwhPz0fv5rz4qrZm83ER9hzwUl/OaDXs0FB01Nx4
 oXbg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785331486; x=1785936286; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FMxHAg20evSZle1OQ/hLhWCF0lxvl+hBcpKqdq68BZs=;
 b=ljg11bEmHvkotAPgTdf6ctacYvIilthOX5NvxF7riR4iylUTsuCBJoyr+lAVS0Kuua
 ZSL61YnZ0bnxmEcp8tYdHX3Cz5q8+cEU64LI8dKdS9b0Wi0JQqyULjbqs9KZKZmw6QUK
 y9rZa/N01YHr6FGhGfdnbg6xfn607Ifx8Ilouc3/uf7RgvR5xzXm2M8s9KxjJzExEhjx
 jjV08HAn33xZSunRZwSwmOpxDg6eNPtnivxRei8zrvWxo5HUKXmn4CDJ8eu32lSgZovj
 lbCYtMzpdsf1mexKimw88VeOGvgaI1B9rFJyQvZcW1DaNK2TyOUC+Kwvm6PQXdWlBkBL
 HJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785331486; x=1785936286;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FMxHAg20evSZle1OQ/hLhWCF0lxvl+hBcpKqdq68BZs=;
 b=SyjEJ0MzskbUTTFHW6R5t+0i0T+BAg8dIpYPnkOeQawpuMAUV3GiAhzvNEjg0KIMoo
 vI42mpUlWRxPDehBhOZ/WCZycZEHwTxUP3VEx5+rBfFP3SXjO0kPKl1sgePDyeFcu3Ak
 4NBTq2b5PcEMen8fcgU+R6yZfV69mDdB2iJefoZTgCvvqcI4EarGmN63+RuhOgu8ELjF
 YliIeQ4YfbPtAyCeKdtj7Y7D6I8f8gbi6Et68Xgd5ftNZsncJsfxM1TRsaRjmITBO9Ti
 r09gf4fvyVU7RunB2dqZBX7n1cGLuvd2WQhzZUQstszZOzecRGdWEwdnOz2Nd86SYMQO
 bQ+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RreemPrag7xhqR7GV1n3n24DLtD9kQhk3JBt9UIy+J07l7QvjV8l4AfR3DaJmle5qF2G8636mQRx1c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBa5VuNc2h6M6zHuMHcMMqFkfqAB+sO4IuDkrpsAo1s2qqZSTy
 1GElkhh/PwK2qH28bxrS8mqr8uNUiI27vm5ybozgAb9FB0oXHkx3u7O7SaX24JwfyPXoB4smoze
 epGlEjWwPt7nwoZx3Ten/AJcdHVfp7Aw=
X-Gm-Gg: AR+sD11O0laXBxFMazSMEAnH/+vfHkylQ9MRM0Bs4rSWoxBUDVt/1tsSPlC6fOWS3ES
 z0hIubY2uL7IJvv65F23wDvNGnO8ISEE/dnnEfeeGHeBJByDQt4MqzItsmcQtOyiakS00X5ev9h
 JIstqbMd8/PAyUbwsq95JQqF6FTfiPwtYxVv71KuwcQTwZH57Zk3mHLxByW53Ej/bvrrXKTx29p
 CVtBe28uzFQPS8iOm/PIFVWRFhblM7vRN7kG1dUfVp/cvYqYcOTFCLWiiO1Tg1/iW3eEuWT2gpa
 kii1VgiNjRGmdc09rr+dM/mYBgjSwKZTNFkTr5Yk7ipMKuZv5Yb5UveJ+en0h7sLdgFcarZcWT6
 emq4wu/GHlFvWUb24odipYHqa+gYF0Hk=
X-Received: by 2002:a17:90b:3a0e:b0:38e:7069:7117 with SMTP id
 98e67ed59e1d1-38f6a1ad171mr6178956a91.0.1785331485948; Wed, 29 Jul 2026
 06:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260728234626.86008-1-teobsn@gmail.com>
In-Reply-To: <20260728234626.86008-1-teobsn@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Jul 2026 09:24:33 -0400
X-Gm-Features: AUfX_mxTF-LZlWrjXh4LBoMXhrUraGcVIVWGEA4djUJLfvmV7rvBy26t_YHkV14
Message-ID: <CADnq5_NEU98wff+MiLObBByUUMNkkz7XLZ9MUnGNr1e0B+EKvQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Add PPTable power limit quirk for ASUS G14
 GA402R
To: Teodor Bostan <teobsn@gmail.com>, "Wang,
 Yang(Kevin)" <KevinYang.Wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kenneth.feng@amd.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, 
 mario.limonciello@amd.com, dri-devel@lists.freedesktop.org
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

+ Kevin

On Wed, Jul 29, 2026 at 9:23=E2=80=AFAM Teodor Bostan <teobsn@gmail.com> wr=
ote:
>
> ASUS ROG Zephyrus G14 (2022) GA402RJ and GA402RK laptops use custom AC
> power limits of 100W (RX 6700S) and 105W (RX 6800S). On resume from
> suspend, the SMU firmware resets to the reference vBIOS default of 80W,
> hard-capping GPU performance.
>
> Override SocketPowerLimitAc in sienna_cichlid_patch_pptable_quirk for
> these subsystem IDs so the driver restores the platform's intended AC
> power limit when reloading PPTable during boot and resume.
>
> Signed-off-by: Teodor Bostan <teobsn@gmail.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index cef628752..10d330edb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -479,6 +479,7 @@ static int sienna_cichlid_patch_pptable_quirk(struct =
smu_context *smu)
>         struct amdgpu_device *adev =3D smu->adev;
>         uint32_t *board_reserved;
>         uint16_t *freq_table_gfx;
> +       uint16_t *power_limit;
>         uint32_t i;
>
>         /* Fix some OEM SKU specific stability issues */
> @@ -501,6 +502,18 @@ static int sienna_cichlid_patch_pptable_quirk(struct=
 smu_context *smu)
>                 }
>         }
>
> +       /* Fix some OEM SKU specific power limit issues */
> +       if ((adev->pdev->device =3D=3D 0x73EF) &&
> +           (adev->pdev->subsystem_vendor =3D=3D 0x1043)) {
> +               if (adev->pdev->subsystem_device =3D=3D 0x1DEC) {
> +                       GET_PPTABLE_MEMBER(SocketPowerLimitAc, &power_lim=
it);
> +                       power_limit[PPT_THROTTLER_PPT0] =3D 100;
> +               } else if (adev->pdev->subsystem_device =3D=3D 0x1DCC) {
> +                       GET_PPTABLE_MEMBER(SocketPowerLimitAc, &power_lim=
it);
> +                       power_limit[PPT_THROTTLER_PPT0] =3D 105;
> +               }
> +       }
> +
>         return 0;
>  }
>
> --
> 2.55.0
>

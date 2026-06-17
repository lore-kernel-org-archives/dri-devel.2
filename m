Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9D2CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:39:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0500510EFFE;
	Wed, 17 Jun 2026 14:39:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OufI4x3o";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3199A10EA50
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 14:39:55 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-304f8e80b7eso451446eec.3
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 07:39:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781707194; cv=none;
 d=google.com; s=arc-20240605;
 b=CCE14AND4V2eROXjV/G88WxcMO6IBUErrgwOzzn8VYAA89LopLFwGlevOlqJ16LtTv
 hFYiCoO9/CaSrmT/NLSolvXucCBr7brziHN5983IOzL6h4TWlan+2OQCUPX3ohrltBN4
 F6tx5Dj5+EkE238/XeZp7cQutH3ODXSVf4iR/721C7Ngq9kDigU520gdNZX1HtUib0BP
 QXoq+lSSqmK8WNEjzYle6mgkfni/kURBty50QvZRRbvP5H4rzpW+19iwBgJj0Tnqt0Vx
 SIXDgpktjuL6P+6lRNoCoG6unTuQtDNNdL1On9rYeNvBO50oqNC3TGigxrEeJvWrYmyR
 i26A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=H+dC1Ehi3qgIqIz5guL69Mk1/vs8Hz96N955RLbsg+I=;
 fh=KymoFT0LKK3a6nVyPbNRa7QvlTu5TMDET3SbudhDcyU=;
 b=Bc/S+6jeUspMTodMu2L0OEckFjs9kXlvwwNRHzq4x5auy4e8XVANmzhcFKZz7pHDd3
 LXTGu4AlbhUhkCBLQ+IZqL/z2uol/UkY6Uv658hvTgrln2reYlv2YYKDcXwRG6yuvpnP
 aE50ScEY6RwL85y8lLv98HXsp+QBQl2s6Vxn27ppdQdhKireWNLAf9UYPcc8+011CEXd
 /s86BBnRCCqpXgGuq/tpKk50fPu0xB+6U9X+5m4hlSsrluk08dQctxBa8gPFT3kxMOLA
 MtDWtI6QK5C3q0VmR0yOXE+jCgKhe+t5g5sQc33h17t9NxbIBZuRl22Rln0LP0yB5zcH
 2WWw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781707194; x=1782311994; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+dC1Ehi3qgIqIz5guL69Mk1/vs8Hz96N955RLbsg+I=;
 b=OufI4x3ogDh2D1nCdYoPcJnC8urZoC0WQ7KJyobmEGIDFsU/f0adXIo03Q3CL783tZ
 Kst10F/V9c0dD7jvyR/kNOnkiUGolIozxcjjULf6IffOC+riFrnTOPDNAKQtEMpV2zoF
 6tpU8k9vCfvEmlKGwdTr+By9Wq6uxQGKH085Mga9YV1kagHUCA+/7wE9dnO7hqbpKwDE
 pGrszkd+Ve0e/YIIxwQjp/1+sV1M6CeXxNOAtWpBf3K3g5rS5VYjiHAoUQyzmkNbox+z
 tx4FQqzJd2a7bkhTmbTKdVDiizU8roEdl4F64QJWwGYxrn3B5HvFMbWA4izEHWUGkl1H
 C0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781707194; x=1782311994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H+dC1Ehi3qgIqIz5guL69Mk1/vs8Hz96N955RLbsg+I=;
 b=kkhdzsb6p6TNaIKSMxRcjcUukI+anTzwmM6Fh2luu2aVBQGcYJVIwxWu4ewHTJJ1Be
 72ESFM6unPjclyqtmTng9yLYYtUQxTrWuMkSwpxGouuwuf9aZLr2hOMaNCfNp5tfTnce
 ZTL2gAMi/Su6hXLlZVTJjY+I8LlNI7hJnIx2m/2CQZPxqHsvzVxEHmbu9suxxI9qPi2A
 Bzu7A6aNZX1FKJLO7TnC7AFm7S4XPOcbaEYL2aSBbeWWcd8sb7WMjHYZembTfOAewvYH
 VXbvf6NPNa1CDPUarMxUYUw3borv16nEY9CzhUK812CgvlAOKyM7EmpGdIJn6lsyW8ND
 pXVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8G2J0t6qMO3i5nZkfudKVNM9Bna1+Zi82upTGDJZy/EEgZot53asL7EudkDH9TgxjOu9aSHYkumpQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQ2tKVW+dKKoiY6tV7bVTjQlM3Q/MpN2nvK0vfKh6H5ZZRxkE2
 UGJDN6Fh+qYU9LAuobmtbYdHejToCSAJ0avTckQ2elVrD4SSiGun1Va97xW7xx26o2WtO3GAkLK
 t+PZMSVvIBI6XjPkg/l1EpxBvEWOA1aI=
X-Gm-Gg: Acq92OHWt3l2ybPI5Jo68WAPh5wG8O8Q2YrULXbx0hrIRwIRvRMNdad80eV4RuqPTR5
 A0iipXPuXQlTReIQcFY6PgX0N79JYQhSMjUJA7iNbhCrUxDaZyvuFTeLwYa7KmUXmdL6FbCeXgY
 Oudphn8d9voSsnZsAqFPUBI1psp8DWwhukpMjsbYc6RQ00tQ/kZuDGJ13Zb9oyos91A+gX0VdoJ
 mEW+hIo4UwVZkIs5MUG5swsNqMuUiKRaSUZCGIXPsIjtjYCHVyR1EhP6znYiRQGp3ImqopLuTih
 nuFbcw1k6U/TGwtvZhwbgzGEFD8BoNIB9TDiT0xOZ/E9NfZgxJ9McfbH4Cc=
X-Received: by 2002:a05:7022:622:b0:137:ec1a:f405 with SMTP id
 a92af1059eb24-1398f56699bmr778964c88.0.1781707194261; Wed, 17 Jun 2026
 07:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260617062415.19898-1-jakob@linke.cx>
In-Reply-To: <20260617062415.19898-1-jakob@linke.cx>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Jun 2026 10:39:42 -0400
X-Gm-Features: AVVi8CeQey_avyCfLu9CoekmKwKkOtyI7rDns3sTfvSTRzhpVqyMectcpzvhhsE
Message-ID: <CADnq5_Mmf50-psbJH5NzPYu_VboOf=MKFK7oCiGo6bKg=p0EpQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/soc24: reset dGPU if suspend got aborted
To: Jakob Linke <jakob@linke.cx>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks!

Alex

On Wed, Jun 17, 2026 at 3:54=E2=80=AFAM Jakob Linke <jakob@linke.cx> wrote:
>
> For SOC24 ASICs (RDNA4 / Navi 4x dGPUs) re-enabling PM features fails if =
an
> S3 suspend got aborted, the same issue already handled for SOC21 and SOC1=
5:
>
>   commit df3c7dc5c58b ("drm/amdgpu: Reset dGPU if suspend got aborted")
>   commit 38e8ca3e4b6d ("amdgpu/soc15: enable asic reset for dGPU in case =
of suspend abort")
>
> The aborted resume fails with:
>
>   amdgpu: SMU: No response msg_reg: 6 resp_reg: 0
>   amdgpu: Failed to enable requested dpm features!
>   amdgpu: resume of IP block <smu> failed -62
>
> Apply the same workaround for soc24: detect the aborted-suspend state at
> resume via the sign-of-life register and reset the device before re-init.
>
> This is a workaround till a proper solution is finalized.
>
> Fixes: 98b912c50e44 ("drm/amdgpu: Add soc24 common ip block (v2)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jakob Linke <jakob@linke.cx>
> ---
> Tested on Navi 44 (RX 9060 XT): recovers the deep->s2idle fallback and pu=
re
> s2idle resumes that otherwise fail with "resume of IP block <smu> failed =
-62".
> It did not recover every case: one resume still failed under sustained ra=
pid
> s2idle cycling, so like the SOC21/SOC15 versions this is a mitigation, no=
t a
> complete fix. Single suspends in normal use recover.
>
>  drivers/gpu/drm/amd/amdgpu/soc24.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amd=
gpu/soc24.c
> index ecb6c3fcfbd1..a970d8a76302 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -521,8 +521,36 @@ static int soc24_common_suspend(struct amdgpu_ip_blo=
ck *ip_block)
>         return soc24_common_hw_fini(ip_block);
>  }
>
> +static bool soc24_need_reset_on_resume(struct amdgpu_device *adev)
> +{
> +       u32 sol_reg1, sol_reg2;
> +
> +       /* Will reset for the following suspend abort cases.
> +        * 1) Only reset dGPU side.
> +        * 2) S3 suspend got aborted and TOS is active.
> +        *    As for dGPU suspend abort cases the SOL value
> +        *    will be kept as zero at this resume point.
> +        */
> +       if (!(adev->flags & AMD_IS_APU) && adev->in_s3) {
> +               sol_reg1 =3D RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_81)=
;
> +               msleep(100);
> +               sol_reg2 =3D RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_81)=
;
> +
> +               return (sol_reg1 !=3D sol_reg2);
> +       }
> +
> +       return false;
> +}
> +
>  static int soc24_common_resume(struct amdgpu_ip_block *ip_block)
>  {
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +
> +       if (soc24_need_reset_on_resume(adev)) {
> +               dev_info(adev->dev, "S3 suspend aborted, resetting...");
> +               soc24_asic_reset(adev);
> +       }
> +
>         return soc24_common_hw_init(ip_block);
>  }
>
> --
> 2.54.0
>

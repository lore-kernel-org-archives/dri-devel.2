Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13784CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 15:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66A910E9BA;
	Wed, 14 Oct 2026 15:17:28 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA7EB10FDF8
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 15:17:22 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-35e8253292cso34282eec.3
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 08:17:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791991042; cv=none;
 d=google.com; s=arc-20260327;
 b=Hb5QAco3ifkLElR/h3EApOZ5UF/zhjaewTFXDxJ7f5wYQcw+kiNu3F95G3CbTmXsQf
 5HMvzaSib/wf5+9Cb6/YCos2beSK9moSQBNrpxnLmJp3WfproryE6yC7kObAL3iWxoCk
 +zRluuRUaTjPyXA7omTv2ZKNzcTHbtmMR6B272e2y6/7wlolnB72Gnw6yO88H2mov+eQ
 JgqzxJyrZdyBojRNIcrTF7jyUFMqGRISXUAxSURdldJhWVT3qBMlTIcYChMXad/S4NgY
 G9lbuM9leoDLle6g0LWEI82vKRz2RTr52lYxtAYROiKZYCbMLMxQrtlh8Q5Aii5IrSHd
 ZxwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MP15FskDIroB85P/ZsRhtMZULyczrJXp5CoRckGiRdk=;
 fh=aP5KtzThIx+ZPbwiqGYJvCEjUiYh+1+flVKqBWlS1os=;
 b=B9+GKCjPeUbzRSnzEI9cYQmHqW8qRd3kggwE7bg079WmFwqxEKUqey8QjXsBSb/UZX
 BxuYc0yo+zSrGHVzLheMcZ3kYRoS8OiumaglKXjJTfjY3wSmYe0Mb69Cc48ZL9WBLvao
 lXBSiACN2XK3GCc+GlEW+Xxd+K81h7LX+JPhg/AMCXEkSWjSgSH2asfBTyeFmiM3hnzQ
 gAsKa4caBlLU5Dd8p2Us8BskTbzMVx63Qlq6+DnVRBX+UrbTXC4uTWCys4JQ9BiJK6qh
 HJvtXZduNF4Kh/tgmEiNgLsNPqXWsoSGpAP4u3LYxmSQht6s5mm0nUXpr+q4cr1Sm1GD
 0fJg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791991042; x=1792595842; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MP15FskDIroB85P/ZsRhtMZULyczrJXp5CoRckGiRdk=;
 b=cuO4KGZF5AvZCBNuvx/zxUamm4LUbuJj3wpzBfQM7xf3X0swkhaCPU5hPEKQwmNGcw
 aJy4hT3ur0xEuaQqy/4vW2RHN6rdbnBMGTUVI8lkcwEJv4SUG40VJUhD8T4zbYJhluV3
 V9nEZumyz0z1g84UB1zffe3jNH+AQpYGTzvRJEhzjaPAqs7enXnHFlYZBw9c76BwZI9j
 3kfLcmAlW5mlbE1kjqCazT4VPUUC1D7NF1TtQH4PIelnz8hP5pfsFHnx7D0l1MyzUWsz
 dmSJyP1tjMPsIpl38JgkB7hB8f+b5ZACMfuvSnVmYd0t50k41LSSKRUCG322OzYrFIsA
 BB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791991042; x=1792595842;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MP15FskDIroB85P/ZsRhtMZULyczrJXp5CoRckGiRdk=;
 b=iyk7X6OHalK6Isq3RXZsq5SPEqcY2y3Ma5737m4TIBnERqcHY9gjlYVR4dImgD4CAH
 y8L3778nKeVD02NAGpGumTtAp5drDtqPfe2HODisDWyMoqZIndyECPttoSV/6kOsj2ZR
 /7OIbqhl9xv/7cPKB02aeQp37rOUYkFF6m51vF4MMVAswl+5Ab62n+XiUutU2ZWXhdVp
 XGDnF9hQwE6mWtMCEIBS8YWMKKvCuvVPf7vV0l+MxE8ujEAhByHLW5j5ytqQBain/LtI
 4xQIq/xG3XsVNKnylJRBGNYwmMapjU+zvzhFwaDXtmeg4JGRW/6V0h1Y1bM9WCkNkMes
 3lFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMt3Ke7oDZX8kVHEIsW6MNV78XFDylGJzEYZaeUJRbc5q9/6GygYadduXsYEvuq1TM5CsaonyiSDg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLkP90+uJ5sg2oqBYbY8XsMQ49oM7SuH87u9sHoTbY1ULCNk+lK
 9j63DgBrTJYfy/KMyFND6PdaWPw6mUHJwFRP9D0TtEN75+fS/JUFuZQIPc7G2CprqpxCUxvyt3f
 3SHGM8mSCsEWiF71Si+pc9zXQ7f6T4nU=
X-Gm-Gg: AYBFou09ETB/Y22/rTh02KnYH2cPgt1RcdG4KQOUVqHTFxkOh8ur7jqQbKrWdGGtgyM
 JtTZX5wFvm+vL8Q+/gnRVyXTmG24habUZyoNQZPVwjf4S8MxMb3tF0IdtRQzQqEI9BrSjwQs7gw
 g6T+oJzqqBYhz8cXj009BLHk9iijWJyV+MHCL0GCoe6W5RkOkG8wHcP2kJhACs16HVrarfAE9qY
 3DsKwhLKTc1Fre94jNNanzjWqGDAsfFPbkjGFo8eAqyyx/IVqNH4mvdBO3b+l51KEBBikFZXQO4
 0xpNkaNe9B2TXnxAzRbZ6IjRm/egnRSiUY8pxlCSeRkjjNAGkDAnnWMtvqOCSDIxTY8CyEzt0Nc
 K/1tGf0n8YdYmh38S8CW2tSO1HkbRyVCxq0qGb2zkRg==
X-Received: by 2002:a05:701b:4515:20b0:144:fd17:3b21 with SMTP id
 a92af1059eb24-16a4e2f6033mr31922651c88.0.1791991041918; Wed, 14 Oct 2026
 08:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20261014073228.2095339-1-thnkslprpt@gmail.com>
In-Reply-To: <20261014073228.2095339-1-thnkslprpt@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Oct 2026 11:17:08 -0400
X-Gm-Features: AclHuK9RTzCxHcsg5D_RZu9qnWTIP8aQ_tciSx9Ychi7L8Go00NiqggSGvOxZjg
Message-ID: <CADnq5_OVC0GgZfiKA1yoW3zJXtTK7Wx+TnPQjQE7xW2FkbMSKg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: propagate errors when forcing SMU11 clock
 levels
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org, 
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

On Wed, Oct 14, 2026 at 8:56=E2=80=AFAM Avi Weiss <thnkslprpt@gmail.com> wr=
ote:
>
> navi10_force_clk_levels() and sienna_cichlid_force_clk_levels()
> return success when a DPM frequency lookup or soft frequency range
> update fails. smu_force_smuclk_levels() then records the requested
> clock mask even though the operation failed.
>
> Return the helper error from both callbacks instead to improve
> observability. No obvious reason to clobber the return values here.
>
> Fixes: db439ca21b81f ("drm/amd/powerplay: add function force_clk_levels f=
or navi10")
> Fixes: b455159c05313 ("drm/amdgpu/powerplay: add initial swSMU support fo=
r sienna_cichlid (v2)")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 6 +++---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index f8ca5eb9adc6..2d05088619f6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -1439,15 +1439,15 @@ static int navi10_force_clk_levels(struct smu_con=
text *smu,
>
>                 ret =3D smu_v11_0_get_dpm_freq_by_index(smu, clk_type, so=
ft_min_level, &min_freq);
>                 if (ret)
> -                       return 0;
> +                       return ret;
>
>                 ret =3D smu_v11_0_get_dpm_freq_by_index(smu, clk_type, so=
ft_max_level, &max_freq);
>                 if (ret)
> -                       return 0;
> +                       return ret;
>
>                 ret =3D smu_v11_0_set_soft_freq_limited_range(smu, clk_ty=
pe, min_freq, max_freq, false);
>                 if (ret)
> -                       return 0;
> +                       return ret;
>                 break;
>         case SMU_DCEFCLK:
>                 dev_info(smu->adev->dev, "Setting DCEFCLK min/max dpm lev=
el is not supported!\n");
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index b42897e7c066..4ef3863fae1a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -1460,7 +1460,7 @@ static int sienna_cichlid_force_clk_levels(struct s=
mu_context *smu,
>         }
>
>  forec_level_out:
> -       return 0;
> +       return ret;
>  }
>
>  static int sienna_cichlid_populate_umd_state_clk(struct smu_context *smu=
)
>
> base-commit: 4056b3c9d3c92ea45955641dbafeb9b960e146ef
> --
> 2.43.0
>

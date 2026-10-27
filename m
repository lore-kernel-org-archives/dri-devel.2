Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B53606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 18:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hTSoZx0g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E94410E476;
	Tue, 27 Oct 2026 18:27:16 +0000 (UTC)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com
 [209.85.217.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96B2810F56B
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 18:27:10 +0000 (UTC)
Received: by mail-vs1-f49.google.com with SMTP id
 ada2fe7eead31-7cc18f754f1so9877137.2
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:27:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793125629; cv=none;
 d=google.com; s=arc-20260327;
 b=WWeV2DswN4yVD3kF/0qr0bPKHc4gKucyjyL7biCs6rcjZ0H/yGy+gNYV7EDlNy2FdE
 f28lXHd0EtSYm8OkRKrGrfdjKCh9XyvjSPJGob686+f6NkBPi/9w+Vqm1E98SPryrbVF
 rqvw2k3/5L6OQP/7xL4eu67pOSTwDm3l2fSepzCVIAMeTWx1QFj0VG+5q6t/pv/w5czt
 9cFn5NzNHBnawnx5TQFVmOSg+nkKSvJdaRbkfAzuhNX6chSSH0/EIN/wqKpEr0QTvujH
 GtBIVDKpKmiviHQ61aFozbmyF7qxL4gZMxtrd7wMwHu4OHdaHqXNXeNDJ+CAYfHQwJbN
 chag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Vw76Aew22t/uqoyjfMPtUUfN6vLBI7u4FwkWnSbrmwo=;
 fh=90y6KM2KQ296CJEGxgb0WL2JLcg9VNR7tjHciLyh2RI=;
 b=hu8zJ2SWEC8VNbH3GZ383EGuDr6SZHTR3R7/F1nrESoKkgKruN4JboEZzDG0gWg3Gh
 hsiernDBO6B9rFJcFnF3aKXlBmOfnJnYvu8HRpwg8BlW1KjQU8k259gwrQq2YGZiDyJe
 qiv96l/B1o2yLmIvIfyaYF1lp2CIdx448907TVtCBzY/Dt7OksE0tRW8qVCrJwY/d2FC
 vv2x4f1d5C8387PacYEL4zj2MCjfN5ds7VoFH9TRt3PnSMxUWE946MbvsEKSuhRun+q3
 d9olVOYHNN/4+C3/iMNdHm6FXXUquCxrCMFTd9vbyDWgo7ArQ90+1bh5ZLS+DQtgU1TI
 fP8w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793125629; x=1793730429; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vw76Aew22t/uqoyjfMPtUUfN6vLBI7u4FwkWnSbrmwo=;
 b=hTSoZx0g5EsYJMw9efBzwbgP6Z6j6fad+zKdnUfm0V9Z6xEBCsFQTLFBmLpbEbYu6Q
 wAsQSw2RnbTRLS6mZ1jo3gJfwaaqwoBfGrviA6EGwJHCItWrB0U2LF2GrMvPd1B4EWpB
 QRYTABi/OROxfR9h9tmReK4mWWTSpUhwLYc4TJrEzn9u9OvkMZm2FSc5Q3Qkc3em5Evo
 pTgD25FHyo8jAs3PGEVYoCgOenLamtGxatbByexpb3DGVcaVt2VP6lD2MEpf3Yj6gsKK
 B4nYD2kFFxDxfcTuyTUNH0f+fX4qzRJMNuPV4edHJSBfIdH4vsUxJ/EVlbLkBHuH3yVN
 9FBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793125629; x=1793730429;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vw76Aew22t/uqoyjfMPtUUfN6vLBI7u4FwkWnSbrmwo=;
 b=DZFqV4m5XYvemk34wV9WTbejaD+9Fd7CCiaI9LRUsGLGr76koSwHY41AC+AwpsmnR4
 QljPdL2woZCbsASmnyn1SS1lJcoQCLpn4BbE3LspaTRvo2rUyJGD4Wb+5sDY8tGGUX/x
 X2gKAT2L4rmuQFFAeeFUKLZ89R5Bv0pjXmOBtHPQauosHgLO04YT/GZWxKqyVzylEwER
 PDAIsPJk+EzM27EzbbEk2yrfB8BXfJZrSqIvs+IcT+tnRi6xWmOAtaztlTzBl08I8Lln
 JRrN7HNk7mxavNyvBvQNUUehiVZquIlM0A/XIFzbnqmrUuAqZrpQgTwnj68QceWrAtxF
 rYvw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2APg5VpAeM+vNW/9VdubVhfJRDW6httIMvTMTZc7gnqYhtwj8V74EO68KYosz0zgRGlHi9SdPPrw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKh1ITQ/IYHXT9hICzh6shwOlKdsDzec0Rd/ESroCW1SRUzWsOo
 OBnbm6tsjr0UbTuNZPy8oQofKAZYV2v2YoGru28zxaCBeIPrBcOSMPxw5lXl+bFdS1kPcbIaytC
 9DZXJuy7as423cTxM+pB8L8KICzm1+sQ=
X-Gm-Gg: AYBFou1iTZFiHEHWg6SeuIw2YoFHtXAYywnwsO+GU6HjQApXTLEonNkPLgiezitZrRa
 RtImCgTcEl1RAs14v3v+Xz9Gh7yloWsqySOmUxDol2WjnRKddxh5HHJpkLHIvuMRHBeL5xSbR7/
 xjVcgFUzejCQbqkHsRd/c9xlzYEc2neVkXWHdG83Djswdp1rW2Xi2/plXeoRW46DvOhUvuixw6y
 zLPqbtDM0JSqc2YSO/Jj7zS/Cy7K9E7BG/SgqFEAn56B6hMHjQ/7phhOG23iE92ryxbHmvuSaaB
 KON8JEyBEZkAQhEcgvejnRzXxJyGqZ8go8Y1sOhOYkh6y/nl7JaMHaYUendQVnwFvl/JWUSmPdD
 QfVefbnu6itNzGW3WlLdgUmOltROM5TUb4U+2ptP9qoEgYacIJmuyy+NaEm0Vt+ymAiDYRS9x03
 EoCByVlQP/GIYCvCoksWiO9bw=
X-Received: by 2002:a67:f28e:0:b0:7c8:3b8c:82ae with SMTP id
 ada2fe7eead31-7d03a4e9c8emr64081137.2.1793125629415; Tue, 27 Oct 2026
 11:27:09 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <3ff4ef96-9c59-4e8d-a0da-92a1ac6f5ba1@gmail.com>
In-Reply-To: <3ff4ef96-9c59-4e8d-a0da-92a1ac6f5ba1@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Oct 2026 14:26:56 -0400
X-Gm-Features: AclHuK_aiFzsLGIkoZq8NQtZC7JMp_ex6BpnMJZTO84Fyg8IpU6xOsXcoFUrrY4
Message-ID: <CADnq5_Nn7+baU=Rdaa8QzOCo64H=ch9HeDaEwtmbQwW0kP00nQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/display: report synced Apple 5K tiles to
 PowerPlay for MCLK switch
To: Richard Lane <richardlanedev@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
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

On Tue, Oct 27, 2026 at 5:41=E2=80=AFAM Richard Lane <richardlanedev@gmail.=
com> wrote:
>
> When driving both 2560x2880 tiles of an Apple 5K iMac panel, Display
> Core's program_timing_sync() already aligns both CRTCs in hardware
> during dc_commit_streams() because the two streams share identical
> timings.
>
> However, on DCE < 12 (iMac15,1 through Polaris-based iMac19,1), Display
> Core leaves pp_display_cfg.all_displays_in_sync unset. Because PowerPlay
> is not informed that the two streams have synchronized vertical blanking
> intervals, SMU7 prevents MCLK switching at idle or causes modeset
> underflows.
>
> Report all_displays_in_sync =3D true to PowerPlay after committing both
> tiled streams so SMU7 knows the tiles blank simultaneously and can
> safely downclock MCLK at idle.
>
> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 548f975c7324..384a81371f80 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4788,6 +4788,19 @@ static void amdgpu_dm_commit_streams(struct drm_at=
omic_commit *state,
>         mutex_lock(&dm->dc_lock);
>         dc_exit_ips_for_hw_access(dm->dc);
>         WARN_ON(!dc_commit_streams(dm->dc, &params));
> +       /*
> +        * DCE < 12 leaves all_displays_in_sync unset; report synchronize=
d
> +        * Apple 5K tiles to PowerPlay after commit so SMU7 can downclock=
 MCLK
> +        * at idle without modeset underflows.
> +        */
> +       if (params.stream_count =3D=3D 2 &&
> +           params.streams[0]->link->tiled_peer =3D=3D params.streams[1]-=
>link) {

This should be made generic for any combination of displays with
identical timings.

Alex

> +               struct dm_pp_display_configuration *pp_cfg =3D
> +                       &dm->dc->current_state->pp_display_cfg;
> +
> +               pp_cfg->all_displays_in_sync =3D true;
> +               dm_pp_apply_display_requirements(dm->dc->ctx, pp_cfg);
> +       }
>
>         bool frl_stream_found =3D false;
>
> --
> 2.55.0

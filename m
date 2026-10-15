Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198DCCC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F37810EBD0;
	Thu, 15 Oct 2026 13:31:43 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 113B510EBD0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:31:37 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-355724d032fso598775eec.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 06:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792071096; cv=none;
 d=google.com; s=arc-20260327;
 b=Xhv2XE2WmssFetMzyzpAnCKyofMOkNCpRAy7qqrnFy2EOQ6qloR4Role+yr9R47cTE
 9PPRK393Ja2uPuHOjCfn2ERFQy3Ow52Qs/SenKEMdNsuyuDGBi/6pH8ShZ9VsmhbRTnZ
 G/OQk+twMPqEecmuDU+/x3HNqTZlu9JbDrUWb6lMnEIvfmPH/pQ/Xx+r3oRmbTdGbWrt
 D5lR2FRg3Ic/Q1HLPEuBJhV6CcM7J+gXog3ORzZEW7qsLGnKxKSQB75TSVH38Z8MPik7
 7j4ueFRfPwQyY6Y1CXpb/UqUaJ7kY/7qUjtIZIue4KbdPQWTi14Jj5qBV+/ZIWF0jOmV
 M/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QApmXxg7MwJF7cN9FykhLPyexb+qvhQ5FPRBd4FC7OA=;
 fh=0wQlltz8Xd4aIpIGrKK+M6wRXQMoSsbHLSO5P935OM8=;
 b=m+MnSGy2/dQFuFAMuPTATlVlGTNUGcVOgqW82Y1zo1fGFAqDPa20pKL/6y574cum8N
 y5OmnAPaBwTV8VqXRD0LVawyIo8Gdguwt0Y29PMrTq71PxnDeiWucH+ycQLWoIRqQxT7
 8zcvBJE/bYL7Wj7tfaK240zToCR4xsSMzvpouHvMYezN1/wwGKyPAK25hyV88b+S5Pql
 NVV5dsLJhGbRAGt/H2ffd7mSekQ7q6bFDy9+/MaAaO+IJkRYyMkw4rManPvIRUux0Dlg
 TaCEraViAopQ5+2sBuiaE7cCxQkl/kqOVKVoLbyMru6gO6YsxHMeSuhJUShfe5X3zx7f
 4IXQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792071096; x=1792675896; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QApmXxg7MwJF7cN9FykhLPyexb+qvhQ5FPRBd4FC7OA=;
 b=auOYTnASjZK9qQb3xPCc5bpoc9IbvdmIrDFIv0IpAJNm41XkFQDz2oNMryt+8iFRul
 XidkWilgtrg3SsowNQES/7M0PONPoMX5cFjpluZ1EGBeGe6mNNhPh+YhDNWBmGKxi7Fu
 6tDbjQOF8fwyV0OTuFnDs4KA2shBFaPJaponDTlTu8APzH7cQljqSIvD3hkqdcXvwvsE
 2q3HM2diusMyyOyYCPnZPJXQcVNMSW369wNcS6Y78MVYdLNEme8U2f9TDEkHWNPcSI2j
 uP+mDwohZro9aV18j1Pmbx3ini3IiKILOaGCbYRy8oJjEUMgxBqYYvv1kO9If0mBSMwx
 yUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792071096; x=1792675896;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QApmXxg7MwJF7cN9FykhLPyexb+qvhQ5FPRBd4FC7OA=;
 b=X0VbWNk3v/DDKjuqF/ymlQwAEp6OLgPS/D1FvxnDmyYV7TdZxUJgLWl4gSrfQ0wAGk
 e8gdlJ5Q7O9mtKmoVLZVHWoBJZxG7mCVfoSh/SvzWjctRnsj8UpJHdoBfuiqqfpDdGAI
 0iXpdbRH7/cyPuGqF7HSs3GbM+Tv9hfvuXbJgaqm019zeAhQLNBf556uMg1kUH8qlsWb
 NB+/9pD2+S5Ejb99wVNkUdKsJHtDZg2v1Q5GnV3jkM3u67zG1NLB7kqzz8pVeAuYiZ4e
 yb5tTyFgwFCgM+ulDoXGIyfsh7s1HsY4gkbfdBmny/Mll1jlTGLg81dSQVwlVJeWCUju
 2prg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcTZ7qEer3wOaSnhYfMmXUOgynePZ0mNaQaq7JOnyPCqPzNg3Gd8wQHC/bp3qAJnDRrsxVpcqVgtM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKY0X1nWDzbeaO65NeV8To6JFpEQ3VEWHrcNLNEt62MfEvtVpbA
 9c5jCzRB4sE/Wn5qID/3CgNZZZmnh41Ihi1Pl77MmR2q3bvycNUfM+9MpDEalqOkcWVf6b2Ugd5
 C6aWgzzM2j9nvfGioUhC3sC49ShTJgSE=
X-Gm-Gg: AYBFou3xRGWBNLSM1nxxfo/jGg4hLaCf/p+ewbdoO/7D3ngDp9Z6NkOBkO8xrCF4oYw
 V6oBy5DnlpwgWHC7pRr8Z6HbbNvvQ8mjmR3Mb0aWQ+jVbOs97biUDchwJz5BCdAZkbl07OkFSx0
 uyVzwOaKdNWUXJVJXdPQzEDvKkI9sREXsdfdDEACr2R9KkqPOOoGtHdxI8gwsTmjwTQLK+sYbun
 /g8ZY0+Mvkx/uG3mABGliiAO8lyRWKSKz+O308JI3A+Lpd6IsbzLf0r22NLvfv8mJJ/7l+YbEnK
 2saauJsn923rPGY3q+Ffy0TBHNo9lGlkkJzeA5v2Q97QuR4bYALxZb5B92XKeSWfx9F/Uoot17R
 fkn5fphvxyk8CX901a5Chl6BLztNb6DQIahk1em6bww==
X-Received: by 2002:a05:7023:a5b:10b0:147:d430:7322 with SMTP id
 a92af1059eb24-16a5bc5bd84mr37714816c88.1.1792071096077; Thu, 15 Oct 2026
 06:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_O=kVgSZoqe_ZVQDmVTWNb+OZ2XhmVx=0CPQQfCaf2idg@mail.gmail.com>
 <20261015002344.98683-1-williandossantosdeoliveira287@gmail.com>
In-Reply-To: <20261015002344.98683-1-williandossantosdeoliveira287@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Oct 2026 09:31:23 -0400
X-Gm-Features: AclHuK9ZmUn4FKK7SEAciymXYIUH4N4bcGFcrSo8pT-xgjBou-x7Yj183erpf3s
Message-ID: <CADnq5_PnCPpWsDDWBD4RicjxHQKTV+_MALbpzx28BoVej4qiyQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/gfx7,8: remove redundant RLC cleanup
To: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
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

On Wed, Oct 14, 2026 at 8:41=E2=80=AFPM Willian Oliveira
<williandossantosdeoliveira287@gmail.com> wrote:
>
> gfx_v7_0_sw_fini() and gfx_v8_0_sw_fini() already call
> amdgpu_gfx_rlc_fini(), which releases the RLC objects used by these
> IP blocks.
>
> Remove the duplicated explicit frees of clear_state_obj and
> cp_table_obj.
>
> Signed-off-by: Willian Oliveira <williandossantosdeoliveira287@gmail.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
and applied.

> ---
> v2:
> - Keep amdgpu_gfx_rlc_fini() and remove the explicit RLC object frees
>   as suggested by Alex Deucher.
> - Apply the same cleanup to gfx7.
>
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 8 --------
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 9 ---------
>  2 files changed, 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v7_0.c
> index 5fc19fefca81..7c56e36665c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -4454,14 +4454,6 @@ static int gfx_v7_0_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>         amdgpu_gfx_mqd_sw_fini(adev, 0);
>         amdgpu_gfx_rlc_fini(adev);
>         gfx_v7_0_mec_fini(adev);
> -       amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
> -                               &adev->gfx.rlc.clear_state_gpu_addr,
> -                               (void **)&adev->gfx.rlc.cs_ptr);
> -       if (adev->gfx.rlc.cp_table_size) {
> -               amdgpu_bo_free_kernel(&adev->gfx.rlc.cp_table_obj,
> -                               &adev->gfx.rlc.cp_table_gpu_addr,
> -                               (void **)&adev->gfx.rlc.cp_table_ptr);
> -       }
>         gfx_v7_0_free_microcode(adev);
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index 7f91186ef1d1..27fbb5b59645 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -2060,15 +2060,6 @@ static int gfx_v8_0_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>
>         gfx_v8_0_mec_fini(adev);
>         amdgpu_gfx_rlc_fini(adev);
> -       amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
> -                               &adev->gfx.rlc.clear_state_gpu_addr,
> -                               (void **)&adev->gfx.rlc.cs_ptr);
> -       if ((adev->asic_type =3D=3D CHIP_CARRIZO) ||
> -           (adev->asic_type =3D=3D CHIP_STONEY)) {
> -               amdgpu_bo_free_kernel(&adev->gfx.rlc.cp_table_obj,
> -                               &adev->gfx.rlc.cp_table_gpu_addr,
> -                               (void **)&adev->gfx.rlc.cp_table_ptr);
> -       }
>         gfx_v8_0_free_microcode(adev);
>
>         return 0;
> --
> 2.47.3
>

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A57CD6E7B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 20:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D74EA11AB01;
	Fri,  5 Jun 2026 20:22:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZkfcnjXW";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66E0211AB00
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 20:22:22 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-13644e164cbso39643c88.2
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 13:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780690942; cv=none;
 d=google.com; s=arc-20240605;
 b=gWgWAnu5oFtzyOVyhNEjUebkvh41kasTOjdPCdPpJ9c0v0ylzxkUL1v51JCcGZGJOG
 f1fiMgnSId6WRD0WYOnihjYAUOwdoqE5KsiPaJTJkdTGSHt6NC/sfRf4rnnnbASZCjW1
 EHJmXx/YSUTd0zDZUmz26D7j1kN6moOkXHkizUHughHxvdD6zOgFo4jb3c4rN3fX1C6G
 U/f/ZGdecHfW8OvY2Mc1zTRDeOMkzTnRn0yAcTPdgUKLWQwGLWgQesJwzXPrImV8QB+i
 NYRJwBlE6R5SrnAj4aG9QhMzNUKCLXRXWO3+9DNel2yXFY79wUHV5RmurF2BZPKc60J4
 Dg+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Jd8zZoj15MB4D27exy0vziD0YMpZOpqLLJrmgLP/VUs=;
 fh=6KSszc6JGsOHQzJJkKyM2IOWPHxvT8QyPuhnePyQoPY=;
 b=TU3KzqSJQp2/IO8FK/7gizRkVvrIHsh93r9f1KkQd86oX+Je5X/ZDkgwitvOqOGlN8
 ZdFhFLy6mT49aScTj9Fptp7gwpnCZcfgq/cQ0bL0qRN5ZP1I1NnFQucc0SlYebY+3TgX
 GVjylunTMcoMFGWGPMtMMRh2CWI17ebsP92CDirCF27xKZ7Gl6LC5WHUqkgztHB/liLp
 htSBkp8Xcd92knywXYoytJm9i+6flQQuk/spP3Z4XOMTs7TEEEsN5gt7p6+oMy2jJiBR
 ESLxvzs5odw0ANETOtp0X5tdmxcyjkMyBKnzEJFkEayxid9zw+rMj6BbDKZaaDjGZ+rv
 ENDw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780690942; x=1781295742; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jd8zZoj15MB4D27exy0vziD0YMpZOpqLLJrmgLP/VUs=;
 b=ZkfcnjXWhq1W+43qmhldaecpiPuFfargFUkDBYuk248BoBl9dHq+UNSfObS/i5Pb9J
 +oUf5X9g8waZ8OWePnrLfB37gg7yx0eH9Khyb2uQqjz4TRphzXWn+UZqjYL5KfNirU6d
 Ye+Yk2e8QjDrQXkAjc1xqIR3sw484wIX+Z6NbJ9UdJTn5lnWiD3oTwF14jVy01HVMqDh
 dRkatdwic6VaQhx96q43mrSCGMGy9A7IxpLO3hH8d8lBXfjm+QCt+MXMAuNK2rZhZ5Eg
 /SGDTdsycszhHEWe3auTLEt3wXNjKsSlecIxCCl1pqbwhmVCtQnWPYGl9wuShkmaRVW0
 DQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780690942; x=1781295742;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jd8zZoj15MB4D27exy0vziD0YMpZOpqLLJrmgLP/VUs=;
 b=HQFQuIIbA17Np4NTXLfXVgB4X1jsRdUGClzlpAandVIGEFXVAymgHMC9qCpCmXMRqp
 6wRpwyRYxM1LP2dJf2rdYbNb0L6UTd0kAnMv17Yi9G1MHnNPisSlwXDfauj4R7qQ4GJG
 defCXEuuKuuGjES/61lqf/vgZB9A8liWu+eRyR0TgCYvLt6QCxDt0yFYIRPL/ZIGDDNH
 jPp0SPA7vfNIcPbHta8UCHZ68aMNnDcr3FJrmJHZ0krIgS7Mrxw1m6nVq8Oz3jjJwNII
 +5hrlwRBMxDyN7Xbw7P9q7OUv0pvtomn9jcTbMe2zGe1RtD4EJvPXs2KjpPuKaLr6xfc
 FbKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8IEeRYs39MqwpFIzCgZItHNtabZ+jIWvYOTaS3Lm0QkHXbbmkLV3UpzkrS2vM/l8w3LkjhxGbnoNc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJm9DSOy4lJXd1I8KiNQveex1WNVZQ8azJ7TiVulfPqN9i8FND
 SXX2cHjQoDWMcOQXbcOmpURL8F4Cgkhp5SxnbzYt/eecifnDmIBxC40D+THhxTUNP5QZ4mcK98E
 D5MqALd33T8y0BmnUiJeRhdTdMEBlmJo=
X-Gm-Gg: Acq92OHh1TCO0PML141FkKP9gVsHuoYRO/PrLsM5aV1QD2D3mbp9Y62VZOKYYiYNfcK
 riiPd54hqkyy8hGrZsRRLNRMrAEqBQJB19f1qSjNZOkvX2zYVj/Ig/PdWdd5CoYOVtavyfS8Wq6
 l919PlHhlMFcFphmb2/JYUmtvwmXWQIg2hUmKXcx8+pzTYr9lkIKJVp7oThebWV2vQoJCt2eH/c
 Gq7UFpArocqRbQyRm8kuPztRe4Viu2IunkHVd7M8sG5+g7RY5xoG7jGrYpBYO3Q3WT3P66WIYBw
 HpGImxuO5sp92PMBJa7PLVpE83Bt4XHSRzpqgqJ0+OjBeh82unC63TubyBqrWY2L7TLavmWQMyW
 Yy9br
X-Received: by 2002:a05:7022:423:b0:137:fdce:fec2 with SMTP id
 a92af1059eb24-138067f0b96mr1031445c88.4.1780690941599; Fri, 05 Jun 2026
 13:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260605091803.6018-1-vulab@iscas.ac.cn>
In-Reply-To: <20260605091803.6018-1-vulab@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Jun 2026 16:22:09 -0400
X-Gm-Features: AVHnY4Itf_LGBLOFfworAGpTyhoHXZvSw8OTwPFhRJI4fD0sd3Y6MHVuNEzj0Ic
Message-ID: <CADnq5_PejRC_QGGYvph_0jAyGWX475LvxTVHZVo3qvH7ZVgv+A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix fence reference leak in
 amdgpu_gfx_run_cleaner_shader_job
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, lijo.lazar@amd.com, aurabindo.pillai@amd.com, 
 superm1@kernel.org, Hawking.Zhang@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
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

On Fri, Jun 5, 2026 at 5:24=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wro=
te:
>
> In amdgpu_gfx_run_cleaner_shader_job(), amdgpu_job_submit() returns a
> dma_fence with an elevated reference count. The function correctly
> releases this reference on the success path after dma_fence_wait().
> However, if dma_fence_wait() fails (e.g., due to a signal interruption),
> the code jumps to the error label without calling dma_fence_put(),
> resulting in a reference leak.
>
> Fix the leak by adding dma_fence_put(f) before the goto err when
> dma_fence_wait() returns an error.
>
> Fixes: 559a285816af ("drm/amdgpu: Replace 'amdgpu_job_submit_direct' with=
 'drm_sched_entity' in cleaner shader")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index b8ca876694ff..88bec4e93712 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1686,8 +1686,10 @@ static int amdgpu_gfx_run_cleaner_shader_job(struc=
t amdgpu_ring *ring)
>         f =3D amdgpu_job_submit(job);
>
>         r =3D dma_fence_wait(f, false);
> -       if (r)
> +       if (r) {
> +               dma_fence_put(f);
>                 goto err;
> +       }

I think all of the clean up paths have issues.  How about something like th=
is:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 321d7aa52f042..848846ac9391e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1701,7 +1701,7 @@ static int
amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
                                  &sched, 1, NULL);
        if (r) {
                dev_err(adev->dev, "Failed setting up GFX kernel entity.\n"=
);
-               goto err;
+               return r;
        }

        /*
@@ -1729,16 +1729,12 @@ static int
amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
        f =3D amdgpu_job_submit(job);

        r =3D dma_fence_wait(f, false);
-       if (r)
-               goto err;

        dma_fence_put(f);

+err:
        /* Clean up the scheduler entity */
        drm_sched_entity_destroy(&entity);
-       return 0;
-
-err:
        return r;
 }



>
>         dma_fence_put(f);
>
> --
> 2.34.1
>

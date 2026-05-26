Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370FECD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 21:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 702F310E560;
	Tue, 26 May 2026 21:02:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AovNHjcg";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3573910E556
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 21:02:29 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-12db2e9b5a7so328523c88.3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:02:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779829348; cv=none;
 d=google.com; s=arc-20240605;
 b=coziWAXuSEuellm0+04L5BfDAuc+Aa+sUnGOxjaP6/pZMAeMH6cWdWmoL8arKIDY+T
 /czzhITjGydXozu9RkdvBHiFyYiVcLKSnk/GpzezHyeITtmKsx+aBK7BYckoX3U5CDt8
 mvLRxFVTzQ5Mdw+VCQT3t5w+3m8MmQlqAk0AK3vff+iTGrlVQSHKTMXFuGDqoE6ymj8D
 Z+3g8ckSPyfmg9dt7eX/88I/yIAEd4OWSf6v7iFVtaTkYAWg7TDqHVxi9vMHeQyvo8jH
 dcaznNSVZZAxxI0O3zWNrd6EjhVdUVG533COqdT/uLhrM4y0AWFiMi0CB4yl2naHBW/E
 ueeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xDSN+zAFo3SDyZ1j/OWiBK2mX5qoAAjzuXlq2kenLkU=;
 fh=tqtyrbssjYZW4MHxsPHfLfXVdLraX5Ku5t/koLYC9Ng=;
 b=fAxr09TDNJcj+ovOF4W8yVJWyFhgNTDMe4a1S6Gor+nCa66dAbzZ5JKTKGKzAJ1mwd
 s6qCT4qvWbpDtPqySMcbq61R4ZEoHMLHiyZFJq3SV64EVTB3hKitYPVRLqQSxlaK37kp
 A9t1o3ZhqRE+/2EwtpP0b5ycSxACkmUSN7CuYfCrDCfpiH8DYktEAHaRxvcQNAUsLfc2
 tbd5BCwX3w851JKwMb+9C4J8APrsnpOPRx8wlJqEtLLlol1Fxq7LRZYCiA1qlDgdV8Aw
 j94YPyfM/j4XUN6wyMxs/ybb7zIccYQfTEa+NW2/SmRix233p5wOdeaBDoLhS7W2IP/s
 TBkQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779829348; x=1780434148; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xDSN+zAFo3SDyZ1j/OWiBK2mX5qoAAjzuXlq2kenLkU=;
 b=AovNHjcgghit7G3i6d4TqJ/SmLbGvQtV4oFZUmKIN299Wghgrdnx1kwvDVCUowej8H
 r69nLcVdyixEmhaJSVXa+X+JlnJGb/oTV7d5iJZiI/sI0Q38T1yHZONw+j2IhygCT+Ug
 2mnbkrZOeIqRRenb7Y42RwMO26TAoFfgQ4Cx4WWljKBta6VPUshzz8hXzf705H7S1qK2
 2cmyhcgOJB02BOm07tX120P2oXVpNYyW/xUlom4f1xooMF8EWREJv7wht6HeY/mbMTtG
 4ZecZjkx12M4O1EunXdD6pLKKlsNbFIuosNykKxuXe1j3t7UCE/ckNVQ0ryFtuMB1o+e
 fFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779829348; x=1780434148;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xDSN+zAFo3SDyZ1j/OWiBK2mX5qoAAjzuXlq2kenLkU=;
 b=XR1j+A1zLVd3oAWOlX/YODO9Sdgv+eY/Ioy2O/3WWNCPv+HUAKy/eOEdvl6eyDRApp
 hPWU14dVi2bQnSZ/9D7lgSzvLqSWPqD/gYnsB2DQFNVem4vk+C0Dw4kgFHcPPIqLS7Sz
 myvpZdtMad1HEgNrkJEJP9M0aXOnFO0JBg78HJcw7mVHmJHePribjnUJYXyQAv8m4yro
 i8lMLFQqKs8rkD0tu8xy4Cg+GQotpqZzpbCDQkT5BQtJw7HjRdDgma/MaCDgLASqSji8
 RQXFb269quloqSgEWOO2+/Vf73MtOhmhzGEWZzIiD5stFsZjIuYG87kenLBo50Ie//Yz
 tRtA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vtzp2qkKn0AvwrqIXUx/T8fbzqD3jNfSjRIEa4BXTarD+6QY5Q/jDbm2lZ2kyug7QL9MAb0+GtJ0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNDcCzD4dwhfz0rvlIDvSnyOirMKBTMX0sYl8OQxCUxQLMPpSc
 DJuChMwUDbXV2h0KkNQk1dnpZs2vE2422DfGBJo/mkLd5Gy83DeolikTINCIMEwRd6jsAgVcfAw
 0zIaRvetgj3ohDzb06dGTVTXX1+E8H7uiYg==
X-Gm-Gg: Acq92OGc9BMBOOQyx+9rhwjRj58pcvbGmnC4/bZ22TUfIsg6McuOWxTcTrbt6ikt/jV
 n+Y4NwUSADHakVBOm2TWcmUBk9KxAA9syrwF/4BJHx9czG+TBfW5dCZ2AZfPNAW3BYa493Xe0cY
 ssF1cVLYd31/dJEocK4wfjepsGvURC8Ll7/3J5/fMhNHTPwZrHU2unmpLhTINgamZGwHDB9H6f/
 tZfvdoDmgDPFmKTjj51Fhlr09azYgZHcd391/7UAlKKzfCgUxctDZL2KXeDDVN5lB+K0pIfNXkL
 PSP6GU4/KAxeDM75hT1viUU6AjFWVRvhOs+qbX69PM8PnQ3EI3L7fTSRCACNYdGkBtAR+oLvTCb
 QO/3l
X-Received: by 2002:a05:701b:4285:10b0:12c:897a:5219 with SMTP id
 a92af1059eb24-1365fd80cd6mr2508477c88.5.1779829348250; Tue, 26 May 2026
 14:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260523142645.39102-1-meatuni001@gmail.com>
 <20260523165646.25645-1-meatuni001@gmail.com>
In-Reply-To: <20260523165646.25645-1-meatuni001@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 May 2026 17:02:15 -0400
X-Gm-Features: AVHnY4JqZMeWeY53IE6NJ-7vofcMYfgVFqoUhkfR5wacLpNgAvtsXhnZNwnkDGY
Message-ID: <CADnq5_MH_eLM1qeQB4t_uR=T66TuSHCAs5O47Li9_KtatkmgqA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix NULL dereference in get_queue_ids()
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: Felix.Kuehling@amd.com, alexander.deucher@amd.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

On Mon, May 25, 2026 at 5:59=E2=80=AFAM Muhammad Bilal <meatuni001@gmail.co=
m> wrote:
>
> When usr_queue_id_array is NULL and num_queues is non-zero,
> get_queue_ids() returns NULL. The callers check only IS_ERR() on the
> return value; since IS_ERR(NULL) =3D=3D false the check passes, and
> suspend_queues() calls q_array_invalidate() which immediately
> dereferences NULL while iterating num_queues times.
>
> Userspace can trigger this via kfd_ioctl_set_debug_trap() by supplying
> num_queues > 0 with a zero queue_array_ptr, causing a kernel panic.
>
> A NULL usr_queue_id_array with num_queues =3D=3D 0 is a legitimate no-op
> (q_array_invalidate never executes, and resume_queues already guards
> all queue_ids dereferences behind a NULL check). Return ERR_PTR(-EINVAL)
> only when num_queues is non-zero and the pointer is absent; both callers
> already propagate IS_ERR() returns correctly to userspace.
>
> Fixes: a70a93fa568b ("drm/amdkfd: add debug suspend and resume process qu=
eues operation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index c08ad718dbd7..8488b3a6c2ba 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -3312,7 +3312,7 @@ static uint32_t *get_queue_ids(uint32_t num_queues,=
 uint32_t *usr_queue_id_array
>         size_t array_size;
>
>         if (!usr_queue_id_array)
> -               return NULL;
> +               return num_queues ? ERR_PTR(-EINVAL) : NULL;
>
>         if (check_mul_overflow((size_t)num_queues, sizeof(uint32_t), &arr=
ay_size))
>                 return ERR_PTR(-EINVAL);
> --
> 2.53.0
>

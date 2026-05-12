Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BAACD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 19:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE1FD10E2B7;
	Tue, 12 May 2026 19:11:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dVMnnOiE";
	dkim-atps=neutral
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D6D10E2B7
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:11:20 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-7bd87e5d8ffso74726827b3.1
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 12:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778613079; cv=none;
 d=google.com; s=arc-20240605;
 b=c/jqbA9is9mSGrNhNLWMTeXn/2K27zRSQ31f2NTDU8RVxuOEZNRfx805IAcvNGzXAe
 T5uVGnZV7v3q2J0xki0NovOcVIj4BEw7/GeHxGtglCYqigKefoMPBIg4TwP0bKf6HdbG
 XjY1TKpaB2AepVytsEonKUqU2sqEuwgx6vWpFEq6fPpjsQew9DnydhiElgd6wotUhFnr
 O5w+eYpZ8QwZ2DOZ6GX4rESWDt2lmADre4sUKs6qJQNwxCQKTZTi6JZh0XIhm3fCo3Pb
 +aZVh4BicbWziHjz/3GVYFkhf2XFeP2EtUJB0Nv1J1V7FRCmTvtFwt2BAZDGXpp3+K5q
 /jxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=abwtRXcEr7HRCHBy7n+6bVsELPOWqP6mab57xjFXvhM=;
 fh=kGohjB5GBPT1ONwlwMvwvekcH6KcIbuQ9d3mBn/E2i8=;
 b=dugdlcEdVd2UqcPFs6029vETVL/dOAIdOXJAYsk6Ofj/lwCP+bW3L3e/Fja8ieEDg8
 T0MYoVdRUJpSfAX2TOGRH4i9kDdnCptKUnoFHsCeQ5naPBYzgy4VBGsnVYV8Yn0PmszA
 9fCF6/l6oqX1wz4cLf9n42hfS/A8AkG1s/qAl3OTabV3f64HqsDuQvYGB9SPsMu99mP5
 UfTQUvT4GQPB08/BjNS1/0LTaayQ78vdFJiDi7tR4C0YYt2JR3mfDivIarG5DuCL9kJY
 erUWTRx+zrZhts4Yimg4Ok7WblAKlTqHTMOZe1VT415J2K9q32DmlgVl3WhxzPmG5Eu/
 dzkA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778613079; x=1779217879; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=abwtRXcEr7HRCHBy7n+6bVsELPOWqP6mab57xjFXvhM=;
 b=dVMnnOiEpx886dZHo21nIseNClrT9cvc2bT9iZsGhuV595y0A+yyknhg72uvXX5kFv
 3T06KPX5A3gXv+xJ4sjYR3Yq2o5ZgzT4i8mQ9VU+njuqFFU0upB0L470Xpiy91TFMR4u
 CrR0L/05FPda0Iv6M1USCnnM8PVOutl64VhVxAK5cYA15NBB2OuYmHjsaCAvHc8ViAbC
 79jgEOj27sZyeXhuzzXR8Io/LEj7YJNPmPVoap74TB6/gg/ZEPI5E3n30k3FcawuNCwO
 24i6J7yFITREBhMPMc/NJWOkKTdygWlj7iCwCtJX9jCkLKgcdVYEzbV6i/+BSTOJk8b2
 Ophw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778613079; x=1779217879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=abwtRXcEr7HRCHBy7n+6bVsELPOWqP6mab57xjFXvhM=;
 b=k71noSGapvCkN1NopRoYJiy1ST5TW9JzoTWbpYtlttePPVBClxL1I4G36SoLn6eRz+
 WPMCdZYFYKI0OhrbdOynzw/GNbeL8kl0kvtf4k4s+Hqvs7hn2m3nsXjad637LhXPmr7Y
 r79HX1OvZ6wOoZzv4dgPPn7kM4iks7ciiNYBZ3VQgPqE2nEXrrpQv/5ffoIA07ZnlP4x
 NAK9Jgv3omh44Qfzu22nQHUM0rMuwilB5UXJalm1+eXvqa0eQG1lU3lw4dqQIxf1mTRl
 bYvtTvvMbhyZEKdv/PUYE5Tsg5ncgiE8S8qeiDl37BuMPXEMtp2uBtwgYatdug22GfgM
 Iq4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gJdumhoF96ZMM1+806RMLdozJHhqbi8Phlk9WsPG4UYaUhBGOgyWKWEbXe0fbss1YB3KU3cvROPc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YydlZHQ0MmOumow09Wc53s/SjN7yHuxUA5ZVb3KlEkd+GyM6PNZ
 e2QtJaCgeY5vGqQ2ydlMMeqzzbzx10VfVkh2LyLT64bImu7fAMLQ6A3Kh8n9BnOjr9Ra00EsOd2
 KK4BSg6NhzzuWVxO2IONRdvOmXiKP0m0=
X-Gm-Gg: Acq92OEdH2zLGx9j4ICezpRtSXkLq7UUfkY6CuNZWcVUYHjTkk7jUOaeyVmKfByG8PJ
 3mnu7Wj8YBileVwUUAXhiNwaGHCMBjAYJL6h5ciR2udM9prdGFPFn+NOy7st/HElR2YPg4+EZvB
 YkLF1VjwA80KVBoOtcR8kDDRNlyD4/lePI203HfAROQCSk+5dAEbK2NYb0W/3Kxz9KJMWcSdypi
 WDEkiocAvxlZeX+o9w7348/19HsW3ABwN9joNt4VPOSWtArIOOPvlRlqan51G8UXRmXq2XMTpC4
 EOXOg6bRUxOr+6Pduh0ZrDGF81wpZwXFtyCTCiuT67GfQWIoUHaPq8PWzSt4OGpS/GaSufzEOw=
 =
X-Received: by 2002:a05:690c:389:b0:7bd:6a98:58d3 with SMTP id
 00721157ae682-7c69ae4a90bmr3332897b3.18.1778613079336; Tue, 12 May 2026
 12:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-4-95c614a739cb@collabora.com>
In-Reply-To: <20260512-panthor-signal-from-irq-v2-4-95c614a739cb@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 12 May 2026 12:11:08 -0700
X-Gm-Features: AVHnY4L6yd0xkquyUunWoWPGS5Em_z0pRxIWcg4ji-awbv3FcSYz1Ukm_mFFbOw
Message-ID: <CAPaKu7R56gakVRPrzXAu94Kk-AL+Ac=uFrikTyXsj8QtWKM29w@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] drm/panthor: Extend the IRQ logic to allow
 fast/hard IRQ handlers
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
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

On Tue, May 12, 2026 at 4:54=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> All drivers except panthor signal their fences from their interrupt
> handler to minimize latency. We could do the same from the threaded
> handler, but the latency is still quite high in that case, so let's
> allow components to choose the context they want their IRQ handler
> to run in by exposing support for custom hard handlers.
>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.h | 11 ++++++++---
>  drivers/gpu/drm/panthor/panthor_fw.c     |  1 +
>  drivers/gpu/drm/panthor/panthor_gpu.c    |  1 +
>  drivers/gpu/drm/panthor/panthor_mmu.c    |  1 +
>  drivers/gpu/drm/panthor/panthor_pwr.c    |  1 +
>  5 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/p=
anthor/panthor_device.h
> index 393fcda73d88..1aaf06df875b 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -672,6 +672,7 @@ static inline void panthor_irq_disable_events(struct =
panthor_irq *pirq, u32 mask
>  static inline int
>  panthor_irq_request(struct panthor_device *ptdev, struct panthor_irq *pi=
rq,
>                     int irq, u32 mask, void __iomem *iomem, const char *n=
ame,
> +                   irqreturn_t (*raw_handler)(int, void *data),
>                     irqreturn_t (*threaded_handler)(int, void *data))
>  {
>         const char *full_name;
> @@ -687,9 +688,13 @@ panthor_irq_request(struct panthor_device *ptdev, st=
ruct panthor_irq *pirq,
>                 return -ENOMEM;
>
>         panthor_irq_resume(pirq);
> -       return devm_request_threaded_irq(ptdev->base.dev, irq,
> -                                        panthor_irq_default_raw_handler,
> -                                        threaded_handler,
> +
> +       if (!threaded_handler) {
> +               return devm_request_irq(ptdev->base.dev, irq, raw_handler=
,
> +                                       IRQF_SHARED, full_name, pirq);
> +       }
devm_request_irq expands to devm_request_threaded_irq plus
IRQF_COND_ONESHOT. This appears redundant.

> +
> +       return devm_request_threaded_irq(ptdev->base.dev, irq, raw_handle=
r, threaded_handler,
>                                          IRQF_SHARED, full_name, pirq);
>  }
>
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panth=
or/panthor_fw.c
> index eaf599b0a887..8239a6951569 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1483,6 +1483,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
>
>         ret =3D panthor_irq_request(ptdev, &fw->irq, irq, 0,
>                                   ptdev->iomem + JOB_INT_BASE, "job",
> +                                 panthor_irq_default_raw_handler,
>                                   panthor_job_irq_threaded_handler);
>         if (ret) {
>                 drm_err(&ptdev->base, "failed to request job irq");
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/pant=
hor/panthor_gpu.c
> index ce208e384762..d0be758ea3e1 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -177,6 +177,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>         ret =3D panthor_irq_request(ptdev, &ptdev->gpu->irq, irq,
>                                   GPU_INTERRUPTS_MASK,
>                                   ptdev->iomem + GPU_INT_BASE, "gpu",
> +                                 panthor_irq_default_raw_handler,
>                                   panthor_gpu_irq_threaded_handler);
>         if (ret)
>                 return ret;
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 375022fb3fd8..2955b8baa2e2 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -3266,6 +3266,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>         ret =3D panthor_irq_request(ptdev, &mmu->irq, irq,
>                                   panthor_mmu_fault_mask(ptdev, ~0),
>                                   ptdev->iomem + MMU_INT_BASE, "mmu",
> +                                 panthor_irq_default_raw_handler,
>                                   panthor_mmu_irq_threaded_handler);
>         if (ret)
>                 return ret;
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/pant=
hor/panthor_pwr.c
> index 80cf78007896..1efb7f3482ba 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
> @@ -491,6 +491,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
>         err =3D panthor_irq_request(
>                 ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK,
>                 pwr->iomem + PWR_INT_BASE, "pwr",
> +               panthor_irq_default_raw_handler,
>                 panthor_pwr_irq_threaded_handler);
>         if (err)
>                 return err;
>
> --
> 2.54.0
>

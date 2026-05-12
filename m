Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DD6CD343F
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 18:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE6710E079;
	Tue, 12 May 2026 18:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Exdigg22";
	dkim-atps=neutral
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC71F10E079
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 18:40:34 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-7b37d84a6b3so58692107b3.2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:40:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778611234; cv=none;
 d=google.com; s=arc-20240605;
 b=SkxHJzxhuC+6KWIivh9PRXzW91sVKQ37GKTrsAFFHZh57U/5e/Thnjyo5QiADdxGWz
 Y0NVtfmAlbcWd9hi+82tZv1bagC7d7al/Se4gJeae8UhAygjTjeAKyV4Rgc+HEV9H70+
 cJIsfXeGAqt8PpFhA2F+eY6rlcQrGuKB5X2iiD7X3QrnTNnnCRzGQxhVRQo2TtBcZylv
 /OQuzBd8argHDoATARux7RoSWnI/4kexQd2jP5fd6oC/9D1XKvLLfy+gBkl3MgYl8zbJ
 sZP1rYsEcvpghyLRoC1wW2ez7ornL1utFziZ5vgkXcCKkXH2DCiDilx3/QGW+Sx/puPI
 o+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=V+qATgh/9SsCy4dOaTg7UkQ0r7zMefJnX561sD6TpkY=;
 fh=1kZcCCn4JDZvoxe7vvzG1Dfpf+RWN16Zz4fyJAsYQ2w=;
 b=gQrRMtixAjbNEmcD0kEnbQwE1l2oKhTfzfjT+RCx4LO8saxNQlqw9kbboNo67HsB1X
 nv6j4uo4lPSvtT3q9uDTiZWyyQfATPKvP4X9UncPfhjL+jf16n93Mt44iqzUqLsAOg4O
 MDKcp3cyfL462jCMwMrGx8VYRKpvYcnwpHOoEItQLj4NR6kHnDCLCCwP2RXfpitRmBHk
 xblGAI+at4Qs2akqSzb1rNNTRyIG2ExnnPl5YLalfCkdA3vJ+YVNnQn1FVS7eEVjYqiY
 M5XWHU9ZQFbSkOZSuSDlJG/1/EdyP9SZr35/Vx58MieGM79NA0Kf+1NUtHWtA7Q1XelW
 uB2A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778611234; x=1779216034; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V+qATgh/9SsCy4dOaTg7UkQ0r7zMefJnX561sD6TpkY=;
 b=Exdigg22qjZREMykFZmgl3kPKQL7V//VYJFVPf1fkwKR+6eK9uV+RHnHAmah45ROfA
 Jhhi6oA1dIT1Kl2KvW0REMKUn8jZH35GQNyCDOGXEVy7ypijLJTUGwuVLC124D4XoHto
 ck6MxuxinpMSZvjRjtJB8h5e0w3/TySsFhH5RYWdJK0A9MYgGiVPirExsh3T8qpXckch
 KQ7U7coZvMxavKbRFseBhi3TPnU49ujwKptcwp3skQTY6wLGFxFUXoVxju+w+/0Px5Jg
 WxsOqSiHH9hMllNH/NDFRp5oIuZ3KnlX8dGgbhx2Xx3KNdnKfJ44aotK+1T5RnKaOHom
 rIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778611234; x=1779216034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V+qATgh/9SsCy4dOaTg7UkQ0r7zMefJnX561sD6TpkY=;
 b=XWTf59LKeCYRnNr1xVLalM8JlmJyRXGLcN8Wd+4DO3No5i9zCdbylR2b0Oz4zvv0GF
 6uewxAc9MI07MwlmxW4Iqam1lQOL9xd3eMKdDwfp1P8ifx/YkIjYtqxg0iVTRD2SE11w
 B38Vpxs/MrLgkcCHOEOQuaFlw+EdhoDVpmH8PJDuaiulSjH2LD8p0TA4uC6K915mB2g4
 F/FR7yPVdG/EJZq46kgBbCQOuse7qSLQJkjvm20PpMR8FvTlGN25dQjFixBDvEM/TSDh
 aBPvidPXXbvlFvO3K2bacHmwpvEKGbcrf9SHYsDkYY8JH2BFKjHpJUzXYlFAif41c2gV
 DrGw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hOm9sz6H+JR642SnL0ghxbTbd/vKiAD32doca1nyIgRizLgwTAXsoCN5DszvQL1+RwuJyQ/atgyk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yze0Fz4galHdqp+BT9gUQLsl/x2X6PuBpR2FNciWpfPOxY29ui6
 vy45okPyVXo9rwqlWCTMfUn6KkgxrtJMiuh2XU5XTS4zwJz8bJviJ1fRiLdij4C02JGS4zXW7nL
 ArmgrGU46Rr4bnPWSxcADZ03p1VM03PA=
X-Gm-Gg: Acq92OEJCj9NdNmofwUpsrLuvxp1s35RN606WwlMFF0fEoC9sBiQlsJ5gnvdWmhB518
 X363xr66jji/1ICID+HJB/ek4qdwPqyYxrGt9hQ+Nhino8oyljY85DNsCovDo5HuqHqNMhyUa9s
 gToiQXepfCst0UrG5VuhY8ZfS8ggmltY1sUuBiEQDf1RDwkS+nL3f4sFBfccNysztwcoOLBOtUJ
 JxsFzi2a/SfL49CVQ+Wv97k63F3wtFdiiTfVmHbpjim0uxG/5F6DYNfIYupJ2yo4LaEbc1H1umb
 pvgxZguImzs/WUPIY7yj1U2VY/CftyXuzQ7XA+lBwLaSAGAUUlSJrgRU4J6IxCD326IRtfs06b2
 cNzGVv23Z
X-Received: by 2002:a05:690c:6989:b0:7bd:a6ea:c508 with SMTP id
 00721157ae682-7c104dab240mr137572627b3.24.1778611233691; Tue, 12 May 2026
 11:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-1-95c614a739cb@collabora.com>
In-Reply-To: <20260512-panthor-signal-from-irq-v2-1-95c614a739cb@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 12 May 2026 11:40:22 -0700
X-Gm-Features: AVHnY4JDaglJaOM0XnyYJVIvvjYAWpPLAqXuLyzZ6781VE0cLdqpQzLVowAwxMQ
Message-ID: <CAPaKu7SUFiJ0O_v0yM2rrusUgzOUZ1Jb=Dm=ejFBPn8Sc6MYug@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] drm/panthor: Make panthor_irq::state a
 non-atomic field
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

On Tue, May 12, 2026 at 4:44=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> The only place where panthor_irq::state is accessed without
> panthor_irq::mask_lock held is in the prologue of _irq_suspend(),
> which is not really a fast-path. So let's simplify things by assuming
> panthor_irq::state must always be accessed with the mask_lock held,
> and add a scoped_guard() in _irq_suspend().
>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.h | 35 ++++++++++++++++----------=
------
>  1 file changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/p=
anthor/panthor_device.h
> index 4e4607bca7cc..3f91ba73829d 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -101,8 +101,12 @@ struct panthor_irq {
>          */
>         spinlock_t mask_lock;

optional nit: might want to rename mask_lock

>
> -       /** @state: one of &enum panthor_irq_state reflecting the current=
 state. */
> -       atomic_t state;
> +       /**
> +        * @state: one of &enum panthor_irq_state reflecting the current =
state.
> +        *
> +        * Must be accessed with mask_lock held.
> +        */
> +       enum panthor_irq_state state;
>  };
>
>  /**
> @@ -510,18 +514,15 @@ const char *panthor_exception_name(struct panthor_d=
evice *ptdev,
>  static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void =
*data)                 \
>  {                                                                       =
                       \
>         struct panthor_irq *pirq =3D data;                               =
                         \
> -       enum panthor_irq_state old_state;                                =
                       \
>                                                                          =
                       \
>         if (!gpu_read(pirq->iomem, INT_STAT))                            =
                       \
>                 return IRQ_NONE;                                         =
                       \
>                                                                          =
                       \
>         guard(spinlock_irqsave)(&pirq->mask_lock);                       =
                       \
> -       old_state =3D atomic_cmpxchg(&pirq->state,                       =
                         \
> -                                  PANTHOR_IRQ_STATE_ACTIVE,             =
                       \
> -                                  PANTHOR_IRQ_STATE_PROCESSING);        =
                       \
> -       if (old_state !=3D PANTHOR_IRQ_STATE_ACTIVE)                     =
                         \
> +       if (pirq->state !=3D PANTHOR_IRQ_STATE_ACTIVE)                   =
                         \
>                 return IRQ_NONE;                                         =
                       \
>                                                                          =
                       \
> +       pirq->state =3D PANTHOR_IRQ_STATE_PROCESSING;                    =
                         \
>         gpu_write(pirq->iomem, INT_MASK, 0);                             =
                       \
>         return IRQ_WAKE_THREAD;                                          =
                       \
>  }                                                                       =
                       \
> @@ -551,13 +552,10 @@ static irqreturn_t panthor_ ## __name ## _irq_threa=
ded_handler(int irq, void *da
>         }                                                                =
                       \
>                                                                          =
                       \
>         scoped_guard(spinlock_irqsave, &pirq->mask_lock) {               =
                       \
> -               enum panthor_irq_state old_state;                        =
                       \
> -                                                                        =
                       \
> -               old_state =3D atomic_cmpxchg(&pirq->state,               =
                         \
> -                                          PANTHOR_IRQ_STATE_PROCESSING, =
                       \
> -                                          PANTHOR_IRQ_STATE_ACTIVE);    =
                       \
> -               if (old_state =3D=3D PANTHOR_IRQ_STATE_PROCESSING)       =
                           \
> +               if (pirq->state =3D=3D PANTHOR_IRQ_STATE_PROCESSING) {   =
                           \
> +                       pirq->state =3D PANTHOR_IRQ_STATE_ACTIVE;        =
                         \
>                         gpu_write(pirq->iomem, INT_MASK, pirq->mask);    =
                       \
> +               }                                                        =
                       \
>         }                                                                =
                       \
>                                                                          =
                       \
>         return ret;                                                      =
                       \
> @@ -566,18 +564,19 @@ static irqreturn_t panthor_ ## __name ## _irq_threa=
ded_handler(int irq, void *da
>  static inline void panthor_ ## __name ## _irq_suspend(struct panthor_irq=
 *pirq)                        \
>  {                                                                       =
                       \
>         scoped_guard(spinlock_irqsave, &pirq->mask_lock) {               =
                       \
> -               atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDING);  =
                       \
> +               pirq->state =3D PANTHOR_IRQ_STATE_SUSPENDING;            =
                         \
>                 gpu_write(pirq->iomem, INT_MASK, 0);                     =
                       \
>         }                                                                =
                       \
>         synchronize_irq(pirq->irq);                                      =
                       \
> -       atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDED);           =
                       \
> +       scoped_guard(spinlock_irqsave, &pirq->mask_lock)                 =
                       \
> +               pirq->state =3D PANTHOR_IRQ_STATE_SUSPENDED;             =
                         \
>  }                                                                       =
                       \
>                                                                          =
                       \
>  static inline void panthor_ ## __name ## _irq_resume(struct panthor_irq =
*pirq)                 \
>  {                                                                       =
                       \
>         guard(spinlock_irqsave)(&pirq->mask_lock);                       =
                       \
>                                                                          =
                       \
> -       atomic_set(&pirq->state, PANTHOR_IRQ_STATE_ACTIVE);              =
                       \
> +       pirq->state =3D PANTHOR_IRQ_STATE_ACTIVE;                        =
                         \
>         gpu_write(pirq->iomem, INT_CLEAR, pirq->mask);                   =
                       \
>         gpu_write(pirq->iomem, INT_MASK, pirq->mask);                    =
                       \
>  }                                                                       =
                       \
> @@ -610,7 +609,7 @@ static inline void panthor_ ## __name ## _irq_enable_=
events(struct panthor_irq *
>          * on the PROCESSING -> ACTIVE transition.                       =
                       \
>          * If the IRQ is suspended/suspending, the mask is restored at re=
sume time.             \
>          */                                                              =
                       \
> -       if (atomic_read(&pirq->state) =3D=3D PANTHOR_IRQ_STATE_ACTIVE)   =
                           \
> +       if (pirq->state =3D=3D PANTHOR_IRQ_STATE_ACTIVE)                 =
                           \
>                 gpu_write(pirq->iomem, INT_MASK, pirq->mask);            =
                       \
>  }                                                                       =
                       \
>                                                                          =
                       \
> @@ -624,7 +623,7 @@ static inline void panthor_ ## __name ## _irq_disable=
_events(struct panthor_irq
>          * on the PROCESSING -> ACTIVE transition.                       =
                       \
>          * If the IRQ is suspended/suspending, the mask is restored at re=
sume time.             \
>          */                                                              =
                       \
> -       if (atomic_read(&pirq->state) =3D=3D PANTHOR_IRQ_STATE_ACTIVE)   =
                           \
> +       if (pirq->state =3D=3D PANTHOR_IRQ_STATE_ACTIVE)                 =
                           \
>                 gpu_write(pirq->iomem, INT_MASK, pirq->mask);            =
                       \
>  }
>
>
> --
> 2.54.0
>

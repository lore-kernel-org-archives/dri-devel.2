Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACD5CD343F
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 22:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2B010EC4D;
	Tue, 12 May 2026 22:40:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DeDdcVeb";
	dkim-atps=neutral
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2BA910EC4D
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 22:40:53 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-7c5d8f45465so12049227b3.1
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 15:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778625653; cv=none;
 d=google.com; s=arc-20240605;
 b=KuCYAKAiPI2WTjwNrJkXa4P57P6dcnJzgaDSSe11YuhFM9pUBwVoyht06t1208wK8s
 tOVo3nEtAqKrCHE4Ex9F8Ne8BxhFNCv4uVdZhw7HGqiteg5XXkMSXnqd2jD8EcQM4xi4
 h85r/iil9Gz7ikygR3p3emPq2G02nLuIN2Y90gHisARlBzFLB+yzwNL+ebFMyiZwsCwp
 AWGWX0KPMQk/k4X2Dk5kJMQMHHqkVmXgz99hF5z/KCqpK+QN2IfPnADClcOu28g+c3kd
 T0voHx2zy3NI5Qodd9i6T9VHmf79hh8695eWNYp/KksdKwUAj+6+5FJsu8BcvPw+uS9k
 otMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Cygyudo1BYFtSoVToi3+AaHuTF3NF/CTpI7e71MPoiE=;
 fh=XhtNqM9TqVaNxWQtEOOwA0f2ro6mPu9bI2JFuakbFDk=;
 b=UdNWL3UZWcgPO7DBl4JCFSPcU3QvS3LTpXtUiLkKr+6qOi/cjZcU0+ydb4pqpUy+v9
 ZyAFzygLqyYdH5adDEkenCMiSSDJFeY0jJkZ4GvnVVYqzFbWe9AI0CUpNmmYk6CZ463d
 ZRvE5xaDON+3Ppzkn6xty0l+DuN1UKLCbj8jLQ2UEtGd8Xmr5ktIvjpDdCyWjmN/aGkR
 fEwXoJ4XNjO0KICzCYwHiwJ+gZFWEwXy+38phy1/yPWDmanSU8AaShSiGhpqh7iI6yRZ
 UweQdO0kJI+ReslAYJsrHciGooB2TPhLjo6nO414cOSbO4Z3GvOsj0ZJoCnEORXp9Jx/
 Rviw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778625653; x=1779230453; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cygyudo1BYFtSoVToi3+AaHuTF3NF/CTpI7e71MPoiE=;
 b=DeDdcVebiRYtliCjE8iBycJKj0IJUElZlsEPG3SfcIqHFWvDv+mmNSJ4Y9tc59a4kd
 kp/mx23mK0xYQXh/gvY3jaaDN+Kie9zNTZFVwK/a/+QxfF+AcC7Lbzj8R4X9jSZ0D0k0
 UuzHNpAU1P6KCO/q8VZJjrkcccBVDZ/FJyhMU1ueAblIN9HYowkff6ZNCDJkwY3kXsBq
 UIedQjl0mo6XRaz4Vacocb/CCn0lT1EdyDPlA7lP2rO8a5hKMxvchcPQI7AI/PMF8kDN
 8qdQPP1vCO3N7T56wrcsjAkq9Froowd1dW+EH78JPtnoTDN5Mi20hDeY0E5VtIGt8X9M
 xzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778625653; x=1779230453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cygyudo1BYFtSoVToi3+AaHuTF3NF/CTpI7e71MPoiE=;
 b=IGwp4OuAZpuX+vY1V5J4LuQq5TiIIu4LHcTOta2LL6lCM5JLkihKIq4plRvZg+qIbN
 BTLDHo+6+4LEpYN6QbLarCkG/6DjpnjmD69ZxKEYRuhjJsLnGLUKD2Lhid+Fy9qGvF0o
 IL2EVgE1vXLIG3qv9g0LcPXV/79y5dmF4YICKp1uvl0THKO5AnKMPefggquN3AN3Byqq
 Zlx+UUk2OHwA3an+V00y548lSqvWRWLxwuOAOLTxjG0djNpPsK4XXvpQmnCU5kAZFVF9
 EmM4cTVJv/lu8w2VaMWapB4W4d86+/yMGa3OX3GIb42A9eOPi6m83rMcMn4pmU4AeXfP
 0cdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8NntARUE9+AgmN+HYFByRekhhKRf5rKPF5M5ygQT8XXUTma1peQPgPUWEBYIOcfpSR3npLaTP9uDE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSnBz+qrR8rx7wNACnZ7N45AR8RdTbE7Aua5hLRcc4lVCV80hu
 MUt89IV92TcPAGuHntU+wObbx1dXpm8P7J4LFsDAkkTyMpXkTqewhcyW7qWL34aCc/Gwms9ZUb8
 GlU+xa2IYLmluKezpV9C1rx8zSQ767xX4zKXDbrk=
X-Gm-Gg: Acq92OEvic0LU6svdDFNDgkocREaQ8dgQ+Qkdp2hVGzKhkyDxYh9idcDRf0ZkGy2vws
 eBIb+ZDB5fNcKxbE5Tk59VdIGFytusa0J4THG0icRqFao9dnchNbPoy5p086qgHv6aGVGTignXg
 UjXs1ouSppL3aVbeAMCiguamMLK4d2dozsI82mJXCq/4I6qvH3CyH13Cla8Sq+g0YabJycqOVwU
 CXbHhQyeAguA2pdqp3tZPXGWbUInDIJ1l8jbPr96SUzjwCQKWFpplXcQXjBBvA3yjuGGi88kPIw
 MYFAjQvhj5W9uL/WG2T8PINCG4+qSAr1Ecq1rzKWDOdhFwx4I9VAX76QG4ZAMDHc7oCwFzhe5Dz
 YW7QNB8hz
X-Received: by 2002:a05:690c:6e85:b0:7b4:6f40:635 with SMTP id
 00721157ae682-7c6ac0c051amr8857117b3.16.1778625652658; Tue, 12 May 2026
 15:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-11-95c614a739cb@collabora.com>
 <20260512135041.7801aa88@fedora>
In-Reply-To: <20260512135041.7801aa88@fedora>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 12 May 2026 15:40:41 -0700
X-Gm-Features: AVHnY4Kt0VFthseMB0hvO5hY_sho55bLcwsRDefeBMVYC44LgDzEL3f1J4lNcQM
Message-ID: <CAPaKu7Qk+aYY-O+HFLbg5D+cc4KZrU1dt23kATc7mpWPEP2gOg@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] drm/panthor: Process GPU events in IRQ context
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

On Tue, May 12, 2026 at 5:09=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Tue, 12 May 2026 13:37:41 +0200
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
>
> > The current panthor_gpu_irq_handler() logic is already IRQ-safe
> > (no sleep or sleeping locks, spinlocks taken with irqsave in other
> > contexts, etc), so let's toggle the switch and make it an hard IRQ
> > handler.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_gpu.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/pa=
nthor/panthor_gpu.c
> > index b9c51f8a051d..04c8f23baf3f 100644
> > --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> > @@ -86,10 +86,15 @@ static void panthor_gpu_l2_config_set(struct pantho=
r_device *ptdev)
> >       gpu_write(gpu->iomem, GPU_L2_CONFIG, l2_config);
> >  }
> >
> > -static void panthor_gpu_irq_handler(struct panthor_irq *pirq, u32 stat=
us)
> > +static irqreturn_t panthor_gpu_irq_raw_handler(int irq, void *data)
> >  {
> > +     struct panthor_irq *pirq =3D data;
> >       struct panthor_device *ptdev =3D pirq->ptdev;
> >       struct panthor_gpu *gpu =3D ptdev->gpu;
> > +     u32 status =3D gpu_read(gpu->irq.iomem, INT_STAT);
> > +
> > +     if (!status)
> > +             return IRQ_NONE;
> >
>
> Forgot to add the pirq state transition here:
>
>        scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
>                if (pirq->state !=3D PANTHOR_IRQ_STATE_ACTIVE)
>                        return IRQ_NONE;
>
>                pirq->state =3D PANTHOR_IRQ_STATE_PROCESSING;
>        }
>
> >       gpu_write(gpu->irq.iomem, INT_CLEAR, status);
> >
> > @@ -115,11 +120,8 @@ static void panthor_gpu_irq_handler(struct panthor=
_irq *pirq, u32 status)
> >               ptdev->gpu->pending_reqs &=3D ~status;
> >               wake_up_all(&ptdev->gpu->reqs_acked);
> >       }
> > -}
> >
> > -static irqreturn_t panthor_gpu_irq_threaded_handler(int irq, void *dat=
a)
> > -{
> > -     return panthor_irq_default_threaded_handler(data, panthor_gpu_irq=
_handler);
>
> and restore it here:
>
>        scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
>                if (pirq->state =3D=3D PANTHOR_IRQ_STATE_PROCESSING)
>                        pirq->state =3D PANTHOR_IRQ_STATE_ACTIVE;
>        }
>
It looks like we can get rid of state transitions if
panthor_irq_{enable,disable}_events updates INT_MASK directly when the
handler is not threaded. Hm, we can even make pirq->state atomic again
to get rid of locking.

> > +     return IRQ_HANDLED;
> >  }
> >
> >  /**
> > @@ -176,8 +178,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
> >       ret =3D panthor_irq_request(ptdev, &ptdev->gpu->irq, irq,
> >                                 GPU_INTERRUPTS_MASK,
> >                                 ptdev->iomem + GPU_INT_BASE, "gpu",
> > -                               panthor_irq_default_raw_handler,
> > -                               panthor_gpu_irq_threaded_handler);
> > +                               panthor_gpu_irq_raw_handler, NULL);
> >       if (ret)
> >               return ret;
> >
> >
>

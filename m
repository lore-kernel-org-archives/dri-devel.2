Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A435CD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 22:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E9E910E3E4;
	Thu,  4 Jun 2026 22:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PfpK5mw4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45BDA10E3E4
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 22:08:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7FC996001A
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 22:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D2C1F00893
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 22:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780610912;
 bh=O+3X+2iuG5boyqMumkBOYvRhUfYJCUh9iz9v4LBRues=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=PfpK5mw4h/AUdpTTstzCczhZ6U39eAQiAe/VvimAMvKJROzpzB71RIcM+3wg+FJt8
 EfSJK7Yr1Q7R45mfZfcJ54KxJfTDqh85jdPOtLrzvn/u7oRVH30+Q5FIuhwG5gY4GK
 donHitSrK98Gz8VvVlZKFX7VhwJ2+E9Wd4sxse/o93jQKEUlHoml9jGJjcJFDuHHCb
 nYuZ2iiWKlHcU8Uk/bt8ly2k7hrmnIk6/hB7P6pvcM09LDcK0ycUOKdApi1DgLca7s
 tOXPiADrgbSc1J8GU+FdJhk6S0+6SGSCiOqq7tPwtXr6oxJQB1cdxaMyenOev+Br0p
 JWZR7lZCOcEUQ==
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-beb8a08a6c8so180036066b.2
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 15:08:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9uP6jy1YDrzfxcBCecwnzFSGScnPNyuXJASCwZ0N1dWzspkznXB1OC88e17ZNuYV7WJJUhoYE74T0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyeGoVzTqL40id7h8DeaS1oCU9bmzEKLhBW6VbhYJAVHr+ob/Rw
 eITRQRnSYGYUgrQIIw+OjvyYTPmk3d1Qg7TxgkCVF1vuZMx93JKepbjiCZJintHPHZSl6misJOK
 9Jr0XveO6BOF4bOd94IlOaFAv4Hc1wQ==
X-Received: by 2002:a17:907:96a2:b0:beb:7979:47d9 with SMTP id
 a640c23a62f3a-bf37135dafamr26249966b.8.1780610910960; Thu, 04 Jun 2026
 15:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260516144623.2582427-2-mcanal@igalia.com>
In-Reply-To: <20260516144623.2582427-2-mcanal@igalia.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 4 Jun 2026 17:08:19 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+p4Pzwki4N7RiB6YbPOA_rcV3q6rO9PNmqOsw6qOE=-A@mail.gmail.com>
X-Gm-Features: AVVi8CfFvtoOs92eMqiLcd6S3lQtF-WTePaHpbFSZwKyFELfjs27mBPnydmeqmQ
Message-ID: <CAL_Jsq+p4Pzwki4N7RiB6YbPOA_rcV3q6rO9PNmqOsw6qOE=-A@mail.gmail.com>
Subject: Re: [PATCH] accel: ethosu: Remove redundant job_lock
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
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

On Sat, May 16, 2026 at 9:46=E2=80=AFAM Ma=C3=ADra Canal <mcanal@igalia.com=
> wrote:
>
> The job_lock mutex guarded dev->in_flight_job across ethosu_job_run(),
> the threaded IRQ handler, and ethosu_job_timedout(). However, the DRM
> scheduler already provides most of the serialization required, which
> makes this mutex redundant.
>
> Analyzing the different scenarios:
>
>   1. run_job() and timedout_job() are mutually exclusive scheduler
>      callbacks, so the scheduler itself serializes them.
>
>   2. run_job() and the IRQ handler are implicitly serialized, but they ca=
n
>      overlap in time: dma_fence_signal() synchronously queues the next
>      run_job onto submit_wq, and the worker can execute run_job(next) on
>      another CPU before the IRQ thread finishes. The mutex previously kep=
t
>      the IRQ's trailing "in_flight_job =3D NULL" from racing run_job(next=
)'s
>      "in_flight_job =3D next" store.
>
>      The handler is now restructured to clear in_flight_job before callin=
g
>      dma_fence_signal(), so any run_job(next) woken by the signal observe=
s
>      NULL.
>
>   3. timedout_job() and the IRQ handler can also overlap if the hardware
>      completes the timed-out job near the timeout boundary, since
>      drm_sched_stop()'s cancel_work_sync() only synchronizes with the
>      scheduler's workqueue. The IRQ handler saves in_flight_job into a
>      local with READ_ONCE() before dereferencing ->done_fence, and
>      run_job()/timedout_job() publish the field with WRITE_ONCE(). This
>      prevents the compiler from reloading the pointer, and keeps the IRQ
>      thread operating on the same job for the duration of the handler eve=
n
>      if timedout_job() concurrently clears the field.
>
> Drop the mutex along with its initialization.
>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
>
> Hi,
>
> I noticed this pattern while reviewing "[PATCH v2] accel: ethosu: Add
> performance counter support" and I had the impression this could be a
> nice code simplification. However, I don't have the hardware to test it,
> so this was only "compile-tested".

Looks good to me and I'll give it a spin before applying.

The mutex originated from the rocket driver code, so maybe the same
change applies there? Though since we have a single h/w core/queue,
things are a bit simpler for ethosu.

Rob

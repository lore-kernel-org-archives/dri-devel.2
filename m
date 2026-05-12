Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89FACD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 18:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1808410E2B9;
	Tue, 12 May 2026 18:42:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V2DqR256";
	dkim-atps=neutral
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ACB510E2BD
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 18:42:07 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-7bd5c773ef3so61027957b3.1
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778611326; cv=none;
 d=google.com; s=arc-20240605;
 b=JHfNVAVviBFKxgRvPyZnj/kguCjE6y6FtnF9w/Ra5xXXj7iDaXCFnKV9mW49gV/fe3
 R8W70U1IDtu3bG1ZuukU8pQMRyg8npOrTBia6kGPpHnmgvcn5K/hUytgXLlth/3RW4ed
 3cMIOaummCIdcqqXkbM0+TCQlRQ2h/+A+3/xZZzt2tvkwO1IUqMht0ZsbMJiZ5lFEuEP
 Q8TdBYw+/jwdygawuBDynfEUY/N7YknWpia5v+0uFc6GuhblKJGkeKxZeLwXkWTL941C
 XWBo7GHQVszI2YxtiCHWV1rDAqqxCtFdYI3RYlveo9xmPMgqKhWlky6j6+QWtBBXClUR
 57mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hVI0uMyryQeB+8oifVzIiPBD+D3+AyQDX5OQytqj6no=;
 fh=1NAUvi7lh0OfgxphuQWNuqiygs/nb5HjXk9jLXuoR8U=;
 b=aJBVoWj77Xv9mpx/WvGXssSXwyVY5iCkbyTYymaRdM+5os6KS+L6kJzNjy8PcPdFuB
 tpjByc3bP6eICadJv13suFaEDYLj2iqcXzCqp3DUoMnydZBdTZtLdpu//3GWo719GcIW
 183XEDgxda5OyvBFs5is3cSzera/NA+PWM8TCAGBygKuFhtAbCIq0FgyOkH31GP+pnvl
 iHgD9FEN/gSODhQ/a3uStZXmTOBy23f4417vHeeq3N0ic2HURLFsJS38K4V8E/HPQwrp
 d2K57Mzwlb/TYdrA4Q8ffvtSdwl2LzplxXH3P5LIGJ87HN0+kh6LMRzoUtKW5UqmrvbA
 aX2w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778611326; x=1779216126; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hVI0uMyryQeB+8oifVzIiPBD+D3+AyQDX5OQytqj6no=;
 b=V2DqR256BZHJwavgP27Ig19PX1BctSyFiC4vXf/0spblJ8fydZqIRpC85clFFncGBK
 pIetMBXlmpn5XE6R7ymNZZOfyEdEgahISk6RJyV4lbTgrB613vx/VVxTDkNBWOVQZoDX
 cDdaukt7ccSH0/whkgjK3uX4V5Pz9D41SOavJuYpJqO/c4CJOG970WVCOwlZa8Ir6aV0
 f9Bxw0U03l1NCvkc6Xdcmi5S652PM/e/xS0fSoyjBs7ak7kIUk7TsQ6pLHPLs9JDT7W3
 4mFbYvD+ZZKzEt1cTxObIVGathi5kjzGW54DPd9bAKrU8ByNBUs02FNzF7NO5oxVFFJQ
 hwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778611326; x=1779216126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hVI0uMyryQeB+8oifVzIiPBD+D3+AyQDX5OQytqj6no=;
 b=eFhIwMZ3hHC8o7rJaz+16330MtxtTIuuhYyWJfnbzGQTqtV3IZRJdaamj4BPkb7Abz
 Fl/euhu07X/fyx7/JidQp2S6IakT3QaazMAh0igf5Q6pQF+7wIIkj0nyty1K0FVjJFGL
 v4lEML9XtTthWd0gImwulrI5WJkf93MEhuehADx968CE2+hjd0qbjJ+2hnf/gS55jEZ6
 mswyMK2U8m/OpfXC+qhNJn8wkk2FyL+qexYDHVlZl6i1pX8T6kMxbXz8Zj2vMEYtYrgs
 haikXqqusF1HgzNHRXUwke07uHO7IgAfdjk2AbvhOxg9Vm5l+ch8O0cUBy2mVHcG7STB
 tO0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9eijSpF3xjK0GnA17s59Lg5ABR/lHDzZj5HjSTNB3xy5tu+7Cz39xchCwV7xMNviuPU/DZASyutbE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYOgiQPxJt/7EOX1S6ar6uKpOLhf2z87arAL1RsB8IXbmM/fbP
 s9C7hJ9NvAHebi/bWmiqn1WH2qZRn6Yw3QD26PqapjmAIfmuPkG12fMhXfDzQez6+kZZamWONn3
 LR9uSVhgpk7SlbrrDqqDmdAGWjOLsBfk=
X-Gm-Gg: Acq92OFMjgNMGfAtp0Vtk4wDX9dni0ru2dDVfpcYnc6S0pUCmq4rcjHxEGe3jye+mGS
 QuE8TbTUeDN1KY4OZyNIDfECF5yd8k65q0oHh/Qur2BclkNt9XVkLxGmnUdbUNl//L1E04g+sJo
 SXp8qDKKDnh5HnwtcOsrP1MZwIzclJ2bckI9+31HLt203I7NIK8SkiLJYFOOcWvBs0NxcO8+7qG
 HBJFjFdlWIn74TiJ7jInmoAVkuiffyjMXG9PXtoDvpv3oPrVGmlvXfsC57ym00OKE8ftQSLXDM6
 S+srNQQLI60o4HbSRd+G6ZMxM1fV1u6C6DYTpm7PT7CVciCC53v8Rvecx0TbDCDDi7D9J1B7EQ=
 =
X-Received: by 2002:a05:690c:e1c5:10b0:79a:dae4:5832 with SMTP id
 00721157ae682-7c6aaee61c6mr261117b3.22.1778611326393; Tue, 12 May 2026
 11:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-2-95c614a739cb@collabora.com>
In-Reply-To: <20260512-panthor-signal-from-irq-v2-2-95c614a739cb@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 12 May 2026 11:41:51 -0700
X-Gm-Features: AVHnY4LnvV2EE1LRM9I8eHDy3ytgLIdPqP5tsyl2YYdALFnjPSTuqpaCvETNp3o
Message-ID: <CAPaKu7SVEqURGurR5xX+jd3Bd93VGu6M-8=PX+xyNozkfVBF0w@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] drm/panthor: Move the register accessors before
 the IRQ helpers
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

On Tue, May 12, 2026 at 5:14=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> We're about to add an IRQ inline helper using gpu_read(). Move things
> around to avoid forward declarations.
>
> No functional changes.
>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>

This can be dropped if patch 3 uses non-inline functions.

> ---
>  drivers/gpu/drm/panthor/panthor_device.h | 142 +++++++++++++++----------=
------
>  1 file changed, 71 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/p=
anthor/panthor_device.h
> index 3f91ba73829d..768fc1992368 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -495,6 +495,77 @@ panthor_exception_is_fault(u32 exception_code)
>  const char *panthor_exception_name(struct panthor_device *ptdev,
>                                    u32 exception_code);
>
> +static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
> +{
> +       writel(data, iomem + reg);
> +}
> +
> +static inline u32 gpu_read(void __iomem *iomem, u32 reg)
> +{
> +       return readl(iomem + reg);
> +}
> +
> +static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
> +{
> +       return readl_relaxed(iomem + reg);
> +}
> +
> +static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
> +{
> +       gpu_write(iomem, reg, lower_32_bits(data));
> +       gpu_write(iomem, reg + 4, upper_32_bits(data));
> +}
> +
> +static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
> +{
> +       return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << =
32));
> +}
> +
> +static inline u64 gpu_read64_relaxed(void __iomem *iomem, u32 reg)
> +{
> +       return (gpu_read_relaxed(iomem, reg) |
> +               ((u64)gpu_read_relaxed(iomem, reg + 4) << 32));
> +}
> +
> +static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
> +{
> +       u32 lo, hi1, hi2;
> +       do {
> +               hi1 =3D gpu_read(iomem, reg + 4);
> +               lo =3D gpu_read(iomem, reg);
> +               hi2 =3D gpu_read(iomem, reg + 4);
> +       } while (hi1 !=3D hi2);
> +       return lo | ((u64)hi2 << 32);
> +}
> +
> +#define gpu_read_poll_timeout(iomem, reg, val, cond, delay_us, timeout_u=
s)     \
> +       read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, fals=
e,     \
> +                         iomem, reg)
> +
> +#define gpu_read_poll_timeout_atomic(iomem, reg, val, cond, delay_us,   =
       \
> +                                    timeout_us)                         =
       \
> +       read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_u=
s,     \
> +                                false, iomem, reg)
> +
> +#define gpu_read64_poll_timeout(iomem, reg, val, cond, delay_us, timeout=
_us)   \
> +       read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, fa=
lse,   \
> +                         iomem, reg)
> +
> +#define gpu_read64_poll_timeout_atomic(iomem, reg, val, cond, delay_us, =
               \
> +                                      timeout_us)                       =
       \
> +       read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout=
_us,   \
> +                                false, iomem, reg)
> +
> +#define gpu_read_relaxed_poll_timeout_atomic(iomem, reg, val, cond, dela=
y_us,  \
> +                                            timeout_us)                 =
       \
> +       read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,  =
       \
> +                                timeout_us, false, iomem, reg)
> +
> +#define gpu_read64_relaxed_poll_timeout(iomem, reg, val, cond, delay_us,=
       \
> +                                       timeout_us)                      =
       \
> +       read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeou=
t_us,  \
> +                         false, iomem, reg)
> +
>  #define INT_RAWSTAT 0x0
>  #define INT_CLEAR   0x4
>  #define INT_MASK    0x8
> @@ -629,75 +700,4 @@ static inline void panthor_ ## __name ## _irq_disabl=
e_events(struct panthor_irq
>
>  extern struct workqueue_struct *panthor_cleanup_wq;
>
> -static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
> -{
> -       writel(data, iomem + reg);
> -}
> -
> -static inline u32 gpu_read(void __iomem *iomem, u32 reg)
> -{
> -       return readl(iomem + reg);
> -}
> -
> -static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
> -{
> -       return readl_relaxed(iomem + reg);
> -}
> -
> -static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
> -{
> -       gpu_write(iomem, reg, lower_32_bits(data));
> -       gpu_write(iomem, reg + 4, upper_32_bits(data));
> -}
> -
> -static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
> -{
> -       return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << =
32));
> -}
> -
> -static inline u64 gpu_read64_relaxed(void __iomem *iomem, u32 reg)
> -{
> -       return (gpu_read_relaxed(iomem, reg) |
> -               ((u64)gpu_read_relaxed(iomem, reg + 4) << 32));
> -}
> -
> -static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
> -{
> -       u32 lo, hi1, hi2;
> -       do {
> -               hi1 =3D gpu_read(iomem, reg + 4);
> -               lo =3D gpu_read(iomem, reg);
> -               hi2 =3D gpu_read(iomem, reg + 4);
> -       } while (hi1 !=3D hi2);
> -       return lo | ((u64)hi2 << 32);
> -}
> -
> -#define gpu_read_poll_timeout(iomem, reg, val, cond, delay_us, timeout_u=
s)     \
> -       read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, fals=
e,     \
> -                         iomem, reg)
> -
> -#define gpu_read_poll_timeout_atomic(iomem, reg, val, cond, delay_us,   =
       \
> -                                    timeout_us)                         =
       \
> -       read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_u=
s,     \
> -                                false, iomem, reg)
> -
> -#define gpu_read64_poll_timeout(iomem, reg, val, cond, delay_us, timeout=
_us)   \
> -       read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, fa=
lse,   \
> -                         iomem, reg)
> -
> -#define gpu_read64_poll_timeout_atomic(iomem, reg, val, cond, delay_us, =
               \
> -                                      timeout_us)                       =
       \
> -       read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout=
_us,   \
> -                                false, iomem, reg)
> -
> -#define gpu_read_relaxed_poll_timeout_atomic(iomem, reg, val, cond, dela=
y_us,  \
> -                                            timeout_us)                 =
       \
> -       read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,  =
       \
> -                                timeout_us, false, iomem, reg)
> -
> -#define gpu_read64_relaxed_poll_timeout(iomem, reg, val, cond, delay_us,=
       \
> -                                       timeout_us)                      =
       \
> -       read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeou=
t_us,  \
> -                         false, iomem, reg)
> -
>  #endif
>
> --
> 2.54.0
>

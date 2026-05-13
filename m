Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3822CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 17:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05A1610EF8D;
	Wed, 13 May 2026 17:06:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l0XlaDlU";
	dkim-atps=neutral
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 154B810EF8D
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:06:27 +0000 (UTC)
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-651d6347a69so6757539d50.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 10:06:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778691986; cv=none;
 d=google.com; s=arc-20240605;
 b=gR0/btSwIKHXQl4Ewa1vet63CNOWvcU9vX/U7Diw6WSf7VSgH6AsNhs/SMs8Qyu0bB
 tQy0uk2kuGTgXX2cB6TcUPObPEvYG/IpWtw/JRm2foOLy88q23vRRUMJBjkBOqA1VQAn
 K9rGeyWUFaBHhTzHyBSVmQEpsDkz2X7k2+bsEhgSiXXoOD0VrKezrxcI9g+Js+C7w7bk
 cHTAoD9yxP70vNcvtxDKTCXfoNsggNg7/RD4kSNtJTtvaYUrRmFo3wwTAv5Crx+Ozv60
 laPxKdMpfKhPfWBHD0mI4e+FZNYB2FqpA10UP3QhskyV1WR1R2ukGRVsLSSro4GVAcl5
 4KxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0V9CbYi6l+/mep8ny4atr6u2VxLzAeNM1fG1CMAw3pc=;
 fh=GU+cQ7UuXc3aX/DLuHhbjkW44C8aPyWZ/uix0sKPXx4=;
 b=ibthVSf2CIYd6XzfGeiFV9cO67D/wW8cu+At0J/p7zI/7njo/cuRlB/s4a0W8VsW7u
 ibgH3nClWHALe4rK3hMx5auwey65ZYEI7kNzCh9mJ3uhjFwRmplIRjnCxLauW8kS2/BJ
 4j4RWdG46JPWtUL5DEAc4/n2oQTwDsXl/CVTfvBgm5FebgjGtEpSctOxk2+GlmKfwEi1
 u5sgaLL+fJvADjfb3g/+huVZfJ4kuE9ATFlvr80ERMyafywh/R5hFKOWTsdqp9Avs25B
 jQNXULd9/w7nOkvjuMp+8s2Ax3J6tjig2JOMCMeWByCwAsuAfpofgbTkh4ju68aNqaai
 5uZA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778691986; x=1779296786; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0V9CbYi6l+/mep8ny4atr6u2VxLzAeNM1fG1CMAw3pc=;
 b=l0XlaDlU5itRlvf2bn8+rcviar/af9P/Tnsw5eR097MmMjX2D5ERzG27xyJ5fM95mT
 RTaOi55U95YSn9GSTvb771kWjNZ4NnrZVDqQ6CdIQJCs853nNCRyaujhPWlY+Lpf6UFA
 DUu0PiyPfhX1iGfke027HsG84ruNX18ecKjfG6G/fojduXq4Ysab2HaaWrkYUmbq+DSV
 XHn9FmctYXyTqW8ixcmGveEFMUi2pb9ZrQLePzjL9yXj68MKq+1uvXVL6yCCF3LsRba6
 tT8t9Tv678//96H/J5v3uH1WoA6BFPbh3WRwtTJdO4/EhxHdTusQT803jG5Zv1BXPWLU
 1/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778691986; x=1779296786;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0V9CbYi6l+/mep8ny4atr6u2VxLzAeNM1fG1CMAw3pc=;
 b=G9rL7vY88bi0lCuiuhRxpJx8aqkkrFA04nZZkfbOba7KTEkECRWIwtRdtvfnbGy/f1
 8nDtOjteOFeqUveGBLIEhQddQwe3FjuJdKN3mlui/+hfsXd7Y8jKsr+EhRnDs7HmQ1Uu
 nx9an0kCv8EiprGLF1a+XSvpASAI8tG+/nMzvlIGhWWfsXMaLe8Hbk4XDsAd48kRYYhe
 ODU0BCV06/Sa4Swst/KnTgtsYZdpxMmkHWnamL+v5XfUqI5Epf03hBogFHxuMewrY5We
 ur7oK1ta8+I41Us3pSY90fg5Abw8iy+V6uRC3KkVBjYOjKd/Sz1ab5HwyWgICy6uRAib
 IntA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UUgcyf2acIe7A8qSPyI7/Qahk1cDQrqxlXWiXl28pw93IJG6ayj7RWcQPJN9oTAu2e4thHOpx9a0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyoWEJFdyvKIqMAe5IBvTYIQ7/Xdqfw8zIoig4yk4dQ0kr8PCJn
 60YWYoYsU1YWLc1bZW3lUlFJPDwnmKqZEswLJKky4eS0YHQs+xEAa4YKpD+dhtKtJUEq9GEQ4kf
 D/WIjA2I2A4m9sBnVlvGaXA3RUL8STtI=
X-Gm-Gg: Acq92OHU/jVBqfA4hU18CuhFGN0e/u/EaIaHAc0gQK+IfzfS4a+QxLQIN/rNaDupQEn
 LRnHNNwlGD3pTtzFtjN1/lpvZn8/yaet2UEVu0iSORHUT+7vIa0wurxE4RnfiUgSlHygUuJLh3O
 rQP6unwDqKq/20qQwN/tphz0yGVyiCzR2QI2F3AJ71lWKynqWb7RzUyUZHuzAToab7smCGt+SgZ
 08y2vuQ6swyjU/Tk8Vx9qgCKobYApmECl32TJRA0kcitp8D9Wjc/jZICkZRfsNbtVe+bWJbgYn8
 kdmal9iHgOO4oCfF8FjpU5Gni6Usa3r9BWpF+HUYSKmXcxmL6LyRNGAafGeintZ2QGayQbYJpQ=
 =
X-Received: by 2002:a05:690c:4911:b0:7c2:db9a:7bdc with SMTP id
 00721157ae682-7c7e80123e3mr3584537b3.22.1778691985793; Wed, 13 May 2026
 10:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-4-95c614a739cb@collabora.com>
 <CAPaKu7R56gakVRPrzXAu94Kk-AL+Ac=uFrikTyXsj8QtWKM29w@mail.gmail.com>
 <20260513100901.7b497929@fedora>
In-Reply-To: <20260513100901.7b497929@fedora>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Wed, 13 May 2026 10:06:14 -0700
X-Gm-Features: AVHnY4Kma_PzelE4xO46LmID4jNnngKJd90lFTmO_QKOBh4mzf0-KpI-wngPAf8
Message-ID: <CAPaKu7TN4+PRYZWMRWFuEP6a9NL6sP_x1_zZrAbkVXsht-yQnw@mail.gmail.com>
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

On Wed, May 13, 2026 at 1:09=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Tue, 12 May 2026 12:11:08 -0700
> Chia-I Wu <olvaffe@gmail.com> wrote:
>
> > On Tue, May 12, 2026 at 4:54=E2=80=AFAM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote:
> > >
> > > All drivers except panthor signal their fences from their interrupt
> > > handler to minimize latency. We could do the same from the threaded
> > > handler, but the latency is still quite high in that case, so let's
> > > allow components to choose the context they want their IRQ handler
> > > to run in by exposing support for custom hard handlers.
> > >
> > > Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> > > Reviewed-by: Steven Price <steven.price@arm.com>
> > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > ---
> > >  drivers/gpu/drm/panthor/panthor_device.h | 11 ++++++++---
> > >  drivers/gpu/drm/panthor/panthor_fw.c     |  1 +
> > >  drivers/gpu/drm/panthor/panthor_gpu.c    |  1 +
> > >  drivers/gpu/drm/panthor/panthor_mmu.c    |  1 +
> > >  drivers/gpu/drm/panthor/panthor_pwr.c    |  1 +
> > >  5 files changed, 12 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/d=
rm/panthor/panthor_device.h
> > > index 393fcda73d88..1aaf06df875b 100644
> > > --- a/drivers/gpu/drm/panthor/panthor_device.h
> > > +++ b/drivers/gpu/drm/panthor/panthor_device.h
> > > @@ -672,6 +672,7 @@ static inline void panthor_irq_disable_events(str=
uct panthor_irq *pirq, u32 mask
> > >  static inline int
> > >  panthor_irq_request(struct panthor_device *ptdev, struct panthor_irq=
 *pirq,
> > >                     int irq, u32 mask, void __iomem *iomem, const cha=
r *name,
> > > +                   irqreturn_t (*raw_handler)(int, void *data),
> > >                     irqreturn_t (*threaded_handler)(int, void *data))
> > >  {
> > >         const char *full_name;
> > > @@ -687,9 +688,13 @@ panthor_irq_request(struct panthor_device *ptdev=
, struct panthor_irq *pirq,
> > >                 return -ENOMEM;
> > >
> > >         panthor_irq_resume(pirq);
> > > -       return devm_request_threaded_irq(ptdev->base.dev, irq,
> > > -                                        panthor_irq_default_raw_hand=
ler,
> > > -                                        threaded_handler,
> > > +
> > > +       if (!threaded_handler) {
> > > +               return devm_request_irq(ptdev->base.dev, irq, raw_han=
dler,
> > > +                                       IRQF_SHARED, full_name, pirq)=
;
> > > +       }
> > devm_request_irq expands to devm_request_threaded_irq plus
> > IRQF_COND_ONESHOT. This appears redundant.
>
> I considered going for devm_request_threaded_irq(COND_ONESHOT), but I
> thought it was easier to reason about with a regular devm_request_irq()
> and an extra conditional since request_irq() is what people tend
> to use when they just have a hard handler (see [1], there's just one
> driver using it, and it's not even needed, because it's calling
> devm_request_irq() which adds this flag already)
It is unclear to me why the current version wants IRQF_COND_ONESHOT in
one case but not in another. Can't we call devm_request_threaded_irq
without IRQF_COND_ONESHOT for both cases?

>
> [1]https://elixir.bootlin.com/linux/v7.1-rc3/A/ident/IRQF_COND_ONESHOT

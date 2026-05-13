Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A89CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5546010EFAE;
	Wed, 13 May 2026 18:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H2QX/Bdt";
	dkim-atps=neutral
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com
 [74.125.224.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A72A910EFAE
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:07:41 +0000 (UTC)
Received: by mail-yx1-f48.google.com with SMTP id
 956f58d0204a3-651d6347a69so6881579d50.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:07:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778695660; cv=none;
 d=google.com; s=arc-20240605;
 b=eGJKh+TxcK4u4xYoENtyqzF2F4Ni/PpAE5Ue7jg7s7T0VRdDoiXop49GHTNa50EQEm
 5B9+kqsglzb5LpeDtm7MKDCITKe5yk6XUJpD2w4YcsG5FCOX1qO/HbniPnbOyDbHDrn0
 aMpyhioDSrAtbA4hj7UlmSZPyD5zQCzE8qYzoMjGrx0kIE80CyoTB4Dc4azI1lzkG/5O
 5Yw2/lYuyD3VVCRsQlI8Iaz5fPcAbqeFkuqtWTgcyUguRh4a60Sz40yWOcCE1i8GMien
 W7ux604oKuiNJAxSHpkEY3vsUsJ36SBJFuclSFfFXimsSEUiluRgeH7/iDaqUQkaEC39
 eQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jxclsP1jswumT4PiuNawpBapcJpnal40G/paeXbGMCA=;
 fh=7upOyMj5ExPNd9r6mVoI4w7ItGWNPcKePGhoGTU4qY0=;
 b=XuW84EkbnZUPFLUtaY8nNdC+kkI8bE/568EJFcOjRS7O/8SIQRCZ1MHRkdTpIncXnQ
 e0c26He5xSu4+j8lCsM3YrrEMBg7gOqGri9B37EwK5LnHpc48OKiZjOFio10C0LK6PCw
 5kpXPs6nLlU2dQsRepzuUvRUbctzGxi3rcoNuTjRHB2tm1m6qfLgyRInExWl0zlNLCey
 AzxmO0vyibpfYN1pg+WH4w4RpthSTkRInBGRIRIMJv0evuXfnI+ajzo/I34RNKhZSd0L
 takBuMkR4wD5NG4fyJKUBf9OaQU+/zQzufmXhq3jzs9q0pLC1JVUrTa8YbSpHNJfWkvj
 z4lQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778695660; x=1779300460; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jxclsP1jswumT4PiuNawpBapcJpnal40G/paeXbGMCA=;
 b=H2QX/Bdt7LD3sC/8KBidnNuUYZ1OLbjBQc4783lGlmXs+TIjzh6mNMhSVSH1S/o4g9
 3vZzBV6od7gW99H8izp9yi58n9I3RrMMY5OjnrJtg5tk6qS0U8djceXuGwmRYuZsuoxR
 9Plc2TGVwwz92eurjYWiXh81f4/gJ4krMSwvnlsIjh9jp6n4MwY5yNJh7w0VCglhAoLA
 o4b5DsjOUcoA9BzB60llF3uZIF2fTdyDSmZpc3LYOdogZOtBAg2jw/Hl08Z79ACPSwQz
 dy5OvuKhR9aWYD4O8uG0aNe/NWFNtWESRb1IAl8yaz6CvV01hdbdUHmRearrpn51swl8
 MMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778695660; x=1779300460;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jxclsP1jswumT4PiuNawpBapcJpnal40G/paeXbGMCA=;
 b=QN8GrA88WC8D0dP1EDnI+oEfFKaAR5ASmFhfjPYctI/+Cw1LyUfzDZo60EMas5qobV
 U15g8Atx2vwZgTgJsuMpokn4j6zs0ZKZeJio5I7YdkVc259EexbUfnA0/WipF3q6Q7Jp
 4wAg5wZ1Xiwt/pkC5isqdsTMwNj3wRG7u1U8mFOUI9Wkl/Ov+NoFKU8n1lwRe9sLtNWW
 PSERqF/IJKfaTi34YwzovsoMewXlgKf59XKZNkhWqzsWbniRYJhWR/s1tsF+nrn0UjDJ
 CueG8o2+fxrheBXtkdSVkXgZZixo2r70bJiUoolWaGDXdmyae8BYkLp7ajVtbl3QxcJ6
 Kq7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ841Jo028NVarkkYSw7ygmNEKXu2dEAuE8TExvA/kTfUAeCkrmzlywZsAtvC+VO+7AArBkpAfUZiGA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkgPyJbBMIxo/9Gy15+Gl51jYZzd705dA0wG3n21USCo/eJ6J1
 EUv4PFK1t+fSzdni1nA0gbDSMwGCeuthSWYOHEPcdJujM8nvknzUh1HOHIrtFl6JfE9MjOGwYNd
 ULz6wtFxyf19x8oMQbBy5TBfsr++fTjQ=
X-Gm-Gg: Acq92OHx+1bpmSg6WJHAXtW0TGuUr4gNa/x9J43aOneaMP26j4qh2fDv3GESOVrfhNE
 e2/S6N8rCLYMGrWJpI9EcxnQYSWamifqYkWBkziwvhQaihipnVagNdufEMjfc8VJTH7kkCZc6WH
 l2ofhQWRTIKOsn7TcMJxtG2GwnteC4lwP2i75onmimVoJWz+xboK0WL5d0oVxgLDqn79PA6G2ZW
 8PBsjF3rhywc3URNkCMaAqnPegTjOXjABz68/B74YlXS09C5o+RVooQH5BCn/rc6Y/J4SoH3DLd
 ukcMIB7aYUuacMdJN3LKYBSIrHD2Ao23n4sb5zGYEsebOBbJnopquNh3lhJiT7O/m/Ic27ntPkT
 DWRegnjSFGVvfH/7clYw=
X-Received: by 2002:a05:690c:6e0c:b0:7bf:eadc:c13d with SMTP id
 00721157ae682-7c7e92c7e52mr5571997b3.31.1778695660353; Wed, 13 May 2026
 11:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-11-95c614a739cb@collabora.com>
 <20260512135041.7801aa88@fedora>
 <CAPaKu7Qk+aYY-O+HFLbg5D+cc4KZrU1dt23kATc7mpWPEP2gOg@mail.gmail.com>
 <20260513105418.6e59142a@fedora>
In-Reply-To: <20260513105418.6e59142a@fedora>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Wed, 13 May 2026 11:07:29 -0700
X-Gm-Features: AVHnY4LkiXfdjiTDWADDu9Cpj2VP_MwSp5FbmKV-lh6Zi09VqauiP-1pPtwHaS8
Message-ID: <CAPaKu7T28Qy7v6zAfhEKDLWrC18VbnsdnAvMxF+Mi0gEyTgiYg@mail.gmail.com>
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

On Wed, May 13, 2026 at 1:54=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Tue, 12 May 2026 15:40:41 -0700
> Chia-I Wu <olvaffe@gmail.com> wrote:
>
> > On Tue, May 12, 2026 at 5:09=E2=80=AFAM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote:
> > >
> > > On Tue, 12 May 2026 13:37:41 +0200
> > > Boris Brezillon <boris.brezillon@collabora.com> wrote:
> > >
> > > > The current panthor_gpu_irq_handler() logic is already IRQ-safe
> > > > (no sleep or sleeping locks, spinlocks taken with irqsave in other
> > > > contexts, etc), so let's toggle the switch and make it an hard IRQ
> > > > handler.
> > > >
> > > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > > ---
> > > >  drivers/gpu/drm/panthor/panthor_gpu.c | 15 ++++++++-------
> > > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/dr=
m/panthor/panthor_gpu.c
> > > > index b9c51f8a051d..04c8f23baf3f 100644
> > > > --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> > > > +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> > > > @@ -86,10 +86,15 @@ static void panthor_gpu_l2_config_set(struct pa=
nthor_device *ptdev)
> > > >       gpu_write(gpu->iomem, GPU_L2_CONFIG, l2_config);
> > > >  }
> > > >
> > > > -static void panthor_gpu_irq_handler(struct panthor_irq *pirq, u32 =
status)
> > > > +static irqreturn_t panthor_gpu_irq_raw_handler(int irq, void *data=
)
> > > >  {
> > > > +     struct panthor_irq *pirq =3D data;
> > > >       struct panthor_device *ptdev =3D pirq->ptdev;
> > > >       struct panthor_gpu *gpu =3D ptdev->gpu;
> > > > +     u32 status =3D gpu_read(gpu->irq.iomem, INT_STAT);
> > > > +
> > > > +     if (!status)
> > > > +             return IRQ_NONE;
> > > >
> > >
> > > Forgot to add the pirq state transition here:
> > >
> > >        scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
> > >                if (pirq->state !=3D PANTHOR_IRQ_STATE_ACTIVE)
> > >                        return IRQ_NONE;
> > >
> > >                pirq->state =3D PANTHOR_IRQ_STATE_PROCESSING;
> > >        }
> > >
> > > >       gpu_write(gpu->irq.iomem, INT_CLEAR, status);
> > > >
> > > > @@ -115,11 +120,8 @@ static void panthor_gpu_irq_handler(struct pan=
thor_irq *pirq, u32 status)
> > > >               ptdev->gpu->pending_reqs &=3D ~status;
> > > >               wake_up_all(&ptdev->gpu->reqs_acked);
> > > >       }
> > > > -}
> > > >
> > > > -static irqreturn_t panthor_gpu_irq_threaded_handler(int irq, void =
*data)
> > > > -{
> > > > -     return panthor_irq_default_threaded_handler(data, panthor_gpu=
_irq_handler);
> > >
> > > and restore it here:
> > >
> > >        scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
> > >                if (pirq->state =3D=3D PANTHOR_IRQ_STATE_PROCESSING)
> > >                        pirq->state =3D PANTHOR_IRQ_STATE_ACTIVE;
> > >        }
> > >
> > It looks like we can get rid of state transitions if
> > panthor_irq_{enable,disable}_events updates INT_MASK directly when the
> > handler is not threaded.
>
> Hm, this would add some conditionals to
> panthor_irq_{enable,disable}_events() and it makes the whole thing even
> harder to reason about, because now it's different depending on whether
> this is a threaded handler or not.
The difference comes from the default raw handler clears INT_MASK
while the custom raw handler does not. That's how one interacts with
{enable,disable}_events and the other does not.

I think it makes sense to move work from hot raw handlers to cold
{enable,disable}_events in the event. It can certainly be a follow-up
series because the benefit is insignificant compared to this series :)

>
> > Hm, we can even make pirq->state atomic again
> > to get rid of locking.
>
> I'd say, if we really want to optimize that, we do it in a follow-up
> series. And I'd rather have an attempt at turning the MMU handler into a
> hard handler (which implies selecting what we process immediately and
> what we defer) than adding conditionals to irq_enabled/disable_events.

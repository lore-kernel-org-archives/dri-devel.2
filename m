Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B61CCD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:17:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 213AC10EFB2;
	Wed, 13 May 2026 18:17:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FithDT0F";
	dkim-atps=neutral
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5729110EFB2
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:17:39 +0000 (UTC)
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-65c2cd216c9so7103836d50.3
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778696258; cv=none;
 d=google.com; s=arc-20240605;
 b=d9nb2j2AugRXQxvoscDcwyTGCeNbCrq/fWCNdVEvj9E1Vnf1c/OCuoXRRhXdfsSgr4
 xalBUhMML8yZN4q56ZqBUxp1QgaUnPYT0aDPsjQLq4E4slq6/vwsJdVhVbk9mRwUdspr
 dvNvAEpdRmsQnqM4XzFGma3FWBq+bvZgfc1upDTU/08jexaiiWsovL3D0abetKl5FtNk
 j3dEEvwIYIPwTAmRwTBaq7WgP67K5JSH47HK27hGnweQsEQpld80olPS/7zsYGvWDmih
 DubHdryeqSPgoAqyT7PsNK5N4qrKnEeK8DibeII88U3S8it3RuRzqv5yWWNkKFY1Z9Za
 5pqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=58WED0uhkGdHD0SVe/mpYCc0dDtXD9vRE+FZdd9uGR0=;
 fh=ATBsfJYRT4Q2zrKLrvPnoV+UlojtpUSdf+jZZ3ygPNc=;
 b=aGVyEn+mGXAztce3CoaRIQQrBPwIGvaWvwEmEpPpKEID4HJxDLtGPSDLf5VbTwBMuT
 c7IRx22Kro7jSUjXP3UucdffbN4d3+xf5ZOx7LL7yb4Qy5bYWxfm0UHBw1wZRpmwA9XJ
 ANIcHHu6Tzugw7PLpVpVyBhHtLLozFv+XkR6m2dnl6aOxr93FrnX6Q5WPu8PdXdOe9r8
 cNpFccXT9Bj9nCCoG6NkmkGkmLxpnfoKT306mxMY8Bg/0WHvGZb/Xrga8jjf9Ic5Pff1
 4S7/KYaSgGmSDdbHsniCfEKfgX5C9FU1kJorSCfXJZKBQTjBvtoUDM9Gc4kNDwFe9bdl
 zowQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778696258; x=1779301058; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=58WED0uhkGdHD0SVe/mpYCc0dDtXD9vRE+FZdd9uGR0=;
 b=FithDT0Fq5Decp0TV3dEZJ+eVNYx05lPCr5UrH5lQBFQYvfhvc+UcLDInvkGc0uliA
 /UhGGEExpMAM6HiNDPG6pu8qRonwxOMRda/apDC6v7I2ZLqAd8xCtXGcCXrq960B95w9
 BlmR+46bTEr7nTMJ8ipXrzgisvzMz2mQI3CklNCqaq+8n4XVxkIJapDl9nkExqNv48OW
 +09Yo3AEcPDIJGvKd2m65sHxaDKCzhfu0CnhJChV6rQpEH+jo1zudq4V8cbkO7du3yLi
 Jr2BFCftBvpdc2LFXE8KBIaIJp8UXuh/rpusH/+uFQ0HsG4eJpsLndOvOdQaQ0nsH2Tx
 c09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778696258; x=1779301058;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=58WED0uhkGdHD0SVe/mpYCc0dDtXD9vRE+FZdd9uGR0=;
 b=WgYgQAi5CET0T2x7COKr0mUTfk0GZcDYvOUvoVmzttahn5Lbzyl9AJu6HCKTkViyFJ
 EkDuSdRBe/wpRaCQByCIwzF6ZuoBn+pwR//AmAzNhKPYY2Yv5c4go9HgOX3BdDbz47NU
 beImsStBIQ/kR5ZIs9ZOBImvsokFtY686yjYSk/T1OEcmZtN6tdULJWt09A+iRwRmmeN
 wKbB5Aqap/EJn685d4sj+aGLFztFESb4pMyxYp6IEkEjn2jSV9thPe/iUMNjLGqHxX+w
 62jA31Z+shs2O4FIJSKKZ9OqXhmcWqfyQtF78+dBllP6PYt+UBPcyli4LjesKV077OzV
 OnMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xrQ0tDtDG/dXtfuQFaax1gAvc9+NdkLWKvOWjWQclJtJDCYApL3qIl9+V3iKFCPdnlNU+86SdL+k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzWJbWWZ15DJGj2Yb+/wyFCo0J9ZvC2xlsw9RbFJrlBvlget6io
 iY4jbe3Pm/D2vynvm1WIWXNNUBwWLxxg5GEYATTtz0Maj70LzaGqpIQpFhdVtkG94MAEnsuzq04
 TrOeXde8BbhRF1q7zK0lVb/PozQ6zjuk=
X-Gm-Gg: Acq92OF78FzkchZ15DS3brEEfPgERikiZVNrOs44Re74PmKgVZKLNve7ljx1tN1IV7Z
 YgLxet+CjZ2Fet/GXJUPrDJuHpJ4K98Dlz/MiomWbVHBWJMw2VgyUM+ON4qWDtzdg1jwJYOpFU6
 bBHp5n6Z8H5NARjTDY+nLuqcf0VmIZuqGJ2d6bMQ92C5u5fnrOZ8xqCMFHNwQadB9xgz9Wty6Am
 83BH0F8n43psDTaEREsyRrOyRawQUz62aywQZzeXQFe1YSiuAUxb+1OSzSmspvevBPR7EFz/1QC
 9MO60Rbws2r5t8UZUP6xxRVviVXrPQfnA96n1Uya3dhDYPIgJHm6mLHH8jvIRHUjw+6EmKvemU8
 FmQcki8eU
X-Received: by 2002:a05:690c:ec9:b0:79b:73dc:d30b with SMTP id
 00721157ae682-7c6ab5e7f27mr47168427b3.8.1778696258267; Wed, 13 May 2026
 11:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-4-95c614a739cb@collabora.com>
 <CAPaKu7R56gakVRPrzXAu94Kk-AL+Ac=uFrikTyXsj8QtWKM29w@mail.gmail.com>
 <20260513100901.7b497929@fedora>
 <CAPaKu7TN4+PRYZWMRWFuEP6a9NL6sP_x1_zZrAbkVXsht-yQnw@mail.gmail.com>
 <20260513193011.4c7d30fc@fedora>
In-Reply-To: <20260513193011.4c7d30fc@fedora>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Wed, 13 May 2026 11:17:26 -0700
X-Gm-Features: AVHnY4ID2SS3qy5X2PgxDw2j_jo89uasHkOOqSnCyRLgpaR9zlwLs2FVokF5NnE
Message-ID: <CAPaKu7ShbEAGC5xx6XgJzVkuBF--RT-g0vgQ9kL5vvw5Q2kUhQ@mail.gmail.com>
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

On Wed, May 13, 2026 at 10:30=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Wed, 13 May 2026 10:06:14 -0700
> Chia-I Wu <olvaffe@gmail.com> wrote:
>
> > On Wed, May 13, 2026 at 1:09=E2=80=AFAM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote:
> > >
> > > On Tue, 12 May 2026 12:11:08 -0700
> > > Chia-I Wu <olvaffe@gmail.com> wrote:
> > >
> > > > On Tue, May 12, 2026 at 4:54=E2=80=AFAM Boris Brezillon
> > > > <boris.brezillon@collabora.com> wrote:
> > > > >
> > > > > All drivers except panthor signal their fences from their interru=
pt
> > > > > handler to minimize latency. We could do the same from the thread=
ed
> > > > > handler, but the latency is still quite high in that case, so let=
's
> > > > > allow components to choose the context they want their IRQ handle=
r
> > > > > to run in by exposing support for custom hard handlers.
> > > > >
> > > > > Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> > > > > Reviewed-by: Steven Price <steven.price@arm.com>
> > > > > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > > > ---
> > > > >  drivers/gpu/drm/panthor/panthor_device.h | 11 ++++++++---
> > > > >  drivers/gpu/drm/panthor/panthor_fw.c     |  1 +
> > > > >  drivers/gpu/drm/panthor/panthor_gpu.c    |  1 +
> > > > >  drivers/gpu/drm/panthor/panthor_mmu.c    |  1 +
> > > > >  drivers/gpu/drm/panthor/panthor_pwr.c    |  1 +
> > > > >  5 files changed, 12 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/g=
pu/drm/panthor/panthor_device.h
> > > > > index 393fcda73d88..1aaf06df875b 100644
> > > > > --- a/drivers/gpu/drm/panthor/panthor_device.h
> > > > > +++ b/drivers/gpu/drm/panthor/panthor_device.h
> > > > > @@ -672,6 +672,7 @@ static inline void panthor_irq_disable_events=
(struct panthor_irq *pirq, u32 mask
> > > > >  static inline int
> > > > >  panthor_irq_request(struct panthor_device *ptdev, struct panthor=
_irq *pirq,
> > > > >                     int irq, u32 mask, void __iomem *iomem, const=
 char *name,
> > > > > +                   irqreturn_t (*raw_handler)(int, void *data),
> > > > >                     irqreturn_t (*threaded_handler)(int, void *da=
ta))
> > > > >  {
> > > > >         const char *full_name;
> > > > > @@ -687,9 +688,13 @@ panthor_irq_request(struct panthor_device *p=
tdev, struct panthor_irq *pirq,
> > > > >                 return -ENOMEM;
> > > > >
> > > > >         panthor_irq_resume(pirq);
> > > > > -       return devm_request_threaded_irq(ptdev->base.dev, irq,
> > > > > -                                        panthor_irq_default_raw_=
handler,
> > > > > -                                        threaded_handler,
> > > > > +
> > > > > +       if (!threaded_handler) {
> > > > > +               return devm_request_irq(ptdev->base.dev, irq, raw=
_handler,
> > > > > +                                       IRQF_SHARED, full_name, p=
irq);
> > > > > +       }
> > > > devm_request_irq expands to devm_request_threaded_irq plus
> > > > IRQF_COND_ONESHOT. This appears redundant.
> > >
> > > I considered going for devm_request_threaded_irq(COND_ONESHOT), but I
> > > thought it was easier to reason about with a regular devm_request_irq=
()
> > > and an extra conditional since request_irq() is what people tend
> > > to use when they just have a hard handler (see [1], there's just one
> > > driver using it, and it's not even needed, because it's calling
> > > devm_request_irq() which adds this flag already)
> > It is unclear to me why the current version wants IRQF_COND_ONESHOT in
> > one case but not in another. Can't we call devm_request_threaded_irq
> > without IRQF_COND_ONESHOT for both cases?
>
> Hm, I thought this had to do with the automatic hard -> threaded
> downgrade happening when RT is enabled, but I fail to see why it
> matters, since all irqaction end up with IRQF_ONESHOT in that case
> anyway. Honestly, I'm tempted to stay on the safe side, and have
> devm_request_irq() called when we just have a hard handler, because I'm
> sure there's a reason for this COND_ONESHOT flag.
Sounds good. Feel free to add Reviewed-by: Chia-I Wu <olvaffe@gmail.com>.

FWIW, I think this commit explains the motivation

  commit c37927a203fa283950f6045602b9f71328ad786c
  Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  Date:   Thu Jul 11 12:20:04 2024 +0200

      genirq: Set IRQF_COND_ONESHOT in request_irq()

      The callers of request_irq() don't care about IRQF_ONESHOT because th=
ey
      don't provide threaded handlers, but if they happen to share the IRQ =
with
      the ACPI SCI, which has a threaded handler and sets IRQF_ONESHOT,
      request_irq() will fail for them due to a flags mismatch.

For panthor, my takeaway is we either care about flag mismatch (then
we should set IRQF_COND_ONESHOT for the threaded case) or we don't
(then we don't need to use devm_request_irq).

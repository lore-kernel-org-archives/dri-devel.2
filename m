Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D780CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 22:10:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE8010E043;
	Tue, 12 May 2026 22:10:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xuftxizb";
	dkim-atps=neutral
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A511110E043
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 22:09:59 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-7bf0b47d2f1so58443547b3.3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 15:09:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778623798; cv=none;
 d=google.com; s=arc-20240605;
 b=A+hPyP2GKLcv4jkT3P0FxsDtzUpRcGcijdCB0dTu6yM3Qrwks+e5IKdXdhpiDMPUps
 Yy+Y/jb0g/lSGjpvB3FhwnQIJ/pLM5vUGR5vF01sAyupYnJbK4XLgjCNUmB8i1qdsgUr
 ppUnlJ3tsvfNjTgv1l3nPjB/G0OWnFVi3HBM58RWoRVy+FbxjWOsijalsyZjiHrYLvGP
 nPB60bnP00Ok51lquu2OMTArlk1GZzkbbJI3ST1bopAPkN1hwUoYBa612ZNpbPrpdBmq
 UdfPv6opQoC73K48HVzEF0f/OagIwzr9gp9DIx4gm9mQ3un7YDKRdVNtb34aZ3TPuEY4
 uuOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5sGXvZWX3HFcYItSgCzD7EyQznbcU2E1kWFPZ1hF9Ck=;
 fh=gYHMgTj7zMyR8wN1ge6MtmMnj7YjgQHZKIC26W+v7+Y=;
 b=BvcrxXRVTMZgZjOSXjUKVuN4cD/38cTMCin9k4bnfgI2m53uKPufGAIPbOiqtMeZLw
 6Y4dPRJAMBlMUm4HBSGdLehS3OKDvwpMBCB4rhlsOH9O4MjQc5WETA3aTVJViG+8RjXO
 ncFeJE76KLk5/DIL6/VB7WybPTY97bEA8f0d4x3AASFxkHHOoVU4M5ZN9KjErXKlrLAM
 z6wJj4TiawIP68iazOh1mcpgqgg3tzX2CqpR9gKSEHUqECo6RBPTY3rdIVABZjajcqkJ
 4eP2byn0/hfKEH78qjYtXaYonXoM34Qj4R4jjcaB/l2J5DkKTG98JIPnSaaNYIgHpSls
 fKBw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778623798; x=1779228598; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5sGXvZWX3HFcYItSgCzD7EyQznbcU2E1kWFPZ1hF9Ck=;
 b=XuftxizbYkuVoWu7Kf8Astxty6F6UOPacOLh/ZVYifFTmTohmzBg8sypxCZOTXNvHz
 /kd7KI5J6aUlrZhcqlwgCUnWi9KuDvWVNMSZOIWAij1tommn6yOV2HysC8pk+S6ojXPh
 qQa47MABsr82DSeFLQIJ5Qo/16IWrqdW3SKXHqQzXw6a8ow9ZoZWPKo5D50o9+ABhe3k
 +sg7jq6PBpOM7ZT3An36nkHveBN+NrUPOE0kzbcznoGPAxwbkLHYBkIxcSAFT3lRkl83
 n5fAxshKNTCb/uCkbRyrYKL3/fbezpZXbO4hW67UfoI80zrX0smgL5/7bzOCMtMjsmY3
 zb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778623798; x=1779228598;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5sGXvZWX3HFcYItSgCzD7EyQznbcU2E1kWFPZ1hF9Ck=;
 b=P47SDg4Wqe0q3tzPwegMTu8OA7mSsT1+UmUX+5uelDCYPMai6M75o5ut0NlkYxigaA
 tcBojqN4yDjgOEvkTPpYtHTSMdu33mc6+ewyG/CFLeeReVX+h99u6IvAVc3BCkPNdrGa
 mNWBU6M3GcR9gUezV6lE24lEWV62a3NZTWy2ZLqJUuhqHvjZ2zyA62n7glOP5p1GKAdu
 YL4PBFmGnqL9tmG4uoCgrhT2Xk0mhthYBkiwDRD1b17tMqQTdFRR+KwsO4y2rcHP1pJG
 Zv7m9enyxRYcFe1DgHoOcsG4ZPE+gaBC5dsMc/xWVk852zqO2xTCdeNMVs89Wl2iPmPN
 wHKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/m9btlD3rs3YWyVUb+cAzfpi3D6Aia9ul1ryvyJbe/OvGElqUw42bc18lp8SktNOAB+FHOLH5vvXg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzfz8f8JQRykTt/sRxfZ/e8gLHOCCtwPgLYwgvKVoebb1aUWAEW
 rsleHHJAi3/6EpEW2Wr31VPykG7Yv6Hvecl4wxcPKIo0R8ck1JV9FIV23Weg0jPSfdyv5foH8Ho
 JFodRCLu0MnfZX6XBqHUN11/dDXaFqUk=
X-Gm-Gg: Acq92OE4D3IwEbn8ZDXbs7EgWinQVUPPSKUs91ISQouVeiIu7B+MQqXkyMxIkdQW06d
 0Kklr8Pyq57mqpU+lkbUGfap3IQyMdE9VSn7JE5hVXLao9f1h2ovjcgEByV7sZpHOiXeA7TqH4T
 QASE7jB4yiuzPBN5+sXihKr535Ifp9Uit0YdBFqN6Tlecx4eVuu4Z/7L5gfFmKGGSaPnYI/Q+JE
 rwIWIv5VlAeHtsRJhoKoSkv/TTEf3crntr6wHBHRMImFP14MCLv4JpepXcX0UfQeARRPRJ+ngyi
 bmUsl6DRYEAyV7xuz9IbOfQ5qJF2gHc6qH2eTzlu1HQFLD3rWoK7WpTWywuSOVExCxwq7zfqxA=
 =
X-Received: by 2002:a05:690c:6d83:b0:7a1:dbab:9406 with SMTP id
 00721157ae682-7c6a944c3famr8052737b3.8.1778623798625; Tue, 12 May 2026
 15:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-9-95c614a739cb@collabora.com>
 <CAPaKu7SHcS=KaeLvSrxcopgL_aKQm2vVeRmGHGWW+E2YgGOM0Q@mail.gmail.com>
In-Reply-To: <CAPaKu7SHcS=KaeLvSrxcopgL_aKQm2vVeRmGHGWW+E2YgGOM0Q@mail.gmail.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 12 May 2026 15:09:47 -0700
X-Gm-Features: AVHnY4LF_EYS2Cfk9L6kll_DMaAmrf0ZG2aUk8L_7KxClcM09DMx4u1kt-6_O0c
Message-ID: <CAPaKu7S=Cq=nASYBRRa_y2Zj4X7sX3+RY6tc4C=Vqq3-5-nqqg@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] drm/panthor: Process FW events in IRQ context
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

On Tue, May 12, 2026 at 3:05=E2=80=AFPM Chia-I Wu <olvaffe@gmail.com> wrote=
:
>
> On Tue, May 12, 2026 at 4:54=E2=80=AFAM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > Now that everything is set to allow processing FW events in IRQ context=
,
> > go for it. This should reduce the dma_fence signaling latency.
> >
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_fw.c | 27 +++++++++++++++++++++++----
> >  1 file changed, 23 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/pan=
thor/panthor_fw.c
> > index f5e0ceca4130..8cfebf180de7 100644
> > --- a/drivers/gpu/drm/panthor/panthor_fw.c
> > +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> > @@ -1087,9 +1087,29 @@ static void panthor_job_irq_handler(struct panth=
or_irq *pirq, u32 status)
> >         }
> >  }
> >
> > -static irqreturn_t panthor_job_irq_threaded_handler(int irq, void *dat=
a)
> > +static irqreturn_t panthor_job_irq_raw_handler(int irq, void *data)
> >  {
> > -       return panthor_irq_default_threaded_handler(data, panthor_job_i=
rq_handler);
> > +       struct panthor_irq *pirq =3D data;
> > +
> > +       if (!gpu_read(pirq->iomem, INT_STAT))
> > +               return IRQ_NONE;
> > +
> > +       scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
> > +               if (pirq->state !=3D PANTHOR_IRQ_STATE_ACTIVE)
> > +                       return IRQ_NONE;
> > +
> > +               pirq->state =3D PANTHOR_IRQ_STATE_PROCESSING;
> > +       }
> > +
> > +       /* We can use INT_STAT here, because we didn't mask the IRQs. *=
/
> > +       panthor_job_irq_handler(pirq, gpu_read(pirq->iomem, INT_STAT));
> We should loop here until INT_STAT is cleared.
Perhaps not. This is hardirq.

Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> > +
> > +       scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
> > +               if (pirq->state =3D=3D PANTHOR_IRQ_STATE_PROCESSING)
> > +                       pirq->state =3D PANTHOR_IRQ_STATE_ACTIVE;
> > +       }
> > +
> > +       return IRQ_HANDLED;
> >  }
> >
> >  static int panthor_fw_start(struct panthor_device *ptdev)
> > @@ -1489,8 +1509,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
> >
> >         ret =3D panthor_irq_request(ptdev, &fw->irq, irq, 0,
> >                                   ptdev->iomem + JOB_INT_BASE, "job",
> > -                                 panthor_irq_default_raw_handler,
> > -                                 panthor_job_irq_threaded_handler);
> > +                                 panthor_job_irq_raw_handler, NULL);
> >         if (ret) {
> >                 drm_err(&ptdev->base, "failed to request job irq");
> >                 return ret;
> >
> > --
> > 2.54.0
> >

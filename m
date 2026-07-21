Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29217C4452F
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 03:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89FEF10E27D;
	Tue, 21 Jul 2026 03:10:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zll0ahwq";
	dkim-atps=neutral
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FEB610E27D
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 03:10:23 +0000 (UTC)
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-80a123ef90aso64506257b3.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 20:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784603422; cv=none;
 d=google.com; s=arc-20260327;
 b=PGDIH/IFxQEdSqvwRYCKOI2S0k6dC/Qj+BWkTH1Ouj1+JW26PMyIIigdg9mqksc56k
 qRcm1JcjqZzbwfIe/ppvyom4McwcrWmAcCaexW4MRZ7oeyTZPz9Z87iVnuislPcoE1IG
 cPj0QFGpILqJU9JeRqx/qD8E3Bj7677NcJNNJ5LYH8GfjWcDf2OpQ5i/p8IxsRd2kUrq
 eLfe39s12soVX4PcvXwFIrRUx+wwaSDN680gvT710m+M+rVUa+/T8BncyqvQ9qFpL9I2
 /+M6qJy0M4MkaRbTZLIH1BEWT5ftfVBCdqrj198LgLInY990Qn1vN29Q9VYb3QSwhDdq
 I3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=phLMwCnRovNBL2FCZmS9hb02QIovvFlxaoITzfa1zfE=;
 fh=r4ZSjWYceERf02VLQF/3lciSvN/E2BZFGQMPMmnkJs0=;
 b=aU0RDPl3BdAS0r16Ki1laTpm8hwNPzx4sJEbj39OTI2DgZRt/MeeAvk9qaLfn+LGMa
 BA3bh5S/V5u17VGy0nPLkx7F9gQvq1jmnpPWLkfc3F3Y99R/U/QzCl9O/c9JKXE151Ik
 cgxVQCcNu7qHbV/axGfx0SMytLyn6nh2ye3kIpUglgXIWCs8HovkVwc9FrWwFUoxBAqf
 cnotPogJx3TboF6LhihUgzeXLpUh6eR9Zb9JISnCfI1sVau0KJ6ss+D6M7rSreMQFJwR
 NWUufx2LjDjKbYdBKfk6hr+YritbGjrJCC4qu3j2BOQ2tOP4PSeZUVf7E4znbvasgYpv
 /EtQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784603422; x=1785208222;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=phLMwCnRovNBL2FCZmS9hb02QIovvFlxaoITzfa1zfE=;
 b=Zll0ahwqxaO9VboIbBa/M9L37SdtNORt+dPiDD5wXvo0XpPl8uM/n8fMnWaS03AZcb
 lYNQUpQ+yujXM7hYrPnoJ/p1VwocPRCgKrlzGB99ShPFUJO6Mg49a6GcM9qcgxH65wr3
 UYd/m19jJx4kMZOk2YkK1XficUnrVreIxCrO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784603422; x=1785208222;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=phLMwCnRovNBL2FCZmS9hb02QIovvFlxaoITzfa1zfE=;
 b=rumbXFqQbQF7s4pJ4xVfgieedfOQwb40tUb6uRlviYp45C97uT0e95Z6T917nc8eRm
 XPgqntrMlai8cbTBE1Nqiv5iz5/XmRRj/Bcf42u/FaAjkPkkzGbe47tLWIQRYlV+MkRu
 cwp8d9ykVTLmPgoY0zMsz9PE4F9W+dY/LHdbQ2+Nw51Vme/RgaXT0pDuLGqp+Qsg5xgW
 TRvGmeLZnHSSyatiFEY5sqDgwPaDIMnUeocZWwRCLgytMNu7dFMZlFapQK8zd39HmDb+
 7G121ESCWXHGRis+mI+vYfNsHYUIEMrp9976BGUoK1/RTOLw/pPdRaCH1WO4VTCnvJqK
 RXQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoT+uEcVY9yollD/jJ+sgXd2udZTcCXWlhATdO+jIE512mNhH/3qofHn7LaZ6+DCkHrqq2vDF3oxC0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGojaCQiD0Vv2DamxV4+LRbCYTVBPdpH1BZFnzn9amlyOjpX+Q
 SmxyH4qr7JL96XH69gN00erXnVl5Rcp6OyeIy3f+E823bhCipRm9Zb5Z9niJS2z0KLWCOI01CnD
 NqqCyYX+makQc7wM04/lmSII4XceVga3loG0b5TR2
X-Gm-Gg: AR+sD12dKwJ8utYvs9wWgpJagGQZyg787lzGy2RdM5+2jGhu3uCcoZe7JxTER4dH71g
 iTq597A870Bhs4YWmfysQT4dvZ5n5TN86vAdvrq9sDSFKXFYjSbdyJtA2VDGJ1FTakA/8L8ZtIM
 QphDl0VL2F2JbGuB/vNzSYwkcxVxmQzo+h9b4VxSNtAr5w6FL/8iGInwx3qVlOJm2KDbapHDSzx
 8bSpoXJ+zVsEctQjVKQqwopQ+u/zC6+nbBW5rzgVl1L/vPo0H4D88SaCpQr+UjrZCYDnRzQadE2
 wfUFU1gsyuQEbdLl
X-Received: by 2002:a05:690c:e1c3:10b0:81e:f57f:1f8f with SMTP id
 00721157ae682-81ef57f23cemr34445977b3.6.1784603422238; Mon, 20 Jul 2026
 20:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1784600387.git.daniel@makrotopia.org>
 <91b40322b07b967fcf286b3e4bd11e5f821bff1c.1784600387.git.daniel@makrotopia.org>
 <20260721024147.2FEE71F000E9@smtp.kernel.org>
In-Reply-To: <20260721024147.2FEE71F000E9@smtp.kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 21 Jul 2026 11:10:11 +0800
X-Gm-Features: AUfX_mx4qcPgLK3orBZOGVBUCGLkc4lvsRzCU905dlQI4f0WIMZbU3ENBGxGpF0
Message-ID: <CAGXv+5HhSyr-q-T-JxOjPv013CsNh1wtf4QxPYxQbrf1XQcaXg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/bridge: it6505: cancel outstanding work before
 teardown in remove()
To: Daniel Golle <daniel@makrotopia.org>
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
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

Hi Daniel,

On Tue, Jul 21, 2026 at 10:41=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [Medium] Calling cancel_work_sync() on the potentially uninitialized ex=
tcon_wq triggers a WARN_ON(!work->func) kernel splat.
>
> Pre-existing issues:
> - [High] Canceling work items without first disabling their scheduling so=
urces (IRQ and extcon notifier) leaves a race window where works can be req=
ueued, leading to a use-after-free.
> --
>
> --- Patch [1]: [PATCH v3 1/4] drm/bridge: it6505: cancel outstanding work=
 before teardown in remove() ---
> commit 06b35e4209da852ce0af8e4b1dd2aec2e9e172b4
> Author: Daniel Golle <daniel@makrotopia.org>
>
> drm/bridge: it6505: cancel outstanding work before teardown in remove()
>
> This commit adds calls to cancel_work_sync() and cancel_delayed_work_sync=
()
> in it6505_i2c_remove() to ensure background works do not dereference free=
d
> memory after the device is unbound. It notes that extcon_wq might not be
> initialized, but claims a zero-allocated work_struct is safe to cancel.
>
> > cancel_work_sync() on extcon_wq is safe even
> > when it was never INIT_WORK()'d, since it6505 is zero-allocated and a
> > zeroed work_struct is reported as not pending.
>
> [Severity: Medium]
> Is this description accurate?
>
> Looking at __flush_work() in kernel/workqueue.c, the workqueue core asser=
ts
> WARN_ON(!work->func) when flushing a work item. If the DRM bridge was nev=
er
> attached, extcon_wq remains zero-allocated.
>
> During module removal, calling cancel_work_sync(&it6505->extcon_wq) will
> unconditionally call __flush_work(work, true), which immediately triggers
> the WARN_ON because the work function is NULL. On systems with panic_on_w=
arn,
> this leads to a kernel panic.

Sashiko seems to be correct here. This is going to cause a very loud
warning, which we likely don't want.

ChenYu

> > diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/brid=
ge/ite-it6505.c
> > index 8ecb43611dba8..2f349aefb7054 100644
> > --- a/drivers/gpu/drm/bridge/ite-it6505.c
> > +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> > @@ -3644,6 +3644,10 @@ static void it6505_i2c_remove(struct i2c_client =
*client)
> >  {
> >       struct it6505 *it6505 =3D i2c_get_clientdata(client);
> >
> > +     cancel_work_sync(&it6505->link_works);
> > +     cancel_work_sync(&it6505->hdcp_wait_ksv_list);
> > +     cancel_delayed_work_sync(&it6505->hdcp_work);
> > +     cancel_work_sync(&it6505->extcon_wq);
>
> [Severity: High]
> This is a pre-existing issue, but does this leave a race window where the=
se
> work items could be requeued?
>
> The driver uses devres for the IRQ and extcon notifier, which remain acti=
ve
> during these cancel_work_sync() calls. Furthermore, the hardware interrup=
t
> is disabled after the works are cancelled.
>
> If we look further down in it6505_i2c_remove():
>
>         ...
>         drm_bridge_remove(&it6505->bridge);
>         drm_dp_aux_unregister(&it6505->aux);
>         it6505_debugfs_remove(it6505);
>         it6505_poweroff(it6505);
>         ...
>
> The interrupt is only disabled inside it6505_poweroff(it6505). If an
> interrupt or extcon event fires immediately after the work is cancelled b=
ut
> before it6505_poweroff() and devres cleanup, won't the handler run and
> re-queue the work via schedule_work()?
>
> This could lead to a use-after-free when devres frees the it6505 structur=
e
> while the re-queued work is still pending.
>
> >       drm_bridge_remove(&it6505->bridge);
> >       drm_dp_aux_unregister(&it6505->aux);
> >       it6505_debugfs_remove(it6505);
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784600387.=
git.daniel@makrotopia.org?part=3D1

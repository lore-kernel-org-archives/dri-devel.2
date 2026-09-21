Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D759BC982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 08:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40FF110E04D;
	Mon, 21 Sep 2026 08:12:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G+04dcps";
	dkim-atps=neutral
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com
 [74.125.224.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8570110E04D
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 08:12:41 +0000 (UTC)
Received: by mail-yx2-f13.google.com with SMTP id
 956f58d0204a3-66e56a1b327so1975819d50.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 01:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789978360; cv=none;
 d=google.com; s=arc-20260327;
 b=JXbvlghAVxf6hrIF6tEUYYpDhejMSKRf9u3qV88Fc5b2Kn2M7ZKaFw7zxuyXR1x3V6
 hYf1mWpK4qVJtUjmI5eO5B+QXtdUZHtP6xNCWoA1eFFjms+YZ4moqwL1La/SaCnZE/Wa
 vQDfV8ZYbSFFUjIE61XHS3Gz1WYhl2NZqRplEJ+8sqxR1AAw9HFILxfwPSZBAzbd3MPj
 5LZYj/f0mA9nEUi9f0pe+SsI5q9d935EmtOghYl4P5HbTgjar83pXx3g1uFTd9lKpImM
 JMBtarO6qLhOb4LLN9K/ayOrC8lnHaqMyTZe07LchYqGATNlRV65CtFIDRJ0ETGoVXhv
 I2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2iqujM79yGjztEGr/+fVKOMfP5+oEqBbOqmgpHVP6Xw=;
 fh=cOEdVGybMIGsaw4tGZs3HMvDWJUdtPC3RAUkHhNEKPU=;
 b=IPD/zzyNcM5qdGz4Hue42w9YBr/CdTyKneAf0G3mfGu92Y6uQZIyK4jz6PnuS4P/UJ
 149YrsBcKIo0hq0xEXcwgU+yBTfF+vWF35N9GbFSLJJ1sl4rZi58URoTBE7pZx2GS9sH
 I3phVHPBOpbmn4aL9it4Kl5Jfsf+pJf/K1jNaFpHTprNLuUhWDP/DbUMGV5stXNeZfoJ
 vS8t1y+4w7lHOTn35Zu1d6VVV+yGiDQ1OqnOsmwI1OetidX+9A7U6icInqQP0VvkPSCl
 umU/4j9HgvhpQP+nVSRUN1P9xXojdkEHbSphopuE9AuzKmW9Rt7ve2d8dLsTrfWWDIdl
 s4wg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789978360; x=1790583160; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2iqujM79yGjztEGr/+fVKOMfP5+oEqBbOqmgpHVP6Xw=;
 b=G+04dcps+Y0vr/6oIig0ed07DL4c2EMHByTb7OzxOIL7IX6Gpaae6/CKR75kjxW6C4
 ZO72gcdCLbm0YPi0ax95IWJFCmc8uc4jH7E0xWZXfkG526zHRp7hCPRdOQn7VgyThgsz
 uZpt160HzHQFjnmn47IEvSPD/6slWAMwm0dGPDJiIbZ68lLQMUy7v/vTq/6BYaiuQcaq
 y/SR/P2+NnD9/e/h9sALVHTxr7PJIV21Ecqsa/DIZyzPx0XAxVFt6/14Kx+JeiO8CCds
 LmBkaX3HK34zz/U2Mo0puu5Vg5wzDveYQsU45dGd6h8QMR6A13fxKweXNpAsffsYWMG5
 ihtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789978360; x=1790583160;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2iqujM79yGjztEGr/+fVKOMfP5+oEqBbOqmgpHVP6Xw=;
 b=UWB/njKQeb9GZp9xD5IC3VUJMn0LS0M0YGJVKj8R8xH6rxxodCBg/LsQc/ZJhTU5T8
 K1d5JN/yUkdYX1zqsW0+BOTVP77b+ibOTFt0OeiNqLYDsD6fFSwEFICwAOCe7uOWYB56
 szLQUOItn4gtBEDC/3iOByVIbXlR9ArE7EaP4CHeFa9IgbhrKc38o5tzWjUIrLdLGV9Z
 VDZUCZ9RybQwX6eB6PX34Z0KGuq/It8ZuCN7xyGYuJ+wxM0m597irdL1cVq3Ms90QAYz
 0nPl3KJGRW7cG/Ziy88TL4WjMBDWrB1Hv4z/756NWA3iSKggzStzike8f5SwSDIOl9Kk
 ZKYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdRuSshkg1XxwsDzenhNS3N7Belwm35qZrfdbHxIqUVdqWwH++q+GpLuTZK6s63kef2xb3SLWEakM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mQhgf+12TciBWQHjqc22+5WuOLQ10eu/VULWiVDAoJXK408X4i
 8KK0NEJPToE1Px3KJCt6jPLo7JixJfTWJ1LAkPRwCBYFJ9YrambMW8yBHZagrEG4y/b1rBFfoIC
 WavdHb4UOkffj0Jc54ccEIwpKrx+kceQ=
X-Gm-Gg: AYBFou1Yf+bgS4mPhms68dQe9OG9sRe7hpXTvlcrEZkqBQOkMG7grP/P9cxKqlqsleq
 28jw3HgUT2iYo/SckETdOTvtzyapAilNzV7kwYmhl910W6GCvtJCroNqMxCFdPu0AOTIDeY/7EO
 1WG+SOTuA/WReVuObO9CHikdX1Fdu/WfXRlRqiBSn6nBwaGSnF+I/JPHLMznn+cnUV3KB1uppu+
 TYvLOxziQRCH5pE4gElnpWNvgMHecqENW4lSGjYC4nPY0Gn+GZZU6lyOujNpjoeHY8gKO5xBVue
 0MSzil7nxVSpAXnDXi6efJFN+g8/HFkc8nu0OBbm5ZODg9Aqr/RzcY79mg==
X-Received: by 2002:a05:690e:12ce:b0:671:70d1:d6d0 with SMTP id
 956f58d0204a3-6717fdfb97amr2457382d50.66.1789978360315; Mon, 21 Sep 2026
 01:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260913120227.1559129-1-lgs201920130244@gmail.com>
 <UqvaHP03S_-FFGTtKijH0w@nvidia.com>
In-Reply-To: <UqvaHP03S_-FFGTtKijH0w@nvidia.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 21 Sep 2026 16:12:26 +0800
X-Gm-Features: AcwNN1XgCXWlbGX--RVpkbgMM1GXMuJYBg88G-h-KhzxE_R154h9ZeFi1-ayk2A
Message-ID: <CANUHTR9xhXwfAmk+OTBdLyUjd5CXZm=aMQuEkH3nwsxd_tQ0Og@mail.gmail.com>
Subject: Re: [PATCH] gpu: host1x: fix runtime PM reference leak on remove
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dmitry Osipenko <digetx@gmail.com>,
 Ulf Hansson <ulfh@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

Hi Mikko,

Thanks for the review.

On Mon, 14 Sept 2026 at 13:39, Mikko Perttunen <mperttunen@nvidia.com> wrot=
e:
>
> On Sunday, September 13, 2026 9:02=E2=80=AFPM Guangshuo Li wrote:
> > host1x_probe() calls pm_runtime_resume_and_get() and intentionally keep=
s
> > the runtime PM usage reference for the lifetime of the driver because
> > host1x is not yet ready for dynamic runtime PM.
> >
> > The probe error path drops this reference with
> > pm_runtime_put_sync_suspend(), but the remove path only calls
> > pm_runtime_force_suspend().
> >
> > pm_runtime_force_suspend() disables runtime PM and invokes the runtime
> > suspend callback when necessary, but it does not decrement the runtime
> > PM usage counter. As a result, the reference acquired by
> > pm_runtime_resume_and_get() remains held after the driver is unbound.
> > Repeated bind and unbind cycles can therefore leave the runtime PM
> > usage counter increasingly unbalanced.
> >
> > Drop the usage reference with pm_runtime_put_sync_suspend() before
> > forcing the device into suspend during removal.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 6b6776e2ab8a ("gpu: host1x: Add initial runtime PM and OPP suppo=
rt")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/gpu/host1x/dev.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
> > index d2c64728f804..bb6a1647e4db 100644
> > --- a/drivers/gpu/host1x/dev.c
> > +++ b/drivers/gpu/host1x/dev.c
> > @@ -729,6 +729,7 @@ static void host1x_remove(struct platform_device *p=
dev)
> >       host1x_unregister(host);
> >       host1x_debug_deinit(host);
> >
> > +     pm_runtime_put_sync_suspend(&pdev->dev);
> >       pm_runtime_force_suspend(&pdev->dev);
>
> After the pm_runtime_put_sync_suspend, the device should always be
> suspended, so I think we should also replace the call to
> pm_runtime_force_suspend with a pm_runtime_disable.
>
> Thank you!
> Mikko
>
> >
> >       host1x_intr_deinit(host);
> > --
> > 2.43.0
> >
> >
>
>
>
>
That makes sense.

I'll replace pm_runtime_force_suspend() with pm_runtime_disable()
after pm_runtime_put_sync_suspend() and send a v2.

Thanks,
Guangshuo

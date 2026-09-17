Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81590C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 10:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DC9A10ED73;
	Thu, 17 Sep 2026 10:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="YtjkH7V5";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4693B10ED73
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789642205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u6ihbO4Iqd9EoQ+wSGF6cP/+ZqsoR5JgyUGsjJYPabY=;
 b=YtjkH7V5e0Zr8FMzFZOLCttIWwT/4jVwoxbT8jkEgseULlLa9tB4jVS8wVRUKDb6EfyaNv
 Yn1kR6crirMyg2atwxJ009dP4/ZdME5XyGBti7DpBs85aE36qZ966Hcte1JEQJ0TI1WdHP
 NsvcZ00H9etlLZ0JYpAMKdhTYcAfuyA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-jEvUy3bANgWxzJN5lavIVQ-1; Thu, 17 Sep 2026 06:50:03 -0400
X-MC-Unique: jEvUy3bANgWxzJN5lavIVQ-1
X-Mimecast-MFC-AGG-ID: jEvUy3bANgWxzJN5lavIVQ_1789642203
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so584690a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 03:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789642203; x=1790247003;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u6ihbO4Iqd9EoQ+wSGF6cP/+ZqsoR5JgyUGsjJYPabY=;
 b=YZayzsGmBUzK0vWTdh3mDBQ+VaDOmt7aE6HmULTcqpjkCbSq+dV49EdkiS+YyBurCl
 I5cHC6EuGfnwOK9NoltRxIB9tVIJNaWe6ggzJqg/EuRX/n9Dm/9CRYdLUor8aQmCHVwf
 hB6KWVbWtqQvdJP3yEAzmjCDyvclMcq4ZQXjeLNHcJrozi9KZrsQNwBwTPWGLcuNbRdt
 2k8VZAL63UGEqp6L5AWTMVtGhDrQHN+DNi/utSxiymgSH76pUgFPAdVvewPAC0p8ME8R
 P5AowoGAPPjNSfr4ol3gazTmgJVDIrK7XIey867UCC92GbXbt3ggSnTWaBVqCRe7c6X3
 UWjA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMphZEo2PSCC89BceC5wOx6O9fMA0kAfd1HShEojscuDd/zmpLVgiMYouzN3MTO10kryPzTaZlmsk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mIErXZMI61+J2p0mWHjmzCVQsk5vy9qwAlUxCxRMXF6N9Sb3LV
 XM8/z2Tmhrc2y3FPbzfO/y3A31gedIK328xb7qWHiwcypzhmwTRiMx3qNfe5Ktfbq8A2DGLw6Xz
 sTESgPV6AzXMHp8ygKZK/5bkYBiGBDrwqXwCA45NfdF/cMkcaxQ/hxmoK9DNBLShu0lZBkz5V8h
 PKDkYLYGg0tARsOnm4kXPV3oq43/XM400wxTRZ/DJegc10
X-Gm-Gg: AYBFou28xAmvB979vz4VXcMxzDtrzhO7dUPF0JkXv/BYJJV/jQXc3GwROnyf0JfqkzM
 vT0qbJSf9pnMn1OiFc833uWPe/s07WnCewd1ayJf2UgfOWM8yVLHU5+ffQbvHO0HnxnKSyNe0Kz
 TDj0Z90mHyU23K93yD36bflTYPedZX7ne/UDeu3fyaApstywJc9JZ/KgH6
X-Received: by 2002:a05:6a20:d70f:b0:3db:2c66:6638 with SMTP id
 adf61e73a8af0-3dd5f471e3emr17197376637.10.1789642202680; 
 Thu, 17 Sep 2026 03:50:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:d70f:b0:3db:2c66:6638 with SMTP id
 adf61e73a8af0-3dd5f471e3emr17197287637.10.1789642202196; Thu, 17 Sep 2026
 03:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260529-bar-v3-0-5c2ac1c751ee@gmail.com>
 <20260529-bar-v3-2-5c2ac1c751ee@gmail.com>
 <2bfb73e6-dca3-4d93-af04-3c644929dd19@ti.com>
 <20260616083921.4066690-1-zaq14760@gmail.com>
 <423c3dca-9589-488d-8462-c3d51f05ee4a@ti.com>
 <20260617020926.114947-1-zaq14760@gmail.com>
 <8fcfab0f-6b98-478b-be4a-c5b810fb3524@ti.com>
 <20260731035705.3198816-1-zaq14760@gmail.com>
 <20260916082924.956116-1-zaq14760@gmail.com>
 <0a13ccb8-8817-4223-a4a2-0de594ac8c71@suse.de>
 <20260916094453.1062125-1-zaq14760@gmail.com>
 <f4c6feab-b1ec-48df-81a5-888444b243a3@suse.de>
 <20260917025644.1262504-1-zaq14760@gmail.com>
In-Reply-To: <20260917025644.1262504-1-zaq14760@gmail.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Date: Thu, 17 Sep 2026 12:49:50 +0200
X-Gm-Features: AcwNN1UM1luWQq9ihk-KOU9oijNFKfCQk8IyuxX6LfLxCouMc1ifgDhN-sy05j4
Message-ID: <CAFOAJEfnDrGTg40h=R0mfZasroPkrSsmbVmmMA91O9uOzu_gYQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
To: LiangCheng Wang <zaq14760@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Devarsh Thakkar <devarsht@ti.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Wig Cheng <onlywig@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NnAhZ9T7iF1rTFiXShm5M4MvSDIs3O9XYRJ8ZKuWveQ_1789642203
X-Mimecast-Originator: redhat.com
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

Hello LiangCheng,

Thanks Thomas for CC'ing me since I missed this patch series.

On Thu, Sep 17, 2026 at 4:57=E2=80=AFAM LiangCheng Wang <zaq14760@gmail.com=
> wrote:
>
> Hi Thomas,
>
> > There's also the ssd130x driver under solomon/ how does it related to
> > the ssd16xx? Is that similar as well?
>
> They share the vendor, but not much else as far as I can tell - Javier
> will know ssd130x far better than I do.
>
> It is an OLED driver over regmap, while ssd16xx is e-paper over raw SPI
> with a BUSY handshake, RAM address windows and waveform LUTs.  The
> register maps do not overlap, so I doubt there is much the two could
> share.
>

Correct, I don't think there is much overlap between the ssd13xx and
ssd16xx families.

There are a few bits that I think are similar though and could be
reused, for example the pixpaper_spi_write() helper logic is basically
the same than ssd130x_spi_write() AFAICT.

Same for pixpaper_send_cmd() and pixpaper_send_data(), I believe that
is the same logic that we now have in ssd130x_write_cmds(). Specially
after the recent commit 3e391b0b516b ("drm/ssd130x: Add SSD135X_FAMILY
and SSD1351 support") that introduced a cmd_params_are_data flag that
allows to send the operation as command and the parameters as data.

So the MCU interface seems to be the same, in particular for the
4-wire SPI interface which AFAIU is what this new SSD1677 driver
supports.

> Its shape does look like a good model though - one driver covering three
> sub-families through a variant table.  And if you would prefer ssd16xx to
> sit in drivers/gpu/drm/solomon/ next to it, that is fine by me.
>

I think that's a good idea, as I mentioned above some of the helpers
used by ssd130x could be factored out in a solomon-common.{h,c} or
something and be shared by both driver ssd130x and ssd16xx drivers (in
insight I should had called ssd13xx to the driver since now it
supports SSD130X, SSD132X, SSD133X and SSD135X families...).

> > If the ssd16xx does not make progress, we could also try to merge your
> > code as ssd16xx and Devarsh would then add support for additional ICs o=
n
> > top.
>
> Thank you - I would be glad to help that way if it comes to it.
>

Agreed. The ssd16xx driver could do the same than ssd130x and support
both SSD1677 and SSD1683. They seem to be quite similar by looking at
the datasheets publicly available.

> Devarsh, it is your series though, so please say if you would rather carr=
y
> it yourself; I would only pick it up with your agreement.
>
> I should also be honest about what I could offer: only what the SSD1677
> and the PIXPAPER 4.26m need, arranged so that further controllers can be
> added on top.  This panel is the only SSD16xx hardware I have, so I could
> not implement or test the others.  If that is too small a starting point,
> I quite understand.
>

That's OK. When I introduced the ssd130x driver, it only supported the
SSD1306 controller and over time we added suppport for more ICs and
13xx families.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


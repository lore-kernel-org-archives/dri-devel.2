Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B44BCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 09:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E575F10E2C4;
	Mon, 18 May 2026 09:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pRmyMkOt";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26F8810E2C4
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:51:23 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2f68f3b075fso8400635eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 02:51:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779097882; cv=none;
 d=google.com; s=arc-20240605;
 b=KePrB1PaD6NGvOFdCEEdFoeJFtvtAyucyqTMGNJYWx3GgHMOAssI3k2LL6aOE6g+se
 0kw8VcwZbqjzrd9k2Bc5R/E1tygLizRTfwJCIV7Bfg56HA4CuXjOredQQJPSY1K8SVYA
 43BHpa5Eh40A699ox/e/W6iMPZ1+Q4LHmJykkE31X18tsb0lty444VCQaC7tBLBoht7F
 Wlatcu/zH4qX09tNF4op9Y/VPkifdg9YcUXpKPXomedXKFJwIleWSoPoxrF6xxRYdhoL
 8LwGv3/BHZKozZWRLaZDdMxr9PzfznuPDZur2MeAlL+BM/Ceppvu4OsN9kYeIBZuIatz
 llRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FePX2WL11b5dRW+WYbo5NswoFP4g/thJvtgtY1wXay8=;
 fh=g+2UT73qgkFL4ze3yhmjcz9E1uTS3bJCkpryKPxrZ0c=;
 b=PbdGuyhH3qbGZCHuOJ6r9ycqFkPfuzr4yf18WRVsrgfVZdWJ5P4AX68tz2emWUqsHW
 4TmzQuCR4YD5DrSeY9636XPuMAGMcX6COTun5ROMuC14i+YiyNfNSpLDTw/UktNCt3bY
 eMG7KPesI5f7FY/uxMWCKyFobwf3tgv2NMzxKwONhRa10RlSQyDxjF92mym9e3IgJs7o
 F04W6mqhBK32kQCiU+IzBnj303frSxY5j13JOknfnyu4ijrTrOniPC1t7YAQkOrgMvo+
 xKV5/RTraPjv/cW0mRdG7BYBu5dY03Cyje2llAhedOV3N4Nt2vSNcOhq/oSH9sA3PoQi
 gtTQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779097882; x=1779702682; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FePX2WL11b5dRW+WYbo5NswoFP4g/thJvtgtY1wXay8=;
 b=pRmyMkOtxmioIO+8Nst0eaPNexzvzBmqhkDDm//Ij62tAxLnItUBQ+4/f3CNuE0Yut
 Z/wNT9QtTYyKbIx1hxi9KZAkvzRFn6mAXDXaKidrwmeJQJUgJyrZH3+9YurGaFrIiMTk
 TEVt4fgy4BPJh8TN+G5j5p+XBmB/EPOYfoxsyMMAzeMJWXOlvOoV1mpN5RDQ7lwfrb5S
 xMKwcemKrAsuz4w2kboNZunMguO3Ueh1ro20gntL9VUkCiFupK2IMuXy3841vbiQMzd2
 UdOL1VxD8W6E1vAKzxoFXtN4uJHCkrZWNfjg7mB1WDLCa+16xh7BWQy7/T8v9gCVF8KH
 k6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779097882; x=1779702682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FePX2WL11b5dRW+WYbo5NswoFP4g/thJvtgtY1wXay8=;
 b=rtJmDifoJdTao1r5MLLBkxlBal+0E5yh9vHQgekDvsVGxWa20HChlaky2T8OQusZM3
 9yiIWJ0QBeucjMNoIPnfk4mYyDKUTwa4YIC2POnGWhrYG7Zv0uvYOjoSedc8t00fi72D
 4KLB5tjjQ2gw7wYpRVtduN8uNAV+nXwjG8L5vyxwG4oR0wzNfy5Es7JFxuUQTEZRlBMI
 eGhcP9HeVyGODEydvVYN9DkJNQFTpsQSFoxnZWn8rPjSpNzCTpsLLxJRwwsKHzPJKmqO
 tKp8DQIwtFf3/ia0rfXzGHgJgczR8Nw/0XtokVhlcKS0CCmdIZ4XBS7CmAS0r5ZiE3VV
 E0sg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8F1e3u6tizhs3htS2F6nOoo4i+qI6Y9Abs2MD1EpDPLtJ/2hYrZWYJd66eO1dS5nzgWa7vZziJ1ps=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyJTjAWyu539/Je+lM3TGEOghegg16NHeueG2MLzoxJrPO7V2p
 OJ02Owu4eK4Z5CDAWhu9eyAnuVvFtKuxenEjJXKBMdGjg6mGjMHCxPJQqRLYQ2zq3B6wVw2zSp1
 CzuWWFODalfFccsNutnh/vAGndxolll4=
X-Gm-Gg: Acq92OHGwvI2pIZiF/Wa5SUYRa4KXyH5Kbj7wluijYxNUiF29k/ewN4pWT/QSQRBL8f
 v0FesCcqbLaQOjukQFrqpbE8aizezM1qcX/tZEl9Xeb9T7t3LRlTXn8QP9Oyrw1C5sZaovp3DNh
 HmiGbRnr3AASiW2psjzEyfyyt48QLnPY8tlqYoUAQgkH1jxhtguJmwvIVPgV1fGnrPtNffD69pT
 QBBVtFw0DSMuMwRKUjZWyw0iIuR/MeCGfTMQ9EldHNN4+83Pmod5kQwgIyY56fvuD6kFMUfFzlP
 Qq5Fc1N2b88NTtdaPr2IS1yeR03vZA==
X-Received: by 2002:a05:7301:688:b0:2ed:e16:6b4a with SMTP id
 5a478bee46e88-3039869b963mr6436744eec.32.1779097882266; Mon, 18 May 2026
 02:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260517074306.30937-1-clamor95@gmail.com>
 <20260517074306.30937-3-clamor95@gmail.com>
 <CAPVz0n3gLYXab4H+DihfTkdBkGPqTvmoFVY1Cwuafd70KPtYbA@mail.gmail.com>
 <20260518092833.GR305027@google.com>
In-Reply-To: <20260518092833.GR305027@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 18 May 2026 12:51:11 +0300
X-Gm-Features: AVHnY4IgFlUyRpln1URXZyQyooZBVQu7rOOaMkPI7Cfdheurgkdm_oeKquAVOyE
Message-ID: <CAPVz0n3QAGk_iebCQdEnv_fG2nnGdM1xm__=wG+4KqVJzs-T_g@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] mfd: lm3533: Convert to use OF bindings
To: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Rob Herring <robh@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, Helge Deller <deller@gmx.de>, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 Andy Shevchenko <andy@kernel.org>
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

=D0=BF=D0=BD, 18 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 12:2=
8 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, 17 May 2026, Svyatoslav Ryhel wrote:
>
> > =D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
10:43 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Since there are no users of this driver via platform data, remove the
> > > platform data support and switch to using Device Tree bindings.
> > > Additionally, optimize functions used only by platform data.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/iio/light/lm3533-als.c      | 123 +++++--------
> > >  drivers/leds/leds-lm3533.c          |  60 ++++---
> > >  drivers/mfd/lm3533-core.c           | 257 +++++++++-----------------=
--
> > >  drivers/video/backlight/lm3533_bl.c |  52 ++++--
> > >  include/linux/mfd/lm3533.h          |  51 +-----
> > >  5 files changed, 202 insertions(+), 341 deletions(-)
>
> Please snip replies.
>
> [...]
>
> > > -static int lm3533_device_led_init(struct lm3533 *lm3533)
> > > -{
> > > -       struct lm3533_platform_data *pdata =3D dev_get_platdata(lm353=
3->dev);
> > > -       int i;
> > > -       int ret;
> > > -
> > > -       if (!pdata->leds || pdata->num_leds =3D=3D 0)
> > > -               return 0;
> > > -
> > > -       if (pdata->num_leds > ARRAY_SIZE(lm3533_led_devs))
> > > -               pdata->num_leds =3D ARRAY_SIZE(lm3533_led_devs);
> > > -
> > > -       for (i =3D 0; i < pdata->num_leds; ++i) {
> > > -               lm3533_led_devs[i].platform_data =3D &pdata->leds[i];
> > > -               lm3533_led_devs[i].pdata_size =3D sizeof(pdata->leds[=
i]);
> > > +               dev_err(dev, "failed to set boost ovp\n");
> > > +               goto err_disable;
> > >         }
> > >
> > > -       ret =3D mfd_add_devices(lm3533->dev, 0, lm3533_led_devs,
> > > -                             pdata->num_leds, NULL, 0, NULL);
> > > +       ret =3D devm_mfd_add_devices(dev, 0, lm3533_child_devices,
> > > +                                  ARRAY_SIZE(lm3533_child_devices),
> > > +                                  NULL, 0, NULL);
> >
> > Question to Lee Jones. Would you find acceptable if the driver will
> > build cell list dynamically based on the nodes in the device tree?
> > This is LED controller after all, not all leds can be populated and
> > same LED control bank can be linked to all LVLEDs for example.
> >
> > If you are ok, would this implementation satisfy you?
>
> Generally not.  Create the non-dynamical information statically
> (obviously not 'const'), then you can add dynamic data as you go.
>

Hm, code I have proposed below creates mfd_cell structure with 7 cells
(max amount of children), and fills each slot with devices described
in the device tree. This seems to fit your expectation. LM3533 is
basically a LED controller but it is set as mfd and IMHO would be
undesirable to create dummy devices.

> >         struct mfd_cell lm3533_cells[LM3533_CELLS_MAX];
> >         u32 count =3D 0, reg;
> >         int ret;
> >
> >         device_for_each_child_node_scoped(lm3533->dev, child) {
> >                 if (!fwnode_device_is_available(child))
> >                         continue;
> >
> >                 if (count >=3D LM3533_CELLS_MAX)
> >                         break;
> >
> >                 if (fwnode_device_is_compatible(child, "ti,lm3533-als")=
) {
> >                         lm3533_cells[count].name =3D "lm3533-als";
> >                         lm3533_cells[count].id =3D PLATFORM_DEVID_NONE;
> >                         lm3533_cells[count].of_compatible =3D "ti,lm353=
3-als";
> >
> >                         lm3533->have_als =3D true;
> >                 }
> >
> >                 if (fwnode_device_is_compatible(child, "ti,lm3533-backl=
ight")) {
> >                         ret =3D fwnode_property_read_u32(child, "reg", =
&reg);
> >                         if (ret || reg > LM3533_HVLED_ID_MAX) {
> >                                 dev_err(dev, "invalid backlight reg %d\=
n", reg);
> >                                 continue;
> >                         }
> >
> >                         lm3533_cells[count].name =3D "lm3533-backlight"=
;
> >                         lm3533_cells[count].id =3D reg;
> >                         lm3533_cells[count].of_compatible =3D
> > "ti,lm3533-backlight";
> >
> >                         lm3533->have_backlights =3D true;
> >                 }
> >
> >                 if (fwnode_device_is_compatible(child, "ti,lm3533-leds"=
)) {
> >                         ret =3D fwnode_property_read_u32(child, "reg", =
&reg);
> >                         if (ret || reg < LM3533_HVLED_ID_MAX ||
> >                             reg > LM3533_LVLED_ID_MAX) {
> >                                 dev_err(dev, "invalid LED reg %d\n", re=
g);
> >                                 continue;
> >                         }
> >
> >                         lm3533_cells[count].name =3D "lm3533-leds";
> >                         lm3533_cells[count].id =3D reg - LM3533_HVLED_I=
D_MAX;
> >                         lm3533_cells[count].of_compatible =3D "ti,lm353=
3-leds";
> >
> >                         lm3533->have_leds =3D true;
> >                 }
> >
> >                 count++;
> >         }
> >
> > >         if (ret) {
> > > -               dev_err(lm3533->dev, "failed to add LED devices\n");
> > > -               return ret;
> > > -       }
> > > -
> > > -       lm3533->have_leds =3D 1;
> > > -
> > > -       return 0;
> > > -}
>
> [...]
>
> --
> Lee Jones

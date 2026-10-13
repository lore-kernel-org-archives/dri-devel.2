Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A0BCC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:49:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E392D10E0B8;
	Tue, 13 Oct 2026 14:49:06 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8933910E011
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 14:49:00 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-88aea027391so1464215b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 07:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791902940; x=1792507740; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tQnPST9S9TXx/lpXdW6R6/PTycYLIXzyk2fMAOlKVx0=;
 b=SR5o/xsHNzHtueXTy6IS6tIFzyIvv83f5L/EzL/txej4wzNFGVWiLpUdMUd6QdSt74
 cVf2MjjzKo8Us2xYyPP1sDtRv3EbjA/jRhNkXzyjPhdD+zCUNlLv1I32lCt2RbhJZVff
 3V7dnAuZoXCAwF5EfDiucKCp9jhwaKqK/rGb/IniVB9CwqlnWX19qANlF0Aoh3ddIZpu
 WeFqTM344Wdeke9EL+Voz/CUJM/gvwi6djeEPsb3m9WRYuwHEVdWZMF7m3WvM/FPkKvZ
 sn+Tz9++r/OBzyLKQxU5ZMMcJ7Emug9gilJzjCso8/Qmau9gAicSL99+0iyr1K1IzvQJ
 iA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791902940; x=1792507740;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tQnPST9S9TXx/lpXdW6R6/PTycYLIXzyk2fMAOlKVx0=;
 b=h2SlkF0JmuCPS2BLrMFDFHnXxXaMxpRBa7Iqx+ZhMsjqQDdLsByUuFK/1bAzMjN/6h
 aUOxvp678Go267pkfLpeRvN6zfOxZzUWBvNPWIy4z+fYkyoADyXpkIXG/c3MXQ8OvLAC
 wz1wZthekMV+eJvUxU1DLP/kcg/wqnrZX4xQJwEhqi/UJgV2zW+Bjw5njVg3OJj9TODr
 m1WBuujT1dglHTQhE6/lLH+UIAt9xHCCCljaFJQOcsnJhifBb0fP3EL4jsKyzVBB5OZH
 1XLLpP1uzRQQTkCooSlXtHJppIlpFNVsZb+vJIiL17jSgq3hD/YoFh2ubEkIpzRvi3u/
 4gEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHBA5oPB689B5PfVNS3dYGtUtdQQ9ncHMShyyn76JOxarQPQsXWogAuQHN2di40zVjXY9VY/cQA5A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKcZ8yqdJEpGuk4wAX84gM6573vizsdMbfzQRK2ln/xybWrj/dN
 w3KlIxmBPqkEYM6/W79IhpGeL44qATlQjGjQXO2cwGsHSgzP+Qk2HJ5Q
X-Gm-Gg: AYBFou0BDSWivRKbfmuQJ4NNjFIyn7P7BGKcgqei2H6upaSD/YJqY6Dm2hEuBWPYfRb
 97NGOI7Tc1r5/8lQSTQrmTSeS0JEhW+W1p4xFkuvXaBL6NynOGZsVjhYoW1UubWSyQqJ7R5Jozr
 OVmr2mBbE2DxX+fApQcVj14yrRJssOiB0KtHKOs+9boQxpsaG5/ERdat4SioS5vREelvnvw72fi
 iNawRXrX0VNt0CMryQs9f7Ri10HDTcHaiT91dMoOkNFBwgx1S1cObI3Ye89WKuM8SseW02ABy8b
 zZ4YBDlJ8u0Sb3MB0fBzaTmQN5fgFpqg3ekqJSO3ix3gRJBov4Z96cVaD0FsJI31W3AzuzSA99m
 2pxn4/TiLTd2Ee++jIs+lPCOtz/Vucmnnecqym73rYDswVjpLgRcuGZ8w6saqwxl51JlLLvYMFu
 J2vrUnzFDsoW3t/haar48S5Fgp8yKkcQhhal4zoVbSTL15TUK40eVoKyiyQzqoW/bet3tKH1Tnl
 mvFbQiKbHn5QQMHGLXP6w==
X-Received: by 2002:a05:6a20:9c15:b0:3e0:bbb8:bbdb with SMTP id
 adf61e73a8af0-3e16be9eb80mr11142742637.47.1791902939830; 
 Tue, 13 Oct 2026 07:48:59 -0700 (PDT)
Received: from arch.localdomain ([161.118.199.118])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896b68ef2easm5380700b3a.7.2026.10.13.07.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:48:59 -0700 (PDT)
From: Jun Yan <jerrysteve1101@gmail.com>
To: dianders@chromium.org
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org,
 jerrysteve1101@gmail.com, jesszhan0024@gmail.com,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, neil.armstrong@linaro.org, simona@ffwll.ch,
 tzimmermann@suse.de
Subject: Re: [PATCH] drm/panel-edp: Add BOE NV140FHD-N43 panel
Date: Tue, 13 Oct 2026 22:48:48 +0800
Message-ID: <20261013144849.343351-1-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAD=FV=VZs9bZciynpey2O6Yy5DQJqeq9Rgz_Ks6dgsBhVUkenA@mail.gmail.com>
References: <CAD=FV=VZs9bZciynpey2O6Yy5DQJqeq9Rgz_Ks6dgsBhVUkenA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi,

> Hi,
> 
> On Sun, Oct 11, 2026 at 9:44=E2=80=AFAM Jun Yan <jerrysteve1101@gmail.com> =
> wrote:
> >
> > Add the BOE NV140FHD-N43 14.0" 1920x1080 eDP panel found in the
> > Sunniwell Z96A.
> >
> > raw EDID:
> >
> > 00 ff ff ff ff ff ff 00 09 e5 f4 03 00 00 00 00
> > 13 1c 01 04 a5 1f 11 78 02 3f 62 94 5e 56 94 28
> > 21 4f 58 00 00 00 01 01 01 01 01 01 01 01 01 01
> > 01 01 01 01 01 01 c8 36 80 cc 70 38 14 40 30 20
> > 36 00 35 ae 10 00 00 1a 86 24 80 cc 70 38 14 40
> > 64 64 44 05 35 ad 10 00 00 1a 00 00 00 fe 00 53
> > 54 41 52 52 59 0a 20 20 20 20 20 20 00 00 00 fe
> > 00 4e 56 31 34 30 46 48 44 2d 4e 34 33 0a 00 97
> >
> > Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
> nel-edp.c
> > index ac815729aa83..ba981581f3b4 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -1972,6 +1972,7 @@ static const struct edp_panel_entry edp_panels[] =
> =3D {
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0xd497, &delay_200_500_e50, "B120X=
> AN01.0"),
> >         EDP_PANEL_ENTRY('A', 'U', 'O', 0xf390, &delay_200_500_e50, "B140X=
> TN07.7"),
> >
> > +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x03f4, &delay_200_500_e50, "NV140=
> FHD-N43"),
> >         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0607, &delay_200_500_e200, "Unkn=
> own"),
> >         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0608, &delay_200_500_e50, "NT116=
> WHM-N11"),
> >         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0609, &delay_200_500_e50_po2e200=
> , "NT116WHM-N21 V4.1"),
> 
> Things look pretty reasonable, but before landing I'd love a little
> more background about this panel and where your timings come from. Do
> you actually have a datasheet here, or are the timings a guess based
> on nearby panels? This panel is also curious in a few other ways:
> 

Thanks for your review.

Regarding the NV140FHD-N43 panel: I could not find its dedicated datasheet.
Instead, I referenced the similar NV140FHM-N43 panel [0], which shares the same
resolution but is 6-bit.

As I understand it, per section 8.0 POWER SEQUENCE:

- hpd_absent maps to T3 (200ms)
- unprepare maps to T10 (500ms)
- enable maps to T17 (20ms).

[0] https://raw.githubusercontent.com/yjun123/e-waste/master/sunniwell-z96a/datasheet/NV140FHM-N43_GZ.pdf

Since delay_200_500_e20 is not defined, I'd avoid adding a new delay entry.
Reusing delay_200_500_e50 is acceptable and works fine on hardware.

> 1. ID (0x03f4) is much lower than other panels.
> 
> 2. The EDID contains the string "STARRY", which is weird for a BOE panel.
> 

These two points are indeed strange and I have no good explanation for them. 
That said, I found a third‑party EDID for this same panel [1].

It contains identical information to the EDID I extracted from the panel, so
this is not an isolated case.

[1] https://github.com/linuxhw/EDID/blob/9c0c1bffc9c0f1cb2044115149a5ecb1652803f8/Digital/BOE/BOE03F4/C26FE7F0F22E

> None of that is necessarily blocking, but I wanted to get a little
> more info. Thanks!
> 
> -Doug


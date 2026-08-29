Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C52C61DD9
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 15:25:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2495010E0A9;
	Sat, 29 Aug 2026 15:25:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SPrjbLum";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D59E010E0A9
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 15:25:43 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cc1cb472b76so1637499a12.0
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 08:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788017143; cv=none;
 d=google.com; s=arc-20260327;
 b=gL4PT2e6yQIWx1SgSG2Q3iyBnBx+FU6jWV73JxC7Py1XqfaFjLXNh+dMlZY1WbO8NL
 AWfqkCKza32jf60It7Khz/E4fd2Q/Mii474Eu9L2aTE7prWf8G9ctRokuzFF2fQes/dx
 rzzEY+cTBVgPg0AiObr9kcloMwkH2AHPGaP3m0yzmedOLfnw3dWjUeqqfCoechO1V9N+
 OFF5YA2KlHoIw/DGQsOrwE2a1M8Q4QG8c2L4te1MS86v3AFEBySHBnWhKikVxHrBHHsE
 n4Hm8A2w5XbVJiXlNwmGhZMtddpDm/Xyjqm9gJ7dUZ7PB393O/Drtf+t0bkP+G2aMuz4
 l/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+vdXxpOV3BfxzN65NOTLlQ+CtWQCv48GXwA+hHSuHZk=;
 fh=ur2puSAPPDbTHrBis5SKZedQUBC8lii9mhB4RjBiVs8=;
 b=o9BgFZqdEvueBQ3mk0TwMqGifwgyuUknzXoVz812iBtIjIUm7LPkV6FV74Pt/yNQ0S
 8Ilw36efES2IXuQhVJbCC2UOzyuwB3DPfl8LqdJMlwQ3nEPReXLL+0GEO7cz/yJOi3Ue
 dWQPP4ZeBeVrJAdIXrTohiwpgJN6TB+yFJntYPu0lfqhSPW4TZ80aWo/GpRStztrdqv3
 od8V8iyax++TMvMPcsmqOtnStAG3XCOsZ50UQ4tfLPTTlDf5DvTngNxEUGG0dP8zjOkU
 O+pHLwSVo/zrPXeHfWw/K4TBFqTD8x+lj8gKWa9oxSfHkMWamZ7/VS+Y0hEfc+CG94Dz
 0Y6A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788017143; x=1788621943; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+vdXxpOV3BfxzN65NOTLlQ+CtWQCv48GXwA+hHSuHZk=;
 b=SPrjbLumRzSAZjTwHFbdme6HWh+MK5L791jmGTONBJUTO2m2OZTUGeIx6AhvfOYcEW
 t4HRHU1jPh0lbXHNvKvB8KHCQwfmiW5fApimhdft9MZX8ee5kU+I0RF0zUztKPeDcWMR
 o7plS6HHBtHnS1O4SxMw1MVZk183vC5etc1XSQQzNhM89aOLHGgYC/O0hapdtaVxjxv4
 pSJkiTcDlyCPkQeFu1WotdJlFXS2Kt27GrukJu5ECyjhbrGhcbDeJ9GqL82BxJ7bgDS7
 gCkQphbVYch2/fU6zJjomdQwiNIIQ9xSQTCRwwSuXJp86QzgUzN5gJXTy6yE/VjUsOGh
 4P4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788017143; x=1788621943;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+vdXxpOV3BfxzN65NOTLlQ+CtWQCv48GXwA+hHSuHZk=;
 b=OOOTWynJwSrq1Yf1GCUMXWNq+SUrqaJa5jbBZ6CnNH+N3q390/9yq2o2ECRM09IjWx
 tW4EGz7qhEtPwfITc+61PchANdnkAHgJIMjXxAy7G+SDzpvNR9yjmWqFh3pra9Sk8vkn
 2cmhe+dlOyLF4VoUzMqRs1NQrRRtAzv11egf25tobJGbRp50FIlQ/BJJ7Sky+AutiUyq
 NdEjLnD4IROkCBofQReCg/VfyNF2UCiChqXBQQbqHPVlxWxdMTU/2ywlk4llCYHDDg5s
 TB52SPj7QjDnbzQKyZxDbTtnvH4NfySvlGglodmP/Wf4K/4oEy/mPCdwv69Qk8fUY4kC
 o1qg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz2yIXRh9u2RYwlF9jKNMt7cEvJmtuJFUUmCUXERWLJDWsfIW3gjCEQceKcwnFrCmwpWZ6jFhsPZs4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kPUGUChzoiBABw02EC/WQtRNlzqSmdGcm0snL+zVHtHaX92nZF
 reVuTM1XmKPvU2YqiojIubG6y/006oi9eGkhLnLc4PICGDyN3r2BnUPDWutMkX2hVhJpQGCPngb
 PYJbscXFmFBbhDQxkDUwrzitjJQRpjLQ=
X-Gm-Gg: AYBFou3HB/uPMStZADLB12214O7Pg1bNjOpGYTWIJXdag+RXTfOCLlD8iyIRCnGrGsf
 fob8blVUgz08LhYglbE8BAaQHTY7nD3x66fT3kpxhQmPFWSZFG1g5cDejYjj0STehCSgRg8kRp6
 /b9f1kc0/Q/9MkhSUN34HBjbgdVuIqiHnhN/MB5YmRpfcwzhKMm85M0pv5Fj656uL8Sg5XoNj4V
 P7mlajvFf9zmxYIbObC2qxUfLW65/eUBb5q4RI16JzSYbvKGtZHSTkbdv6CGyW1GHpllLgi4QGG
 lCZ0N6udBUlIZ61dnyoQQ3gC6Nm344r05rTVD2Y8eCM328PwCXKaejVrD+D0mM+kdLTQt5G6gkj
 W3A==
X-Received: by 2002:a17:90b:1e05:b0:398:9bd5:490c with SMTP id
 98e67ed59e1d1-3989bd54c4emr9157251a91.19.1788017143287; Sat, 29 Aug 2026
 08:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260625082507.57703-1-clamor95@gmail.com>
 <20260625082507.57703-2-clamor95@gmail.com>
 <DKSTU1V8CI9T.1CILLIDVSCGTQ@bootlin.com>
In-Reply-To: <DKSTU1V8CI9T.1CILLIDVSCGTQ@bootlin.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 29 Aug 2026 18:25:32 +0300
X-Gm-Features: AcwNN1UsWEJpZRhqcHwqIRCxBAXEtc7byNpBTuq3vGpQa2odXY3oJraHxfULBuw
Message-ID: <CAPVz0n0zi8DfbNWa25gut4Uz5UpD2ZuQ_xb--CTThysvGJRTxA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpu/drm: bridge: tc358768: Add delay after PLL
 setup
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
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

=D1=81=D1=80, 19 =D1=81=D0=B5=D1=80=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:5=
3 Luca Ceresoli <luca.ceresoli@bootlin.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hello Svyatoslav,
>
> On Thu Jun 25, 2026 at 10:25 AM CEST, Svyatoslav Ryhel wrote:
> > After tc358768_setup_pll() enables PLL_CKEN and the lock indicator come=
s
> > up, the DSI register sequence runs near immediately. On TF700T this
>
> Do you refer to the Asus Transformer Pad TF700T here? Please add the full
> name of the device.
>

Yes, I am referring to Asus Transformer Pad TF700T. Sure, my bad.


> > results in the bridge claiming PLL lock but producing no DSI video outp=
ut:
> > the panel powers up, the backlight comes on, but the framebuffer is nev=
er
> > scanned out.
> >
> > Insert a small settling delay between PLL setup and the rest of the
> > attach.
> >
> > Suggested-by: Michele Brocco <brocco@perceptos.de>
> > Tested-by: Michele Brocco <brocco@perceptos.de> # TF700T
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/gpu/drm/bridge/tc358768.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge=
/tc358768.c
> > index 0f2820b37302..ea358c8da0e9 100644
> > --- a/drivers/gpu/drm/bridge/tc358768.c
> > +++ b/drivers/gpu/drm/bridge/tc358768.c
> > @@ -824,6 +824,9 @@ static void tc358768_bridge_atomic_pre_enable(struc=
t drm_bridge *bridge,
> >               return;
> >       }
> >
> > +     /* Allow the PLL to settle */
> > +     mdelay(20);
>
> Why 20 ms, and not another amount? Is it backed by some datasheet? Or jus=
t
> "it's what fixed my usecase"?
>
> The extra delay is a panel requirement maybe, and definitely specific to
> the specific hardware pipeline of the TF700T. Would it make sense to add =
a
> DT property so only hardware needing a delay can add it, and add as much =
as
> needed?
>

This is a fair point. Thank you Luca. I will experiment a bit more to
see how this can be arranged differently.

> Luca
>
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

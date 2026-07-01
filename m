Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA74C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 16:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 188BE10F068;
	Wed,  1 Jul 2026 16:34:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Go4GEvD8";
	dkim-atps=neutral
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com
 [209.85.222.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31FBB10F068
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 16:34:00 +0000 (UTC)
Received: by mail-ua1-f42.google.com with SMTP id
 a1e0cc1a2514c-966801d093aso243924241.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 09:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782923639; x=1783528439;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmpqSMfTzOW7+zhY+Fvam8zzaPw6BXgrbn1R+/PgTWE=;
 b=Go4GEvD82Iw6g53ouNFAtUoRKz9yokRn38Rm/oW91Dmu8M39M1I8XbqCpmCxNfZrkp
 lQnSHGebwLz9d1KvQrvxkd5r3naOTFiHIAzjniYpGBLQdmG7tcACZTIppT/gqmLqlQmJ
 viwNwyDYXnSn/8bdE2qFlYElkNbXhDZUvswVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782923639; x=1783528439;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cmpqSMfTzOW7+zhY+Fvam8zzaPw6BXgrbn1R+/PgTWE=;
 b=qvDiPyNUj/D2CKNCzRrVSpAC4l9Aus3MSW9flg8iPm9U1Eb4KQNL47/tJr+BrFJYgC
 EW7stFN/z6uWeQMgp9H44zGdpHkrEZzm9VoShmWaOu3alZrF0GVp65uM6OgxgPUrasxz
 bRGKboX/0a0TMbrXTXDTvp0ZEdMyFmXty6msipQZvAJz+ZPKMtprm6381WaFLV4ZsY5J
 IkvZluFQsCXKEkrmEPSb3zWVM5Yos7OG6SZIeqrrZPDWfWDaA/5zgOb3Uf9u/Szq4VUT
 1UQDfvqR8jAePHLXEMDRI5sxPOVbhKFBcpN/RiqlncNK3CcQvvo/wb5dzNqUiXKQgxSO
 ZVnA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpekOgA0Q67EcOugn761XpeOFRcBSZC0WUhBglexKrJMhX/i8ejlOWUqPnCESm/Tfpp2j8L5ovyrbU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdCAdCpdGMPxvvPLkR/jCfsObex731/+t1tZZonFwRbQWkyf/T
 rFNKgAcvhrccg/O4iuTjYft4Q6260JtCGPUMqGWKysiRvf16ImhoVaLt44VmSQCjQdel3doOmk3
 u+sY=
X-Gm-Gg: AfdE7ck8QXkskEFhcBVxwuzPXEHyPKjVM7GXsrBCu+7xP/B3O+B5Np6UfIBlFJcOlri
 TPhFxo/qKDik6X2n061Mz30sJC3wmCRJMt4yoq5AsezCLOGMh90i+oWA8qGzCtqo/hKYmRNjSxf
 lnZzfr7+jjjF3QqSrGIcrfOvcmv2YN6yS+uprWUvt0DN+vD+FVLe11uTiM6k0GftCc96SKM3xv9
 PMZdp7NkO1spXVoU/1rAo96ZMWpJwRrMX7asgizC+0i9y+SENdTShUYCFqm4fTvekl519zlmFha
 lvDN+De9RhTL/NqLwTsCjsA77zZLqfQUj7pVZ1C6mt2L3DuIMGFQGZBs+XJQziGC50k4qldvmzT
 9PJWwLA27qJAtjZfLb3RDLO4/hKBqPE8F2dqJJLU2ia0Vt1XM32i0sCghD1A9FHeK2lmFX/CNzD
 Bcwla15Hqrtjhkllgs9Mfdv71wgP4ocdrXWjinNxovWKK5e1ZFoO6Ti3E=
X-Received: by 2002:a05:6102:2907:b0:726:cd42:d023 with SMTP id
 ada2fe7eead31-73da83095ccmr1079445137.11.1782923638172; 
 Wed, 01 Jul 2026 09:33:58 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com.
 [209.85.221.179]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e173b2b2csm101614137.0.2026.07.01.09.33.56
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 09:33:56 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-5bd95de6865so244312e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 09:33:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RoFdTyOB3j6KGPLp1WASL3M+4LdGGSWXAm77V287ILaG5s2gkEn8ZVjcNqWRCigHbthxC7FoHdwRWU=@lists.freedesktop.org
X-Received: by 2002:a05:6102:6c6:b0:737:9003:ac4c with SMTP id
 ada2fe7eead31-73da8210244mr1281324137.10.1782923635216; Wed, 01 Jul 2026
 09:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260629030930.379879-1-zhouhaikun5@huaqin.corp-partner.google.com>
 <CAD=FV=XoDLOwva_tnUWujgGHCJbe1h6YqX7hO6vdD4f9dbc8UQ@mail.gmail.com>
 <CAKDRTegZxEsE36qpebdg0hAFek0NN1py1aLt4SWPVD8S7S-nbw@mail.gmail.com>
In-Reply-To: <CAKDRTegZxEsE36qpebdg0hAFek0NN1py1aLt4SWPVD8S7S-nbw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 1 Jul 2026 09:33:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VPyyQosGRgn3GKWzvRhii=X7_i4OJ9AiRxczh92gyxjg@mail.gmail.com>
X-Gm-Features: AVVi8Cd5JidG0onYg-h2pdMj1ox8dVHc_GfiS4NzTQE1-3FtHsKQrn3dCF0VmUY
Message-ID: <CAD=FV=VPyyQosGRgn3GKWzvRhii=X7_i4OJ9AiRxczh92gyxjg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Change the KD116N2930A15 panel enable delay
To: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, sam@ravnborg.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 daniel@ffwll.ch, airlied@gmail.com
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

Hi,

On Tue, Jun 30, 2026 at 6:16=E2=80=AFPM Haikun Zhou
<zhouhaikun5@huaqin.corp-partner.google.com> wrote:
>
> Hi Doug, thank you very much for your reply,
>
> On Wed, Jul 1, 2026 at 1:33=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
> >
> > Hi,
> >
> > On Sun, Jun 28, 2026 at 8:09=E2=80=AFPM Haikun Zhou
> > <zhouhaikun5@huaqin.corp-partner.google.com> wrote:
> > >
> > > Due to panel characteristics, when the panel wakes up from the S3, th=
e
> > > main link data is not yet ready when the backlight turns on, causing
> > > a garbage appearance on the screen. Delaying the backlight by 1000ms
> > > can avoid this issue.
> > >
> > > Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.co=
m>
> > > ---
> > >  drivers/gpu/drm/panel/panel-edp.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > This really doesn't feel right; it seems like a hack papering over a
> > problem whose root cause hasn't been found. If nothing else, what does
> > "S3" have to do with anything? The panel isn't left powered on during
> > S3, right? So, as far as the panel is concerned, S3 should be the same
> > as S5. Why would you see this noise only coming out of S3?
> >
> > -Doug
>
> Yes, this screen issue isn't limited to the S3; the backlight turning
> on first and then
> displaying garbage isn't limited to this issue. On Chromebooks, the
> same phenomenon occurs
> when the backlight is completely turned off and then back on.
> Measurements with EE revealed
> that when the backlight is on, the main link data is already being
> transmitted but is still unstable.
> Turning on the backlight at this time causes the screen to display garbag=
e.
> We had to add sufficient backlight delay to fix this issue, and while
> we could modify it in the DTS
> settings, since this is a screen-related problem, we wanted to fix it
> from the driver.

OK, fair enough. Sure, if this is truly a problem with this specific
panel then your patch is the correct one. That being said, I'd still
like to confirm a bit more. Specifically:

1. Usually the controller on the panel is shared among a family of
displays. Do we understand why this specific panel needs the extra
delay while no other panels do? Is this only because we support so few
KDC panels?

2. Have you talked to the panel manufacturer about this problem? Have
they confirmed that they understand the problem and verified that we
truly need a full 1 second delay here?

The 1-second delay is pretty beefy and can affect things like boot
speed for devices using this panel.

-Doug

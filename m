Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36259F013C5
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 08:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AA3710E49D;
	Mon, 16 Mar 2026 08:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hSgverlH";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8227810E289
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 08:03:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C9DC8600AE
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 08:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F7FC2BCB2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 08:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773648186;
 bh=OPGhupo6k7Uc5ylSZDzCP6KD05oEItawAi06nEF6FNw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=hSgverlHOHpBTlT9fHgwTjZakIEOhlTss1q3QMnJ+68xV8CO9XN5rs9gKBuR7cta+
 CR6N1vRbtLF8SSonIVnbXPOsxrOv6WwmafJrhEVf+62KNSOMmpXtACP+IVUKFf0BQ+
 nW4zrF62kBcFnzRlpbNKZrolA9oO249k54oqwQr24+0KLIMjNqA6YzNwDkWj7XBrc/
 or6BhbJN2wBosVwQjt/E87AsPXqye+mYFQg/Y7R4uGq27XWDAPKQS44zWpdLq+jmeY
 ElRP74WVdHgxUSc7/FRrN1Ycv51rCXN493u7YjLnigrLamLX2inNt4ADmfI8sOCKhV
 ncK9K3xZy9Ylw==
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6618bc129acso5363396a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 01:03:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUkejcNcq3K7cgaSNIt/BpXtByfvnkCGMAXak7f8QIhuC9EMyDZTvJID1Hx7X2T7Ese4tjxhq27opc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyqp8AQFF5xMKa1Ng2DNqSaaHWq7SBzlHAeBrYdPWomoWssIdH8
 i6HVgo6GwuUOGN0sSKC9ZjRUKkycMhkAEtYQ6dPB26BOb/nnlxnw0prWz6d8oAZRxtwQ841UzlY
 1K7wY0r0TcNh09X6cNvWJlSuTEjFX6wE=
X-Received: by 2002:a17:906:a14e:b0:b96:eee1:bb66 with SMTP id
 a640c23a62f3a-b9764fc9b73mr615632566b.10.1773648184937; Mon, 16 Mar 2026
 01:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260314165421.1201790-1-zhengxingda@iscas.ac.cn>
 <e716ebde-a4f3-4035-bb21-3c6ab2fe06a4@suse.de>
In-Reply-To: <e716ebde-a4f3-4035-bb21-3c6ab2fe06a4@suse.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 16 Mar 2026 16:02:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4Xt25LavPpiimFxS+BUSU_r-oNCFS=z5kqt8o6ei6XfQ@mail.gmail.com>
X-Gm-Features: AaiRm51603GZoNqGVhZrHZ2eP2D70_RQhaBKKb42Xk030lU_xxFfmbJSvKFJo1M
Message-ID: <CAAhV-H4Xt25LavPpiimFxS+BUSU_r-oNCFS=z5kqt8o6ei6XfQ@mail.gmail.com>
Subject: Re: [PATCH] drm/loongson: stop to set get_vblank_timestamp for 7A1000
 CRTC
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Sui Jingfeng <suijingfeng@loongson.cn>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
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

Hi, Icenowy,

On Mon, Mar 16, 2026 at 3:53=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
>
>
> Am 14.03.26 um 17:54 schrieb Icenowy Zheng:
> > As there's no known hardware capability about querying vblank on the
> > 7A1000 display controller, setting get_vblank_timestamp will mislead th=
e
> > kernel about the support of DC-backed high precision vblank query.
> >
> > Drop this function pointer in the CRTC function table for 7A1000.
> >
> > This solves a kernel warning when booting Linux 7.0-rc3 on a
> > 3A4000+7A1000 Haier Boyue G51 laptop (with injected EDID for replicatin=
g
Please s/3A4000/Loongson-3A4000/g and s/7A1000/LS7A1000/g, thanks.

Huacai

> > the display timing set by the firmware).
> >
> > Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> > ---
> >   drivers/gpu/drm/loongson/lsdc_crtc.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c b/drivers/gpu/drm/loo=
ngson/lsdc_crtc.c
> > index 587fbe285e9ef..b3af8e0cdb15f 100644
> > --- a/drivers/gpu/drm/loongson/lsdc_crtc.c
> > +++ b/drivers/gpu/drm/loongson/lsdc_crtc.c
> > @@ -721,7 +721,6 @@ static const struct drm_crtc_funcs ls7a1000_crtc_fu=
ncs =3D {
> >       .late_register =3D lsdc_crtc_late_register,
> >       .enable_vblank =3D lsdc_crtc_enable_vblank,
> >       .disable_vblank =3D lsdc_crtc_disable_vblank,
> > -     .get_vblank_timestamp =3D drm_crtc_vblank_helper_get_vblank_times=
tamp,
> >       .atomic_print_state =3D lsdc_crtc_atomic_print_state,
> >   };
> >
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG N=C3=
=BCrnberg)
>
>

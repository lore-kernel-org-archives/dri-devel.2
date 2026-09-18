Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B51C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ABD710E357;
	Mon, 21 Sep 2026 07:00:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bq96xx+C";
	dkim-atps=neutral
Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com
 [74.125.231.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D764895CA
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 19:15:32 +0000 (UTC)
Received: by mail-oa2-f12.google.com with SMTP id
 586e51a60fabf-466cc88a0d7so888770fac.2
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 12:15:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789758931; cv=none;
 d=google.com; s=arc-20260327;
 b=bhMqGJYLYdn1uoIPsbgfqOSffC0i0kUA7YXt6nqNbh9wgxVpgaebMpbIS1l26VyCJ1
 uKOk0R9LDR2y3GwgSFJLqswiXMaliFe30suh8wMmAMPrCkQapkG8bICtpkpIwMEQ0hm7
 h7BYHFYG11Tedf5WYGwRm0rgkQUrQtAlHGH52I5JiGICm2mve81yBPAjWSIsbysMHl5W
 he58pxyHD1vG7ZtUYZE0HOf1EY3FzDI8vXk8YKIZSGu/jElevWVZsDy5X26oMLxYur4C
 WrmCpVekx2yytUQKq8hLcpY5kYfyllm3FOIpwwIqxM9THQWv/nGlfu/WS8Ia7/QcQshX
 dZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XvJsVfQVMx1/qqFKk/K/i5edij8GiQUxYcPFjKzVNws=;
 fh=IePNdqEd92+eyPK3ZbFLaGNL1t1V1uwZTjI0C3ChhjQ=;
 b=QXYgWb5OAL0FDLYeaPArAevus7r+M8pW1ZNDPYbGmCB951Z991ZVwsQ5p4/2BYC79n
 v3wkQ+459FxSb/qG+ruDEL2u8HC6eN+bjm3aRBZk8A5mcU7pKN188k/iPqjWkbc829T5
 A+6aVKZpuPkqXlDmoXXY9jQepyA56eKXbgggzBwALTq56W3vxthL0ytqg03RbJjOypUw
 QJxHQYpNcGA+zOivpFrtuX2W8Ds1YANDYQ4G5OSqKs4f/oV6jVjqywhLYHmr1RzgNoas
 lEs7NnJBTTy+kHFMEsWOanvY9E6qYVrM6WylefNgUigyJE8sNQM+49187VrA31aTcV4B
 3mmw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789758931; x=1790363731; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XvJsVfQVMx1/qqFKk/K/i5edij8GiQUxYcPFjKzVNws=;
 b=Bq96xx+CS6niqKJ/GQfskNuyPpwdGpKo+pV3vfg6Ec0UvsjiyMyN7tVNVvndHd0D6P
 YN7QRZTVYl6WA/HPF1yK7gRoSJfZuRfbJBDV4MHUjX8kKxYlXWZov4M7rHJXaQicyACq
 vJI7k1wHb8m7yHsFr02cz1iIAQi/znBhz9vgeZCtGb7nOpcTMrFTVLnDvp86IeXFS6aF
 wAPl/1VNhIiW6nwVOs3UazKbsXx9XxIOof7wuh897Sw/69CJYxhFcoZELa2I/tt/b8wz
 VzwWsgp/Y9FdD5e4PLqRjdjrnTynWlRGaZI3BlijhyRrPs/MzNBETnlkVhcglHgSBtRb
 iN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789758931; x=1790363731;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XvJsVfQVMx1/qqFKk/K/i5edij8GiQUxYcPFjKzVNws=;
 b=aoSxtpj+KVw/8OUcLgjraz/08lx9y9+1M0GYCxvjP+cRhxTt+ccw3yyUywe1P0TJKJ
 w9f2PuuZu3udBtmw72Pq4NLGbGWGK9ro04I/YqwhT0Dof3hd1NKkBwdx54ZLLSPM+e0x
 P61mEjX2ieJgFoIHccQcVMukcBD5Kn/yDpM0XrK+a1Hmi17MhL0+kl2gaf318o+cEg13
 DQYa1AjHdozgAquSccz3JSWNqOz7uocDYNlq+zsW/NspOGLVUCpYHNWx+S7YX3DhZ4DR
 s/fA1zYPAk9Nsc8elV3yRM0NQ5f1n0iwvQT3dU98TRuvHxpU4TD6oPtTlY8ZR53knOO7
 Enew==
X-Forwarded-Encrypted: i=1;
 AKwUvBwn7ym/d6r/X4j6otQhAvSlNfs0fLC46aP/9juRqYg+D6MqGGkcO0mrVIW89jC/Gituspr2hEjDgBY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++moLUiOLrlMzvNTg92h2zFLoK2NiMn3eIDAb4XkRLGmABfc7rnT
 jDoiHM+6ExMInaj3aiYfmKW41vynv3eK++ruQuq0iyK4YCWuOnTK4S0ljwPBY320iI9q/3JkFW1
 l/KoSGj55LHDUnyv5RkrMvRGKC5ffH3s=
X-Gm-Gg: AYBFou359rVGBGVgSRlwH7w8InpVd4+hQ+HGjgDMVjOuaZCZjkJZbWcDeoqRUm9/UBC
 O61NcGcPB6fFEv2tv0xta7JyeuDqzqBqrMXjLcCTopTPmtskQagy+cYw6JFCJNKDUOyGdjMbEbn
 ZltKTqiwrfC3u3MhoW5M5bvA53r8jOFsoW+tmxvgzZ8u29tbfftvaqSdOrrBFeziJhf+pworgI8
 S7l/72WlrUdD89YcKyzEkPTsyMBB9wYKdsQ3CFLZmRfH8rw2oP8hfQeoQQF4ceN922w2Lpi0ctj
 Lg5VRTpfxHoMr26E7Il3FaubwbytVE8ybcbTJoIQpxhlb/1CUWvWPOTio9LuVq32z7Nasr/Ydqa
 QpV/AGRS35OM//vac2vNUE6r2iY2TPbZ5HCqej1kwsmrUmb8=
X-Received: by 2002:a05:6871:cfc6:10b0:487:958f:e35b with SMTP id
 586e51a60fabf-48795900e6amr1424971fac.34.1789758931211; Fri, 18 Sep 2026
 12:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260917135051.47683-1-tano.dzhinski@gmail.com>
 <20260917215114.1136715-1-tano.dzhinski@gmail.com>
 <f8a34420ac2bfadda23ef6812933ae64510972e4.camel@redhat.com>
In-Reply-To: <f8a34420ac2bfadda23ef6812933ae64510972e4.camel@redhat.com>
From: tanodzh <tano.dzhinski@gmail.com>
Date: Fri, 18 Sep 2026 22:15:13 +0300
X-Gm-Features: AcwNN1WoeEiIJqasT-7K-vP0zJa-u7OJgPUeY7USwoX3XqPRXTuUa60V6-sDLws
Message-ID: <CAJhzm--KvAUbTxpMMmy_ye4mYfJOViHJ21SNONqdy_Ab55oXPA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/nouveau/disp: don't reject HDMI config on cards
 without SCDC
To: lyude@redhat.com
Cc: Danilo Krummrich <dakr@kernel.org>, Giuseppe Ranieri <giuseppe@ranieri.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

Sounds great! Thanks for the update.

=D0=9D=D0=B0 =D0=BF=D1=82, 18.09.2026=E2=80=AF=D0=B3. =D0=B2 21:21 <lyude@r=
edhat.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0:
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
>
> Will push to drm-misc-fixes in just a moment, thank you!
>
> On Thu, 2026-09-17 at 21:51 +0000, Tano Dzhinski wrote:
> > From: Giuseppe Ranieri <giuseppe@ranieri.dev>
> >
> > nv50_hdmi_enable() passes the sink's SCDC capability from its EDID
> > straight through to nvif_outp_hdmi(). On pre-Maxwell-2 cards there is
> > no
> > hdmi->scdc callback, so nvkm_uoutp_mthd_hdmi() rejects the whole
> > configuration with -EINVAL, and nv50_hdmi_enable() returns before
> > hdmi->ctrl() runs and before the AVI and VSI infoframes are sent.
> >
> > The result on such a card driving an SCDC-capable HDMI 2.0 sink is
> > that
> > HDMI audio silently stops working. Video is unaffected, and nothing
> > is
> > logged, which makes the failure hard to attribute.
> >
> > SCDC is optional, and the hdmi->scdc() call further down is already
> > guarded against a missing callback. Requesting it on a card that
> > cannot
> > do it need not invalidate the rest of the HDMI configuration, so drop
> > that term from the condition and let the existing guard skip SCDC
> > alone.
> >
> > Fixes: 6c6abab20b99 ("drm/nouveau/disp: add output hdmi config
> > method")
> > Signed-off-by: Giuseppe Ranieri <giuseppe@ranieri.dev>
> > Co-authored-by: Tano Dzhinski <tano.dzhinski@gmail.com>
> > Signed-off-by: Tano Dzhinski <tano.dzhinski@gmail.com>
> > Tested-by: Tano Dzhinski <tano.dzhinski@gmail.com>
> > ---
> > v2: restore Giuseppe Ranieri's original authorship and Signed-off-by
> >     (he posted this fix to the nouveau list on 2026-01-17,
> >     https://ratatoskr.run/nouveau/2026/01/16963412), per Lyude's
> >     review of v1. Added Co-authored-by and Tested-by.
> >     Tested on GK104 (GTX 670MX) with BenQ PD2700U and EW2790U.
> >
> >  drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> > b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> > index 377d0e0cef84..9887b3898505 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> > @@ -253,8 +253,7 @@ nvkm_uoutp_mthd_hdmi(struct nvkm_outp *outp, void
> > *argv, u32 argc)
> >
> >       if (!ior->func->hdmi ||
> >           args->v0.max_ac_packet > 0x1f ||
> > -         args->v0.rekey > 0x7f ||
> > -         (args->v0.scdc && !ior->func->hdmi->scdc))
> > +         args->v0.rekey > 0x7f)
> >               return -EINVAL;
> >
> >       if (!args->v0.enable) {
>

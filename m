Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CD2C55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAF1310EC88;
	Thu, 30 Jul 2026 01:42:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m8stWmLR";
	dkim-atps=neutral
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B1DF10EC88
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:42:13 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-8ff5d1b0f91so11290906d6.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 18:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785375732; x=1785980532;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OsIxvN6RYD4nfvmijZC7KmHewLJtuir0RPF6x5FglYs=;
 b=m8stWmLRXXPqQCTdAPLOPlPDhKWrnRWIpDhSk2KidlPKfEibr73O4nXt2qPuoS2AaG
 +MzwE3daAw2JXgbZyZc/5BuIXv88lgCxyR59u33+raSUnnRETATD7Q7piUyF48Jo2Kcw
 x7K4Ksu9Pwd6d60ITMMfJRu9mdgRzXCybC7+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785375732; x=1785980532;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OsIxvN6RYD4nfvmijZC7KmHewLJtuir0RPF6x5FglYs=;
 b=ImFjz4X8Mze18RiAs1fAAkJAXLqD8Ah9wSiI1EH8aGKRxyJpoRWNU9NDoEwczff1lV
 t5aJqYKqpTxEdShuM9A9u0JPvw0ETOtMVejblGTK5WhL9tzVvCGejGGzePbFtaOWTulL
 ZzpMipLtWvE4lO9hRm0m9YJWsgke1FrisG10lzrmV9BcKL0fycrIwc/CurWBULOGCTsC
 k/ocCVoh7kYLa8Z8ErCg0fnmMS53Nk/qP4/0lRkt4TVkfyLFFEnJHB7fsfTn8sctaUcD
 veKVKRpMBjxU/t62TU0sMrsj3o1zwP7ubTlLbeD2h8ZOy6fhGVV4IRGYHaiSFhBqqou/
 yDFw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrpiBpxgTppv4jrChAfIwVNeEeQA4raWb7Ex7HWILkjAbzG5B5Jfcwi+sWPGbp8Pve2ojNeKDTJCfI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywcwf8bIAbmrdnZ8YY3MHpFN0nKQSmAYRStI/WkKHjMwH8gv9LM
 mZBfTOfx3CrIdUvbvSbJ8wvfvtJHRUsOb2H8BnmAIQStor97eub9dO3JmHHULRPNV6DIiptIYnO
 oRP0=
X-Gm-Gg: AR+sD12Zo27HjaShoEGDtyLe+CdNT1gLytJEPHpW9h3fsK/KtmEtyfkOoOG+2K26EU5
 jsmRzvOTQNxQMqVo/RTGiuBVohcRWbGaSGwkt67e+nbo5PzRVC3QfJ+9kSObkOh4k08PPMYu6p/
 +vrfvf9Xdw/xoAI3lAVK28y4ujL8+3SBnFTPBh49oTHyc1PAEmUWm78SGmIIcaTnUFQgom+Nd2I
 pnHF+x+ic2yg3CzN74hgwRHfmB5U97CELGvYOiMP3VvCOZ4N3zxtnYnFIwwDZdPSd2G7+kdPUSk
 pyTlYIG1EvfI5/lBdIclWaXalTrThbvFNucN9oQdM2ETnlkTd4M4+sj4//u+R09qzHOJHTD4kD4
 hzrb91SGdDsAoBLKLmbCKclo7ZneFXjHNsyP8FT9BeudwVoXIWO4r0LA+BhVpLz5HV0MiFofG+P
 DffBkt8x0pGbxLze2v2WdYYC7eSy2MAiQ3Cz9q6Ee8rv8WzQMeZilxWVB5fLc9imBHDnpaBlxDp
 yLFEY3WkYn34IZ898okUv+7zyv67FI=
X-Received: by 2002:a05:6214:3a85:b0:8f2:fbb1:cec4 with SMTP id
 6a1803df08f44-908346f03b8mr5884496d6.19.1785375732070; 
 Wed, 29 Jul 2026 18:42:12 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com.
 [209.85.160.174]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908324f332esm4885376d6.33.2026.07.29.18.42.09
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 18:42:10 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-51c167c58f2so10938491cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 18:42:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RqvquNw4HVWKQIEzDHEKcWhEHg3tEHOLvVCu3oONJtmvhUlIsK7ar1Re/MmjE2/iz8C/1O0yYZFcdM=@lists.freedesktop.org
X-Received: by 2002:a05:6214:2c13:b0:8f1:8349:59ee with SMTP id
 6a1803df08f44-90834796b21mr5518286d6.35.1785375728810; Wed, 29 Jul 2026
 18:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260723103509.2-ps8640-v2-pengpeng@iscas.ac.cn>
 <c1cfe79fabe97b3d1603a4fa064a18afb7d6810b@intel.com>
In-Reply-To: <c1cfe79fabe97b3d1603a4fa064a18afb7d6810b@intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 29 Jul 2026 18:41:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wo-ps+aStGn5vCvb08tKx-rKDeu-r0bRVABL8zgg4Lhw@mail.gmail.com>
X-Gm-Features: AUfX_mwIfUVkQozFkM984R32bwex5z7xEp6Iay9mTMXKPubHDtNpAoYdfi6AbZ0
Message-ID: <CAD=FV=Wo-ps+aStGn5vCvb08tKx-rKDeu-r0bRVABL8zgg4Lhw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: ps8640: propagate AUX transfer register
 errors
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
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

Hi,

On Mon, Jul 27, 2026 at 4:40=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Thu, 23 Jul 2026, Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:
> > ps8640_aux_transfer_msg() programs the AUX address registers, starts th=
e
> > AUX transfer, waits for SWAUX_SEND to clear, and reads the AUX status
> > register. Several of those regmap operations have return values, but th=
e
> > function only checks a stale ret after the status read.
> >
> > Propagate failures from the address write, transfer start, completion
> > poll, and status read. This avoids returning a transfer length when the
> > bridge register transaction or AUX completion wait failed.
> >
> > Fixes: 13afcdd7277e ("drm/bridge: parade-ps8640: Add support for AUX ch=
annel")
> > Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> > ---
> > Changes since v1: https://lore.kernel.org/all/20260623060635.16064-1-pe=
ngpeng@iscas.ac.cn/
> > - include the AUX address and length in the address-write diagnostic
> > - describe poll failures without assuming that every error is a timeout
> > - add the Fixes tag suggested by Doug
> > - rebase onto the current drm-misc-next tree
> >
> >  drivers/gpu/drm/bridge/parade-ps8640.c | 27 +++++++++++++++++++++-----=
-
> >  1 file changed, 21 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/b=
ridge/parade-ps8640.c
> > index 96332721cb69..56b48f8feab6 100644
> > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > @@ -257,8 +257,14 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_=
dp_aux *aux,
> >       addr_len[PAGE0_SWAUX_LENGTH - base] =3D (len =3D=3D 0) ? SWAUX_NO=
_PAYLOAD :
> >                                             ((len - 1) & SWAUX_LENGTH_M=
ASK);
> >
> > -     regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, addr_len,
> > -                       ARRAY_SIZE(addr_len));
> > +     ret =3D regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, addr_len,
> > +                             ARRAY_SIZE(addr_len));
> > +     if (ret) {
> > +             DRM_DEV_ERROR(dev,
>
> DRM_DEV_ERROR() is deprecated in favour of drm_err() or dev_err().

Good point. I'm inclined to land this anyway, though, since this is
nominally a bugfix and it matches the error printing in the rest of
the function. Any objections? It would be a nice future cleanup to fix
the error printing in this driver overall to use the non-deprecated
functions...

-Doug

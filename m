Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFC4C54FCD
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C23510E086;
	Thu, 30 Jul 2026 01:38:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kRCwUDGT";
	dkim-atps=neutral
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 007D410E086
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:38:25 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-51c08df8513so9951151cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 18:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785375505; x=1785980305;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P0s5qkaQbJtwn9wO/pBIXbTJTF7WUgw+n+4dNiFb+hA=;
 b=kRCwUDGT8Hhm+mrPjsSWBZyGjhTjD+ulBXSLbKXRP8HxaTGlY0nEEFk/EYMcL3eJje
 HiUVhxf/3Yb/immKVnegQRBNzO62swkeWpyfbXsJ7gTmSoIKXVEoHLo4xQJdOlduIINZ
 YT8sKhG7rPwpU1LZEnyw6cUQFqUbfNOSqo/4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785375505; x=1785980305;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P0s5qkaQbJtwn9wO/pBIXbTJTF7WUgw+n+4dNiFb+hA=;
 b=qgsGQKSVkYyfmb91apeLynu3Iatyy8b/xtpUWQTpNfSq4pmhudU27O7/Tm5bcCLUew
 Jz5fcZr9xtg+8mDBClJH7cEldMCAkBQOjQ4eYeKcePlFAVqCSMUW89KrzAy1pmR8vClL
 JZGYcy0H+Lr2Gsyqg0A9jzHDBO9c2KwHPE4cK/2vDJODKZuH9cDUXFUu2w9PAy2yowoc
 qZzY2awGCVrk7UluMDPA/5NNYFC+WECoonz3+IukPqEH6z86dz/+LcAZJd1H3Jzn4+Xg
 tDeq7/yOwf/DfN7TuJ0WKgjtTs81IEy3MRRpWmOQIRkmXrWmbW5mldimFy5AFRLf1Rm5
 0/nw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/YFzyuOG8x4xyI0VjHOIKkzuS7aGo+2Eazc22E3lNOwAHR8IXVVPrXmO/PsRKd835DuzewFtuF6Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFiUD8LpPZCPaJoyogwqgT+Ut8e2+lntf0SKnmidaHbLRYW2Z3
 T5oMX8B1Qcq1mA1jkvF/9r9PYlIXBBAgDGQTt8G9iuCQqNhN/nGAXwhWdOabdRTBcuc3V82LmL4
 PdQw=
X-Gm-Gg: AR+sD10Q2EmnilKfNqvFcovn0aexy7BslIqdEJPCm3wnJDsErXpfvay/CuHiVoS+VBZ
 rB+//ZcDoznm5oOe4f6rXH2lfMGYFcTiPoWC/d9EqIRvN6+Eiv869c9vxCMU+91N81Vgf5QL5uB
 bCpIlX+4e1WaRF33LP4CZkfgeEDfQXiG9w2P43uaL98YXO+CqlXpZIxI1adPx/GUqbfGe2YwL1w
 nraz8D9Qu5u0itj5Q89GzgD697kzLaIq/oX2jxgiP2PZr53uvFbyM2xX7oWBnxG/qbOlJ3Jjp5p
 bngb6Mn+0wV4qrZK0Uo6NKZlKElDkczRXYLTNEg683hzN4W3apqFbVvbUJyk8auLwt9mCdSEExc
 c9ZtN6buyGJEu263ijcZw4FukpxEasfOmpidxSZ1lefZB8qZVerTRDWiteeE2feUJbefWvHy5PG
 sPFmbYsRRln+D1/oC/Sezhn0tNcfpdfnTN3+eROFrR+8l5VDN/nsTPUGw5ShpyT5vl4foR+iKZt
 6iBq/sOUQtBGXfED+L0foGdo7I=
X-Received: by 2002:a05:622a:40cb:b0:51c:f3e:7819 with SMTP id
 d75a77b69052e-52b384c7f4emr9619711cf.39.1785375504823; 
 Wed, 29 Jul 2026 18:38:24 -0700 (PDT)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com.
 [209.85.219.43]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529e2b649b9sm31716641cf.11.2026.07.29.18.38.23
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 18:38:23 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-907ae240ac3so7998186d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 18:38:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5chAzEkk00Z/nfMYJ1J9bH0janADk6U432Ud1q8yVGxxXH+S3G16vbLlIikQRCjhMsCfvCh8VWxo=@lists.freedesktop.org
X-Received: by 2002:ad4:5dc1:0:b0:907:44ac:7d12 with SMTP id
 6a1803df08f44-908345e75bcmr6070656d6.0.1785375502283; Wed, 29 Jul 2026
 18:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260723203601.806697-1-michail.tatas@gmail.com>
 <CAD=FV=X+0_oVB2oHg=R+JAyFZFd2EXWAVhHv5oX6QGjB0RCKUg@mail.gmail.com>
In-Reply-To: <CAD=FV=X+0_oVB2oHg=R+JAyFZFd2EXWAVhHv5oX6QGjB0RCKUg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 29 Jul 2026 18:38:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V6i=HqufCucNnx9JYeveGfeGWTcZRgrFqd237g1xS7dQ@mail.gmail.com>
X-Gm-Features: AUfX_mx_jy2X5-MAlFzfXkHLHAxLnPSqT7CngwkFYGhiHFvMtcXWebNKj0uT6qI
Message-ID: <CAD=FV=V6i=HqufCucNnx9JYeveGfeGWTcZRgrFqd237g1xS7dQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] drm/panel: ilitek-ili9805: convert to *_multi API
To: Michail Tatas <michail.tatas@gmail.com>
Cc: michael@amarulasolutions.com, neil.armstrong@linaro.org, 
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
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

On Fri, Jul 24, 2026 at 7:15=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Thu, Jul 23, 2026 at 1:36=E2=80=AFPM Michail Tatas <michail.tatas@gmai=
l.com> wrote:
> >
> > This series converts panel-ilitek-ili9805 to the
> > mipi_dsi_*_multi helpers and cleans up the resulting code.
> >
> > Patch 1: Convert the individual DSI calls to their
> > *_multi variants
> >
> > Patch 2: Replace the ILI9805_INSTR table with per
> > panel init functions using the *_multi API, dropping
> > struct ili9805_instr
> >
> > Patch 3: makes ili9805_power_off() and ili9805_deactivate()
> > return void, since no one checks their return values.
> >
> > Michail Tatas (3):
> >   drm/panel: ilitek-ili9805: Use _multi variants
> >   drm/panel: ilitek-ili9805: Use dsi_multi in init
> >   drm/panel: ilitek-ili9805: make cleanup funcs void
> >
> >  drivers/gpu/drm/panel/panel-ilitek-ili9805.c | 212 ++++++++-----------
> >  1 file changed, 87 insertions(+), 125 deletions(-)
>
> Thanks for the extra small cleanups. Planning to apply v4 mid-next
> week unless something comes up.

Pushed v4 to drm-misc-next:

[1/3] drm/panel: ilitek-ili9805: Use _multi variants
      commit: fdde70f52306f74c7f2466706626f3f1ef973e61
[2/3] drm/panel: ilitek-ili9805: Use dsi_multi in init
      commit: 438caed529a6b6dd985afc85ee52a29bc20ab3f6
[3/3] drm/panel: ilitek-ili9805: make cleanup funcs void
      commit: eb7979f6014a18f7086ecbb70da3e442056b5673

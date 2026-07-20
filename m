Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDE9C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:05:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A152610E109;
	Mon, 20 Jul 2026 15:05:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jXljGms0";
	dkim-atps=neutral
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
 [209.85.217.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D9C610E109
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:05:11 +0000 (UTC)
Received: by mail-vs1-f51.google.com with SMTP id
 ada2fe7eead31-7380954d1c6so3367097137.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784559910; x=1785164710;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DzQyYANNjq+7VySreA3Am+Pyxk37p/vOEcew0s14qEU=;
 b=jXljGms04apYzdwqa2G5Ozvru/qX+lYzsuTgVaOARw/cF9tZHcYyi6/T+cFDS2S2Bo
 ueTuTadVeqSZ9gcvDEGLJxZcLFHVL5Q7XqhMH/h8LcPKFvDNsv8u8Xc7tSkKS9DQaRzW
 p/XvpR1c00nxsHqSL/eTkk2LJWwRJyNz1GxSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784559910; x=1785164710;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DzQyYANNjq+7VySreA3Am+Pyxk37p/vOEcew0s14qEU=;
 b=CENOeyQwASFYBFBvZHPQ0Ros9BZeZSguZkLzyp2UNp1gk6EZgQx4g2v5gdetvauUv1
 dRywATOe1FAfQJmkdPMKtSzOuuKvurvEFaPVSqs5PtsO1CdHd3LkVPrGk2bxeJp7RDMi
 YDJ2Ycr4eTqk6sVTMAHklbhxxg4Y5wwQedueTm3l90UH4gM02f13eO99c6cIEkHX7qew
 CAubP4nrmLpBZioFDAZqSBclAiYMQADtmytsdvFTpeTri3orrxMm9fqCv9Pw9fY38YIc
 oqoYJWKUo9oKgM5o3hhJ0A+C7k+fIhj2XvTR6FtHfpW9s5T8NqOdW6aJvOsnuCNyTb0x
 YkxA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrqFdnz/YkhCPTwfqXyKPH3L/j4JY5Pt82Q2e/j2nvnUhNdhy3Zf8y2/Cq1DKRt+mxzXrFJ0s7nxVg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDux7Xq0vIOgU2FFe6vNzxCCI+ZOREEwD7OUR9TeI1NIhV3Pru
 TmNlVeBeWyWP5ujJ/uX9oMRISyXPmT52M3rEjLCaAVFs1uswKAuEUQtFJD/6ztQDJpiig6BrSQK
 8pyU=
X-Gm-Gg: AfdE7cm/bpDCnupwFWreBxuyI6a059D8wVKKWnmippqcmyv4saT2GbC2WoesPZcrwMS
 lt+WXqh+6iPCuPpRE0vAV+wX3QY0AbYw5RZ0XdhLM4xfLbVWJVDTrgvOiNz3hEBCo9cX1DL2lLZ
 CoiWv+0MCcl7SuUzEAI7b8Jf0PZX31k/7yfMOdofRHm/RJUf9/OZh886asVEEiPWfOdILxi6b8S
 EacD4+HzawXibvr3LucXFnoPpr2uUGFQ9gVC7G5hTKQucNAkAkju/hhiSkwYg8UbGmrCuYOuSpC
 AFqUUaO819UqlamOefPMurhetUczMnNJw93on0M02jUNfVJoB0epKjCo0wYALJMLiedQWjTdpJF
 dqO+sLWQjQ6eZFkjrtDkMa3B99h+al7yRsdOGEUd9FS0nY1XW/WE4jmQSBn7MRXIQAYMPgTWIZv
 rMq8/V5Iolm9HphyKb5gpCX9kO0Zb81rZTpMDh+bEAerXM
X-Received: by 2002:a05:6102:4422:b0:739:4470:d8 with SMTP id
 ada2fe7eead31-7475373cbc4mr3146514137.26.1784559909737; 
 Mon, 20 Jul 2026 08:05:09 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com.
 [209.85.221.171]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-976fc65cd25sm7996877241.12.2026.07.20.08.05.06
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 08:05:08 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-5bf5370d38fso3836397e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:05:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rqi0Wcu894XeJeU3mYRY1krQUQwMlQWZCTsOShkRMqSpYxIUtXZf6cZBm0cgtceW2gtNRaGOOVkOWc=@lists.freedesktop.org
X-Received: by 2002:a05:6102:3751:b0:73f:7bca:217d with SMTP id
 ada2fe7eead31-747536f091bmr3604840137.20.1784559905013; Mon, 20 Jul 2026
 08:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260623060635.16064-1-pengpeng@iscas.ac.cn>
 <CAD=FV=Vx=q_TzxGo3j+fKVRi9p4ih0kMmUY0MM6GfL+2-a7vHA@mail.gmail.com>
In-Reply-To: <CAD=FV=Vx=q_TzxGo3j+fKVRi9p4ih0kMmUY0MM6GfL+2-a7vHA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 20 Jul 2026 08:04:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V4aZMcSr48OkMfFxSdhgNnTDE+r9EWKZyviwbcb=7+qA@mail.gmail.com>
X-Gm-Features: AUfX_mxInmJ_gnwYR-eJCGh3M16yyoeGn1S2MPvws6-XV2cLQy1Q2KcHka1KVFw
Message-ID: <CAD=FV=V4aZMcSr48OkMfFxSdhgNnTDE+r9EWKZyviwbcb=7+qA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: propagate AUX transfer register errors
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
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

On Tue, Jun 23, 2026 at 10:17=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Mon, Jun 22, 2026 at 11:06=E2=80=AFPM Pengpeng Hou <pengpeng@iscas.ac.=
cn> wrote:
> >
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
> > Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
>
> I think we want this, right?
>
> Fixes: 13afcdd7277e ("drm/bridge: parade-ps8640: Add support for AUX chan=
nel")
>
>
> > ---
> >  drivers/gpu/drm/bridge/parade-ps8640.c | 24 ++++++++++++++++++------
> >  1 file changed, 18 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/b=
ridge/parade-ps8640.c
> > index b93514023baa..bf5a36e76c56 100644
> > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> > @@ -257,8 +257,12 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_=
dp_aux *aux,
> >         addr_len[PAGE0_SWAUX_LENGTH - base] =3D (len =3D=3D 0) ? SWAUX_=
NO_PAYLOAD :
> >                                               ((len - 1) & SWAUX_LENGTH=
_MASK);
> >
> > -       regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, addr_len,
> > -                         ARRAY_SIZE(addr_len));
> > +       ret =3D regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, addr_len,
> > +                               ARRAY_SIZE(addr_len));
> > +       if (ret) {
> > +               DRM_DEV_ERROR(dev, "failed to write AUX address: %d\n",=
 ret);
> > +               return ret;
> > +       }
>
> nit: Include "msg->address" and "len" in the error message?
>
>
> >         if (len && (request =3D=3D DP_AUX_NATIVE_WRITE ||
> >                     request =3D=3D DP_AUX_I2C_WRITE)) {
> > @@ -274,13 +278,21 @@ static ssize_t ps8640_aux_transfer_msg(struct drm=
_dp_aux *aux,
> >                 }
> >         }
> >
> > -       regmap_write(map, PAGE0_SWAUX_CTRL, SWAUX_SEND);
> > +       ret =3D regmap_write(map, PAGE0_SWAUX_CTRL, SWAUX_SEND);
> > +       if (ret) {
> > +               DRM_DEV_ERROR(dev, "failed to start AUX transfer: %d\n"=
, ret);
> > +               return ret;
> > +       }
> >
> >         /* Zero delay loop because i2c transactions are slow already */
> > -       regmap_read_poll_timeout(map, PAGE0_SWAUX_CTRL, data,
> > -                                !(data & SWAUX_SEND), 0, 50 * 1000);
> > +       ret =3D regmap_read_poll_timeout(map, PAGE0_SWAUX_CTRL, data,
> > +                                      !(data & SWAUX_SEND), 0, 50 * 10=
00);
> > +       if (ret) {
> > +               DRM_DEV_ERROR(dev, "AUX transfer timed out: %d\n", ret)=
;
>
> nit: not all failures here will be a timeout. Can you adjust the error me=
ssage?
>
>
> > +               return ret;
> > +       }
> >
> > -       regmap_read(map, PAGE0_SWAUX_STATUS, &data);
> > +       ret =3D regmap_read(map, PAGE0_SWAUX_STATUS, &data);
> >         if (ret) {
> >                 DRM_DEV_ERROR(dev, "failed to read PAGE0_SWAUX_STATUS: =
%d\n",
> >                               ret);
>
> The one above is super weird since we clearly meant to set "ret" given
> the error message. Not sure how we missed that originally. Oh well.
>
> In any case, the change looks good to me, though it'd be nice if you
> could spin with slightly different error messages.

I was assuming you'd send a v2 with the above nits fixed, but I
haven't seen it. Did I miss it?

-Doug

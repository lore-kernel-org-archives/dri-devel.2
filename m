Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1634DC5516F
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72DD010F2C1;
	Fri, 31 Jul 2026 14:43:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UYBKq6oz";
	dkim-atps=neutral
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B48E10F2B9
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:43:43 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-92e50a650a0so53825885a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785509022; x=1786113822;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ANysXUr6RG+NBEAOxs7kvNYYbqp8hKotEYIvbaspU/w=;
 b=UYBKq6oz6vuXCEmYHg6Go60GOGpNoGbQ00szkGCaSXCAgvnS3ZiEyPooFV7sGEgDuR
 tp33IUXvDDmkPwvBdF12tS/9Nlz2IOsWcPUOvHaFwy/PlwnjqhjS/PViJKry1QXzFP6S
 oCFSXOFwlsVR1IgYH2w8Q52qXsRMwyLtqJP2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785509022; x=1786113822;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ANysXUr6RG+NBEAOxs7kvNYYbqp8hKotEYIvbaspU/w=;
 b=D21mD9NYxwpa5D1VJ6vGSzejKkyPO6gaUEwmWu87ZuZBo0kziUNKrV/bapeWcdoCXF
 C2TO1OyO/hPMPEoPoreJC38kFYZi1lsDh5eMQsnxfuGF946S/IJ/Bhqwgpjr/Hk+7N7S
 Iv/gCc2+/pTlMU7qKMBK7DonpGSn+FZuLNrcNtPnpoEOQmZ/sRvKxTyKE7kaSA2dxwU+
 34Jsjy5DiK3pGxy/ABF+ejSAI/8JzUUjy4TjFbpjl+tWnQLvMol257Ae8ClxMTgAWVN/
 qhO48rdGdXC2x01WzmCfkLHWjodrwegqXSsXeHuMhWcvOKqNVY4ZuhKK3mDX5l0npewb
 MsxA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0Zq4Hp0//+mKH+4hvOmEkXRHTy5W8qXHCG9OgUtanfsdoYnWx3+8aYPrW/rX3n+MhePwhe/4Kubo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxC61zsXi2h6AaPL6zZxDIMcKx4CoNyoBrZlum2sfmuntc8dL3n
 geBKrh+mal4YMVBLLYqqY10Epmd6r/SnoZamUzETjtkuKQQ8L18eRdSQVRXMVhBQG4Hj+lAKH9o
 KXVk=
X-Gm-Gg: AR+sD1089OYbcbRwhohX43BhHXt4OoXP/aopZtB2sHH9stxtJ/sAy2zQzaGzK7JVXBu
 JEe9kicsEo0aC/ZS0IKVwSYrQ2QutexJgAalHk/ZrQcpAjY0OSTRyQwVJt5AtQXLNDBhzqDTIz4
 +NICRnJwI8jgs4VowML65o6ykxdXjIUKSz1+fHyI5QDF6Tb4cRw/X8EY4PIGXm0ilY+uHzv5MtT
 b79ffM8UBDGNN5HixHCKOjNON5pRB9lnEVXBmEuritS/tB83I+PU9bSKOrM882IGzJQf4dpNUS5
 SWmIC95wvusuyRZ1rAfW//3HyuwmUscjvLAVX4IsXpceOyNhUt1pb2yBtKX+dpsGoDX18jhhkpI
 KPPSk/ASeN9NlUfjBJcq8hxO1E6sbWRsMHXJBUkTse/pugKuo7bUrLTYMuLyUKiXIqvVjcrgrkF
 O6cbIjhwj51rdSvnYEBf53zMqvF18zZlgK8rvnwvRz3hvzekBDbq7ySmloFCfvk8dlPQGQ9GYFj
 oTQ3vy6f4y5GIidmWo6co7Y75C/zwg=
X-Received: by 2002:a05:620a:290e:b0:92f:d3:1d29 with SMTP id
 af79cd13be357-934a07501d8mr38549485a.3.1785509021595; 
 Fri, 31 Jul 2026 07:43:41 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com.
 [209.85.221.171]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9349c1998f3sm68079385a.27.2026.07.31.07.43.38
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 07:43:38 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-5c2ae02f69eso773838e0c.2
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 07:43:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RphTbwQzJKIyjDxpuEHTGfJh7ciROyv3f4ajWy0G71i+3eUY6bnsJoBDQPBgxBMJGu/c+DqukttJ30=@lists.freedesktop.org
X-Received: by 2002:a05:6122:e187:b0:5c1:1dac:45d3 with SMTP id
 71dfb90a1353d-5c38786be2amr89741e0c.10.1785509017205; Fri, 31 Jul 2026
 07:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260723131649.134127-1-panchuang@vivo.com>
 <20260723131649.134127-11-panchuang@vivo.com>
 <CAD=FV=WPC92HLyRbo72KK5E9jTQ2TZN9F9gogZk7oNfpat4YRg@mail.gmail.com>
 <CAD=FV=Uud3YA_eQ12SM9MUSLQSmzDY1f_V0HnSCUUXOHSY1aDQ@mail.gmail.com>
 <DKCKLKB5PQRX.5J3QA5DIEMK@bootlin.com>
In-Reply-To: <DKCKLKB5PQRX.5J3QA5DIEMK@bootlin.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 31 Jul 2026 07:43:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VELor3eGb0FgtKS5isXw2ARKAb4vJckLcsC20EzA=AZg@mail.gmail.com>
X-Gm-Features: AUfX_mxp4hRroPWGJY3h31v32jD1laQy2JQG5l-5JvgoQqL6yu0ilQARxL0hp0s
Message-ID: <CAD=FV=VELor3eGb0FgtKS5isXw2ARKAb4vJckLcsC20EzA=AZg@mail.gmail.com>
Subject: Re: [PATCH 10/10] drm/bridge: ti-sn65dsi86: Remove redundant
 dev_err_probe()
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Pan Chuang <panchuang@vivo.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
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

On Fri, Jul 31, 2026 at 12:16=E2=80=AFAM Luca Ceresoli
<luca.ceresoli@bootlin.com> wrote:
>
> Hi Doug,
>
> On Thu Jul 30, 2026 at 11:17 PM CEST, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Jul 24, 2026 at 7:11=E2=80=AFPM Doug Anderson <dianders@chromiu=
m.org> wrote:
> >>
> >> Hi,
> >>
> >> On Thu, Jul 23, 2026 at 6:17=E2=80=AFAM Pan Chuang <panchuang@vivo.com=
> wrote:
> >> >
> >> > Since commit
> >> > 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_i=
rq()"),
> >> > devm_request_threaded_irq() automatically logs detailed error messag=
es on
> >> > failure. Remove the now-redundant driver-specific dev_err_probe() ca=
ll.
> >> >
> >> > Signed-off-by: Pan Chuang <panchuang@vivo.com>
> >> > ---
> >> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >>
> >> I'll plan to apply this to drm-misc-next in ~1 week unless anything co=
mes up.
> >
> > Pushed to drm-misc-next:
> >
> > [10/10] drm/bridge: ti-sn65dsi86: Remove redundant dev_err_probe()
> >         commit: 9c950822f0fa923ccd344d7a143872d25efe89a3
>
> Out of curiosity, did you apply using b4?
>
> I see the commit does not have the R-by I gave to the cover letter a few
> days ago, and assumed b4 would pick it up as it does when applying the fu=
ll
> series. If my assumption was wrong, maybe it's an issue to report to the =
b4
> project?

Oops, sorry about that. I actually found your response to the cover
later as I continued to work through my inbox backlog, but I had
already pushed the patch. :( I was also surprised that b4 hadn't
picked it up...

I applied w/

b4 am -P_ 20260723131649.134127-11-panchuang@vivo.com

Running it again still doesn't find your review:

$ b4 am -P_ 20260723131649.134127-11-panchuang@vivo.com
Grabbing thread from
lore.kernel.org/all/20260723131649.134127-11-panchuang@vivo.com/t.mbox.gz
Analyzing 4 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Analyzing 16 code-review messages
Checking attestation on all messages, may take a moment...
---
  =E2=9C=93 [PATCH 10/10] drm/bridge: ti-sn65dsi86: Remove redundant dev_er=
r_probe()
    =E2=9C=93 Signed: DKIM/vivo.com
    + Reviewed-by: Douglas Anderson <dianders@chromium.org> (=E2=9C=93
DKIM/chromium.org)
  ---
  NOTE: install patatt for end-to-end signature verification
---
Total patches: 1 (cherrypicked: <20260723131649.134127-11-panchuang@vivo.co=
m>)
---
 Link: https://lore.kernel.org/r/20260723131649.134127-11-panchuang@vivo.co=
m


Ah, if I don't do the "-P_" then it finds your tags, but I don't know
of a way to pick up just one patch other than that... Even "b4 am -t
-P_" doesn't find your tags... I guess that's by design?

-Doug

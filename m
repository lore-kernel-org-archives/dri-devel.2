Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C59FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 15:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7272F10EC4F;
	Tue, 28 Apr 2026 15:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VFO09wtw";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3286C10EC4F
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 15:49:16 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b9c3e2cf3c0so1963548066b.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 08:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777391352; x=1777996152;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ajbkEbKDdLbKymtMUQjuNsnZglOkHRFWBqwK7N6UE2E=;
 b=VFO09wtw0RLryAqyKQv6zc2lg9Bebmyh+NXu0wSC/TpH4Gt85gYXDI8aqDhYTr1Xyt
 txGRpryESqI2YKd7ZKgwoSqDaYVHFr49DldyGR6aMHox03BnJXOyTyPcNTnKP2PXiM3e
 tVwksh/J1KO8zV9YkLt5TbEIP4dSaZ1w6QWTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777391352; x=1777996152;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ajbkEbKDdLbKymtMUQjuNsnZglOkHRFWBqwK7N6UE2E=;
 b=gOP1QnGbl/MUevPibqZw6QhdvD0vDUj4W9UwqstOaRIvPbHl3FtoLOuNzCTnop7BHe
 gCgRq5fZRvGm0BWvVY2rybwufX9EWwBT70T37f6zP2wIn/xo7+i4l39njrUruSWOh6ZJ
 EasgHOE5ypWEOK5z22wBVstblRdroL+s8nWdS8AZVxoQ5fPa2rEF1lW18kPOGc4Z330E
 tOi/voagfhY/IUyvWRcRaNR4qU8cVhITZDeeEJ6WqrVkZsmhBFcmU0eojApUG3GhgS2V
 sJWHlz6T1CZjsIJNnInYke09AqNgjc42MAYtqFEDaaqgfZ4wSWSEzHvECw2jK7PX6PqX
 dLhg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FDcsxpdVg5n/0tcBQRe0Obz9gPO7V0+wi2/lCuCDFTEN1p7OmIMqFl6g5cSmNJOy6i/n0LVpXaiA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwprKBtWutb37TWKz+jLuJaeaaslixVlcVtQMfZ3PHwckze98tX
 oEEdMICvRcF9V2/EFMgrfJfvAFbyvJm6O9qFfoCRsPyMlybHCgPKd9qG22QniH/a/lcQpSKtIih
 u7gb8BHZS
X-Gm-Gg: AeBDievuybcW2HW7Uma4NyLKpO8GwmsKsaPtpxO6l3acRONyMAQLV2vTxi533a19JEu
 5SJMZnENHj14ewRwayrP6LxsluUqmGPAHVCLDaurihq5+YO8VGVfRbABLumypz6Z3JKjfZvYwIP
 pR3xDh2J/j7rbyASB/ICL5us5l3w+2QHSEv1NQs9+voLYlGqtdMX1YXbbYfAsYzSZx6bx4ctyUI
 Sbul8D3wDSZXxtT5q+YyY5exlAIOVinRXhlU2K56wQ/rlxxWGz3yVnLxETYOiqSr5TPf97K5J9I
 qCLZTeXwpHPV7hu4bLuahJatWCzmqneZkWlP/Ip6K1gTMZFA3KYSt/mBhE0FX/a/+6aBkNwHdSp
 /Gw/ThiJTPw59Nomvs59KJ7Ini6kDaG+Q6NCCImGsUpQhIa1fo8iw1ACTS314L5juNzZfT/ZCHG
 c1s+9dpkBZkvQYoAz3Gzf3mnHz9Uar7ef2tRLd/x7QwMyWV7UUas9HDQ72eS8j817RsYPyQYOT
X-Received: by 2002:a17:907:1804:b0:ba9:3162:182 with SMTP id
 a640c23a62f3a-bb801ed5633mr223411366b.19.1777391352482; 
 Tue, 28 Apr 2026 08:49:12 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com.
 [209.85.221.50]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bb8bd10356esm62078366b.2.2026.04.28.08.49.11
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 08:49:12 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43eb05b1875so6769688f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 08:49:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9+cWLGwT0PaQma9ZsVxA678S0XVHLokgnZHr0MALk8ZOvqRH6oAOeBeMrmq7gzvtwTh3V+9v1kyeg=@lists.freedesktop.org
X-Received: by 2002:a05:6000:26d2:b0:43d:300b:2285 with SMTP id
 ffacd0b85a97d-44648b50d01mr6684095f8f.11.1777391350488; Tue, 28 Apr 2026
 08:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
 <CAD=FV=VXD34ZZTH4MJUtZ6xifbbjp1cLRBd_xvz=3T12G4tKYw@mail.gmail.com>
 <d9faab05aab120fee367394edcb35bd131c97646.camel@iscas.ac.cn>
In-Reply-To: <d9faab05aab120fee367394edcb35bd131c97646.camel@iscas.ac.cn>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 28 Apr 2026 08:48:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X-FUw_MqE2ufv=ngBS3ho4vg-QKokav+MeP7XAAjXUbg@mail.gmail.com>
X-Gm-Features: AVHnY4KcDuFY0KOauqhFMmUAZtkIYYE4OelTMMpZ8zfK3NDGP7A542OgIRYDm-o
Message-ID: <CAD=FV=X-FUw_MqE2ufv=ngBS3ho4vg-QKokav+MeP7XAAjXUbg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: himax-hx83102: restore MODE_LPM after sending
 disable cmds
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

On Mon, Apr 27, 2026 at 10:49=E2=80=AFPM Icenowy Zheng <zhengxingda@iscas.a=
c.cn> wrote:
>
> =E5=9C=A8 2026-04-27=E4=B8=80=E7=9A=84 11:24 -0700=EF=BC=8CDoug Anderson=
=E5=86=99=E9=81=93=EF=BC=9A
> > Hi,
> >
> > On Sat, Apr 25, 2026 at 9:58=E2=80=AFAM Icenowy Zheng
> > <zhengxingda@iscas.ac.cn> wrote:
> > >
> > > When preparing the panel, it seems that it always expects commands
> > > to be
> > > transferred in LP mode. However, the disable function removes the
> > > MIPI_DSI_MODE_LPM flag, and no other function re-adds it.
> > >
> > > As the unprepare function contains no DSI commands, re-adding the
> > > flag
> > > just after disabling the panel should be safe. Add the code re-
> > > adding
> > > the flag after the two commands for disabling the panel are sent.
> > >
> > > This fixes screen unblanking (after blanking once) on
> > > mt8188-geralt-ciri-sku1 device.
> > >
> > > Cc: stable@vger.kernel.org # 6.11+
> > > Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out as
> > > separate driver")
> >
> > This "Fixes" looks wrong. The bug was still there even before the
> > driver was broken out. ...and it looks like the driver that this was
> > broken out of (panel-boe-tv101wum-nl6.c) still has the same bug?
>
> Yes, but I think the fix shouldn't be propagated to the other driver
> because of the same reason with breaking out the original driver.

...but doesn't all the same logic apply to the other driver? Nothing
ever adds MIPI_DSI_MODE_LPM back in.

Even if you don't fix the other driver yourself right now, the proper
"Fixes" tag is when the problem was introduced, not when the driver
forked out.

-Doug

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63925FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 15:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5FA110ECCC;
	Tue, 28 Apr 2026 15:56:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="htipR74E";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF27A10EBC5
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 15:56:54 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso1007222366b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 08:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777391809; x=1777996609;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WLFz0+fL7Igaq1YF4c4WzQUXnbnHd0d5tSqwHAt7wNQ=;
 b=htipR74EY9IcIdgg66cdN5aVl7k9jzpUiMpZewt80XhtfW7TIW9XnKeN+YY1h6bGPb
 ZwuftPF64rdqLP+lvfwvVDV4//0vIb6coTPyxnZ9/7TCqWVM0QyjJiHMxWkrxDocW+3t
 p+LDUx4B/0kkJr0j4QJvfI8nU2DXkx6NbaI3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777391809; x=1777996609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WLFz0+fL7Igaq1YF4c4WzQUXnbnHd0d5tSqwHAt7wNQ=;
 b=UIghNN0UD6tmRbzuv7kzFy4EQoM1LAutuiiOY83NQ0HQTNoNGbHtDcZnbfa5Y9zfea
 beaixEIYZd8QOgaJS+9mKCzi6BI9gf3hvcCqHYL0yC4ZtPLpzuJEKDWFG5WQG3wEHRRl
 RgFx3pHJKklvminzR8LcA5/A/wFczB5BC2uzBuc5aCMuaEM6di7KvXhPP0Tepna++3rB
 wdTtPAreLPXeyIhzjyF1n0w7uRWe8MPEDsF/8LCAKgaljZoQb+T/D4vbz6+hwhzIaOxA
 Sms/pcNwLXsI+Okes+ubR5uYiNfw9wpDUu6Unwm3p4qsBLxpcjrBSXz5llzCXQS8oD9r
 nSZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Dx+NIjtyJbG7TsIA8lJg01OFrlSeuG2bPWbQV9K771vlsMgI4T/9D/LZctD58+GsQIn1LE9OrGLE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwbctMOZbcmh6i8yzFUCPgsg+UZ9CbRBNvu5hoY2zO8DwofuOjN
 lbp7gJYHhhnhncxdK53gvWOkXyHedSlLBn1DoQCsekOnJzs2xIIEKAkxhtONnpjmx3Pz8atAfEn
 dwh4GO0dZ
X-Gm-Gg: AeBDieuun+4eoYF6q1xJz8eKOi1G+Kz+nJLS5BZLAGw+q64Hz3AWSoYsNu3H5sQvoTB
 /AUtTD070/B2B4nD7JAYikDGOLQbpkzbNppbp6h3ybHV2AvuK0rPkEaJH75qrOBWKjPNbDSGmCJ
 dLefYj/yth/dtVZXu4nksopPv++kCLkbGNfm4/kmILZJRc5ahZtQ1VKcROFICJXqiJUM9fYsXJK
 CI3Zz6rE0AaphNJ+68pmn1+2kKdRsSESWlOvBfsBpN/5JeIxLJWeLW7IlcG8HjQzWvLKRIdGAu9
 gb4hfskGH5SQJH4pMw2G1Xt9gbFBTYYLu4zO1f822YYuTAXhiFDzDMxfZLoU375IkVKVkTfUQpo
 7+CB/svublbfXxBvnS5eFu11KTQC9a7536zTDvgCXigmK5uN/xMGy4vywvbjx9Qte8JU9r2+QOJ
 GuEtCwpD4E+T3vYVXNDs0ru2TwL7nQeGibEkjdLYKE44UYcre+bFuHEaAk9Aa6ogeYMHw0ZzY0
X-Received: by 2002:a17:906:fe0a:b0:bb8:efe8:110f with SMTP id
 a640c23a62f3a-bb8efe81e16mr74096066b.0.1777391808658; 
 Tue, 28 Apr 2026 08:56:48 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com.
 [209.85.128.49]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bb80ba9e4bcsm122775766b.49.2026.04.28.08.56.47
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 08:56:48 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso97020265e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 08:56:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9Prg3XgAvufnCr3o/Ew0m4eQjGwc92uudFOlrvcej+YxhZPHtx3XXC5R4EOXkM1DgJK8bysyI329Y=@lists.freedesktop.org
X-Received: by 2002:a05:600c:3b13:b0:48a:525b:e148 with SMTP id
 5b1f17b1804b1-48a77ae03e7mr53600045e9.4.1777391806260; Tue, 28 Apr 2026
 08:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
 <CAD=FV=VXD34ZZTH4MJUtZ6xifbbjp1cLRBd_xvz=3T12G4tKYw@mail.gmail.com>
 <d9faab05aab120fee367394edcb35bd131c97646.camel@iscas.ac.cn>
 <CAD=FV=X-FUw_MqE2ufv=ngBS3ho4vg-QKokav+MeP7XAAjXUbg@mail.gmail.com>
 <151c1c1d52fce8c3b1dac3a919be3086ce3426df.camel@iscas.ac.cn>
In-Reply-To: <151c1c1d52fce8c3b1dac3a919be3086ce3426df.camel@iscas.ac.cn>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 28 Apr 2026 08:56:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XPAWEiN4EFvY0sA7uEBqxpc0iiD28Y9BmpguoerG1hpg@mail.gmail.com>
X-Gm-Features: AVHnY4IA2Dm1yshlPxhQkFms2fky9sEgdM6Do7-4YmOKn1Ubv2moq16Bw_HaZvg
Message-ID: <CAD=FV=XPAWEiN4EFvY0sA7uEBqxpc0iiD28Y9BmpguoerG1hpg@mail.gmail.com>
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

On Tue, Apr 28, 2026 at 8:53=E2=80=AFAM Icenowy Zheng <zhengxingda@iscas.ac=
.cn> wrote:
>
> =E5=9C=A8 2026-04-28=E4=BA=8C=E7=9A=84 08:48 -0700=EF=BC=8CDoug Anderson=
=E5=86=99=E9=81=93=EF=BC=9A
> > Hi,
> >
> > On Mon, Apr 27, 2026 at 10:49=E2=80=AFPM Icenowy Zheng
> > <zhengxingda@iscas.ac.cn> wrote:
> > >
> > > =E5=9C=A8 2026-04-27=E4=B8=80=E7=9A=84 11:24 -0700=EF=BC=8CDoug Ander=
son=E5=86=99=E9=81=93=EF=BC=9A
> > > > Hi,
> > > >
> > > > On Sat, Apr 25, 2026 at 9:58=E2=80=AFAM Icenowy Zheng
> > > > <zhengxingda@iscas.ac.cn> wrote:
> > > > >
> > > > > When preparing the panel, it seems that it always expects
> > > > > commands
> > > > > to be
> > > > > transferred in LP mode. However, the disable function removes
> > > > > the
> > > > > MIPI_DSI_MODE_LPM flag, and no other function re-adds it.
> > > > >
> > > > > As the unprepare function contains no DSI commands, re-adding
> > > > > the
> > > > > flag
> > > > > just after disabling the panel should be safe. Add the code re-
> > > > > adding
> > > > > the flag after the two commands for disabling the panel are
> > > > > sent.
> > > > >
> > > > > This fixes screen unblanking (after blanking once) on
> > > > > mt8188-geralt-ciri-sku1 device.
> > > > >
> > > > > Cc: stable@vger.kernel.org # 6.11+
> > > > > Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out as
> > > > > separate driver")
> > > >
> > > > This "Fixes" looks wrong. The bug was still there even before the
> > > > driver was broken out. ...and it looks like the driver that this
> > > > was
> > > > broken out of (panel-boe-tv101wum-nl6.c) still has the same bug?
> > >
> > > Yes, but I think the fix shouldn't be propagated to the other
> > > driver
> > > because of the same reason with breaking out the original driver.
> >
> > ...but doesn't all the same logic apply to the other driver? Nothing
> > ever adds MIPI_DSI_MODE_LPM back in.
> >
> > Even if you don't fix the other driver yourself right now, the proper
> > "Fixes" tag is when the problem was introduced, not when the driver
> > forked out.
>
> I think the Fixes tag should point to where the driver is forked out,
> and if I'm going to send a patch for panel-boe-tv101wum-nl6, it will
> has a Fixes tag pointing to the further commit affecting that driver.

You're free to have your own opinion, but that doesn't match my
understanding of the Fixes tag. If you can convince Neil or some other
drm-misc committer to land your changes with the Fixes tag as you have
it, then I won't object, but I won't land it. Best of luck!

-Doug

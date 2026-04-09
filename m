Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7347E9DE6C
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 08:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 164BE10E76C;
	Thu,  9 Apr 2026 08:50:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n9JoTSj8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5553410E76C
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 08:50:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 73E42600CB
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 08:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2640FC2BCAF
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 08:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775724650;
 bh=it8N9QiPAQ6bG4oSqDUwnWos44xYZQNt5vVT1HI+p3I=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=n9JoTSj8wEDvUoGHnm+uD3ee5K+cpRk5z1FgTVC7GLA9HNmIriL9zeroJPWPPZxGb
 qlPZXKVcpS8T5Rg1HnCr7mWuO3EBXMTJivRXV86yR23DboCM8hAlMmh5F8BEdiXLbs
 z8WpfBy9Bwbxoe3hPYUGbC0P6GlV11GiDbWMVxHzT6yeMkVw1+kHSmW/dPJJ3O1ekF
 iUIVTx3M/LwFZlTZ5D4NSB7Nh7DvyUtnBWEACP4iVAb+IP7J+FBMV0EBL3ENtKjF/q
 RUHb2LJkeGl9XS5PQ7EvkhK2Kzs/g+6T9vTbiG60ekL9a94VR2r/qWMxnlusFKH0Zy
 d6iRmuholPChg==
Received: by mail-yx1-f51.google.com with SMTP id
 956f58d0204a3-6505ef94043so654759d50.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 01:50:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCW7ZPHLXbprMPxQClzfnIwOs49yEtzUDo+/QiIDnvLrQUn1wfD1Do4OLoWr4+WSVL+C7EggUxYa5qs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1Ouv+EoV7B7VGqVtupuB37c/nOhlnF7h3SA0GNJyEzoWxbB1R
 6iKxIO4DHUVVFsApaSmJOlger4l6MH2d0P3dQ7eTjdx+gsa435nbZSPhPb2xHSksl8eQWMXo44Z
 Eesm3YX7UPtdWhdO5tqMGgfgTlU9UU3Y=
X-Received: by 2002:a05:690e:4419:b0:650:2ff9:d681 with SMTP id
 956f58d0204a3-650488b4a4amr16332676d50.68.1775724649517; Thu, 09 Apr 2026
 01:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-14-5e9119b5a014@oss.qualcomm.com>
 <CAD++jL=jUd4sQ1bhwcBRYpFFApP6vdJw2BoQwxoWShUKdEb9oA@mail.gmail.com>
 <z3obsnbmdvvlzs3cxm57osbax4ivg2zq2zk6xgp37n4hni7y6i@smwn362nhn6a>
In-Reply-To: <z3obsnbmdvvlzs3cxm57osbax4ivg2zq2zk6xgp37n4hni7y6i@smwn362nhn6a>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 9 Apr 2026 10:50:38 +0200
X-Gmail-Original-Message-ID: <CAD++jLnXJKKv5ghRnCcMTU9g984seJAMHyL6VWWV0Bv+dv01wg@mail.gmail.com>
X-Gm-Features: AQROBzBsoNdPYNsMvGgzeGYog6ZDiTw-eucSP-xx3bid1He95rIDmnyN8FEvCgY
Message-ID: <CAD++jLnXJKKv5ghRnCcMTU9g984seJAMHyL6VWWV0Bv+dv01wg@mail.gmail.com>
Subject: Re: [PATCH 14/19] drm/panel: jadard-jd9365da-h3: support Waveshare
 DSI panels
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, 
 Javier Martinez Canillas <javierm@redhat.com>, Jagan Teki <jagan@edgeble.ai>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org
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

On Thu, Apr 9, 2026 at 2:49=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:

> > But there is also one more thing, this looks like a big "jam table"
> > with just register+value tuples, so construct something like:
> >
> > struct jadard_jam_tbl_entry {
> >         u8 reg;
> >         u8 val;
> > };
> >
> > static const struct jadard_jam_tbl_entry jd_3_4_c_init_jam[] =3D {
> >         {0x00, 0x00}, {0x01, 0x41}, ...};
> >
> > (Ideas taken from drivers/net/dsa/realtek/rtl8366rb.c, take a look
> > for code and all, you get the picture.)
>
> Few months ago the code was moved exactly in the opposite direction. We
> added all _multi() functions and made shure that the code is as
> efficient as the register tables. On the other hand, having it as a code
> allows better control. E.g. handling 2/4 lane case would require extra
> hacks to the register tables, while the code handles that without extra
> hacks and without loosing effectiveness.

OK then sorry for the fuzz!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

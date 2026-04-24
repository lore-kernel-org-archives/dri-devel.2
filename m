Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65111FF885A
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 21:35:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A730810E119;
	Fri, 24 Apr 2026 21:35:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TzSrA83h";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99B0810E119
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 21:35:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 61CD4418BF
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 21:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E502C2BCF5
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 21:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777066531;
 bh=V/g5417/lu7Rq9Wc+VHeVNBsxjaU+u4FIfHUcgI8RBA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=TzSrA83h3MF29WGElQvFWQ5jKHyEJlRhWdtIJjpO4xcVRbM/po+lDeAxLa/JBomDK
 uh6wtq/VEjqMJxCJZOtItouPuZdLYh/0K1ESZwMkKekkwajXTLCh5uVPkRAGQw2ex2
 z6HerXXTiRtWoEON36F59AhbxYvNLf48NirNBrQ/5WGPKpR/C+PJFigx4/xW8RMq5j
 jg1XBWHt7viGZ8Rwn/TJYA0uqaNse0FsL1PxNhIG2Tlmc+tYIUoJP2Gwi4DR+HOM74
 /Gybl/hwIIJTu7nYxN32939Xr7ypeUUNQvwFONtCG8LGIQvBhNFlyxrVc3C63ww0kM
 U7FVAFBpb9XiA==
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-38a01c80c34so80692171fa.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 14:35:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8ZcTFfvyJLp7zIXk4WiUd/X0sktxae6w4S2BqMym7zm7U8bfdqlReeVeciyAq/dCicPd22lhSAP2M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0iz7lUHRrBnxUo85ES/NevlSxaY5TxTd69zRfEtwU7E6e1fIw
 Rpb1QWEud6GPajTNDhQ2f0uBJnf4ZLcGxL9OH0ehb5FS3c/ycq/w19l5v0WYiNPJ2uSLPO2bG9M
 tkAsJFfhAJjnjWiMqFQZPJ7hw32P5mzE=
X-Received: by 2002:a05:6512:3d27:b0:5a2:b3dd:7a74 with SMTP id
 2adb3069b0e04-5a4172e7af6mr12181069e87.33.1777066529695; Fri, 24 Apr 2026
 14:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
 <20260411-waveshare-dsi-touch-v2-21-75cdbeac5156@oss.qualcomm.com>
 <CAD++jL=zmd8yto9HuyjC8cmBj1oMgOa7C899yo_toP9Q+QJcDw@mail.gmail.com>
 <dovqowg4a3aet2f4gwd5lufh6xqopeq5slgyix2bqbf3v7z4fk@b6pwiyn6ppov>
In-Reply-To: <dovqowg4a3aet2f4gwd5lufh6xqopeq5slgyix2bqbf3v7z4fk@b6pwiyn6ppov>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 24 Apr 2026 23:35:17 +0200
X-Gmail-Original-Message-ID: <CAD++jLnSeT2obJrvw3Z7G5WMeEqaPueWAKhjS7BO-HY6RsR+2A@mail.gmail.com>
X-Gm-Features: AQROBzDBWqqVUjdalSSficemzrrdbGhMWHS70jsRIKyadsmlsfGsHqdU45XnDFM
Message-ID: <CAD++jLnSeT2obJrvw3Z7G5WMeEqaPueWAKhjS7BO-HY6RsR+2A@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] gpio: add GPIO controller found on Waveshare DSI
 TOUCH panels
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
 linux-gpio@vger.kernel.org, Riccardo Mereu <r.mereu@arduino.cc>
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

On Wed, Apr 22, 2026 at 8:39=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
> On Wed, Apr 22, 2026 at 03:20:26PM +0200, Linus Walleij wrote:

> > This looks like it can be replaced with a few lines of
> > select GPIO_REGMAP
> > #include <linux/gpio/regmap.h>
> > helpers.
> >
> > Has this not been discussed earlier?
>
> Yes, it was. Using gpio-regmap would complicate BL code since it
> wouldn't be easy to directly toggle the BL GPIO.

OK I buy that.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75828C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 16:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CB0110F069;
	Wed,  1 Jul 2026 16:38:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CnjZ9Lzy";
	dkim-atps=neutral
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
 [209.85.221.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8995610F069
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 16:38:52 +0000 (UTC)
Received: by mail-vk1-f175.google.com with SMTP id
 71dfb90a1353d-59cd803792aso462583e0c.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 09:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782923931; x=1783528731;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2wqbqqnz7xSZo8cxkrKdPTuR1WFDOkJv6SeG+ZwdR8o=;
 b=CnjZ9Lzydo05Qb+1RPE4Vxht1D2OZ4ciuM7DpQEzvee7o11FPMnab0AZlNdCYbk/LR
 OyI7H1v0vh883bKTF8WWYbWneT8pEJH7e/5SBJzYsGHxu6asmMeVQvXcQIr9LLATVMGU
 PAWq6HGRGa+dfr/JrvISymJymvhlKowj7TQy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782923931; x=1783528731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2wqbqqnz7xSZo8cxkrKdPTuR1WFDOkJv6SeG+ZwdR8o=;
 b=WDaXjDC3Auc+z+Ye/WszoxcOEtqzROVDWiU57HJCLRgINxmvsrmqDQu/0NVIpNfx7e
 yzguXLrNX3UD2DcQXxOQJQr3M6SF9Od/K4hjRemsEREhJxa2LTyS+O8VcSlpZ2BoU0G7
 fEGd0SPInr1ZHlJeXvZWiyf1YKedxeqUD53YlsWdCZLQsw5xnK2Xdgbe3ZIbAL5ie8Zg
 pQ2f8p+n5nOvqI2BT4qTGlEZrSDEmH9t7E079MPtozfmLyRjS84c0SQIVPmKNFsdIBUv
 lMHgx+wQIiVzPsWq8Avem40n8y66TuPXCPk/4Iag1E6Kl2ruzMkPiK1pf9tBW2+qPD4r
 idQg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKczcyofuLyuR/UUxNLp8nLgjICen+ZMP6aI2kzgKH1JVf5hJmUoScovYRweNfZnqV/djwXjG26kw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyo753I52DwTopbdCwbXeN7HM8Z5LAYCmbNhCHHuKIqnJ9fQzoA
 zPCwMirDrRA6QQVJRCRC4f2yumpoKRPeHhujl/KZv1t6ciN4NCGfPNXjQSGoOze6WRKYSCKuvZY
 b9gI=
X-Gm-Gg: AfdE7ck6F9GI18XdaX/LUUnhH5i57hbSiHiewAm/VroJpG8QPAMoznMk771Ty2AMfNm
 hOzsbgUgjYNo0NflW1Y3JvQCx0wp8FYUJGlanjBcxLXkI3IlrNJ+tQfJaW4duc/K5EmT/gR18OX
 bdwmttTdIFarZfliawqvtxBPgIttq//UeueO8K82po924BtUwy5Yle5gpvdmHeZeD+d0gjr5ESK
 oxXjBpSu67/NNOusfqZungB/g2wTXxfUJb9ZeWw5yW6VHtdVVCramWKQtVcS3NOQIT/yCxcadSk
 mgw+2ypgJHj4qDpTiEvsGkXn08wS0py+MuCPJjdxxRKozvMjuDUEjYDuInPS8n7oXRV+DJ0gIrY
 rp/+m6s7Kg69JXRo1jdOxDfrq1pcDKq8zJYs8ZqVRZPEFLznAeNpNKEKl7OoxAA64BORZfB2d0l
 I6SJ9qx7t3MJg6gD13XppHyhmOz1JmTT3tm1tv5js3dJqgp9WBskQ=
X-Received: by 2002:a05:6122:2888:b0:5bd:7fbd:ecec with SMTP id
 71dfb90a1353d-5bddf707342mr1111171e0c.13.1782923931354; 
 Wed, 01 Jul 2026 09:38:51 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com.
 [209.85.222.47]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bdc1a8d94esm3729655e0c.9.2026.07.01.09.38.49
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 09:38:49 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id
 a1e0cc1a2514c-96730906293so448029241.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 09:38:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrVLSHl96z5fa2THf6bu1p7909eb5sx9uTAiI9LmumHJW3VcOLW2HnbQOKRHjl+2BlZeFkETY6xO3M=@lists.freedesktop.org
X-Received: by 2002:a05:6102:5a97:b0:738:5e0:b40c with SMTP id
 ada2fe7eead31-73da9f0cca9mr1181664137.24.1782923928552; Wed, 01 Jul 2026
 09:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260701013018.2621972-1-zhouhaikun5@huaqin.corp-partner.google.com>
In-Reply-To: <20260701013018.2621972-1-zhouhaikun5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 1 Jul 2026 09:38:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XTJPqLTqM0r1-HvtCz6DJoK96vwsBssw1ABNRh3d6hMA@mail.gmail.com>
X-Gm-Features: AVVi8CfZHCw-UQf19BKpT_zKYKBvYRTHd89rS7PH6CBFrBIn0Ephvcs-SFbXqKs
Message-ID: <CAD=FV=XTJPqLTqM0r1-HvtCz6DJoK96vwsBssw1ABNRh3d6hMA@mail.gmail.com>
Subject: Re: [PATCH V2] drm/panel-edp: Support MB116AS01'3 edp panel
To: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, sam@ravnborg.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 daniel@ffwll.ch, airlied@gmail.com
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

On Tue, Jun 30, 2026 at 6:30=E2=80=AFPM Haikun Zhou
<zhouhaikun5@huaqin.corp-partner.google.com> wrote:
>
> MB116AS01'3 raw edid:
> 00 ff ff ff ff ff ff 00 21 63 03 12 00 00 00 00
> 00 23 01 04 95 1a 0e 78 23 e7 05 9c 5b 56 93 27
> 21 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 36 1c 56 92 50 00 1c 30 60 18
> a8 00 00 90 10 00 00 18 00 00 00 fd 00 28 3c 30
> 30 07 01 0a 20 20 20 20 20 20 00 00 00 fe 00 48
> 4b 43 20 4d 59 20 20 20 20 0a 20 20 00 00 00 fe
> 00 4d 42 31 31 36 41 53 30 31 27 33 20 20 01 cb
>
> 70 20 79 02 00 22 00 14 1c 1a 01 84 55 05 91 00
> 5f 00 17 00 ff 02 1b 00 09 00 07 00 2b 00 06 27
> 00 28 3b 00 00 81 00 13 72 1a 00 00 03 01 28 3c
> 00 00 00 00 00 00 3c 00 00 00 00 25 01 09 1c 1a
> 01 1c 1a 01 28 3c 80 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 e7 90
>
> Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel-edp: Support MB116AS01'3 edp panel
      commit: 844e71ba7d7a50c5ffa29d147afaeaafb19b39e4

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D7DFED3EF
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:18:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A650910F64F;
	Fri, 24 Apr 2026 17:18:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hf6tqkW4";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59CBC10F650
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 17:18:07 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so1445883166b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 10:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777051084; x=1777655884;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/hf0FVfMXWMn+GR87JsjIzW5dvM3go44g3jD9SsJg0=;
 b=Hf6tqkW4ZCTw+boKr2mgrbdxBq8QgtGM/A9uexSksQWXVb/4Ox3l8vAJURMmPnY3M2
 6enWBqmDZPW6AOFFlkdQMTaBQb6X86Bs9Q0YAlzsfOqpwS4UnkRcytHl3+8nlEb31eqX
 PeGXGpgmD24gtq1D325T/lwPS9wMEz0i7Iui4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777051084; x=1777655884;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9/hf0FVfMXWMn+GR87JsjIzW5dvM3go44g3jD9SsJg0=;
 b=N6cnI2ei+gYZI91FsAeki1/ITZ61BWQhtn+Kg2PGqzRAeDff3nZbd5hSclGCZgRiRn
 ESf/FtJ3NhDf4AwcoCKNqnZQuFNz3T57hAIqCYI9RC3BMvezvSw+GaR263C9MbPHFpmM
 MSQ6DwFhrZsAXzAYwNvEvX2yFmuKHuzmlVHwcwfgB2JL8qX2enUgsyHhKgp166h9IVk4
 SrDDCPHxL9SBSjyZz+o6GTrFDiu30Ps7OaXFutkvmlDqovP96iMA/b7RaQB0HEqbMJQo
 112lcqZDjQZhe8DDZ/p4EBfe2I3Mw2RNaoMq/qh8gCK1FpjAJWAktvBk7yFqJ5RKm7ET
 wJ4A==
X-Gm-Message-State: AOJu0Yxjt/HHeEGwlfesKzQo4MQ0l0oR6r+hCzeroCYjQvBI4ZiXB8+u
 DFvHxm2CSe4MDhpIxaPMSJ16VayiHDZ7jojZqmIYh5WdUsCRJ48M0+UbUo73Yc1o8QH5cEAAEtQ
 ErSdxNw==
X-Gm-Gg: AeBDiet+1reOj75xEPs8ZtNJValJ39FtFtiayBft0uNW1OXx1D2ByXOpQCo73RB1Zjb
 hLHBVvZiAd+KLYhlCwrcbVBa1vwIPq16fBTydHRMlDwkQetUKfXcKLIoI2NO94B1WU935jGhaZa
 Eljuh6gy5lJiEJ8C1nCiAt1WFHSZk/S/f7KHJHcozSAdKYXYM5eI++F4ucxVrt1VTEXD1Jcbs0g
 4HPuG9LsK7HpjHSg4TSHL4p3WjAMxStb8IjPDzOqaF5Pf6YUeklaFw8MpIx1uziEWfAmE01rQsA
 WicEJpnO1ztHQAzLabIui9q7dzCN1AtYVZCFE4wSUjzytZAyUbiQQOJr8XAhOoth9fi6q6+d9ig
 tw+jN+nIKrg2gJruqi5lPID9ik1yzgCi0aEaHaFjQYe2ovCrSurIQzt4uCAhA5rFrzVSyfIT0QE
 3SfX4x81BfaecB3jF989xWTM/MHGzRxIh04ttCg0/gMiAAiQhazCPsHACn0aRAaws+TMzQFdQe
X-Received: by 2002:a17:907:1997:b0:ba4:73da:c with SMTP id
 a640c23a62f3a-ba473da1fc5mr1711623566b.47.1777051084014; 
 Fri, 24 Apr 2026 10:18:04 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com.
 [209.85.221.50]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ba451210e26sm808549166b.8.2026.04.24.10.18.03
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 10:18:03 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so5542196f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 10:18:03 -0700 (PDT)
X-Received: by 2002:a05:6000:2890:b0:43d:7aa8:f64e with SMTP id
 ffacd0b85a97d-43fe3e0a2c4mr50867788f8f.32.1777051082414; Fri, 24 Apr 2026
 10:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260417061842.66631-1-avinal.xlvii@gmail.com>
 <20260417061842.66631-3-avinal.xlvii@gmail.com>
In-Reply-To: <20260417061842.66631-3-avinal.xlvii@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 24 Apr 2026 10:17:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V1pdK1V5-s3Ljb5EE1ZU0sOUCyARShUfVf8uAfNJMUoA@mail.gmail.com>
X-Gm-Features: AQROBzDWgz0wLkr04lft4zR2JRpxOpkHXn9viqi89bsfyG6n7294aTUkuDX8LPc
Message-ID: <CAD=FV=V1pdK1V5-s3Ljb5EE1ZU0sOUCyARShUfVf8uAfNJMUoA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] drm/panel: panasonic-vvx10f034n00: transition to
 mipi_dsi wrapped functions
To: Avinal Kumar <avinal.xlvii@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 neil.armstrong@linaro.org, lumag@kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch
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

On Thu, Apr 16, 2026 at 11:19=E2=80=AFPM Avinal Kumar <avinal.xlvii@gmail.c=
om> wrote:
>
> Change the panasonic-vvx10f034n00 panel to multi
> style functions for improved error handling and
> remove redundant error printout.
>
> Signed-off-by: Avinal Kumar <avinal.xlvii@gmail.com>
> ---
>  .../drm/panel/panel-panasonic-vvx10f034n00.c  | 24 ++++++++++---------
>  1 file changed, 13 insertions(+), 11 deletions(-)

Pushed to drm-misc-next:

[2/2] drm/panel: panasonic-vvx10f034n00: transition to mipi_dsi
wrapped functions
      commit: 03af6c3afc4893988ceed54531f5dde4bebd6024

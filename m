Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4205EFDEE4D
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A824810F2A1;
	Thu, 23 Apr 2026 21:26:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oW+PNH6A";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1C5410F2A1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:26:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CEFCC4449F
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D35C4AF14
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776979604;
 bh=0DDQs8T54McOd7hJnTqwws1DRjXMfYuwNn80v+kQdL8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=oW+PNH6A6jOzDCoA2J2zMffkHl18TOlJgyakCnNt8Gtcgl7skCoN8ilGdVfJ6tLMZ
 IAhj9lqfxZdOY8fOkdOisssAvuWwzxY7R9dNJxDVY+VbQVEE4k9rmsR0kmP1kk3piy
 4qoYNWLpF4HmNCtr7wjB0g8UIfR89ShJKHKO4Gc/vvzjG7P1P6YLatXd5caADlfDvr
 PxTxce3IPk5Z6gjd+EO2f8HF+lPrVEmldNGDY8g5pCVT5IMuv60OjzJLM4jNKgZ3zF
 JHlxzX3zCwycCQAs5oNslX4T9Vm2Z4oY4hhiKjbG/AeGAllCFiPH0V94NEEzX+WkYa
 f2oeohy4FFk9w==
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-5a3be187ffbso7698341e87.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:26:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/1QnHJ7tSHNjt2Up6/VeMtrxlqBtjChjEL2ws9r68veSBid3VScpotTzqrLBPe8dZk7uMOT/R6qp0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwT0zGUAYh4845KdvsALT4uOp3pNS8rP1tyuoCj7QjtZ09CEEe+
 HME7VE2rwWObHwOVAzkB3j9QHx2CG0nbxWPc/rS9c5M7NmUzABbGFyItDzzPZGE1j22TsoXY3rU
 QMUo2sFMvmHmhSP8ZHJlTSVT1KBZRLNs=
X-Received: by 2002:ac2:41cb:0:b0:5a5:25ae:da17 with SMTP id
 2adb3069b0e04-5a525aedd3bmr3763550e87.2.1776979603322; Thu, 23 Apr 2026
 14:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
 <20260413-waveshare-dsi-touch-v3-14-3aeb53022c32@oss.qualcomm.com>
In-Reply-To: <20260413-waveshare-dsi-touch-v3-14-3aeb53022c32@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 23 Apr 2026 23:26:30 +0200
X-Gmail-Original-Message-ID: <CAD++jL=g_t9RC-8rmZvdMuu_b+QpB8GjmbAVx6B1F96zToXVpw@mail.gmail.com>
X-Gm-Features: AQROBzDL1cfJthhfBWrjmA-f89fl7mK8hXIZNmLuA8w3ky1MkgwguYS8Mfizo84
Message-ID: <CAD++jL=g_t9RC-8rmZvdMuu_b+QpB8GjmbAVx6B1F96zToXVpw@mail.gmail.com>
Subject: Re: [PATCH v3 14/21] drm/panel: jadard-jd9365da-h3: support Waveshare
 round DSI panels
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
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Riccardo Mereu <r.mereu@arduino.cc>
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

On Mon, Apr 13, 2026 at 4:06=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:

> Add configuration for Waveshare 3.4" and 4.0" round DSI panels using
> JD9365 controller.
>
> Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

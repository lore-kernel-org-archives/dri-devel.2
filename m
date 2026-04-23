Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C756EFDEE4D
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 383F910F2AD;
	Thu, 23 Apr 2026 21:27:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="q3Es0YHw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE4B10F2AD
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:27:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3355D44545
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0251C2BCF6
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 21:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776979652;
 bh=LHGK+gI0n/9OErq8+42i/9GhBphDgJzvi2yvX7jJL5g=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=q3Es0YHwjLRlSbqSzExuGzL44NTypKdiBYyaPBqYVOYFtuRzOxit9m6YNW6ZLAvK4
 oPnoXgs0+YEXCbdf/coX4ex2BMby3X5FNfkNLuxIfJkFOjyea2IFIbFhSif/bFh3mO
 70mzrMIn1HhKbLPYAuIqW9NGgluaTU/atFo4Gqtua0y3BqlG/OoStBkKGA5k5hKztU
 t5+Q7m5JQ3uUOkfU3GL18/nd6sOdfqPvUW7ZNBwZhltP2szYkdjMil+suVjaYDF0Ua
 gdA4ehuQ0npSJLsuNoAg5Q717v7Aebmd7ZqeyqKkTNIfrZS48E2r0k9bl+mOuc85c2
 D1kPtJu1JiX/Q==
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5a1307438ddso6494191e87.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:27:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ82+FpfDWMpgR2MF+6BlVw/uky7Gs1IFXDj8YxU3xbHUeHoRYl9VIm5UFg0UoHstYbE/Ujd5Vb6axo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzWRRIXBTjuMkdP9HerkClpzCKWdIywxtLmHEhImuugajYm2Nxq
 gXFeNKrK3s8LgEObKZybtFcfn5gScSlh5cDVlsX47pkurJnjmy6IJBN8ggglZClyX5Z1+Sh8DpV
 /W+8IrkCD5HXzjKNv/ssURzNfq/AuW8k=
X-Received: by 2002:a05:6512:6d2:b0:5a2:9b44:1cb with SMTP id
 2adb3069b0e04-5a4172c0fabmr8827159e87.2.1776979650648; Thu, 23 Apr 2026
 14:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
 <20260413-waveshare-dsi-touch-v3-16-3aeb53022c32@oss.qualcomm.com>
In-Reply-To: <20260413-waveshare-dsi-touch-v3-16-3aeb53022c32@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 23 Apr 2026 23:27:19 +0200
X-Gmail-Original-Message-ID: <CAD++jLk6Bt1ocd9nbrDPg3tRnKkZdG=otB=CPv6iuY_Que5HcQ@mail.gmail.com>
X-Gm-Features: AQROBzBgvARcF3IK5AHeLBYYiVQtCKareEdSCXulR4gFnM4VD2cDpl4FLI87TaU
Message-ID: <CAD++jLk6Bt1ocd9nbrDPg3tRnKkZdG=otB=CPv6iuY_Que5HcQ@mail.gmail.com>
Subject: Re: [PATCH v3 16/21] drm/panel: jadard-jd9365da-h3: support Waveshare
 720p DSI panels
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

> Add configuration for Waveshare 9.0" and 10.1" 720p DSI panels using
> JD9365 controller.
>
> Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

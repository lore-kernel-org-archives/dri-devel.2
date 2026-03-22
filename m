Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D9EFC72AD
	for <dri-devel@archiver.kernel.org>; Sun, 22 Mar 2026 13:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22C8710E139;
	Sun, 22 Mar 2026 13:07:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wbg/enLD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F02C10E139
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 13:07:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3717C44432
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 13:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26A2C2BCB5
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 13:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774184826;
 bh=U4G/IHK65Lt4xZiDkJ4QwR5+PobqwvwSVmCDcYhqn7k=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Wbg/enLDqjr4aYJ5z7Yj+DV93Oa129HFg7Sakl/iL2uaidripxfeZK2vTofLWLe06
 WBPKHmukFh+omidL4UIErpe7WP+Hbk2mgu4/mO/616mBDIgTGju5jaLFRsujuN1wm5
 JJJ2mviuENp+qWRxs/6FrSdepdL9fUSLACpywcSk8WkWkbFyoU8wGS/9nS1VzuXZFN
 ddtPRRxwIFPytD8LidUbOepgEC4sAoY/FjsbXP1DG19OZ5UjOjh2/73gJASTPRigb8
 m6XuyHwx3ukNJts//MxDx2qKPzZ76DrH1zP+Uwsem1xcc7kXQrJWNJEKFH9kzDgK11
 waoLQ3ZH9wmGw==
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-12732165d1eso4283173c88.1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 06:07:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWM8PZDXHmJ5gSjxpIlIno6J6+ImN14qRusF+8wPoSzxRUrfI2vI8wtgK6JFIfQY//3v1DJOTckrro=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyeLas0WMnOJjL1rTkT/iV7yvXm/mYJV8jPNw1QkFwMOeWXTY+p
 1Js5tJp71vdSFYl0gKIpN2mjoyQOxgMS1CGnY3AM8oe/5r/ws2VlZqEChsGugpmEPjwC5J23ty8
 yVht0b/0C7/7Y8qpIvBdUQqUFXjbuPQ==
X-Received: by 2002:a05:7022:23a4:b0:11d:c22e:a131 with SMTP id
 a92af1059eb24-12a7263dd72mr4213470c88.3.1774184825290; Sun, 22 Mar 2026
 06:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260212192605.263160-1-l.scorcia@gmail.com>
In-Reply-To: <20260212192605.263160-1-l.scorcia@gmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Sun, 22 Mar 2026 13:06:52 +0000
X-Gmail-Original-Message-ID: <CAAOTY_9OkywB=+p=TWG7GcoR3dfuPE3GLAdHpFKKs47n=x58Ew@mail.gmail.com>
X-Gm-Features: AaiRm53244OfRV3JHtb3IQRO_s53Fjj8DO5UiCOTvEXuDbtFjMzRwZUMDRJPblw
Message-ID: <CAAOTY_9OkywB=+p=TWG7GcoR3dfuPE3GLAdHpFKKs47n=x58Ew@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: Remove all conflicting aperture devices
 during probe
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

Hi, Luca:

Luca Leonardo Scorcia <l.scorcia@gmail.com> =E6=96=BC 2026=E5=B9=B42=E6=9C=
=8812=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:26=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> If a device has a framebuffer available it might be already used as
> display by simple-framebuffer or simpledrm when mediatek-drm is probed.
> This is actually helpful when porting to a new device as
> framebuffers are simple to setup in device trees and fbcon can be
> used to monitor the kernel boot process.
>
> When drm-mediatek loads a new fb device is initialized, however
> fbcon remains attached to the initial framebuffer which is no longer
> connected to the actual display - the early fb is never removed.
>
> We can gracefully transition from framebuffer handling to drm-managed
> display by calling aperture_remove_all_conflicting_devices before
> registering mediatek-drm. This takes care of unloading other fb
> devices/drivers and disconnects fbcon which then automatically
> reconnects to mediatekdrmfb as soon as it's available.
>
> The function is invoked just before drm_dev_register() to kick out
> the existing framebuffer as late as possible to reduce the time the
> screen is unresponsive.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
> v2: Moved the call to aperture_remove_all_conflicting_devices to
>     right before drm_dev_register()
>
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/med=
iatek/mtk_drm_drv.c
> index a94c51a83261..02effd9fc698 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -4,6 +4,7 @@
>   * Author: YT SHEN <yt.shen@mediatek.com>
>   */
>
> +#include <linux/aperture.h>
>  #include <linux/component.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -670,6 +671,10 @@ static int mtk_drm_bind(struct device *dev)
>         if (ret < 0)
>                 goto err_free;
>
> +       ret =3D aperture_remove_all_conflicting_devices(DRIVER_NAME);
> +       if (ret < 0)
> +               dev_err(dev, "Error %d while removing conflicting apertur=
e devices", ret);
> +
>         ret =3D drm_dev_register(drm, 0);
>         if (ret < 0)
>                 goto err_deinit;
> --
> 2.43.0
>

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B16C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13F7010E3CD;
	Mon, 17 Aug 2026 12:34:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="cPzOPisL";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DB0910E3CD
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:34:41 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id F23101A16D0;
 Mon, 17 Aug 2026 12:34:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BA1EB60352;
 Mon, 17 Aug 2026 12:34:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 800DE11C7242C; 
 Mon, 17 Aug 2026 14:34:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786970074; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=t9jWyBdZdQwH82cE3h61208mFIq6dRzArIgnVLSJ74c=;
 b=cPzOPisLUuJiMMnHBWQ9zlXt5Hv8XNmuxnMeBNrFTwt+B5uhIswDTvmk+kyiHq30LUotLc
 gYxdwDOAkz5PZIN04PyMdHePxaFQ8Gq7XE9gZ/fgsQBD9i4gCqMm9e1C/Goj9ufsuVDdOo
 dYIXmWueCBUEDY55r0Rn80xsa9UpRajDX/a0vT2vBwp7wH88O4iBWbixJbiyQGCqV7+dB5
 K+QszE5kSju0gC2N015gO2hMVwOLYpq4No9F0yFKchikUXo4dtbVHWjrady16iWs+cX/3d
 Pj+CnqETtb8N56G52CSp56BOG1q/IAL7yjnI3B5dd2jAKuNP+tL6sLJfp7vb9g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 14:34:30 +0200
Message-Id: <DKR80T71W8LA.2VCYRMRT666RW@bootlin.com>
Subject: Re: [PATCH 08/11] drm/mcde: dsi: simplify device_node management
 using scoped for_each variant
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jessica
 Zhang" <jesszhan0024@gmail.com>, "Inki Dae" <inki.dae@samsung.com>, "Jagan
 Teki" <jagan@amarulasolutions.com>, "Marek Szyprowski"
 <m.szyprowski@samsung.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Hui Pu" <Hui.Pu@gehealthcare.com>,
 "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Linus Walleij" <linusw@kernel.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-8-19cd5277cc8d@bootlin.com>
 <CAD++jLkdF2wyWLtXnuO7egzwHqijtkGpd91SYT6Fhc++x9kf1g@mail.gmail.com>
In-Reply-To: <CAD++jLkdF2wyWLtXnuO7egzwHqijtkGpd91SYT6Fhc++x9kf1g@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Linus,

On Mon Aug 17, 2026 at 2:25 PM CEST, Linus Walleij wrote:
> On Fri, Aug 14, 2026 at 4:07=E2=80=AFPM Luca Ceresoli <luca.ceresoli@boot=
lin.com> wrote:
>
>> Before further modifying this function, simpify the struct device_node
>> management using the scoped variat of for_each_available_child_of_node()=
.
>>
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>
> This looks like it can be queued already irrespective of other
> patches,

Absolutely.

That's not the case for patch 9, which works only if patch 5 (or a better
future version of it) is applied.

So I'm all OK if you want to apply this patch.

> Reviewed-by: Linus Walleij <linusw@kernel.org>

Thanks!

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

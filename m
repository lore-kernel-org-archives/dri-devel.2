Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58339C5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 09:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3C1D10E101;
	Wed, 19 Aug 2026 09:53:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="yj5Es0c6";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04F7910E101
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 09:53:03 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 4B98A4E412D0;
 Wed, 19 Aug 2026 09:53:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 06F715FF42;
 Wed, 19 Aug 2026 09:53:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8819811C75589; 
 Wed, 19 Aug 2026 11:52:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787133175; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=SjXIs72QK5azP/b7Ud7PDBwyGS3GpesfQcCpzpeowVk=;
 b=yj5Es0c6gAhI+yYEgt42SUuug7t+mKeQKv9L60oQPIWBdboR8AoMGYbzHE64HmmzlY+JFE
 dvCqyXUjovopTi3wMZrFMbKn7Fld4/C3eBsI2qR6N6S8IaU0Dy+7Z40KHGjCataaeULq5l
 iSWVh6K4D+/+r+yRE46/jmaIQU+JRHUBI/yeYdlNxh8vOhxtlV4Q9nWGLXlWekzatOJXYY
 I1EyKc3tBGj2is4XrClsXjxygCk89dPf91WhGFvLAPu02wJLz+1Mt0cmPRH+t5gmlA36Hz
 40l43m3SqWEW8J/jxzfanB69IEvADfmF/u1WIKyQHhyuvZMw6xqouRgyHA9zQA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 11:52:44 +0200
Message-Id: <DKSTU1V8CI9T.1CILLIDVSCGTQ@bootlin.com>
To: "Svyatoslav Ryhel" <clamor95@gmail.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2 1/1] gpu/drm: bridge: tc358768: Add delay after PLL
 setup
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260625082507.57703-1-clamor95@gmail.com>
 <20260625082507.57703-2-clamor95@gmail.com>
In-Reply-To: <20260625082507.57703-2-clamor95@gmail.com>
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

Hello Svyatoslav,

On Thu Jun 25, 2026 at 10:25 AM CEST, Svyatoslav Ryhel wrote:
> After tc358768_setup_pll() enables PLL_CKEN and the lock indicator comes
> up, the DSI register sequence runs near immediately. On TF700T this

Do you refer to the Asus Transformer Pad TF700T here? Please add the full
name of the device.

> results in the bridge claiming PLL lock but producing no DSI video output=
:
> the panel powers up, the backlight comes on, but the framebuffer is never
> scanned out.
>
> Insert a small settling delay between PLL setup and the rest of the
> attach.
>
> Suggested-by: Michele Brocco <brocco@perceptos.de>
> Tested-by: Michele Brocco <brocco@perceptos.de> # TF700T
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/t=
c358768.c
> index 0f2820b37302..ea358c8da0e9 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -824,6 +824,9 @@ static void tc358768_bridge_atomic_pre_enable(struct =
drm_bridge *bridge,
>  		return;
>  	}
>
> +	/* Allow the PLL to settle */
> +	mdelay(20);

Why 20 ms, and not another amount? Is it backed by some datasheet? Or just
"it's what fixed my usecase"?

The extra delay is a panel requirement maybe, and definitely specific to
the specific hardware pipeline of the TF700T. Would it make sense to add a
DT property so only hardware needing a delay can add it, and add as much as
needed?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

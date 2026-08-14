Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFF5C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E8AB10E0AD;
	Fri, 14 Aug 2026 14:13:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="nJnzzwEE";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8B2F10E0AD
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:13:55 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 4EE244E41210;
 Fri, 14 Aug 2026 14:13:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 173316046D;
 Fri, 14 Aug 2026 14:13:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2EC3911C4EDC1; 
 Fri, 14 Aug 2026 16:13:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786716828; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ySXqbzKrAbyjeRdl5zFDEXT5GzptB9mSXKhF5NuCrhE=;
 b=nJnzzwEE/XmN+soscpiZXbBhCwXMVihFCosF2/IjQmTUuB8hCanVosp+trXdH82rg/C3AH
 BeHoZurWpZe/7uffZT1mbz8PPuUWEnhrT7i7msxsq0IfTgqPa9dLUZ58r1YwEkS/ne/LqJ
 W/wD8DT9f8pjrlf9T71OJv8KkvOCjdMozKniTpvXshnFWXGRC51sRpki4qFZAhuY6J7seM
 +ymUQzkHDeJQ5wRJU/9A3tUrS+hafNNtOgh76dH68zIqhNitaocz8Wp5IXOaqcme0HGuqs
 2ilTuq+5s18NK18mrbeuuq81qX1RpOAYLIJGqu6eh6212LaXpY9SjwhdXOciOA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Aug 2026 16:13:42 +0200
Message-Id: <DKOQ94UFQEIV.3RTO4CFHQZ2P7@bootlin.com>
Subject: Re: [PATCH 00/11] drm/panel: add a panel_bridge to every panel
Cc: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Hui Pu"
 <Hui.Pu@gehealthcare.com>, "Ian Ray" <ian.ray@gehealthcare.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jessica Zhang"
 <jesszhan0024@gmail.com>, "Linus Walleij" <linusw@kernel.org>, "Inki Dae"
 <inki.dae@samsung.com>, "Jagan Teki" <jagan@amarulasolutions.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
In-Reply-To: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
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

Hello,

On Fri Aug 14, 2026 at 4:05 PM CEST, Luca Ceresoli wrote:
> This series makes every drm_panel create a drm_panel_bridge wrapping it, =
as
> previously discussed [1][2].

I'm afraid I forgot adding an [RFC] tag to this series before
sending. Sorry about that.

> =3D=3D Series outline

[...]

>  2. Address circular module dependency that would arise in the following
>     commit [RFC!]
>
>       drm/panel: merge the drm_kms_helper module into the drm module
>
>  3. The main commit
>
>       drm/bridge: panel: add a panel_bridge to every panel

FYI, these two commits are those in the biggest need for comments.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

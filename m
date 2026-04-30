Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E1CFF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28A7E10F27A;
	Thu, 30 Apr 2026 07:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WgKHn8mu";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89B7110E0EF
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 07:53:17 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 452B94E42B8A;
 Thu, 30 Apr 2026 07:53:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 00C5F60495;
 Thu, 30 Apr 2026 07:53:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DC1981072816D; 
 Thu, 30 Apr 2026 09:53:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777535594; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Ey8gR43xKkL3Ku1urhZsLCjax+MlIzA5IqmKctUOGwQ=;
 b=WgKHn8muKRQOvtNLxgBiyLZcPI0N2j8tig6Bm7KhoGBRkBNULndkw67XtJdHUjlEubqvEf
 zceQncsMKCpyH/ZT0IUE/FaAzYohGDos2XExsxzaW+POLYTDXR2XwycDrA8HkFJP/Xx8Ov
 5NFz16EfKlpr/2iwBV0ql8gVpI1c5Kqq/+POIOcZlD9W+Pq4+uuy8XHQNDYg3CDcKB4bji
 5nDSbLmQDik+TLotELrznGCzLBQivFMlFZCt24i6mnCULF5VZIk3/djRcZDbHikFULv+g0
 v0RsjHXuzr0mSxEQ0f/X2PfkzX9kTteS63Z4Z3Zjr9QbI0WkbYIlJAyNtBjLjA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 09:53:08 +0200
Message-Id: <DI6BS0B8HTLP.2Q00QFIUQUZRU@bootlin.com>
Subject: Re: [PATCH] drm/bridge: lontium-lt8912b: Do not generate HFP
Cc: "Adrien Grassein" <adrien.grassein@gmail.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "David Airlie" <airlied@gmail.com>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Robert Foss" <rfoss@kernel.org>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Francesco Dolcini" <francesco@dolcini.it>, <max.oss.09@gmail.com>,
 "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "Neil Armstrong" <neil.armstrong@linaro.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20250728150059.2642055-1-max.oss.09@gmail.com>
 <20260429133333.GA68737@francesco-nb>
In-Reply-To: <20260429133333.GA68737@francesco-nb>
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

Hi Francesco,

On Wed Apr 29, 2026 at 3:33 PM CEST, Francesco Dolcini wrote:
> +Dmitry, Luca
>
> Hello all,
> how to get this patch considered and eventually merged? I see that this
> is not moving since long.
>
> Considering that Adrien Grassein is not visible on the mailing list
> since 2022, and that I have various HW available that is using this
> combination (on TI Sitara and Jacinto, on a DPI-DSI tc358768 bridge,
> and NXP i.MX), I have access to the (little) documentation that is
> available from Lontium I can propose myself as a maintainer here.

Thanks for volunteering! I am not a DRM maintainer, so I'll let others
chime in, but I suspect you should just send a patch to add yourself to the
MAINTAINERS entry and (as a separate patch?) remove Adrien, unless he
speaks up by then.

> I assume being able to ack patches would help the maintenance here, or
> is this just a glitch and a ping was enough?

dri-devel is flooded by patches, driver-specific ones will unavoidably be
missed in lack of a responsive maintainer. So this is not a glitch, it's a
frequent pattern I'm afraid.

As above, if you were in the MAINTAINERS entry, look at patches and comment
on them, and test on hardware that would be great IMHO.

For this one patch: it looks OK.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Adding the "why" would be better, which I assume to be power saving. No
need to sned a v2 just for that though.

I'm applying it in ~1 week. It would be good if you could check it still
applies on drm-misc-next before that, report back if it does, send a v2
(adding the "why") if it doesn't.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDFCFA0C3D
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 07:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B55E710E5CA;
	Wed, 15 Apr 2026 07:14:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="1jt44X/V";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0514110E5CA
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 07:14:02 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 669FC4E429FB;
 Wed, 15 Apr 2026 07:14:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 28D1860420;
 Wed, 15 Apr 2026 07:14:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C5B6B10451BC6; 
 Wed, 15 Apr 2026 09:13:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776237240; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=iygYfs8OpmDj7EArekkpuMFiF4SNkAQXIDO0MbSPk1k=;
 b=1jt44X/VHX7vc5fMwQRP6HQk0nq4iNKzijy4m3ZrruuZ7Cshdkf3HdB8EgDePX3j9pJEum
 WGcJkENB7V333mLkx4o/nx7giqakav5UhfdrDCTTS4GC4k0Y7HkBHRIJsWvnZVyNUF0wtH
 5NAv+Pq0CQZkc1QNhJc9cbvKN6hDD2/jl8WJMnuESumcp58+Pcr5QWrFfuRERqlk6zuMVF
 Yf2gMKUKPs1DQTdvXySbnoagMQXLPG2YErsOJuDU2to0O4OOyEuOWifoxJJe55FuI/v60c
 OtIVB4XmAUhDnU3DX8UUbQGcDh8BkEsuuhiNjZIqX+Csb36JI578kVRs8qEb2w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Apr 2026 09:13:52 +0200
Message-Id: <DHTJJRKD65L4.1P7X5O20V1W2Q@bootlin.com>
Subject: Re: [PATCH v3 1/1] drm: bridge: ti-sn65dsi83: Fix DSI mode flags
 for stable LVDS output
Cc: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <marex@denx.de>, <valentin@compulab.co.il>,
 <philippe.schenker@toradex.com>, <alexander.stein@ew.tq-group.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Sudarshan Shetty" <tessolveupstream@gmail.com>,
 <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260412053811.662461-1-tessolveupstream@gmail.com>
 <20260412053811.662461-2-tessolveupstream@gmail.com>
In-Reply-To: <20260412053811.662461-2-tessolveupstream@gmail.com>
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

Hello Sudarshan,

On Sun Apr 12, 2026 at 7:38 AM CEST, Sudarshan Shetty wrote:
> The current DSI mode configuration enables VIDEO_BURST and disables
> horizontal front porch (HFP) and back porch (HBP) transmission using
> MIPI_DSI_MODE_VIDEO_NO_HFP and MIPI_DSI_MODE_VIDEO_NO_HBP.
>
> However, the SN65DSI83/84 bridge relies on receiving full horizontal
> timing information over DSI in order to correctly reconstruct the LVDS
> output timings. When HFP and HBP are not transmitted, the bridge cannot
> recreate the required timing parameters, resulting in unstable or
> missing display output on some panels.
>
> Additionally, while burst mode is supported by the hardware, its use
> depends on continuous clock behavior from the DSI host. In practice,
> burst mode may introduce instability depending on the host controller
> implementation, as the DSI link may transition to low-power state
> between bursts.
>
> In testing, removing burst mode and ensuring full horizontal timing
> transmission results in stable LVDS output across affected panels.
>
> Update the DSI mode flags to:
>   - Drop MIPI_DSI_MODE_VIDEO_BURST
>   - Drop MIPI_DSI_MODE_VIDEO_NO_HFP
>   - Drop MIPI_DSI_MODE_VIDEO_NO_HBP
>
> This aligns with common system configurations where non-burst mode is
> preferred and full timing information is transmitted over DSI.
>
> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>

Thanks for having gone into the details and provide a good explanation for
the removal of these three flags.

It would be still great to have authoritative info from TI, possibly as an
update to the documentation.

I managed to test on a board with i.MX93, a TI SN65DSI84 and a 1920x1080p60
panel, and:

 - no image shown with the current mainline driver
 - it works by removing only MIPI_DSI_MODE_VIDEO_BURST (my current setup)
 - it works with this patch applied

Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com> # imx93 1920x1080p60

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

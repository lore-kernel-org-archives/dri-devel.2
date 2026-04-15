Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6828FA0C47
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 08:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40AD310E6B3;
	Wed, 15 Apr 2026 08:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="PwmHiPX+";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DD1D10E6A5
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 08:07:42 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 711A6C5AABF;
 Wed, 15 Apr 2026 08:08:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CCCB660420;
 Wed, 15 Apr 2026 08:07:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5417510451BC2; 
 Wed, 15 Apr 2026 10:07:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776240458; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=cSY2tIyXcuZuOelcL3Cqr3aN8E+YxAI8Sm5cELy+gE8=;
 b=PwmHiPX+F8ofsnKYyNtXxrLCvlu/Fj31sxBhVXJX8vXTEVm1EliSp8nsaTchrDtR0aaP9S
 XerBnyaldACNW9+VirY2vZycQpoIwUO3tTc+uXg+ihrTY2H6RXoPj2Xf+0e9hRpwOuHlHH
 EZlaONrjIoP/WzH3voEODKKDp8h54nxzVi9CJbCC/ORfK2RT+T2/w7a7distYC1eUPndeD
 bAvvSE5P4YD0k7B7zcNYKYG4gGKkVd0ot4QHufH4mv8iO/JVwr9kuIIgRbNba7W71LRD7L
 yG8UOj6tJn7C4DibnGkg5sMmgm9K5xL3oSzCgRsFcDSJx4A2FIcASRiDArJMzQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Apr 2026 10:07:32 +0200
Message-Id: <DHTKOUUOOLLA.BOA2FARZMJSB@bootlin.com>
Subject: Re: [PATCH v3 1/1] drm: bridge: ti-sn65dsi83: Fix DSI mode flags
 for stable LVDS output
Cc: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <marex@denx.de>, <valentin@compulab.co.il>,
 <philippe.schenker@toradex.com>, <alexander.stein@ew.tq-group.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Sudarshan Shetty"
 <tessolveupstream@gmail.com>, <andrzej.hajda@intel.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260412053811.662461-1-tessolveupstream@gmail.com>
 <20260412053811.662461-2-tessolveupstream@gmail.com>
 <DHTJJRKD65L4.1P7X5O20V1W2Q@bootlin.com>
In-Reply-To: <DHTJJRKD65L4.1P7X5O20V1W2Q@bootlin.com>
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

On Wed Apr 15, 2026 at 9:13 AM CEST, Luca Ceresoli wrote:
> Hello Sudarshan,
>
> On Sun Apr 12, 2026 at 7:38 AM CEST, Sudarshan Shetty wrote:
>> The current DSI mode configuration enables VIDEO_BURST and disables
>> horizontal front porch (HFP) and back porch (HBP) transmission using
>> MIPI_DSI_MODE_VIDEO_NO_HFP and MIPI_DSI_MODE_VIDEO_NO_HBP.
>>
>> However, the SN65DSI83/84 bridge relies on receiving full horizontal
>> timing information over DSI in order to correctly reconstruct the LVDS
>> output timings. When HFP and HBP are not transmitted, the bridge cannot
>> recreate the required timing parameters, resulting in unstable or
>> missing display output on some panels.
>>
>> Additionally, while burst mode is supported by the hardware, its use
>> depends on continuous clock behavior from the DSI host. In practice,
>> burst mode may introduce instability depending on the host controller
>> implementation, as the DSI link may transition to low-power state
>> between bursts.
>>
>> In testing, removing burst mode and ensuring full horizontal timing
>> transmission results in stable LVDS output across affected panels.
>>
>> Update the DSI mode flags to:
>>   - Drop MIPI_DSI_MODE_VIDEO_BURST
>>   - Drop MIPI_DSI_MODE_VIDEO_NO_HFP
>>   - Drop MIPI_DSI_MODE_VIDEO_NO_HBP
>>
>> This aligns with common system configurations where non-burst mode is
>> preferred and full timing information is transmitted over DSI.
>>
>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>
> Thanks for having gone into the details and provide a good explanation fo=
r
> the removal of these three flags.
>
> It would be still great to have authoritative info from TI, possibly as a=
n
> update to the documentation.
>
> I managed to test on a board with i.MX93, a TI SN65DSI84 and a 1920x1080p=
60
> panel, and:
>
>  - no image shown with the current mainline driver
>  - it works by removing only MIPI_DSI_MODE_VIDEO_BURST (my current setup)
>  - it works with this patch applied
>
> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com> # imx93 1920x1080p60

And tested on a i.MX8MP board too, with a different 1920x1080p60
panel. This one was working without the patch and is equally working with
the patch applied.

Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com> # imx8mp 1920x1080p60

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

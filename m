Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B34F483C9
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A4B210E4C3;
	Mon, 23 Mar 2026 16:15:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Y9Q5yK4w";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BA9410E4C1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:15:12 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 78FFAC58083;
 Mon, 23 Mar 2026 16:15:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 821D7601A0;
 Mon, 23 Mar 2026 16:15:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BC02710450FE5; Mon, 23 Mar 2026 17:14:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774282506; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=L93GLqLus5B8kLAj3bNWOHqwo3TpCpr9wsx8jieRi1E=;
 b=Y9Q5yK4wSxbiIxPpWmJBuauTLMPubXYCTglW000y3lpGh25SszpOYvUrxJuQECba/o2q1l
 TjuoLvy2B7i+go4faD59gCap17AtHWUaqSeq5NMW/ms6zrQ5Tz4kcdXIWZbIB2lMNrDhzj
 35dSPmVEiJTV/JXx2gXhAxV3IitA7Dn1L9CRdCTrkwrJ8Z9K/pOtEJVAKDl74Wpf4CS9nW
 P7VoidWaZhEsqS0s3HmOvrCuxYGgp0bACrvOjA7DyCOoXBkpv153f9Q3RuRa1eUhtR7AiM
 4iUu6RfXa4LN9MLMyH9RmxXQCWhrLZpVaHWh8Iq3HEktUyhE41vVtz58WeRNMQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 17:14:50 +0100
Message-Id: <DHAANFJ6QZKU.5NN7RD47T8TI@bootlin.com>
Cc: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <nicolas.frattaroli@collabora.com>,
 <alchark@gmail.com>, <cristian.ciocaltea@collabora.com>,
 <sebastian.reichel@collabora.com>, <kever.yang@rock-chips.com>,
 <heiko.stuebner@cherry.de>, <tomeu@tomeuvizoso.net>, <amadeus@jmu.edu.cn>,
 <michael.riesch@collabora.com>, <didi.debian@cknow.org>,
 <dmitry.baryshkov@oss.qualcomm.com>, <dianders@chromium.org>,
 <m.szyprowski@samsung.com>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>
To: "Damon Ding" <damon.ding@rock-chips.com>, <hjc@rock-chips.com>,
 <heiko@sntech.de>, <andy.yan@rock-chips.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2 7/9] drm/bridge: analogix_dp: Rename and simplify
 is_rockchip()
X-Mailer: aerc 0.20.1
References: <20260319104031.1986946-1-damon.ding@rock-chips.com>
 <20260319104031.1986946-8-damon.ding@rock-chips.com>
In-Reply-To: <20260319104031.1986946-8-damon.ding@rock-chips.com>
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

On Thu Mar 19, 2026 at 11:40 AM CET, Damon Ding wrote:
> Rename is_rockchip() to analogix_dp_is_rockchip() for naming consistency
> and readability, and simplify the code with switch.
>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> Suggested-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

The patch content is OK:
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

However this won't apply without [0], correct?

So, worth mentioning in the cover letter that this series depends on the
[0] series.

[0] https://lore.kernel.org/all/20260319071452.1961274-8-damon.ding@rock-ch=
ips.com/

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

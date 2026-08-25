Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEBDC61DB4
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A8DB10E9D0;
	Tue, 25 Aug 2026 10:29:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="g/RI7u33";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E72F10E9D0
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 10:29:48 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 8AE6B4E412E5;
 Tue, 25 Aug 2026 10:29:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5652D604C4;
 Tue, 25 Aug 2026 10:29:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3FE7411C7A421; 
 Tue, 25 Aug 2026 12:29:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787653781; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=JGBFtUtJW7Q1eT+UC3LLB2zRK/feS4sxhZgOiIWSH4k=;
 b=g/RI7u33Vl0dfzQMHPpzKeBjPRViB9uVUBsdA0YXWKZ7LSBMNi5m9gGcN9nkXUN2xi598+
 ZPyMzNk/bmh8EvR5ITvc3xsma6Y/w/NlPb6yKcjcuF/QTatHGoCQfxJaiO8nZkLQ99/j8s
 zNXocDYZnhJqofw404ZpT8k00G1/eT3L1Rv1tqD/t7Eo814tuqC8Ic1eUoKKccRC7rBswz
 UWCdGwzCmh7YLGz0fGu1mJO3DN2OzFb8J0UVI3F7cRE4sCcnhciVZRmU0PnYa+qpJbjwiw
 kmFecGaxlEUuPWQo0FxNGRCYo7eiIpHCgzOb6Ut9rA9Cc56YDrC5ZlqvIiRLfA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 12:29:29 +0200
Message-Id: <DKXYDGIP3KRX.3AJ5KBX7VI2M7@bootlin.com>
Subject: Re: [PATCH v1] drm: bridge: dw_hdmi: Fix constant truncation
 warning on phy_mask
Cc: "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca
 Ceresoli" <luca.ceresoli@bootlin.com>, "Liu Ying" <victor.liu@nxp.com>,
 "Jani Nikula" <jani.nikula@intel.com>, "Shengjiu Wang"
 <shengjiu.wang@nxp.com>, "Javier Martinez Canillas" <javierm@redhat.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Sean Chang" <seanwascoding@gmail.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260819151216.56833-1-seanwascoding@gmail.com>
In-Reply-To: <20260819151216.56833-1-seanwascoding@gmail.com>
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

On Wed Aug 19, 2026 at 5:12 PM CEST, Sean Chang wrote:
> In dw_hdmi_probe(), casting the bitwise complement of (HDMI_PHY_HPD |
> HDMI_PHY_RX_SENSE) directly to u8 triggers a compiler warning
> (-Wconstant-conversion).
>
> Due to C integer promotion rules, the bitwise OR and bitwise NOT are
> evaluated as 32-bit signed integers, producing 0xFFFFFF0D before being
> cast down to u8.
>
> Fix this by explicitly masking the inverted 32-bit result with 0xFF
> to keep only the lower byte and prevent implicit upper-bit truncation.
>
> Signed-off-by: Sean Chang <seanwascoding@gmail.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

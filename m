Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163BAC5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AD1410F1D3;
	Thu, 13 Aug 2026 07:51:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="KaayYQY+";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 607DD10F1D3
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:51:50 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id B20B24E411E0;
 Thu, 13 Aug 2026 07:51:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 79A15602B8;
 Thu, 13 Aug 2026 07:51:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3953711C4DA71; 
 Thu, 13 Aug 2026 09:51:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786607506; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=FKh/8+SfO495U80CNy6JuxwZlf79jZQTNJGu0uja1G0=;
 b=KaayYQY+zqv+r6+t04gqYdwL4yBQAhx6yeVi3CUY3Fw04/ywU8X6MxsKc4AGhTKsyBE98Y
 2VbK67KZntLf6dMrloaWzdpbd8RTPXf0m4opEkD1Ebs7CMI0Q+tQBPr4mJw+VeASdBYPFN
 oxrxGjzvFAZLy+sYdbDYoInwtst6Ryt8+WtY8Wyz2V+GbMc5HJ1Ae1D+LG2+BcbNTXuIzZ
 KObuwoQAJwjAZ8jxjlC/YhkypvKXua2wq2pPKTTr40UoCiGrX2ZxtcAQrAzDHTe1S/llRD
 +w/clQQqI1WoYyBeD3E16D8zk0GgulW5c6pzBasdwPBkTHbqDT8EOxKOjlzu5g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Douglas Anderson <dianders@chromium.org>, 
 Damon Ding <damon.ding@rock-chips.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Harikrishna Shenoy <h-shenoy@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Kees Cook <kees@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Pan Chuang <panchuang@vivo.com>
In-Reply-To: <20260723131649.134127-1-panchuang@vivo.com>
References: <20260723131649.134127-1-panchuang@vivo.com>
Subject: Re: (subset) [PATCH 00/10] drm/bridge: Remove redundant error
 messages on IRQ request failure
Message-Id: <178660749514.216710.14432095187610483140.b4-ty@b4>
Date: Thu, 13 Aug 2026 09:51:35 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
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


On Thu, 23 Jul 2026 21:16:32 +0800, Pan Chuang wrote:
> Commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()") added automatic error logging to
> devm_request_threaded_irq() and devm_request_any_context_irq()
> via the new devm_request_result() helper, which prints device
> name, IRQ number, handler functions, and error code on failure.
> 
> Since devm_request_irq() is a static inline wrapper around
> devm_request_threaded_irq(), it also benefits from this
> automatic logging.
> 
> [...]

Applied, thanks!

[01/10] drm/bridge: analogix_dp: Remove redundant dev_err()
        commit: 2132c69fa0a05b66824714fc17dbfd1d2f93ef86
[02/10] drm/bridge: cdns-mhdp8546: Remove redundant dev_err()
        commit: ee4cb1090310e56f5a1a5cf13bbedafb4f786751
[03/10] drm/bridge: lt9611: Remove redundant dev_err()
        commit: fa5cbeccd5e49ac165af3487741b61f94b5a5d06
[04/10] drm/bridge: samsung-dsim: Remove redundant dev_err()
        commit: 27860b5f974f412ee92ca44538f402d1cf1141c5
[05/10] drm/bridge: synopsys: dw-dp: Remove redundant dev_err_probe()
        commit: c4d6efe7364de4f68ed54fd654bd79b4c14979f3
[06/10] drm/bridge: tc358767: Remove redundant dev_err()
        commit: d265c80cbfc5a0df93c64106d3db1689d09b2ea3
[07/10] drm/bridge: it6505: Remove redundant dev_err()
        commit: d81e374f453de961662296905e77260048446f2d
[08/10] drm/bridge/sii8620: Remove redundant dev_err_probe()
        commit: b0899db1a492a6830a6cf5cfe12349f45f866549
[09/10] drm/bridge: ti-sn65dsi83: Remove redundant dev_err_probe()
        commit: c9a2c8ddcd65e96e7f095a87c0cc0b3211f740ea

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



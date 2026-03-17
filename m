Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F49FED9F6
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A13F510E5DF;
	Tue, 17 Mar 2026 17:29:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="MKT7yYSc";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71ED210E5DF
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 17:29:14 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 314551A2E71;
 Tue, 17 Mar 2026 17:29:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EE1775FC9A;
 Tue, 17 Mar 2026 17:29:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E2CF910450651; Tue, 17 Mar 2026 18:29:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773768551; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=cRVoOWLPKWuFETrlnWJFPl+sm1jQGU97ogkoEGJ4v04=;
 b=MKT7yYScc1mVn4B8hX7dotZvhbNzUqQvmXPtROurRqhVBUsCMYfakCzc0J6KJe1ebBJLin
 HDLgh9oyBoxLdEqyPMd0S0MtdwbDX208vMjJrQlhulkRFGIss/a4di4cSkwBw5ageIDUnY
 JAojp3Yjj5rdhgjbWc6wRK1giBdKK+uc/PIUYzKILfgxZiGcfIkGZpim8Yrhu0iEhd91TN
 kBaz0woJtsdIBE11VQGnpUOMfDErE0nyc2QQYVxJnyZ42msmsKHcIzs9i3ho4o62HllK3u
 G1I5cGBFUYcbP2LEwVHUMl4UwQYLmSqwcyKxv/t15Wr4bpYzLFZEgPMWwH6QrA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Detlev Casanova <detlev.casanova@collabora.com>, 
 Douglas Anderson <dianders@chromium.org>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Sugar Zhang <sugar.zhang@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20260228112822.4056354-1-christianshewitt@gmail.com>
References: <20260228112822.4056354-1-christianshewitt@gmail.com>
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi-qp: fix multi-channel audio output
Message-Id: <177376854105.1901972.15709099301544999005.b4-ty@bootlin.com>
Date: Tue, 17 Mar 2026 18:29:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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


On Sat, 28 Feb 2026 11:28:22 +0000, Christian Hewitt wrote:
> Channel Allocation (PB4) and Level Shift Information (PB5) are
> configured with values from PB1 and PB2 due to the wrong offset
> being used. This results in missing audio channels or incorrect
> speaker placement when playing multi-channel audio.
> 
> Use the correct offset to fix multi-channel audio output.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: dw-hdmi-qp: fix multi-channel audio output
      commit: cffcb42c57686e9a801dfcf37a3d0c62e51c1c3e

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


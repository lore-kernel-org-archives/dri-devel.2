Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DFBED7B9D
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 10:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 789BB10E443;
	Tue, 14 Apr 2026 10:35:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="h57t1l5Q";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D34210E443
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 10:35:25 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 8DB0CC5AA9D;
 Tue, 14 Apr 2026 10:36:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 80B935FFBB;
 Tue, 14 Apr 2026 10:35:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F328610450E1B; 
 Tue, 14 Apr 2026 12:35:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776162922; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=9IFAkSOFl3Fe8DBfy3FPEFfSzWS/W/Jp51ROqYyJGDU=;
 b=h57t1l5Q9M447Q2KGx5eypXeu4l7lB3AHt31SZOe/CoMt37LhnWm66bDhaicSQCr5gH1xZ
 nRbjphb8W6jsjG8RvDTdKpvhrp1nXo8qAYCIGVj1LIesC6XT/uLj+nz4+UGXpFtPBd2bS5
 r7mU9zkpc88zjp2ZOI/9qmwFf92grsYn129w4yjBJc00WosAuLwnz7SgPgjDu4MQYvJXbr
 2ckFX2S5v2Kg6vJ3GvYiP0OACyyZsF+OI7ZpNFSLROw8oKLDFMerVPpBUIXkihtkMhwa+O
 Jdb4jjVMLCkj3bgW4N1xsnq1OBoELHvcapqOh5NKWGNmwdYFB6Q+ijCxlttoTQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Douglas Anderson <dianders@chromium.org>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Kees Cook <kees@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Osama Abdelkader <osama.abdelkader@gmail.com>
In-Reply-To: <20260403145208.15890-1-osama.abdelkader@gmail.com>
References: <20260403145208.15890-1-osama.abdelkader@gmail.com>
Subject: Re: [PATCH v2] drm/bridge: dw-mipi-dsi: Fix bridge leak when host
 attach fails
Message-Id: <177616291553.682248.11063878080834534262.b4-ty@b4>
Date: Tue, 14 Apr 2026 12:35:15 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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


On Fri, 03 Apr 2026 16:52:05 +0200, Osama Abdelkader wrote:
> dw_mipi_dsi_host_attach() and dw_mipi_dsi2_host_attach() call
> drm_bridge_add() before pdata->host_ops->attach(). If attach fails,
> the bridge stayed registered without drm_bridge_remove(), leaking the
> bridge reference and leaving the device on the global bridge list.

Applied, thanks!

[1/1] drm/bridge: dw-mipi-dsi: Fix bridge leak when host attach fails
      commit: be19b43f92fae4794f271ed9e338bdbcfa725aa2

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


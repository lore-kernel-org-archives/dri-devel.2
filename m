Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3244CD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A0210E384;
	Tue, 19 May 2026 08:45:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="z9ishCiy";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93DBC10E257
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:45:09 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 0EFAB1A3621;
 Tue, 19 May 2026 08:45:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CCFAA606E9;
 Tue, 19 May 2026 08:45:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2116511AF8B70; 
 Tue, 19 May 2026 10:45:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779180306; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=JWHCHEcz5tAU0rcu+nUNJLEsb84bX0BSdluBtZFXTzI=;
 b=z9ishCiyREuR8OqkTa/ky1lbGbcOBWCZVgSXg5d+XsDDT5K+Jw/+ijU2Q+N+Avd8kvKMve
 05u2nFC45DjTKlu6JC7AH+AZg6cgkZAjtPnjU7AtVNlVE95tgkYZhVDExz6UaeBDo8IA5J
 NXgz1R2lMfgcuJhyoiq25Qj1+MQzVyZ95lxiNUUQmmx2i6aUZZDLf5IIH3Kj41Y1YbkFFN
 4H5Eg+KqDN5ORoVaBj/Ne45MWmn/CVQCQWGo32WUGcxnluYNqpmldgaDvVQ82qZ/J5g2Ez
 npGcy7XlRXfVbFnlD6+0+qI+kRLaaW/o/sOLp032IhTXeBNEIh5Ye/BoswptkA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260430194944.78119-1-osama.abdelkader@gmail.com>
References: <20260430194944.78119-1-osama.abdelkader@gmail.com>
Subject: Re: (subset) [PATCH v4 1/2] drm/bridge: chipone-icn6211: use
 devm_drm_bridge_add in i2c probe
Message-Id: <177918030157.161420.8280837915282020004.b4-ty@b4>
Date: Tue, 19 May 2026 10:45:01 +0200
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


On Thu, 30 Apr 2026 21:49:42 +0200, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe
> fails after registration, and drop drm_bridge_remove() in chipone_i2c_probe.

Applied, thanks!

[2/2] drm/bridge: chipone-icn6211: use devm_drm_bridge_add in dsi probe
      commit: b11a6cea91f2cec688936d591548bc5c1540c648

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DC4CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 14:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B06C310E415;
	Tue,  5 May 2026 14:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="vFHd9xpe";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37ADC10E415
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 14:38:38 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id AFC7F1A3511;
 Tue,  5 May 2026 14:38:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 836936053C;
 Tue,  5 May 2026 14:38:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 76FB511AD0239; 
 Tue,  5 May 2026 16:38:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777991915; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=vdjcD+3w1/eDo7k74qowwM3MW8AI528WqtNg+2SI6eI=;
 b=vFHd9xpe+kHwdStSoSe5zQIiLaN0hax4NBZhRYFXQB+kdzsE6Fvbt81TJh7YE3A7YBZmZg
 CIaXiUFICZOYyfM7T/tyhrDHU7dQO2B/VWQ+2bn2Sd3/VZPQiebRUDuIXV12Kyg1Ys336x
 /wxlAxDxCHLo7uDKzJtd9uqhQWcw5TqIBVbWW6cPnwl1qxuOE1M54VnlNoftPeo5dBJ/GK
 Mq16T9eNFggErlbMLrZaxq/s7phk0/+XnG6jv3dQewTiKnf/WSnrOmftOreAwbmTwiyKR4
 Hpgq4etFmRHPFLzZPnDQZh32Vn4wRayN8bhb7BerAgXnAds3EbWg4Pwwewpakw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5] drm/bridge: cdns-dsi: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Vitor Soares <ivitro@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vitor Soares <vitor.soares@toradex.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, stable@vger.kernel.org
In-Reply-To: <20260505134705.188661-2-ivitro@gmail.com>
References: <20260505134705.188661-2-ivitro@gmail.com>
Date: Tue, 05 May 2026 16:38:24 +0200
Message-Id: <177799190412.1203717.2443652106247895131.b4-review@b4>
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

On Tue, 05 May 2026 14:47:05 +0100, Vitor Soares <ivitro@gmail.com> wrote:
> drm/bridge: cdns-dsi: Replace deprecated UNIVERSAL_DEV_PM_OPS()

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>

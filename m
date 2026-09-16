Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F42CC88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA79710E992;
	Wed, 16 Sep 2026 12:59:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="pK3r9GXh";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4CE810E992
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 12:59:00 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 6CAE81A08D2;
 Wed, 16 Sep 2026 12:58:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3E34960337;
 Wed, 16 Sep 2026 12:58:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AF91A11C7B026; 
 Wed, 16 Sep 2026 14:58:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789563534; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=lAtwGYoWQXq96+JGmh19RpCOxihvyL82+P6fbhIjFa0=;
 b=pK3r9GXhKxqvNBh+uXILARiAUr9bhSEdv0vJJifmx/ebx+SuLs+bXIXjJy67VEPVdgnY1Q
 7AkcL2rt0Y/jStyrLfNUVtlBPHpGJgYBVSICCCf+NjobsPdCflSSuWXP3urs6IPIkzxjH0
 DQUtAWbfaBGfTCMmqH3LqypBrXnm+oWtWU13ywX7j4qapnCiJVfeYWsqy8QZnLeW/GiTJn
 9f89qVNrRoVk+uyxjhV8MC1TbpoE6KwvTXhPaLyOVVGyXZGmC7Wvo2c6e6HGScC4G2xxzU
 LDD91wzOvieAN+EQVb76w9XKzpZjBKCJLgg9KKhq3BeVvFbIBwcrc+xb3UdmOA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Albert Esteve <aesteve@redhat.com>, 
 Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
References: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
Subject: Re: (subset) [PATCH RFC v2 00/19] drm/panel: embed a drm_bridge
 into every drm_panel
Message-Id: <178956352643.382952.1141486827113876827.b4-ty@b4>
Date: Wed, 16 Sep 2026 14:58:46 +0200
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


On Thu, 03 Sep 2026 10:11:03 +0200, Luca Ceresoli wrote:
> This series embeds a drm_bridge into every drm_panel, as previously
> discussed [1][2] and in v1.
> 
> This will allow bridges and encoders to interact with the next pipeline
> component always with the bridge API, not caring whether it is a panel or
> another device (e.g. a bridge from a bus to another bus).
> 
> [...]

Applied, thanks!

[15/19] drm/omap: dsi: remove unused includes
        commit: dd8950786bd24315d1a650b1b3c6ebe7ff026e76
[17/19] drm/tve200: remove unused includes
        commit: acb05c825e393b0584adb5472bfbb17c8033a99f

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



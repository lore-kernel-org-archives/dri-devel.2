Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0C4CD342C
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 10:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FBF510E3A4;
	Mon,  4 May 2026 10:34:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Lta76662";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F4610E3A4
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 10:34:39 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 180994E42BBC;
 Mon,  4 May 2026 10:34:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E00FD5FD5F;
 Mon,  4 May 2026 10:34:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1FFCF11AD266E; 
 Mon,  4 May 2026 12:34:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777890876; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Koav5DTC4vGTWTUtVC/t+/VrEALIrhI+k8FnR7rv1qY=;
 b=Lta7666245WFGw8GKMKyUhzh6nB+w7o8dFV3V4nKHh+XZ9uNeCV1CPs/wZOwZNWV1rYUfs
 hkwQX4xN6yqa5IajwMsv3b0ujoX4+YY2ohUFqsLfv0I36DGIzFr4gbehQc2hpvGgHQ3ch0
 ZrzddYoDEPADw+OWcAbm60Cghzk4AmS1naGZo6cTklopckwrqLIcrcoLT3AvBANVGnIWaM
 T9bnJQHt7nlowtoMarbFyRFXyf4dmtSarpjy2gXQKhnYaeoFJamO5h7kp6SJTv5gHPiES0
 ULAdoo8Gu7bDC7jf+4wywlQX1KLkT3zTT6HsuLTUJR79u6NpXrjXQju/8mTvjw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>, 
 Linus Walleij <linusw@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260416-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v3-0-143886aebc6b@bootlin.com>
References: <20260416-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v3-0-143886aebc6b@bootlin.com>
Subject: Re: [PATCH v3] drm/bridge: ti-sn65dsi83: two fixes + add test pattern
Message-Id: <177789087185.275106.17946042535609363566.b4-ty@b4>
Date: Mon, 04 May 2026 12:34:31 +0200
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


On Thu, 16 Apr 2026 15:59:54 +0200, Luca Ceresoli wrote:
> This series used to have two bug fixes, now applied to drm-misc-fixes, and
> a patch adding support for enabling the test pattern output from userspace,
> which is now at v3.

Applied, thanks!

[1/1] drm/bridge: ti-sn65dsi83: add test pattern generation support
      commit: 55a412e3a78104036bbb1036e2ebe8fa4fb41770

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


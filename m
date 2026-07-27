Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6BFC531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B33E010E2D6;
	Mon, 27 Jul 2026 13:52:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="xEcD7EIL";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75F2E10E3F9
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 13:52:05 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id D174B1A1285;
 Mon, 27 Jul 2026 13:52:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 992BF601BE;
 Mon, 27 Jul 2026 13:52:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 33ED511C13452; 
 Mon, 27 Jul 2026 15:51:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1785160317; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=7JBXk2jXtQsOJF65QCitE7vlw/YO5M+3O4WO4XdbtAs=;
 b=xEcD7EILK4mpt5O6ZSHTjHiqPPMIIRZxC/FgQm65soRs6gzWBfNlO8wHkmhWBY+YKn/B9l
 AE+3w1ds0octEPRy7A8Ic3YMx7VL49qutGwvZNxcPMII1eImu9Q0em+hKnojUqwyf2zWCF
 ptQsw5eGRruB8MBHRz2r9bMyiPSBylwRZ6sk8x+g+sl9cHAykb+dcO+TbWqdlWNF97BlLK
 tTTSSk3Cj6Zb4NVIEmSe9uxFnT2lsUfwulDoraD1znG1sRvamPvXnG3GDT1edHwPAjmAcL
 e5z6kyufS28sIhhLT3wIN8D6Wc7QXuzUuv0Z9tcFPuZILISCbT6HJEwxb1Z43Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jagan Teki <jagan@amarulasolutions.com>, Liu Ying <victor.liu@nxp.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 Peter Senna Tschudin <peter.senna@gmail.com>, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Martyn Welch <martyn.welch@collabora.co.uk>, 
 Russell King <linux@armlinux.org.uk>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Jani Nikula <jani.nikula@intel.com>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Xin Ji <xji@analogixsemi.com>, 
 Marco Crivellari <marco.crivellari@suse.com>, Arnd Bergmann <arnd@arndb.de>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>, 
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Kees Cook <kees@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
In-Reply-To: <cover.1784545092.git.u.kleine-koenig@baylibre.com>
References: <cover.1784545092.git.u.kleine-koenig@baylibre.com>
Subject: Re: (subset) [PATCH v2 0/3] drm: Use named initializers for arrays
 of i2c_device_data
Message-Id: <178516030634.1134541.480483848560598607.b4-ty@b4>
Date: Mon, 27 Jul 2026 15:51:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Mon, 20 Jul 2026 13:25:46 +0200, Uwe Kleine-König (The Capable Hub) wrote:
> the objective of this patch set is to prepare drm for a change to
> i2c_device_id. See
> https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
> for the details.
> 
> (Implicit) v1 is available at
> https://lore.kernel.org/dri-devel/20260518100401.631351-2-u.kleine-koenig@baylibre.com
> 
> [...]

Applied, thanks!

[1/3] drm/bridge: Use named initializers for arrays of i2c_device_data
      commit: a2a334802883908ee86e0571faf5e9ea6a008c3a

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



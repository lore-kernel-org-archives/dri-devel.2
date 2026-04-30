Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9719ECD13D3
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D73FD10E00F;
	Thu, 30 Apr 2026 07:17:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WoOX+do3";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44C6710E00F
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 07:17:53 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id B50A94E42B73;
 Thu, 30 Apr 2026 07:17:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7F51B60495;
 Thu, 30 Apr 2026 07:17:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 01BEB10729FC2; 
 Thu, 30 Apr 2026 09:17:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777533470; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=fYZocCmk4lmGT9EFNgIlV7nk5A86HLgtF421diFCKSM=;
 b=WoOX+do3yybdEoFa7DAreeKsB6INbX37cr/NMH09jHfWInuntO3hyNCUd8njgEQQ/8q/nq
 +tJqUn/Te3H74VIoNZ5vFcOST8/qL1g/4YAgf2r6sXRQGlylKocFF3J6LAxZfyw1O2YE2k
 ACnNoz6aVp83gthH0GjBF7cr8a61DO/As8QDY0cRWoMZTXve+riChb5T2R21uOL97JGRt1
 g/M6amic3c8jEiyHpDiMsR0waP3nAGsxXB4Efw8McSyi6LcdYbMxwRgbkO7xkJgoURjY/O
 VW2OyV2jpCUUZHFAC/66EihwcmU391sA7D+A+/8qIVCX3FFBkJGc5X5u2q1m8w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 09:17:40 +0200
Message-Id: <DI6B0UNV68LI.3PYKFFB0F1DH6@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] drm/ipv3: add CONFIG_OF dependency for
 DRM_OF_DISPLAY_MODE_BRIDGE
Cc: "Arnd Bergmann" <arnd@arndb.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>,
 <dri-devel@lists.freedesktop.org>, <imx@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
To: "Arnd Bergmann" <arnd@kernel.org>, "Philipp Zabel"
 <p.zabel@pengutronix.de>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Frank Li"
 <Frank.Li@nxp.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Damon Ding"
 <damon.ding@rock-chips.com>
X-Mailer: aerc 0.20.1
References: <20260429140024.192432-1-arnd@kernel.org>
In-Reply-To: <20260429140024.192432-1-arnd@kernel.org>
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

On Wed Apr 29, 2026 at 4:00 PM CEST, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Without this, not all dependencies are met here.
>
>   Depends on [n]: HAS_IOMEM [=3Dy] && DRM [=3Dy] && DRM_BRIDGE [=3Dy] && =
OF [=3Dn]
>   Selected by [y]:
>   - DRM_IMX_PARALLEL_DISPLAY [=3Dy] && HAS_IOMEM [=3Dy] && DRM [=3Dy] && =
DRM_IMX [=3Dy]
>   - DRM_IMX_LDB [=3Dy] && HAS_IOMEM [=3Dy] && DRM [=3Dy] && DRM_IMX [=3Dy=
] && COMMON_CLK [=3Dy]
>
> Fixes: ba2db93cf3d5 ("drm/bridge: Move legacy bridge driver out of imx di=
rectory for multi-platform use")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

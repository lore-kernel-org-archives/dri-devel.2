Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B63AFF8875
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CF5810E2A2;
	Wed, 29 Apr 2026 11:39:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="zVkIdRfP";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E044810E2A2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 11:39:33 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 5B764C5EF22;
 Wed, 29 Apr 2026 11:40:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1F12B601DF;
 Wed, 29 Apr 2026 11:39:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BC45310729BD5; 
 Wed, 29 Apr 2026 13:39:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777462767; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=YDJnA5+mFaO5n0Q+22A7+P3Kisgt2i8ACTxIqS2VQvg=;
 b=zVkIdRfPPjnJ/gzHfz2y+sABS9kT3XhEHE9Yon2ZkOe6JNla5d4bIzU9LoyV1yRl/8RGK3
 4TFer2NL+293rN6DzNUEYsqKGYztCqSVQhKXDDLGvZaWC/tPFTSarC6QgpXf2ylE2jNlYO
 0Wd/bxOe1PhWphIE/InvPDOHx+6/TzoVCWAxVbgq/amyglCiFyMp819eE8sVS8YxWQKAEb
 elHnB5CfyBcP/79WgJRtetJRn4ZYSsJ/M+YRe9k0O/JYSfrfv2Dsh6HPBVS00C6+FgLof3
 6S8IiD99/HADYJ9JCfD+2cXpmBeMqXtPwqBd/b96Gt51ZxayB5XpPs7xAX8V4A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 13:39:22 +0200
Message-Id: <DI5LYOKX7578.3O0V5KDB32VKF@bootlin.com>
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Jagan Teki"
 <jagan@amarulasolutions.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert Foss"
 <rfoss@kernel.org>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 2/2] drm/bridge: chipone-icn6211: use
 devm_drm_bridge_add in dsi probe
X-Mailer: aerc 0.20.1
References: <20260423200604.324615-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260423200604.324615-1-osama.abdelkader@gmail.com>
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

On Thu Apr 23, 2026 at 10:06 PM CEST, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe fails after
> registration, and drop drm_bridge_remove() in chipone_dsi_probe.
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
> v3: split the patch into two, one for i2c probe (bugfix) and one for dsi =
probe
> v2: devm_drm_bridge_add instead of drm_bridge_add

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

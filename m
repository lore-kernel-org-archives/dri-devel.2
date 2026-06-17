Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CACECD98F3
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3CE210E9EB;
	Wed, 17 Jun 2026 16:02:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="BSoCe4w+";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E44CD10E85C
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 16:02:32 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 168D4C2B9F3;
 Wed, 17 Jun 2026 16:02:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0EEF8601AA;
 Wed, 17 Jun 2026 16:02:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6AF99106C8548; 
 Wed, 17 Jun 2026 18:02:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781712150; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=MQMqD5cZTCvaXH97q75Yxdd26SuY/ux8Bv6dd0zCd8s=;
 b=BSoCe4w+zY2BuaKURiAE+e3mvYkp0JxFfDk5BpzxiapJ5hvNHUIVylUHj3bW3y3itnEWlT
 EW3CC3jwpMQfHcQbz5xhaGQVDS/qw8S6sVcUyK3zXKG4/Q2Q+8CH5X3JDBG0v5pvSoOaGY
 dFWb0VjR4v6AY69hOgfQYV4HwTIM0LGmF5bXfRyqIcue23cWBoiMnKoY9bp44hLCaPFyQo
 2AKjO0B8uQyQrc35T07cGuF7lHgdXTwrv/aI+YJysQZqJb1ELnRc00GluQYRhXe9Xba0/c
 9Yq17GlNbgutab/8C+4uN81ZISfJg7qmFUTzAH+llHLEYL6oNOfvMSnWFTWv9g==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 02/78] drm/bridge: cdns-mhdp8546: Return an error
 pointer on allocation failure
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>, 
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-2-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
 <20260608-drm-no-more-bridge-reset-v2-2-0a91018bf886@kernel.org>
Date: Wed, 17 Jun 2026 18:02:16 +0200
Message-Id: <178171213660.312625.302682121474138086.b4-review@b4>
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

On Mon, 08 Jun 2026 16:35:44 +0200, Maxime Ripard <mripard@kernel.org> wrote:
> The drm_bridge_funcs.atomic_reset documentation states that the hook
> must return either a valid drm_bridge_state object or an ERR_PTR().
> 
> The cdns_mhdp_bridge_atomic_reset() callback returns NULL when the
> allocation of its state fails, violating this contract.
> 
> Return ERR_PTR(-ENOMEM) instead.
> 
> [...]

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


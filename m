Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1F5CD98F2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:02:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4951D10E839;
	Wed, 17 Jun 2026 16:02:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="I2qNLxni";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4567810E839
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 16:02:30 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id F13F31A396F;
 Wed, 17 Jun 2026 16:02:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C3DD7601AA;
 Wed, 17 Jun 2026 16:02:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C541B106C8586; 
 Wed, 17 Jun 2026 18:02:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781712147; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=rsz4CB/ioUh11u6+oBW2vw8gDR6TbWvMzvgdFf8PjZI=;
 b=I2qNLxnihWiEPmH/RpKdcWbzuFq5A0VIHXps2CHj4O9LbOcGQ+a38WzlT2rY9BHZ8xY26T
 zlLLF1Pb7UoWQ5ShwZxx0wonfncdxJ9IUZlJDVs2K8R0adlw7VRpd1mZAq3vByEyxWNkvR
 atfSfghRQAa8zCZm0qNlbs7qddHhBO145BFDS7vAaYgFWUwVrFpkG26bdrh4LtXR31tDmR
 MMD6QTbNFRfQ3jNhhA9uoDvSg5bDgXd8jOU7G20riMiipvbYEf+Ox8JFqJKYcEl5MoCH1S
 sC5Pt1UYMYujmF5llCM4fg8MNmA4BWcEVXuBczM0KlvMCd9G9p1TGuUtwKGt+Q==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/78] drm/bridge: cdns-dsi: Return an error pointer
 on allocation failure
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
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-1-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
 <20260608-drm-no-more-bridge-reset-v2-1-0a91018bf886@kernel.org>
Date: Wed, 17 Jun 2026 18:02:16 +0200
Message-Id: <178171213659.312625.4861273784102077854.b4-review@b4>
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

On Mon, 08 Jun 2026 16:35:43 +0200, Maxime Ripard <mripard@kernel.org> wrote:
> The drm_bridge_funcs.atomic_reset documentation states that the hook
> must return either a valid drm_bridge_state object or an ERR_PTR().
> 
> The cdns_dsi_bridge_atomic_reset() callback returns NULL when the
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


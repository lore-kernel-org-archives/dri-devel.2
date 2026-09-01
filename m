Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170CDC624D0
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB6810E3C6;
	Tue,  1 Sep 2026 09:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ymSFr5qq";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 720A710E3C6
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 09:48:28 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id DEC811A1931;
 Tue,  1 Sep 2026 09:48:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A68976053C;
 Tue,  1 Sep 2026 09:48:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4FD3611C7925B; 
 Tue,  1 Sep 2026 11:48:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788256105; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=95mEIBuy7z2wnWxzkNx9JJx0GxackAytcnMN6Df3vCc=;
 b=ymSFr5qqggE8n9GgQNHyVvfxYKJFYBxmRFihxkph58XTPfkkb9UVvsyfpASeY2sTWOuwsx
 VuDbzeHSe+yFvHkKwx8mwO6nJqqytc4fXq63QcHSQQFjrM8o7ZEIIpVsnwssq/tuTmagsy
 5zSoVeJUGQNQpiqgZLLJu87SZlwHJ285fRZYOTVWmTblW1jL9zJQGfjn+h1ecWw2LXlMiz
 x1/LDKzAhleT49OPdPg7dk+0Oudu4dFzfbYNVDKLGVqDfQJf2ZSoAjOhhUrs7KwCVtbh7N
 KiNGsBOrca+XZZd3+tlrPlxp6OVPLZINGxr2/TCBqZSrU1AQiX3YZSF/kwHHeg==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 1/2] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Linus Walleij <linusw@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>, 
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260831-ti-sn65dsi83-fixes-v5-1-e712765d6c4f@geanix.com>
References: <20260831-ti-sn65dsi83-fixes-v5-0-e712765d6c4f@geanix.com>
 <20260831-ti-sn65dsi83-fixes-v5-1-e712765d6c4f@geanix.com>
Date: Tue, 01 Sep 2026 11:48:16 +0200
Message-Id: <178825609646.149491.2880661575829864139.b4-review@b4>
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

On Mon, 31 Aug 2026 14:21:32 +0200, Esben Haabendal <esben@geanix.com> wrote:
> The error handling of sn65dsi83_reset_pipe() in sn65dsi83_reset_work() has
> seen a couple of changes that seems to cause a bit of confusion.
> 
> While sn65dsi83_reset_work() has implemented an early exit if
> sn65dsi83_reset_pipe() fails since it was added, when a commit from Maxime
> Ripard switched to use drm_bridge_helper_reset_crtc() [1] the
> sn65dsi83_reset_pipe() function would no longer return an error code, so
> the early exit was then a no-op, and even on sn65dsi83_reset_pipe()
> failure, enable_irq() has been called.
> 
> [...]

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


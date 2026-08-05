Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A7AC55182
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82F310ED53;
	Wed,  5 Aug 2026 07:47:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="1sy7+/Aj";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9083110ED53
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 07:47:07 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id E1D0E1A13B9;
 Wed,  5 Aug 2026 07:47:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9E278602AB;
 Wed,  5 Aug 2026 07:47:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8D4EA11C3430D; 
 Wed,  5 Aug 2026 09:46:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1785916020; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=4/j8xH3wRPgHkMdxqEYEc/1jozPJiWxNH8edxlIgasU=;
 b=1sy7+/AjanhCZ60M5+Rky55YxHDCX9h9e6e54zDljzRNaiF1njOxKblXhHtwTAPMtcIImm
 JgP1KH6B1ehAfvw2uFDITwQZENWK6O1qOjdOQ22JHFqo/xOhhvifsZmvCxOQKLRIhY2B2w
 88+NCqnfbTfua09y5BtWUSsn2r5bSoJwZ1+SCsf534UFvLfv9xfqRz6ck7vklVoP7Z3NGz
 wz6JIeCh1Rb1suocddvQXPCCKNiv05x70dMy3X4nfRbEmhHzCpk5ZCvvudW0dgp5vDYkyQ
 E1HXdu6mnAhHM46fthXdAGlFm+Fncmc78FxoUT2Plz/wCiomwMzwtRm+nGcgRg==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/3] drm/bridge: ti-sn65dsi83: Propagate error in
 sn65dsi83_reset_pipe()
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
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260803-ti-sn65dsi83-fixes-v3-1-9b403a405ccd@geanix.com>
References: <20260803-ti-sn65dsi83-fixes-v3-0-9b403a405ccd@geanix.com>
 <20260803-ti-sn65dsi83-fixes-v3-1-9b403a405ccd@geanix.com>
Date: Wed, 05 Aug 2026 09:46:47 +0200
Message-Id: <178591600766.274551.9164227801232973400.b4-review@b4>
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

On Mon, 03 Aug 2026 16:57:03 +0200, Esben Haabendal <esben@geanix.com> wrote:

Hi Esben,

> Propagate the error code from drm_bridge_helper_reset_crtc(), so that
> callers has a chance to handle the failure.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>

Thanks for the improved patches!

Patches 1-2 look like big fixes, so they need a Fixes tag along with 'Cc:
stable'.

Other than that they look OK to me.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


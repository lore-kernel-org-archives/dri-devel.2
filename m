Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D611C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 09:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7DAD10E93E;
	Wed, 19 Aug 2026 09:17:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="EwN9sxc2";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC6B10E93E
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 09:17:25 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 222D11A1730;
 Wed, 19 Aug 2026 09:17:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E2D8F5FF42;
 Wed, 19 Aug 2026 09:17:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 03BB511C754FF; 
 Wed, 19 Aug 2026 11:17:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787131042; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=L7z/EWjbVHGLxCU0R84qVZeBKbA0IgpGtdVay8Ixsbg=;
 b=EwN9sxc2yakZgoLTwKZkMxewVxuTeNRzVPcMcD/shI7mXoXI3h0EyGijyWxQdoTjnv8XF8
 ekg+PVfHtS9If17GbONxMHuQKpZ+14qpPUJDqBfqb9sqqwEZE/8RfSsdjh6znZxVLCyQUn
 iG290IjCfu4XF2+T08Ib36ci5XuxUzT3TpayYvs4G5Z+IJMgLvETU1QFDiOZizPvQlotJl
 7XM+aT0PYqYqfdd12VwyIeBxiBmLULH9KUkdzha4PcBeXbd7GnwAIKnjf+2a64GPdIAdDL
 njo3T3uDmVj7yyyHXr9s4jmjI2dR8XfBOiq+e1TmBNCM7n4OCldbK/dd/l0cMw==
Date: Wed, 19 Aug 2026 11:17:16 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Linus Walleij <linusw@kernel.org>, Frieder
 Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] drm/bridge: ti-sn65dsi83: Fix error handling in
 sn65dsi83_reset_work()
Message-ID: <20260819111716.58b5843f@bootlin.com>
In-Reply-To: <20260803-ti-sn65dsi83-fixes-v3-2-9b403a405ccd@geanix.com>
References: <20260803-ti-sn65dsi83-fixes-v3-0-9b403a405ccd@geanix.com>
 <20260803-ti-sn65dsi83-fixes-v3-2-9b403a405ccd@geanix.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Esben,

On Mon, 03 Aug 2026 16:57:04 +0200
Esben Haabendal <esben@geanix.com> wrote:

> We obviously should not leave the DRM bridge critical section activated
> when exiting on error.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

With Fixes tag mentioned by Luca added in the commit log,

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

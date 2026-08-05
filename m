Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FA4C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 08:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA40010ED83;
	Wed,  5 Aug 2026 08:36:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ZTtxCL8W";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 660D310ED83
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 08:36:25 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 25ADA4E4102F;
 Wed,  5 Aug 2026 08:36:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E7B8F602AB;
 Wed,  5 Aug 2026 08:36:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4AFAE11C3444C; 
 Wed,  5 Aug 2026 10:36:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1785918979; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=m87RtPGy6qFC4GMSv0YYXsvPeEFKzyiF/asOdlM1rSs=;
 b=ZTtxCL8W9E18i1QqiXYbPspVuruRLWQcY5rA0x5+DH1rS/zFEOr7gKK49hNtip0lgCF2WU
 SBRajYr2ToAzrwfRYwXpGmI3ALjuz96JF/Z4Z6spQK8c6a1JfsykN7Ae2dZH4Loc+PgjjK
 aXQdltJGg9Kg0XMfRVs5KYsQyPBl1OOC3MLhkYLBIuKivOLDRq+/c0RFFULkWSitkcrbbI
 C1ij+6H51OGThSFjjdHNTol0l4lPxCGcwIG3r/WnDv2owptJ+N5qIf/e6HB3sftnrnforN
 OYLgHkLAR5p7YlJ9hUwiPm6Fl6+Bkmbh12U/SNQpiaplLR02MIoOz5HIZbDjPw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 4/4] drm/bridge: nwl-dsi: Add error handling of
 nwl_dsi_mode_set()
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260803-nwl-dsi-fixes-v2-4-1809a0ac453f@geanix.com>
References: <20260803-nwl-dsi-fixes-v2-0-1809a0ac453f@geanix.com>
 <20260803-nwl-dsi-fixes-v2-4-1809a0ac453f@geanix.com>
Date: Wed, 05 Aug 2026 10:36:01 +0200
Message-Id: <178591896150.480618.7817290661302611456.b4-review@b4>
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

On Mon, 03 Aug 2026 16:56:22 +0200, Esben Haabendal <esben@geanix.com> wrote:
> There does not seem to be any good reasons for ignoring the return value of
> the nwl_dsi_mode_set() function.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>

Here too, if it's a fix it needs Fixes: + Cc: stable.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


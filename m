Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6C4C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 18:26:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA2E89A4E;
	Wed,  2 Sep 2026 18:26:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="nbX8DEx4";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6FE389A4E
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 18:26:12 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 4294C1A1968;
 Wed,  2 Sep 2026 18:26:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0C4AF6053C;
 Wed,  2 Sep 2026 18:26:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D58D311C795A7; 
 Wed,  2 Sep 2026 20:25:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788373565; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=p03yiwsq38j8TPrIFwJ6uLWAobpLTqLwpi0gup1+xQo=;
 b=nbX8DEx4dXIMMnr4Z9CsBI5CeXMXiXwYc0nKt9WsCt+KoByT8ytPW+DVzqZEVvC+kVpb8S
 uFeaovux2LcHJT2uqwH0WLx12ZBme7D2x6hZDvV5Wq9wjWWHTVPmFkZvHLbDWfUA8V/IZ1
 3u5OxJe4ZsWQxAvuoeYVzyN1PgrhYeAZGeNfNvm6BdRyd5XUoAGJfw6h4zsG2IsPq8QTFo
 nQzOToE9yjmSyw60bNO5WR/Q0xMTP+yG3zkaZpX6lif4UYweZcizk+lGBggRk0rAP0vRuB
 3/sTXL+nKy+C7ix7JtqcMn+bWyf7EdDrhh5C+Y6ocwCbLl9kxcK/fzt8yaJMow==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
Subject: Re: (subset) [PATCH 00/11] drm/panel: add a panel_bridge to every
 panel
Message-Id: <178837355762.1178469.9866687339968107247.b4-ty@b4>
Date: Wed, 02 Sep 2026 20:25:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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


On Fri, 14 Aug 2026 16:05:48 +0200, Luca Ceresoli wrote:
> This series makes every drm_panel create a drm_panel_bridge wrapping it, as
> previously discussed [1][2].
> 
> A panel_bridge is currently created only afterwards by the component
> accessing it (such as the previous bridge), but that creates a mismatch
> between the panel and the panel_bridge lifetimes and devm ownership.
> 
> [...]

Applied, thanks!

[01/11] drm: of: drm_of_find_panel_or_bridge: simplify freeing the remote node pointer
        commit: 5a859b820ddf99e084b7fef2ec520b2df90a0a19
[02/11] drm: of: drm_of_find_panel_or_bridge: simplify error return paths
        commit: 97c594f71fa71dc30a0583a76d8b6ef5c5ea10b1

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



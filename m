Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C86CD98F6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB7CB10F512;
	Fri, 19 Jun 2026 10:24:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="iGdfcvgj";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F69610F510
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 10:24:22 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 8A6E9C06CD9;
 Fri, 19 Jun 2026 10:24:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BCD6E601AD;
 Fri, 19 Jun 2026 10:24:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 00D76106C8831; 
 Fri, 19 Jun 2026 12:24:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781864659; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=0pb5Ub9QOgQLRSepMfHnEdXotVS7SiWHTJfh2R9M/9w=;
 b=iGdfcvgjWCAnqfDO8Zjq09OFes4acAPBTIa2oMDZhl+l4FBNQuAryry6fAPGAbtkn/VtA3
 E7hzKbYM3wHv6YQlEYIDZjctxFZtOoAVoZLJ2+lb1BwPb8QYYKXHMyYhAW/xrbKCIDRl69
 +yVdceR1a4LGhXPOnEqEatmQ3vUhWx2YjMLkLfHGdR63/61wGp1wzwCwCU2L1IYRewGGuy
 D41dnFdkK177kqykbvY62JLnxI4i2uFt9kXOnbsLwp+tUGKfq/9H2ndvT1Ieniv1mKF4/T
 R7vv8Y/95HfBEqLdsG3bdNw9jRNiDrXZhLtrNDvIeQjWFG6GY/bwsvaMnuI4Ew==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 75/78] drm/bridge: cdns-dsi: Use
 __drm_atomic_helper_bridge_state_init()
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
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-75-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
 <20260608-drm-no-more-bridge-reset-v2-75-0a91018bf886@kernel.org>
Date: Fri, 19 Jun 2026 12:24:04 +0200
Message-Id: <178186464482.2030423.9022589923086294936.b4-review@b4>
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

On Mon, 08 Jun 2026 16:36:57 +0200, Maxime Ripard <mripard@kernel.org> wrote:
> The cdns-dsi bridge open-codes the bridge state initialization with
> a memset and a manual assignment of the bridge pointer.
> 
> The memset is redundant since the state is already kzalloc-ed, and
> __drm_atomic_helper_bridge_state_init() exists for exactly this
> purpose.
> 
> [...]

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


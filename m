Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B512BCD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 16:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A9110E959;
	Wed, 17 Jun 2026 16:02:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="lXNzLTTW";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A1E310F040
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 16:02:39 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id A67384E42F3F;
 Wed, 17 Jun 2026 16:02:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 748E5601AA;
 Wed, 17 Jun 2026 16:02:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E27DB106C8586; 
 Wed, 17 Jun 2026 18:02:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781712156; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=bdhhyAPetf77qgcphRdMa6aTL0KqSU0lYKB9U5NG3jo=;
 b=lXNzLTTWgoDQobC3YIXfNUVpWpUSvc8NFb7he2pHl3f+lhirgc8icCdH9K1W7EpzXonjHj
 69OooygM9UGkRio/TCYWN4vtPvExTXJDndCECg9RUgIsuIEYWg/cgirjqDTe+6KltRAY9p
 w6UrrBVS5v9rzRKRxImKzGaa7wFQTCPzwSw5LOSRwslL9Ia4FyrM/JakN7YuYvl2vDEe+s
 AiwcvOLl55vqk8qkX9qhMWCqLMHHmt3+qCr4Mn9C7F46WJMK5ZwTEl/4guLgp5BHurzABm
 BxBmgsW9xEMy+n0v794tVVW0AqO4i6zLOce+MvAFc0ILcBakMqrhFvHsDyqL3g==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 06/78] drm/bridge: Add new atomic_create_state callback
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
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-6-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
 <20260608-drm-no-more-bridge-reset-v2-6-0a91018bf886@kernel.org>
Date: Wed, 17 Jun 2026 18:02:16 +0200
Message-Id: <178171213663.312625.2294080557921796779.b4-review@b4>
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

On Mon, 08 Jun 2026 16:35:48 +0200, Maxime Ripard <mripard@kernel.org> wrote:
> Commit 47b5ac7daa46 ("drm/atomic: Add new atomic_create_state callback
> to drm_private_obj") introduced a new pattern for allocating drm object
> states: atomic_create_state, a dedicated hook that allocates and
> initializes a pristine state without any side effect.
> 
> The bridge atomic_reset callback is already fallible and in practice
> only allocates and initializes state without touching hardware.
> However, the reset name does not make this contract clear: callers
> and implementers cannot tell from the name alone whether the hardware
> will be affected or when the hook is safe to call.
> 
> [...]

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


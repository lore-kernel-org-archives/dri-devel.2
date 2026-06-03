Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB52CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 14:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C252010FEBF;
	Wed,  3 Jun 2026 14:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Z1iNIkpY";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB97710FEBF
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 14:07:38 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id B05B91A0119;
 Wed,  3 Jun 2026 14:07:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7E59D5FA0A;
 Wed,  3 Jun 2026 14:07:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D73D210888CC6; 
 Wed,  3 Jun 2026 16:07:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780495656; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=se81d5hTs+01XG6DeepFsQZB++xyjAyQyJ03fHSfqkM=;
 b=Z1iNIkpYEgkNwSZlsI9rIe2WHjkt20x0F49kL3vdQuqfX7AQ2obPdhufw6gQxT7V2zTM3i
 FsZwBz94eCVecV0Kas0Ceneao4iPu6O86azJHzbPOwNtNZpJ4cHeY2F4bI8VwJLCFxMEyr
 QKTz1wPBb3ExPElFTxZZXBpkhWZRRKs2Zojcns2g4Vsn+qJpFa55KbD0Jq2p3Hx4eWmJsO
 +kUzyLtLhlvG1fds5MQXYBhu6/D84ScOGzEb0aM2FhyE2+ffnD3vLzao2k408sGNqE6LrF
 eBrP42tatdf0CjwY00NfRDyTfOjxFWkn0m90yYNVief4NUqG6upxUlGTv/N7kA==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 05/76] drm/atomic-state-helper: Add
 drm_atomic_helper_bridge_create_state()
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
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-5-875d828d31bc@kernel.org>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
 <20260530-drm-no-more-bridge-reset-v1-5-875d828d31bc@kernel.org>
Date: Wed, 03 Jun 2026 16:07:19 +0200
Message-Id: <178049563994.8577.17937360641076913511.b4-review@b4>
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

On Sat, 30 May 2026 15:59:10 +0200, Maxime Ripard <mripard@kernel.org> wrote:
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 2a694698aca1..cd92a676d2a2 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -853,3 +853,28 @@ drm_atomic_helper_bridge_reset(struct drm_bridge *bridge)
>  	return bridge_state;
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_bridge_reset);
> +
> +/**
> + * drm_atomic_helper_bridge_create_state - default &drm_bridge_funcs.atomic_create_state hook for bridges

Line longer than 100 chars.

> [ ... skip 16 lines ... ]
> +		return ERR_PTR(-ENOMEM);
> +
> +	__drm_atomic_helper_bridge_state_init(bridge_state, bridge);
> +	return bridge_state;
> +}
> +EXPORT_SYMBOL(drm_atomic_helper_bridge_create_state);

This new function is identical to drm_atomic_helper_bridge_reset(). Maybe
worth noting that in the commit message, to avoid other people doing the
diff as I just did. :)

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


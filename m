Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C5A607DE9F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=q+fsZSKh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D6CB10FD15;
	Wed, 25 Nov 2026 15:43:00 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF03810FD04
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:42:41 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 30240C6221D;
 Wed, 25 Nov 2026 15:42:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 43BAD60480;
 Wed, 25 Nov 2026 15:42:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A8E6B11E6A0D7; Wed, 25 Nov 2026 16:42:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795621357; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=hZ6aFvwj2O387fKbMKxhHV3O1W/lkVQrorBhCvcytw8=;
 b=q+fsZSKhmVhhOWJkMw2q14k3bPgEMKg5HdhwEEz3LR96EPw0iXwIMqIVyvv8PYHEMKQihD
 9NF8jyP9rWsuJpbVdK6GC3YZQu2bVdKKLjmZrVVp6Bj20f7k0wS+dcwe/P7ni0/tRKpPDn
 ybHlyCbBycJMuSYCk6RScCUI4bm4BNohsM9LMVpZGTYM+GSQ+i2Lnm7zntlVsi/pyklNMt
 SEEjMepX6imJjbTmvuJGIRSUbDXugT4MY9m3KUT29TIzuRV6ZEniEtI92BKPcNFoGY+5al
 Z9VS8iQtwkerSG7h/SmjF4240uznnGzbMDI2Sc1dUStN6i1uEaNj6x7qpKSiAw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Damon Ding <damon.ding@rock-chips.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Heiko Stuebner <heiko@sntech.de>, Thorsten Blum <blum@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261111164243.77775-2-blum@kernel.org>
References: <20261111164243.77775-2-blum@kernel.org>
Subject: Re: [PATCH RESEND] drm/bridge: analogix_dp: Use
 str_supported_unsupported() helper
Message-Id: <179562135215.656989.6398184433108139062.b4-ty@b4>
Date: Wed, 25 Nov 2026 16:42:32 +0100
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Wed, 11 Nov 2026 17:42:41 +0100, Thorsten Blum wrote:
> Replace hard-coded strings with the str_supported_unsupported() helper.
> This unifies the output and helps the linker with deduplication, which
> can result in a smaller binary.

Applied, thanks!

[1/1] drm/bridge: analogix_dp: Use str_supported_unsupported() helper
      commit: aad74288f6bf622e5560cf83564fa1b3891e2a95

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



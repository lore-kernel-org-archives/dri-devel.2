Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E8FCD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85C8E10F50C;
	Fri, 19 Jun 2026 10:24:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="FVtrxBzD";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68A5110F50C
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 10:24:20 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 6B30FC06CD8;
 Fri, 19 Jun 2026 10:24:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7AA8A601AD;
 Fri, 19 Jun 2026 10:24:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6677A106C81A3; 
 Fri, 19 Jun 2026 12:24:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781864657; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Bpfvw7aIKN7ZdedV0Rg92kVKYxeMZ35Dqd5MSisrKgc=;
 b=FVtrxBzDJdgSCE7pPRxUiTUVGSPjI4rh6bGV1y+Ip6eBBt4q7F95J4GD72srcLxXybHdmT
 OPtKJb0Dn5oRjEJYUX1Dp7I9M84uYvfC+tA+1c3MKSjmyeCbCMMDju0jUu+LcIXPuwB8/Q
 31Gaibzqz71VyMlKn/2i8INTHGsTsgtiFON7Nzl8MTl/5aSC4IsNJRO3yHXeYBCZXay2kx
 3CyA/jNiEe1u3uvj7g8VGdDll+6X2iiNRlP/s5G+vF7jGKVhW17kZWC4VY8B5rM7kXmHmC
 MzHn5FZePE7wOQ/9+zuN3IAn5ONEAaMUESqUhzMnVUc2D96p8/WgmCuQObibVA==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 74/78] drm/atomic-state-helper: Remove
 drm_atomic_helper_bridge_reset()
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
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-74-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
 <20260608-drm-no-more-bridge-reset-v2-74-0a91018bf886@kernel.org>
Date: Fri, 19 Jun 2026 12:24:04 +0200
Message-Id: <178186464480.2030423.10783457436815205173.b4-review@b4>
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

On Mon, 08 Jun 2026 16:36:56 +0200, Maxime Ripard <mripard@kernel.org> wrote:
> All drivers have been converted to the atomic_create_state callback
> and its drm_atomic_helper_bridge_create_state() helper.

There are a 2 remaining users (in macros, which is perhaps why coccinelle
didn't catch them) and a mention in the docs:

  | $ git grep  drm_atomic_helper_bridge_reset
  | drivers/gpu/drm/tests/drm_bridge_test.c:        .atomic_reset                   = drm_atomic_helper_bridge_reset,
  | drivers/gpu/drm/tests/drm_bridge_test.c:        .atomic_reset                   = drm_atomic_helper_bridge_reset,                       \
  | $

Luca

drivers/gpu/drm/tests/drm_bridge_test.c: .atomic_reset                   = drm_atomic_helper_bridge_reset,
drivers/gpu/drm/tests/drm_bridge_test.c: .atomic_reset                   = drm_atomic_helper_bridge_reset,                       \

drivers/gpu/drm/tests/drm_bridge_test.c: .atomic_reset                   = drm_atomic_helper_bridge_reset,
drivers/gpu/drm/tests/drm_bridge_test.c: .atomic_reset                   = drm_atomic_helper_bridge_reset,                       \

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


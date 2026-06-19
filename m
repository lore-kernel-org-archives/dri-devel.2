Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F8ECD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:24:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCF2410F522;
	Fri, 19 Jun 2026 10:24:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="h9Orv1EA";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A76510F51A
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 10:24:30 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 3C6F11A398A;
 Fri, 19 Jun 2026 10:24:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 092F0601AD;
 Fri, 19 Jun 2026 10:24:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D931E106C8934; 
 Fri, 19 Jun 2026 12:24:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781864668; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=4JJkVs3tLM1p39lhCidpIH8UjqmTgp87GAx6PaWQPGs=;
 b=h9Orv1EAyLIMc/M42o9y74fsTCCZBxtn3Cf8dd+zsM5biS2z5gmDAcTfp3i9OFDCWvoNix
 e8GHWnDV1ts2+6Fm9ZO15CWQE7qRdb7gOX92IeYyCXj+zODQ73k/+SyYTM4m6ifFa+XclJ
 J30z0jVo0aXS+MG66VShyuiOwT5Piy6Xs1ncOeIniTms6t8gI9SyYTSQz3d0sVx0IBr1FF
 +731O01Xj0QSpeqZovYSqsAB78NOWSjwPofpXIzGtlAIYLN2C+qF25RbNUs/tclKAh6OXt
 Rq7X6Mijf3n1QCLEwWuRf4pkJMpIdsTmQPCqF/HY616wFMVrt9XxQSOjrEyryQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 78/78] drm/bridge: Remove atomic_reset support
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
 dri-devel@lists.freedesktop.org, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-78-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org>
 <20260608-drm-no-more-bridge-reset-v2-78-0a91018bf886@kernel.org>
Date: Fri, 19 Jun 2026 12:24:04 +0200
Message-Id: <178186464486.2030423.14405658349151518391.b4-review@b4>
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

On Mon, 08 Jun 2026 16:37:00 +0200, Maxime Ripard <mripard@kernel.org> wrote:
> There are no remaining users of the atomic_reset hook. Remove it
> from the core.

Similarly to patch 74, there are a few leftovers:

  $ git grep -w  atomic_reset -- drivers/gpu/drm/
  drivers/gpu/drm/tests/drm_bridge_test.c:        .atomic_reset                   = drm_atomic_helper_bridge_reset,
  drivers/gpu/drm/tests/drm_bridge_test.c:        .atomic_reset                   = drm_atomic_helper_bridge_reset,                       \
  $

One in the docs, the other 2 are the same reported for patch 74.

Otherwise LGTM.

Luca

drivers/gpu/drm/tests/drm_bridge_test.c: .atomic_reset                   = drm_atomic_helper_bridge_reset,
drivers/gpu/drm/tests/drm_bridge_test.c: .atomic_reset                   = drm_atomic_helper_bridge_reset,                       \

drivers/gpu/drm/tests/drm_bridge_test.c: .atomic_reset                   = drm_atomic_helper_bridge_reset,
drivers/gpu/drm/tests/drm_bridge_test.c: .atomic_reset                   = drm_atomic_helper_bridge_reset,                       \

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


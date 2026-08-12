Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158B1C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BFB710F000;
	Wed, 12 Aug 2026 14:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="EUF5j17j";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 627E310F000
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 14:01:40 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id D526B1A15B6;
 Wed, 12 Aug 2026 14:01:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A26FB6045E;
 Wed, 12 Aug 2026 14:01:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E667511C4CF4E; 
 Wed, 12 Aug 2026 16:01:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786543293; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=q6Nku3dEzztmsbf/GKD+6Kf098eLKHF+39e80S9m4iQ=;
 b=EUF5j17j634OPvyGVGA8h4+ENHbJqcw6GXGvcrpDRdeAk5uVZQ7LVr5Au3n8SfUviZ0ryS
 1HqQowqGSqteZdd0j05H9VETCJHMdbw0a+kfFIhx9kSw6Kwh6u2ApWhCzr66XdL5Gk69OX
 b+3f1D95nEQ1KKzaomRoL9xr/jfBz799LssTGwQBn/Uw4eAL6p+BJvfF9sGethneR76+gB
 nk4eR/0IVdw1X1cmqVooBub5zxn53HzqVhtcMbne9nEct5BuDjdXDNRe4RKNoXZeMTTNbI
 n1eoQB5ffDLFZ+0DLmNv6kO/622miQ0s3+Zstawvn+sxcwsrWz5IK+op9Ou/fw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] drm/bridge: chipone-icn6211: use devm_mipi_dsi_attach
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: luca.ceresoli@bootlin.com, Jagan Teki <jagan@amarulasolutions.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260521212529.151493-1-osama.abdelkader@gmail.com>
References: <20260521212529.151493-1-osama.abdelkader@gmail.com>
Date: Wed, 12 Aug 2026 16:01:15 +0200
Message-Id: <178654327537.483443.8461948369902839411.b4-review@b4>
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

On Thu, 21 May 2026 23:25:28 +0200, Osama Abdelkader <osama.abdelkader@gmail.com> wrote:
> Follow up on the previous devm_drm_bridge_add() conversion by
> converting the remaining manual cleanup in chipone-icn6211 to the
> managed helper.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


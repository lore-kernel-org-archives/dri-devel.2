Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E22B606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=dvZ/VJUQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A84E10E14A;
	Thu,  5 Nov 2026 14:55:17 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A58E10E14A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:55:10 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id DB5191A09F3;
 Thu,  5 Nov 2026 14:55:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AE2BC5FF85;
 Thu,  5 Nov 2026 14:55:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8480710329267; Thu,  5 Nov 2026 15:55:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793890507; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=b3oG9ClQenZCeftR5+d3EFUFv88sO/z2Ote9FZmOxWM=;
 b=dvZ/VJUQOWDqS/25TKvHHGnUoabikgHVZ5qpWdVl9ftgVcJjFQCM65Orsjo9HREiwiXBN0
 ln0qYrqWK3XYlQSAJIhBbQsP3egcFRdaYooolcRGPYlYtSy6tVql/f9+JdV7U0NCexWL+D
 zNQXWP5m5ybA1ExTYk3l6epaZvx0y5COLLiw2/O6RKZmqxQd0UJW9QFjBQIcEfdZWBWodt
 TneemejURRoTPs7v+DTE7IcWnMhl66smitnALaFxoAOhu6d27dhaX1a23mTFgUx2Ix0cJp
 Wl4/CuHMcgvj52E3SA+M/AWX5XEJ9U3Sop4vkMXCBv77FmXUm92tZo+GF529pg==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 7/7] MAINTAINERS: Add Dmitry Baryshkov as bridge maintainer
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, 
 David Airlie <airlied@gmail.com>, Maarten Lankhorst <dev@lankhorst.se>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
In-Reply-To: <20261105142127.708219-7-mripard@kernel.org>
References: <20261105142127.708219-1-mripard@kernel.org>
 <20261105142127.708219-7-mripard@kernel.org>
Date: Thu, 05 Nov 2026 15:54:40 +0100
Message-Id: <179389048000.1070495.2477516297733174670.b4-review@b4>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 05 Nov 2026 15:21:27 +0100, Maxime Ripard <mripard@kernel.org> wrote:
> Dmitry has been one of the most active reviewers of the DRM bridge
> subsystem without having the maintainer status.
> 
> Add him as a maintainer to match the current situation.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


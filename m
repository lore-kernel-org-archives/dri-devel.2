Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CB3606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=EwMGM74N
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D28C1112629;
	Thu,  5 Nov 2026 15:14:23 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A892311261C
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:14:17 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 82C23C6915B;
 Thu,  5 Nov 2026 15:14:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5B2A15FF85;
 Thu,  5 Nov 2026 15:14:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D005F103292A7; Thu,  5 Nov 2026 16:14:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793891651; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=UnKQnoGzIENW/QrHI7Sx2RKP7nPr7us/AwRxCGVBOG0=;
 b=EwMGM74NBzXvOgWv2JSq5qRs1SqK2Ub3lrO75PAKANc98j0PphN5siMTPMDtSugJcOGliT
 SnjoW9RNPA13UShdy+Uq0gyyjH7mNU/QOY1+XUf33uKUjmBTEd4IIjyAfIwTe7iEqfEq3c
 Crpx9wHq9Kdge+SOYCK1rSLuUUADGnLJqa0yt/1NYx1IkM7O0aJoPare+X/V4YY5UET4Gg
 i57YU+RdF1w1mmIvtwVhrSKkPOFZtykrNpL927U9ZvXt+Gquj7dXWWn/MkYaKwMuxTj0S5
 J9K5gmEBkyJc4kwvRvcMmBWXLMMV6EqDzbReOpNFyy+7lwYbWqVYnGSxLNSB8g==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/7] MAINTAINERS: Remove Andrzej Hajda from bridge
 maintainers
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
In-Reply-To: <20261105142127.708219-5-mripard@kernel.org>
References: <20261105142127.708219-1-mripard@kernel.org>
 <20261105142127.708219-5-mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:13:57 +0100
Message-Id: <179389163714.1070495.2067145957365134979.b4-review@b4>
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

> Andrzej Hajda's last commit to the DRM bridge subsystem dates back to
> 2021, and his last bridge review to 2023. His focus has since moved to
> the Intel GPU drivers.
>
> Remove the maintainer entry to match the current situation.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Based on a 'f:Hajda NOT s:i915' search on lore.kernel.org/dri-devel and
some git log research:

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


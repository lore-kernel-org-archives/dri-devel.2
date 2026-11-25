Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A2606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=KyKHSlK5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30DB010E91E;
	Wed, 25 Nov 2026 16:11:32 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6981E10E91E
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 16:11:26 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 429FDC6221D;
 Wed, 25 Nov 2026 16:11:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 345CE60480;
 Wed, 25 Nov 2026 16:11:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 47C3A11E6ABF3; Wed, 25 Nov 2026 17:11:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795623079; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=shMr3VTsq3XeQkoO9Ln5izMtWpMU+7APEuFdjKZvMdY=;
 b=KyKHSlK5Ey6/akMaHN+c+uAv7NDQWG/yMqCI9oHkdzOeFbzRpfp9AX0SGw1K3164JB9OmD
 SBOtdiMH+BGgUgF2ct0BEaPwEFVq/GAtFqSZs0LarGryqPr7NPXdYBiOv18ORWOyFNKDw/
 rfUe1p8BMVELflNxh4NBO6aqhw2OzQ/wmafCV6jLdu1BO8GxEpYkJUDmGtPPEZ1uwFGMHn
 iSAxv03Cb4YalrORtMHi0FOmZuAqIud4DNo5mZFLr+YVVHtkCT24lJ73yd0ymz+CCnaIjF
 cR10/N5EuLjCMv+Ee288k3V7r1nHhACNaNtZpjOt8gJyJQTfe3yNYM412T5HWw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261112162127.1592210-1-colin.i.king@gmail.com>
References: <20261112162127.1592210-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] drm/bridge: tc358767: make read-only array
 ext_div static const
Message-Id: <179562307394.731258.1793421800570057727.b4-ty@b4>
Date: Wed, 25 Nov 2026 17:11:13 +0100
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


On Thu, 12 Nov 2026 16:21:27 +0000, Colin Ian King wrote:
> Don't populate the read-only array ext_div on the stack
> at run time, instead make it static const

Applied, thanks!

[1/1] drm/bridge: tc358767: make read-only array ext_div static const
      commit: 632586bd82b0158a97c6eb6830375c1efda6e0f6

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



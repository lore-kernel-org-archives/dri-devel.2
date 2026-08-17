Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B943C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B66BF10E3E2;
	Mon, 17 Aug 2026 09:01:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="V0aFfuJF";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10B8C10E3E2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 09:01:13 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 31CCD4E41286;
 Mon, 17 Aug 2026 09:01:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0363760352;
 Mon, 17 Aug 2026 09:01:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E7BD611C4FF4A; 
 Mon, 17 Aug 2026 11:01:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786957267; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=7qD0FXlzYm6rn5234QgYrEDLLeicDWUkbqtOU7mj7IE=;
 b=V0aFfuJFV5O1SO0AZMQqsFLPYoKN0ov0QWvarioCe14bHF/CmkNnfjGe04+e02U9EdqDE/
 6Cj2DzdpdBqoL8x8lYb1EiqbeRjSlJf5JwtWttORjGbpUxVjXKJEd3xTXJm745ut2IA/4F
 kq4KZhHZtfFod19KeyhozrfUa9QehAGd4zkDQaGCS0hIyYqOuhfh2i8Tn4o6e8aa1IoFB1
 BIEFI2ER69buMKK47MuivqNrMzMTFutjoH/10o30v9rsziLVMKDVQKeUBKFa3GbMokQcvD
 P2mxgZpNYR4lmG1p240AfR4mJxQGRNoreJfPEyzFUYa1diCdMHkExa7xlscfSA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Osama Abdelkader <osama.abdelkader@gmail.com>
In-Reply-To: <20260521212529.151493-1-osama.abdelkader@gmail.com>
References: <20260521212529.151493-1-osama.abdelkader@gmail.com>
Subject: Re: [PATCH] drm/bridge: chipone-icn6211: use devm_mipi_dsi_attach
Message-Id: <178695726167.98988.12193203980659651177.b4-ty@b4>
Date: Mon, 17 Aug 2026 11:01:01 +0200
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
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


On Thu, 21 May 2026 23:25:28 +0200, Osama Abdelkader wrote:
> Follow up on the previous devm_drm_bridge_add() conversion by
> converting the remaining manual cleanup in chipone-icn6211 to the
> managed helper.

Applied, thanks!

[1/1] drm/bridge: chipone-icn6211: use devm_mipi_dsi_attach
      commit: 5d2584e2ffaabf2d420edcb2d120209e151f8dce

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



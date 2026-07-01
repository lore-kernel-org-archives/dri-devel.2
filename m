Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438CAC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 17:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D9CC10F06D;
	Wed,  1 Jul 2026 17:19:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="y9QUWxlV";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCAE110F06D
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:19:39 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 55C834E40BFA;
 Wed,  1 Jul 2026 17:19:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 030955FD9D;
 Wed,  1 Jul 2026 17:19:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C7306104C948E; 
 Wed,  1 Jul 2026 19:19:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782926376; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=9IjGriL20aUDrYKm6+vTu9029BmucxRxhyWYYY+OsIA=;
 b=y9QUWxlV0KdIf9f/c4LLTFZWCL9K6cSxJ/+M78N1Z9c1zI/NLsntj7oPAFKCXCpZxmnZxy
 alT4YKxKZFYGyT+BFHqW0GwcfRgehJWuH9JkuEfKyuWtyVMIjOGqF6REFNJmf+kUMt7Q7c
 0PvtvmNs6hOoxfJ9G+p6z+B6fitYNygvlI4q8INBZ/lDSbL+LWeTJ9zzcs0mS37NuSJHfj
 3BgM+ueb3u+bs6Wwtv5v11Km4oq8x/vkwCS4/PvbFL9S+u1ExOoV+SQo311mp5LfzBDoDN
 2w765HyEMzksiUMFNcnPmxeZWvdxOYB8q1B2P9ciZK/JxfRGj40HEvUYuJwHeg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260619-drm-lcdif-deferral-msg-v1-1-ce2392dca985@bootlin.com>
References: <20260619-drm-lcdif-deferral-msg-v1-1-ce2392dca985@bootlin.com>
Subject: Re: [PATCH] drm/mxsfb/lcdif: don't hide lcdif_attach_bridge()
 deferral messages
Message-Id: <178292637135.3330226.15837707987617382686.b4-ty@b4>
Date: Wed, 01 Jul 2026 19:19:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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


On Fri, 19 Jun 2026 09:02:13 +0200, Luca Ceresoli wrote:
> lcdif_attach_bridge() uses dev_err_probe() on all its error returns to
> store a specific deferral message.
> 
> However its caller lcdif_load() calls dev_err_probe() again on error,
> overwriting the specific deferral messages with a unique, unavoidably
> generic, message.
> 
> [...]

Applied, thanks!

[1/1] drm/mxsfb/lcdif: don't hide lcdif_attach_bridge() deferral messages
      commit: cff96362794a5c1f3adb013b4a46c7233149a629

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



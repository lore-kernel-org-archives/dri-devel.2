Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172B6606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=YHGlFiX8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 683C110E368;
	Thu,  5 Nov 2026 07:57:05 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2709E10E368
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 07:56:59 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 70DFA4E40774;
 Thu,  5 Nov 2026 07:56:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2BF3B5FF85;
 Thu,  5 Nov 2026 07:56:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4367C10328E67; Thu,  5 Nov 2026 08:56:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793865415; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=HXdQdKGkpxAzk7wWxbV26AiUxZP5IjbO1/tuui0e0tU=;
 b=YHGlFiX8f1PGxqg5IcKDvgND/e/tgTG7BZ1U7j7r8WC0rlQmn4/eS4Gx8ZeHqOQCxod6kG
 tDX+QJgmfqoY889/r+FZiTH5nPuHqGcaNFHKy58Hm+jXirXPsS4QgQwk/aqNv23LCLoCvb
 NlIQBARCz79v7mUWBrlqUhj7ngV5lk6odzlHOV4I3adFohGPM47RcthLqyggKZ4OsU72pH
 z9ugz0yWevutyGX/qZ1Cs9jJ4GnGXwwzPl0Xx5WlWLBMg57VUm7NUFGVrw0i8X23E/TY0S
 14BQxKlzkE6Un8zZodkv+0xDHyzG2UGCQHHUWicxATYR3Nz/T+vtSDuqqbBFRA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: dri-devel@lists.freedesktop.org, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com, 
 Andrzej Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261029144132.572020-1-dario.binacchi@amarulasolutions.com>
References: <20261029144132.572020-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH] drm/bridge: fsl-ldb: return -EPROBE_DEFER if the panel
 bridge is not found
Message-Id: <179386540880.926962.15452112879509946789.b4-ty@b4>
Date: Thu, 05 Nov 2026 08:56:48 +0100
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


On Thu, 29 Oct 2026 15:41:28 +0100, Dario Binacchi wrote:
> of_drm_find_and_get_bridge() returns NULL if the panel has not been
> registered yet. Returning -ENODEV in this case makes the probe fail
> instead of being retried, so the LDB is never bound and the display
> pipeline never comes up:
> 
>   platform 32e90000.display-controller: deferred probe pending: imx-lcdif: Failed to get bridge for endpoint0
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: fsl-ldb: return -EPROBE_DEFER if the panel bridge is not found
      commit: ef08ae876d0641a5c8496008d35ceb0d6b1a92b9

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



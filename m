Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD829606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=BcxkCqPP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B77410E0DE;
	Thu, 29 Oct 2026 19:30:51 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D423B10E0DE
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 19:30:44 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 07CCF1A13AF;
 Thu, 29 Oct 2026 19:30:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CEAF76076A;
 Thu, 29 Oct 2026 19:30:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 12A6B10328F94; Thu, 29 Oct 2026 20:30:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793302237; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=5Ll62Av3zqAK/UwbMKhO8aHQhK9NIEhSdwE8ZCKZZSM=;
 b=BcxkCqPPeOZNlzvUkt34zUi+bPlBrwF5/ELWAjACOSKLOEqu5ZG8BwQ5THjmZir8WXDnia
 KtakL2n+IAEfH610ac1VwmOjNYM4/+sPGZWQ7qkz66dfKFBgX0E80PznTP4W4oPiXQUGDm
 B2Yl9wZfaBDBuNoxNu/dI9EH6NggUwaAV7hpmhtV+QZctGjVyNGTrrSBz7620nTwNJCe5R
 v4KGhscGj1vAlNEpblwwc1W4D6Pq6gF2eR8o81b0LMUw2QMDA9YrPEhRTqWN14Bse7rY4V
 3pkdHWZ4JSXnCP7dClBjXtpe7bwC+8A4vmkHbtpUc1ptRinSDxllx0HqogqSUg==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 20:30:31 +0100
Message-Id: <DMHKL3TFB3D6.10S4BKS9F6TXJ@bootlin.com>
Subject: Re: [PATCH] drm/bridge: fsl-ldb: return -EPROBE_DEFER if the panel
 bridge is not found
Cc: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "David Airlie"
 <airlied@gmail.com>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jonas
 Karlman" <jonas@kwiboo.se>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Laurentiu Palcu"
 <laurentiu.palcu@oss.nxp.com>, "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert
 Foss" <rfoss@kernel.org>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, <linux-kernel@vger.kernel.org>
To: "Dario Binacchi" <dario.binacchi@amarulasolutions.com>,
 <dri-devel@lists.freedesktop.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261029144132.572020-1-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20261029144132.572020-1-dario.binacchi@amarulasolutions.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Oct 29, 2026 at 3:41 PM CET, Dario Binacchi wrote:
> of_drm_find_and_get_bridge() returns NULL if the panel has not been
> registered yet. Returning -ENODEV in this case makes the probe fail
> instead of being retried, so the LDB is never bound and the display
> pipeline never comes up:
>
>   platform 32e90000.display-controller: deferred probe pending: imx-lcdif=
: Failed to get bridge for endpoint0
>
> Return -EPROBE_DEFER, so that the probe is retried once the panel is
> available.
>
> Fixes: 802372cf316a ("drm/bridge: fsl-ldb: don't create a panel_bridge")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

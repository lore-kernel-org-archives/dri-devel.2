Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F1E606A327
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qxWBGn5U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0431410EA92;
	Thu, 12 Nov 2026 07:44:06 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5452D10EA92
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:43:59 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 6B8F91A162A;
 Thu, 12 Nov 2026 07:43:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 394845FF85;
 Thu, 12 Nov 2026 07:43:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A761B11BC05A9; Thu, 12 Nov 2026 08:43:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794469436; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=kmQ9tCdfHJvODaaQiJY8VbOIwr70LOZMLlckjTphBqE=;
 b=qxWBGn5U7P1yTzXNaHcOOzcQZq/cFIGm7krSI+3Bi66X7rsB7bQq1hsuuju80p+MgL5JBm
 /r2GnHwH2uOCNh0G+cZq9ucouQ1Lq7gWIOSKnf5Zgs//geAQg8sGL+Yn/J0XsoBSP+wy9X
 rlaMgtg14HY7xLBBcCnBeZdrQr6ZwVbrI6/uOYtntDPksJbf2UuLNQevRxR3RjWGjli7Za
 4XeyRzOn804jwucyIf54TvFMmkm/PPSyZbJwcedjRnjoLT+DOt8j3soYsdVmTFaSDg+XlL
 OXvNJ2412KL1/8vQVlpQofV8u9fcLC4mnXzCXmzv8L56R0aByuvpqzHNfswM1g==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 08:43:50 +0100
Message-Id: <DMT2BO0OMZAC.3IJ7D9NC2GQ0W@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v2] drm/omap: dss: fix handling deferrals
Cc: <dri-devel@lists.freedesktop.org>, <linux-omap@vger.kernel.org>,
 <hns@goldelico.com>, <linux-kernel@vger.kernel.org>
To: "Andreas Kemnade" <andreas@kemnade.info>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261111-gta04-drm-regression-fix-v2-1-010caf3b08bd@kemnade.info>
In-Reply-To: <20261111-gta04-drm-regression-fix-v2-1-010caf3b08bd@kemnade.info>
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

On Wed Nov 11, 2026 at 10:14 PM CET, Andreas Kemnade wrote:
> Forward the error given by of_drm_get_bridge_by_endpoint() if it is
> EPROBE_DEFER to ensure output gets initialized later when available.
>
> On GTA04/OMAP3 no display was found, but it appeared after doing
> rmmod omapdrm ; modprobe omapdrm
>
> Fixes: b7e9b93fc8ecf ("drm/omap: dss: don't create a panel_bridge")
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

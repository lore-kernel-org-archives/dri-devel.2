Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C58C606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=n1/8+wKk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 923FD10EF96;
	Mon, 16 Nov 2026 11:37:39 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8630610E2D3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:37:32 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 6384BC4EFD5;
 Mon, 16 Nov 2026 11:37:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 69FE16023F;
 Mon, 16 Nov 2026 11:37:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 84F1011BC0949; Mon, 16 Nov 2026 12:37:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794829045; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=tlxQbNS6YQ6dC4GW6OJCCMzPULNSrAZH+Tzi4oNheUc=;
 b=n1/8+wKkaYL+fR3a+f5O3cXaZsUZ2LP2/kH6EvLZuqQciO/HWmnBxlP87Krgwjab+hEo1V
 e28S+wm/bNgiSHEm2F7KjKk1AMq4ZWsEFKVfUHNgsNRo0u5ZQfb7UAYv01CQQdl7L0Gbvj
 COzUiq+IZRAA9xsAQGHggG0PYOPK4moR1QCsdqoEgNmoNTePnttnK6MIV2xmsgKNJi1fdb
 EwEFueQfCrqePqeGDKKjFUIX9P3qES5mYvaoS0DEGA/OJXgV4gljcO9Fntx7Xxkgh34A41
 88c6abrL3RTW0XiqpxzYjlVWUqthJqiBD8LqmW0/ft8dQY3Tfm6QPneSjtOS1A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>, 
 "Francis, Sebin" <sebin.francis@ti.com>, stable@vger.kernel.org
In-Reply-To: <20261103-v7-4-topic-am335lpm-tilcdc-v1-1-b7f91f9c9a05@baylibre.com>
References: <20261103-v7-4-topic-am335lpm-tilcdc-v1-1-b7f91f9c9a05@baylibre.com>
Subject: Re: [PATCH] drm/tilcdc: Fix suspend/resume drvdata
Message-Id: <179482904036.190319.14137028928687094984.b4-ty@b4>
Date: Mon, 16 Nov 2026 12:37:20 +0100
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


On Tue, 03 Nov 2026 14:15:33 +0100, Markus Schneider-Pargmann (TI) wrote:
> drvdata contains a pointer to a struct tilcdc_drm_private and not a
> pointer to a struct drm_device anymore.
> 
> Note that this breaks suspend/resume at the moment, it hangs on
> acquiring a mutex.
> 
> Interpret drvdata correctly as struct tilcdc_drm_private as is done in
> the rest of the driver.
> 
> [...]

Applied, thanks!

[1/1] drm/tilcdc: Fix suspend/resume drvdata
      commit: b4d01c788bfa50dc65ffb5fbc9db4135004c0e01

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23845608363D
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=PXvk6PAp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8091A10E1CE;
	Tue,  3 Nov 2026 13:18:04 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA35A10E1CE
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 13:17:57 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 250D94E413E7;
 Tue,  3 Nov 2026 13:17:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E38866046C;
 Tue,  3 Nov 2026 13:17:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C5338103291A0; Tue,  3 Nov 2026 14:17:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793711874; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=KmttJ85pE90PdDzWLTROu9/Of3WqCJlijzaY0DqI8Fk=;
 b=PXvk6PApPG7W6pEWtlWuob97UJQsHqW1FMANL2d3hQbQLED6rseULG94RH19p16BxZmjAO
 niNxyzgUAAbayQb+GBaBI4I2c5sGkzXeY2L0lRA5wb/gwAeO7j311jKR6R7/LSqBS0MwvH
 TTssnqN5+Uu7TEWjx5VE3PdC+lj2D/PVU25ACBDEngaR6h7ZMN/Lp9t4PvwJ4cv97WNnqI
 GBHdNXSaNSCpawOgXpBSgv7D0gWLD7BXCpVSN4oMHSrfUFczlU4W1ASF1oRKHNWZcG/NIw
 8cDHl+PjoPlbvBsxZP/taFrZlV7LypoDgthoQrKtIkSphhd7+4kqKy0v2MFvWw==
Message-ID: <09ee73ca-3ddd-4a09-a5b8-15556e76b8b3@bootlin.com>
Date: Tue, 3 Nov 2026 14:17:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] drm/tilcdc: Fix suspend/resume drvdata
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>,
 "Francis, Sebin" <sebin.francis@ti.com>, stable@vger.kernel.org
References: <20261103-v7-4-topic-am335lpm-tilcdc-v1-1-b7f91f9c9a05@baylibre.com>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261103-v7-4-topic-am335lpm-tilcdc-v1-1-b7f91f9c9a05@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 11/3/26 14:15, Markus Schneider-Pargmann (TI) wrote:
> drvdata contains a pointer to a struct tilcdc_drm_private and not a
> pointer to a struct drm_device anymore.
> 
> Note that this breaks suspend/resume at the moment, it hangs on
> acquiring a mutex.
> 
> Interpret drvdata correctly as struct tilcdc_drm_private as is done in
> the rest of the driver.
> 
> Fixes: 3301302060da ("drm/tilcdc: Modernize driver initialization and cleanup paths")
> Cc: stable@vger.kernel.org
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


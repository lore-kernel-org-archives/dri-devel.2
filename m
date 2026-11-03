Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84133606A336
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=2WprqqPW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E37B010F5B8;
	Tue,  3 Nov 2026 13:56:26 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0233210F5B8
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 13:56:19 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 129D3C8F463;
 Tue,  3 Nov 2026 13:57:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 721F86046C;
 Tue,  3 Nov 2026 13:56:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A9856103291E2; Tue,  3 Nov 2026 14:56:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793714176; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=IWTHRSzeGW5fpCXVav87N82FYLK03Zsl6ESEIn+XvdQ=;
 b=2WprqqPWwIE4yMtpFdjcdwLq29XhBfaKpiYIEBYic/gByEZ+zv06NYLU+a5QT47FTvvXw0
 B4tzlkM4QQu8XwHRvp5uyInplg8m64tUM32MzDmXxc1a+aFV4DbT2pcUJ3v4gFAwIaOq7H
 JzR7FzHplqg4p53/K9IZCWjljox1SwLknQErThZkivVwvstHC7JSJ2uQFPt8ly3bKLd5F4
 sVwlQIPReYAvCji0ZfBLwqg+zMbCBjkSNf5XAPVZMUgymzjCjGXa1ly4+jnX0up9SKKRMF
 7kI+GWt1lAdr3JBtQ6yrECS1EBVtaExy9TtMr07qQGl9JNBw4WyPJx7Kl17MgA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 14:56:09 +0100
Message-Id: <DMLMLTKB2QCE.3MTSUFWC3G8WQ@bootlin.com>
Subject: Re: [PATCH] drm/tilcdc: Fix suspend/resume drvdata
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Julien Panis" <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>,
 "Francis, Sebin" <sebin.francis@ti.com>, <stable@vger.kernel.org>
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, "Jyri Sarha"
 <jyri.sarha@iki.fi>, "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Luca
 Ceresoli" <luca.ceresoli@bootlin.com>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261103-v7-4-topic-am335lpm-tilcdc-v1-1-b7f91f9c9a05@baylibre.com>
In-Reply-To: <20261103-v7-4-topic-am335lpm-tilcdc-v1-1-b7f91f9c9a05@baylibre.com>
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

On Tue Nov 3, 2026 at 2:15 PM CET, Markus Schneider-Pargmann (TI) wrote:
> drvdata contains a pointer to a struct tilcdc_drm_private and not a
> pointer to a struct drm_device anymore.
>
> Note that this breaks suspend/resume at the moment, it hangs on
> acquiring a mutex.
>
> Interpret drvdata correctly as struct tilcdc_drm_private as is done in
> the rest of the driver.
>
> Fixes: 3301302060da ("drm/tilcdc: Modernize driver initialization and cle=
anup paths")
> Cc: stable@vger.kernel.org
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

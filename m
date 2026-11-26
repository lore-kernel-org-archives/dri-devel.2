Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB284606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=pCvaSWpT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F481123F0;
	Thu, 26 Nov 2026 13:37:35 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AEE41123F1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:37:22 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id E3F7B4E417A3;
 Thu, 26 Nov 2026 13:37:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B2701604ED;
 Thu, 26 Nov 2026 13:37:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8E6DA11E68072; Thu, 26 Nov 2026 14:37:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795700239; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=OTlAdjsMnjHpK7mYzreF1Hc8nBUzyBy1IwUaOdo6L+A=;
 b=pCvaSWpTPSboOeyPCEWxm296dT2ARRfMHg/jxbWuTxvylPGzKgJGYSQl4h3BS7GKq4Q7zv
 yx45WbFdHbJUsYFG63QlEWM4hh6IgGzsK/ZRLyPe9xQGgKBgtU+thk+PLi8vzw2f4naOvZ
 aqPBFCt6c5hPWGI0+WONFQofOVevtXply55MOfTMTGeMpzkDfLIhv+HCDIz4lEtQ9w9ruk
 k2TkAeZrkinf3xDXs1rnFcVIwVyqEqn8At85hso4wkH2ohbjo5qROvmiPVbE4ag2NbEgIY
 4xOZi0b6C6VCvMk2wuh3F7S+nVnwUaMoOXhfDp0A8viZR4ItOrZps+w6ysOyGA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 14:37:14 +0100
Message-Id: <DN56LVC0GG0Z.31QWFJ8SS5206@bootlin.com>
Subject: Re: [PATCH] drm/exynos: hdmi: put bridge reference on probe failure
Cc: "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, "Peter Griffin"
 <peter.griffin@linaro.org>, "Alim Akhtar" <alim.akhtar@samsung.com>, "Luca
 Ceresoli" <luca.ceresoli@bootlin.com>, "Marek Szyprowski"
 <m.szyprowski@samsung.com>, <dri-devel@lists.freedesktop.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
To: "Yige Jiang" <yigejiang86@gmail.com>, "Inki Dae" <inki.dae@samsung.com>,
 "Seung-Woo Kim" <sw0312.kim@samsung.com>, "Kyungmin Park"
 <kyungmin.park@samsung.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <rc-b1-20261110-vc-19-b220c856ecbb@gmail.com>
In-Reply-To: <rc-b1-20261110-vc-19-b220c856ecbb@gmail.com>
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

On Thu Nov 26, 2026 at 6:58 AM CET, Yige Jiang wrote:
> hdmi_resources_init() ends with hdmi_bridge_init(), which takes a
> reference on the next bridge with of_drm_find_and_get_bridge(). That
> reference is only dropped in hdmi_remove(). When hdmi_probe() fails
> after hdmi_resources_init(), including the -EPROBE_DEFER returns for
> the DDC adapter, the PHY and the syscon lookups, the reference is
> leaked, once per failed probe attempt.
>
> The sashiko AI review bot pointed this out on dri-devel on 2026-07-16,
> in its review of an unrelated exynos_hdmi patch.
>
> Drop the reference at the end of the probe error path and route the two
> early returns after hdmi_resources_init() through it. drm_bridge_put()
> ignores NULL, which covers boards without a bridge on port 1.
>
> Fixes: 2db0d298f22d ("drm/exynos: hdmi: convert to of_drm_find_and_get_br=
idge()")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20260716132919.A3EA81F000E9@smtp.kernel.o=
rg
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E92D606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=jt/zlPSz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DF9D10FD08;
	Wed, 25 Nov 2026 16:11:46 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 800DA10FD08
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 16:11:27 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 524D71A17F4;
 Wed, 25 Nov 2026 16:11:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2793360480;
 Wed, 25 Nov 2026 16:11:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A559311E6ABF5; Wed, 25 Nov 2026 17:11:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795623085; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=tbs9QZ54tCRQ/HtclM3IabBk9mVStM5QK20RUGLtRbE=;
 b=jt/zlPSzPlDxOt36gF1yOUZ/2F9s3nhlFcOFekHfBF2rwocHmQIUzHhziaUu7yrnYFkVB9
 HIIUVK4+XGY57cyTvM330UdV6qXCjGZnpayUdSfJmksDn+TkRr+ne8pMIigFM11FKAS8L5
 SskizWrctJNG8aXAKjms4nMYXFKV9nDguw0h6cJDTLz/lb0raupFm8eWtKgDA+zGnrUvyC
 Vmw2yTQqyfyKZSmL1vvFfq4u3SNeQ1lGshEYfCyhIKMBA5Ft/5pzBQpF6WQS07/NEIVyUL
 kKoZYKjIezPbcWde1OLTdBtAxDiZPGC2e2rEQFSjZq6mBmYetCIIHvvmIa7smg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: laurentiu.palcu@oss.nxp.com, Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 marek.vasut@mailbox.org, mripard@kernel.org, stable@vger.kernel.org
In-Reply-To: <20261124112215.12255-1-festevam@gmail.com>
References: <20261124112215.12255-1-festevam@gmail.com>
Subject: Re: [PATCH v3] drm/mxsfb: lcdif: Fix use-after-free on unbind
Message-Id: <179562308334.731258.14637573993541736813.b4-ty@b4>
Date: Wed, 25 Nov 2026 17:11:23 +0100
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


On Tue, 24 Nov 2026 08:22:15 -0300, Fabio Estevam wrote:
> lcdif allocates its private data, which embeds the CRTC and primary
> plane, and its encoders using devres. These DRM objects are linked into
> the mode_config lists.
> 
> Since mode_config cleanup is DRM-managed, it is deferred until the DRM
> device is released. An open DRM file can keep the DRM device alive after
> the platform device has been unbound and devres has freed those objects.
> The later mode_config cleanup then dereferences freed memory.
> 
> [...]

Applied, thanks!

[1/1] drm/mxsfb: lcdif: Fix use-after-free on unbind
      commit: 479e381e77dcde0dfcc9d51e89ff3273da199804

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AE4606A329
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1HLjEA6k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A557910E67D;
	Fri,  6 Nov 2026 13:56:07 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2373310E67D
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:56:01 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id D28B24E413FC;
 Fri,  6 Nov 2026 13:55:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9DBBA5FFBC;
 Fri,  6 Nov 2026 13:55:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 357AE103293C9; Fri,  6 Nov 2026 14:55:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793973354; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=eVV5WcmATBQj5kdlszV3xcqV1u/ocCnzojcIn5gRuXA=;
 b=1HLjEA6k/8398JpgmQXcsEnBqk6hWRN+X8RQda4zNSUmT2Yv4b2cMa6pHeTy8oQe41xfsG
 C+n7pslXUKjB8+uESCt+UOP3jnKwUTaiIexoFJJwrE4s40bDbayGYngcc7OppUK3cD3CSQ
 GOFoEbfi8JMvzL+yTGP+viYcmFfOrBRYrEEDkHopctTuqS3oto9WIQMtUsdPhRCScqBKvZ
 f0/60bmTK3SUUK8JvvvSmPqwIkbyIer7ZDfeiYn82L+nVr+mMvFH9SsLE3fuPiotzyoMkJ
 wk6R7yBosuRyvqUVMn0pwGDtlBtiM10kY5uOFKDehJJDOVf8JTdbeg9EE1o5aQ==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Nov 2026 14:55:47 +0100
Message-Id: <DMO6H6FTHD1T.36AXZ14RLKCXB@bootlin.com>
To: "Maxime Ripard" <mripard@kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jyri
 Sarha" <jyri.sarha@iki.fi>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v8 01/39] drm/ingenic: Convert to devm_drm_bridge_alloc()
Cc: "Devarsh Thakkar" <devarsht@ti.com>, <dri-devel@lists.freedesktop.org>,
 "Paul Cercueil" <paul@crapouillou.net>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-1-cbe78624e1bc@kernel.org>
In-Reply-To: <20261106-drm-state-readout-v8-1-cbe78624e1bc@kernel.org>
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Maxime,

On Fri Nov 6, 2026 at 2:14 PM CET, Maxime Ripard wrote:
> The ingenic driver allocates a structure holding both the DPI encoder
> and the source bridge of its pipeline, and allocates it as a whole
> through drmm_encoder_alloc(). The bridge is thus not known to
> devm_drm_bridge_alloc(), which drm_bridge_attach() already warns
> about.
>
> The bridge private object also gets its name from the devm bridge
> allocation, and drm_bridge_attach() will soon report a failure of
> that initialization instead of ignoring it, so a bridge allocated any
> other way would prevent the driver from probing.
>
> Allocate the structure through devm_drm_bridge_alloc(), making the
> bridge the primary object of the allocation, and initialise the
> embedded encoder in place with drmm_encoder_init(). Both objects
> stay in the same structure, so the container_of() conversions keep
> working, and the bridge funcs assignment moves into the allocator
> call.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Seems there are now 3 competing patches to fix the same issue! :)
This, [0] and [1].

[0] https://lore.kernel.org/all/4f30341735d77c77a9a4952abd91879007bc00fd.17=
87604223.git.hns@goldelico.com/
[1] https://lore.kernel.org/r/20261105203517.2293404-1-f.fainelli@gmail.com

However yours does not add a call to [devm_]drm_bridge_add(), so I'd rather
prefer applying [1]. Also [1] removes the encoder pointer as it is not
really necessary.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

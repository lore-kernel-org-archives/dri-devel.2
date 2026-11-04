Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA25606A32E
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kTHHYk48
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5041510E285;
	Wed,  4 Nov 2026 17:45:04 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90B3010E285
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 17:44:57 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 2E7F54E41403;
 Wed,  4 Nov 2026 17:44:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E826B60770;
 Wed,  4 Nov 2026 17:44:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 946C410329205; Wed,  4 Nov 2026 18:44:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793814294; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=2OZGfbXAgtd+w2idgiB8GoPuMMh0i+bVPHx9lPE1lZA=;
 b=kTHHYk48A0LYy1x9rjVQdFvmO/rOU1MWiXaAvFQaqKzoNuq/1r0GEMb/3YJ+ywpnpi2/Vi
 sfPb7vit5c2vInGRjx6C8xDwUJjDEMUMl/QfyQpznpRKWelUb8I3FvOt8SlNj//m0/DDiW
 uJZ2p+7LH4UIXmje2dnM4FS/N+cTWvZCIsRNNxztFqiCmrN+7P6I5nFPPgHYsj0VgZ3dFS
 onRzwv4sCJvDKtqY1Rc4scdqXGcZIIejJEpc1PxWi9qFVV88oWnoBr4wAVGHwbQfzt78Pb
 tU8kbOLATbWMPeypsPtWPBOqDiKXFuOsR1a0z8PFJJLOzg03aZuggl6SnPgceQ==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 18:44:47 +0100
Message-Id: <DMMM3FFSQC5C.3PDA68QJ6WR2Z@bootlin.com>
Subject: Re: [PATCH v2] drm/bridge: sii902x: validate I2S data lane values
Cc: <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <luca.ceresoli@bootlin.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Pengpeng Hou" <hppiscas@163.com>, <andrzej.hajda@intel.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260920034833.18874-1-hppiscas@163.com>
In-Reply-To: <20260920034833.18874-1-hppiscas@163.com>
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

On Sun Sep 20, 2026 at 5:48 AM CEST, Pengpeng Hou wrote:
> The sil,i2s-data-lanes property reader bounds the number of entries, but
> does not bound each entry's value. Those values index the four-entry
> i2s_lane_id table when the audio FIFO sequence is built.
>
> Reject unsupported lane values before indexing that table. Report the
> property name and invalid value with dev_err_probe() so the diagnostic
> identifies the faulty configuration.
>
> The issue was found by our static-analysis tool.
>
> Fixes: ff5781634c41 ("drm/bridge: sii902x: Implement HDMI audio support")
> Assisted-by: gpt 5
> Signed-off-by: Pengpeng Hou <hppiscas@163.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

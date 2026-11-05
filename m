Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E309606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=qf6nHwO3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1A4D112624;
	Thu,  5 Nov 2026 15:14:18 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A4EB112623
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:14:12 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 89271C6915A;
 Thu,  5 Nov 2026 15:14:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 52C145FF85;
 Thu,  5 Nov 2026 15:14:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 68FE4103291F6; Thu,  5 Nov 2026 16:14:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793891645; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=1TbfFZ0rX1H3p3+f72DuVqW3kgygq5FmVZx7OZnnltM=;
 b=qf6nHwO3UppGlaUN/xkeMWxjAyMHF70M9lACu2o4QRprZWnrydDLb7fLLnIt85TEX0ROnX
 SSaCqLKjWjjCObkarU024SG5StKCYA6+WUYl0w2vux+sgZhOKjOedofWW/QYpPd7DUqLxb
 /Q7X42z/vb1JwVd2aRdB9M/x8pMwVr2GDPhhyNGPw/eQUKvpVO9O/25nOySLub58huIlNn
 zOEriLq7b0FgYgBxeMDb+MpsJKMGKAwgkGPLHNZ1XEpgtZRJuLP6JVbZGl1WDYqh6FRmau
 l2UjN5P46WRA+YX3uQ/yCGanVIDWLHh/rdHH8z0oE+fWtxwtWo1UXU+ROTSzWg==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/7] MAINTAINERS: Remove Jonas Karlman from bridge
 reviewers
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, 
 David Airlie <airlied@gmail.com>, Maarten Lankhorst <dev@lankhorst.se>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
In-Reply-To: <20261105142127.708219-4-mripard@kernel.org>
References: <20261105142127.708219-1-mripard@kernel.org>
 <20261105142127.708219-4-mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:13:57 +0100
Message-Id: <179389163713.1070495.14456653716575076524.b4-review@b4>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Jonas Karlman's last review for the DRM bridge subsystem dates back to
> 2019, and he has never committed to drm-misc. The bridge subsystem has
> been de facto reviewed without his involvement since.
>
> Remove the reviewer entry to match the current situation.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Based on a 'f:Karlman s:bridge' search on lore.kernel.org/dri-devel and
some git log research, there seems to be just two e-mails remotely related
to the core drm-misc code, so:

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21634606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=VyRzKilz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CD2C10ECE2;
	Thu,  5 Nov 2026 14:55:13 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DE6510ED8E
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:55:06 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 14FA84E40826;
 Thu,  5 Nov 2026 14:55:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D67BF5FF85;
 Thu,  5 Nov 2026 14:55:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 90B2D103291F6; Thu,  5 Nov 2026 15:55:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793890504; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=NbRx1XLMkKiVicfAKy5ajbt05VbZfQGmrrwyyWgtBoc=;
 b=VyRzKilzjpf3Jr6WO6E+dFE6qohIiK6elVYORiCMUt4VnH7qL49wy/MkFirUEyBOHO2wXA
 HYl1lELaPTZhq/iMBekaSgGSGMBw2rCVJ4MnmLCRALMl7t3R99w2nueyJyscNXeMf1f6KB
 cxurjyhNdZJIO0u/Wl+/K03ReMvv9HpYVCJ0TYC5rr9iGSO4C6xQgsgZCuYfD8MwBONPyz
 A90Vtwi54jldI/pC+PfRNUQ+9hfZk1u0iPIXm9IcDzwGu0lPuJVDi80Nnr6Z2FIfzFxgq2
 qPM09hgy25tWI0VsVSrwF0HWV5E/4cJ84hKXy0N6Nx3R7mDxayFiWWsIivls6Q==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 6/7] MAINTAINERS: Remove myself for VC4 DRM driver
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, 
 David Airlie <airlied@gmail.com>, Maarten Lankhorst <dev@lankhorst.se>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20261105142127.708219-6-mripard@kernel.org>
References: <20261105142127.708219-1-mripard@kernel.org>
 <20261105142127.708219-6-mripard@kernel.org>
Date: Thu, 05 Nov 2026 15:54:39 +0100
Message-Id: <179389047999.1070495.1488399769901611528.b4-review@b4>
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

On Thu, 05 Nov 2026 15:21:26 +0100, Maxime Ripard <mripard@kernel.org> wrote:
> I have not been actively involved in VC4 maintenance for a while. The
> driver is in good hands with Dave and Maíra.
> 
> Remove my maintainer entry to match the current situation.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


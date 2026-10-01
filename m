Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E639ECA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4424210E304;
	Thu,  1 Oct 2026 07:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="xhGFSjFe";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97C8010E304
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 07:57:30 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id EDA9E4E410EC;
 Thu,  1 Oct 2026 07:57:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B57E660346;
 Thu,  1 Oct 2026 07:57:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C4CB81032989B; 
 Thu,  1 Oct 2026 09:57:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790841447; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ea1fbe+c1Bj2VsRfvIM5hRTESNst+GdPGcpUsHtDn1s=;
 b=xhGFSjFeLsF3SZONrAZrzTJVCqVwIvWnYEHDHUlJoJmsYayI0bwZsvuZnf3d+LHraIYpd+
 dEiR+rfJfjqirMbA041CebIgW2HYLZ10HLWzAqOkI3JM3rgwn7LDAgXrqpEwHt9ivewXax
 it2Qv3MSBzzPJw2imwd32vLJzFZim3vFO1MEQETjsNaEkdfg/bbwBz42wyD2bMUxDZg1yE
 tJguCgn7hybaTONn2X7pzga6vrDtHbJkKNP3CNuDaTOnFNgSjqIb+7sS4rDKlfbWFhHtCJ
 /LE7fNMo1bPQzByQ7cL+9x01d5ryHIuqwb5CoI7hHoDnRIw37h47fUswcRb3mg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
In-Reply-To: <20260928210326.1526997-1-rdunlap@infradead.org>
References: <20260928210326.1526997-1-rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation/gpu: fix location of drm_panel
 kernel-doc
Message-Id: <179084144262.1017724.17529088161372803961.b4-ty@b4>
Date: Thu, 01 Oct 2026 09:57:22 +0200
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
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


On Mon, 28 Sep 2026 14:03:26 -0700, Randy Dunlap wrote:
> The source file location was changed, so update the documentation
> accordingly. Fixes these warnings:
> 
> ERROR: Cannot find file ../drivers/gpu/drm/bridge/panel.c
> ERROR: Cannot find file ../drivers/gpu/drm/bridge/panel.c
> WARNING: No kernel-doc for file ../drivers/gpu/drm/bridge/panel.c
> 
> [...]

Applied, thanks!

[1/1] Documentation/gpu: fix location of drm_panel kernel-doc
      commit: aefb99d4406ee2f3f22b1b4211717a194262e8c8

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7E3C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 08:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B837110EF6C;
	Wed, 15 Jul 2026 08:52:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="UktgJmLN";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F42310EF66
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 08:52:31 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 975A5C2B9CC;
 Wed, 15 Jul 2026 08:52:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BC0826035C;
 Wed, 15 Jul 2026 08:52:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 035F611BD3AD3; 
 Wed, 15 Jul 2026 10:52:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784105548; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=mAxNHnURgECiVgbbdE4OlSzC0AXpBOq2TdlBOOqCMVw=;
 b=UktgJmLN1DSChEyr77+mRDqvR4VKDfZLyYQrRu/z+86zqysEZiCgL3BeDKTCimSjQKYQSs
 3bNwF3D6vjxkFAT22q+sVtw5HQ0KQTvxpUPjNEzcK5lY9/nBwe0h/9XIRShmjtMF8yKehG
 +9lf2y8T4YNXth34t9snppDtrVxN3ZEnLiycLKJS17A7alr5FSEanPJopBuyLsJvCVzkyX
 2Uzw7pJaZ/Y+IkP+v53UgcBU+v70X0oIYwphU8FVfh5EN3zezqVb7WTlNuVyIUspUXJAXy
 8CWabKPlmVtaKrgiXMrvtnnEy2xEZVUwtNazsyKm0McW9PbkkT9uoZEqtavhJQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi83: Fix problem with
 premature PLL locking
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Esben Haabendal <esben@geanix.com>, Gary Bisson <bisson.gary@gmail.com>
In-Reply-To: <20260711-ti-sn65dsi83-fixes-v1-2-d85eb5342b98@geanix.com>
References: <20260711-ti-sn65dsi83-fixes-v1-0-d85eb5342b98@geanix.com>
 <20260711-ti-sn65dsi83-fixes-v1-2-d85eb5342b98@geanix.com>
Date: Wed, 15 Jul 2026 10:52:18 +0200
Message-Id: <178410553814.253594.6153852459811911516.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Sat, 11 Jul 2026 13:51:15 +0200, Esben Haabendal <esben@geanix.com> wrote:

Hi Esben,

+Cc Gary

> [...]
> 
> This is the same issue as addressed in the patch by Gary Bisson [1],
> but changing the ti-sn65dsi83 driver instead, so we don't have to change
> all other drivers that could potentially be used with this chip.
> 
> [1] https://lore.kernel.org/all/20260120-mtkdsi-v1-1-b0f4094f3ac3@gmail.com/

AFAICU your patch would replace Gary's one. Also Gary's patch has been
reported to introduce regressions but it hasn't been reverted yet. Can you
reply to that thread mentioning your patch, so everybody in the discussion
is aware of your alternative proposal?

> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>

If it's a fix it should have a 'Fixes:' tag and a 'Cc: stable' line
(https://docs.kernel.org/process/submitting-patches.html) and it should be
the first patch in the series, to facilitate cherry-picking on stable
branches.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A65C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 832B310F2C0;
	Wed,  2 Sep 2026 16:24:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="qEQPobQs";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED3A110F2C0
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 16:24:49 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 7C9FF1A1967;
 Wed,  2 Sep 2026 16:24:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4CD896053C;
 Wed,  2 Sep 2026 16:24:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 65A2D11C798E5; 
 Wed,  2 Sep 2026 18:24:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788366283; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=hLJ/CpxXuD6ymjaCOfhQB55zWbz7W46bUrSUDWQxz98=;
 b=qEQPobQsuSS1W3WnE+pn3kyGDUNRCKh/tfOnc09s0U2gLCWggput97YZW93UfrWS7UEqdx
 uhFblnOfLCVLJjzi8jxI6wHcN82dlQdoSJpOVloHidOKekKqmf3XDlO19kNLzub27a1I0p
 rxPKeLNZxAt88Q0fYuSVlmqxZQYeyKmfM4uwq9S5BdJCk683Tauiwd4fB0RpMMA2+yJ8n7
 eKl4RfzqYl79lcqrUlhhMDsq2AnPec2pFUVqEBC5BfpxEPTizB5B58hidT0rW9oiIFgphN
 VnExDr3vLLTsXzz/o0F3hgfoCXeWUJOUXXz4p3WwaU8gKdgo414iJaSRxuZ1Iw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michael Walle <mwalle@kernel.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Osama Abdelkader <osama.abdelkader@gmail.com>
In-Reply-To: <20260812151000.74799-1-osama.abdelkader@gmail.com>
References: <20260812151000.74799-1-osama.abdelkader@gmail.com>
Subject: Re: [PATCH v4 4/6] drm/panel: Use managed helpers in Himax and
 Ilitek panels
Message-Id: <178836627813.834353.158292906822547823.b4-ty@b4>
Date: Wed, 02 Sep 2026 18:24:38 +0200
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


On Wed, 12 Aug 2026 17:09:59 +0200, Osama Abdelkader wrote:
> Use the managed MIPI DSI attach and panel add helpers in Himax and Ilitek
> panel drivers and drop the corresponding manual detach and panel remove
> calls from remove paths.

Applied, thanks!

[4/6] drm/panel: Use managed helpers in Himax and Ilitek panels
      commit: 44b944ab41afd9e490fc99014afa21ad0af479c6

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



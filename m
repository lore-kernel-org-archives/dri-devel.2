Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA52CD98D2
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 20:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75DCF10ED41;
	Tue, 16 Jun 2026 20:36:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Lza3w7lR";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE4F10ED41
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 20:35:59 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 8035F4E42F1E;
 Tue, 16 Jun 2026 20:35:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3D0DF601A9;
 Tue, 16 Jun 2026 20:35:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B6882106C9FF2; 
 Tue, 16 Jun 2026 22:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781642157; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=7+6hB3Fw7KfOt6+AkSxjuJNMlohcfYWDsd5fCjWwOa8=;
 b=Lza3w7lRiXgwEcast8cUAsl15IYPFgA9qxv5/liHhSt13ZsaF/FxD16tvdwxvyBTXybTmA
 5ZFY+q9Ob2Mz847ygbu8yak3ZWXSYu/sFUjlzWkyxXGMvUAFiVmlg6opS2MV+YMw8wV/j+
 Q92yBg8q8rSGL6KSLK5GYUtPxYLfI99aPva5x4FOPeHG4W90eh5lmS1hQMHDp3AeAg3MjI
 ijszNA+RVMvz9gTdJlPcDdBpAQ+lXN4fWMlSPEa9AL4tr5o3SN0UYSUU1Y7t+lvrYY3ZyA
 Mym0OrkVf3K51+13CDJGbTTVxFpidnedzVmtcsR4HNCNvfQ9ld3knmLf0TRoYQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260517172136.3321-2-thorsten.blum@linux.dev>
References: <20260517172136.3321-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH RESEND] drm/bridge: sii902x: inline
 i2c_check_functionality check
Message-Id: <178164215213.192266.5005128241385538664.b4-ty@b4>
Date: Tue, 16 Jun 2026 22:35:52 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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


On Sun, 17 May 2026 19:21:37 +0200, Thorsten Blum wrote:
> Inline the i2c_check_functionality() check, since the function returns a
> boolean status rather than an error code.

Applied, thanks!

[1/1] drm/bridge: sii902x: inline i2c_check_functionality check
      commit: ef1d1506976f9bd35864344d2a78a67bf6091bdb

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



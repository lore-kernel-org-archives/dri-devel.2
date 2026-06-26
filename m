Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A484C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 16:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D93FB10E0A3;
	Fri, 26 Jun 2026 16:44:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="x3TH2KpN";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEB0D10E0A3
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 16:44:20 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id AC772C5CD68;
 Fri, 26 Jun 2026 16:44:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A2C6460232;
 Fri, 26 Jun 2026 16:44:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 68F3F104C9D9B; 
 Fri, 26 Jun 2026 18:44:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782492257; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=odS7JwgpXfkCrWEp5Id6aL7qKDLYaA361cQYEGdJGLE=;
 b=x3TH2KpN6NRrrEsKTtBPCvrrKxHO5afqpDhCpgkGzHplOB+UBK5W+dm2IKDxKIou7EZFZZ
 2JQhsnw8eFRt/WLTqeYlT2lnRHAgA3hTz7ZwByiM+nEsPpVWF+78F8Zchf4IWETfHuX3WR
 ZXnVPPfzNxXoe2hY3UGwI0E84upIdQzKcZE/mzx35BElxm/sS7NxfDBtykqZEkj4oOj8CN
 EDxQ+LWbG4yrnw9xEF508Lni089lCn09la8RDm5mR2EOewQQ5dqyQ2Qu+zYvFYHQjgc84S
 FRUbkeyOuEYjDPFdul0KzwgxgTNRW+6h63uoz5KuYjXbRqTo5rH/xvcDAslkBw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Damon Ding <damon.ding@rock-chips.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20260617080755.186368-1-damon.ding@rock-chips.com>
References: <20260617080755.186368-1-damon.ding@rock-chips.com>
Subject: Re: [PATCH v1] drm/bridge: of-display-mode-bridge: Fix missing
 static const for the bridge funcs
Message-Id: <178249225295.1442258.4071784445495013828.b4-ty@b4>
Date: Fri, 26 Jun 2026 18:44:12 +0200
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


On Wed, 17 Jun 2026 16:07:55 +0800, Damon Ding wrote:
> Add static qualifier for of_display_mode_bridge_funcs to resolve the
> sparse warning:
> 
> drivers/gpu/drm/bridge/of-display-mode-bridge.c:54:25: sparse: sparse:
> symbol 'of_display_mode_bridge_funcs' was not declared. Should it be
> static?
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: of-display-mode-bridge: Fix missing static const for the bridge funcs
      commit: 6648301c5bb2ef23f0fb15bcb01d21ff66f36799

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



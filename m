Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFABDC44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 16:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3206510E058;
	Tue, 14 Jul 2026 16:05:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="xMbC8IEA";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A2010E058
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 16:05:38 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 3CDE01A0FCE;
 Tue, 14 Jul 2026 16:05:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0285660346;
 Tue, 14 Jul 2026 16:05:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 31C9111BD3A80; 
 Tue, 14 Jul 2026 18:05:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784045135; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=p2Q03M5Qo5hBXFIilmL0M/xoaJQC1jAcQbHh/u0YmIM=;
 b=xMbC8IEAgTFmtK4TcGjrhyoQeEg9EPgAFQybhNbI3UPiNUpHLvBz52JW6MJSG1TBsFOKEG
 GxNCffBYTc7032xcZ4b1FEpxhQbzVj6b6EW40/hpvfRTIb+TEthC33HhgPUooFVY8sXA4e
 k2OVNgQzk4iKHp3Y0f7y8A5WFPJrViLWCGU182c0IjOJa4coLteIUKa+5Pmtpful3aX452
 /PHAbs50/xi76Lvq1zvPbqRhcZvgMR1CfRhfx8Vqd2nQGkx9Tp7hg81ti9bsyVtkuiiy69
 XYjUzN51qnx2dE5qWaUuuYhfvzHmUJdfCgQTAmI30hQtKIhcNDUtF/XPS4Kuxw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Miguel Ojeda <ojeda@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 llvm@lists.linux.dev
In-Reply-To: <20260630-drm-bridge-alloc-getput-for_each_bridge-2-v2-1-e0a1094cd1eb@bootlin.com>
References: <20260630-drm-bridge-alloc-getput-for_each_bridge-2-v2-1-e0a1094cd1eb@bootlin.com>
Subject: Re: [PATCH v2] drm/bridge: rename
 drm_for_each_bridge_in_chain_scoped() to drm_for_each_bridge_in_chain()
Message-Id: <178404512885.172760.6481594517700778969.b4-ty@b4>
Date: Tue, 14 Jul 2026 18:05:28 +0200
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


On Tue, 30 Jun 2026 17:34:04 +0200, Luca Ceresoli wrote:
> drm_for_each_bridge_in_chain_scoped() was added in commit e46efc6a7d28
> ("drm/bridge: add drm_for_each_bridge_in_chain_scoped()") to provide a
> safer alternative to drm_for_each_bridge_in_chain().
> 
> Following commits converted all users to the _scoped variant.
> 
> Finally commit 2f08387a444c ("drm/bridge: remove
> drm_for_each_bridge_in_chain()") removed the old
> drm_for_each_bridge_in_chain() macro.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: rename drm_for_each_bridge_in_chain_scoped() to drm_for_each_bridge_in_chain()
      commit: 12f5090aaa3cc82ce2d8ca0d7bb2b86817587ace

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AB0C44508
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39AEB10EDE4;
	Tue, 14 Jul 2026 15:54:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="n/R9hmPu";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D363E10EDD9
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 15:54:31 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 544D7C2BB2B;
 Tue, 14 Jul 2026 15:54:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8DDB660346;
 Tue, 14 Jul 2026 15:54:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ACECA11BD3A82; 
 Tue, 14 Jul 2026 17:54:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784044468; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=bbSHOm7BNCYZlHJmtGBGb+6q9viN/SchVJIMjpMhTpg=;
 b=n/R9hmPuyG/3Aei/5gutGv/WBZOROlPKU/fxcWGxUgU/f6zht3WTDl40/IUSnaGp8Gs3mn
 UGkckHJVS9d8AGvsPqwvp2NDkUBK1w6TIIJbofXD9VL3uuIy4rdkRQja1rOssLHG4SUF8A
 WsMxRCFiW5gbwXIZMXtiG2FnXnKEzKuc/FMGITCrgiBhWPHsi3xQlgCwqcbRKghacz1rug
 aqIQuoi54Xk5gEJKDzNdkEJF8qK+eE6VFdBwbOzIcbOVvwEvjh7snscdVVrZQpGlyxp158
 PHHR2tKK6NkRXExyjC4OTWz2RQ+0ptqeWrf58tmV1SJLm3vtQBwo41y5AskTyw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
In-Reply-To: <20260701-drm-fix-graph-wording-v1-0-295605c5777b@bootlin.com>
References: <20260701-drm-fix-graph-wording-v1-0-295605c5777b@bootlin.com>
Subject: Re: [PATCH 0/3] drm/bridge: fix wording in comment about graph
Message-Id: <178404446038.105154.7716378996117612511.b4-ty@b4>
Date: Tue, 14 Jul 2026 17:54:20 +0200
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


On Wed, 01 Jul 2026 19:19:37 +0200, Luca Ceresoli wrote:
> These patche fix the (almost) same grammar error in a comment, in all
> places where this comment is duplicated.

Applied, thanks!

[1/3] drm: of: fix wording in comment
      commit: e73e34a4a4c2a9d4359202a2ed02f4930684dd01
[2/3] drm/bridge: samsung-dsim: fix wording in comment
      commit: 7a8ece0e0d7006164c2ba51f2726964cc1818117
[3/3] drm/bridge: fix wording in comment
      commit: e8113d658235369fb31584c58538a5d2bc6fe867

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



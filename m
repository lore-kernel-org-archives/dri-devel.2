Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E51F31E21
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:32:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC96B10E80C;
	Thu,  9 Apr 2026 14:32:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="hd/bJAYy";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CA7D10E80C
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 14:32:36 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id B5B6E4E4293F;
 Thu,  9 Apr 2026 14:32:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7DA2B5FDEB;
 Thu,  9 Apr 2026 14:32:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0D86C10450115; 
 Thu,  9 Apr 2026 16:32:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775745153; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ZAtdBYs9gQt4rDjaRiK5aADtujPQmsYU7Ky31N2KEZ8=;
 b=hd/bJAYy9L11WuLw+laHvgRIrRfzAV7RdgCr0qG6M9dfli0VdriVQGG8DHd34E7LqO6yfg
 n8W/ypUN4PrmqaYBW5pBVy+unqPcLFwnMmkxVlYTfghVZoOUJJUd09iskuQQonogcbMaE6
 RmWZhafgzg8slU5IPbBT9COcUSnkBCpccVX2CM61hIqcmuBcw2mQocDWq9rm4Fux9gj1hC
 TKh08zFIgOXH/0F0w9sIZ+EY+jB9Hz0goAL7AIcmOh4hWlKV9aKNZhkUd3vq3u66nu0tU6
 Bch23IYm3kdsKXSgfT8xCeHrHJaftCUU0nY7OuNZc3hsza+x9wspLU9Haa0j3g==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Liu Ying <victor.liu@nxp.com>, Hui Pu <Hui.Pu@gehealthcare.com>, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260324-drm-bridge-alloc-getput-document-null-check-v1-1-fb0877c49d7e@bootlin.com>
References: <20260324-drm-bridge-alloc-getput-document-null-check-v1-1-fb0877c49d7e@bootlin.com>
Subject: Re: [PATCH RESEND] drm/bridge: drm_bridge_get/put(): document NULL
 pointer behaviour
Message-Id: <177574514860.744793.15877101251711269066.b4-ty@b4>
Date: Thu, 09 Apr 2026 16:32:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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


On Tue, 24 Mar 2026 10:08:49 +0100, Luca Ceresoli wrote:
> drm_bridge_get and drm_bridge_put() do nothing when they are passed a NULL
> pointer, and they do so since their initial addition in commit 30d1b37d4c02
> ("drm/bridge: add support for refcounting").
> 
> This allows simpler code in various places when using these
> functions. However it's not documented, so it's not clear whether it is
> part of the API "contract" or just a current implementation detail that
> might change in the future.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: drm_bridge_get/put(): document NULL pointer behaviour
      commit: af29fcbe806ecd10078c406470fecb902b3c0e55

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


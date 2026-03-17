Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EF7FED9EC
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A714910E141;
	Tue, 17 Mar 2026 17:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="yE5Bkup9";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C607710E141
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 17:07:37 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 89ED81A2E71;
 Tue, 17 Mar 2026 17:07:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 48DF25FC9A;
 Tue, 17 Mar 2026 17:07:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 117061045064C; Tue, 17 Mar 2026 18:07:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773767255; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=5sNJNSogvr16Wozc+mtgqMSKlfmbe78cmdvZN+TyoWI=;
 b=yE5Bkup9p6p9P3AOWDRLxDte3cdwwQ921DViN/Y1JQKlLVyb05JJrTNSBaDPTZ0Fo5JsBV
 1s9Ar+bZb4ADSiCYvJRE/XyML4kfJGZpL5X7fv4nj228YGtAXhsJp/Mf4jxpS3Go17sPn1
 JzAEtcowWF3WjvRaZIfNq7iilbNI8YvlmvQr13C8gVtwB3GLTRcS9dP3TVUcdAC6tBqLJu
 wPw1BE3flvucnDAYPULwEWU6SIl1Q3nTcj1sJlHGkH/ry9k9EgcrvxpqJpRxEesV1cZv/Y
 UKv/UYIAD4Q2Xw1bcE1tBd+hJFvr9DMqHCu2fAoqzCDRJppgGJbpIeHn22bJvg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Joseph Guo <qijian.guo@nxp.com>, kernel test robot <lkp@intel.com>
In-Reply-To: <20260307033245.71666-1-ethantidmore06@gmail.com>
References: <20260307033245.71666-1-ethantidmore06@gmail.com>
Subject: Re: [PATCH] drm/bridge: waveshare-dsi: Fix signedness bug
Message-Id: <177376724986.1882915.15882507831794720723.b4-ty@bootlin.com>
Date: Tue, 17 Mar 2026 18:07:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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


On Fri, 06 Mar 2026 21:32:45 -0600, Ethan Tidmore wrote:
> The function drm_of_get_data_lanes_count_ep() returns negative error
> codes and dsi->lanes is an unsigned integer, so the check (dsi->lanes <
> 0) is always impossible.
> 
> Make the return value of drm_of_get_data_lanes_count_ep() be assigned to
> ret, check for error, and then assign dsi->lanes to ret.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: waveshare-dsi: Fix signedness bug
      commit: a469749640fbcd2f49ab05fb83cca3da07f35ee3

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


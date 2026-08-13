Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12A2C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0705510F335;
	Thu, 13 Aug 2026 13:30:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="KUAcFqlC";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 373278903B
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:30:47 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id BA3B04E411FA;
 Thu, 13 Aug 2026 13:30:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 85571602B8;
 Thu, 13 Aug 2026 13:30:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D87E511C4DF36; 
 Thu, 13 Aug 2026 15:30:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786627840; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=7cSIcWpLL5MF5M7OTNVPE4aBZy2yR3yCV865rYsklRk=;
 b=KUAcFqlCoHh0jv7vLJ9sszaPMG/VrO4ykTVrP+BW3LlNKl+OnAd9UcJqZW9SwweC6Y6Ds2
 6qQb41sNRa1OHLULLTFSolWgrK/afzbNZAKomwCcO95dpPJswWUTxfPXPygD6IrdyMajay
 e1KRa2qlTl3H962bKIJWMUyB/KeroOJ3xO2mdVtvDLJANO9qt9wNSsLhD1Shbucr4yB4sl
 HewgCMuGureG1Jp9+ZJR6lPbt3NQ3TPsR6v0HAqy4pjw9WVVZ46xdP4iQ4mKHwSB75d55K
 lhY8i9xtQUBPfCB3CEUsSWIpzoeC/82JBPwgqxDh972bRqiYQGzf0FvBoLipmA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: linux-kernel@vger.kernel.org, Wojciech Dubowik <wojciech.dubowik@mt.com>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
In-Reply-To: <20260728122032.692482-1-wojciech.dubowik@mt.com>
References: <20260728122032.692482-1-wojciech.dubowik@mt.com>
Subject: Re: (subset) [PATCH v7 0/3] drm/bridge: ti-sn65dsi83: Add reverse
 lvds lanes support
Message-Id: <178662783448.424368.5270156329576543328.b4-ty@b4>
Date: Thu, 13 Aug 2026 15:30:34 +0200
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


On Tue, 28 Jul 2026 14:20:28 +0200, Wojciech Dubowik wrote:
> From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> 
> Add support for reversed lvds output lanes. With an optional
> data-lanes property one can support default layout <1 2 3 4>
> or reversed layout <4 3 2 1>. The property is optional and when
> not set it keeps the default output layout.
> 
> [...]

Applied, thanks!

[1/3] drm/bridge: ti-sn65dsi83: Simplify error condition logic
      commit: d85a5e9dfb42449d9f37b0ddc6ec30b129f481ce

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



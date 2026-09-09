Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70197C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 874BA10F08A;
	Wed,  9 Sep 2026 10:43:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="raHc7n+I";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0837D10F0B3
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 10:43:07 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 370261A199A;
 Wed,  9 Sep 2026 10:43:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EEFA360448;
 Wed,  9 Sep 2026 10:43:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DD3DE11C7AF2B; 
 Wed,  9 Sep 2026 12:43:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788950584; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=E+Jz7PrwLSD5+BXBpsvFFAbrVGfKthjNHdSYiD9evhc=;
 b=raHc7n+IOO/jbqQk2b0K0V3tccdkK2cR2yRZnHWO9oBNd4jlqQCC8DdYSZ6iLF1rnnnJyN
 etDpVBVbtRWh6CIGbp38lnboxslsLvQn2/oY3O+juXAGEo87xzysFg1SNb5CO02ue3nd4p
 uG88++tRwQFUS36J52iAiyCPlaye+9JBmWjAVvj7v8cr937F8IzrX0+7CzJxT3N+enQsVX
 OKurR6WozLCBoK/2vFu6RkH6AA1577ISj71RGvBZi9A+MXOwK/SqSjNGzRRbv0q+aVoepr
 WISbys2fzi7Sq7scx2FN1CbRJKRH0eahsboiwmOFCkrqkuXXUWvnlqhMe7SaQA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260825143921.512966-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260825143921.512966-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] drm/bridge: lontium: Drop redundant vendor prefix from
 I2C device name
Message-Id: <178895058002.1260236.16630673371946496846.b4-ty@b4>
Date: Wed, 09 Sep 2026 12:43:00 +0200
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


On Tue, 25 Aug 2026 16:39:22 +0200, Krzysztof Kozlowski wrote:
> Device names for i2c_device_id are not OF compatibles and have a meaning
> only for in-tree users (which there are no except the driver itself),
> thus vendor prefix in this name is completely redundant.
> 
> It is actually a discouraged pattern because for OF platforms it allows
> matching driver by I2C bus, instead of OF, thus hiding incomplete
> way of obtaining driver match data (lack of i2c_get_match_data() usage).
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: lontium: Drop redundant vendor prefix from I2C device name
      commit: dfd2bd7af66564b349a84a2c6a951ea3286a53cf

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



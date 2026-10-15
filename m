Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFF8CC6B3D
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABEB510FDA1;
	Thu, 15 Oct 2026 13:54:46 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC51710EC06
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 13:54:34 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 668804E41260;
 Thu, 15 Oct 2026 13:54:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 2CA8B60360;
 Thu, 15 Oct 2026 13:54:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6094210328B3C; 
 Thu, 15 Oct 2026 15:54:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792072470; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=C6uzUWvcmfL5gq9OV74KgZectQ/GqRFjGKtoI9/JweE=;
 b=qQvEr2/tW2TzEyxG91ETD2GV+RWxEqJ6PO3jYu/cNJj8nwhFIePNuQI7T5cVR6kwSdkO8D
 K911Jx/ctKhI/qWiUr2uVd++3eXB5m9eqn1HO5phrc4kl92U22UVOleJv+sqhVU5qSdip+
 /CgQAaaU2WWLNnlhlRkLsU6e+PeIJoDiEJ/qsHrlVyeTcdEDKmRkDhETCEBTLdBQRJxmyU
 tpvfRxO1if2hUfysD4zI14fd4tBrTANJg41DFpiG87bXSfbJt70V9TaOFzcAluMmylZSEn
 lkYOGG4L2ul1yrAVAVjs1JnddG6xcQhVwB8DDOEkhVXLtGEAdVTcPtcwx1Ux2g==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RESEND v4 2/4] drm/bridge: nwl-dsi: Limit LCDIF
 specific sync override
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Fabio Estevam <festevam@gmail.com>, Robert Chiras <robert.chiras@nxp.com>, 
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261014-nwl-dsi-fixes-v4-2-b9138ea5e12c@geanix.com>
References: <20261014-nwl-dsi-fixes-v4-0-b9138ea5e12c@geanix.com>
 <20261014-nwl-dsi-fixes-v4-2-b9138ea5e12c@geanix.com>
Date: Thu, 15 Oct 2026 15:54:18 +0200
Message-Id: <179207245897.1117464.4076524155285133478.b4-review@b4>
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

On Wed, 14 Oct 2026 09:44:43 +0200, Esben Haabendal <esben@geanix.com> wrote:
> When using DCSS with NWL, overriding the mode flags to enforce active high
> sync is preventing the use of active low with downstream bridges, such as
> ti-sn65dsi83, which will not see such mode flags set by the panel.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


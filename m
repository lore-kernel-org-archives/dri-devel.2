Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3FA108B8EC
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 10:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26A7810EACF;
	Fri, 20 Mar 2026 10:18:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="NaRh0Evm";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C02010EACF
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 10:18:50 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 46D734E4272E;
 Fri, 20 Mar 2026 10:18:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 19D51600E0;
 Fri, 20 Mar 2026 10:18:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BB0A610450A84; Fri, 20 Mar 2026 11:18:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774001927; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=3ijqAhaUvFMxdsxLwzCp3tMvfza7veSqXowbCtHXGq0=;
 b=NaRh0EvmanmgAPHCKuJSQLSD++BjW/DJ51U3PqSs4q9VfekK2dhh9UtH5Z1MsFkAq5nMIv
 s/ImQIU5ec28hx3QRg2u+a83RRNmeWJxcRXev287kSz8RE5Kc3ZdMuKq9zpsbj0JuiSGIs
 ddNgywFPHKFr5tiT7mO+rojwgDRHLQRDqmOdZ/6urJyjbsE9yMlwanJliomn6K/YnsYWKf
 nJBmgT3Ii9H5Wy1er+TBbVBxL2TeWL0MUKs24tTithy5ploMfxiDsKu55v5IkbIqcxS6Do
 YFXEPFq3pKhitg7A5tLH/RXu0nbLosRR6C0hCqtTmu3vwN17j8HNQ2mfLlv/rA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260310-drm-bridge-atomic-vs-remove-clear_and_put-v2-0-51fe222f3cf0@bootlin.com>
References: <20260310-drm-bridge-atomic-vs-remove-clear_and_put-v2-0-51fe222f3cf0@bootlin.com>
Subject: Re: [PATCH v2 0/2] drm/bridge: add drm_bridge_clear_and_put()
Message-Id: <177400192059.2548636.14148318649268909187.b4-ty@bootlin.com>
Date: Fri, 20 Mar 2026 11:18:40 +0100
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


On Tue, 10 Mar 2026 13:13:22 +0100, Luca Ceresoli wrote:
> This small series introduces drm_bridge_clear_and_put(), to give a easy and
> safe way to put a bridge reference and clear the pointer without leaving a
> possible use-after-free window.
> 
> This is part of the work to support hotplug of DRM bridges. The grand plan
> was discussed in [0].
> 
> [...]

Applied, thanks!

[1/2] drm/bridge: add drm_bridge_clear_and_put()
      commit: 8f3c83720555ffa96799896f2a0bb985a03a89f4
[2/2] drm/bridge: samsung-dsim: use drm_bridge_clear_and_put() to put the next bridge
      commit: fbef867cf6614178bc6afd15ee15f85cddf19eab

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


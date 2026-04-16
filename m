Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEA1F8D753
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 14:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BE2B10E8A2;
	Thu, 16 Apr 2026 14:46:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="lIDoPXQe";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB67D10E8A2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 14:46:06 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 386784E42994;
 Thu, 16 Apr 2026 14:46:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0382B60495;
 Thu, 16 Apr 2026 14:46:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B4440104608AA; 
 Thu, 16 Apr 2026 16:45:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776350763; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=MIi0isple/re7E2ZUPULW5f3WGWYby9NBpp/u86OcO4=;
 b=lIDoPXQeYVJn5ak4NMqbpAHszS6b4EIsEERpye90vwYoKP9w0bEaDXv0kfs9ZJbxEdLfcn
 SX2pd9w2Bnp/zmXqsrbOM8xJwL9g8nwSnnjDN75Nnx+JJs8skDPozymxD2TWF/xEhMw+x9
 zI3+MfEdAaDk2goADjkKOriBs1IrG+fhQyldzBI9OaSvOOvtityuwBBfbJVWRsTMb+VaWm
 203Q79Md/mpxmEtJxHG+mhmdXMOZiy87yr/V+XQv1MWiYHk2F9dgMFlnhhdn26s3KNUT0N
 chwDyeHqw43YQf0JdvXMjlWONBnHegLHmnG0wsRdVenD0yGM5cFL5i5D01Hemw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Apr 2026 16:45:54 +0200
Message-Id: <DHUNSF4J77L3.4YXH069ZDGT0@bootlin.com>
Cc: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Jessica Zhang" <jesszhan0024@gmail.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Thierry Reding"
 <thierry.reding@gmail.com>, "Sam Ravnborg" <sam@ravnborg.org>, "Joseph Guo"
 <qijian.guo@nxp.com>, "Marek Vasut" <marek.vasut+renesas@mailbox.org>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "Robert Foss"
 <rfoss@kernel.org>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3 2/2] drm/bridge: waveshare-dsi: support DSI LCD kits
 with LVDS panels
X-Mailer: aerc 0.20.1
References: <20260412-ws-lcd-v3-0-db22c2631828@oss.qualcomm.com>
 <20260412-ws-lcd-v3-2-db22c2631828@oss.qualcomm.com>
In-Reply-To: <20260412-ws-lcd-v3-2-db22c2631828@oss.qualcomm.com>
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

On Sun Apr 12, 2026 at 7:32 PM CEST, Dmitry Baryshkov wrote:
> Several Waveshare DSI LCD kits use LVDS panels and the ICN6202 DSI2LVDS
> bridge. Support that setup by handling waveshare,dsi2lvds compatible.
> The only difference with the existing waveshare,dsi2dpi is the bridge's
> output type (LVDS vs DPI).
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD66FC56203
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 09:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 107E310E2C5;
	Thu,  6 Aug 2026 09:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="q/Hyx43t";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C21810E2C5
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 09:02:46 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 94B924E41109;
 Thu,  6 Aug 2026 09:02:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6239E602B8;
 Thu,  6 Aug 2026 09:02:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1985A11C35CFF; 
 Thu,  6 Aug 2026 11:02:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1786006963; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=uRIVf7iQ1fG4KUvl36a6Xsu/iwEpmrbMKm/ZhCDmRvE=;
 b=q/Hyx43tC7O/n23olEuApOmbILym2Q3faDBCZXk2hzcbfRLja2Ts44WypA6U96Ywgg0iG+
 fy+zb5N7rL/wjJ2JwUnlWNA4rKkK5mNQpZE+/+rgYgsc/LuceWZtRNNpvDBFmjGi0gCTYC
 uGTHfc0/fFwdvkjQ+of1zEaUmAQdDOcY74vOqwuBNTzuZcFSKqqM00JmhSEjObwneg0Sxw
 Xz/yaiXmXTh7MyinUXDZOe+Ds38NK2wfNzP1KxhuO6fGhcLAO1osERyCoksrtfOXIHMF4u
 /v6t8YLsqrfoYTR1Oum2FzXli/DbwXTq7LFr43anaXwoAxKeBMoHh2AHNCj3eQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 11:02:36 +0200
Message-Id: <DKHQML180X88.1FWP1KUMGYDUS@bootlin.com>
Subject: Re: [PATCH v3 0/3] drm/bridge: ti-sn65dsi83: Various fixes
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Esben Haabendal" <esben@geanix.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Herve Codina" <herve.codina@bootlin.com>,
 "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Linus
 Walleij" <linusw@kernel.org>, "Frieder Schrempf"
 <frieder.schrempf@kontron.de>, "Marek Vasut" <marex@denx.de>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.21.0
References: <20260803-ti-sn65dsi83-fixes-v3-0-9b403a405ccd@geanix.com>
In-Reply-To: <20260803-ti-sn65dsi83-fixes-v3-0-9b403a405ccd@geanix.com>
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

On Mon Aug 3, 2026 at 4:57 PM CEST, Esben Haabendal wrote:
> This small series adds support for using SN65DSI84 in single-link mode wi=
th
> output to LVDS channel B, and provides a fix for a PLL locking issue.
>
> Signed-off-by: Esben Haabendal <esben@geanix.com>

With the planned changes (Fixes/Cc:stable tags, patches 1-2 swapped)
applied you can send v4 with:

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

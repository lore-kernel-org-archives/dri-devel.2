Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85852FF886F
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B254610E0D6;
	Thu, 30 Apr 2026 09:06:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="gUKmBuk2";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04E6510E0D6
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:06:27 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 75475C5EF3A;
 Thu, 30 Apr 2026 09:07:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EBA9B60495;
 Thu, 30 Apr 2026 09:06:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AE48F1072B76B; 
 Thu, 30 Apr 2026 11:06:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777539984; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Ak370hgj4sdOt0ISyGWpdBSTxH3ZFKgb8FLsDorWblI=;
 b=gUKmBuk2KOjft+dUbIPP33Xe1dktfOq7mITfeyhvG3AviqZNpvxUpXYT0wD6chKEEjQKIC
 tOLPn0tg5QtNK3y7hfQdQ0U7detWMsB2BhcFbBytf+N6nKvXR5ExyB7IONWZK0sROQJ2zM
 DyyV024zON1mZyAe5kFHSZdfguYad19gJjO2wr8YbeO4FU48ZkFR7kbTjB8oWlz1NbpS8g
 uyIxKYKTfhr64jcFA0OAy14PVQK692UhzHp5r0Uvw7raG7uKdw6V6uZqHCVlVWPMgFGTpl
 NKCNE4KuAF6iNXiHhmbmfgoroRxgpJ7Nbyl5Z85ZB1nx7YfKqa4y8be8y81bPQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 11:06:20 +0200
Message-Id: <DI6DC1OD5S7N.2EXPCKI13OZNM@bootlin.com>
Cc: "Francesco Dolcini" <francesco.dolcini@toradex.com>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Adrien
 Grassein" <adrien.grassein@gmail.com>
To: "Francesco Dolcini" <francesco@dolcini.it>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] MAINTAINERS: Update maintainer for LT8912B DRM HDMI bridge
X-Mailer: aerc 0.20.1
References: <20260430085344.34271-1-francesco@dolcini.it>
In-Reply-To: <20260430085344.34271-1-francesco@dolcini.it>
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

On Thu Apr 30, 2026 at 10:53 AM CEST, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> Update the maintainer from Adrien to Francesco.  Adrien is not
> interested in maintaining this driver anymore, Francesco has access to
> various hardware devices using this component and the vendor
> documentation.
>
> Cc: Adrien Grassein <adrien.grassein@gmail.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

FWIW:
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

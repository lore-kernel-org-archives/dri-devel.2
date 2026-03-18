Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CB3FCD0D2
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB2A610E73A;
	Wed, 18 Mar 2026 08:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="YtFM2TBm";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50E9010E73A
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 08:26:02 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 07737C5506E;
 Wed, 18 Mar 2026 08:26:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 855E560050;
 Wed, 18 Mar 2026 08:26:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 69200104506B6; Wed, 18 Mar 2026 09:25:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773822354; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=jklowRBIPrCpmZeab4ftNAYk2L8Ww36BQPRSWzmduYY=;
 b=YtFM2TBm2PeYawvnlspTLypBD26nCAy/B9Aqc97kiwaiRGktFVvylPIlk7WDmy3MEa+CtI
 tFlJMVpUTK0umXdwlv5qsMeWGRwfrQYT4NSorvQbtsCsfVGZa6vRtk6PSZFlHfQlsSc3FW
 LeQVygXVPI0byOEHL91genAAQWuaQnOvN05qGompN93+XPevrIkPkVRYiCowqZya+hfArZ
 HoSQTLqqGG02Ntnp0g33Wm5OEzb8RnOL7ecum8ZFK+9SJ+AVQ0gKn0wBm/JIZ9LSCVqzTU
 IYhAux+aLh/jnx1yJmyvDzCyRpBJJXOJm9/crVFEqwEqo8BBj6VIyi7CrQ3xig==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 09:25:48 +0100
Message-Id: <DH5RJL3Z3PJM.8IS8TN7NNCVP@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v3] drm/bridge: Fix refcount shown via debugfs for
 encoder_bridges_show()
Cc: "Marco Felsch" <m.felsch@pengutronix.de>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Liu Ying" <victor.liu@nxp.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.20.1
References: <20260318-drm-misc-next-2026-03-05-fix-encoder-bridges-refcount-v3-1-147fea581279@nxp.com>
In-Reply-To: <20260318-drm-misc-next-2026-03-05-fix-encoder-bridges-refcount-v3-1-147fea581279@nxp.com>
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

On Wed Mar 18, 2026 at 6:26 AM CET, Liu Ying wrote:
> A typical bridge refcount value is 3 after a bridge chain is formed:
> - devm_drm_bridge_alloc() initializes the refcount value to be 1.
> - drm_bridge_add() gets an additional reference hence 2.
> - drm_bridge_attach() gets the third reference hence 3.
>
> This typical refcount value aligns with allbridges_show()'s behaviour.
> However, since encoder_bridges_show() uses
> drm_for_each_bridge_in_chain_scoped() to automatically get/put the
> bridge reference while iterating, a bogus reference is accidentally
> got when showing the wrong typical refcount value as 4 to users via
> debugfs.  Fix this by caching the refcount value returned from
> kref_read() while iterating and explicitly decreasing the cached
> refcount value by 1 before showing it to users.
>
> Fixes: bd57048e4576 ("drm/bridge: use drm_for_each_bridge_in_chain_scoped=
()")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Thanks!

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

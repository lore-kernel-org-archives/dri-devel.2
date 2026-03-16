Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58996F4644F
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 11:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD5D710E4A2;
	Mon, 16 Mar 2026 11:15:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="b1zdiID3";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A4B010E4A2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 11:15:35 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 305484E426CC;
 Mon, 16 Mar 2026 11:15:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 06FAA5FC4A;
 Mon, 16 Mar 2026 11:15:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 17A6F10368AC4; Mon, 16 Mar 2026 12:15:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773659733; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=5vyBWTSbSnBam1/VIflhtSS0Rw3btUmHihZbmiEsm3g=;
 b=b1zdiID3L3yc5xoTBXNj3KoCtPZ/3SVyhlB8F0dyF2WgHIkg5MK0rpFvYd2Ay8kz3Lv4uE
 8IMwWAmDXPWeAk+KwT6P4LoljILgew+wqokHrAju6LkjRFWnUDPeB5704PF6NWLVf9t7dp
 nH1znywWX6wrYTexAXhw+3/JGRr5p8NItYdxwrsdXVb/8tUGUDqFfVyIONeEBq1KU/LfT3
 xf3i1KuFqqMUvHNCm0ZeKENnHLcla+AH035i6I3b93LKUHlRc59rReI+E3DycSwiGC6WvP
 1yaKpJlw7swu8ShBz6583vEIDWGHHHQlAj4/D0i8O4b4r78JTrWu77RJEV6qZA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 12:15:29 +0100
Message-Id: <DH45WF6QQX3X.3197SDA7BFY30@bootlin.com>
Subject: Re: [PATCH] drm/bridge: Fix refcount shown via debugfs for
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
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260312-drm-misc-next-2026-03-05-fix-encoder-bridges-refcount-v1-1-b9ba3d844732@nxp.com>
In-Reply-To: <20260312-drm-misc-next-2026-03-05-fix-encoder-bridges-refcount-v1-1-b9ba3d844732@nxp.com>
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

Hello Liu,

On Thu Mar 12, 2026 at 7:05 AM CET, Liu Ying wrote:
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
> ---
>  drivers/gpu/drm/drm_bridge.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index f8b0333a0a3b..84fc3cfd17e0 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -1567,14 +1567,18 @@ void devm_drm_put_bridge(struct device *dev, stru=
ct drm_bridge *bridge)
>  }
>  EXPORT_SYMBOL(devm_drm_put_bridge);
>
> -static void drm_bridge_debugfs_show_bridge(struct drm_printer *p,
> -					   struct drm_bridge *bridge,
> -					   unsigned int idx,
> -					   bool lingering)
> +static void __drm_bridge_debugfs_show_bridge(struct drm_printer *p,
> +					     struct drm_bridge *bridge,
> +					     unsigned int idx,
> +					     bool lingering,
> +					     bool scoped)
>  {
> +	unsigned int refcount =3D kref_read(&bridge->refcount);
> +
>  	drm_printf(p, "bridge[%u]: %ps\n", idx, bridge->funcs);
>
> -	drm_printf(p, "\trefcount: %u%s\n", kref_read(&bridge->refcount),
> +	drm_printf(p, "\trefcount: %u%s\n",
> +		   scoped ? --refcount : refcount,

I'd s/--refcount/refcount - 1/ here, no point in modifying the value while
printing it.

> @@ -1599,6 +1603,22 @@ static void drm_bridge_debugfs_show_bridge(struct =
drm_printer *p,
>  	drm_puts(p, "\n");
>  }
>
> +static void drm_bridge_debugfs_show_bridge(struct drm_printer *p,
> +					   struct drm_bridge *bridge,
> +					   unsigned int idx,
> +					   bool lingering)
> +{
> +	__drm_bridge_debugfs_show_bridge(p, bridge, idx, lingering, false);
> +}
> +
> +static void drm_bridge_debugfs_show_bridge_scoped(struct drm_printer *p,
> +						  struct drm_bridge *bridge,
> +						  unsigned int idx,
> +						  bool lingering)
> +{
> +	__drm_bridge_debugfs_show_bridge(p, bridge, idx, lingering, true);
> +}

I think this should be much simpler and avoid a lot of the boilerplate
code: just add a 'bool scoped' argument to drm_bridge_debugfs_show_bridge()
and pass true/false as applicable.

Or maybe an 'int offset' with an integer to be subtracted from the refcount
for diplaying, but that's probably overkill.

Best regards,
Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

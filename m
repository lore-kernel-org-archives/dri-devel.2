Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3229B606A320
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1YVGmnIV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8122310E874;
	Fri, 30 Oct 2026 08:29:58 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F9510E874
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:29:52 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 0B95A4E4139F;
 Fri, 30 Oct 2026 08:29:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C8F2C603C2;
 Fri, 30 Oct 2026 08:29:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E481D103287DA; Fri, 30 Oct 2026 09:29:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793348988; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=vn07bY4uFq8PBN9qP0CTPo9LlrFGbj9n/s2CEOTDmkk=;
 b=1YVGmnIVJ/VGw/8am2qtF4gVWmQOXXUdPRTBtWLffB2F4tD0J/gsCNEb2wgBpm+ERAjaCK
 t7cxm0wENSDDmcaZLo7LYOaGIX7EzMua+cqumo/4wpKpuZe0eHkPcd4Y2q1Vsv1UaUUnJX
 wGX8RAla0NvRuq1i2KuP36tDaSjiXtbW9DDMQKJmBVd/lwW3YFteIkrEZm5fv7sIqaecS/
 p2fZ2e+YTh+AH+gvnY+FhqbWKlAm656hNCLl6m9VM+LQ9MiOmhJJu1iXxoIrzk0+b0GSaG
 XuRcEa5Y8w4fDVljtFV7e2v7S3D7KkHe9jmn01+VA7LQRczCbylGL7n2nr2J8A==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 2/9] drm/bridge: fsl-ldb: Get the next non-panel bridge
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Ying Liu <victor.liu@nxp.com>, Frank Li <frank.li@oss.nxp.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 linux-clk@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261006-dcif-upstreaming-v10-2-bcfb28de0aae@oss.nxp.com>
References: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
 <20261006-dcif-upstreaming-v10-2-bcfb28de0aae@oss.nxp.com>
Date: Fri, 30 Oct 2026 09:29:39 +0100
Message-Id: <179334897994.680709.5849266352850173475.b4-review@b4>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Laurentiu,

> The next bridge in bridge chain could be a panel bridge or a non-panel
> bridge.  Use devm_drm_of_get_bridge() to replace the combination
> function calls of of_drm_find_panel() and devm_drm_panel_bridge_add()
> to get either a panel bridge or a non-panel bridge, instead of getting
> a panel bridge only.

Since commit b7797081ccfe ("drm/panel: embed a drm_bridge into every
drm_panel") there is no such thing as a panel_bridge. Now every panel just
embeds a bridge, and there is no reason to use the panel_bridge API. All
bridges/encoders/whoever needing to interact with "the next component, be
it a bridge or a panel" should just use the bridge API.

The old panel_bridge APIs are deprecated [0] and by now they are just
complicated wrappers to the bridge API.

I'm addressing the conversion to bridge API and eventual removal of the
deprecated panel_bridge API as time permits (but pathces would be
welcome). This driver has already been converted by commit 802372cf316a
("drm/bridge: fsl-ldb: don't create a panel_bridge"), so this patch is
basically not changing anything: it's still getting a pointer to the next
bridge, but switches to a slightly more complicated implementation.

So I'd drop this patch.

Still it's good to get rid of the obsolete "panel" wording because now we
don't interact with a panel aymore, see below.

[0] https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-next/Documentation/gpu/todo.rst#remove-panel_bridge-api-functions

>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
>
> diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
> index 7ec84c81cd78..52ae7f5b63c7 100644
> --- a/drivers/gpu/drm/bridge/fsl-ldb.c
> +++ b/drivers/gpu/drm/bridge/fsl-ldb.c
> @@ -294,8 +294,8 @@ static const struct drm_bridge_funcs funcs = {
>  static int fsl_ldb_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *panel_node;

This could be renamed remote_bridge, or next_bridge_node, or the like.

>  	struct device_node *remote1, *remote2;
> +	struct drm_bridge *next_bridge;
>  	struct fsl_ldb *fsl_ldb;
>  	int dual_link;
>
> @@ -318,19 +318,16 @@ static int fsl_ldb_probe(struct platform_device *pdev)
>  	if (IS_ERR(fsl_ldb->regmap))
>  		return PTR_ERR(fsl_ldb->regmap);
>
> -	/* Locate the remote ports and the panel node */
> +	/* Locate the remote ports. */

This is OK.

>  	remote1 = of_graph_get_remote_node(dev->of_node, 1, 0);
>  	remote2 = of_graph_get_remote_node(dev->of_node, 2, 0);
>  	fsl_ldb->ch0_enabled = (remote1 != NULL);
>  	fsl_ldb->ch1_enabled = (remote2 != NULL);
> -	panel_node = of_node_get(remote1 ? remote1 : remote2);

I'd leave it as is, it's just less code (and more efficient FWIW)
than... see below (*)

>  	of_node_put(remote1);
>  	of_node_put(remote2);
>
> -	if (!fsl_ldb->ch0_enabled && !fsl_ldb->ch1_enabled) {
> -		of_node_put(panel_node);
> -		return dev_err_probe(dev, -ENXIO, "No panel node found");
> -	}
> +	if (!fsl_ldb->ch0_enabled && !fsl_ldb->ch1_enabled)
> +		return dev_err_probe(dev, -ENXIO, "No next bridge node found");

This can be simplified by using a clenaup action on panel_node (or whatever
the new name will be), so the of_node_put() would disappear. See for
example commit 23bc92902edd ("drm/mxsfb/lcdif: simplify ep pointer
management using __free").


> @@ -339,10 +336,14 @@ static int fsl_ldb_probe(struct platform_device *pdev)
>  	if (of_property_present(dev->of_node, "nxp,enable-termination-resistor"))
>  		fsl_ldb->use_termination_resistor = true;
>
> -	fsl_ldb->bridge.next_bridge = of_drm_find_and_get_bridge(panel_node);
> -	of_node_put(panel_node);
> -	if (!fsl_ldb->bridge.next_bridge)
> -		return -ENODEV;
> +	next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node,
> +						    fsl_ldb->ch0_enabled ? 1 : 2,
> +						    0);

(*) ...this code.

> +	if (IS_ERR(next_bridge))
> +		return dev_err_probe(dev, PTR_ERR(next_bridge),
> +				     "failed to get next bridge\n");
> +
> +	fsl_ldb->bridge.next_bridge = next_bridge;
>
>  	if (fsl_ldb_is_dual(fsl_ldb)) {
>  		struct device_node *port1, *port2;

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


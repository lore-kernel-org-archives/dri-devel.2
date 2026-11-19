Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31C1606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=oD7vVKF7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D668A10F00E;
	Thu, 19 Nov 2026 15:20:38 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4ACE10F00E
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 15:20:31 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 231324E4166D;
 Thu, 19 Nov 2026 15:20:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E9DEA60237;
 Thu, 19 Nov 2026 15:20:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5C16911BC0B70; Thu, 19 Nov 2026 16:20:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795101628; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=CtIelgNPamQxiDiybdb9Qo/Ms+w8uXXR3XHpdpS8FdM=;
 b=oD7vVKF7YpVQLURknpJtOBeJECMhgImWOmV9jgmx7ziE12fpCZ+bfRw9srz2v0OVh7VFwn
 ex3qZiov9IUkncJ9kk3zEiEi7yYLBWVySgkn41SQXshauMIEgixRHgYT9sQ6/6YzB6FiFt
 VyO2DfyimoHCqo8kKkOB5TOW+ZGb5e3mvieg06YTIspJbDPnIr+qMyAqYhhrnYJA0RhJzo
 4CcACV7Uw5RvHDLIwCTgdoJllb5CeFsxqx9IfjI/m3iSEIGw/uW/J7hBQLteoa3I786yTx
 sdX/ibeSgABwKdj7KtBtIAmG77JmrYtMsXqqucNkknHrPhU7M3zmGpA16ca4XQ==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 16:20:21 +0100
Message-Id: <DMZAF0FK9GF2.MVNE1YPB5JLM@bootlin.com>
Cc: "Devarsh Thakkar" <devarsht@ti.com>, <dri-devel@lists.freedesktop.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Maxime Ripard" <mripard@kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jyri
 Sarha" <jyri.sarha@iki.fi>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v8 07/39] drm/atomic: Add drm_private_obj name
X-Mailer: aerc 0.22.0
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-7-cbe78624e1bc@kernel.org>
In-Reply-To: <20261106-drm-state-readout-v8-7-cbe78624e1bc@kernel.org>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Maxime,

On Fri Nov 6, 2026 at 2:14 PM CET, Maxime Ripard wrote:
> drm_private_obj does not carry a human-readable name, which makes
> debug messages hard to interpret when multiple private objects are
> registered on the same device.
>
> Add a name field to drm_private_obj, passed through
> drm_atomic_private_obj_init() and freed in
> drm_atomic_private_obj_fini(). Update the existing callers to pass a
> name.
>
> Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

[...]

> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -319,4 +319,5 @@ static void __drm_bridge_free(struct kref *kref)
>  	drm_bridge_put(bridge->next_bridge);
>
> +	kfree(bridge->name);
>  	kfree(bridge->container);
>  }
> @@ -420,4 +421,11 @@ void *__devm_drm_bridge_alloc(struct device *dev, si=
ze_t size, size_t offset,
>
>  	bridge =3D container + offset;
> +
> +	bridge->name =3D kasprintf(GFP_KERNEL, "bridge-%s", dev_name(dev));

Ah, nice! I can't wait to use it in debugfs and a few other places! "%ps"
bridge->funcs is OK-ish, but not great, and also does not differentiate
multiple instances of the same driver.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

I wish I could test it but cannot apply the series even with all the
depepndecies applied. :-/

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

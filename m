Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E545606A323
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UX+RWlr+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4180B10E07B;
	Fri, 27 Nov 2026 16:27:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B781410E07B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 16:27:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5ECB243CE6;
 Fri, 27 Nov 2026 16:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47DB1F00893;
 Fri, 27 Nov 2026 16:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795796830;
 bh=+5uK595nRr/sn943YCkDPktJJ49OiwnDZhbJ7KWjkP4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UX+RWlr+9Gp4Y47L60qkZ9dFFqRWLRtaBwEeiJ174S7zRTQLMUfNBO6Z/DsUYhTzH
 cGCpYs8zXu2jVPjm58GM72hY5GhGAeeiimnbyjqEYFV1qKiSsxGot/GagEnrn31jFV
 R/7uNvVI+NcqSMDUFwcGKHaqGeqxMfiW7GmSPJSTz1txBF4yDqV2FuU40sw+Q4xk35
 vwR3sX20db0rjjAjQybRkQzdNg5hCQ2rrWYxgC3lluZoyaxcunAmE3VqoNApgxjGYl
 2Azwy4bcy6PtdIBP12/KyK0N6XiLRWAjpWXFzOuj4+74vyMRG5t2r0hH271+fAXR2b
 gk2AqNxcm3hYw==
Message-ID: <sashiko-outbox-237877@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/bridge: inno-hdmi: Report hotplug through
 drm_bridge_hpd_notify()
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127-inno-hdmi-ddc-of-node-v1-2-465622e1b7ad@samsung.com>
References: <20261127-inno-hdmi-ddc-of-node-v1-0-465622e1b7ad@samsung.com>
 <CGME20261127161907eucas1p1686924e9c6528a60f5a0f030b39c8436@eucas1p1.samsung.com>
 <20261127-inno-hdmi-ddc-of-node-v1-2-465622e1b7ad@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 16:27:10 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] drm/bridge: inno-hdmi: null pointer dereference in
  inno_hdmi_i2c_xfer() [1]
--

commit 95253be01dd44552656110fd639d49c16e43c337
Author: Michal Wilczynski <m.wilczynski@samsung.com>

drm/bridge: inno-hdmi: Report hotplug through drm_bridge_hpd_notify()

This commit changes inno_hdmi_irq() to report hotplug events through
drm_bridge_hpd_notify() and moves devm_request_threaded_irq() in
inno_hdmi_bind() after devm_drm_bridge_add().

> diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/=
inno-hdmi.c
> index 3bdcacf3cbc84..bbc90ae9eaae0 100644
> --- a/drivers/gpu/drm/bridge/inno-hdmi.c
> +++ b/drivers/gpu/drm/bridge/inno-hdmi.c

[ ... ]

> @@ -1129,6 +1124,16 @@ struct inno_hdmi *inno_hdmi_bind(struct device *de=
v,
>  	if (ret)
>  		return ERR_PTR(ret);
> =20
> +	/*
> +	 * The hotplug handler takes the bridge's HPD mutex, which
> +	 * drm_bridge_add() initialises, so request the interrupt only now.
> +	 */
> +	ret =3D devm_request_threaded_irq(dev, irq, inno_hdmi_hardirq,
> +					inno_hdmi_irq, IRQF_SHARED,
> +					dev_name(dev), hdmi);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
>  	ret =3D drm_bridge_attach(encoder, &hdmi->bridge, NULL, DRM_BRIDGE_ATTA=
CH_NO_CONNECTOR);
>  	if (ret)
>  		return ERR_PTR(ret);

[Severity: High]
This problem wasn't introduced by this patch, but can
inno_hdmi_i2c_adapter() race with a concurrent I2C transfer and cause a
NULL pointer dereference in inno_hdmi_i2c_xfer() [1]?

Just before devm_drm_bridge_add(), inno_hdmi_bind() calls
inno_hdmi_i2c_adapter(), which publishes the adapter via
devm_i2c_add_adapter() before assigning hdmi->i2c:

CPU0                              CPU1
inno_hdmi_i2c_adapter()
  i2c_set_adapdata(adap, hdmi)
  devm_i2c_add_adapter(..., adap)
                                  inno_hdmi_i2c_xfer()
                                    hdmi =3D i2c_get_adapdata(adap)
                                    i2c =3D hdmi->i2c  <-- NULL
                                    mutex_lock(&i2c->lock)
  hdmi->i2c =3D i2c

If a transfer starts right after devm_i2c_add_adapter() registers the
adapter, inno_hdmi_i2c_xfer() reads a NULL hdmi->i2c and dereferences it
in mutex_lock(&i2c->lock).

[1] https://sashiko.dev/#/bug/linux-c25575e8-f25c-439d-83ee-81502085106c

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-inno-hdmi-=
ddc-of-node-v1-0-465622e1b7ad@samsung.com?part=3D2

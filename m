Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAB8606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwYUUfWd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62DC310E185;
	Wed, 25 Nov 2026 18:07:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0F9F10E185
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:07:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ABA3F41FDE;
 Wed, 25 Nov 2026 18:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FA31F000D4;
 Wed, 25 Nov 2026 18:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795630040;
 bh=0pQHbF5+Ci3aZyc1Gn2UFrIqsyZHRfTcxPO9IkIezYI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HwYUUfWd2SI2d55amZ+9EnV/a+rYqV1PiYXxfYs4oLQaUEoVTZE+anNFavI3Yqtx/
 hdnyqvZP41gC03As6BRr+4WHEzmYVrEPs29Oy94L0bIvfKx0VSkAzHrXp/e8EVHOQY
 c1x+4BdhGGTD1gBdBK7KsljvXu8gSuG962V9DCwqmmLCvgGEg6nOGpRIzjH5x+Jomp
 da3/H9JQurK8mAfzif+BfU5iQuy3hvfFOMudN2bB5ODtWfAQR8Rr1MfZl3+it5bqx6
 GgztygDG9f6Uw58fxnVIbgvBoCuxO5cdCvhabTEWzl+pOfUDPyhrkjoPiVcXUY+ETn
 +UxjdNtxwt4ug==
Message-ID: <sashiko-outbox-233907@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/32] drm/display: hdmi-cec-notifier-helper: add
 non-drmm API variant
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261125-drm-bridge-hotplug-v4-4-822722850492@bootlin.com>
References: <20261125-drm-bridge-hotplug-v4-0-822722850492@bootlin.com>
 <20261125-drm-bridge-hotplug-v4-4-822722850492@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:07:19 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/display: missing cec.mutex in
  drm_connector_hdmi_cec_notifier_unregister()
--

commit 524d66733b09456c82258b5e235e9f87be3e61c7
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/display: hdmi-cec-notifier-helper: add non-drmm API variant

This commit adds non-drmm register and unregister helpers for the HDMI CEC
notifier so that hotpluggable HDMI bridges can dynamically register and
unregister their CEC notifiers.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_cec_notifier_helper.c b/dri=
vers/gpu/drm/display/drm_hdmi_cec_notifier_helper.c
> index 47662bdc5d08f..2f30844fcdad9 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_cec_notifier_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_cec_notifier_helper.c
[ ... ]
> @@ -58,6 +57,27 @@ int drmm_connector_hdmi_cec_notifier_register(struct d=
rm_connector *connector,
> =20
>  	mutex_unlock(&connector->cec.mutex);
> =20
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_connector_hdmi_cec_notifier_register);
> +
> +void drm_connector_hdmi_cec_notifier_unregister(struct drm_connector *co=
nnector)
> +{
> +	cec_notifier_conn_unregister(connector->cec.data);
> +	connector->cec.data =3D NULL;
> +}
> +EXPORT_SYMBOL(drm_connector_hdmi_cec_notifier_unregister);

[Severity: Medium]
Should drm_connector_hdmi_cec_notifier_unregister() take
connector->cec.mutex and also clear connector->cec.funcs?

drm_connector_hdmi_cec_notifier_register() sets connector->cec.data and
connector->cec.funcs under connector->cec.mutex, and
drm_connector_cec_phys_addr_set() and
drm_connector_cec_phys_addr_invalidate() hold the same mutex while calling
those callbacks.  When a hotpluggable bridge unregisters its notifier at
runtime while connector detection runs concurrently, the lack of locking
allows a use-after-free on struct cec_notifier:

CPU0                                    CPU1
drm_connector_hdmi_cec_notifier_unregister()
  cec_notifier_conn_unregister(connector->cec.data)
    cec_notifier_put(n)  [frees n]
                                        drm_connector_cec_phys_addr_set()
                                          mutex_lock(&connector->cec.mutex)
                                          ...->phys_addr_set()
                                            cec_notifier_set_phys_addr(
                                              connector->cec.data, ...)
                                              mutex_lock(&n->lock)
                                                <-- use-after-free
  connector->cec.data =3D NULL;

Leaving connector->cec.funcs non-NULL also allows subsequent physical
address updates on the connector to keep invoking the notifier callbacks
with a NULL connector->cec.data pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-drm-bridge=
-hotplug-v4-0-822722850492@bootlin.com?part=3D4

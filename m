Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF54606A33F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8LqMofm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5068A10FE9D;
	Wed, 25 Nov 2026 18:08:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8377810E237
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:08:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6BF9F46620;
 Wed, 25 Nov 2026 18:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEED1F0156D;
 Wed, 25 Nov 2026 18:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795630092;
 bh=s11Rv7KUePQs9knFLFl7A4wK9PqxTnOyZXfBcGNyr60=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C8LqMofmDIQl5tEIKNe8ixEHiJNmlJIeb67x0rvU1we/xNAx0NqQ2KD0OlZkjn9zh
 lo8+UZ7c9k+T/V4SX+j7Qd4rzpFzKyrwnkhjFtOeGdcgfjWTaSzD19OdR/oZDO/L8X
 fnntqkr7gGNchAA80JktCruriAhX5d4ouLQhDAbkHRcknAKNM0wenuKv8AIa6Sjtg2
 IYl0APy1kHanLxMxFcWVuAbwim029iFeY9D9pTkG/11IIU1fMuLc1iq4/ZRvkuapF7
 4b+oVJH3M2IXETj3vznPn2PdoFbREecd7K1juo9tErJ3bnBu4bJJvD6rrhne0UyzVR
 wqnFQ6UZqtQ6Q==
Message-ID: <sashiko-outbox-233910@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/32] drm/display: hdmi-cec-helper: add non-drmm API
 variant
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261125-drm-bridge-hotplug-v4-2-822722850492@bootlin.com>
References: <20261125-drm-bridge-hotplug-v4-0-822722850492@bootlin.com>
 <20261125-drm-bridge-hotplug-v4-2-822722850492@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:08:11 +0000
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
- [High] drm/display: missing lock and clear in
  drm_connector_hdmi_cec_unregister()
--

commit 6c19735a9b5d351aeeed042f0b7e6649c04d3e13
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/display: hdmi-cec-helper: add non-drmm API variant

This commit adds non-drmm drm_connector_hdmi_cec_register() and
drm_connector_hdmi_cec_unregister() helpers to support hotpluggable HDMI
bridges.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_cec_helper.c b/drivers/gpu/=
drm/display/drm_hdmi_cec_helper.c
> index b79c41703d539..81b271659ad9c 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_cec_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_cec_helper.c

[ ... ]

> @@ -160,6 +150,38 @@ int drmm_connector_hdmi_cec_register(struct drm_conn=
ector *connector,
> =20
>  	return ret;
>  }
> +EXPORT_SYMBOL(drm_connector_hdmi_cec_register);
> +
> +void drm_connector_hdmi_cec_unregister(struct drm_connector *connector)
> +{
> +	struct drm_connector_hdmi_cec_data *data =3D connector->cec.data;
> +
> +	cec_unregister_adapter(data->adapter);
> +
> +	if (data->funcs->uninit)
> +		data->funcs->uninit(connector);
> +
> +	kfree(data);
> +	connector->cec.data =3D NULL;
> +}
> +EXPORT_SYMBOL(drm_connector_hdmi_cec_unregister);

[Severity: High]
Does drm_connector_hdmi_cec_unregister() need to hold connector->cec.mutex
and clear connector->cec.funcs?

drm_connector_cec_phys_addr_invalidate() and
drm_connector_cec_phys_addr_set() serialize on connector->cec.mutex and
check only connector->cec.funcs before invoking the callback, which then
dereferences connector->cec.data->adapter.  Because
drm_connector_hdmi_cec_unregister() frees data without holding
connector->cec.mutex and leaves connector->cec.funcs populated while
connector->cec.data is NULL, a concurrent or subsequent hotplug path such
as drm_atomic_helper_connector_hdmi_hotplug() can trigger a use-after-free
or NULL pointer dereference on data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-drm-bridge=
-hotplug-v4-0-822722850492@bootlin.com?part=3D2

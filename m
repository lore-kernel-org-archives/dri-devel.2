Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9C6606A6B0
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+wfh5D7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDD2110FEF0;
	Wed, 25 Nov 2026 18:18:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 507BC10FEF0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:18:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C8356061C;
 Wed, 25 Nov 2026 18:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABD21F000C4;
 Wed, 25 Nov 2026 18:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795630713;
 bh=JNwyyTFdADOjhany7yNnMrbOAyashut3uPS6FuhGslk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m+wfh5D79lwbI7GbBHW1UYlR4K53MfdXAymlFD5C9svyShVVUUMYWzX/Pcruud2hJ
 jiX0PbB/MXG2gIedoY0S8P9ZwJQg2PxsRpVcLP7C2Iql7cBvwzAwRTU/sGs4XHZs6t
 KlUvlyy/pT/fbSwYGCbG+DH/drlnumbx2rFlqooKIm20mZmbwhAMWcDpBX3bY2i8Dk
 WmhaQbtlwqSZbNRgCiEFK7Tz6pwsiNXA9AwZf7891ylh0hwImhMjGAJYByJ/hn91R9
 Op95MO8eYYxXI0p1tJM/5j0VPz5r/6n5MdpXbe+2k7EgrcTSdsASfsYWI4wtIlWu0Y
 2oHKFV8cQZCUA==
Message-ID: <sashiko-outbox-233960@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 24/32] drm/bridge: ti-sn65dsi86: implement
 .get_next_bridge
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261125-drm-bridge-hotplug-v4-24-822722850492@bootlin.com>
References: <20261125-drm-bridge-hotplug-v4-0-822722850492@bootlin.com>
 <20261125-drm-bridge-hotplug-v4-24-822722850492@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:18:33 +0000
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
- [High] drm/bridge: ti-sn65dsi86: UAF on pdata->next_bridge in
  sn65dsi86_get_next_bridge()
--

commit 79f96bd174206efa5c1019cb2a4980bed689b63c
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/bridge: ti-sn65dsi86: implement .get_next_bridge

This commit implements the .get_next_bridge callback and sets
DRM_BRIDGE_OP_GET_NEXT_BRIDGE to expose the downstream bridge in the
ti-sn65dsi86 driver.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index 38318113a534f..6dadcd7eb8d18 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -743,6 +743,13 @@ static int ti_sn_attach_host(struct auxiliary_device=
 *adev, struct ti_sn65dsi86
>  	return devm_mipi_dsi_attach(&adev->dev, dsi);
>  }
> =20
> +static struct drm_bridge *sn65dsi86_get_next_bridge(struct drm_bridge *b=
ridge)
> +{
> +	struct ti_sn65dsi86 *pdata =3D bridge_to_ti_sn65dsi86(bridge);
> +
> +	return pdata->next_bridge ? drm_bridge_get(pdata->next_bridge) : ERR_PT=
R(-ENODEV);
> +}

[Severity: High]
Can sn65dsi86_get_next_bridge() pass a dangling or ERR_PTR pointer to
drm_bridge_get()?

ti_sn_bridge_probe() obtains pdata->next_bridge with
devm_drm_of_get_bridge(&adev->dev, np, 1, 0).  For a non-panel downstream
bridge (such as a DisplayPort connector bridge), devm_drm_of_get_bridge()
does not hold a reference to the returned bridge, so pdata->next_bridge
becomes a dangling pointer if the downstream bridge is removed and freed.

Even for a panel bridge, its devres release is bound to the child
auxiliary device (&adev->dev), whereas pdata->bridge lives on the parent
I2C device and neither ti_sn_bridge_remove() nor the probe error path
clears pdata->next_bridge.  In addition, ti_sn_bridge_probe() stores the
result of devm_drm_of_get_bridge() directly into pdata->next_bridge before
checking IS_ERR(), so a failed re-probe leaves an ERR_PTR in
pdata->next_bridge that passes the non-NULL check here and is dereferenced
by drm_bridge_get().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-drm-bridge=
-hotplug-v4-0-822722850492@bootlin.com?part=3D24

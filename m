Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A31F606A330
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3ru4BVM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB25710FEA1;
	Wed, 25 Nov 2026 18:03:49 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AC6D10FEA1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:03:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3DAE3461F3;
 Wed, 25 Nov 2026 18:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC961F000CF;
 Wed, 25 Nov 2026 18:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795629817;
 bh=Jjg2AizMoO8fgmQX9TPrWTlZoBJhv6b0qu+vOHQoQVE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K3ru4BVMi1a/1cpmTvefmjUQCfyRawe3Ce6r/Htv1He99OJnaLEGr9A10J8N3v7cN
 SwX6cn91KSzn8hUdta9hrw7PlaZOt5EsMxSXOhKyWPJjlkxSsw0fdcb0sPHBed4EjM
 D7SpB6j7IkXDBac36tR1Css38nbbPE8Xzpp+9SumJSBUAzrUK1Xgv4m1Pc5CqTdIw6
 bwU+sGcf/Jx616UBrhvJnshce9ZeRMR/uJIEvOF6Gcdqsl3d6WtGrt2rSA2+xG2qTx
 ggvzSLJf63goWxQdKmpQNg1FI17uoYvKocTOkTtbFG4CjLUXXHMyAnoi+RThhUrayT
 thmVDCj1kH/dQ==
Message-ID: <sashiko-outbox-233898@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/32] drm/display: bridge-connector: hoist error
 management to common code
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261125-drm-bridge-hotplug-v4-8-822722850492@bootlin.com>
References: <20261125-drm-bridge-hotplug-v4-0-822722850492@bootlin.com>
 <20261125-drm-bridge-hotplug-v4-8-822722850492@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:03:36 +0000
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
- [High] drm/bridge-connector: int return in
  drm_bridge_connector_initialize()
--

commit a701ba5bb1c19c7b9fcfc98010ada24b2c5ec042
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/display: bridge-connector: hoist error management to common code

This commit moves the error check for drmm_connector_hdmi_init() and
drmm_connector_init() out of the if/else branches in
drm_bridge_connector_initialize().

> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> index 19cacae617dce..f4a71801e8a3b 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -1057,15 +1057,13 @@ drm_bridge_connector_initialize(struct drm_bridge=
_connector *bridge_connector,
>  					       &drm_bridge_connector_funcs,
>  					       &bridge_connector->hdmi_funcs,
>  					       connector_type, ddc);
> -		if (ret)
> -			return ERR_PTR(ret);
>  	} else {
>  		ret =3D drmm_connector_init(drm, connector,
>  					  &drm_bridge_connector_funcs,
>  					  connector_type, ddc);
> -		if (ret)
> -			return ERR_PTR(ret);
>  	}
> +	if (ret)
> +		return ret;

[Severity: High]
Should this return ERR_PTR(ret) instead of ret?
drm_bridge_connector_initialize() returns a struct drm_connector *, so
returning an int fails to build with -Werror=3Dint-conversion (and breaks
git bisect before commit "drm/display: bridge-connector: use a dynamic
connector" restores ERR_PTR(ret) later in the series).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-drm-bridge=
-hotplug-v4-0-822722850492@bootlin.com?part=3D8

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E73A606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1Q3wCgz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5266A10E24C;
	Thu, 19 Nov 2026 17:13:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E2A112659
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:13:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7977941298;
 Thu, 19 Nov 2026 17:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339261F000C7;
 Thu, 19 Nov 2026 17:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795108395;
 bh=FUdhp8AgU65gnaXv3bgUg913sZNfPKu4P0eP/FBjC94=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k1Q3wCgz3STvg0uBubjmGEdjsDbL9DiRCB3mcgnLugbOi7/Rt/H7OHA9SWE6POLYE
 lNGgSDMzfNsdkDF2FbC8IIzP9v/+waJxwOSzgXS9MjYnw20wr0TRqkh/r7JmI0QByS
 DDCNX5BInWh9xf8BT3/hJzGbcfO0dPZ5YypVT/w+/QpoVdyl/lUFyZDkR92DFjbO2a
 anPPzx8qrIFiGbBcOYh0dNMc4wLPsPhb1G6YFo7jGUnLf0VLVexyzV0MS0mLHUMj0C
 g1ICxeXVQewufuSO2hpJMT/P+D7kMguVVG1OxKTBvpqw5YH0OxAusl11G7qcA3IKeB
 SVgBejrvvNhKg==
Message-ID: <sashiko-outbox-223654@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/nouveau: Handle NVIF_CONN_TV and fix error
 cleanup in nouveau_connector_create()
To: "Ian Rogers" <irogers@google.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <f0db7ca640d19d1021b4031b08be426532425095.1795106937.git.irogers@google.com>
References: <cover.1795106937.git.irogers@google.com>
 <f0db7ca640d19d1021b4031b08be426532425095.1795106937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 17:13:14 +0000
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
- [High] drm/nouveau: missing drm_connector_cleanup() in
  nouveau_connector_create() [1]
--

commit 35127d593c69f43f2dbfc8d677382d137440fa37
Author: Ian Rogers <irogers@google.com>

drm/nouveau: Handle NVIF_CONN_TV and fix error cleanup in nouveau_connector=
_create()

This commit maps NVIF_CONN_TV to DCB_CONNECTOR_TV_0 in
nouveau_connector_create() and cleans up nv_connector->conn and
nv_connector before returning ERR_PTR(-EINVAL) in the default switch case.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/dr=
m/nouveau/nouveau_connector.c
> index e472c23c29811..22545fd06e05b 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -1437,6 +1437,9 @@ nouveau_connector_create(struct drm_device *dev, in=
t index)
> =20
>  		switch (nv_connector->conn.info.type) {
>  		case NVIF_CONN_VGA      : type =3D DCB_CONNECTOR_VGA; break;
> +		case NVIF_CONN_TV:
> +			type =3D DCB_CONNECTOR_TV_0;
> +			break;
>  		case NVIF_CONN_DVI_I    : type =3D DCB_CONNECTOR_DVI_I; break;
>  		case NVIF_CONN_DVI_D    : type =3D DCB_CONNECTOR_DVI_D; break;
>  		case NVIF_CONN_LVDS     : type =3D DCB_CONNECTOR_LVDS; break;
> @@ -1446,7 +1449,9 @@ nouveau_connector_create(struct drm_device *dev, in=
t index)
>  		case NVIF_CONN_HDMI     : type =3D DCB_CONNECTOR_HDMI_0; break;
>  		default:
>  			WARN_ON(1);
> -			return NULL;
> +			nvif_conn_dtor(&nv_connector->conn);
> +			kfree(nv_connector);
> +			return ERR_PTR(-EINVAL);
>  		}
> =20
>  		nv_connector->type =3D type;

[Severity: High]
This problem wasn't introduced by this patch, but later in
nouveau_connector_create(), does the LVDS error path [1] free
nv_connector without calling drm_connector_cleanup()?

drivers/gpu/drm/nouveau/nouveau_connector.c:nouveau_connector_create() {
    ...
	drm_connector_init(dev, connector, funcs, type);

	switch (type) {
	case DRM_MODE_CONNECTOR_LVDS:
		ret =3D nouveau_bios_parse_lvds_table(dev, 0, &dummy, &dummy);
		if (ret) {
			NV_ERROR(drm, "Error parsing LVDS table, disabling\n");
			kfree(nv_connector);
			return ERR_PTR(ret);
		}
    ...
}

If nouveau_bios_parse_lvds_table() fails after drm_connector_init() has
registered connector with the DRM core, calling kfree(nv_connector)
directly leaks the connector IDA and leaves a dangling pointer on the DRM
connector list, causing a use-after-free when the list is later traversed
or torn down.

[1] https://sashiko.dev/#/bug/linux-5fc9af31-e33a-4535-9e9a-4dc95a2d84c3

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795106937.gi=
t.irogers@google.com?part=3D1

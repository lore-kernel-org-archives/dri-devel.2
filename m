Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3553C4451C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:05:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ED2F10EC8B;
	Wed, 22 Jul 2026 07:05:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dfHmgVd0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9FAD10EC8B
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:05:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D2F4543CDB;
 Wed, 22 Jul 2026 07:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD011F000E9;
 Wed, 22 Jul 2026 07:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784703953;
 bh=EwTQKGF+zTKegRWucm3OOhY6kLyFy1tqPHY0zJgbOu8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dfHmgVd0/JMvaoj5WcN/tZeRO3vG6TEQJSdBBAZU1UhtMQYY/2OZPR7hIGQ8JLTj5
 8wtsxGyUnVE9VD8odX0NmFgsu4xTrjtsrw7l2565IHZex1yxuYt3AFPR0wrVw+tmXL
 813ltVIqZMVjsgF2KHv9ILbHcNheHp9+wGuYL1feQtYMsAQcvRyqw46eQqkEcTEKgk
 bcRJ59mB7aZhSfO9p514k1fxGrYqfK8r8zSipIQk491uR3pBtN34/rTvvSh5uz1gZj
 tHezytCkKW+3OWAiYOM2nWdr7K0r4tpEQvppVYXbLKpmThcLWWmJOw8boyBL+bdO8T
 UcckeoZh2Qtig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 24/24] drm/bridge-connector: attach the DP subconnector
 property
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-drm-msm-display-interface-v1-24-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
 <20260722-drm-msm-display-interface-v1-24-368c10fe62fd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:05:53 +0000
Message-Id: <20260722070553.8BD011F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unchecked return value from drm_property_create_enum() causes a NU=
LL pointer dereference inside drm_object_attach_property().
--

--- Patch [24]: [PATCH 24/24] drm/bridge-connector: attach the DP subconnec=
tor property ---
commit 3033458679cc26b1f68f203c9dbef371dae0aec7
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: drm/bridge-connector: attach the DP subconnector property

This patch attaches the DP subconnector property from
drm_bridge_connector_init() for all DisplayPort connectors. It also removes
the open-coded attachment from the MSM driver to push other DP drivers towa=
rds
adding support for the property.

> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> index 8b54069fa53a4..f83d5f52ab146 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -1089,6 +1089,10 @@ struct drm_connector *drm_bridge_connector_init(st=
ruct drm_device *drm,
>  	    IS_ENABLED(CONFIG_DRM_DISPLAY_HDCP_HELPER))
>  		drm_connector_attach_content_protection_property(connector, true);
> =20
> +	/* The DP subconnector property applies to DisplayPort only. */
> +	if (connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort)
> +		drm_connector_attach_dp_subconnector_property(connector);

[Severity: High]
This is a pre-existing issue, but can this lead to a NULL pointer dereferen=
ce
if drm_property_create_enum() fails under memory pressure?

By adding this call here, the bug is now exposed to all DisplayPort bridge
connectors. In drm_connector_attach_dp_subconnector_property():

	if (!mode_config->dp_subconnector_property)
		mode_config->dp_subconnector_property =3D
			drm_property_create_enum(connector->dev, ...);

	drm_object_attach_property(&connector->base,
				   mode_config->dp_subconnector_property,
				   DRM_MODE_SUBCONNECTOR_Unknown);

If drm_property_create_enum() returns NULL, it passes NULL to
drm_object_attach_property().

Inside drm_object_attach_property(), the NULL property pointer is immediate=
ly
dereferenced:

void drm_object_attach_property(struct drm_mode_object *obj,
				struct drm_property *property,
				uint64_t init_val)
{
	int count =3D obj->properties->count;
	struct drm_device *dev =3D property->dev;

Could an error check be added to
drm_connector_attach_dp_subconnector_property() to handle the allocation
failure instead of dereferencing a NULL pointer?

> +
>  	ret =3D drm_connector_attach_encoder(connector, encoder);
>  	if (ret)
>  		return ERR_PTR(ret);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-drm-msm-di=
splay-interface-v1-0-368c10fe62fd@oss.qualcomm.com?part=3D24

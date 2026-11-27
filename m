Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA2C606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=caEZdiSH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 184A510E4C5;
	Fri, 27 Nov 2026 08:40:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBCBB10E4C5
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 08:40:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A45BD429F2;
 Fri, 27 Nov 2026 08:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F48B1F00923;
 Fri, 27 Nov 2026 08:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795768825;
 bh=LvslhYrVq8yaV+sPzoSiLAVAMgv8DnIJoGtTdeu8phk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=caEZdiSHLq2cgPiqPj0rTmYt6zMUQCWpVYc/HwGWks2tlBcpYEhMCxTwMl7f9bHxv
 I8I9Rs2poADMAZ5BuCScI2/CoC66ABS/idFKLnvjwGw82IE0RGDEGgXN1CxSkjjASI
 WLjv+Y0Y8qfgD2e0lXws4hl1tvpKK/HbUpnzdBSeeehZKjRpvOUJQl9ySuyLUTGqJa
 gMqzMzanyFOvtredEOwmVQyv0S45rb0B4ZFOWWuahXk/GFC7jzasxn/Bn1JYCQOPki
 T/2oQvmaf7y3twAqqB6+qc9M4Q17mosMOD3Mfed/adeQMVEJ9Du4tCv2IeLSJgJoo4
 O3lT7vpWgxVmg==
Message-ID: <sashiko-outbox-236891@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] drm/connector: Check DP subconnector property
 before attaching it
To: "Alex Kazinsky" <a.kazinsky@ideco.ru>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126081602.2901498-2-a.kazinsky@ideco.ru>
References: <20261126081602.2901498-1-a.kazinsky@ideco.ru>
 <20261126081602.2901498-2-a.kazinsky@ideco.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 08:40:24 +0000
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
- [Medium] drm/connector: NULL deref in
  drm_dp_set_subconnector_property() on alloc fail
--

commit 8421b6289fec4b66a03cb7c78bad44b087056f4f
Author: Alex Kazinsky <a.kazinsky@ideco.ru>

drm/connector: Check DP subconnector property before attaching it

This commit checks that mode_config->dp_subconnector_property is non-NULL
before passing it to drm_object_attach_property() in
drm_connector_attach_dp_subconnector_property().

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 893716a9e4895..41cbd76e0b1cc 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -2106,9 +2106,10 @@ void drm_connector_attach_dp_subconnector_property=
(struct drm_connector *connect
>  				drm_dp_subconnector_enum_list,
>  				ARRAY_SIZE(drm_dp_subconnector_enum_list));
> =20
> -	drm_object_attach_property(&connector->base,
> -				   mode_config->dp_subconnector_property,
> -				   DRM_MODE_SUBCONNECTOR_Unknown);
> +	if (mode_config->dp_subconnector_property)
> +		drm_object_attach_property(&connector->base,
> +					   mode_config->dp_subconnector_property,
> +					   DRM_MODE_SUBCONNECTOR_Unknown);
>  }
>  EXPORT_SYMBOL(drm_connector_attach_dp_subconnector_property);

[Severity: Medium]
If drm_property_create_enum() fails here, does skipping
drm_object_attach_property() just defer the NULL pointer dereference to
connector detection?

DP connector initialization still succeeds with
mode_config.dp_subconnector_property left as NULL.  On the next detect or
hotplug event, drm_dp_set_subconnector_property() (and amdgpu's
update_subconnector_property()) passes that NULL pointer directly to
drm_object_property_set_value(), which unconditionally dereferences
property->dev:

drivers/gpu/drm/display/drm_dp_helper.c:drm_dp_set_subconnector_property() {
	if (status =3D=3D connector_status_connected)
		subconnector =3D drm_dp_subconnector_type(dpcd, port_cap);
	drm_object_property_set_value(&connector->base,
			connector->dev->mode_config.dp_subconnector_property,
			subconnector);
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126081602.2901=
498-1-a.kazinsky@ideco.ru?part=3D1

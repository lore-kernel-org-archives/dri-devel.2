Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7662A606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IDnNonj7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8D4E10E40A;
	Fri, 27 Nov 2026 08:38:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40BDB10E460;
 Fri, 27 Nov 2026 08:38:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C091442D9F;
 Fri, 27 Nov 2026 08:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672311F00897;
 Fri, 27 Nov 2026 08:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795768700;
 bh=zjvb0IBPPBofZITtMgblShLaF1YMiLsTUwH8uKbum0U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IDnNonj7EAw+PFTGdM7nXDyKQukxnAwSrvnjwFUiM4I5x8Gbmpqdn1mC0DjXOjNCN
 rWdSyULtWCVxMk4OQnusd8AnfXy9to9ZSw0c32nuggpyuLxx9sNyi1g8NxYtpFoYp7
 mSauLnhrL8M3s5pOqwLupZG7lQmg00gvZxzvzQEXHV5Mz6BPBf7QpGoZ0VKsipzO2i
 qzDt4JJ2eCQqjHyCLTHOfhBqSZz3rrYK+x6KstWIQGKmih2BZZbLJjnl9++xrqNVaz
 doNSRW3T1s0Rr3ZDUYjgkvmfS+vkz/x9yOAJKMIRBz2ALXIlmaGg9f0FFCMIp2neEw
 GloVDhbAvtG/A==
Message-ID: <sashiko-outbox-236888@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] drm/connector: Propagate content type property
 creation errors
To: "Alex Kazinsky" <a.kazinsky@ideco.ru>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20261126081602.2901498-4-a.kazinsky@ideco.ru>
References: <20261126081602.2901498-1-a.kazinsky@ideco.ru>
 <20261126081602.2901498-4-a.kazinsky@ideco.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 08:38:20 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] drm/amd/display: active work reinit in
  amdgpu_dm_connector_init_helper() [1]
--

commit b9748e6639f50b5b110c49b43861b3ed27424ab6
Author: Alex Kazinsky <a.kazinsky@ideco.ru>

drm/connector: Propagate content type property creation errors

This commit propagates errors from drm_mode_create_content_type_property()
in drm_connector_attach_content_type_property() and logs attachment failures
in AMDGPU and i915.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 8a039ef6e4b76..3d163c2fc1066 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -3325,7 +3325,8 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_=
display_manager *dm,
> =20
>  	if (connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIA) {
>  		/* Content Type is currently only implemented for HDMI. */
> -		drm_connector_attach_content_type_property(&aconnector->base);
> +		if (drm_connector_attach_content_type_property(&aconnector->base))
> +			drm_err(adev_to_drm(adev), "Failed to attach content type property\n"=
);
>  	}
> =20
>  	if (connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIA) {

[Severity: High]
This problem wasn't introduced by this patch, but can
amdgpu_dm_connector_init_helper() reinitialize active delayed work in
dm->hdmi_frl_status_polling_work [1]?

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c:amdgpu_dm_conne=
ctor_init_helper() {
    ...
	dm->hdmi_frl_status_polling_delay_ms =3D 200;
	INIT_DELAYED_WORK(&dm->hdmi_frl_status_polling_work, hdmi_frl_status_polli=
ng_work);
    ...
}

amdgpu_dm_connector_init_helper() runs for every connector, including
DisplayPort MST connectors created at runtime by dm_dp_add_mst_connector().
While an HDMI FRL stream is active, dm->hdmi_frl_status_polling_work rearms
itself every 200ms, so hotplugging an MST connector while that work is
armed reinitializes an active timer and corrupts the timer wheel.

[1] https://sashiko.dev/#/bug/linux-bb56a34e-fe01-46fd-8aea-d7d3688e24ce

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126081602.2901=
498-1-a.kazinsky@ideco.ru?part=3D3

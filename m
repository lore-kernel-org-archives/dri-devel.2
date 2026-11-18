Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673DE60A2616
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5Oyec5t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEE4D10FD41;
	Wed, 18 Nov 2026 14:22:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B152410FD17
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:22:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7560C45C43;
 Wed, 18 Nov 2026 14:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C3E1F000C9;
 Wed, 18 Nov 2026 14:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795011772;
 bh=1zttJqdmMO+AqSyMg3xZk6m/MRVv0SLvh1fUWcUNOcQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l5Oyec5tIxnftRb/ymrXVy0FgKOfmGRODsiGkNxSGfc0CMK58DLX5QhRqSq4bcOPH
 wdtllrr82/Bxt8jpBCkRtK2VeddDbYbE+lOBD5vsXx3WKcG0AMAfBFm8eFhfBIfMa6
 LHiWNmqMA5m1nhGii/zL9EILy9NfdcFRMLs4F/jdG7tav3MC3MNxk72diHYY8Smjqp
 KgxgHYfJefLWdIu+41tFUOHMcqUVs6irTlU6SKLlad6gzbO5Cin6JoyfBwSV2OkW5+
 Jq4y12RK9pt4fZ+EiUeac1WPHeSwuIZHCEu9XJllZ9IyFHiv7uRN3PE86e2aufhNTS
 ZrgsE2THZIkzA==
Message-ID: <sashiko-outbox-221194@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/kmb: Fix potential invalid free of plane objects
To: "Guangshuo Li" <liguangshuo@mail.sdu.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261118-324f82bd41-drm-kmb-0@mail.sdu.edu.cn>
References: <20261118-324f82bd41-drm-kmb-0@mail.sdu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:22:51 +0000
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
- [High] drm/kmb: invalid CRTC and mode_config cleanup on kmb_probe()
  error path [1]
--

commit ea7f217c42f68c4024aad8e879735018a1ecdb10
Author: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>

drm/kmb: Fix potential invalid free of plane objects

This commit replaces drmm_kzalloc() and drmm_kfree() with kzalloc_obj()
and kfree() in kmb_plane_init() so plane allocations match the kfree() in
kmb_plane_destroy().

> diff --git a/drivers/gpu/drm/kmb/kmb_plane.c b/drivers/gpu/drm/kmb/kmb_pl=
ane.c
> index 1742c2c6dfd89..7c908ca23e5ba 100644
> --- a/drivers/gpu/drm/kmb/kmb_plane.c
> +++ b/drivers/gpu/drm/kmb/kmb_plane.c
> @@ -581,7 +581,7 @@ struct kmb_plane *kmb_plane_init(struct drm_device *d=
rm)
>  				  BIT(DRM_MODE_BLEND_COVERAGE);
> =20
>  	for (i =3D 0; i < KMB_MAX_PLANES; i++) {
> -		plane =3D drmm_kzalloc(drm, sizeof(*plane), GFP_KERNEL);
> +		plane =3D kzalloc_obj(*plane);
> =20
>  		if (!plane) {
>  			drm_err(drm, "Failed to allocate plane\n");
> @@ -636,6 +636,6 @@ struct kmb_plane *kmb_plane_init(struct drm_device *d=
rm)
> =20
>  	return primary;
>  cleanup:
> -	drmm_kfree(drm, plane);
> +	kfree(plane);
>  	return ERR_PTR(ret);
>  }

[Severity: High]
This problem wasn't introduced by this patch, but if kmb_plane_init() or
an earlier step in kmb_setup_mode_config() fails, doesn't the err_free
path in kmb_probe() still perform invalid CRTC and mode_config cleanup
[1]?

drivers/gpu/drm/kmb/kmb_drv.c:kmb_probe() {
    ...
	ret =3D kmb_setup_mode_config(&kmb->drm);
	if (ret)
		goto err_free;
    ...
 err_free:
	drm_crtc_cleanup(&kmb->crtc);
	drm_mode_config_cleanup(&kmb->drm);
    ...
}

When kmb_setup_mode_config() fails before drm_crtc_init_with_planes()
initializes kmb->crtc (for example when kmb_plane_init() returns an
error), drm_crtc_cleanup(&kmb->crtc) dereferences an uninitialized
crtc->head list entry, causing a NULL pointer dereference.  In addition,
because kmb_setup_mode_config() uses drmm_mode_config_init(), calling
drm_mode_config_cleanup() explicitly at err_free causes it to run a second
time when devm_drm_dev_alloc() unwinds.

[1] https://sashiko.dev/#/bug/linux-d222f5e7-17ec-4c5d-8774-adf4a0718282

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-324f82bd41=
-drm-kmb-0@mail.sdu.edu.cn?part=3D1

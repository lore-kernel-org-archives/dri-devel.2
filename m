Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E13606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJ/98F6c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F93110E1C8;
	Wed, 11 Nov 2026 03:02:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EBCE10E1C8
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 03:02:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 506CB62EC7;
 Wed, 11 Nov 2026 03:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6731F0089F;
 Wed, 11 Nov 2026 03:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794366154;
 bh=V3mLjEyDj8QG3xeNkvw/L1Lqz6DrqbFLz8yg/VEENRk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YJ/98F6crbN1lSiSzru+KqBB/7LdSfP3ZLcf/k6FE1VJDZ2ibZHHTwU/S5KBW24+I
 mRFen9BKKqlAWlyui/zBhVqQRnAnCXWZ46kE0E6p63Gus59CkXp9J7ZztOrhqZ2VH7
 B3hhOHV6amlC/L/BFTcwNUt5yv58Yud3OvUytpm2/xofEdbTOjXLB50Qya9O37hUnX
 C4AT3gLxbn6eoCBoAjSpH6Humvkbubx3JvhSk3CVojZqZ4LSMKm7Y0z4FGgW4/2QEM
 fSp4Jf0Qw+RwsZsKMcEa8LSdVqXHtGCUoJaZh4QBF/qea+ZB4khyA9zz8/y3clCyuk
 Ndh28UedjLtpQ==
Message-ID: <sashiko-outbox-208149@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amd/display: Fix dm i2c adapter lifetime on
 teardown
To: yaolu@kylinos.cn
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261111021925.63610-1-yaolu@kylinos.cn>
References: <20261110070204.307887-1-yaolu@kylinos.cn>
 <20261111021925.63610-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 03:02:33 +0000
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
- [Medium] drm/amd/display: NULL deref and bad kfree() in
  amdgpu_dm_create_i2c() tests
--

commit 34d2cc7ca5025a414952478c53098d172f5f6cc4
Author: Lu Yao <yaolu@kylinos.cn>

drm/amd/display: Fix dm i2c adapter lifetime on teardown

This commit allocates struct amdgpu_i2c_adapter with devm_kzalloc_obj()
and moves the release of dm.i2c_devres_group into amdgpu_dm_fini() before
dc_destroy().

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 8db7956c01d32..ae99058dafba4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -3437,7 +3437,7 @@ amdgpu_dm_create_i2c(struct ddc_service *ddc_servic=
e, bool oem)
>  	struct amdgpu_device *adev =3D ddc_service->ctx->driver_context;
>  	struct amdgpu_i2c_adapter *i2c;
> =20
> -	i2c =3D kzalloc_obj(struct amdgpu_i2c_adapter);
> +	i2c =3D devm_kzalloc_obj(adev->dev, struct amdgpu_i2c_adapter);

[Severity: Medium]
Does switching amdgpu_dm_create_i2c() to devm_kzalloc_obj() break the
dm_test_create_i2c_oem() and dm_test_create_i2c_hw_bus() KUnit tests in
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c?

dm_test_create_i2c_setup() leaves ctx->adev->dev as NULL, so
devm_kzalloc_obj(adev->dev, ...) triggers a NULL pointer dereference in
devres_node_add() when locking dev->devres_lock.  Both tests also call
raw kfree(i2c) on the returned pointer, which is no longer valid for a
devres-managed allocation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111021925.6361=
0-1-yaolu@kylinos.cn?part=3D1

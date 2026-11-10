Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01029606A332
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b93geQyS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4967110EE2E;
	Tue, 10 Nov 2026 07:17:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B1710E27F
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 07:17:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 399E142359;
 Tue, 10 Nov 2026 07:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3101F0089F;
 Tue, 10 Nov 2026 07:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794295041;
 bh=quRE8rKUC4TkcIfKYZkSyg2uV2jIZjdASGVacx/5idI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b93geQySuD1YejNIqEL69APii0JaaE+WYzeeyplSDlnrgaMNtJD9Yr+UbPB77ZD8F
 PmfYElAV+QXooO07xPnRMiNy1p4kX65x6Opm6KA/dxbTurhyslBOobSeTzuZ0zvP5K
 cA6E41doINmvxF9qe8KS2kPU/wR6JJaeX3+umWJ9+TB/U1v5Ie/xAirhsbUkJqoflS
 WW0fFvIfGIDQmJH9qxtSSb4HC0wb/uh5DiyQvamRsys1OwTR6qG+J/nvIxZsg3CY7t
 xZDOo79P+ayw9idtWQM8J9PGpM9YK77VQ8DGGWUjoUCWTfdt1KUsj4iD0wYHOKUhdj
 ee6EVqj9A35ow==
Message-ID: <sashiko-outbox-206472@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: Don't free devres-owned i2c adapter on
 init failure
To: yaolu@kylinos.cn
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110070204.307887-1-yaolu@kylinos.cn>
References: <20261110070204.307887-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:17:20 +0000
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
- [Medium] drm/amd/display: leak and dangling ddc_service in
  amdgpu_dm_connector_init()
--

commit cd13d71ccba1fac1ae6d56da56c40ca922c6fa4a
Author: Lu Yao <yaolu@kylinos.cn>

drm/amd/display: Don't free devres-owned i2c adapter on init failure

This commit changes amdgpu_dm_connector_init() to return directly instead of
jumping to out_free when drm_connector_init_with_ddc() fails.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index b498fc5fbb140..ccbda54c3add8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -3514,7 +3514,7 @@ int amdgpu_dm_connector_init(struct amdgpu_display_=
manager *dm,
>  	if (res) {
>  		drm_err(adev_to_drm(dm->adev), "connector_init failed\n");
>  		aconnector->connector_id =3D -1;
> -		goto out_free;
> +		return res;
>  	}

[Severity: Medium]
Does returning here leak the struct amdgpu_i2c_adapter and leave the adapter
registered with a freed i2c->ddc_service during error unwind?

amdgpu_dm_create_i2c() allocates i2c with kzalloc_obj(), while
devm_i2c_add_adapter() only schedules i2c_del_adapter(&i2c->base) via devres
and never frees the enclosing struct amdgpu_i2c_adapter.  When
amdgpu_dm_connector_init() fails, amdgpu_dm_initialize_drm_device() frees
aconnector and loses the only pointer to i2c.

In addition, amdgpu_dm_init() calls amdgpu_dm_fini() -> dc_destroy(), which
frees link->ddc (i2c->ddc_service) before dm_hw_init() reaches
devres_release_group() to unregister &i2c->base.  Unregistering the adapter
and freeing i2c (or allocating i2c with devm_kzalloc() and releasing the
devres group before dc_destroy()) would avoid both the leak and the dangling
ddc_service window.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110070204.3078=
87-1-yaolu@kylinos.cn?part=3D1

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FE6C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 00:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B70E10EB86;
	Tue, 14 Jul 2026 00:12:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hwtV/xIg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D6B610EB86
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 00:11:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DC1524175D;
 Tue, 14 Jul 2026 00:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951511F000E9;
 Tue, 14 Jul 2026 00:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783987918;
 bh=gOygTCTK0QoO9HAodMWtclr2I34D9xQofJvwM7I1Zuk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hwtV/xIgkIS7hXVuUe7QSoJfEUDA8qQG0jNeFTscfNijLs+SVeqcjGz3UGDfxiCNV
 blZt4JpQkp63BgZm/oljkrd9bBT1KtXF/c5z1X0RI7FaYVAVFlmZEGPhbqyFV4j2IW
 IgDyBfPFz04LAsPKoiEmmBXw3Di8T/nUVdzDbKb3SfmtTEnSctu87Aw0uUYSkL0nF+
 Ah/0BcDFS0e/Hsp8k5Ls0mTn1CXosJYH8n+7WddEmBalQmwprr9DhO8xfiQCj8SadF
 49sCx95CO5N8FNklRqDVc63uiQhE3BstqzCfaNepGpcFYCqCTnOpm+Tlk2pPk3r0M7
 AcoNN39DjYq4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/9] drm/amd/display: use drmm allocation for
 writeback connector
To: "John Harrison" <John.Harrison@Igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713235153.3862650-3-John.Harrison@Igalia.com>
References: <20260713235153.3862650-1-John.Harrison@Igalia.com>
 <20260713235153.3862650-3-John.Harrison@Igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 00:11:58 +0000
Message-Id: <20260714001158.951511F000E9@smtp.kernel.org>
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
- [High] Unconditional free of potentially registered DRM encoder and conne=
ctor on probe failure paths causes Use-After-Free.
--

--- Patch [2]: [PATCH v7 2/9] drm/amd/display: use drmm allocation for writ=
eback connector ---
commit 76da3d5e9ff0ab02ea5b4f6f7fccc6c370396c0b
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/amd/display: use drmm allocation for writeback connector
   =20
Currently memory used for writeback connectors isn't freed on driver
unbinding, leaking the memory. Use drm_device-memory allocation
function for the writeback connector, making sure that the memory is
freed on the driver unbinding.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 67b825cbb88fb..1fd48e28f5fef 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
[ ... ]
> @@ -2597,7 +2598,7 @@ static int amdgpu_dm_initialize_drm_device(struct a=
mdgpu_device *adev)
>  		link =3D dc_get_link_at_index(dm->dc, i);
> =20
>  		if (link->connector_signal =3D=3D SIGNAL_TYPE_VIRTUAL) {
> -			struct amdgpu_dm_wb_connector *wbcon =3D kzalloc_obj(*wbcon);
> +			struct amdgpu_dm_wb_connector *wbcon =3D drmm_kzalloc_obj(adev_to_drm=
(adev), *wbcon);
> =20
>  			if (!wbcon) {
>  				drm_err(adev_to_drm(adev), "KMS: Failed to allocate writeback connec=
tor\n");
> @@ -2606,7 +2607,7 @@ static int amdgpu_dm_initialize_drm_device(struct a=
mdgpu_device *adev)
> =20
>  			if (amdgpu_dm_wb_connector_init(dm, wbcon, i)) {
>  				drm_err(adev_to_drm(adev), "KMS: Failed to initialize writeback conn=
ector\n");
> -				kfree(wbcon);
> +				drmm_kfree(adev_to_drm(adev), wbcon);
>  				continue;
>  			}
> =20
[ ... ]
>  	return 0;
>  fail:
>  	kfree(aencoder);
>  	kfree(aconnector);

[Severity: High]
This is a pre-existing issue, but could this unconditional kfree() sequence
cause a use-after-free or list corruption during the error path?

In amdgpu_dm_initialize_drm_device(), aconnector and aencoder are declared
outside the connector iteration loop. If a memory allocation fails for
aconnector during iteration N, the code jumps to the fail label.

At this point, aencoder still retains the pointer from iteration N-1.
Since that previous encoder was successfully initialized and linked into
the DRM device's lists, freeing it directly here leaves a dangling pointer.
When drm_mode_config_cleanup() iterates over the registered DRM objects
during teardown, wouldn't it access this freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713235153.3862=
650-1-John.Harrison@Igalia.com?part=3D2

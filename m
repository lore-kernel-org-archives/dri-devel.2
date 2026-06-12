Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBBCCD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D33A10E314;
	Fri, 12 Jun 2026 18:58:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n0G+S0Vd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEF7810E314
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:58:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 30344601F3;
 Fri, 12 Jun 2026 18:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D241F00A3E;
 Fri, 12 Jun 2026 18:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781290708;
 bh=NSTAYe9MJcSwnPosJp+llQZ6BifRFh8Zk8/BM12MG5k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n0G+S0VdLl65Rk+IR+MjEkdxrriO8IXT7JaY74DHEWPMKlxZXlNXCzZoNxWFSq+ym
 myXI0WDk726GNs4EG1PyYa2k7CyNJVRGlo8RJVrYv3H0U7grplmGRpdK/E9aQVSG8f
 gEx8Bw3cj80DNm0m5nt22roiFP57l5mbysBD4lE4jd0usKJ31LV95yBG5mR+RikXzB
 8HF5n5/7M7pamKrl1PVLP6YVS31YiZ8XTC7wtpUsyYSfvLh1MfZKJPhV/l46H390dQ
 RQuBytMvLTGAmEfpVysl0IEnQwY03w2LULNhVYzHNDOkyJPmCOvftDTXdHtI+iFYQc
 Kiyla2V170V+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/9] drm/amd/display: use
 drmm_writeback_connector_init()
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260612-wb-drop-encoder-v6-3-9f3a54f81310@oss.qualcomm.com>
References: <20260612-wb-drop-encoder-v6-3-9f3a54f81310@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:58:28 +0000
Message-Id: <20260612185828.C0D241F00A3E@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Dangling drmm cleanup action on writeback connector initialization=
 error path leads to Use-After-Free, and possible build failure with drmm_k=
free.

Pre-existing issues:
- [High] Pre-existing memory leak of `wb_info` and sleeping in atomic conte=
xt in `dm_set_writeback()`.
--

commit 946e1af8401710237d25526b5d87b4357eceb542
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/amd/display: use drmm_writeback_connector_init()

The patch converts the driver to use drmm_writeback_connector_init() and
drmm_plain_encoder_alloc() to ensure proper cleanup of the writeback
connector instance and its job queue.

> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
[ ... ]
> @@ -11086,7 +11086,7 @@ static void dm_set_writeback(struct amdgpu_displa=
y_manager *dm,
>  		return;
>  	}
> =20
> -	acrtc =3D to_amdgpu_crtc(wb_conn->encoder.crtc);
> +	acrtc =3D to_amdgpu_crtc(crtc_state->base.crtc);

[Severity: High]
This is a pre-existing issue, but does dm_set_writeback() allocate memory
using GFP_KERNEL in an atomic context?

It appears that wb_info is allocated using kzalloc_obj() earlier in this
function, which implicitly uses GFP_KERNEL. However, this function is called
from amdgpu_dm_atomic_commit_tail(), which is an atomic context where sleep=
ing
functions are forbidden.

Additionally, dc_stream_add_writeback() copies the contents of wb_info by
value, but the originally allocated pointer seems to never be freed before
dm_set_writeback() returns. Does this introduce a memory leak every time a
writeback job is queued?

>  	if (!acrtc) {
>  		drm_err(adev_to_drm(adev), "no amdgpu_crtc found\n");
>  		kfree(wb_info);

[ ... ]
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
[ ... ]
> @@ -188,17 +187,26 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_displ=
ay_manager *dm,
>  	struct dc *dc =3D dm->dc;
>  	struct dc_link *link =3D dc_get_link_at_index(dc, link_index);
>  	int res =3D 0;
> +	struct drm_encoder *encoder;
> +
> +	encoder =3D drmm_plain_encoder_alloc(&dm->adev->ddev, NULL,
> +					   DRM_MODE_ENCODER_VIRTUAL, NULL);
> +	if (IS_ERR(encoder))
> +		return PTR_ERR(encoder);
> +
> +	drm_encoder_helper_add(encoder, &amdgpu_dm_wb_encoder_helper_funcs);
> +
> +	encoder->possible_crtcs =3D amdgpu_dm_get_encoder_crtc_mask(dm->adev);
> =20
>  	wbcon->link =3D link;
> =20
>  	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_f=
uncs);
> =20
> -	res =3D drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
> +	res =3D drmm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
>  					    &amdgpu_dm_wb_connector_funcs,
> -					    &amdgpu_dm_wb_encoder_helper_funcs,
> +					    encoder,
>  					    amdgpu_dm_wb_formats,
> -					    ARRAY_SIZE(amdgpu_dm_wb_formats),
> -					    amdgpu_dm_get_encoder_crtc_mask(dm->adev));
> +					    ARRAY_SIZE(amdgpu_dm_wb_formats));

[Severity: High]
If drmm_writeback_connector_init() fails internally after successfully call=
ing
drmm_connector_init(), will it leave the drmm_connector_cleanup_action
registered?

The caller, amdgpu_dm_initialize_drm_device(), appears to handle this failu=
re
by attempting to free the connector using drmm_kfree(). Since drmm_kfree()
requires a dev argument, will this missing argument result in a build failu=
re?

More importantly, since drmm_kfree() frees the memory but does not unregist=
er
actions, will the managed resource list later execute
drmm_connector_cleanup_action on the already-freed pointer, resulting in a
use-after-free when the DRM device is torn down?

> =20
>  	if (res)
>  		return res;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-wb-drop-en=
coder-v6-0-9f3a54f81310@oss.qualcomm.com?part=3D3

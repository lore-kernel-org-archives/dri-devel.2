Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260C9C44532
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 00:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5241610E4FD;
	Thu, 23 Jul 2026 00:53:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RwpEHUsu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF81A10E4FD
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 00:53:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 33803600E1;
 Thu, 23 Jul 2026 00:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8621F000E9;
 Thu, 23 Jul 2026 00:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784768000;
 bh=gYYndwFdSMvpRgKOW6sp9ud++ykfIwqJnYqjElnJwe0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RwpEHUsufiiM5Tk4dS8Yaog7BL1UU1/YSeXo71eIqeilTCmjRPjHKdE8CX1shJx0u
 wxsM+900w1rd+9YqWHrt8PHE28tY6XwQoU7lZFSd1WHI97N3iQgy8vsZ8C/LPKt34D
 jPR9woQXLTYiu92JnfkFZUX/3J2iBqQgIK9E1yz8Qvk1xxIfHLAYRaAX3wIfV6Tyh6
 usFdnfeo7PwvH8YCMIJzx3liwYURgdCaChTONDlNEABqGX7OgRts7a8Y343leiJxL2
 LmQr7iDcRKA5HDp+/H6YNnn4wpZrUdVOQfQ15UrSW38EPFrmxuMMLbv7ELCCBIB70+
 ZqEChPI2FZq0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/8] drm/amd/display: use
 drmm_writeback_connector_init()
To: "John Harrison" <John.Harrison@Igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260723003205.330362-4-John.Harrison@Igalia.com>
References: <20260723003205.330362-1-John.Harrison@Igalia.com>
 <20260723003205.330362-4-John.Harrison@Igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 00:53:20 +0000
Message-Id: <20260723005320.BE8621F000E9@smtp.kernel.org>
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
- [Medium] Mismatched object lifetimes in KUnit test causes Use-After-Free =
when DRM device is torn down.

Pre-existing issues:
- [High] The struct dc_writeback_info allocated dynamically in dm_set_write=
back() is leaked on every successful writeback job setup.
--

--- Patch [3]: [PATCH v8 3/8] drm/amd/display: use drmm_writeback_connector=
_init() ---
commit 4cc9223584993bb5748e535854c7b5fb0eba8f0d
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/amd/display: use drmm_writeback_connector_init()

The driver uses drmm_writeback_connector_init() to ensure proper job queue
cleanup. It also allocates a simple encoder using drmm_plain_encoder_alloc()
for the writeback connector.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 289da9d00b056..ff7b21830fce9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5048,7 +5048,7 @@ static void dm_set_writeback(struct amdgpu_display_=
manager *dm,
>  		return;
>  	}
> =20
> -	acrtc =3D to_amdgpu_crtc(wb_conn->encoder.crtc);
> +	acrtc =3D to_amdgpu_crtc(crtc_state->base.crtc);
>  	if (!acrtc) {
>  		drm_err(adev_to_drm(adev), "no amdgpu_crtc found\n");
>  		kfree(wb_info);

[Severity: High]
This isn't a bug introduced by this patch, but does dm_set_writeback() leak
the dynamically allocated wb_info struct on success?

When userspace configures a writeback job, wb_info is allocated dynamically
using kzalloc_obj(). It is then passed to dc_stream_add_writeback():

	dc_stream_add_writeback(dm->dc, crtc_state->stream, wb_info);

	acrtc->wb_conn =3D wb_conn;
	drm_writeback_queue_job(wb_conn, new_con_state);

However, dc_stream_add_writeback() copies the contents by value into an arr=
ay
(stream->writeback_info[...] =3D *wb_info) but does not take ownership of t=
he
pointer.

The function then returns without ever calling kfree(wb_info) on the success
path, which seems to result in a memory leak on every successful writeback
job setup.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> index 9e7bad4d6ed0c..2bb86218e80b0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c

[ ... ]

> @@ -197,17 +196,26 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_displ=
ay_manager *dm,
>  	struct dc *dc =3D dm->dc;
>  	struct dc_link *link =3D dc_get_link_at_index(dc, link_index);
>  	int res;
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

[Severity: Medium]
Can this conversion to drmm_writeback_connector_init() cause a use-after-fr=
ee
in the KUnit tests during DRM device teardown?

In the KUnit test dm_test_wb_connector_init_success(), the mock DRM device =
is
allocated via dm_kunit_alloc_adev() (which registers a KUnit cleanup action=
).
The test object wbcon is then allocated using kunit_kzalloc():

	wbcon =3D kunit_kzalloc(test, sizeof(*wbcon), GFP_KERNEL);
	KUNIT_ASSERT_NOT_NULL(test, wbcon);

	ret =3D amdgpu_dm_wb_connector_init(dm, wbcon, 0);

Because KUnit cleanup actions run in LIFO order, when the test completes, it
first frees wbcon via kfree(), and then tears down the mock DRM device.

The device teardown triggers the drmm cleanup action registered by this pat=
ch
(drm_writeback_connector_cleanup), which will dereference the already-freed
wbcon to lock job_lock and iterate job_queue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723003205.3303=
62-1-John.Harrison@Igalia.com?part=3D3

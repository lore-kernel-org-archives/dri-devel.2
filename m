Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E75BC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 00:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80F2F10EA13;
	Tue, 14 Jul 2026 00:10:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Yub3gTz2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 837F410EA13
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 00:10:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 125A8409E1;
 Tue, 14 Jul 2026 00:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B949C1F000E9;
 Tue, 14 Jul 2026 00:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783987805;
 bh=5nRcLFHH/Vp5sycdXqWAOsiTm4awMXai7JqyKaLpiUU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Yub3gTz2e3a51FD5dQx5S4SWtYxj+q1lqGfi4pgcct1RP4p1uydEUxn3uCFdROK2p
 C1Y07VkPL7dGJ67XQ1q4JDGxItApQayRx98dGBYlUhsiyBoWX/YIEaQRVfYjgB6xFI
 ZHLj8KAUcJC4co9+yK1wj9Z5GT2LSTq3JKnPRnCMbcoSlhILkZNb4LgEoeS2blIlmT
 qKxhM3Mvuf82NQbyzs6bqmS3oj18BK6J4jf+w2m+wkYQeW2jteV8sPOxT2gbM/+enV
 yv3cf+GE2rGe4V0Zsdi7N2psewO8DYEVdm5hBE8f4cKSBCp6ILh16rGPLoWtZA3vUs
 n9lKwbuBA/GkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/9] drm/amd/display: use
 drmm_writeback_connector_init()
To: "John Harrison" <John.Harrison@Igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713235153.3862650-4-John.Harrison@Igalia.com>
References: <20260713235153.3862650-1-John.Harrison@Igalia.com>
 <20260713235153.3862650-4-John.Harrison@Igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 00:10:05 +0000
Message-Id: <20260714001005.B949C1F000E9@smtp.kernel.org>
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
- [High] Calling `drmm_kfree` on `wbcon` after `drmm_writeback_connector_in=
it` fails causes a Use-After-Free during DRM device teardown.
- [Medium] The patch breaks the `amdgpu_dm_wb_test` KUnit tests by failing =
to update test assertions to match the new encoder allocation mechanism.
--

--- Patch [3]: [PATCH v7 3/9] drm/amd/display: use drmm_writeback_connector=
_init() ---
commit fecbcb335bbb22bbd24d07e0177c5af99179cac1
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

    drm/amd/display: use drmm_writeback_connector_init()

    The driver uses drm_writeback_connector_init() instead of its drmm
    counterpart, but it doesn't perform the job queue cleanup (neither
    manually nor by calling drm_writeback_connector_cleanup()). On the
    contrary, the drmm_writeback_connector_init() function ensures the
    proper cleanup of the job queue.
   =20
    Use drmm_plain_encoder_alloc() to allocate simple encoder and
    drmm_writeback_connector_init() in order to initialize writeback
    connector instance.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> index 0bf82e46f773f..3ee31634549e4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> @@ -193,17 +192,26 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_displ=
ay_manager *dm,
>  	struct dc *dc =3D dm->dc;
>  	struct dc_link *link =3D dc_get_link_at_index(dc, link_index);
>  	int res;
> +	struct drm_encoder *encoder;
> +
> +	encoder =3D drmm_plain_encoder_alloc(&dm->adev->ddev, NULL,
> +					   DRM_MODE_ENCODER_VIRTUAL, NULL);

[Severity: Medium]
Does this change break the amdgpu_dm_wb_test KUnit tests?

The test suite in drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_=
test.c
asserts on the state of the embedded encoder:

dm_test_wb_connector_init_success() {
    ...
    KUNIT_EXPECT_TRUE(test, wbcon->base.encoder.funcs !=3D NULL);
    KUNIT_EXPECT_EQ(test, wbcon->base.encoder.possible_crtcs, 0x1);
}

Since the code now dynamically allocates a separate encoder, the embedded o=
ne is
left zero-initialized, which will likely cause the assertions to fail.

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

[Severity: High]
Can this cause a use-after-free during DRM device teardown if
drmm_writeback_connector_init() fails?

If drmm_writeback_connector_init() encounters a failure (like memory
allocation failure in __drm_writeback_connector_init()), it returns an error
but leaves drm_connector_cleanup_action registered from its prior call to
drmm_connector_init():

drivers/gpu/drm/drm_writeback.c:drmm_writeback_connector_init() {
    ret =3D drmm_connector_init(dev, connector, con_funcs, ...);
    if (ret)
        return ret;

    ret =3D __drm_writeback_connector_init(dev, wb_connector, enc, ...);
    if (ret)
        return ret; // cleanup action remains registered
}

When this error propagates up, the caller amdgpu_dm_initialize_drm_device()
explicitly frees the connector:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:amdgpu_dm_initialize_drm_=
device() {
    if (amdgpu_dm_wb_connector_init(dm, wbcon, i)) {
        drm_err(adev_to_drm(adev), "amdgpu_dm_wb_connector_init failed\n");
        drmm_kfree(adev_to_drm(adev), wbcon);
        continue;
    }
}

drmm_kfree() will free the memory, but it doesn't unregister the separate
cleanup action. Later, during device teardown, drm_managed_release() will
execute the dangling action and call drm_connector_cleanup() on the already
freed wbcon pointer.

> =20
>  	if (res)
>  		return res;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713235153.3862=
650-1-John.Harrison@Igalia.com?part=3D3

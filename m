Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D7F606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cLV35aoV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C443C1125EB;
	Thu, 22 Oct 2026 12:57:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5DC410E419
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:57:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD87742E8D
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876061F000C1;
 Thu, 22 Oct 2026 12:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792673870;
 bh=T2NhdOE0vIoLfOlBGvVuTyD+hrM27KtKBDCgMMhY6aY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cLV35aoVTbkqZTbYGacN/54dB9CENx/rM3kUTB90Xnna103gI1SFo3nF9vCQGPtdj
 +0ss1xwgoXIy0DKOVegNTljgF0YmZX0h003l59mHICWOIkMee03T9xJE6d//szHwVz
 T8ZD3vy6qQT3L4C44KxkjdnzEa/hlPWHisiHZ7vWXQ6OC+VNKda9Hiytd7TSm+Hqtp
 5A7v2sFlWikZzwpnrTWrnX3U20V4gdDBxUWAMDhMSTj415VZsfDqitbc7Cr7UAHbIa
 /rJE7FIDxKrCFTyzP9Loy8vTeTXteNs+K9/9D953hke2j73eVEP9D1F+OkwRJiPiRw
 wfbCRfYtBuwTw==
Message-ID: <sashiko-outbox-181522@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 53/59] drm/amdgpu: dm: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-53-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
 <20261022-drm-no-more-connector-reset-v2-53-0b7e4e85b1e8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 12:57:50 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/amd/display: partial init and NULL deref when atomic_create_st=
ate() fails
- [Medium] drm/amd/display: ERR_PTR deref on cleanup in connector KUnit tes=
ts
--

commit a996d78c707775b6da542d46e144536aa2b44c5d
Author: Maxime Ripard <mripard@kernel.org>

drm/amdgpu: dm: Convert to atomic_create_state

This commit converts the amdgpu_dm connector state initialization from the
drm_connector_funcs.reset hook to drm_connector_funcs.atomic_create_state
across connectors, MST connectors, writeback connectors, and KUnit tests.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 3a4e98b08ac1f..e59595b5e39b2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c

[ ... ]

> @@ -3199,8 +3195,16 @@ void amdgpu_dm_connector_init_helper(struct amdgpu=
_display_manager *dm,
>  	 * Some of the properties below require access to state, like bpc.
>  	 * Allocate some default initial connector state with our reset helper.
>  	 */
> -	if (aconnector->base.funcs->reset)
> -		aconnector->base.funcs->reset(&aconnector->base);
> +	if (!aconnector->base.state &&
> +	    aconnector->base.funcs->atomic_create_state) {
> +		struct drm_connector_state *conn_state;
> +
> +		conn_state =3D aconnector->base.funcs->atomic_create_state(&aconnector=
->base);
> +		if (IS_ERR(conn_state))
> +			return;
> +
> +		aconnector->base.state =3D conn_state;
> +	}
> =20
>  	aconnector->connector_id =3D link_index;
>  	aconnector->bl_idx =3D -1;

[Severity: High]
What happens in the callers of amdgpu_dm_connector_init_helper() in
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c when
atomic_create_state() fails with ERR_PTR(-ENOMEM) and returns early?

Returning early from this void function skips initializing
aconnector->dc_link, aconnector->bl_idx =3D -1, aconnector->audio_inst =3D =
-1,
aconnector->hpd_lock, aconnector->handle_mst_msg_ready, and connector
properties, while leaving aconnector->base.state as NULL without reporting
an error to the caller.

In drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c,
amdgpu_dm_connector_init() continues execution assuming the connector was
initialized:

    amdgpu_dm_connector_init_helper(
        dm,
        aconnector,
        connector_type,
        link,
        link_index);
    ...
    if (dc_is_dp_signal(link->connector_signal))
        amdgpu_dm_initialize_dp_connector(dm, aconnector, link->link_index);

For DP or eDP connectors, amdgpu_dm_connector_init() ->
amdgpu_dm_initialize_dp_connector() in
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c immediately
dereferences aconnector->dc_link while it is still NULL:

    aconnector->dm_dp_aux.ddc_service =3D aconnector->dc_link->ddc;

For other connectors, amdgpu_dm_mode_config_init() proceeds to call
amdgpu_dm_update_connector_after_detect(), which also dereferences
aconnector->dc_link->local_sink. In addition, if
amdgpu_dm_connector_destroy() runs on this partially initialized connector,
aconnector->bl_idx is still 0 rather than -1, so it will unregister
dm->backlight_dev[0].

Similarly, in drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c,
dm_dp_add_mst_connector() calls amdgpu_dm_connector_init_helper() and then
calls drm_connector_attach_max_bpc_property(connector, 8, 16), which
dereferences connector->state while it is NULL:

    amdgpu_dm_connector_init_helper(
        &adev->dm,
        aconnector,
        DRM_MODE_CONNECTOR_DisplayPort,
        master->dc_link,
        master->connector_id);
    ...
    connector->max_bpc_property =3D master->base.max_bpc_property;
    if (connector->max_bpc_property)
        drm_connector_attach_max_bpc_property(connector, 8, 16);

Along the same lines, in
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c,
amdgpu_dm_wb_connector_init() ignores an ERR_PTR return from
amdgpu_dm_connector_atomic_create_state() and returns 0 with
connector->state left as NULL:

    conn_state =3D amdgpu_dm_connector_atomic_create_state(connector);
    if (!IS_ERR(conn_state)) {
        if (connector->state)
            connector->funcs->atomic_destroy_state(connector, connector->st=
ate);

        connector->state =3D conn_state;
    }

Should amdgpu_dm_connector_init_helper() and amdgpu_dm_wb_connector_init()
propagate the allocation error to their callers so connector initialization
can fail cleanly?

[ ... ]

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connec=
tor_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connecto=
r_test.c
> index 8117aaf41f220..ebf8155326cb1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_tes=
t.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_tes=
t.c
> @@ -1468,19 +1468,19 @@ static void dm_test_decide_crtc_timing_no_crtc_cl=
ock(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, drm_mode.crtc_hdisplay, 0);
>  }
> =20
> -/* Tests for amdgpu_dm_connector_funcs_reset() */
> +/* Tests for amdgpu_dm_connector_atomic_create_state() */
> =20
>  static const struct drm_connector_funcs dm_test_connector_funcs =3D {
> -	.reset =3D amdgpu_dm_connector_funcs_reset,
> +	.atomic_create_state =3D amdgpu_dm_connector_atomic_create_state,
>  	.atomic_duplicate_state =3D amdgpu_dm_connector_atomic_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,
>  };
> =20
>  /**
> - * dm_test_funcs_reset_sets_defaults - Test funcs_reset sets defaults
> + * dm_test_atomic_create_sets_defaults - Test funcs_reset sets defaults
>   * @test: The KUnit test context
>   */
> -static void dm_test_funcs_reset_sets_defaults(struct kunit *test)
> +static void dm_test_atomic_create_sets_defaults(struct kunit *test)
>  {
>  	struct device *dev;
>  	struct drm_device *drm;
> @@ -1501,9 +1501,9 @@ static void dm_test_funcs_reset_sets_defaults(struc=
t kunit *test)
>  	drmm_connector_init(drm, connector, &dm_test_connector_funcs,
>  			    DRM_MODE_CONNECTOR_DisplayPort, NULL);
> =20
> -	amdgpu_dm_connector_funcs_reset(connector);
> +	connector->state =3D amdgpu_dm_connector_atomic_create_state(connector);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector->state);
> =20
> -	KUNIT_ASSERT_NOT_NULL(test, connector->state);
>  	dm_state =3D to_dm_connector_state(connector->state);
>  	KUNIT_EXPECT_EQ(test, (int)dm_state->scaling, (int)RMX_OFF);
>  	KUNIT_EXPECT_FALSE(test, dm_state->underscan_enable);
> @@ -1515,10 +1515,10 @@ static void dm_test_funcs_reset_sets_defaults(str=
uct kunit *test)
>  }
> =20
>  /**
> - * dm_test_funcs_reset_edp_abm_level - Test funcs_reset eDP sets ABM
> + * dm_test_atomic_create_edp_abm_level - Test funcs_reset eDP sets ABM
>   * @test: The KUnit test context
>   */
> -static void dm_test_funcs_reset_edp_abm_level(struct kunit *test)
> +static void dm_test_atomic_create_edp_abm_level(struct kunit *test)
>  {
>  	struct device *dev;
>  	struct drm_device *drm;
> @@ -1542,9 +1542,10 @@ static void dm_test_funcs_reset_edp_abm_level(stru=
ct kunit *test)
> =20
>  	/* Test with abm_level > 0 */
>  	amdgpu_dm_set_abm_level_param(3);
> -	amdgpu_dm_connector_funcs_reset(connector);
> =20
> -	KUNIT_ASSERT_NOT_NULL(test, connector->state);
> +	connector->state =3D amdgpu_dm_connector_atomic_create_state(connector);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector->state);
> +
>  	dm_state =3D to_dm_connector_state(connector->state);
>  	KUNIT_EXPECT_EQ(test, (int)dm_state->abm_level, 3);
> =20
> @@ -1552,11 +1553,11 @@ static void dm_test_funcs_reset_edp_abm_level(str=
uct kunit *test)
>  }
> =20
>  /**
> - * dm_test_funcs_reset_edp_abm_disabled - Test funcs_reset eDP ABM
> + * dm_test_atomic_create_edp_abm_disabled - Test funcs_reset eDP ABM
>   * disabled
>   * @test: The KUnit test context
>   */
> -static void dm_test_funcs_reset_edp_abm_disabled(struct kunit *test)
> +static void dm_test_atomic_create_edp_abm_disabled(struct kunit *test)
>  {
>  	struct device *dev;
>  	struct drm_device *drm;
> @@ -1580,9 +1581,10 @@ static void dm_test_funcs_reset_edp_abm_disabled(s=
truct kunit *test)
> =20
>  	/* Test with abm_level <=3D 0 =E2=86=92 immediate disable */
>  	amdgpu_dm_set_abm_level_param(-1);
> -	amdgpu_dm_connector_funcs_reset(connector);
> =20
> -	KUNIT_ASSERT_NOT_NULL(test, connector->state);
> +	connector->state =3D amdgpu_dm_connector_atomic_create_state(connector);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector->state);
> +
>  	dm_state =3D to_dm_connector_state(connector->state);
>  	KUNIT_EXPECT_EQ(test, (int)dm_state->abm_level,
>  			(int)ABM_LEVEL_IMMEDIATE_DISABLE);
> @@ -1620,8 +1622,8 @@ static void dm_test_atomic_dup_state_copies_fields(=
struct kunit *test)
>  	drmm_connector_init(drm, connector, &dm_test_connector_funcs,
>  			    DRM_MODE_CONNECTOR_HDMIA, NULL);
> =20
> -	amdgpu_dm_connector_funcs_reset(connector);
> -	KUNIT_ASSERT_NOT_NULL(test, connector->state);
> +	connector->state =3D amdgpu_dm_connector_atomic_create_state(connector);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector->state);
> =20
>  	/* Modify original state fields */
>  	dm_state =3D to_dm_connector_state(connector->state);

[Severity: Medium]
In dm_test_atomic_create_sets_defaults(),
dm_test_atomic_create_edp_abm_level(),
dm_test_atomic_create_edp_abm_disabled(), and
dm_test_atomic_dup_state_copies_fields() in
drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c, can
assigning directly to connector->state before
KUNIT_ASSERT_NOT_ERR_OR_NULL() cause an error pointer dereference during
test teardown?

Each of these tests initializes the connector with drmm_connector_init(),
which registers drm_connector_cleanup() as a managed cleanup action. If
amdgpu_dm_connector_atomic_create_state() returns ERR_PTR(-ENOMEM),
connector->state holds that non-NULL error pointer when
KUNIT_ASSERT_NOT_ERR_OR_NULL() aborts the test, and drm_connector_cleanup()
in drivers/gpu/drm/drm_connector.c will then pass it to
atomic_destroy_state():

    if (connector->state && connector->funcs->atomic_destroy_state)
        connector->funcs->atomic_destroy_state(connector,
                               connector->state);

Would it be safer to store the return value in a local conn_state variable
and assert KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state) before assigning
connector->state, as done in the other tests in this file?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-drm-no-mor=
e-connector-reset-v2-0-0b7e4e85b1e8@kernel.org?part=3D53

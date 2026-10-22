Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC1E606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2OfVCdI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12F2110E3FF;
	Thu, 22 Oct 2026 12:50:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96E9F10E3FF
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:50:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5353141780
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D2A1F000C1;
 Thu, 22 Oct 2026 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792673427;
 bh=VRWjI9i6S0AnPnu72EG+tFs1mFw24i6oCOIeuqf3yqM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=a2OfVCdI2KMMtdcQxQjUGHnB9gtkKCVmjAkI+p8sogn0YvmKB2byMaJfLwjeqRHEZ
 LTdj0OIxLmcB0YTOv+t5DMvz6g9brQn5VXWevxBsbIjyHXgK117dsYVZWTtF229aVl
 x6tKNfWNhU7ZWIHHNHCi6wOQcO44vc682dU8G/ApFGWLjaryirSnCBGJkOfejKhC/k
 /3KC+gvb4fQsNCKPgJCr5Xr4HM02pz8f7WD87Ya2lB6vHfBGwQbMmgmHMjKVMdgUbM
 qSZPfqJAjK0qceJnlcYhX5PaK8OrzLQFxbMDCl37nrSq3ezFvu170VTpaVTDCGjxp4
 FBBKHAmrS20VQ==
Message-ID: <sashiko-outbox-181507@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 52/59] drm/connector: Remove
 drm_atomic_helper_connector_reset()
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-52-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
 <20261022-drm-no-more-connector-reset-v2-52-0b7e4e85b1e8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 12:50:26 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/connector: removing drm_atomic_helper_connector_reset() brea=
ks 21 files
--

commit 948666959edea381d867894c27d616519ac047c5
Author: Maxime Ripard <mripard@kernel.org>

drm/connector: Remove drm_atomic_helper_connector_reset()

This commit removes the drm_atomic_helper_connector_reset() helper and its
declaration from the DRM atomic state helper headers and implementation.

> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/=
drm_atomic_state_helper.c
> index 3534925636d54..5efda28bb2b07 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -435,26 +435,6 @@ __drm_atomic_helper_connector_reset(struct drm_conne=
ctor *connector,
>  }
>  EXPORT_SYMBOL(__drm_atomic_helper_connector_reset);
> =20
> -/**
> - * drm_atomic_helper_connector_reset - default &drm_connector_funcs.rese=
t hook for connectors
> - * @connector: drm connector
> - *
> - * Resets the atomic state for @connector by freeing the state pointer (=
which
> - * might be NULL, e.g. at driver load time) and allocating a new empty s=
tate
> - * object.
> - */
> -void drm_atomic_helper_connector_reset(struct drm_connector *connector)
> -{
> -	struct drm_connector_state *conn_state =3D kzalloc_obj(*conn_state);
> -
> -	if (connector->state)
> -		__drm_atomic_helper_connector_destroy_state(connector->state);
> -
> -	kfree(connector->state);
> -	__drm_atomic_helper_connector_reset(connector, conn_state);
> -}
> -EXPORT_SYMBOL(drm_atomic_helper_connector_reset);
> -

[Severity: Medium]
Does removing drm_atomic_helper_connector_reset() here and in
include/drm/drm_atomic_state_helper.h cause build regressions when compiling
drivers and KUnit tests that still reference this symbol?

In drivers/gpu/drm/sysfb/drm_sysfb_helper.h, DRM_SYSFB_CONNECTOR_FUNCS still
uses drm_atomic_helper_connector_reset (affecting corebootdrm.c, efidrm.c,
ofdrm.c, simpledrm.c, and vesadrm.c):

    #define DRM_SYSFB_CONNECTOR_FUNCS \
            .reset =3D drm_atomic_helper_connector_reset, \

In addition, several other drivers and KUnit test suites still assign
.reset =3D drm_atomic_helper_connector_reset (or call it directly):

- drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c (komeda_wb_conne=
ctor_funcs)
- drivers/gpu/drm/bridge/lontium-lt8912b.c (lt8912_connector_funcs)
- drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c (ge_b850v3_lvds_=
connector_funcs)
- drivers/gpu/drm/bridge/sii902x.c (sii902x_connector_funcs)
- drivers/gpu/drm/bridge/simple-bridge.c (simple_bridge_con_funcs)
- drivers/gpu/drm/hyperv/hyperv_drm_modeset.c (hv_drm_connector_funcs)
- drivers/gpu/drm/imx/ipuv3/imx-tve.c (imx_tve_connector_funcs)
- drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c (dpu_wb_conn_funcs)
- drivers/gpu/drm/solomon/ssd130x.c (ssd130x_connector_funcs)
- drivers/gpu/drm/stm/lvds.c (lvds_conn_funcs)
- drivers/gpu/drm/tiny/appletbdrm.c (appletbdrm_connector_funcs)
- drivers/gpu/drm/vc4/vc4_txp.c (vc4_txp_connector_funcs)
- drivers/gpu/drm/vc4/tests/vc4_mock_output.c (vc4_dummy_connector_funcs)
- drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c (dm_te=
st_audio_connector_funcs)
- drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c (d=
m_backlight_test_connector_funcs)
- drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c (dm_test=
_crc_connector_funcs and a direct call to drm_atomic_helper_connector_reset=
(wb_conn))
- drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c (dm_=
test_connector_funcs)
- drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c (dm_test=
_connector_funcs)
- drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c (d=
m_mst_test_connector_funcs and dm_mst_test_dsc_link_conn_funcs)
- drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c (dm_wb_te=
st_connector_funcs)

Should those remaining users be converted to atomic_create_state before
drm_atomic_helper_connector_reset() is removed?

>  /**
>   * drm_atomic_helper_connector_create_state - default &drm_connector_fun=
cs.atomic_create_state hook for connectors
>   * @connector: connector object

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-drm-no-mor=
e-connector-reset-v2-0-0b7e4e85b1e8@kernel.org?part=3D52

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F105F606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GTRh6QTH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C17810E188;
	Sat, 14 Nov 2026 18:14:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52A6E10E267
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:14:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA403608FA;
 Sat, 14 Nov 2026 18:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AA61F000C4;
 Sat, 14 Nov 2026 18:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794680073;
 bh=Q/SP1Nudm6vRLU2OZJjgN6v3qFBuwTdTsDXWkWT+2Y8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GTRh6QTHTGihGZ7Vxcm0yFC/K0pnufH2humktjTILh/aYXoETvOVecqQuxhnzjei7
 g9sQInmag9OXoy8HGWpqJ01yJdQ7z5Me75PHO1lXW7mjFit9PHz1KdBBoHiXbJXB8i
 p9r/awRDYQY1VJbnTaSzhoa/RKh8psbJ+klv8BoBjjWCvTQ0Fx5ze7pYExD+KvjTAd
 4UnC18vhjxwYlgzWk/IgdFWQk7WzOpibeqv+sAGh1nl2snzEXXDNjIa/lnlkpCiBMc
 cdred5RTfwDFVjc2DNWVTpMuDLVm29HBDDEAywupoz4F2psREER2iFPoiS4InmyHci
 o58ygpyO8dtFg==
Message-ID: <sashiko-outbox-214894@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/25] drm/tests: hdmi: Convert to
 drmm_connector_hdmi_init()
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-6-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
 <20261114-drm-conn-hdmi-cleanup-v1-6-20e8a33a2286@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 18:14:32 +0000
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
- [Medium] drm/tests: ww_mutex leak in
  drm_test_check_reject_audio_infoframe() [1]
--

commit d078fa85b984429f42b17f7efe1e93d8055ccfb2
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/tests: hdmi: Convert to drmm_connector_hdmi_init()

This commit converts the HDMI state helper KUnit tests to the new
drmm_connector_hdmi_init() signature and stores each connector's
drm_connector_hdmi_funcs copy in drm_atomic_helper_connector_hdmi_priv so
it outlives the connector.

> diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers=
/gpu/drm/tests/drm_hdmi_state_helper_test.c
> index 336bb644cb7c9..f1bdd197429c6 100644
> --- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
> +++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c

[ ... ]

> @@ -3314,8 +3310,6 @@ static void drm_test_check_reject_audio_infoframe(s=
truct kunit *test)
>  	int ret;
> =20
>  	priv =3D drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test,
> -				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
> -				8,
>  				&reject_audio_infoframe_hdmi_funcs,
>  				test_edid_hdmi_1080p_rgb_max_200mhz);
>  	KUNIT_ASSERT_NOT_NULL(test, priv);

[Severity: Medium]
This problem wasn't introduced by this patch, but can a failed assertion in
drm_test_check_reject_audio_infoframe() leak the modeset ww_mutex locks in
ctx [1]?

drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c:drm_test_check_reject_au=
dio_infoframe() {
    ...
	drm_modeset_acquire_init(&ctx, 0);

retry_conn_enable:
	ret =3D drm_kunit_helper_enable_crtc_connector(test, drm,
						     crtc, conn,
						     preferred,
						     &ctx);
    ...
	KUNIT_ASSERT_EQ(test, ret, 0);
    ...
	drm_modeset_drop_locks(&ctx);
	drm_modeset_acquire_fini(&ctx);
}

KUNIT_ASSERT_* returns immediately on failure, bypassing
drm_modeset_drop_locks() and drm_modeset_acquire_fini() at the end of the
function.  Because ctx lives on the stack, returning with locks held leaves
dangling lock list nodes pointing to out-of-scope stack memory, triggering
lockdep warnings and potential crashes during subsequent tests or DRM
device cleanup.

[1] https://sashiko.dev/#/bug/linux-1258d4b2-95ea-43e2-a892-e2011a232ee8

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-drm-conn-h=
dmi-cleanup-v1-0-20e8a33a2286@collabora.com?part=3D6

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FE1CCA462
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 650AF10E9DF;
	Thu, 15 Oct 2026 21:34:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1CC310E9DF
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 21:34:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B33560A57;
 Thu, 15 Oct 2026 21:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCB71F000C5;
 Thu, 15 Oct 2026 21:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792100084;
 bh=1N7Q+MS717Y5ZELpLnbTADM+aewJBTA4kYL9wLAAglg=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=hb+sNVMoq/woyk3V7rO3MVd4NeMSxfs8inTzpJ+AOm8U6UpxjRHz+2PIIzo/y6X53
 z2hPB+ho4WWVvAfzXAGe3y0bGsm1t60y4JCILer2VNtOgJ33zQWoPlNVVrykJ09wc2
 OWUd9PP/3K4fbvRSIAVwPEpc2QzNtEpGgWd4Ru2HHVcNVvl9gMvcDjeoy5o9A2QYqf
 mPhCux1KfX0HloUKDx2hfDtPjhHHFdTM3fzLrwbO2NG+Yx4vYK3crNjhrIVx+1DHpH
 atQ7WpM0mhe1LNmFCEPL88gS2R2k1bcBeQ3CQ6KxD2q1QB4E6peEFbUyianZSxynzK
 6kqh7+28SqK9Q==
Message-ID: <sashiko-outbox-173427@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/tests: Add KUnit tests for the client mode size
 limits
To: "Hugo Sales" <hugo@hsal.es>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261015212545.1989962-3-hugo@hsal.es>
References: <20261015212545.1989962-1-hugo@hsal.es>
 <20261015212545.1989962-3-hugo@hsal.es>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 21:34:44 +0000
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
- [Low] drm/tests: lockless access to connector->modes violates locking rul=
es
- [Low] drm/tests: memory leak of cloned modes on KUnit assertion failure
--

commit 806dc20896099436a3d060ce16a4a8cb84cf8467
Author: Hugo Sales <hugo@hsal.es>
Subject: drm/tests: Add KUnit tests for the client mode size limits

This commit adds KUnit tests for various client mode pickers to ensure they
skip modes larger than the client's size. It also tests that the modeset
probe properly retains the preferred mode.

> diff --git a/drivers/gpu/drm/tests/drm_client_modeset_test.c b/drivers/gp=
u/drm/tests/drm_client_modeset_test.c
> index 00f43fca97954..93aa919d4f317 100644
> --- a/drivers/gpu/drm/tests/drm_client_modeset_test.c
> +++ b/drivers/gpu/drm/tests/drm_client_modeset_test.c

[ ... ]

> @@ -197,6 +213,206 @@ static struct kunit_suite drm_test_pick_cmdline_tes=
t_suite =3D {
> =20
>  kunit_test_suite(drm_test_pick_cmdline_test_suite);
> =20
> +static void drm_test_pick_first_mode_within_limits(struct kunit *test)
> +{

[ ... ]

> +	mutex_lock(&drm->mode_config.mutex);
> +	ret =3D drm_helper_probe_single_connector_modes(connector, 1920, 1080);
> +	mutex_unlock(&drm->mode_config.mutex);
> +	KUNIT_ASSERT_GT(test, ret, 0);
> +
> +	mode =3D drm_connector_first_mode(connector, 1920, 1080);

[Severity: Low]
The connector->modes list is explicitly documented as being protected by
dev->mode_config.mutex. Here, the mutex is unlocked just before calling
drm_connector_first_mode(), which iterates over connector->modes.

While this is isolated test code and no concurrent modification occurs,
could this lockless iteration trigger static analysis tools or lockdep
warnings?

> +	KUNIT_ASSERT_NOT_NULL(test, mode);
> +	KUNIT_EXPECT_EQ(test, mode->hdisplay, 1920);
> +	KUNIT_EXPECT_EQ(test, mode->vdisplay, 1080);

[ ... ]

> +static void drm_test_pick_cmdline_mode_within_limits(struct kunit *test)
> +{

[ ... ]

> +	mutex_lock(&drm->mode_config.mutex);
> +	ret =3D drm_helper_probe_single_connector_modes(connector, 1920, 1080);
> +	mutex_unlock(&drm->mode_config.mutex);
> +	KUNIT_ASSERT_GT(test, ret, 0);
> +
> +	mode =3D drm_connector_pick_cmdline_mode(connector, 1920, 1080);

[Severity: Low]
Similarly here, drm_connector_pick_cmdline_mode() iterates over
connector->modes outside of drm->mode_config.mutex. Does this violate
the locking rules for the connector modes list?

> +	KUNIT_ASSERT_NOT_NULL(test, mode);

[ ... ]

> +static void drm_test_pick_tiled_mode_within_limits(struct kunit *test)
> +{

[ ... ]

> +	mutex_lock(&drm->mode_config.mutex);
> +	ret =3D drm_helper_probe_single_connector_modes(connector, 1920, 1080);
> +	mutex_unlock(&drm->mode_config.mutex);
> +	KUNIT_ASSERT_GT(test, ret, 0);
> +
> +	mode =3D drm_connector_get_tiled_mode(connector, 1920, 1080);

[Severity: Low]
As with the previous pickers, drm_connector_get_tiled_mode() accesses
connector->modes without the required drm->mode_config.mutex held.

> +	KUNIT_ASSERT_NOT_NULL(test, mode);

[ ... ]

> +static void drm_test_pick_clone_mode_within_limits(struct kunit *test)
> +{

[ ... ]

> +	mutex_lock(&drm->mode_config.mutex);
> +	for (i =3D 0; i < ARRAY_SIZE(connectors); i++) {
> +		ret =3D drm_helper_probe_single_connector_modes(connectors[i], 1920, 1=
080);
> +		KUNIT_EXPECT_GT(test, ret, 0);
> +	}
> +	mutex_unlock(&drm->mode_config.mutex);
> +
> +	KUNIT_EXPECT_TRUE(test, drm_client_target_cloned(drm, connectors, ARRAY=
_SIZE(connectors),
> +							 modes, offsets, enabled, 1024, 768));

[Severity: Low]
This call to drm_client_target_cloned() also iterates over
connector->modes after the config mutex has been released.

> +	for (i =3D 0; i < ARRAY_SIZE(connectors); i++) {
> +		KUNIT_ASSERT_NOT_NULL(test, modes[i]);

[Severity: Low]
If this KUNIT_ASSERT_NOT_NULL() assertion fails, it immediately forces an
early return from the test.

Because drm_client_target_cloned() allocates new modes via mode_replace(),
would an early return here bypass the mandatory modes_destroy() cleanup
below and leak the dynamically allocated mode objects?

Could KUnit's managed allocations (like kunit_add_action) be used to ensure
modes_destroy() always runs on cleanup?

> +		KUNIT_EXPECT_EQ(test, modes[i]->hdisplay, 1024);
> +		KUNIT_EXPECT_EQ(test, modes[i]->vdisplay, 768);
> +	}
> +	modes_destroy(drm, modes, ARRAY_SIZE(connectors));

[ ... ]

> +static void drm_test_probe_keeps_modes_above_limits(struct kunit *test)
> +{

[ ... ]

> +	ret =3D drm_client_modeset_probe(client, 1024, 768);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	mode =3D client->modesets[0].mode;
> +	KUNIT_ASSERT_NOT_NULL(test, mode);
> +	KUNIT_EXPECT_EQ(test, mode->hdisplay, 1024);
> +	KUNIT_EXPECT_EQ(test, mode->vdisplay, 768);
> +
> +	mode =3D drm_connector_preferred_mode(connector, 1920, 1080);

[Severity: Low]
Once again, drm_connector_preferred_mode() is called to iterate the
connector->modes list without the config mutex held.

> +	KUNIT_ASSERT_NOT_NULL(test, mode);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015212545.1989=
962-1-hugo@hsal.es?part=3D2

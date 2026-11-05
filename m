Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC5606A32E
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iixeevkl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB1CB10E31A;
	Thu,  5 Nov 2026 20:46:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1558510E002
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:46:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E716041A5F
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D0E1F0089F;
 Thu,  5 Nov 2026 20:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793911608;
 bh=2IgGBOTZJDvN1Z5cIFYDn9jL/ak9TqN7kxe7SoR1ZOM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Iixeevkl3cVTw+t46OPNQ+n7NDvkMqKfGxC/7i53NGy2TRGYOC3GxO91QCy9k80X7
 /5h2sYmURQhbSwTkZCw0dMq03jJP6DtAZDR2Dpbv+v69uNlfLoA1vwVxw0GEorifUS
 iT9b42kEr57LsRQORKbrs7sln+Gao/18esDuAP1sO1pqTcYkQSeGchdsmKlGr6qN1g
 wvfNeewm8rJwqy1gVLdDwcsO2RRy0MHVFZnh3/qsxmfCTnnDd5wMaMFnb65+/NhTuU
 LjIkPjxnhQiBndwMfZU6Wub6QS/ZOhlKzZDNOTPxYze0ucEdYMOcsQhkTvvs38EjuH
 Eog/Wsmgj4Usg==
Message-ID: <sashiko-outbox-200132@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 54/83] drm/tests: drm_atomic_state_test: Switch
 to drm_mode_config_create_initial_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-drm-no-more-config-reset-v1-54-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-54-1f58d1e33380@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 20:46:48 +0000
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
- [Medium] drm/tests: error pointer dereference in drm_atomic_commit_test c=
allers
--

commit bf780a2e8e49270edd5c0a0b1f92ae2a80dbb4a2
Author: Maxime Ripard <mripard@kernel.org>

drm/tests: drm_atomic_state_test: Switch to drm_mode_config_create_initial_=
state

This commit replaces the call to drm_mode_config_reset() in
drm_atomic_test_init_drm_components() with
drm_mode_config_create_initial_state() to initialize KMS state for the atom=
ic
commit KUnit tests.

> diff --git a/drivers/gpu/drm/tests/drm_atomic_commit_test.c b/drivers/gpu=
/drm/tests/drm_atomic_commit_test.c
> index 6ccb001f6264b..97f60ce68b3e4 100644
> --- a/drivers/gpu/drm/tests/drm_atomic_commit_test.c
> +++ b/drivers/gpu/drm/tests/drm_atomic_commit_test.c
> @@ -134,7 +134,9 @@ drm_atomic_test_init_drm_components(struct kunit *tes=
t, bool has_connectors)
>  	}
> =20
>  done:
> -	drm_mode_config_reset(drm);
> +	ret =3D drm_mode_config_create_initial_state(drm);
> +	if (ret)
> +		return ERR_PTR(ret);
> =20
>  	return priv;
>  }

[Severity: Medium]
Can returning ERR_PTR(ret) here lead to an error pointer dereference in the
callers of drm_atomic_test_init_drm_components()?

Both drm_test_check_connector_changed_modeset() and
drm_test_check_valid_clones() only check the returned pointer with
KUNIT_ASSERT_NOT_NULL():

	priv =3D drm_atomic_test_init_drm_components(test, true);
	KUNIT_ASSERT_NOT_NULL(test, priv);

If drm_mode_config_create_initial_state() returns a negative error code,
ERR_PTR(ret) will pass the KUNIT_ASSERT_NOT_NULL() check and be dereferenced
in set_up_atomic_state().

Every other failure check in drm_atomic_test_init_drm_components() uses
KUNIT_ASSERT_NOT_ERR_OR_NULL() or KUNIT_ASSERT_EQ(test, ret, 0) to abort the
test immediately. Should this check use KUNIT_ASSERT_EQ(test, ret, 0) as we=
ll,
or should the callers be updated to use KUNIT_ASSERT_NOT_ERR_OR_NULL()?

Also, this isn't a bug, but the commit subject prefix says
drm_atomic_state_test while the modified file is drm_atomic_commit_test.c.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-drm-no-mor=
e-config-reset-v1-0-1f58d1e33380@kernel.org?part=3D54

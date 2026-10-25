Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8773C606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 04:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AE4TFXUg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A33E910E683;
	Sun, 25 Oct 2026 04:30:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B044110E683
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 04:30:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 026CF600D4;
 Sun, 25 Oct 2026 04:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639C71F01825;
 Sun, 25 Oct 2026 04:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792902622;
 bh=2QQcs87YaWMya2pBYkAwd1G49GEHG9Z7e4/sZPzlK3Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AE4TFXUgoNIOoke4H01g1kZXmFqrq/oyP1WkMpGo2aI7pn6KbHoJbXY9px9V3Djgj
 8e1U712SjOz4ADDr1KSUzrjFlDUi+uQA3yYwpT6yxpgSpcXsyW+UVDPkV4D3rLByox
 Ovf65odSW1TPdmCzdLo0VjokB/yNFupuJ58gOIcnrRZPaOEq/QYyYILYnIO+aMXdci
 45tcT6oOcXVB8sgHh1UB/EokPTUPu1iEnFdDaMIDo5n5QpxDQ3DHUfX0O3MEhW4G1G
 xMixa9raIgYCAyUAwL3KPBE+YbJimSl9V9FP/7dGLMfCTUpq3k1+/ceKxmFW5ng12Y
 1ldaIQxDf3+Hw==
Message-ID: <sashiko-outbox-184066@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/13] drm/amd/display: Skip panel power savings on eDP
 links without a panel
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>, 
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261025040046.1602-14-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
 <20261025040046.1602-14-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 04:30:21 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/amd/display: KUnit test failures in amdgpu_dm_should_create_=
sysfs()
--

commit 7217c1895d0e9a0b0a4343bbfd37bba3770b7920
Author: Andre Eikmeyer <dev@deq.rocks>

drm/amd/display: Skip panel power savings on eDP links without a panel

This commit updates amdgpu_dm_should_create_sysfs() to return false when
dc_link->edp_sink_present is false, preventing creation of the
panel_power_savings sysfs attribute on eDP links without an attached panel.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index 703d0617df6d4..c8fbd2167b6b2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> @@ -761,6 +761,9 @@ amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connec=
tor *amdgpu_dm_connector)
>  	if (amdgpu_dm_connector->base.connector_type !=3D DRM_MODE_CONNECTOR_eD=
P)
>  		return false;
> =20
> +	if (!amdgpu_dm_connector->dc_link->edp_sink_present)
> +		return false;

[Severity: Medium]
Does this break the existing KUnit tests for amdgpu_dm_should_create_sysfs()
in drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c?

In setup_test_connector(), fixture->link is zero-allocated with
kunit_kzalloc(), leaving edp_sink_present set to false:

	fixture->link =3D kunit_kzalloc(test, sizeof(*fixture->link), GFP_KERNEL);
	...
	fixture->aconnector->bl_idx =3D bl_idx;
	fixture->aconnector->dc_link =3D fixture->link;
	fixture->aconnector->base.dev =3D &fixture->adev->ddev;
	fixture->link->connector_signal =3D signal;

Because edp_sink_present is never initialized to true in
setup_test_connector() or in the test cases, amdgpu_dm_should_create_sysfs()
now returns false unconditionally in:

- dm_test_should_create_sysfs_no_backlight_index()
- dm_test_should_create_sysfs_oled_cacp()
- dm_test_should_create_sysfs_lcd_panel()

causing their KUNIT_EXPECT_TRUE() assertions to fail, while
dm_test_should_create_sysfs_oled_no_cacp() returns early at the
edp_sink_present check before testing the panel_type and cacp_supported
condition.

Should setup_test_connector() or those KUnit tests be updated to set
edp_sink_present =3D true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025040046.1602=
-1-atharvatiwarilinuxdev@gmail.com?part=3D13

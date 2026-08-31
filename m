Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1921BC61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 22:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2387610E34C;
	Mon, 31 Aug 2026 22:49:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nPcV39Wd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A9BE10E332;
 Mon, 31 Aug 2026 22:49:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F281F602D3;
 Mon, 31 Aug 2026 22:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E7A1F000E9;
 Mon, 31 Aug 2026 22:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788216573;
 bh=VWZNea7qcUcIQpyjNbtHBngrLsSTJsiaD5bV+VNRqM4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nPcV39WdkFXBTmqMkCkGnhAZZyJiWY6hKxTf1OLTZ0bPNBsXs+VfShSInXofN7983
 2DiRPwWgmKsMVh82mnWgV44uFAb3gYysO4bBcpN3umIBNVQ5PAl9RbTJ35sJFz3WOx
 jEZey/wsdOI6h1lwLMnZ1qX/1iXLPVj7kDsc/NDcMAnX/GeXfeXCE7OHrJSkhSm1ct
 nAaX44Ziqvxriy7/F/408XE+Jn2Ncy+nBsKz7nPDLd2Xb13Bu6+Dqpe7G6IssoLQCW
 ucb6AGPOr+EP/8VUrr8WuBd8Aps3pAlPNpYz6kaSJe+R2AJ4rSi+bmiXYINT8oRc+l
 0ITdPZguQQ98w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/12] drm/amd/display: Pass up errors reading actual
 brightness
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20260831210531.2334221-7-mario.limonciello@amd.com>
References: <20260831210531.2334221-1-mario.limonciello@amd.com>
 <20260831210531.2334221-7-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:49:32 +0000
Message-Id: <20260831224933.65E7A1F000E9@smtp.kernel.org>
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
- [Medium] Incomplete refactoring of PWM error path causes KUnit test failu=
re.
--

commit 51bad29849babac3047c98c959ac850e269def79
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/amd/display: Pass up errors reading actual brightness

This patch changes the return type of amdgpu_dm_backlight_get_level() from
an unsigned integer to a signed integer. It also updates the caller and KUn=
it
tests to handle negative error codes like -EINVAL on backlight read failure.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index b66ca60e697dc..ed1f85650e280 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
[ ... ]
> @@ -376,7 +376,7 @@ u32 amdgpu_dm_backlight_get_level(struct amdgpu_displ=
ay_manager *dm, int bl_idx)
>  		u32 avg, peak;
> =20
>  		if (!dc_link_get_backlight_level_nits(link, &avg, &peak))
> -			return dm->brightness[bl_idx];
> +			return -EINVAL;
>  		return convert_brightness_to_user(&caps, avg);
>  	}
> =20

[Severity: Medium]
Was the legacy PWM error path missed during this refactoring?

A few lines down in amdgpu_dm_backlight_get_level(), there is another error
path:

	ret =3D dc_link_get_backlight_level(link);
	if (ret =3D=3D DC_ERROR_UNEXPECTED)
		return dm->brightness[bl_idx];

Since this still returns the cached fallback brightness instead of -EINVAL,
could this cause unexpected behavior for the updated KUnit test?

[ ... ]
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backli=
ght_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backligh=
t_test.c
> index 7ca17f803f9d7..e03173d4e5bd8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_tes=
t.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_tes=
t.c
> @@ -382,7 +382,7 @@ static void dm_test_backlight_get_level_pwm_error(str=
uct kunit *test)
>  	dm->brightness[0] =3D 4321;
>  	dm->backlight_link[0] =3D link;
> =20
> -	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_level(dm, 0), 4321U);
> +	KUNIT_EXPECT_EQ(test, amdgpu_dm_backlight_get_level(dm, 0), -EINVAL);

[Severity: Medium]
Will this test unconditionally fail?

Because the legacy error path in amdgpu_dm_backlight_get_level() wasn't
updated to return -EINVAL, it seems the function will still return the cach=
ed
fallback value (4321) when the mock function returns DC_ERROR_UNEXPECTED.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831210531.2334=
221-1-mario.limonciello@amd.com?part=3D6

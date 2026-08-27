Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C418CC61DBD
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 02:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CE2110E421;
	Thu, 27 Aug 2026 02:33:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q/Z6WMgq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BF8F10E384;
 Thu, 27 Aug 2026 02:33:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7DF9660A5C;
 Thu, 27 Aug 2026 02:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F7D1F000E9;
 Thu, 27 Aug 2026 02:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787797985;
 bh=+jnQfXenNGO8y5soQnQLKjt1mcHf9KLvSk8AgLA7EjE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q/Z6WMgqCPaO1ABs+sp9TiBdkUYdKYLu6ISGGFlczRG4CbHqJq8GxzFR8VC6ta6tW
 cGzeQWnIv7mZDZrS9cLG0h9JxJpEthtNVKJKrNmR9XfB/3VXE9kqiqYxiJfUkQVLTT
 vm31A0piNeFH+hJsJmERy12E5RorTlK1ML2q4tDq0UjNxU+rWPIc6kQu8XCWrRXmqh
 v21X0AbSZ4OGX0oipogLN/xNXVvDB/UEG5bB4g6c1oaoGC6zG+mw1LdYLhPmQSuu7m
 bma/OskvwBWhmYLqn9XI0bhwk/zBT/WlPfMNr/HWaHPvjNHfVdteRrZKeoiJ78rxK5
 hQbFfmG2LiszA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/dp_link_caps: Validate max link rate
To: tarund18303@gmail.com
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20260827022035.3442-1-tarund18303@gmail.com>
References: <20260827022035.3442-1-tarund18303@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 02:33:04 +0000
Message-Id: <20260827023304.D8F7D1F000E9@smtp.kernel.org>
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
- [Medium] The newly added validation check in `max_link_limits_valid()` br=
eaks existing KUnit tests in `intel_dp_link_test.c` because the mock `intel=
_dp` environment does not initialize `source_rates`.
--

commit 449b7e18bca4c6d9716f634b5437a3f267bbd539
Author: tarun-tarun143 <tarund18303@gmail.com>

drm/i915/dp_link_caps: Validate max link rate

This commit validates the maximum link rate against the source-supported ra=
tes
before using the limits to calculate allowed configurations. This prevents
unsupported link rates from being accepted as a maximum link limit.

> diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_caps.c b/drivers/=
gpu/drm/i915/display/intel_dp_link_caps.c
> index 7b6cc6055da82..0934488153bbc 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_link_caps.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_link_caps.c
> @@ -710,7 +710,10 @@ static bool max_link_limits_valid(struct intel_dp_li=
nk_caps *link_caps,
>  	    !is_power_of_2(max_link_limits->lane_count))
>  		return false;
> =20
> -	/* TODO: Validate max_link_limits->rate against the source supported ra=
tes. */
> +	if (intel_dp_rate_index(link_caps->dp->source_rates,
> +				link_caps->dp->num_source_rates,
> +				max_link_limits->rate) < 0)
> +		return false;

[Severity: Medium]
Does this change cause the KUnit tests in intel_dp_link_test.c to fail?

Looking at the mock environment initialization in intel_dp_link_test_init():

drivers/gpu/drm/i915/display/tests/intel_dp_link_test.c:intel_dp_link_test_=
init() {
	/* Reset the dev state for each test. */
	memset(&test_ctx.dev, 0, sizeof(test_ctx.dev));
	...
	intel_dp->link.caps =3D test_ctx.link_caps_ops->init(intel_dp);
}

The mock initialization zeroes the memory but does not populate source_rate=
s=20
or num_source_rates, leaving them at 0 or NULL. As a result,=20
intel_dp_rate_index() will evaluate to -1 during the tests.

This causes unconditional test failures when setting max limits, for example
in verify_link_caps_for_order():

drivers/gpu/drm/i915/display/tests/intel_dp_link_test.c:verify_link_caps_fo=
r_order() {
	...
	KUNIT_ASSERT_TRUE(test, ops->set_max_limits(link_caps, &old_max_limits));
}

Could the mock environment be updated to provide valid source_rates so the
tests can successfully pass this new validation check?

> =20
>  	intel_dp_link_caps_get_forced_params(link_caps, &forced_params);
>  	allowed_configs =3D calc_allowed_config_filter(link_caps, link_caps->en=
abled_configs,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827022035.3442=
-1-tarund18303@gmail.com?part=3D1

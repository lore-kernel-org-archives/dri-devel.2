Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C19C44532
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D0E810EF69;
	Thu, 23 Jul 2026 02:00:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n/oxGUVi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09C1E10EF69
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 02:00:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5EF6E600AB;
 Thu, 23 Jul 2026 02:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65081F000E9;
 Thu, 23 Jul 2026 02:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784772057;
 bh=jozKjk2J6NEYx/vndCj6GKzJOJ+ayBkah+8JkSadd9w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n/oxGUViAFrCsmsNWcSsi1hQ2wHYKkpApG77a6loDfDTT54xp8r4FZFzclFbAOl87
 u+kd3hmy1OeD7BpUfIIHus7+lxlSVZ026B/3n1Gc7Sp3Q07X6TtLsm9XhOTX6klalr
 Ec+d8+5kVFn3zNXEHdrY7/OhY1qjmWWfpMrq8TPe7B1Hfk/GxjMKuds4Qd0g7Sx34h
 G7oKGbseXiSFgGBRLyULLQACsCkhy9FspORjMY0N2ytGwMVYOsw2JCL2U2JgSkdmK5
 RxWFu5kgNE6ukzwm3Mxi43V3SsuwssebcTSHuoXKrk5UVXr5pQ1JAf93JjHNeRbNRD
 2LDuKkP2TVmog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 54/61] drm/tests: connector: Add HDMI source-side
 scrambler coverage
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-54-4fb12ea22ac9@collabora.com>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-54-4fb12ea22ac9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 02:00:56 +0000
Message-Id: <20260723020056.D65081F000E9@smtp.kernel.org>
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
- [Medium] Masked test failures in TMDS character rate validation tests.
--

--- Patch [54]: [PATCH v9 54/61] drm/tests: connector: Add HDMI source-side=
 scrambler coverage ---
commit 51e9e33a81edd8b52502410a5e171c4a8d0bf3c5
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/tests: connector: Add HDMI source-side scrambler coverage

This commit adds KUnit tests to validate the HDMI source-side scrambler che=
cking
in drmm_connector_hdmi_init(). It verifies that scrambler callbacks are
correctly required for HDMI 2.0 and later, and rejected if provided for ear=
lier
HDMI versions.

> diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm=
/tests/drm_connector_test.c
> index f14cd741b05e4..3d050ac5e5f6d 100644
> --- a/drivers/gpu/drm/tests/drm_connector_test.c
> +++ b/drivers/gpu/drm/tests/drm_connector_test.c
> @@ -1412,6 +1412,89 @@ static void drm_test_connector_hdmi_init_max_tmds_=
rate_no_version(struct kunit *
>  	KUNIT_EXPECT_LT(test, ret, 0);
>  }
> =20

[Severity: Medium]
Will the scrambler validation tested by this patch mask the TMDS rate limit
tests located just above this hunk?

In drm_test_connector_hdmi_init_max_tmds_rate_exceeds() and
drm_test_connector_hdmi_init_max_tmds_rate_no_version(), the tests use
dummy_hdmi_funcs_scrambler but set supported_hdmi_ver to HDMI_VERSION_1_4 or
HDMI_VERSION_UNKNOWN:

	struct drm_connector_hdmi_funcs hdmi_funcs =3D dummy_hdmi_funcs_scrambler;
	...
	hdmi_funcs.supported_hdmi_ver =3D HDMI_VERSION_1_4;

Since drmm_connector_hdmi_init() rejects scrambler callbacks for HDMI
versions < 2.0 by returning -EINVAL early, will these TMDS rate tests now f=
ail
during the scrambler check rather than actually validating the TMDS charact=
er
rate logic?

Should they be updated to use a dummy struct without scrambler callbacks to
ensure the max_tmds_char_rate limit is what actually causes the test to pas=
s?

> +/*
> + * Test that the registration of an HDMI connector advertising source-si=
de
> + * scrambling support succeeds when the .scrambler_{enable,disable} call=
backs
> + * are provided.
> + */

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-dw-hdmi-qp=
-scramb-v9-0-4fb12ea22ac9@collabora.com?part=3D54

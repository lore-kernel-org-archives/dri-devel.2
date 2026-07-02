Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842A7C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C180010F453;
	Thu,  2 Jul 2026 15:10:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DXWTP0yZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 158C810F451
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:10:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DAFAD404D6;
 Thu,  2 Jul 2026 15:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5861F000E9;
 Thu,  2 Jul 2026 15:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783005029;
 bh=d5tpnp8ek19Bd8+rIQX2N58f2v0ft56nMLCl9+bsTXw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DXWTP0yZ1KBhnyttg5EZwGslVQUO5zvVdV/DavSESgRut8xEqeGe7wcadVAPezxTQ
 4KxpdeaETKjgDuzPJLp+9YsVAjh8s47gBgMZzFg6BXLjvrM4FCiQMnV0xxMrOWj0x7
 8DSe1vjMpQ1Xk38Y02nc7SAkYpH6wlDQ+1zGZN1yeuzlS60Vjudc/bZsykTwTK9Ydj
 eDQpOvLWb+a3tMMylug5HhIwrirZNRV18BCRkpCFG9o3JRfjRlMUDDdeMMqFzqO0qC
 RH35AEKYEvB4PH+woGjbOWscCCWynrpPlkmgUsnNaYKpyTyH6RMOvs9T2rHXw0V7tr
 tVHIh+7S0LGjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 32/39] drm/tests: connector: Add HDMI caps-based init
 coverage
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-32-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-32-d79890d00b6a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:10:28 +0000
Message-Id: <20260702151029.9A5861F000E9@smtp.kernel.org>
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
- [Low] The test cases introduced in this patch reference `dummy_hdmi_funcs=
_scrambler`, which is undeclared in this commit, causing a compilation erro=
r. Each patch in a series must compile independently to preserve git bisect=
ability.
--

commit 00f793137805b36c4e39a000783f65bb290b345b
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/tests: connector: Add HDMI caps-based init coverage

Add KUnit tests for drmm_connector_hdmi_init_with_caps() covering NULL
caps rejection, max_tmds_char_rate inference, and limits validation.

> diff --git a/drivers/gpu/drm/tests/drm_connector_test.c b/drivers/gpu/drm=
/tests/drm_connector_test.c
> index beb1d50a66464..1fb1d83aec1af 100644
> --- a/drivers/gpu/drm/tests/drm_connector_test.c
> +++ b/drivers/gpu/drm/tests/drm_connector_test.c
[ ... ]
> +static void drm_test_connector_hdmi_init_max_tmds_rate_inferred(struct k=
unit *test)
> +{
[ ... ]
> +	ret =3D drmm_connector_hdmi_init_with_caps(&priv->drm, &priv->connector,
> +						 "Vendor", "Product",
> +						 &dummy_funcs,
> +						 &dummy_hdmi_funcs_scrambler,

[Severity: Low]
Does this cause a compilation error? It appears dummy_hdmi_funcs_scrambler =
is
undeclared in this commit.

While this gets fixed later in the series in commit c237a4e2c8cf9600c005
(drm/tests: connector: Add HDMI source-side scrambler coverage), referencing
it early breaks git bisectability as this patch will fail to compile on its
own.

This same undeclared variable is also referenced in
drm_test_connector_hdmi_init_max_tmds_rate_override() and
drm_test_connector_hdmi_init_max_tmds_rate_at_limit() later in this patch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-dw-hdmi-qp=
-scramb-v8-0-d79890d00b6a@collabora.com?part=3D32

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345CFC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:09:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71AE110EE55;
	Tue,  7 Jul 2026 16:09:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ci8lSmhZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52EEC10EE4E
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:09:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 02335417A5
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 16:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2151F00A3A;
 Tue,  7 Jul 2026 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783440557;
 bh=JjKrvNoDF8zLsKbVGp1+ISWOfMQUy4nnPWQ9Eku8X4I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ci8lSmhZLAtpuuAXpSsK04dKieQiXRK1Z7IYyCSib2VyE5hdTF+DnOdT7ezN5UbIP
 PeGj7hN05gQzYGyQVKTH3ToS9JknL0RgPvAviZznfBLO+UTXNet+Sjv5A5SijDyhKx
 /1meYC2fUZGpB0V7rncrkWviN5Ft/8Abzl1msTMtc/ip6B2UMuKiZ7ZgpYIuHfbyBR
 6dRI07J77aHW++FRc5YjmufDNL57mV5XGA5OdEDMYT0vElU2R9EztM6Ij7RU6cHFb9
 /c91XfcM5naEa+FcqjBp6dGFwnCjKvnssT7AMJfKXD3cRZWHR51qYNsrwLd3wluJCX
 nrv7tooJiG+WQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 34/37] drm/sti: dvo: Switch to atomic bridge callbacks
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-34-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-34-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 16:09:17 +0000
Message-Id: <20260707160917.BC2151F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] NULL pointer dereference when `clk_set_rate()` fails in `sti_dvo_s=
et_mode()`.
--

--- Patch [34]: [PATCH v2 34/37] drm/sti: dvo: Switch to atomic bridge call=
backs ---
commit 377cffc6cdd80910f39bda909df8ad2af0ea4cf2
Author: Maxime Ripard <mripard@kernel.org>

drm/sti: dvo: Switch to atomic bridge callbacks

This commit switches the sti dvo bridge from using legacy non-atomic bridge
callbacks to their atomic counterparts. It also adds atomic state handlers
as part of the effort to remove legacy support from the DRM bridge core.

> diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
> index 7484d3c3f4ed5..b48099468eb97 100644
> --- a/drivers/gpu/drm/sti/sti_dvo.c
> +++ b/drivers/gpu/drm/sti/sti_dvo.c

[ ... ]

> @@ -232,7 +233,8 @@ static void sti_dvo_disable(struct drm_bridge *bridge)
>  	dvo->enabled =3D false;
>  }
> =20
> -static void sti_dvo_pre_enable(struct drm_bridge *bridge)
> +static void sti_dvo_pre_enable(struct drm_bridge *bridge,
> +			       struct drm_atomic_commit *commit)
>  {
>  	struct sti_dvo *dvo =3D bridge->driver_private;
>  	struct dvo_config *config =3D dvo->config;

[Severity: High]
This isn't a bug introduced by this patch, but can this lead to a NULL
pointer dereference?

If clk_set_rate() fails during the modeset in sti_dvo_set_mode(), it returns
early and skips setting dvo->config:

drivers/gpu/drm/sti/sti_dvo.c:sti_dvo_set_mode() {
    ...
	ret =3D clk_set_rate(dvo->clk_pix, rate);
	if (ret < 0) {
		DRM_ERROR("Cannot set rate (%dHz) for dvo_pix clk\n", rate);
		return;
	}
    ...
	dvo->config =3D &rgb_24bit_de_cfg;
}

When sti_dvo_pre_enable() is called later on the atomic commit path, config
is assigned dvo->config (which would be NULL if it was the first modeset),
and then it gets dereferenced unconditionally shortly after:

drivers/gpu/drm/sti/sti_dvo.c:sti_dvo_pre_enable() {
    ...
	if (config->awg_fwgen_fct) {
    ...
}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D34

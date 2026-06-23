Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57390CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA10010E9F6;
	Tue, 23 Jun 2026 08:15:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="APgOfXQx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB50610E9F6
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 08:15:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 17F226001D;
 Tue, 23 Jun 2026 08:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB731F00A3A;
 Tue, 23 Jun 2026 08:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782202528;
 bh=HuvEmyvTGZWtbyAP8u2MKjEOMqC9/h5PEG8vhKt5Bhg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=APgOfXQxtVBtS5J2kc7F+OD0wjfpiUuPI8t5Uv2e7hNhDx0SwdOGUJqVtcVsdFOEX
 swzsrDdKTtuDBLoxcXhmEjwtTZUB9sFl7bd1aD480yjPmZQ84maeFWU4w+4Phd0Ih3
 HSsmf8SCECP4Xa+HrFfwMIBgR3ZifIcWnVS9hn1cHHe2E3qJAH4VQVQ11bS1UAeJ/a
 Lm6oluprdIpSG2RErIucZuWOH1wy9QRmX5fKZtV9k3UmPnzUQJH5uLzjqCcAS9UXQa
 vPZ+0z8h3wjFaqv6UJHJQE4iGaVit2BVnxO22RJNklkz9pculM/DNObXDTLNiIptVD
 DqME3zMcdiKug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915: Calculate CDCLK on modeset after sanitizing
 pre-os programming
To: =?utf-8?b?R2FicsOtZWwgQXJ0aMO6ciBQw6l0dXJzc29u?=
 <gabriel.petursson@jbtmarel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <AM9PR06MB78601E2636164181A4689CC281EF2@AM9PR06MB7860.eurprd06.prod.outlook.com>
References: <AM9PR06MB78601E2636164181A4689CC281EF2@AM9PR06MB7860.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 08:15:27 +0000
Message-Id: <20260623081528.0DB731F00A3A@smtp.kernel.org>
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
- [High] Modifying global hardware state (`display->cdclk.hw.sanitized`) wi=
thin the stateless atomic check phase violates DRM atomic semantics and bre=
aks `TEST_ONLY` commits.
--

commit 8f701efc4d5758e65427e1e613e7e204861dc6ef
Author: Gabr=C3=ADel Arth=C3=BAr P=C3=A9tursson <gabriel.petursson@jbtmarel=
.com>

drm/i915: Calculate CDCLK on modeset after sanitizing pre-os programming

This commit explicitly triggers CDCLK recalculation after sanitization duri=
ng
modesetting. It addresses an issue where monitors display a blank screen at
boot accompanied by CPU pipe A FIFO underrun errors.

> diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm=
/i915/display/intel_cdclk.c
> index 189ae2d3cfc9e..38b384d825d10 100644
> --- a/drivers/gpu/drm/i915/display/intel_cdclk.c
> +++ b/drivers/gpu/drm/i915/display/intel_cdclk.c

[ ... ]

> @@ -3596,9 +3599,10 @@ static int intel_modeset_calc_cdclk(struct intel_a=
tomic_state *state)
> =20
>  int intel_cdclk_atomic_check(struct intel_atomic_state *state)
>  {
> +	struct intel_display *display =3D to_intel_display(state);
>  	const struct intel_cdclk_state *old_cdclk_state;
>  	struct intel_cdclk_state *new_cdclk_state;
> -	bool need_cdclk_calc =3D false;
> +	bool need_cdclk_calc =3D display->cdclk.hw.sanitized;

[Severity: High]
Does reading this global hardware state here lack protection against concur=
rent
atomic checks?

>  	int ret;
> =20
>  	ret =3D intel_cdclk_modeset_checks(state, &need_cdclk_calc);
> @@ -3629,6 +3633,8 @@ int intel_cdclk_atomic_check(struct intel_atomic_st=
ate *state)
>  		ret =3D intel_modeset_calc_cdclk(state);
>  		if (ret)
>  			return ret;
> +
> +		display->cdclk.hw.sanitized =3D false;

[Severity: High]
Does modifying global hardware state within the stateless atomic check phase
violate DRM atomic semantics and break TEST_ONLY commits?

If a userspace Wayland compositor performs a TEST_ONLY atomic commit before=
 a
real commit, it will trigger intel_cdclk_atomic_check() and clear this
sanitized flag. The subsequent real commit will then see sanitized =3D=3D f=
alse
and fail to recalculate CDCLK, potentially resulting in the exact CPU pipe
FIFO underrun and blank screen issues this patch intended to fix.

>  	}
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/AM9PR06MB78601E2636=
164181A4689CC281EF2@AM9PR06MB7860.eurprd06.prod.outlook.com?part=3D1

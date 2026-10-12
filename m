Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEABCCA9ED9
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0EB710E48F;
	Mon, 12 Oct 2026 04:26:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 660FB10E454;
 Mon, 12 Oct 2026 04:26:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 28FEB43AA2;
 Mon, 12 Oct 2026 04:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4B91F0089B;
 Mon, 12 Oct 2026 04:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791779200;
 bh=KeWFrinQF48UrISV/koEeVBMUFV6oRvk2NlN1tCn8wg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mCjD60otqveR/+CtlrmNrILwWp0F45sVv8hAvwnjYuRH8QsPJeNeXePFojsfH1qO3
 xYAJgFQkep6TEsxD2yIHr5DAvHAYCh96CUafWicqwUivoNubFgpwt80aAOW8ppSL+t
 CVkyxTFzwD+ihKkMG9+Ivgxinhut0dcffNWaza2XDJfpU2kCKjPMs7olvdlBRDX3Nb
 /vdY3zv0/mmh1/jsjTRcLq9im6XoKVhGdE7ABBzEbynC6pGP4FeFD1IcDjNJES2NIq
 rKo1D1cCQIROzh8NebPOK4waAlClPUDUe54uOVfFpeoZ/Ikcx5TOJyMjXcaq8wV/Yg
 oVNmjohXF075Q==
Message-ID: <sashiko-outbox-167594@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/56] drm/i915/ltphy: Add PLL tables for HDMI FRL
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-20-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-20-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:26:39 +0000
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
- [High] drm/i915: typo in xe3plpd_lt_hdmi_10g0 PLL table causes write to r=
egister 0x0000
--

commit 42b740d6bfd04d2cc3cafcf973149a0f98931b3a
Author: Suraj Kandpal <suraj.kandpal@intel.com>

drm/i915/ltphy: Add PLL tables for HDMI FRL

Add HDMI FRL Tables for LT PHY i.e for the rates of 3G, 6G, 8G,
10G and 12G.

> diff --git a/drivers/gpu/drm/i915/display/intel_lt_phy.c b/drivers/gpu/dr=
m/i915/display/intel_lt_phy.c
> index 86492651b01d5..61bad87eefec2 100644
> --- a/drivers/gpu/drm/i915/display/intel_lt_phy.c
> +++ b/drivers/gpu/drm/i915/display/intel_lt_phy.c

[ ... ]

> +static const struct intel_lt_phy_pll_state xe3plpd_lt_hdmi_10g0 =3D {
> +	.config =3D {
> +		0x1d,

[Severity: High]
Is this config value a typo? The progression in other FRL tables appears to
increment by 8 for the top nibble (3G=3D0x85, 6G=3D0x8d, 8G=3D0x95, 12G=3D0=
xa5).
Should this be 0x9d instead of 0x1d?

> +		0x2d,
> +		0x0,
> +	},
> +	.addr_msb =3D {
> +		0x85,
> +		0x85,
> +		0x85,
> +		0x85,
> +		0x86,
> +		0x86,
> +		0x86,
> +		0x86,
> +		0x86,
> +		0x00,

[Severity: High]
Is 0x00 the intended value for addr_msb[9]? When combined with addr_lsb[9],
this will cause the configuration data to be written to hardware register
0x0000. It looks like it might be a typo for 0x86.

> +		0x86,
> +		0x86,
> +		0x86,
> +	},
> +	.addr_lsb =3D {
> +		0x10,
> +		0x0c,
> +		0x14,
> +		0xe4,
> +		0x0c,
> +		0x10,
> +		0x14,
> +		0x18,
> +		0x48,
> +		0x00,

[Severity: High]
Could this 0x00 value for addr_lsb[9] also be a typo? This completes the
invalid register address 0x0000. Writing the corresponding data payload
{ 0x27, 0x8, 0x0, 0x0 } to register 0x0000 could overwrite unrelated hardwa=
re
state, and failing to program the intended register (likely 0x8640) might
prevent successful link training for 10Gbps HDMI FRL.

> +		0x4c,
> +		0x24,
> +		0x44,
> +	},

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D19

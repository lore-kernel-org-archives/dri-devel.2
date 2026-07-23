Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C42F8C531FC
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 22:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A78210F243;
	Thu, 23 Jul 2026 22:31:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S8fwAjsK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DFFB10F240
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 22:31:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6490643A88;
 Thu, 23 Jul 2026 22:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0AB1F0155C;
 Thu, 23 Jul 2026 22:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784845882;
 bh=0kCE3suZYwCJ+Kd00s62SptLdfDNTkHAfcJL8OCUUr4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S8fwAjsKMN8nxrNByc0WcpJN9g1nALm9kj8MM9aA1zctYumFaMmNS8JHpiz6msYGD
 bmnxOU4s4IS8OIRDSoc6xbCdaRFb4OLNP9rborlu6gzRoExhUZvuQ/u38fAr9plfN+
 Q9+k0aZj18KbDcc1DTkZC/d+t/aMm/XjRaZhtnTCgy7JAN7yEjfAsmgDudvnhfD8tE
 HWpXhv1Cxb1yhsodsWdJ/UNwe3TEUaa6t5tjNqeK1gMa63oFY/X1v5ep5a6biyBGcf
 inoAtBQjm1k7XjbdBT4fSgsHx8fTj7n7Rfvp+/Z4dcnuDC5s5HsqgFx0m8EebsfQmQ
 Pgj8TnBJB5JvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/15] drm/bridge: synopsys: dw-dp: Support
 MEDIA_BUS_FMT_FIXED
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260724-synopsys-dw-dp-improvements-v5-5-9445c2e87441@collabora.com>
References: <20260724-synopsys-dw-dp-improvements-v5-0-9445c2e87441@collabora.com>
 <20260724-synopsys-dw-dp-improvements-v5-5-9445c2e87441@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 22:31:21 +0000
Message-Id: <20260723223121.ED0AB1F0155C@smtp.kernel.org>
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
- [High] dw_dp_bridge_atomic_check ignores the negotiated input bus format =
when the output format is MEDIA_BUS_FMT_FIXED, forcing the highest-bandwidt=
h format instead.
- [Low] OOM condition masked as -EINVAL instead of -ENOMEM in dw_dp_bridge_=
atomic_check.
--

--- Patch [5]: [PATCH v5 05/15] drm/bridge: synopsys: dw-dp: Support MEDIA_=
BUS_FMT_FIXED ---
commit 22a7a7c58c5ed8233a59740b01dc41f49ab3cdc8
Author: Sebastian Reichel <sebastian.reichel@collabora.com>

drm/bridge: synopsys: dw-dp: Support MEDIA_BUS_FMT_FIXED

This patch adds support for MEDIA_BUS_FMT_FIXED to the Synopsys DW-DP bridg=
e.
It updates atomic_check to resolve MEDIA_BUS_FMT_FIXED by selecting the fir=
st
bandwidth-filtered output format, and implements a custom
atomic_get_input_bus_fmts hook to advertise all supported formats for upstr=
eam
negotiation.

> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/br=
idge/synopsys/dw-dp.c
> index 3dec7777fb285..812c67fdfb6b8 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
> @@ -1586,7 +1587,25 @@ static int dw_dp_bridge_atomic_check(struct drm_br=
idge *bridge,
>  	state =3D to_dw_dp_bridge_state(bridge_state);
>  	mode =3D &state->mode;
> =20
> -	fmt =3D dw_dp_get_output_format(bridge_state->output_bus_cfg.format);
> +	if (out_bus_format =3D=3D MEDIA_BUS_FMT_FIXED) {
> +		unsigned int num_fmts =3D 0;
> +		u32 *fmts;
> +
> +		fmts =3D dw_dp_bridge_atomic_get_output_bus_fmts(bridge,
> +							       bridge_state,
> +							       crtc_state,
> +							       conn_state,
> +							       &num_fmts);
> +		if (!num_fmts) {
> +			kfree(fmts);
> +			return -EINVAL;

[Severity: Low]
Does this mask an out-of-memory condition?=20

If dw_dp_bridge_atomic_get_output_bus_fmts() fails to allocate memory via
kcalloc(), it returns NULL and sets num_fmts to 0. Returning -EINVAL here
obscures the actual -ENOMEM error.

> +		}
> +
> +		out_bus_format =3D fmts[0];

[Severity: High]
Does this unconditionally override the successfully negotiated input format?

If the upstream element negotiated a format other than fmts[0] (which would
be stored in bridge_state->input_bus_cfg.format), won't forcing fmts[0] here
cause a format mismatch between the hardware and the upstream encoder?

> +		kfree(fmts);
> +	}
> +
> +	fmt =3D dw_dp_get_output_format(out_bus_format);
>  	if (!fmt)
>  		return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-synopsys-d=
w-dp-improvements-v5-0-9445c2e87441@collabora.com?part=3D5

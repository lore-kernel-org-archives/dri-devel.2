Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA6FC44512
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D89A10EC6A;
	Wed, 22 Jul 2026 06:51:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R30Gwggl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EB2910EC6A
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:51:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6D91360A64
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2431F000E9;
 Wed, 22 Jul 2026 06:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784703106;
 bh=hU4pyM37p5pPpeLWxrBziQExjoGZLuyrwSwHXhcNbAE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R30Gwgglt/trJaiBksIO06CX93BJ10zMe9mq8DqkzqsWNdlsuq5gCa50420ztBuU7
 HewEqVPjM1pU7Hcaad2nVR/rKcCNgti5Accb9EYkQXWXtPkaQM9VsLN4rbLIxBrBla
 mHjayqCh1MAhWvkiPyjmqAwpMxq+l9NRVQkvWf7OYpb9c8NZrVZQtAdUYiuAN5RM9a
 k/EX+c2UMK6fYfqUk7AfVkUw1y0S1zaO9xgxPV13Y6lZ/ownJv0FJY71X13RjR3QJ6
 SMVK8MicQUfoPeheEB46R1zrDrRvkEzIBlypYDxOutRG55qKuICJZQYdTxANsG3Kwi
 uZx8q527KZbaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: use proper context for logging
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722063210.1144266-1-jirislaby@kernel.org>
References: <20260722063210.1144266-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 06:51:45 +0000
Message-Id: <20260722065145.EC2431F000E9@smtp.kernel.org>
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
- [High] NULL pointer dereference when logging errors in `dce112_get_pix_cl=
k_dividers` and `dcn3_get_pix_clk_dividers`.
--

--- Patch [1]: [PATCH] drm/amd/display: use proper context for logging ---
commit 67013b697b017867bb1c1e61f13b863b96364c5e
Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>

drm/amd/display: use proper context for logging

This commit fixes a NULL pointer dereference in get_ss_info_from_atombios()
by temporarily redefining DC_LOGGER to use clk_src->base.ctx->logger. The
calc_pll_cs->ctx context is uninitialized at that time since it is only set
later by calc_pll_max_vco_construct().

Closes: https://bugzilla.suse.com/show_bug.cgi?id=3D1271175
Closes: https://lore.kernel.org/all/a9ee54e6-2413-4156-9bde-d528ae3c63a3@ke=
rnel.org/
Fixes: 1296423bf23c ("drm/amd/display: define DC_LOGGER for logger")

> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> index ecb8493ec5233..d3f7aa853e3a6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> @@ -1513,6 +1513,10 @@ static const struct clock_source_funcs dce110_clk_=
src_funcs =3D {
>  	.get_dp_dto_frequency_100hz =3D get_dp_dto_frequency_100hz
>  };
> =20
> +/* calc_pll_cs->ctx is set only after get_ss_info_from_atombios(), unlik=
e clk_src->base */
> +#pragma push_macro("DC_LOGGER")
> +#undef DC_LOGGER
> +#define DC_LOGGER CTX->logger

[Severity: High]
This is a pre-existing issue, but does a similar NULL pointer dereference=20
exist in dce112_get_pix_clk_dividers() and dcn3_get_pix_clk_dividers()
during their error paths?

It appears dce112_clk_src_construct() does not call=20
calc_pll_max_vco_construct(), leaving calc_pll_cs->ctx as NULL. If invalid=
=20
parameters are passed (like requested_pix_clk_100hz =3D=3D 0), the error pa=
th
invokes DC_LOG_ERROR() which dereferences calc_pll_cs->ctx->logger:

drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c:dce112_get_pix_clk_di=
viders() {
        DC_LOGGER_INIT();

        if (pix_clk_params =3D=3D NULL || pll_settings =3D=3D NULL
                        || pix_clk_params->requested_pix_clk_100hz =3D=3D 0=
) {
                DC_LOG_ERROR(
                        "%s: Invalid parameters!!\n", __func__);
                return (uint32_t)-1;
        }
        ...
}

A similar error path exists in dcn3_get_pix_clk_dividers().

Since DC_LOG_ERROR() relies on the same uninitialized context pointer,=20
could this trigger a crash similar to the one being fixed here if these
functions encounter invalid parameters?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722063210.1144=
266-1-jirislaby@kernel.org?part=3D1

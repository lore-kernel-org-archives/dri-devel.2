Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0ECDC88E75
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CF6710EBFE;
	Mon, 14 Sep 2026 15:26:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aI2GaBeX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF99310EBFE
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 15:26:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 84D96402DA;
 Mon, 14 Sep 2026 15:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5991F000FF;
 Mon, 14 Sep 2026 15:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789399589;
 bh=pSuyJmHfV/h2G4pqpGDBOV/6k7EuPSRpPjcpzqwExng=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aI2GaBeXl30XDdWaIMzyV39vaXEHd+vyTOohFB1xJqQXeZApKG03cRFuziz6THjWj
 otOEAiPrGCvl65oVJIBCd9ajAxA8LpzMddEKaiH3l1VXkyofwOBf8Mzq5Z5dKujPMF
 t8udIdhTSEFvpED+0UCXBYzpLqDaqha5PUsZS+oBj0NbIftfJRbC+AJw4Mxp9Xiorj
 dkI0icM5BNiyTDY9RQCjGFQbdBx6LotintKb6nzQdFBQScCNwu0R0GaD2w8WP4q8DY
 mFFzb+iJfImfJ5GRI488I+ddVSYFIlWfCL0oeG2zYPVCTVh9InzO7Dd+d+MoLSVJ86
 m+cIkflKPxt2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: guard NULL secondary pipe in
 dcn_validate_bandwidth()
To: "Dmitriy Chumachenko" <Dmitry.Chumachenko@cyberprotect.ru>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914151446.94380-1-Dmitry.Chumachenko@cyberprotect.ru>
References: <20260914151446.94380-1-Dmitry.Chumachenko@cyberprotect.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 15:26:28 +0000
Message-Id: <20260914152629.3D5991F000FF@smtp.kernel.org>
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
- [High] Skipping a required pipe split when no free pipes are available si=
lently accepts an invalid display configuration and allows bandwidth valida=
tion to succeed.
--

commit 933da7b5e47097aeef7c30116ceee6ba3c949c0a
Author: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>

drm/amd/display: guard NULL secondary pipe in dcn_validate_bandwidth()

This commit adds NULL checks around the return value of
resource_find_free_secondary_pipe_legacy() in dcn_validate_bandwidth() to
prevent NULL pointer dereferences during pipe splits.

> diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c b/drive=
rs/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
> --- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c

[ ... ]

> @@ -1263,10 +1263,12 @@ bool dcn_validate_bandwidth(
>  						/* pipe not split previously needs split */
>  						hsplit_pipe =3D resource_find_free_secondary_pipe_legacy(&context-=
>res_ctx, pool, pipe);
>  						ASSERT(hsplit_pipe);
> -						split_stream_across_pipes(&context->res_ctx, pool, pipe, hsplit_pi=
pe);
> +						if (hsplit_pipe)
> +							split_stream_across_pipes(&context->res_ctx, pool, pipe, hsplit_p=
ipe);
>  					}
> =20
> -					dcn_bw_calc_rq_dlg_ttu(dc, v, hsplit_pipe, input_idx);
> +					if (hsplit_pipe)
> +						dcn_bw_calc_rq_dlg_ttu(dc, v, hsplit_pipe, input_idx);

[Severity: High]
Does skipping this pipe split allow bandwidth validation to incorrectly
succeed?

When resource_find_free_secondary_pipe_legacy() returns NULL because all
secondary pipes are in use, this change silently skips the required pipe
split. Since dcn_validate_bandwidth() evaluates the bw_limit_pass condition
independently at the end of the function, it can still return true even
though a required hardware resource was missing.

Could this allow the display framework to proceed with an invalid
configuration, potentially leading to hardware misprogramming or display
underflow? Should dcn_validate_bandwidth() return false or propagate an
error when hsplit_pipe is NULL rather than continuing silently?

>  				} else if (hsplit_pipe && hsplit_pipe->plane_state =3D=3D pipe->plan=
e_state) {
>  					/* merge previously split pipe */
>  					pipe->bottom_pipe =3D hsplit_pipe->bottom_pipe;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914151446.9438=
0-1-Dmitry.Chumachenko@cyberprotect.ru?part=3D1

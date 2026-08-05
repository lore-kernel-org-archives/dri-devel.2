Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A698C55838
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 01:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B091210E11C;
	Wed,  5 Aug 2026 01:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="giKKwoGs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A08F10E11C
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 01:39:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C712B439D6;
 Wed,  5 Aug 2026 01:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9761F000E9;
 Wed,  5 Aug 2026 01:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785893967;
 bh=PqaKQmZAQoZVSM0OZr6DIAGCqJehcHT/QZkTAZcKowM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=giKKwoGsFyGA1Dpfrf0qO7wA1pljqAZnlyCx/YVOr/StrRstAmQeGW5/bsM/GyIRV
 St6SKoT/wgW5MnR0fToiqBcu2WO7tUnYcznQ68Mn6NTHyuopa15zR0iIIl6CYXKQ+X
 Q8aOCPwtls/5Chofa6rLUAYXts6U4c635ZHgoyOIg9l9OJ5Q91FyetrIHD6jO7kWzU
 TbibNX5Oinmm+OMBeLzOzS81mqmCk2M+BjdUD0fwt01g/DHjnz9NLxyVZIP0JQODEA
 DJvDu2Zg+TsiZKd2aIaaB7qWHAVzEpDUF4jX3q0F198ZP609qbw7ocdl3+Evb1Ac0J
 Vj0DkDIQGGMBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: avoid NULL hubp deref when filling
 mpcc_id on DCE
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805012350.1458583-1-honghuan@amd.com>
References: <20260805012350.1458583-1-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 01:39:27 +0000
Message-Id: <20260805013927.7F9761F000E9@smtp.kernel.org>
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
- [High] The patch resolves a NULL pointer dereference of `hubp` on DCE ASI=
Cs in `dc_hw_sequencer.c` by using a helper to fetch `mpcc_id`, but misses =
identical pre-existing vulnerabilities in `dc.c` and `dc_stream.c`. When sp=
ecific `visual_confirm` or `validate_dml_output` debug options are enabled =
(which are documented options passed via module parameters or debugfs), the=
 driver unconditionally dereferences `pipe_ctx->plane_res.hubp` and calls u=
ninitialized function pointers (like `dc->hwss.update_visual_confirm_color`=
, which is NULL on DCE). This leads to an immediate kernel panic on DCE har=
dware.
--

--- Patch [1]: [PATCH] drm/amd/display: avoid NULL hubp deref when filling =
mpcc_id on DCE ---
commit 4049d13de015ecc06980243ec06ca6c8b79266f3
Author: Honglei Huang <honghuan@amd.com>

drm/amd/display: avoid NULL hubp deref when filling mpcc_id on DCE

The commit fixes a NULL pointer dereference on DCE ASICs by introducing a
helper to safely fetch the mpcc_id when a HUBP instance is missing.

> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/driv=
ers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> @@ -729,6 +729,16 @@ void get_fams2_visual_confirm_color(
>  	}
>  }
> =20
> +/*
> + * Return the MPCC instance for a pipe. On DCN it matches the HUBP insta=
nce.
> + * DCE has no HUBP and ignores mpcc_id, so return 0 there instead of cha=
sing a
> + * NULL pointer.
> + */
> +static int hwss_pipe_mpcc_id(const struct pipe_ctx *pipe_ctx)
> +{

[Severity: High]
This is a pre-existing issue, but while this patch resolves the NULL
dereferences of plane_res.hubp in dc_hw_sequencer.c, are there still
identical vulnerabilities in dc.c and dc_stream.c on DCE ASICs?

For example, in drivers/gpu/drm/amd/display/dc/core/dc.c in
dc_commit_state_no_check(), if VISUAL_CONFIRM_SUBVP or
VISUAL_CONFIRM_MCLK_SWITCH are enabled, the code unconditionally dereferenc=
es
hubp->inst:

dc->hwss.update_visual_confirm_color(dc, pipe_ctx,
                                     pipe_ctx->plane_res.hubp->inst);

Similarly, in drivers/gpu/drm/amd/display/dc/core/dc_stream.c in
dc_stream_program_cursor_position(), if VISUAL_CONFIRM_HW_CURSOR is enabled:

dc->hwss.update_visual_confirm_color(dc, pipe_ctx,
                                     pipe_ctx->plane_res.hubp->mpcc_id);

Additionally, dc_commit_state_no_check() unconditionally accesses
hubp->funcs->validate_dml_output on DCE when validate_dml_output is enabled.

Does the driver also call a NULL function pointer on DCE in these paths
since dc->hwss.update_visual_confirm_color might not be initialized for
DCE? Could the new hwss_pipe_mpcc_id() helper be exported and used to fix
these remaining paths, and guards added for the function pointer calls?

> +	return pipe_ctx->plane_res.hubp ? pipe_ctx->plane_res.hubp->inst : 0;
> +}
> +
>  void hwss_build_fast_sequence(struct dc *dc,

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805012350.1458=
583-1-honghuan@amd.com?part=3D1

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB5BC624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADA8210E942;
	Mon, 31 Aug 2026 14:35:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Et776gXV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5481210E91A
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:35:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A47160214
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 14:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3F51F000E9;
 Mon, 31 Aug 2026 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788186905;
 bh=w8I/uxUkrx9kbZEDYoyJNba5uWjbWc/AQuxAoOEAp30=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Et776gXVtHN802WU45Zn3ycJ8DGBFakfWiPkrrfmtkBViuMdqHI1QWWNumlu6XdFF
 p2ss8M+dLciCSbFROw1zNtKC5XU37xWkJihCZ3p+CDnWOOil/7n0v+k/Aoto/VZBS/
 /ASLkHxNB4N4fBrMvgUBHMCb+hhVw6clFKdOtcG1gO37YOfoLhaslmm8AOv8ntPNUC
 eMxflwY3fkDkR4AJPlhQmh5Ny9MOzrUwpXY2nh6tFjgOkaAJHeW2pAoPKKc8Zgp/29
 1O6+M91SFYXjNPobG8GzWl7Yc7/C4+QmYhw24QcTDNx0z131OzwyiysPT/lGMr7Dfq
 yklyeOCaCjHOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] drm/amd/display: Avoid DPMS-on for phantom
 stream
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-127-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-127-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 14:35:04 +0000
Message-Id: <20260831143504.EA3F51F000E9@smtp.kernel.org>
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
- [High] Type confusion between array of pointers and array of structs caus=
es incorrect pipe updates for multi-pipe links.
--

commit 2b93ced29eb3c89bb083129e3d48fc9f319bc125
Author: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Subject: drm/amd/display: Avoid DPMS-on for phantom stream

This commit fixes a NULL pointer dereference in the DP link training
code path. It skips phantom streams during stream caching for updates,
as phantom streams are destroyed during the first update call.

> diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.=
c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
> index 2676ae9f6fe83..5f70793b8372e 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
> @@ -143,6 +143,8 @@ static void dp_retrain_link_dp_test(struct dc_link *l=
ink,
>  	// Set DPMS on with stream update
>  	// Cache all streams on current link since dc_update_planes_and_stream =
might kill current_state
>  	for (i =3D 0; i < MAX_PIPES; i++) {
> +		if (state->streams[i] && state->streams[i]->is_phantom)
> +			continue;
>  		if (state->streams[i] && state->streams[i]->link && state->streams[i]-=
>link =3D=3D link)
>  			streams_on_link[num_streams_on_link++] =3D state->streams[i];
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but looking earlier in
dp_retrain_link_dp_test(), does this code pass an array of pointers to a
function expecting a contiguous array of structs?

dp_retrain_link_dp_test() populates pipes as an array of pointers to active
master pipes:

drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c:dp_retrain_li=
nk_dp_test() {
    ...
    struct pipe_ctx *pipes[MAX_PIPES];
    ...
    link_get_master_pipes_with_dpms_on(link, state, &count, pipes);
    ...
    if (needs_divider_update && link->dc->res_pool->funcs->update_dc_state_=
for_encoder_switch) {
        link->dc->res_pool->funcs->update_dc_state_for_encoder_switch(link,
                link_setting, count,
                *pipes, &audio_output[0]);
    ...
}

It passes *pipes (the first pointer). However, the callee expects a pointer
to an array of contiguous struct pipe_ctx objects:

drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c:dcn31_update=
_dc_state_for_encoder_switch() {
    ...
    for (i =3D 0; i < pipe_count; i++) {
        link->dc->res_pool->funcs->build_pipe_pix_clk_params(&pipes[i]);
    ...
}

Because pipes are collected from active master pipes, they may not be
contiguous in the state->res_ctx.pipe_ctx array for multi-pipe links
(e.g. MST). Using pointer arithmetic (&pipes[i]) here will incorrectly
modify adjacent memory that might belong to unrelated active displays, while
failing to update the actual target pipes.

Can this lead to state corruption and display malfunction during display
hotplug, mode set, or automated DP compliance testing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-127-sashal@kernel.org?part=3D1

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E66C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 238A610EA23;
	Mon, 31 Aug 2026 17:15:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cp7nfFAQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD5D10EA0C
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 17:15:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2701060120
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 17:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4601F000E9;
 Mon, 31 Aug 2026 17:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788196526;
 bh=SZykO3zBsY2YCANmOE64CuFWcDs5t+0CkWM1zhhhIe0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Cp7nfFAQ2njqYggyvwuFW9cYQ5Myca2JiiRcThggctgfe3RMEdv98bUpoBl72i+EL
 6PjLMDnbfht0JYsUQ/hlxrmcUvdo+FBTMSJUhTle7S/5AhJxchGqorW8eqTbK8Ru4N
 /8sEzkvlEurtz/x/qkaLtC5THtB+u65f5yRK1sQX5qLv0zOFDv6L+3hea9Yzu3NEh4
 yMwOXPiSeYKQ91lKssPwU1k1APP1hzk9+/RH3EQNB/vdX5bu6j4a9mDOgjQPVpTnW6
 1gxjo8qwc9ut/wUFcM9BdBs2nIblFQzS8ph2lwbZLQvWyCTiH5+1CszfvJyPl0I8SC
 dW+B1aUxZWoVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.6] drm/amd/display: Fix DPMS using
 partially updated pipe context
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-559-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-559-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:15:26 +0000
Message-Id: <20260831171526.BE4601F000E9@smtp.kernel.org>
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
- [High] The patch introduces a critical indexing mismatch by using a pipe =
index `j` derived from the newly evaluated `context` to fetch the correspon=
ding pipe from the old `current_state`. Because pipe topology can change dy=
namically between states, this leads to NULL pointer dereferences or incorr=
ectly powering down the wrong display's hardware pipeline.
--

commit 4b109eb12ffb5f2fcc8ece3764e3caf46a2d8331
Author: Dominik Kaszewski <dominik.kaszewski@amd.com>

drm/amd/display: Fix DPMS using partially updated pipe context

DPMS functions are modified to use the pipe context from current_state
(the most recently programmed HW config) rather than the partially
updated context.

> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/a=
md/display/dc/core/dc.c
> index 5f2d5638c8191..8793383e39410 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3690,27 +3690,34 @@ static void commit_planes_do_stream_update(struct=
 dc *dc,
[ ... ]
> +			// DPMS should not use partially updated pipe context
> +			struct pipe_ctx *dpms_pipe_ctx =3D &dc->current_state->res_ctx.pipe_c=
tx[j];
> +

[Severity: High]
Does this introduce an indexing mismatch between the old and new contexts?

The commit_planes_do_stream_update() loop iterates over the new context usi=
ng
index j to find pipes for the stream being updated. However, because pipe
topology can change dynamically between states during stream updates, index=
 j
in current_state might not map to the same stream.

>  			if (stream_update->dpms_off) {
>  				if (*stream_update->dpms_off) {
> -					dc->link_srv->set_dpms_off(pipe_ctx);
> +					dc->link_srv->set_dpms_off(dpms_pipe_ctx);

[Severity: High]
If pipe j belonged to a different stream in current_state due to a dynamic
reassignment, could this pass the wrong context and power down the incorrect
physical display hardware?

>  					/* for dpms, keep acquired resources*/
> -					if (pipe_ctx->stream_res.audio && !dc->debug.az_endpoint_mute_only)
> -						pipe_ctx->stream_res.audio->funcs->az_disable(pipe_ctx->stream_res=
.audio);
> +					if (dpms_pipe_ctx->stream_res.audio && !dc->debug.az_endpoint_mute_=
only) {
> +						struct audio *audio =3D dpms_pipe_ctx->stream_res.audio;
> +
> +						audio->funcs->az_disable(audio);
> +					}
> =20
>  					dc->optimized_required =3D true;
> =20
>  				} else {
>  					if (get_seamless_boot_stream_count(context) =3D=3D 0)
>  						dc->hwss.prepare_bandwidth(dc, dc->current_state);
> -					dc->link_srv->set_dpms_on(dc->current_state, pipe_ctx);
> +					dc->link_srv->set_dpms_on(dc->current_state, dpms_pipe_ctx);
>  				}
> -			} else if (pipe_ctx->stream->link->wa_flags.blank_stream_on_ocs_chang=
e && stream_update->output_color_space
> -					&& !stream->dpms_off && dc_is_dp_signal(pipe_ctx->stream->signal)) {
> +			} else if (dpms_pipe_ctx->stream->link->wa_flags.blank_stream_on_ocs_=
change &&
> +					stream_update->output_color_space &&
> +					!stream->dpms_off && dc_is_dp_signal(dpms_pipe_ctx->stream->signal)=
) {

[Severity: High]
Could this result in a NULL pointer dereference?

If pipe j was completely unused in current_state prior to this commit,
dpms_pipe_ctx->stream will be NULL, which would lead to a kernel panic when
unconditionally dereferencing dpms_pipe_ctx->stream->link here.

>  				/*
>  				 * Workaround for firmware issue in some receivers where they don't =
pick up
>  				 * correct output color space unless DP link is disabled/re-enabled
>  				 */
> -				dc->link_srv->set_dpms_on(dc->current_state, pipe_ctx);
> +				dc->link_srv->set_dpms_on(dc->current_state, dpms_pipe_ctx);
>  			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-559-sashal@kernel.org?part=3D1

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EE2CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 03:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD17610E0E7;
	Tue, 29 Sep 2026 03:25:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OJSuA94M";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D0B210E0E7
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 03:25:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6CE45602C3;
 Tue, 29 Sep 2026 03:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0244C1F000FF;
 Tue, 29 Sep 2026 03:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790652315;
 bh=fvkrMstYEQzp3h5f7FnzboogzNlOokxsbynROmD7Ke8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OJSuA94M9yQBhBXtcXM3HrdQZXWTXi59kU28omVcjMQL5kkwERa5xTg+KAa56kWpL
 lJsr0hRq3wFbYSZkT9Qnffzp9paSlsBNny5sIgzKEsBQN/zAtQH1biUECNlxsH8ge0
 /V4FoGSxodFDLCYZImin/GHBu32yj/ddMLOixSsAGNu0moGccog3rHxzKl2w20o8xG
 AjVT3w5/d0bOCsg+OLSdaIufxxnrdy45KlERu4tCTx1EALV04V8xbhClz0jX3uaVp7
 0hIlkJRzCmWDbBtO+XG+tuoBfhAK/IFrcLdBclwipJz6Og5N5ATvxBiTLjO8DHEDT8
 clJZaOUBdT31Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] drm/amd/display: Validate function returns
To: "Artem Dinaburg" <artem@trailofbits.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929031602.87583-1-artem@trailofbits.com>
References: <20260929031602.87583-1-artem@trailofbits.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 03:25:14 +0000
Message-Id: <20260929032515.0244C1F000FF@smtp.kernel.org>
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
- [Medium] drm/amd/display: early return in dc_dmub_srv_cmd_run_list() drop=
s diagnostics
--

commit a641a7a2bd113ef9410e77f8cb3dd3d38d42ca71
Author: Alex Hung <alex.hung@amd.com>

drm/amd/display: Validate function returns

This commit adds checks for function return values to fix Coverity issues.
It handles errors from dmub_srv_wait_for_idle, dc_get_edp_link_panel_inst,
hubbub1_program_pstate_watermarks, and link_detect_connection_type.

> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/d=
rm/amd/display/dc/dc_dmub_srv.c
> index 30a79dffbd37a..b3f02f451535a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
> @@ -144,7 +144,9 @@ bool dc_dmub_srv_cmd_run_list(struct dc_dmub_srv *dc_=
dmub_srv, unsigned int coun
>  		if (status =3D=3D DMUB_STATUS_QUEUE_FULL) {
>  			/* Execute and wait for queue to become empty again. */
>  			dmub_srv_cmd_execute(dmub);
> -			dmub_srv_wait_for_idle(dmub, 100000);
> +			status =3D dmub_srv_wait_for_idle(dmub, 100000);
> +			if (status !=3D DMUB_STATUS_OK)
> +				return false;
> =20
>  			/* Requeue the command. */
>  			status =3D dmub_srv_cmd_queue(dmub, &cmd_list[i]);
>  		}

[Severity: Medium]
Does this new early return inadvertently bypass the diagnostic data collect=
ion?

Looking at dc_dmub_srv_cmd_run_list(), right after this block there is an
error handler for when the queue or wait fails:

		if (status !=3D DMUB_STATUS_OK) {
			DC_ERROR("Error queueing DMUB command: status=3D%d\n", status);
			dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
			return false;
		}

By returning false directly when dmub_srv_wait_for_idle() fails, we skip
dc_dmub_srv_log_diagnostic_data() and the DC_ERROR logging. Could we
instead let it fall through or break here so that the existing error
handler can collect this diagnostic data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929031602.8758=
3-1-artem@trailofbits.com?part=3D1

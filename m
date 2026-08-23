Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5526AC5DF8C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 09:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6683510E4AD;
	Sun, 23 Aug 2026 09:34:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FVUFeR1M";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2774F10E4AD
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 09:34:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0FAB760008;
 Sun, 23 Aug 2026 09:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903F01F000E9;
 Sun, 23 Aug 2026 09:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787477689;
 bh=+4Kl/J455ZG9esdhYeZ8iGyqO9GYRl01LzKAhFrjl/U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FVUFeR1MLqOgtKOCAux+ZkxjOSZFSEsu1rQg6gmKmsI5H15senLlswJrQo2G10e4Z
 O6ksM6bezVDvFMSJ90ZZLM0eKhgDo/u49pQuC+VUoxThg1lTIZ3SuApIMIFsDBJJsH
 LwJNgpXXfbKAzCQ39F3YodfOnAT8A/dM1u3IL2KuYShed80Dirm5BzJp+chDYIDfWz
 0OiLcXQ21EeQi+VZ2zDlgtRadZsLZZjhQebw6CWvmETuI45qSGzdD4+IObwLem9fkn
 C1t42t3e3IMi4ejdeR7miinSK/VZ0HWGYYPIUEAjtLwUIAIZw+vcjAMuY6h1xw5y95
 yqlm/41SCvdnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: Restore self-refresh fallback in DCN21
 bandwidth validation
To: "Julien Le Bourg" <julien.lebourg8@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260822091715.6692-1-julien.lebourg8@gmail.com>
References: <20260822091715.6692-1-julien.lebourg8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 09:34:49 +0000
Message-Id: <20260823093449.903F01F000E9@smtp.kernel.org>
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
- [High] Reverting `allow_self_refresh_only` to `true` reintroduces a known=
 `flip_done` timeout regression for MPO configurations because the underlyi=
ng state consistency issue remains unfixed.
--

--- Patch [1]: [PATCH] drm/amd/display: Restore self-refresh fallback in DC=
N21 bandwidth validation ---
commit a448c5ed2983960ea5f4923032f3c31614dd4ecb
Author: Julien Le Bourg <julien.lebourg8@gmail.com>

drm/amd/display: Restore self-refresh fallback in DCN21 bandwidth validation
   =20
This commit restores the self-refresh fallback in DCN21 bandwidth validatio=
n=20
by passing true for allow_self_refresh_only to dcn21_fast_validate_bw(). Th=
is=20
resolves an issue where high refresh rate modes with short vertical blankin=
g=20
were rejected on eDP panels.

> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drive=
rs/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> index 38c79239004c4..426e9c03fabc6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> @@ -2347,7 +2347,8 @@ bool dcn21_validate_bandwidth_fp(struct dc *dc, str=
uct dc_state *context,
>  	/*Unsafe due to current pipe merge and split logic*/
>  	ASSERT(context !=3D dc->current_state);
> =20
> -	out =3D dcn21_fast_validate_bw(dc, context, pipes, &pipe_cnt, pipe_spli=
t_from, &vlevel, validate_mode, false);
> +	out =3D dcn21_fast_validate_bw(dc, context, pipes, &pipe_cnt, pipe_spli=
t_from,
> +				     &vlevel, validate_mode, true);

[Severity: High]
Does reverting this to true reintroduce the flip_done timeout regression for
MPO configurations?

Since the underlying state consistency issue remains unfixed, it seems
calculate_wm_set_for_vlevel() still overwrites sr_exit_time_us but never
restores it:

drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c:calculate_wm_set_for_v=
level() {
    ...
    dml->soc.sr_exit_time_us =3D table_entry->sr_exit_time_us;
    dml->soc.sr_enter_plus_exit_time_us =3D table_entry->sr_enter_plus_exit=
_time_us;
    ...
}

This state leak into dc->current_state causes the next atomic_check to copy
the corrupted state, leading to a flip_done timeout when bandwidth validati=
on
fails during atomic_commit_tail.

> =20
>  	if (pipe_cnt =3D=3D 0)
>  		goto validate_out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822091715.6692=
-1-julien.lebourg8@gmail.com?part=3D1

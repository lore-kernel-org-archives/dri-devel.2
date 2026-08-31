Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B23C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:24:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5458610E924;
	Mon, 31 Aug 2026 15:24:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M0tuy0nm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A3BD10E924
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:24:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D1E566013A
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658401F000E9;
 Mon, 31 Aug 2026 15:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788189887;
 bh=ub/A2RW6tSlILKSIHpAoGc9kmCwQoG7AXsMC8UT59Ts=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M0tuy0nmn31J8AVm/Di+/6e+uHfhc4DS0MPo0Dq31bbgvREn6V5DInCETFd/dUEpB
 i7ptU+rCsaBcTe4kLLsqHd6kkSfcRSEC9lO5DoKNNTTETWLadwzaR51f2Yq5ElmaYL
 KXeWBe7yZUaepoxtYKBcGXf449Zotes6ZRAvgeUDFgIVcAD7HL8m1m5TmzmpnoKNty
 mhn3VphdgTQECve+Kyk3tm+9JSui6EPiAQGjcDxriESzpTP3pc+2av/ti2SI8MBaqT
 KJ/VetLcEV+vER3or/kKtu34pFEL+5XuTZ381PXtH8YTz7TkG5NI7G3Xq5LXmtZDWx
 +fgbB4poQX18A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] drm/amd/display: Fix CRC open failure
 during active rendering
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-265-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-265-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:24:46 +0000
Message-Id: <20260831152447.658401F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Incomplete Fix / Uninitialized Return Value leaking positive jiffi=
es to VFS
- [High] Resource leak due to missing `drm_crtc_vblank_put()` on error paths
--

commit 4554672736d3ae3e68d6ba478384d8757a136c1f
Author: Tom Chung <chiahsuan.chung@amd.com>
Date:   Mon Aug 31 13:24:53 2026 +0000

    drm/amd/display: Fix CRC open failure during active rendering

This commit changes the wait_for_completion_interruptible_timeout() handling
to treat a positive return value (remaining jiffies) as success, 0 as timeo=
ut,
and negative as an error.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
> index e20aa74380665..596a97092e0dd 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
> @@ -584,8 +584,13 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *c=
rtc, const char *src_name)
>  		 */
>  		ret =3D wait_for_completion_interruptible_timeout(
>  			&commit->hw_done, 10 * HZ);
> -		if (ret)
> +		if (ret < 0)
> +			goto cleanup;
> +
> +		if (ret =3D=3D 0) {
> +			ret =3D -ETIMEDOUT;
>  			goto cleanup;
> +		}
>  	}
> =20
>  	enable =3D amdgpu_dm_is_valid_crc_source(source);

[Severity: High]
This isn't a bug introduced by this patch, but
wait_for_completion_interruptible_timeout() returns the positive remaining
jiffies on success. Since ret is not explicitly reset to 0 here, it can ret=
ain
this positive value.=20

If the condition !enabled && enable evaluates to false later in the functio=
n,
ret is never overwritten to 0 by drm_crtc_vblank_get(). This leaves the
function returning the unmodified positive ret value to the VFS caller.
Returning a positive value from a VFS open() operation triggers a
WARN_ON_ONCE(error > 0) in do_dentry_open(), which causes a kernel panic if
panic_on_warn is enabled.

Should ret be explicitly reset to 0 upon success to prevent leaking positive
jiffies to the VFS layer?

[ ... ]

>  	/*
>  	 * Reading the CRC requires the vblank interrupt handler to be
>  	 * enabled. Keep a reference until CRC capture stops.
>  	 */
>  	enabled =3D amdgpu_dm_is_valid_crc_source(cur_crc_src);
>  	if (!enabled && enable) {
>  		ret =3D drm_crtc_vblank_get(crtc);
>  		if (ret)
>  			goto cleanup;
>  	}
> =20
>  #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
>  	/* Reset secure_display when we change crc source from debugfs */
>  	amdgpu_dm_set_crc_window_default(crtc, crtc_state->stream);
>  #endif
> =20
>  	if (amdgpu_dm_crtc_configure_crc_source(crtc, crtc_state, source)) {
>  		ret =3D -EINVAL;
>  		goto cleanup;
>  	}
> =20
>  	if (!enabled && enable) {
>  		if (dm_is_crc_source_dprx(source)) {
>  			if (drm_dp_start_crc(aux, crtc)) {
>  				DRM_DEBUG_DRIVER("dp start crc failed\n");
>  				ret =3D -EINVAL;
>  				goto cleanup;
>  			}
>  		}

[Severity: High]
This is a pre-existing issue, but does this error path leak the vblank
reference?=20

If amdgpu_dm_crtc_configure_crc_source() or drm_dp_start_crc() fail, the co=
de
jumps to the cleanup label without calling drm_crtc_vblank_put() to balance
the reference successfully acquired earlier via drm_crtc_vblank_get(). This
can permanently leak a CRTC vblank reference count, preventing the display
subsystem from entering low-power states.

Should drm_crtc_vblank_put() be called on these error paths before jumping =
to
cleanup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-265-sashal@kernel.org?part=3D1

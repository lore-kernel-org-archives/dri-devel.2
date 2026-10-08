Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F39CA600E
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 07:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A98F610FCC3;
	Thu,  8 Oct 2026 07:38:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ELEynV8v";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12A7F10FCC3
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 07:38:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 68B456025A;
 Thu,  8 Oct 2026 07:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFF01F00893;
 Thu,  8 Oct 2026 07:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791445118;
 bh=OeGWmsd1zkwW2li9C1wPCg8/T3CMhCzW8z90h+6vsYs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ELEynV8v1gO6bH9uXfwAjZEoAZxLm9R0vc52HDcaniqSv5kQeex2XT16Rvzk4yzgV
 8aKoKebPfAbi1TxW/3q9dCjeqX495pIuDR1Tqb6yqB0F+ZFSMSec6vxug6xN7KTWkL
 IrCainOeRUBKShx9pEOBg9i6thaXSJTTeSNdQDHDERH10pn3OU7HtK5b2WUAmtfE1r
 1ZIdKsi9Yj/H7PHO/IMJ4cj0yDgZI/uc8MKLmoQ5NAyETeVR1YXp9epkkalhIklWQA
 MtCaUikKqyMUjKV/hzE1FXMxLUWxUumuBWJVVh0S7ccw7CgDXuYKpu5kXTLBS39UkM
 evxafaseWXPcQ==
Message-ID: <sashiko-outbox-163773@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: Don't ignore dc_commit_streams() failures
To: 2564278112@qq.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <tencent_34284E790157CA20C27C9260A7A32C08C10A@qq.com>
References: <20261008071700.552056-1-2564278112@qq.com>
 <tencent_34284E790157CA20C27C9260A7A32C08C10A@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 07:38:37 +0000
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
- [High] drm/amd: incomplete fix, plane programming still executes after co=
mmit failure
- [Medium] drm/amd/display: hdmi_frl_status_polling_work leaks on commit fa=
ilure
--

commit 5df85d959754dc46c8ae54787ba1fc6639162940
Author: Wang Jiang <jiangwang@kylinos.cn>

drm/amd/display: Don't ignore dc_commit_streams() failures

This patch modifies the AMD DRM driver to stop ignoring failures from
dc_commit_streams(). It logs the failure and adds an early return in
amdgpu_dm_commit_streams() to avoid programming plane state against a
half-committed stream list. It also logs failures in the reset recovery
path in dm_resume().

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

[ ... ]

> @@ -4735,7 +4740,18 @@ static void amdgpu_dm_commit_streams(struct drm_at=
omic_commit *state,
>  	dm_enable_per_frame_crtc_master_sync(dc_state);
>  	mutex_lock(&dm->dc_lock);
>  	dc_exit_ips_for_hw_access(dm->dc);
> -	WARN_ON(!dc_commit_streams(dm->dc, &params));
> +	if (dc_commit_streams(dm->dc, &params) !=3D DC_OK) {
> +		mutex_unlock(&dm->dc_lock);
> +		/*
> +		 * DC refused the stream list, so the hardware and the DC state
> +		 * no longer agree. Bail out instead of programming more
> +		 * stream/plane state for a half committed stream list (this
> +		 * used to be a silently ignored WARN_ON()).
> +		 */
> +		drm_err(dev, "DC failed to commit %u stream(s)\n",
> +			(unsigned int)params.stream_count);
> +		return;

[Severity: High]
Will this early return successfully stop the plane programming?

Since amdgpu_dm_commit_streams() returns void, it cannot propagate this
failure state back to its caller. Looking at the caller
amdgpu_dm_atomic_commit_tail():

amdgpu_dm_atomic_commit_tail() {
        ...
        if (dm_state && dm_state->context) {
                dc_state =3D dm_state->context;
                amdgpu_dm_commit_streams(state, dc_state);
        }
        ...
        if (dm_new_crtc_state->stream)
                amdgpu_dm_commit_planes(state, dev, dm, crtc, wait_for_vbla=
nk);
}

Because the tail continues unconditionally, won't it still program the
planes against the rejected stream list, resulting in the exact crash
this patch intended to prevent?

[Severity: Medium]
Does this early return cause the HDMI FRL status polling work to leak?

By returning early, we bypass the subsequent block that manages the FRL
polling work:

        if (frl_stream_found) {
                queue_delayed_work(...)
        } else {
                if (cancel_delayed_work_sync(&dm->hdmi_frl_status_polling_w=
ork))
                        ...
        }

Looking at hdmi_frl_status_polling_work(), the handler unconditionally
re-arms itself by calling queue_delayed_work() at the end of its execution.
If we fail the stream commit and return early, doesn't it leave the delayed
work to run and wake up the CPU indefinitely on a recoverable failure path?

> +	}
> =20
>  	bool frl_stream_found =3D false;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_34284E79015=
7CA20C27C9260A7A32C08C10A@qq.com?part=3D1

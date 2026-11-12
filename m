Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572A2606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 01:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RoLxI3y8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7751910FF08;
	Thu, 12 Nov 2026 01:53:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1972B10FF0C;
 Thu, 12 Nov 2026 01:53:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 20596633B8;
 Thu, 12 Nov 2026 01:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986041F00A05;
 Thu, 12 Nov 2026 01:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794448402;
 bh=GndhRdciArYI+AosN7OIgtm7wRWaamSCGNrCorFkQaY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RoLxI3y8jYBE2cV6TkUDV15cF99GRSsw3vr/aKx8nBdG8oXj6PSwYuKwz3HrAMwl7
 W/DwE0ZQZycgy6BYDHan/ay+Y5vvicmY9ImizCo878mgdYI+r1HFcdQbjqhjEQ2dsQ
 HDppvfO/u5m9ktiyiQ0fP+PF+5epKwTSu2tnKL3Cjv/VL0Bqgys76plO8J/vIv3nms
 UIWpnMrvjHFQZnTihZWSA8X2Ugz+3B8kPxhxCHOuMETsfovS4AO+2i1Ob8dxA0usge
 GCm6IH+15Xe3YimlJUrLqJlADN4AIeYLji+t8brY7WJlI9p0dueLO8bkUTrBeUSZ8O
 1MRh9ip8HI25Q==
Message-ID: <sashiko-outbox-210110@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/19] drm/amd/display/amdgpu_dm: Use DC accessors in
 debugfs paths
To: "Dave Airlie" <airlied@redhat.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-amdgpu-dc-cleanup-v1-9-0fae41718ad2@redhat.com>
References: <20261112-amdgpu-dc-cleanup-v1-0-0fae41718ad2@redhat.com>
 <20261112-amdgpu-dc-cleanup-v1-9-0fae41718ad2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:53:22 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] drm/amd/display: use-after-free in dp_dsc_clock_en_write()
  [1]
--

commit 8d9d786f748dd7764b2335ea8779ba852b1d97b2
Author: Dave Airlie <airlied@redhat.com>

drm/amd/display/amdgpu_dm: Use DC accessors in debugfs paths

This commit replaces direct struct dc member dereferences in
amdgpu_dm_debugfs.c with DC accessor functions and adds a setter for the
eDP hotplug detection mode.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 68356cb8e4dec..fddb47a32fb9e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
[ ... ]
> @@ -1696,7 +1696,7 @@ static ssize_t dp_dsc_clock_en_write(struct file *f=
, const char __user *buf,
>  	}
> =20
>  	for (i =3D 0; i < MAX_PIPES; i++) {
> -		pipe_ctx =3D &aconnector->dc_link->dc->current_state->res_ctx.pipe_ctx=
[i];
> +		pipe_ctx =3D &dc_get_current_state(aconnector->dc_link->dc)->res_ctx.p=
ipe_ctx[i];
>  		if (pipe_ctx->stream &&
>  		    pipe_ctx->stream->link =3D=3D aconnector->dc_link &&
>  		    pipe_ctx->stream->sink &&

[Severity: Critical]
This problem wasn't introduced by this patch, but can a concurrent atomic
commit free current_state while dp_dsc_clock_en_write() iterates over
res_ctx.pipe_ctx[] [1]?

dp_dsc_clock_en_write() walks dc_get_current_state()->res_ctx.pipe_ctx[]
before taking dev->mode_config.mutex and dev->mode_config.connection_mutex:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c:dp_dsc_clock_en_w=
rite() {
	...
	for (i =3D 0; i < MAX_PIPES; i++) {
		pipe_ctx =3D &dc_get_current_state(aconnector->dc_link->dc)->res_ctx.pipe=
_ctx[i];
		if (pipe_ctx->stream &&
		    ...
			break;
	}

	if (!pipe_ctx->stream)
		goto done;

	// Get CRTC state
	mutex_lock(&dev->mode_config.mutex);
	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
	...
}

CPU0                                  CPU1
dp_dsc_clock_en_write()
  state =3D dc_get_current_state(dc)
                                      amdgpu_dm_atomic_commit_tail()
                                        ...
                                        dc_state_release(old_state)
  pipe_ctx =3D &state->res_ctx.pipe_ctx[i]
  if (pipe_ctx->stream && ...)        <-- use-after-free

If an atomic modeset commit swaps out and frees current_state during the
unlocked loop, dp_dsc_clock_en_write() dereferences freed memory.

[1] https://sashiko.dev/#/bug/linux-3a852cda-9b25-49c2-b119-47f2a71a94c3

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-amdgpu-dc-=
cleanup-v1-0-0fae41718ad2@redhat.com?part=3D9

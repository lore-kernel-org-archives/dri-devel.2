Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953BDCD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0038810E71F;
	Mon, 15 Jun 2026 20:44:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gp/DSWBY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B087310E716
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:44:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 15FFB6008A;
 Mon, 15 Jun 2026 20:44:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954891F00A3F;
 Mon, 15 Jun 2026 20:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781556243;
 bh=MhNT7FWZo/ZNSBplDIb/oubjlX1BmF9brGYTvfCF6tE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gp/DSWBY+JIxr/k2lfUn2MvScvrehTCy1DLpOy6v5BlzoQd+mSar9sSznGRU7289N
 BFu5Bt7YZpuaJdY4mwp9l1V2sySIQzRmk1lDgK0MqGgQrSY9ylg33lPuOIvBuSh/+k
 1I92nSTgyrM/fZ5zgvt8DmUOEp3Wmr1LAyR8dJCuPQdPWMYOPhuhBjdWX4F6eBMgY0
 Dx0YTXMWdKKieZWLKi1WW3VarnRA15FMH1tIsQ376bGoQF2xsDYpzPbfDcyxpPXSc/
 kuHk6zR6RyPrW5vql3taF0aXGDLhCvozQsfKwPRBCoBvYUJAoBxFPNEjSw7JVXoTCl
 w4GuYP5/wTLlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/27] drm/i915/display: Make set_pipeconf use the fw
 variants
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615201846.307297-15-dev@lankhorst.se>
References: <20260615201846.307297-15-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:44:03 +0000
Message-Id: <20260615204403.954891F00A3F@smtp.kernel.org>
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
- [High] Incomplete migration to _fw register access variants in VRR handli=
ng causes 'sleeping in atomic context' BUG on PREEMPT_RT.
--

commit 3e8bb0c4e5f9821d1b47fa3563431c605e96b128
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/i915/display: Make set_pipeconf use the fw variants

The calls are used inside the critical section when updating
the gamma mode, and thus should use the _fw variants to prevent
locks.

> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/d=
rm/i915/display/intel_display.c
> index 2e3ade44f28ee..03b15765843a0 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c

[ ... ]

> @@ -3042,8 +3042,9 @@ void i9xx_set_pipeconf(const struct intel_crtc_stat=
e *crtc_state)
> =20
>  	val |=3D TRANSCONF_FRAME_START_DELAY(crtc_state->framestart_delay - 1);
> =20
> -	intel_de_write(display, TRANSCONF(display, cpu_transcoder), val);
> -	intel_de_posting_read(display, TRANSCONF(display, cpu_transcoder));
> +	intel_de_write_fw(display, TRANSCONF(display, cpu_transcoder), val);
> +	/* posting read */
> +	intel_de_read_fw(display, TRANSCONF(display, cpu_transcoder));
>  }

[Severity: High]
This is a pre-existing issue, but since the goal is to prevent sleeping
in atomic context on PREEMPT_RT during the vblank evasion section, are
there other register accesses in this path that need the fw variants?

Several VRR functions still use the sleepable non-fw register access
variants inside the atomic section where local IRQs are disabled:

1. intel_vrr_set_vrr_timings() and intel_vrr_enable_dc_balancing() use
intel_de_write() and intel_de_read() and are called from
intel_vrr_enable(), which executes via commit_pipe_post_planes().

2. intel_vrr_set_transcoder_timings() uses intel_de_write() and executes
via commit_pipe_pre_planes() -> intel_pipe_fastset().

For example, in drivers/gpu/drm/i915/display/intel_vrr.c:

intel_vrr_set_vrr_timings() {
        ...
        intel_de_write(display, TRANS_VRR_VMIN(display, cpu_transcoder),
                       intel_vrr_hw_vmin(crtc_state) - 1);
        ...
}

Could these non-fw accesses trigger the same PREEMPT_RT splat?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615201846.3072=
97-1-dev@lankhorst.se?part=3D14

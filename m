Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A213CD98CE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B10C410E6D7;
	Mon, 15 Jun 2026 20:36:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SASiddld";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88DA710E6D8
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:36:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4EB5643E5D;
 Mon, 15 Jun 2026 20:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153BF1F00A3A;
 Mon, 15 Jun 2026 20:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781555772;
 bh=gO4RSWeOTpWWxo8ek3TpDWL4Yw9mB4qdV5nUr6rfcmE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SASiddld2sqTaTEDgpKemALi0orUjhOoND8TYSQyIZXf8XXfzHjUhI/ZAbRYC6qES
 ZOQRatR9eMYH4rJHr2hzpCDytZ3LuGLLu/KacSQRuNXnmIVJawM6satYUVadIJdVGG
 9RrbPz2PuXKNNj5P9b3WRG4iNbnYEEuuUSys1Mk63lf/k7bjvJ9PCM/KztblDiKsay
 NzZTWN5TvE32UUJHc2mcNsTb6bc+g9C7EKwEwfrXLIC2WCL0lu+h/jTBj+Zq36xeZg
 NB928RC/vPwDFuLffWk1BOgXk1PBItaZ1OaNScSxeo16Ogd2OfEHXo1roMK97D5eqy
 x3vNUXX+PNfAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 20/27] drm/i915/display: Remove uncore lock from
 vlv_atomic_update_fifo
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615201846.307297-21-dev@lankhorst.se>
References: <20260615201846.307297-21-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:36:11 +0000
Message-Id: <20260615203612.153BF1F00A3A@smtp.kernel.org>
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
- [High] Removing the `uncore->lock` in `vlv_atomic_update_fifo` introduces=
 a data race on the shared `DSPARB` registers and permits unlocked concurre=
nt MMIO accesses, leading to corrupted hardware FIFO state and potential ha=
rdware crashes.
--

commit a9d530199c31de5dd37f0bfe14d6b4c1885aebb4
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/i915/display: Remove uncore lock from vlv_atomic_update_fifo

This commit removes the uncore lock from vlv_atomic_update_fifo(), with
the assumption that disabling interrupts via intel_pipe_update_start()
is sufficient for synchronization.

> diff --git a/drivers/gpu/drm/i915/display/i9xx_wm.c b/drivers/gpu/drm/i91=
5/display/i9xx_wm.c
> --- a/drivers/gpu/drm/i915/display/i9xx_wm.c
> +++ b/drivers/gpu/drm/i915/display/i9xx_wm.c

[ ... ]

> @@ -1892,7 +1891,6 @@ static void vlv_atomic_update_fifo(struct intel_ato=
mic_state *state,
>  	 * intel_pipe_update_start() has already disabled interrupts
>  	 * for us, so a plain spin_lock() is sufficient here.
>  	 */
> -	spin_lock(&uncore->lock);
> =20
>  	switch (crtc->pipe) {
>  	case PIPE_A:

[Severity: High]
Will removing the uncore lock here introduce a data race on the shared
DSPARB registers during concurrent updates?

While intel_pipe_update_start() disables local CPU interrupts to prevent
local preemption, non-blocking atomic commits for disjoint sets of CRTCs
can execute concurrently on different CPUs.

If two CPUs commit updates for PIPE_A and PIPE_B simultaneously, could
both CPUs read the same DSPARB register value using the unlocked
intel_de_read_fw() accessors?

For example, this sequence might occur:

CPU1 (updating PIPE_A):
    dsparb =3D intel_de_read_fw(display, DSPARB(display));

CPU2 (updating PIPE_B):
    dsparb =3D intel_de_read_fw(display, DSPARB(display));

When both CPUs modify their respective bits and write the value back, one
CPU could overwrite the other's modifications. This would silently erase
the FIFO split configuration for the other pipe and corrupt the hardware
FIFO state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615201846.3072=
97-1-dev@lankhorst.se?part=3D20

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CD1CD98E0
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82F5510E6C1;
	Mon, 15 Jun 2026 20:35:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SzP8F1cW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6D2810E6C7
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 20:35:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B891601E6;
 Mon, 15 Jun 2026 20:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BD01F000E9;
 Mon, 15 Jun 2026 20:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781555751;
 bh=7+5DW8BC8ug886zLXYqpysm9ImrcnUAoIhMhY9hsabw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SzP8F1cWrHPDRiEaY3vfl9iPvw9nat1vPk+EJ3Iqr2cuAMWK6peMsfapFsOQNDLLa
 kOGjzD7FmCPgDEujgzOfGWrjlmV43wk8sdd9KcCgnYI4PCYT8sxEv25h+HO7m/6lT0
 t3K5edAMdEaUGI03riHW8QxMrhOhSuP5BzlBSTERQsss95LY3eMBS27CqRplUNhdBl
 v3AJib46eEd8jp7LrlRpoFYRC6XntvDIpm/84mjKf/b+hp6XMupQUCxtrhtxCg5Rss
 rPZkAiO8UNmBOyRieXPKpist2b9cGapgF/L9grMVq47s5M86N0K4LAjo7Bbb0nhwgK
 mBB2EtIUoFrXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/27] drm/i915/display: Do not take uncore lock in
 i915_get_vblank_counter
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615201846.307297-11-dev@lankhorst.se>
References: <20260615201846.307297-11-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 20:35:50 +0000
Message-Id: <20260615203550.E2BD01F000E9@smtp.kernel.org>
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
- [Low] The inline function `intel_de_read64_2x32_volatile` is now dead cod=
e and should be removed.
--

commit f923f01143a0bb2e1cfb7485bff2c091423e5711
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/i915/display: Do not take uncore lock in i915_get_vblank_counter

This commit prevents taking the uncore and DMC locks repeatedly in a
timing-sensitive path with interrupts disabled. It replaces the volatile
read variant with a new forcewake read variant in the vblank counter code.

> diff --git a/drivers/gpu/drm/i915/display/intel_vblank.c b/drivers/gpu/dr=
m/i915/display/intel_vblank.c
> index c0cc0a4c25dbe..5ca22899055d7 100644
> --- a/drivers/gpu/drm/i915/display/intel_vblank.c
> +++ b/drivers/gpu/drm/i915/display/intel_vblank.c
> @@ -109,8 +109,8 @@ u32 i915_get_vblank_counter(struct drm_crtc *crtc)
>  	 * we get a low value that's stable across two reads of the high
>  	 * register.
>  	 */
> -	frame =3D intel_de_read64_2x32_volatile(display, PIPEFRAMEPIXEL(display=
, pipe),
> -					      PIPEFRAME(display, pipe));
> +	frame =3D intel_de_read64_2x32_fw(display, PIPEFRAMEPIXEL(display, pipe=
),
> +				        PIPEFRAME(display, pipe));

[Severity: Low]
Since this patch updates the only caller of intel_de_read64_2x32_volatile()
in i915_get_vblank_counter() to use the new intel_de_read64_2x32_fw()=20
variant instead, does intel_de_read64_2x32_volatile() become dead code?

If so, should it be completely removed from=20
drivers/gpu/drm/i915/display/intel_de.h to clean up unused functions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615201846.3072=
97-1-dev@lankhorst.se?part=3D10

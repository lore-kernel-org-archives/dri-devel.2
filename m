Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5592C5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:00:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B644610E30E;
	Fri, 21 Aug 2026 15:00:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G8C5OBhg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2351210E30E
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:00:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C347343671
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD231F000E9;
 Fri, 21 Aug 2026 15:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787324420;
 bh=Mx7o0pxh1N8DIFo6t/yMJED3R6/L2vgYy1tRfCxz1po=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G8C5OBhgfMi+BhPZBv4Z3HLA81ja1DFivbC00tg38eAsOz5F/j8bxJLWBbLjvwCQ7
 wHTow39qFgMa5NhzmzeDmRfkJNU0eaHX2dWGulBmIcrPDBS9Ns1/2Jp69jpTGe7D/l
 FiZhqWX65BIDExc3mw5bmFNRVH2JL5icwhTc8ED+RTWGGZuv5n/KomME1HRfOt5MdI
 qlKqX/2kXyXywIuq1A0nMRXFaueMQfUDySoP6aVFp2yHC119bcXLlWbUupZp7+hKS4
 +UavR1aEZ26E0L+/H44fvfnJJO9+jCrOF8IMxamkqN6gxe91A27+G4dty9zZNZs98m
 o1LpcbNBgFAmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/70] drm/imx: dc: Switch to
 drm_atomic_helper_crtc_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-11-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-11-fb793475c05a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 15:00:19 +0000
Message-Id: <20260821150020.6FD231F000E9@smtp.kernel.org>
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
- [High] CRTC atomic callbacks call sleeping functions in atomic context.
--

--- Patch [11]: [PATCH 11/70] drm/imx: dc: Switch to drm_atomic_helper_crtc=
_create_state ---
commit 81ac70d774e55256bc7f69e9538e45aed1e198c8
Author: Maxime Ripard <mripard@kernel.org>

drm/imx: dc: Switch to drm_atomic_helper_crtc_create_state

The imx dc crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook. Switch to
drm_atomic_helper_crtc_create_state() instead.

> diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc=
-crtc.c
> index 764510ff90a4a..0d64186a99018 100644
> --- a/drivers/gpu/drm/imx/dc/dc-crtc.c
> +++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
> @@ -98,7 +98,7 @@ static void dc_crtc_disable_vblank(struct drm_crtc *crt=
c)
>  }
> =20
>  static const struct drm_crtc_funcs dc_crtc_funcs =3D {
> -	.reset			=3D drm_atomic_helper_crtc_reset,
> +	.atomic_create_state =3D drm_atomic_helper_crtc_create_state,

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the CRTC
implementation in this file, I noticed that several atomic callbacks might =
be
calling sleeping functions.

For example, does dc_crtc_atomic_enable() call pm_runtime_resume_and_get(),
which can sleep?

Additionally, it looks like dc_crtc_atomic_enable(), dc_crtc_atomic_flush(),
and dc_crtc_atomic_disable() all use DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(),
which waits for a completion and puts the task to sleep.

According to DRM subsystem guidelines, CRTC atomic enable, disable, and upd=
ate
callbacks run in an atomic context where sleeping is forbidden. Could this
cause scheduling while atomic panics or warnings during non-blocking commits
and page flips?

>  	.destroy		=3D drm_crtc_cleanup,
>  	.set_config		=3D drm_atomic_helper_set_config,
>  	.page_flip		=3D drm_atomic_helper_page_flip,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-drm-no-mor=
e-crtc-reset-v1-0-fb793475c05a@kernel.org?part=3D11

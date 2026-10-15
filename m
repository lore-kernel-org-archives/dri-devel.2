Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF85CC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EA9810E068;
	Thu, 15 Oct 2026 15:33:16 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3C4710E068
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:33:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EBB9960120
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BBC1F000C4;
 Thu, 15 Oct 2026 15:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792078388;
 bh=Tp8egbLFhqxkcxPbV2+/hr6eB3yfF7lCoDDU4cw0jg8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BkpoDU2CFiEzs5/OHHBNZKSE7g5/BjPFc7M2mPyWY0Dux4fUT5JO+Cue2Fk9cxAMJ
 q7iqN9au9advVOwkru5JBaZ+85cxn9cu5oxplKSNjm95HzXSiyIs2wPVsiRAcnRQRa
 QXt0Cb+sTvSjyC7bR6Amo3Po7UMtB0imX1rlCeuHFkTpBrurAIyPRC51rx6VTIspA3
 uCTvErpU5T9+9GrAeB9qBSec7246/Ub4AIyux8i49DchhP3U0TfHmtWQbhDNzYcd90
 tf7O2VM8Jsa+dqwoEzXY+aa+CFW6+4FJuxwCvjtm8XF4PualHMiZHegewGJKMNvCCk
 VFyj9ml4HyzOg==
Message-ID: <sashiko-outbox-173077@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/28] drm/atomic: Export drm_atomic_*_print_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-drm-state-readout-v6-5-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-5-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:33:08 +0000
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
- [Low] drm: missing forward declaration for struct drm_connector_state
--

commit a718c67acdeea45641698c75babcb127ecc60810
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic: Export drm_atomic_*_print_state

This commit exports four DRM atomic print state functions by removing their=
 static
qualifiers and declaring them in drm_internal.h. This allows the SRO infras=
tructure
to call them for debugging purposes.

[ ... ]

> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_interna=
l.h
> index f893b1e3a596e..91ce23f69ec48 100644
> --- a/drivers/gpu/drm/drm_internal.h
> +++ b/drivers/gpu/drm/drm_internal.h
> @@ -40,14 +40,26 @@ struct dma_buf;
>  struct iosys_map;
>  struct drm_connector;
>  struct drm_crtc;
> +struct drm_crtc_state;
>  struct drm_framebuffer;
>  struct drm_gem_object;
>  struct drm_master;
>  struct drm_minor;
> +struct drm_plane_state;
>  struct drm_prime_file_private;
>  struct drm_printer;
> +struct drm_private_state;

[Severity: Low]
Does this file also need a forward declaration for struct drm_connector_sta=
te?
Without it, the struct is scoped only to the prototype below, which might c=
ause
build warnings for any C file that includes this header without previously
declaring or defining it.

>  struct drm_vblank_crtc;
> =20
> +/* drm_atomic.c */
> +void drm_atomic_plane_print_state(struct drm_printer *p,
> +				  const struct drm_plane_state *state);
> +void drm_atomic_crtc_print_state(struct drm_printer *p,
> +				 const struct drm_crtc_state *state);
> +void drm_atomic_connector_print_state(struct drm_printer *p,
> +				      const struct drm_connector_state *state);
> +void drm_atomic_private_obj_print_state(struct drm_printer *p,
> +					const struct drm_private_state *state);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-drm-state-=
readout-v6-0-6cc02cd10998@kernel.org?part=3D5

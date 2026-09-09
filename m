Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAC9C79F82
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 02:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E72110EE4F;
	Wed,  9 Sep 2026 02:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RTKjTrWs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1E6610EE4D
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 02:19:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 96D6F601FD;
 Wed,  9 Sep 2026 02:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B371F00A3A;
 Wed,  9 Sep 2026 02:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788920353;
 bh=Ez64Z86ULaHAnFefjF0WYGE/Wle6faOhVfBbxtMpQws=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RTKjTrWsWRKO2OKA4vgWeAQMBMEKinqGcITxI3aepdPJCE+gRTv6UN/Ady/PxeMiA
 tfB5ny21/TSUuZJ6wCfyLfYUFc2kDj3DXZufUL1NrF3oMVAIVia7JAzj36xVcEg/9R
 ZUlArqs/HoB585CFhH/BSSeFWiWyvpN0s+85sgNIODHCK1NAaCqFZnOd3lWobx7c/v
 MML7zLxum2bBIJg/F4zppQgk/o8Z0dmesMrL7yzAdj0hljjUpcpRrZ4kH267fnPryK
 jUq0RfzQu/BkVWd5NA7JAQ0hWK7iyKK2iCCotjEtFPzBbaDGz2+rRA80KEo8dwE/mD
 sZqKHoOautqpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vkms: Skip pre_blend_color_transform when pipeline
 is all bypassed
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260909021028.105837-1-oushixiong1025@163.com>
References: <20260909021028.105837-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 02:19:12 +0000
Message-Id: <20260909021913.30B371F00A3A@smtp.kernel.org>
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
- [High] VKMS composer accesses global colorop->state directly without shad=
owing it during atomic commit, leading to a data race and potential Use-Aft=
er-Free.
--

commit 7feb24a5b3e1c9cb2aa23694b44e46aece887a34
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/vkms: Skip pre_blend_color_transform when pipeline is all bypassed

This patch adds an optimization to pre_blend_color_transform() to skip
the entire pixel processing loop when all colorops in the pipeline are
bypassed or the pipeline is empty.

> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/=
vkms_composer.c
> index 83d217085ad09..18f58569f0169 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -190,13 +190,29 @@ static void apply_colorop(struct pixel_argb_s32 *pi=
xel, struct drm_colorop *colo
>  	}
>  }
> =20
> +static bool pipeline_all_bypassed(struct drm_colorop *colorop)
> +{
> +	while (colorop) {
> +		struct drm_colorop_state *colorop_state =3D colorop->state;

[Severity: High]
This is a pre-existing issue, but does this direct access to colorop->state
introduce a potential data race and use-after-free?

The VKMS composer processes frames asynchronously in a workqueue
(vkms_composer_worker). While plane states are properly duplicated and
shadowed, reading the global colorop->state pointer directly here in
pipeline_all_bypassed() within drivers/gpu/drm/vkms/vkms_composer.c seems
unsafe.

If a non-blocking atomic commit swaps the state via
drm_atomic_helper_swap_state() and frees the old state via
drm_atomic_state_put() while the composer worker is preempted, will the
worker dereference a freed state pointer when it resumes? Local userspace
with DRM master privileges could potentially trigger this by submitting rap=
id
non-blocking atomic commits that modify the color pipeline while the virtual
hardware is compositing frames.

This same unsafe access pattern already exists in the inner loop of
pre_blend_color_transform(), but this patch expands the pattern into the new
pipeline_all_bypassed() function. Should the colorop state be properly
shadowed for the atomic commit instead of being read globally?

> +
> +		if (!colorop_state || !colorop_state->bypass)
> +			return false;
> +		colorop =3D colorop->next;
> +	}
> +	return true;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909021028.1058=
37-1-oushixiong1025@163.com?part=3D1

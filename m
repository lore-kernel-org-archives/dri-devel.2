Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F8DC5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9B9D10E316;
	Fri, 21 Aug 2026 15:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JvVLrvJq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86FAD10E316
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:36:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5234541FD8
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091971F000E9;
 Fri, 21 Aug 2026 15:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787326591;
 bh=Tt6CdkUcL+I8hq6sDky958PN3WErFFP6wb2N88z7hKo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JvVLrvJq7D6JJV6bMbsHFV5srF3+v202VPfFPzg/UOeQdqXa+8AZXYeCnt3k6SitP
 vPhC+AFedYFEIVhuTyl4KAfdOGSlJyOSTkYNr/C5M0phHcNZtYvhJB7ClZJtEaLct4
 a9gQu0T3Hu/YG8kQ+ZqbSXG4LqNX8grlPMxK3A9VIPiMD55+O7C+9duuwLrffET4VD
 8p0j3et7Cs4H8Y9RjnfFXD20NzuoevqapHWJSOcFJpLcosT76IuHYQIZIb17TurbrA
 tbMwY8OMCYeeaf7BTZGGq8hpqaFJGQX9dI2hOTgptQyNaINgNW4iXuWTVlX9zmrn9w
 rAhEVtbhgP3wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 50/70] drm/loongsoon: Move hardware reset to CRTC creation
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-50-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-50-fb793475c05a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 15:36:30 +0000
Message-Id: <20260821153631.091971F000E9@smtp.kernel.org>
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
- [High] Broken S3 Resume due to missing CRTC hardware reset
--

--- Patch [50]: [PATCH 50/70] drm/loongsoon: Move hardware reset to CRTC cr=
eation ---
commit 841a0290c125afb8611341788938204f1fca139c
Author: Maxime Ripard <mripard@kernel.org>
drm/loongsoon: Move hardware reset to CRTC creation

This commit moves the hardware-level CRTC reset out of the atomic reset
hook and into the CRTC initialization functions.

> diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c b/drivers/gpu/drm/loong=
son/lsdc_crtc.c
> --- a/drivers/gpu/drm/loongson/lsdc_crtc.c
> +++ b/drivers/gpu/drm/loongson/lsdc_crtc.c
> @@ -403,9 +401,6 @@ static void lsdc_crtc_reset(struct drm_crtc *crtc)
>  		__drm_atomic_helper_crtc_reset(crtc, NULL);
>  	else
>  		__drm_atomic_helper_crtc_reset(crtc, &priv_crtc_state->base);
> -
> -	/* Reset the CRTC hardware, this is required for S3 support */
> -	ops->reset(lcrtc);
>  }

[Severity: High]
Since drm_mode_config_reset() is typically called via drm_atomic_helper_res=
ume()
during system resume, does removing the hardware reset from this hook preve=
nt
the CRTC from being correctly reinitialized after waking from sleep?

[ ... ]

> @@ -983,6 +978,9 @@ int ls7a1000_crtc_init(struct drm_device *ddev,
> =20
>  	drm_crtc_enable_color_mgmt(crtc, 0, false, 256);
> =20
> +	/* Reset the CRTC hardware, this is required for S3 support */
> +	lcrtc->hw_ops->reset(lcrtc);
> +
>  	return 0;
>  }

[Severity: High]
The comment explicitly notes this reset is required for S3 support, but
ls7a1000_crtc_init() only executes during device probe.

During S3 resume, the hardware registers will likely contain garbage values=
. If
the hardware reset is no longer called during resume, and the atomic commit
path merely performs a read-modify-write to enable the output, won't this
preserve those garbage bits and cause the display hardware to hang or fail
to resume?

(The same question applies to the identical change in ls7a2000_crtc_init be=
low).

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-drm-no-mor=
e-crtc-reset-v1-0-fb793475c05a@kernel.org?part=3D50

Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14473C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:13:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1098B10E606;
	Mon, 31 Aug 2026 20:13:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f5Rp+zMI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B75710E606
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 20:13:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4C058601DE
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 20:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB831F000E9;
 Mon, 31 Aug 2026 20:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788207191;
 bh=2gR6mOTmf9xb5/qXmM98FhAHOrTmAqKvJc/Hp4X0vL4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f5Rp+zMI7pA7/ToKrMdXdTj3KSsJRkAMXvlTbJD4VllAnIpsiTX+g4xvdyDoc6tdm
 9a2L/JUuhSTSGPeV9S7YXs/MF/Z4vtJ1O4QCsH46ol0TEwXb9nZROXpcd/EG+UuCCz
 6Yjnp/E8MUo6sqKtQkQTRwLVHxUeHUWzIkMYMedXLKB6cICmMDgRCmVvLRGWqrWKku
 h6XsuJieIE3jNAr5geWtqz0ON48ugbe6V8+yOmlHhNB5aDyevWHgMtYKCvK6vm3bS8
 YjHwSArEZjRrumlaXNSFgnmn6mNIszAkjqPGc/ydl1/+9K7lGfov7H9Ph1MoDivzJD
 KIz/FpJmlytyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/13] drm/loongson: Move hardware reset to CRTC
 creation
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-drm-no-more-crtc-reset-v2-8-4500d49a337f@kernel.org>
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
 <20260831-drm-no-more-crtc-reset-v2-8-4500d49a337f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:13:10 +0000
Message-Id: <20260831201310.CCB831F000E9@smtp.kernel.org>
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
- [High] `lsdc_crtc1_soft_reset` calls `msleep(20)`, which can sleep, but i=
t is reachable from the CRTC atomic enable callback (`lsdc_crtc_atomic_enab=
le`), which runs in atomic context.
--

commit 4cb085e0fbbbf2cb0c2550f2c69cc0175ba5ecf8
Author: Maxime Ripard <mripard@kernel.org>

drm/loongson: Move hardware reset to CRTC creation

This patch moves the hardware-level CRTC reset from the atomic state
initialization hook to the CRTC creation path. It adds a new hw_reset
callback to handle the register writes independently.

> diff --git a/drivers/gpu/drm/loongson/lsdc_crtc.c b/drivers/gpu/drm/loong=
son/lsdc_crtc.c
> index 16b8f36a40710..7cca574e3b6af 100644
> --- a/drivers/gpu/drm/loongson/lsdc_crtc.c
> +++ b/drivers/gpu/drm/loongson/lsdc_crtc.c

[ ... ]

> @@ -937,6 +932,15 @@ static bool lsdc_crtc_get_scanout_position(struct dr=
m_crtc *crtc,
>  	return true;
>  }
> =20
> +static void lsdc_crtc_hw_reset(struct drm_crtc *crtc)
> +{
> +	struct lsdc_crtc *lcrtc =3D to_lsdc_crtc(crtc);
> +
> +	/* Reset the CRTC hardware, this is required for S3 support */
> +	if (lcrtc->hw_ops->reset)
> +		lcrtc->hw_ops->reset(lcrtc);
> +}
> +

While reviewing the hardware reset paths in this file, I noticed a pre-exis=
ting
issue nearby:

drivers/gpu/drm/loongson/lsdc_crtc.c:
> static void lsdc_crtc1_soft_reset(struct lsdc_crtc *lcrtc)
> {
[ ... ]
> 	/* Wait about a vblank time */
> 	msleep(20);
> }

[Severity: High]
This isn't a bug introduced by this patch, but can this msleep() be called
during atomic context?

The DRM core calls the CRTC .atomic_enable callback, which executes in atom=
ic
context:

lsdc_crtc_atomic_enable()
  lcrtc->hw_ops->enable(lcrtc) // resolves to lsdc_crtc1_enable()

If a hardware stall is detected, it attempts error recovery:

lsdc_crtc1_enable() {
    ...
    if (val & CRTC_ANCHORED) {
        drm_warn(&ldev->base, "%s stall\n", lcrtc->base.name);
        return lsdc_crtc1_soft_reset(lcrtc);
    }
}

This calls lsdc_crtc1_soft_reset(), which erroneously calls msleep(20).

Sleeping in atomic context violates core kernel locking rules. This triggers
might_sleep() warnings and can lead to deadlocks or panics. (Note that
lsdc_crtc0_soft_reset() correctly uses mdelay(20) instead).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-drm-no-mor=
e-crtc-reset-v2-0-4500d49a337f@kernel.org?part=3D8

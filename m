Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B818CFF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 17:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 357C210E15E;
	Tue,  5 May 2026 17:20:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="gIigzI2A";
	dkim-atps=neutral
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6BF410E15E
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 17:20:47 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-7bdaa68cf81so12066317b3.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 10:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778001647; cv=none;
 d=google.com; s=arc-20240605;
 b=bnVtV9EdiZPV2nvbd5XkxNJh1uAetrfYbbmC3uAVY6hde87RL8LnI2Mx5PesicyXh2
 f1YzWAffQuB/Csb1kYYXN29r9UuJHAxc08gq8o+HRiizwupOwXct0GkA4jthdhgNpZyI
 raEVF86zSCsunKUocHC8x70/fhjUTSL5dwXCpbseBJ35PITkiTqVAUkmKPcci6lCFZNK
 eeTa56mq5wrBzeqDna95nfn1d/2Wn+sYUeGudl3XumAuxdxP6yfRlc3De8MTMwRTXqpS
 nIpmHgmxu7dWVO6mfNGuMaqF3tEyWhyg+g9N2xCCZ7t3BBrJ54a0TMayYAIzJNmpC7Zk
 74hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IDrgmH6xRo5URQMQTp4Z/sRYK/Fl7gxfls3HxVD+kBQ=;
 fh=c6JQ5PsQvZG5vaKTPRxoFuA9tMFcMpPrXus7+t6uzAQ=;
 b=IVarH+917VfsNN7dnOjhzwxp2Xz3qL4Wy0bZHdwquGPekLlhHi7rEUfvKoZ4L68Fi/
 Eb1PQ8a04VDVgAbkMN4KPs6lkztyhTEhVAazs0X3tzy96Gi082MNsvMk6wxH/nlPAgGp
 VmAy2I+gEbvcMq2Wav9IrPEY44usJkMlYRBBjspGyEfuVkJOZZ83o06ePSrhnEUYyUqi
 4b0StcobRXAVsiNxDM86s/pEPYKtMlWE+WvEuvDubCe2cF9a4Jh+m90skTzaK6SrPo/z
 qoPt4YngiJD/yfW04tguEAn+zXPKfRqjQC1PhByQE0eWCuhokMW20IVZXxG1qmAqd3GL
 j2aA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1778001647; x=1778606447;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IDrgmH6xRo5URQMQTp4Z/sRYK/Fl7gxfls3HxVD+kBQ=;
 b=gIigzI2AvEyuplzv6dkRGuw75rvTrDIrQT7Qs/d66mtJLkMSmt/CeaEfCMhx/o9rq+
 RCjcaYqW3W8+EmcQGl7qq5VQekH6iW/hsNFTudc18tv7P7FlKdMLVQ0IeeN0DmStEe+f
 a4Mr9HCEy7cH2+GqBQlm4YalGcNHMbVOjzynGd9SLSpSvxciFD4t8cUu+2QGQDG7xYzW
 LIzUkxSOVLjY5R56ZmpB6clZZWk9cv3y1yKJxWXkysBtzzUcquSkc4wTVnPLfuT2AgsE
 R2TtPTowD3kMqyR2YSitLRkVRcsdBPUbI6mUQrxMliCHfaytyfbqRs5ocdpEQVixVPNN
 WpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778001647; x=1778606447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IDrgmH6xRo5URQMQTp4Z/sRYK/Fl7gxfls3HxVD+kBQ=;
 b=P1iAG2SElT1/bzEdcj+wqeGym04y5SxjDM3by3ZJB/DepmzvqiD10T84LLtZLm9fKr
 ajcNQ565hIAU8AEIoJhsF/ZAyyGGOVo7ynCxZQpRKHRF7v4YnQ+zdKxtl/9OlrFfqs2B
 PV/bblsZC0l6MD9/xFEDAcKSifaMhExeQrbLvUBfdcvIuoP+IfSUouiJb1tCyAdlYadj
 /DSNafma03vKNSwIVc+i5HnYfzbtgJDwYXn+CAf3dOb+B3FsudGCEHntz1Hlui5Yk2Ld
 rvHP2oYE3+CN6WQw4QxpBWiv/xhSs76juP8X21tuDyXg2yV5unDHRQRLn44P+5zBwrX1
 esTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+W6DjvZNVHZtTcJ8q0xBhh3a5++Rgw8OP04iLzMNYLqkoUZznK2sN0b66/pQB11a61mmY2IYdUKiA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJ7oUPJ11IG9H8RZ4pWclD+maZzExT0pK42psdZ/JB01W7vWYp
 YkkB3cOWTwIQdmaYOyNebFz0SwcasTWFz610gPwSwY4wNevNk2WpmZTori2oF/Vq6QPhJHzpR/X
 qC5jXMjOxq2mYkSYQ9IIfQfldi93wEnz2hwCeNW4U5g==
X-Gm-Gg: AeBDietyETzHEi/nOWQkXRUtEIlFYMDf22Loya983wBMQXLZCqvJ0YjM8rYJn2atKrT
 qn8IA69j8z21UraOSbbcN3lDS7mLaMWOEs9b6ypoUxvQ3+as1NEmMCqiWGplV33pXhoOA1vCddB
 383fCaLAhup1+Il/V5r5xf6JQct5/hhxuazm+dpBupNTBdZHX91frd9R22fWqyoLLr0uL1mohP5
 5j4AbVmjvRW7dRxXGhSuAntNsRzwcUwXkQbRgLGCYEOA4QhPrCK9JmU++YOdoqWiZPRJUZfc2Wi
 BOGRBcRXoc1fbXqHIa0N/qVaTyYM6hYitfkapULuhadHtUY=
X-Received: by 2002:a05:690c:dd5:b0:7bd:4a12:f08c with SMTP id
 00721157ae682-7bdf5eeea18mr72427b3.39.1778001646685; Tue, 05 May 2026
 10:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260402015101.3328-1-zikken@xs4all.nl>
In-Reply-To: <20260402015101.3328-1-zikken@xs4all.nl>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 5 May 2026 18:20:29 +0100
X-Gm-Features: AVHnY4LpkmA9UneY6WOX8AV5cs7uRjhT6rd76M2GyJkOkNzQxaco2GXwH-US49c
Message-ID: <CAPY8ntAYnk_Wg0LPq75bwpDvBsRaAXAcr7wzA4OfGgiLHz3bVA@mail.gmail.com>
Subject: Re: [PATCH] drm/vc4: Fix NULL pointer dereference in
 vc4_plane_create_additional_planes
To: Henri Zikken <zikken@xs4all.nl>
Cc: Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, root <root@desktop-40rm2q1.localdomain>
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Henri

Sorry for the delay in replying.

On Fri, 3 Apr 2026 at 09:59, Henri Zikken <zikken@xs4all.nl> wrote:
>
> When a vc4 DRM device has no TXP (Writeback) CRTC, txp_crtc remains
> uninitialized after the drm_for_each_crtc loop. Subsequent calls to
> drm_crtc_mask(txp_crtc) then dereference a NULL pointer, causing a
> kernel panic.
>
> This was observed on Raspberry Pi Zero 2W with a DPI panel connected,
> where vc4_dpi_dev_probe triggers vc4_drm_bind which calls
> vc4_plane_create_additional_planes without a TXP being present.
>
> Fix by initializing txp_crtc to NULL and guarding all drm_crtc_mask()
> calls on txp_crtc with a NULL check.

Which tree have you created this patch against?

Creating a separate set of planes for the writeback connector is a
patch that I haven't upstreamed yet, so it only exists in our vendor
kernel[1].
This issue is already fixed on the rpi-6.18.y branch. It does exist on
earlier branches, but those are frozen for our ongoing development
efforts.

Then again if there is no transposer there is no point in creating the
additional planes at all. Creating them with a mask of 0 is a waste of
time.

  Dave

[1] https://github.com/raspberrypi/linux

> Fixes: (vc4_plane_create_additional_planes introduction)
> Signed-off-by: Henri Zikken<zikken@xs4all.nl>
> Signed-off-by: root <root@DESKTOP-40RM2Q1.localdomain>

Rogue Signed-off-by line.

> ---
>  drivers/gpu/drm/vc4/vc4_plane.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
> index fdd6ba310..c43c12c2c 100644
> --- a/drivers/gpu/drm/vc4/vc4_plane.c
> +++ b/drivers/gpu/drm/vc4/vc4_plane.c
> @@ -2665,7 +2665,7 @@ int vc4_plane_create_additional_planes(struct drm_device *drm)
>         struct drm_plane *cursor_plane;
>         struct drm_crtc *crtc;
>         unsigned int i;
> -       struct drm_crtc *txp_crtc;
> +       struct drm_crtc *txp_crtc = NULL;
>         uint32_t non_txp_crtc_mask;
>
>         drm_for_each_crtc(crtc, drm) {
> @@ -2678,7 +2678,7 @@ int vc4_plane_create_additional_planes(struct drm_device *drm)
>         }
>
>         non_txp_crtc_mask = GENMASK(drm->mode_config.num_crtc - 1, 0) -
> -                                       drm_crtc_mask(txp_crtc);
> +                                       (txp_crtc ? drm_crtc_mask(txp_crtc) : 0);
>
>         /* Set up some arbitrary number of planes.  We're not limited
>          * by a set number of physical registers, just the space in
> @@ -2707,7 +2707,7 @@ int vc4_plane_create_additional_planes(struct drm_device *drm)
>         for (i = 0; i < VC4_NUM_TXP_OVERLAY_PLANES; i++) {
>                 struct drm_plane *plane =
>                         vc4_plane_init(drm, DRM_PLANE_TYPE_OVERLAY,
> -                                      drm_crtc_mask(txp_crtc));
> +                                      (txp_crtc ? drm_crtc_mask(txp_crtc) : 0));
>
>                 if (IS_ERR(plane))
>                         continue;
> --
> 2.39.5
>

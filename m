Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961ADC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E9A10E31A;
	Mon,  6 Jul 2026 13:58:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ATEnK66w";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C30110E31A
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:58:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 721E2403BE;
 Mon,  6 Jul 2026 13:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410C51F000E9;
 Mon,  6 Jul 2026 13:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783346327;
 bh=SP+wWOAGtZB7XaItyWtUfFxA7/3HBbMcshqCZpbfGuk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ATEnK66weUuZY0JnLSxBnw1RCNll8TyalFIHn6yT0RvoX7RJBB7Tu6Kc5fwX7+I1g
 2Z2myVSB0m7EWBJGpwnfoXuxcuIw1A+4Bne1RGXJ7J+2g8oJ5Y5M8p3gPMzAkb/l7+
 1ncga5StezPKVGrQ/q2uyaZMXSI2hO9v+01P1QTcJ/oJ5s9IcVxnO6xGpVZfJEtuWA
 rq8wzh1P7AlhJelq4y6R1+440eFgvthmbVsKK+ZLwnJu+3BmvCC0kossSd1DIZmFEP
 zOZ3LEhGab53I/JWmgD5HG32mrdXvTk/jBrtdLj03A/MULnW52LlizwxUCSsmG/fzP
 oofM/r7IZ+LDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] gpu/drm: Add drm_notice logging when
 drm_mode_create fails
To: "Jan Niedziolka" <j.niedziolka@samsung.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706134515.3369960-4-j.niedziolka@samsung.com>
References: <20260706134515.3369960-1-j.niedziolka@samsung.com>
 <CGME20260706134551eucas1p15c82b3c36b5644c1111663938c1dc881@eucas1p1.samsung.com>
 <20260706134515.3369960-4-j.niedziolka@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 13:58:46 +0000
Message-Id: <20260706135847.410C51F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Redundant custom OOM logging
- [Low] Incomplete implementation of mode creation failure logging
--

commit 918b658b4d8223239a11b91ab8f874692e392821
Author: Jan Niedziolka <j.niedziolka@samsung.com>

gpu/drm: Add drm_notice logging when drm_mode_create fails

This commit adds drm_notice() prints to drm_cvt_mode(), drm_gtf_mode_comple=
x(),
and drm_mode_duplicate() to log when drm_mode_create() fails and returns NU=
LL.

> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index 049d77e75ddda..fc6d974e3948d 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -646,8 +646,10 @@ struct drm_display_mode *drm_cvt_mode(struct drm_dev=
ice *dev, int hdisplay,
>  	 * return directly
>  	 */
>  	drm_mode =3D drm_mode_create();
> -	if (!drm_mode)
> +	if (!drm_mode) {
> +		drm_notice(dev, "Failed to create a new display mode\n");
>  		return NULL;
> +	}

[Severity: Low]
Is this custom error logging redundant?

Since drm_mode_create() relies on memory allocation (via kzalloc_obj()), the
kernel's memory allocation subsystem will already report OOM conditions wit=
h a
backtrace. Adding custom error messages for memory allocation failures
can cause unnecessary kernel binary bloat and log spam.

[Severity: Low]
If the intent is to log mode creation failures consistently, did this miss
drm_analog_tv_mode()?

It takes a dev parameter and calls drm_mode_create() in the same file, but
was not updated by this patch:

drivers/gpu/drm/drm_modes.c:drm_analog_tv_mode() {
        ...
        mode =3D drm_mode_create();
        if (!mode)
                return NULL;
        ...
}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706134515.3369=
960-1-j.niedziolka@samsung.com?part=3D3

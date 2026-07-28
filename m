Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943B7C53209
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 00:47:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1AA910E44D;
	Tue, 28 Jul 2026 00:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dqv9bU1J";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 106EB10E44D
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 00:47:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3B3EC600FC;
 Tue, 28 Jul 2026 00:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9C51F000E9;
 Tue, 28 Jul 2026 00:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785199648;
 bh=QYR8/hE/kTCOkkFQIQeyNsNeqvjRLGHzklCsPTWGUs4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Dqv9bU1J6lpj4PdcH+Qco0pOHsLuC1DwPNfG3a9FRMUGFOUGeOh9HcVrBy5RYoDYm
 54MSzMGhdXEG6maJ/v1twsdkVbxqmYKhOAYbw4ZzPdHPRif0pF700qaHqF7lFaRnw8
 RKGK997/vozJGK7ixjE6Zu2fm32LUUKQb4T9+TZXbfpoBo9VbJzvXY00OEFlBdDzAD
 ZkGG1e/4LqdYITJcl5QvJeSimO6+EKDxzM/KfgJsVNZgnPUy2r+srAMKdxLUR99Yuw
 Nz0Co79WmQsiyVwOVeZLKagqpkmfVIWv5Zf4WnLWn7y2yI4DA3HDMb2THQbdiiybjx
 NFWfHwfyiXQ4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panel: chipwealth-ch13726a: Fix washed out colors
 on 120hz mode
To: "Aaron Kling" <webgeek1234@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260727-ch13726a-washout-v1-1-bf869ddfc5cf@gmail.com>
References: <20260727-ch13726a-washout-v1-1-bf869ddfc5cf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 00:47:28 +0000
Message-Id: <20260728004728.AC9C51F000E9@smtp.kernel.org>
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
- [High] The newly introduced horizontal display timings for the 120Hz mode=
 are mathematically incorrect, resulting in `hsync_end` being smaller than =
`hsync_start`, and an `htotal` value that doesn't match the `.clock` multip=
lier.
--

--- Patch [1]: [PATCH] drm/panel: chipwealth-ch13726a: Fix washed out color=
s on 120hz mode ---
commit 87afbda6cc13589f090573e5294d277fb599926d
Author: Aaron Kling <webgeek1234@gmail.com>

drm/panel: chipwealth-ch13726a: Fix washed out colors on 120hz mode

This commit attempts to fix a washed out color issue at 120Hz by adjusting
the horizontal display timings and enabling continuous clock and burst mode
to stabilize blank intervals.

> diff --git a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c b/drivers/=
gpu/drm/panel/panel-chipwealth-ch13726a.c
> --- a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
> +++ b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
> @@ -128,11 +128,11 @@ static int ch13726a_unprepare(struct drm_panel *pan=
el)
>  static const struct drm_display_mode thor_bottom_modes[] =3D {
>  	{
>  		/* 120Hz */
> -		.clock =3D (1080 + 28 + 4 + 36) * (1240 + 16 + 4 + 8) * 120 / 1000,
> +		.clock =3D (1080 + 60 + 8 + 60) * (1240 + 16 + 4 + 8) * 120 / 1000,
>  		.hdisplay =3D 1080,
> -		.hsync_start =3D 1080 + 28,
> -		.hsync_end =3D 1080 + 28 + 4,
> -		.htotal =3D 1080 + 28 + 4 + 36,
> +		.hsync_start =3D 1080 + 60,
> +		.hsync_end =3D 1080 + 28 + 8,
> +		.htotal =3D 1080 + 28 + 4 + 60,

[Severity: High]
Will this cause the hsync_end value to be smaller than the hsync_start valu=
e?

In the updated 120Hz mode timings, hsync_start evaluates to 1140 (1080 + 60=
),
while hsync_end evaluates to 1116 (1080 + 28 + 8). If hsync_end is smaller
than hsync_start, the DRM core's basic validation checks in
drm_mode_validate_basic() will likely mark the mode as MODE_H_ILLEGAL and
prune it, making the 120Hz mode unavailable.

Additionally, htotal evaluates to 1172 (1080 + 28 + 4 + 60), but the .clock
calculation uses a horizontal multiplier of 1208 (1080 + 60 + 8 + 60). Shou=
ld
htotal match the multiplier used in the clock calculation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-ch13726a-w=
ashout-v1-1-bf869ddfc5cf@gmail.com?part=3D1

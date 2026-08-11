Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8BCC5CFC1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AAF910EDBE;
	Tue, 11 Aug 2026 21:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YL10zsoh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D560E10EDBE
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:57:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 41EB360A85;
 Tue, 11 Aug 2026 21:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9831F000E9;
 Tue, 11 Aug 2026 21:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786485436;
 bh=HxBqsb6Oa4VEe++gFC0lyJ4DIZFuZ2SX/3U+qHhdzno=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YL10zsohgtpm8TI3pyCd3gO3/HtA9693JzMkJKd0EQxnrHa0jW5aBUQP1fb0fW6yU
 gyeJqBk0ReeHWydVLmcPNvbfwBekOLTW0AFoWhJ8zIf+KKS2rdPHJ5lyNhFhB/Pih6
 PuN2LKgrzT0RyDKEwg+/UyeUKANAYhA0PfOR2Pzw1JcLginjS/hz+xKLOWpvi2Q7A8
 S4cCAmCBbHcUcTtnVYUJgkD4ntdg4JTodIEsFNHWi59YyagrT8L6hhQI2KWMKubec3
 77tOnKbi88m4GS4BSlNICF8scU6wHv8LP+h9HdLJV+L7vUx6QnxLSXs3wUUqXHSMcv
 d5Un+eH1Ukblw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/11] drm/panfrost: Prevent division by 0
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260811-claude-fixes-v5-2-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
 <20260811-claude-fixes-v5-2-3d692c9e98c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 21:57:15 +0000
Message-Id: <20260811215715.BF9831F000E9@smtp.kernel.org>
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
- [Medium] Multiplying `status->busy_time` by 100 introduces a 32-bit integ=
er overflow on 32-bit architectures, resulting in wildly incorrect GPU load=
 percentages in the debug log.
- [Low] The use of the type-unsafe `MAX()` macro violates kernel coding sty=
le guidelines.
--

--- Patch [2]: [PATCH v5 02/11] drm/panfrost: Prevent division by 0 ---
commit 40a64804964495fc5a5f268bdf1f61ec7215f8a4
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Prevent division by 0

This commit attempts to fix a potential division by zero when calculating t=
he
GPU load percentage for debug logging by rearranging the operands. It chang=
es
the calculation to multiply busy_time by 100 before dividing, and uses MAX()
to ensure the divisor is at least 1.

Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88

> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/dr=
m/panfrost/panfrost_devfreq.c
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -78,7 +78,7 @@ static int panfrost_devfreq_get_dev_status(struct devic=
e *dev,
> =20
>  	dev_dbg(pfdev->base.dev, "busy %lu total %lu %lu %% freq %lu MHz\n",
>  		status->busy_time, status->total_time,
> -		status->busy_time / (status->total_time / 100),
> +		status->busy_time * 100 / MAX(status->total_time, 1),

[Severity: Medium]
Does this calculation introduce a 32-bit integer overflow on 32-bit platfor=
ms
like ARMv7?

The fields busy_time and total_time in struct devfreq_dev_status are of type
unsigned long. On 32-bit architectures, unsigned long is 32 bits, with a
maximum value of 4,294,967,295.

Since time is measured in nanoseconds and the devfreq polling interval is
typically 50ms, a fully loaded GPU will have a busy_time close to 50,000,00=
0 ns.

Multiplying this by 100 yields 5,000,000,000, which overflows the 32-bit
unsigned integer and wraps around to ~705 million. This results in the debug
log incorrectly reporting a ~14% load instead of 100% when the GPU is fully
utilized.

[Severity: Low]
This isn't a bug introduced by this patch, but does the use of MAX() here
bypass strict kernel type-checking mechanisms?

The MAX() macro defined in linux/minmax.h is explicitly documented with a
warning to use it carefully for obvious constants only, as it performs no t=
ype
checking and uses the arguments multiple times.

While this specific instance does not cause a runtime bug, using the type-s=
afe
max(status->total_time, 1UL) or max_t(unsigned long, status->total_time, 1)
might be a better fit for standard kernel coding style guidelines.

>  		status->current_frequency / 1000 / 1000);
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811-claude-fix=
es-v5-0-3d692c9e98c2@collabora.com?part=3D2
